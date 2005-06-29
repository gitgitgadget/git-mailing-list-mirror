From: Junio C Hamano <junkio@cox.net>
Subject: Last mile for 1.0 again
Date: Wed, 29 Jun 2005 00:16:10 -0700
Message-ID: <7v4qbhfxad.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050624.212009.92584730.davem@davemloft.net>
	<42BCE026.8050405@pobox.com>
	<Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
	<42BCF02B.5090706@pobox.com>
	<Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
	<Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506281351150.1667@localhost.localdomain>
	<Pine.LNX.4.58.0506281201510.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506281655140.1667@localhost.localdomain>
	<Pine.LNX.4.58.0506281424420.19755@ppc970.osdl.org>
	<Pine.LNX.4.63.0506282314320.1667@localhost.localdomain>
	<Pine.LNX.4.63.0506290111250.1667@localhost.localdomain>
	<Pine.LNX.4.58.0506282243180.19755@ppc970.osdl.org>
	<Pine.LNX.4.58.0506282252001.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 29 09:13:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnWkp-0003PZ-TB
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 09:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVF2HUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 03:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVF2HTd
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 03:19:33 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:64427 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262464AbVF2HQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 03:16:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050629071611.OGZV23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Jun 2005 03:16:11 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0506282252001.14331@ppc970.osdl.org> (Linus Torvalds's message of "Tue, 28 Jun 2005 22:54:26 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> ..., but please don't 
LT> change that, since that would be yet another incompatible pack format 
LT> change, and I'd like to calm things down.

Calming things down is good.  Some stuff we should be looking at
during calming down period are:

 - Ask expert help to verify our use of zlib is OK; Linus asked
   for this in a message tonight.  I am not qualified to do this
   myself.

 - There is currently nothing that verifies the SHA1 sums
   embedded in idx and pack files.  A tool for it is needed
   [*1*].  I may be doing this myself.

 - Although there is a hook in sha1_file() that allows mapping a
   pack file on demand (and keep track of their uses for LRU
   eviction), there is currently no code to actually evict a
   mapped pack file.  We need to add some sort of use-reference
   counting to lock down a pack file in use, if somebody is
   inclined to do this.  I will not be doing this myself
   immediately.

 - Think about what to do with the "dumb server" pull protocols
   regarding packed archive files (think about http-pull).  I
   will not be doing this myself.

 - Design "smart server" pull/push pair.  This can independently
   and actively be done without impacting "calming down" period,
   and I am assuming Dan is already looking into this.  This may
   result in another "deathmatch" between Dan and Jason
   Mcmullan, which would be fun to watch ;-).


Not limited to "calming down the packed GIT", but bigger picture
pre-release preparation items I think we need to look into are:

 - Update "Last mile for 1.0" list.  I think the only thing that
   is left from the one I posted on Jun 5th is the tutorials.

   Anybody interested in adding more pages to the tutorials?  If
   there is no taker, I may start continuing what is already
   there, stealing example project outline from "Arch meets
   Hello World" [*2*].

 - Double check the documentation, usage strings in the code and
   what the code does still match.  Last time I checked, I think
   some files in Documentation/ directory were not reachable
   from the main GIT(1) page and were not touched by the build
   process from Documentation/Makefile.  I will not be doing
   this myself.

 - Blame/Annotate.  Does anybody have a fast and correct one
   [*3*]?

 - Publicity.  Somebody may want to start preparing materials to
   have us included in http://better-scm.berlios.de/comparison/


[Footnotes]

*1* One possibility is to add that to fsck-cache when --full is
used, but I am somewhat reluctant to do it that way.  It would
require you to place that "suspicious" pack under your
repository's .git/objects/pack in order to verify it, which can
spread the damage before you know it.

In general, idx file is relatively small, so we _could_ check
the SHA1 sum for idx files when we map them at runtime in
check_packed_git_idx().  However, verifying 1MB (kernel archive
case) idx file every time we run a single core GIT command may
be a price we would not want to pay, so I am not too
enthusiastic about doing it.  We certainly would not want to do
this for pack files every time a pack is mapped at runtime (60MB
kernel archive case).

*2* http://regexps.srparish.net/www/tutorial/html/arch.html.

I am not talking about stealing the concepts but just talking
about stealing the sample project on which example players work
in the sample sessions.  I think its section on update/replay
matches closely to merge/rebase, for example.

*3* I have what I wrote in Perl which does rename/copy/rewrite
and multiple parents correctly, but it is way too slow for
on-demand use.
