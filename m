From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 08/10] fast-export: add support to delete refs
Date: Sat, 12 Oct 2013 02:05:30 -0500
Message-ID: <1381561533-20381-8-git-send-email-felipe.contreras@gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMw-0004bU-RW
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab3JLHLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:54 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:45384 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3JLHLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:52 -0400
Received: by mail-oa0-f48.google.com with SMTP id m6so3079277oag.21
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6lGJHk4qmr1L8Ha1ymJPSamw7bQ/daMckNSGrvZQgi4=;
        b=nxca780NB0VomPR0XdpFB7yo2RbTOYtNgV+ZDS5geXZxue72awHdA2xf4sDjfygAct
         yYjnE9OJXDOCUpbkyOS0rGYjqoYK7CUYBe/y+OVtU4S7CFm0b9c3Sj1lFGiq/DHTzYxC
         yo816TuZ0jfZ3nY4aobAoHlp0s7aYBXKXQcCfOBwyBhydtH4CLsI9LB/5MTKf6/g0Pg4
         pq8xscT9HhdViv+jFXkUPAjr5rzoXELlSGk3rgcKdBFj87vPBKPotusLQ/aqgkigFYMT
         Jsf1vW1PuIf7n6xQn1+mOxnb6lfefhGfE7v3gQdm1NV4kSXrTWzRUP9eLU8O+EXZwgbA
         tZvw==
X-Received: by 10.182.48.130 with SMTP id l2mr2567obn.44.1381561912005;
        Sat, 12 Oct 2013 00:11:52 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm28642007obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235983>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c  | 14 ++++++++++++++
 t/t9350-fast-export.sh | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7f314f0..9b728ca 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -665,6 +665,19 @@ static void import_marks(char *input_file)
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
@@ -755,6 +768,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	}
 
 	handle_tags_and_duplicates(&extra_refs);
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
1.8.4-fc
