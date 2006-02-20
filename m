From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Mon, 20 Feb 2006 14:54:15 -0800
Message-ID: <7virr98wvc.fsf@assigned-by-dhcp.cox.net>
References: <11404323692193-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 23:54:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBJvX-0007Vt-Qp
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 23:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWBTWyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 17:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWBTWyS
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 17:54:18 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:1452 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1161051AbWBTWyR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 17:54:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220225252.TFY20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 17:52:52 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11404323692193-git-send-email-ryan@michonline.com> (Ryan
	Anderson's message of "Mon, 20 Feb 2006 05:46:09 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16508>

Ryan Anderson <ryan@michonline.com> writes:

> I would appreciate some other testing on this, as I can't find a case
> where it falls down, but the files with a lot of history tend to have a
> lot of lines, making them hard to spotcheck without having been an
> intimate part of that history.

I looked at a couple of files, including pack-objects.c,
rev-list.c (in "pu"), and svnimport.perl; what I saw made sense.
I think however we would want to check things with a lot of
merges, so git repository may not be a good guinea pig.

> Oh, this is the "functional" version, but it might not qualify as "nice
> looking" yet, pleaes, feel free to complain.

Nice.

Two design glitches and an implementation:

 - You seem to rely on the working tree file to be clean relative to
   HEAD.

 - You do not take anything other than HEAD as the starting point.

Maybe an additional -r<this-version> option which defaults to
HEAD, plus reading the blob always from that tree as the
starting point would be helpful.

> +	open(P,"-|","git-rev-list","--parents","--remove-empty",$rev,"--",$file)

Johannes noticed I slipped this form which Perl 5.6 does not
grok in another program.  Eric pointed out he uses a backward
compatible idiom in his code.

We would need to make this one safe; something like this, perhaps:

	sub open_read_pipe {
        	my ($fh, @cmd) = @_;
                my $pid = open($fh, '-|');
		die "$!" unless defined($pid);
		if (!$pid) {
			exec(@cmd) or die "$!";
		}
		return $fh;
	}
	...
        open_read_pipe(\*P, qw(git-rev-list --parents --remove-empty),
			$rev, '--', $file);


> +	open(P,"-|","git-diff-tree", "-M50", "-r","--name-status", "-z","$rev")
> +		or die "Failed to exec git-diff: $!";

If you do not mean "I want -M50" but you meant "I want whatever
is default", I'd leave that 50 out.

It is probably premature to talk about issues for UI that can be
built on top of this, but what I found interesting was this.
While looking at the annotate output, whenever I got curious
about one line ("Oh, this is an ancient change and by somebody
who does not feed patches to git regularly -- what was the
change about???"), I grabbed the SHA1 of the commit on the line
and threw it at "git show".  It was a good way to see how the
change to the line was done in context.  Maybe a two-pane UI
that shows annotate on the top pane, and activating one line
from it shows "git show" output on the bottom pane to show the
commit log plus changes the commit introduced to the file and
other files.
