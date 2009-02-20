From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 next 3/4] format-patch: thread as reply to cover letter even with in-reply-to
Date: Fri, 20 Feb 2009 20:55:39 +0100
Message-ID: <d0adbe1d8b07b245a5b71fd7d337a6be50fb2064.1235158956.git.trast@student.ethz.ch>
References: <alpine.LNX.1.00.0902191734110.19665@iabervon.org> <cover.1235158956.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 20:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LabV4-0006tb-3s
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 20:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbZBTTz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 14:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbZBTTz5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 14:55:57 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:36209 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753730AbZBTTzz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 14:55:55 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:55:53 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Feb 2009 20:55:53 +0100
X-Mailer: git-send-email 1.6.2.rc1.310.ga3b4a
In-Reply-To: <cover.1235158956.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 20 Feb 2009 19:55:53.0115 (UTC) FILETIME=[3C7F36B0:01C99395]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110881>

Currently, format-patch --thread --cover-letter --in-reply-to $parent
makes all mails, including the cover letter, a reply to $parent.
However, we would want the reader to consider the cover letter above
all the patches.

This changes the semantics so that only the cover letter is a reply to
$parent, while all the patches are formatted as replies to the cover
letter.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same as v1.

 builtin-log.c           |   20 +++++++++++++++-----
 t/t4014-format-patch.sh |    9 ++++++---
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1d7cf2f..2dc6c48 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1055,12 +1055,22 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
-				if (rev.ref_message_ids->nr > 0)
+				if (rev.ref_message_ids->nr > 0
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
1.6.2.rc1.310.ga3b4a
