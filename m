From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tracking branch history
Date: Sun, 14 May 2006 23:27:53 -0700
Message-ID: <7vac9jx0nq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org>
	<20060513034051.GA21586@spearce.org>
	<7vody2v7yr.fsf@assigned-by-dhcp.cox.net>
	<20060513071753.GA21998@spearce.org>
	<20060513074328.GB21998@spearce.org>
	<Pine.LNX.4.64.0605130815550.3866@g5.osdl.org>
	<7vbqu1vps3.fsf@assigned-by-dhcp.cox.net>
	<20060513181816.GA12475@spearce.org>
	<7vk68o19n4.fsf@assigned-by-dhcp.cox.net>
	<20060515031511.GA27505@spearce.org>
	<20060515055830.GC28068@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 08:28:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfWYg-00080R-M5
	for gcvg-git@gmane.org; Mon, 15 May 2006 08:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWEOG1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 02:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWEOG1z
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 02:27:55 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:2999 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932317AbWEOG1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 02:27:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515062754.JRGC19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 02:27:54 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060515055830.GC28068@spearce.org> (Shawn Pearce's message of
	"Mon, 15 May 2006 01:58:30 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20027>

Shawn Pearce <spearce@spearce.org> writes:

> This is all well and good but its sort of useless without the diffcore
> being able to lookup what SHA1 was valid on a given branch at a given
> point in time.  :-)
>
> I'm thinking about extending the 'extended SHA1' syntax to accept
> a date (or date expression) as a suffix:
>
> 	HEAD@'2 hours ago'
> 	HEAD@'2006-04-20'
> 	HEAD@'2006-04-20 14:12'
>
> etc... This would be merged into get_sha1 (sha1_name.c) so its
> usable pretty much anywhere.  Does this seem reasonable?  If so
> I'll work up a patch for it.

HEAD?

Are you going to hook into symbolic-ref as well to track branch
switching?

Since there is no reverse pointer to tell which symbolic
reference is pointing at branch heads,and there are symbolic
references like refs/remotes/origin/HEAD that point at
refs/remotes/origin/master, detecting that such and such
symbolic refs are pointing at a branch that is advanced by a
call to update-ref and update the log for the symbolic refs that
point at it becomes rather expensive.
So probably you would need a separate log format that tracks
which concrete ref a symbolic ref was pointing at at any given
time and use that to keep track of them.

I personally doubt it is worth the trouble.  I switch branches
between master, next and the topics all the time, and never is
interested in which branch I happened to be on 30 minutes ago.

The time-warp format would make sense for individual branches,
like refs/heads/master, though.

sha1_name.c and sha1_file.c were supposed to be real core, but
get_sha1() is looking more and more Porcelainish these days, and
I do not have much problem with being able to say "tip of this
branch, two hours ago".

I am not sure about the syntax though.  We would want to be able
to say "start from the commit that was at the tip of 'master'
branch two days ago, grab its tree and look at arch/sparc64
directory", so things like

            "master@2006-05-14 14:12"
            "master@2006-05-14 14:12^{tree}"
            "master@two days ago:arch/sparc64"

would need to be supported.
