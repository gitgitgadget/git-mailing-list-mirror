From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 3/3] gc: Clean garbage .bitmap files from pack dir
Date: Fri, 13 Nov 2015 16:46:27 -0800
Message-ID: <1447461987-35450-3-git-send-email-dougk.ff7@gmail.com>
References: <CAGZ79kYPv2OLzMX6t9=mejes9F8CzxAJiERs8GGxDnaAG8Q64g@mail.gmail.com>
 <1447461987-35450-1-git-send-email-dougk.ff7@gmail.com>
Cc: peff@github.com, gitster@pobox.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 01:46:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxOzR-0001sw-KY
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbbKNAqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:46:46 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33330 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbbKNAqo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:46:44 -0500
Received: by pabfh17 with SMTP id fh17so115589130pab.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 16:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMhnBHg3fh/udzutvdqe3Ev3oRBTk1mNb45J0kFVjek=;
        b=zx2q73Um3RYDP0ORUYvdN5jyLIQY5Gr3jgCAy3ziXC3AZfBGNFTEz6q4GLXyu1CYCt
         75VzZKGLccIMPOaO/OH/PGafgoIZ00QVDd0/PyE6F/mlJtLEMWjxhvEdGMNMc354P6Bz
         8C0KpSb5unP1wKT0nT7eXV/Nxl6IqsigVg3LZAP6Q534PdyFaLveWPN8nZd2chrTY0t4
         sCz051mRciguDT5Ksh/ndhON+nMt7brOcXxP+TRy+lvzwLed8S5zzOei40+1bginO2AJ
         dqI06Alp8cR5ynwCGWcLSriDotfHggNTCqFu3QZTeIlmauKGLATkmL8koGKZC/QWKcU+
         Jxcg==
X-Received: by 10.68.69.81 with SMTP id c17mr18075409pbu.132.1447462003531;
        Fri, 13 Nov 2015 16:46:43 -0800 (PST)
Received: from k-na.local.com ([104.135.13.127])
        by smtp.gmail.com with ESMTPSA id c1sm11548168pap.36.2015.11.13.16.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2015 16:46:42 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1447461987-35450-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281287>

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
