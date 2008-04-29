From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG] git svn accepts to clone an empty SVN repo, but then fails to dcommit
Date: Tue, 29 Apr 2008 00:15:52 -0700
Message-ID: <20080429071552.GH24171@muzzle>
References: <vpq3apbm8k3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:16:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqk4w-00086S-7G
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbYD2HPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYD2HPy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:15:54 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53680 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbYD2HPx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:15:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id F098A2DC08C;
	Tue, 29 Apr 2008 00:15:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpq3apbm8k3.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80662>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Hi,
> 
> All is in the title ;-).
> 
> The command
> 
>   git svn clone (URL of an empty SVN repo here)
> 
> works, creates an empty git repository. I can perform the initial
> commit there, but then, "git svn dcommit" says :
> 
> Use of uninitialized value in concatenation (.) or string at /home/moy/local/usr/bin/git-svn line 414.
> Committing to  ...
> Unable to determine upstream SVN information from HEAD history
> 
> I guess a correct management of the initial commit in git-svn would be
> hard to implement, but at least, the error message can be improved.
> First step is something like the patch below, and better would be for
> "git svn clone" to warn that it won't be able to do much with the
> cloned repo.

Thanks Matthieu,

It shouldn't be *that* hard to implement being able to start an empty
SVN repository from scratch, actually.  Of course, there are about
a billion other things people have been asking for in git-svn that I
keep forgetting to implement.

Acked-by: Eric Wong <normalperson@yhbt.net>

> diff --git a/git-svn.perl b/git-svn.perl
> index b864b54..9a70c1e 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -410,10 +410,12 @@ sub cmd_dcommit {
>         $head ||= 'HEAD';
>         my @refs;
>         my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
> -       print "Committing to $url ...\n";
> +       if ($url) {
> +               print "Committing to $url ...\n";
> +       }
>         unless ($gs) {
>                 die "Unable to determine upstream SVN information from ",
> -                   "$head history\n";
> +                   "$head history.\nPerhaps the repository is empty.";
>         }
>         my $last_rev;
>         my ($linear_refs, $parents) = linearize_history($gs, \@refs);
> 
-- 
Eric Wong
