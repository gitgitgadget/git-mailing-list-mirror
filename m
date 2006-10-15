From: Junio C Hamano <junkio@cox.net>
Subject: Recent and near future backward incompatibilities
Date: Sat, 14 Oct 2006 23:29:17 -0700
Message-ID: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Stephen Hemminger <shemminger@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 08:29:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYzV8-0002A0-BZ
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 08:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbWJOG3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 02:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbWJOG3T
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 02:29:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31386 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1752494AbWJOG3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 02:29:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061015062918.EABX22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Oct 2006 02:29:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id aWV51V00J1kojtg0000000
	Sun, 15 Oct 2006 02:29:06 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28906>

It was brought to my attention that the public git.git
repository cannot be cloned with older versions of git.  More
precisely, packs generated with post 16854571 (NOT contained in
v1.4.2.3 but in the current "master" and more importantly in
v1.4.3-rc3 which I tagged tonight) can contain deltas that are
not compatible with the version of git before d60fc1c8, which
means that v1.1.6 and older (v1.2.0 and later are Ok).

The older version of git did not know anything about version 3
delta (which can express larger copies from source when
computing a delta) before d60fc1c8, and barfs if it is fed a
pack that contains such a delta.  We have generated only version
2 delta for quite a while until very recently post v1.4.2.3.

The thing is, I made a mistake to repack my public repository
with more recent git (I work with "next" usually, and with
"master" after we go into -rcX cycle to prepare for the
release).  Although the version of git that kernel.org runs is
still v1.4.2.3 which means its pack-objects does not produce
version 3 delta by itself, the problem is that the delta reuse
logic happily copies out whatever delta is in existing packs.

I already repacked the public repository with an older git,
v1.4.2.3, using 'git-repack -a -d -f' to fix this problem.

One thing we can and should immediately do is to revert 16854571
for now until we decide how to resolve this issue cleanly.

These are what needs to happen but one of them is quite tricky:

 - the reusing of delta is what makes pack-objects practical,
   and it is expensive to look into existing delta to see if it
   is version 2 or version 3 before deciding to reuse each delta
   data, so even if we update pack-objects so that we can tell
   it to generate a pack that contains only version 2 deltas, it
   would be very expensive to do so and may not be practical.  I
   am not sure how to resolve this issue efficiently right now;
   we need a bit of thinking.

 - so instead we could just say a public repository that needs
   to interoperate with older clients should not keep packs with
   version 3 delta, at least for now.  deltifying from loose
   objects are done afresh every time pack-objects is run, and
   it is easier to control.

 - git-pack-objects needs to be updated so that we can control
   whether we generate version 2 or version 3 delta.

 - we need to add .git/config item that tells pack-objects to
   never generate version 3 delta for that particular
   repository.  This is similar to the way we would need to
   control the use of delta-base-offset representation currently
   cooking in "next".

 - the on-the-wire protocol between fetch-pack and upload-pack
   needs to be updated so that the server side can tell if the
   client side is prepared to handle version 3 delta in the
   pack, and this needs to be passed to pack-objects to control
   its operation.  This part I can see how to fix.

We may have a similar issue when enabling generation of loose
objects with new style headers.  This is already controlled with
the core.legacyheaders configuration item.
