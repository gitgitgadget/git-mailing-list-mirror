From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 09/10] fast-export: add support to delete refs
Date: Tue, 12 Nov 2013 14:57:06 -0600
Message-ID: <1384289830-5471-14-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL9X-0000cy-MU
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309Ab3KLVFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:05:23 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:46382 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282Ab3KLVEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:42 -0500
Received: by mail-oa0-f42.google.com with SMTP id h16so3731425oag.29
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y/79ghTgfo7e19u0Tb1qVX7d1S3fcq90NF1DsUtRFW0=;
        b=OfNmzadYnMO71rGCNMoZk/ujtLmuwgmTSmvobsRJGRxyMzDEuf1uYlnd0zQNw+ucwL
         hhAzexFNCtsegxAGesLLAwOERFsd1mxo5GJJE3zE1NvzeoKFgApkm/81LjB4C0hBe8C5
         i9bnSsm8864Z2WRts5d29cZ9Zj1rx01Iy/vQHauRLSh7CFcNKlpRka0QbI954k3l/Set
         5zzN/Eg1cbZ3zHZrUpTMFn5Xei/kNdLlCPXZXeBTs3/2cZ7mQ/cvqmWGI574d3om7zYZ
         wy+q2dXffz0sIh0i+NhUTW95GEDu+A/xGYiEgwYZxWWamc7vVtazu2+Rsm6pkU64mcTz
         HyhA==
X-Received: by 10.60.134.14 with SMTP id pg14mr8733149oeb.66.1384290281425;
        Tue, 12 Nov 2013 13:04:41 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm35391402obj.8.2013.11.12.13.04.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:40 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237751>

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
