From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] contrib/git-svn: fix UUID reading w/pre-1.2 svn; fetch args
Date: Thu, 09 Mar 2006 02:08:38 -0800
Message-ID: <7vacc07wwp.fsf@assigned-by-dhcp.cox.net>
References: <20060307220837.GB27397@nowhere.earth>
	<20060308014207.GA31137@localdomain>
	<20060308015730.GA28056@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 11:08:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHI4Z-0004XA-Ri
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 11:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWCIKIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 05:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWCIKIl
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 05:08:41 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38274 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751330AbWCIKIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 05:08:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309100723.OZBG3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 05:07:23 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060308015730.GA28056@localdomain> (Eric Wong's message of
	"Tue, 7 Mar 2006 17:57:30 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17401>

Eric Wong <normalperson@yhbt.net> writes:

> Junio: please don't apply this patch to git.git just yet.  It seems fine
> to me, but I haven't tested it heavily yet (Yann can help me, I hope :)
> I hardly slept the past few days and I may have broken something badly
> (it pasts all the tests, though).

I won't be applying it then.

I think this part is wrong.

> @@ -922,7 +930,9 @@ sub git_commit {
>  	}
>  	my @update_ref = ('git-update-ref',"refs/remotes/$GIT_SVN",$commit);
>  	if (my $primary_parent = shift @exec_parents) {
> -		push @update_ref, $primary_parent;
> +		if (!system('git-rev-parse',"refs/remotes/$GIT_SVN")){
> +			push @update_ref, $primary_parent;
> +		}

I think you are trying to see if you have .git/refs/remotes/foo,
and I think you actually have tried it to determine that is the
case.

But "git-rev-parse refs/remotes/foo" dies not because there is
no valid file .git/refs/remotes/foo that records SHA1 of an
existing commit.  If there is refs/remotes/foo file, it thinks
you have asked for it and gives it back happily.

A demonstration:

	$ cd /var/tmp/ && rm -fr junk && mkdir junk && cd junk
        $ git init-db
	defaulting to local storage area
        $ git-rev-parse refs/remotes/foo ; echo $?
        refs/remotes/foo
        fatal: 'refs/remotes/foo': No such file or directory
        128
        $ mkdir -p refs/remotes/foo
        $ ls -a
        ./  ../  .git/	refs/
        $ git-rev-parse refs/remotes/foo; echo $?
        refs/remotes/foo
        0

If you are trying to see if there is such a ref, I would do
this:

	$ git-rev-parse --verify refs/remotes/foo^0
        git-rev-parse --verify refs/remotes/foo^0
        fatal: Needed a single revision
	128

The --verify flag makes sure that the argument resolves to a
valid 40-hexadigit string (note that it does not verify if that
object actually exists), so asking for zeroth parent makes sure
you are dealing with a ref that actually points at a commit
object that exists.
