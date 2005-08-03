From: Junio C Hamano <junkio@cox.net>
Subject: Re: Users of git-check-files?
Date: Wed, 03 Aug 2005 11:07:30 -0700
Message-ID: <7vy87ic2sd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508021942500.3341@g5.osdl.org>
	<7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030808530.3341@g5.osdl.org>
	<7vr7dbhvci.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030913060.3341@g5.osdl.org>
	<7vk6j3f044.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
	<7voe8fdkd7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508031014070.3258@g5.osdl.org>
	<7virymdirb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508031048360.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 03 20:09:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Nf5-0005Rj-V8
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 20:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVHCSIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 14:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVHCSIF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 14:08:05 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:62450 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262383AbVHCSHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 14:07:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803180732.RUSU3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 14:07:32 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508031048360.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 10:48:49 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch seems to fix the problem.

 * If the original value of remote ref refers to an object we do
   not have, and if the ref is one of the branches we are trying
   to push, we refuse to update it.

 * Otherwise, we do not attempt to use such an value when
   computing what objects to put in pack, since rev-list would
   fail.

I've tested Josef's two-branches case, one repo updates one
branch and pushes to the central repo, another repo updates the
other branch and pushed to the central repo.  The old code
barfed when invoking rev-list, but this does not seem to.

Josef, could you give it a try please?

---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - master: git-send-email-script: minimum whitespace cleanup.
# + (working tree)
diff --git a/send-pack.c b/send-pack.c
--- a/send-pack.c
+++ b/send-pack.c
@@ -43,7 +43,8 @@ static void exec_rev_list(struct ref *re
 		char *buf = malloc(100);
 		if (i > 900)
 			die("git-rev-list environment overflow");
-		if (!is_zero_sha1(refs->old_sha1)) {
+		if (!is_zero_sha1(refs->old_sha1) &&
+		    has_sha1_file(refs->old_sha1)) {
 			args[i++] = buf;
 			snprintf(buf, 50, "^%s", sha1_to_hex(refs->old_sha1));
 			buf += 50;
@@ -208,6 +209,12 @@ static int send_pack(int in, int out, in
 			continue;
 		}
 
+		if (!has_sha1_file(ref->old_sha1)) {
+			error("remote '%s' object %s does not exist on local",
+			      name, sha1_to_hex(ref->old_sha1));
+			continue;
+		}
+
 		/* Ok, mark it for update */
 		memcpy(ref->new_sha1, new_sha1, 20);
 	}

Compilation finished at Wed Aug  3 11:02:15
