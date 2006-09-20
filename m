From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 10:13:04 -0700
Message-ID: <7vac4uihr3.fsf@assigned-by-dhcp.cox.net>
References: <20060919232851.GA12195@spearce.org>
	<7vac4ujzf0.fsf@assigned-by-dhcp.cox.net>
	<20060920161407.GQ8259@pasky.or.cz>
	<20060920162145.GA23260@spearce.org>
	<7v1wq6jy3q.fsf@assigned-by-dhcp.cox.net>
	<20060920164912.GD23260@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 20 19:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5dZ-0000z0-60
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 19:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWITRNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 13:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWITRNI
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 13:13:08 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61158 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932068AbWITRNG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 13:13:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920171305.MPOB12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 13:13:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QhCr1V0031kojtg0000000
	Wed, 20 Sep 2006 13:12:51 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920164912.GD23260@spearce.org> (Shawn Pearce's message of
	"Wed, 20 Sep 2006 12:49:12 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27382>

Shawn Pearce <spearce@spearce.org> writes:

> I started this change with '--all' and realized that ideally you
> want '--all' to copy all available refs/heads/* from the remote to
> refs/remotes/<name>/* here.  You want to create any new branches
> which the remote has introduced since your last fetch.
>
> You probably don't want to force a non-fast forward unless there's a
> '+' in the corresponding Pull line of remotes/<name> or if --force is
> used.  However you probably also want to delete any removed branches.

I think we are in agreement here.

> Which I think is quite different from a mirror.  A mirror wants to
> replace the entire ref namespace with what's on the remote as it
> has no need for a local namespace of its own.

If you have remotes/origin that does not use the refs/remotes
hierarchy, does not copy master->origin (iow, the assumption
that "origin" branch is to be merged into local "master") but
copies remote master to local master, and forces all refs by
default, then your local ref namespace is effectively a mirror
of the remote, so it is very tempting to think --mirror is a
logical extension of "fetch --all".

Except that new refs are not created and old refs are not
deleted.  And these two are rather big exceptions.

If we are to have another command (git-mirror which is a thin
wrapper around git-fetch as you propose later), these two
exceptions would be cleanly handled there.  Otherwise, we would
need to give the command a hint (git-mirror.permitted) to allow
them to be done in addition to the usual "fetch --all", but then
we would end up doing the equivalent of your one-liner anyway,
so there is not much point having it in git-fetch.  So I am in
favor of your thin-wrapper idea.

> Originally I gave Pasky a one-liner on #git:
>
>   git fetch --force origin $(git ls-remote origin \
>       | awk '{if(!/\^{}$/){print $2":"$2}}')

Which sounds a very sane thing to do, especially given git is
designed to be scripted this way.

> And I think this mirror thing may make more sense as a small wrapper
> around git-fetch.  A wrapper that checks for:
>
> 	- its running in a bare repository;

Ok.

> 	- it has a single remote named origin;

Do you mean ".git/remotes must have only one file 'origin' and
nothing else", or do you mean "There must be .git/remotes/foobla
for 'git-mirror foobla' to work"?

> 	- HEAD isn't a symlink or a symref (its a normal ref in its
> 	  own right);

Why?  Usually HEAD is a pointer to the active branch.  I
consider it is a bug in the upload-pack protocol not to convey
that information (but that is a separate topic).

> 	- git-mirror.permitted is true in the config file.

Ok.
