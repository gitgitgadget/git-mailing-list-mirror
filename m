From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 10/11] fast-export: add support to delete refs
Date: Tue, 12 Nov 2013 14:57:08 -0600
Message-ID: <1384289830-5471-16-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:05:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL8y-0008IN-2S
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab3KLVEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:04:54 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:47424 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300Ab3KLVEr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:47 -0500
Received: by mail-oa0-f43.google.com with SMTP id g12so5936409oah.2
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y/79ghTgfo7e19u0Tb1qVX7d1S3fcq90NF1DsUtRFW0=;
        b=ZK1NvFgDjiKZsuujb6yYTb3KceOhtmTX0eZXpk2uu6C1X4L9AkU2lra7IT6rLo9O7o
         fDGx/xdQhBCp+8OubwW/OAIuvSNZEkBDQs7eLqmqfffU8oNfWpeeHRN4frcsOVaR3B4q
         aYCU4C+quKMd2OFeucr0LaelSuhr8nuajsQjUjOOs4pMkJkjfT6iQS/0IcQkaZkw4CQH
         7f2/+Ntdj67yyugsW32k3wLcchTUqtv+ouqztdDk9h9zlxk1gTqsEj41k6tZ3e/E3T7w
         Fq8LTrglpOdydHCZk+xJey0oADJmd9Uy3u1aUVGrmb1AgSBKH9dZQzxGTdTO2pW84dMn
         mm8w==
X-Received: by 10.60.51.7 with SMTP id g7mr33468517oeo.6.1384290287162;
        Tue, 12 Nov 2013 13:04:47 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm35388308obb.11.2013.11.12.13.04.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:46 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237745>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c  | 14 ++++++++++++++
 t/t9350-fast-export.sh | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index cf745ec..4b76222 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -673,6 +673,19 @@ static void import_marks(char *input_file)
 	fclose(f);
 }
 
+static void handle_deletes(void)
+{
+	int i;
+	for (i = 0; i < refspecs_nr; i++) {
+		struct refspec *refspec = &refspecs[i];
+		if (*refspec->src)
+			continue;
+
+		printf("reset %s\nfrom %s\n\n",
+				refspec->dst, sha1_to_hex(null_sha1));
+	}
+}
+
 int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -764,6 +777,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	}
 
 	handle_tags_and_duplicates();
+	handle_deletes();
 
 	if (export_filename && lastimportid != last_idnum)
 		export_marks(export_filename);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 3d475af..66c8b0a 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -511,4 +511,15 @@ test_expect_success 'use refspec' '
 	test_cmp expected actual
 '
 
+test_expect_success 'delete refspec' '
+	git branch to-delete &&
+	git fast-export --refspec :refs/heads/to-delete to-delete ^to-delete > actual &&
+	cat > expected <<-EOF &&
+	reset refs/heads/to-delete
+	from 0000000000000000000000000000000000000000
+
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.4.2+fc1
