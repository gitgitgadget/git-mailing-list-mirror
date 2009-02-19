From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/4] format-patch: thread as reply to cover letter even with in-reply-to
Date: Thu, 19 Feb 2009 22:26:32 +0100
Message-ID: <27f6b112941593e8ad92298814645b97a3e20fe2.1235078708.git.trast@student.ethz.ch>
References: <200902170027.09406.trast@student.ethz.ch> <cover.1235078708.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 22:28:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaGRl-0002Ns-Qa
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 22:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbZBSV0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 16:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756271AbZBSV0w
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 16:26:52 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21625 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756134AbZBSV0u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 16:26:50 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 22:26:43 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 22:26:42 +0100
X-Mailer: git-send-email 1.6.2.rc1.295.g1e29
In-Reply-To: <cover.1235078708.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 21:26:42.0795 (UTC) FILETIME=[C258A3B0:01C992D8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110759>

Currently, format-patch --thread --cover-letter --in-reply-to $parent
makes all mails, including the cover letter, a reply to $parent.
However, we would want the reader to consider the cover letter above
all the patches.

This changes the semantics so that only the cover letter is a reply to
$parent, while all the patches are formatted as replies to the cover
letter.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin-log.c           |   20 +++++++++++++++-----
 t/t4014-format-patch.sh |    9 ++++++---
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index b188575..89bfa70 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1036,12 +1036,22 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			/* Have we already had a message ID? */
 			if (rev.message_id) {
 				/*
-				 * If we've got the ID to be a reply
-				 * to, discard the current ID;
-				 * otherwise, make everything a reply
-				 * to that.
+				 * Without --cover-letter and
+				 * --in-reply-to, make every mail a
+				 * reply to the one before.
+				 *
+				 * With --in-reply-to but no
+				 * --cover-letter, make every mail a
+				 * reply to the <reply-to>.
+				 *
+				 * With --cover-letter, make every
+				 * mail but the cover letter a reply
+				 * to the cover letter.  The cover
+				 * letter is a reply to the
+				 * --in-reply-to, if specified.
 				 */
-				if (rev.ref_message_id->nr > 0)
+				if (rev.ref_message_id->nr > 0
+				    && (!cover_letter || rev.nr > 1))
 					free(rev.message_id);
 				else
 					string_list_append(rev.message_id,
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 345e6de..8b970c3 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -237,16 +237,19 @@ In-Reply-To: <1>
 References: <1>
 ---
 Message-Id: <2>
-In-Reply-To: <1>
+In-Reply-To: <0>
 References: <1>
+	<0>
 ---
 Message-Id: <3>
-In-Reply-To: <1>
+In-Reply-To: <0>
 References: <1>
+	<0>
 ---
 Message-Id: <4>
-In-Reply-To: <1>
+In-Reply-To: <0>
 References: <1>
+	<0>
 EOF
 
 test_expect_success 'thread cover-letter in-reply-to' '
-- 
1.6.2.rc1.295.g1e29
