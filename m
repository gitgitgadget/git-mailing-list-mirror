From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] diff: further cleanup.
Date: Mon, 30 May 2005 00:07:39 -0700
Message-ID: <7vacmd8a4k.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
	<7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
	<7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net>
	<7vekbp8ajm.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 09:06:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DceL6-0000mK-VB
	for gcvg-git@gmane.org; Mon, 30 May 2005 09:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVE3HHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 03:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVE3HHt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 03:07:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63410 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261530AbVE3HHl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 03:07:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530070739.PEFT8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 03:07:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekbp8ajm.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 23:58:37 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When preparing data to feed the external diff, we should give
the mode we obtained from the caller, even when we are dealing
with a file with 0{40} SHA1 (i.e. the caller said "look at the
filesystem"), since the mode passed by the caller via
diff_addremove() or diff_change() is always trustworthy.

This is _not_ a bugfix --- the existing code stat() on the file
ifself and does the same computation on st.st_mode to compute
the mode the same way the caller did to give the original mode.
We cannot remove the stat() call from here, but the extra
computation to create the mode value is unnecessary.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 diff.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

9c88ea020142346a56e36cea87e349814675f3f5 (from f96e0e2250f29f5ba2ae06c6b401a83fa1b828b4)
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -421,8 +421,13 @@ static void prepare_temp_file(const char
 				strcpy(temp->hex, sha1_to_hex(null_sha1));
 			else
 				strcpy(temp->hex, sha1_to_hex(one->sha1));
-			sprintf(temp->mode, "%06o",
-				S_IFREG |ce_permissions(st.st_mode));
+			/* Even though we may sometimes borrow the
+			 * contents from the work tree, we always want
+			 * one->mode.  mode is trustworthy even when
+			 * !(one->sha1_valid), as long as
+			 * DIFF_FILE_VALID(one).
+			 */
+			sprintf(temp->mode, "%06o", one->mode);
 		}
 		return;
 	}

