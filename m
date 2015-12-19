From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 3/3] gc: Clean garbage .bitmap files from pack dir
Date: Fri, 18 Dec 2015 18:06:40 -0600
Message-ID: <1450483600-64091-4-git-send-email-dougk.ff7@gmail.com>
References: <20151215232534.GA30998@sigill.intra.peff.net>
 <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Cc: peff@peff.net, sbeller@google.com, gitster@pobox.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 01:07:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA53L-000089-PE
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 01:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbbLSAHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 19:07:07 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36592 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbbLSAHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 19:07:05 -0500
Received: by mail-yk0-f171.google.com with SMTP id x184so77281909yka.3
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 16:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMhnBHg3fh/udzutvdqe3Ev3oRBTk1mNb45J0kFVjek=;
        b=bMMn+jSDmyqyAwq8NS4jwBQwfM29YQjEL1QOahy1UB7Q0yh2YMdGS7FYXwaGCFf5s7
         eV8Ty2y8Zwsvl6I95BaiIDkGdw7VwjD05F0bhfRjRFWy+QuKnYgPdgsM4hRWcxwcbIbH
         UrQF8WJhsfv2uhxApO8wtNZvzyjTpHUbcS/YuYiBJQfEcuQ270BwSn/TX93CqcSHWDFk
         Nl6aFLRSXuUJw5PNLfrRObS7wvtHQS5WWNF/YDroDEJoJvzRvSYeH3QPtYi6mdbC8nEq
         Ps0jL2rxZB0AOpZi0NVJCtzhZsTpAD+/x+Jhlmb7Iu6Qhbo3vimXfO9x7gmFqfIWGdVT
         XzzQ==
X-Received: by 10.13.253.7 with SMTP id n7mr5395144ywf.74.1450483624906;
        Fri, 18 Dec 2015 16:07:04 -0800 (PST)
Received: from localhost.localdomain ([204.77.163.41])
        by smtp.gmail.com with ESMTPSA id w184sm18490831ywc.41.2015.12.18.16.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Dec 2015 16:07:04 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282722>

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
