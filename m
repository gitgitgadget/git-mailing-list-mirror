From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 09/10] fast-export: add support to delete refs
Date: Mon, 11 Nov 2013 16:55:04 -0600
Message-ID: <1384210507-26561-8-git-send-email-felipe.contreras@gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0V2-0006T2-4b
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab3KKXCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:25 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33976 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab3KKXCR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:02:17 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp4so3036302obc.36
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y/79ghTgfo7e19u0Tb1qVX7d1S3fcq90NF1DsUtRFW0=;
        b=Jls89bJwxHq57wFFJnOIOMm0dkrl3g+hndd2Mt0+/6wDWOu5FjVW/TnGq/fJihbA+y
         v/Se0ZkaTmAWiHOEzfdZdRy/lsf2CvU2wUtMxUlxY7pYv2683svb6IZ15gXpPm3md0t/
         QqtaWReQcoARKNGvij9QGjLNCq/e2tC2T27D9pQq8koH8iyjCiKf1sKQNkkIxxUhZf/d
         VvfphDF1BW/Um+QwTgH/dWGnL/LQ++ErJi1vIwfDUltK95GsQ/j+/C3qCvrFqi63yKhW
         IWdr6GZadmKfPoi9YFLHBzjZFOPYzJ6YvfjD47MX9Q3/QKPFAjSiJ1Lsm8tFs//qB8jF
         TNpQ==
X-Received: by 10.182.106.4 with SMTP id gq4mr27661318obb.4.1384210936818;
        Mon, 11 Nov 2013 15:02:16 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ee7sm34163060oeb.5.2013.11.11.15.02.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:02:16 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237670>

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
