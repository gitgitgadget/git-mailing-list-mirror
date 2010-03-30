From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] format-patch: Squelch 'fatal: Not a range." error
Date: Mon, 29 Mar 2010 19:46:38 -0700
Message-ID: <1269917198-58320-1-git-send-email-kevin@sb.org>
References: <46BEF37C-3E3F-4490-9CE6-C0109438C181@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 30 04:47:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwRUP-000189-9N
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 04:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab0C3CrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 22:47:21 -0400
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:57125 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754820Ab0C3CrU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 22:47:20 -0400
Received: from localhost.localdomain (173-13-153-133-sfba.hfc.comcastbusiness.net [173.13.153.133])
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id A98081857FA;
	Mon, 29 Mar 2010 19:47:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.436.g3ff98
In-Reply-To: <46BEF37C-3E3F-4490-9CE6-C0109438C181@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143536>

Don't output an error on `git format-patch --ignore-if-in-upstream HEAD`.
This matches the behavior of `git format-patch HEAD`.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
This seems like a safer change than just deleting the die("Not a range.").
The conditional here is copied from cmd_cherry().
 builtin/log.c           |    9 ++++++++-
 t/t4014-format-patch.sh |    4 ++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0cb4d5a..362dd42 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1179,8 +1179,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			return 0;
 	}
 
-	if (ignore_if_in_upstream)
+	if (ignore_if_in_upstream) {
+		/* Don't say anything if head and upstream are the same. */
+		if (rev.pending.nr == 2) {
+			struct object_array_entry *o = rev.pending.objects;
+			if (hashcmp(o[0].item->sha1, o[1].item->sha1) == 0)
+				return 0;
+		}
 		get_patch_ids(&rev, &ids, prefix);
+	}
 
 	if (!use_stdout)
 		realstdout = xfdopen(xdup(1), "w");
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c7b6256..d21c37f 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -609,4 +609,8 @@ test_expect_success 'format-patch -- <path>' '
 	! grep "Use .--" error
 '
 
+test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
+	git format-patch --ignore-if-in-upstream HEAD
+'
+
 test_done
-- 
1.7.0.3.436.g3ff98
