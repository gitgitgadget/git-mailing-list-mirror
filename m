From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 3/3] gc: Clean garbage .bitmap files from pack dir
Date: Fri, 13 Nov 2015 16:10:53 -0800
Message-ID: <1447459853-28838-4-git-send-email-dougk.ff7@gmail.com>
References: <1447459853-28838-1-git-send-email-dougk.ff7@gmail.com>
Cc: Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 01:12:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxOS5-0008Ky-My
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbbKNAMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:12:17 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34657 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbbKNAMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:12:14 -0500
Received: by padhx2 with SMTP id hx2so114595185pad.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 16:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMhnBHg3fh/udzutvdqe3Ev3oRBTk1mNb45J0kFVjek=;
        b=D6Q737y2+gwpf925Rp4ppKE8aLCMv9q4KC8ko+bP0UprcJSi5o8BSX0Ono9m6Eps87
         R40KJ4XZet1I9etaV2kN1iNMpJIwzEBLI63x4NQtS5/3JewPGg1DySeKi9z0E8zgO7A9
         oSL64hXAtJXxBDwVTztvLQ2XUao1wL3aw1YkBrBEoLJuv5BMOQchjwVrznd7iMjrxo/j
         8qrtwcgGi69yWMd5XNK8NyXPHWWL7z6dV7sH7L4HnznivwChorGL6oXfxMfMVkZ574rC
         gcoYBaSvR8PnN000IGvzkheGSVIu4aMVbP0bu6kmEKhjP3er9cQboXriShZzBiCJpgRs
         zu0A==
X-Received: by 10.69.25.40 with SMTP id in8mr35761329pbd.96.1447459933690;
        Fri, 13 Nov 2015 16:12:13 -0800 (PST)
Received: from k-na.local.com ([104.135.13.127])
        by smtp.gmail.com with ESMTPSA id qd2sm22507609pbb.68.2015.11.13.16.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2015 16:12:12 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1447459853-28838-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281280>

Similar to cleaning up excess .idx files, clean any garbage .bitmap
files that are not otherwise associated with any .idx/.pack files.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 builtin/gc.c     | 12 ++++++++++--
 t/t5304-prune.sh |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c583aad..7ddf071 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -58,8 +58,16 @@ static void clean_pack_garbage(void)
 
 static void report_pack_garbage(unsigned seen_bits, const char *path)
 {
-	if (seen_bits == PACKDIR_FILE_IDX)
-		string_list_append(&pack_garbage, path);
+	if (seen_bits & PACKDIR_FILE_IDX ||
+	    seen_bits & PACKDIR_FILE_BITMAP) {
+		const char *dot = strrchr(path, '.');
+		if (dot) {
+			int baselen = dot - path + 1;
+			if (!strcmp(path+baselen, "idx") ||
+				!strcmp(path+baselen, "bitmap"))
+				string_list_append(&pack_garbage, path);
+		}
+	}
 }
 
 static void git_config_date_string(const char *key, const char **output)
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 4fa6e7a..9f9f263 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -257,7 +257,7 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_failure 'clean pack garbage with gc' '
+test_expect_success 'clean pack garbage with gc' '
 	test_when_finished "rm -f .git/objects/pack/fake*" &&
 	test_when_finished "rm -f .git/objects/pack/foo*" &&
 	: >.git/objects/pack/foo.keep &&
-- 
2.6.1
