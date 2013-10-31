From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 09/10] fast-export: add support to delete refs
Date: Thu, 31 Oct 2013 03:36:34 -0600
Message-ID: <1383212197-14259-8-git-send-email-felipe.contreras@gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbonA-0003uF-LP
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab3JaJng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:43:36 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:44522 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab3JaJnf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:43:35 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so2751102obb.18
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VTGswgbvmXQA5ugJgx6mNKfybCp+Y4ErIP1D53ygwdM=;
        b=eQq9dzBsLZAhwRi2I9o4xaO9LA2bX6ansX49pE+jHw9uCqnX94LIxLdyRLM4ghar2a
         hnIBH4a7P7o4rWfv/Wg41IoFu/TGLa7yCQrzSPGDggpwdRA1PgHcTkpCsuYp2xowJ6o4
         ri7h60cywJau+lnLcrXFB6keFTZ4Im7TuREb2bc3iwkbucMf9Aq501pm1tpunSmCk/de
         QpvQS7jFL0aHHEHQ7bmo8efX7NOthnAJ/JmptEycNhZ/+AMQ/Wh0jONDSEaqQuLzOcD1
         GdDDF0CoA/m9TMY3RPh7EH91wVaKHH46gfqNSqC1RvuDLqArBJSDHLmujJSIleCJZtkL
         yeug==
X-Received: by 10.182.18.9 with SMTP id s9mr1896026obd.15.1383212615048;
        Thu, 31 Oct 2013 02:43:35 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm4509194obc.10.2013.10.31.02.43.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:43:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237107>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c  | 14 ++++++++++++++
 t/t9350-fast-export.sh | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b6f623e..8ed41b4 100644
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
@@ -762,6 +775,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	}
 
 	handle_tags_and_duplicates();
+	handle_deletes();
 
 	if (export_filename && lastimportid != last_idnum)
 		export_marks(export_filename);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index dc6666f..ea6c96c 100755
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
