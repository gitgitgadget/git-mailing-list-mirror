From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/9] fast-export: add support to delete refs
Date: Thu, 29 Aug 2013 10:23:26 -0500
Message-ID: <1377789808-2213-8-git-send-email-felipe.contreras@gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:29:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF49q-0000bZ-B3
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab3H2P3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:29:10 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:41125 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab3H2P3I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:29:08 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so759125oah.20
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6lGJHk4qmr1L8Ha1ymJPSamw7bQ/daMckNSGrvZQgi4=;
        b=T/riSwDIa29zojLBNpFdRrE15VeIq5P9NnYOLpmxJ5y9j5mOJSRX76F7tefLWiz3Ha
         rhLXVqAMyTVpUfKb24O2U+wH/VGhzTX5jpsHlfzgHMui9EZoYJcEKMSxXC3DNhFJ4xGg
         B8pOJfMG5/7itaWKUgqnC9n9KjN99APzd6ilqFsxQKIlFrQ8s+EsG3Tt8559zwzsbgaw
         SuYg4VxlcREcWBubdZhZ6uAuUCKoz1c8olPposGX8nhKOW5QhkgujNybCi5rAoD3ViqM
         VRsisdrWK5lnKp6h1t0JPo42zlo/1aY0XuX1BYRZIR/dSHQqAm36n4JAzAuiCAwYgG85
         pjbQ==
X-Received: by 10.60.51.196 with SMTP id m4mr2967035oeo.1.1377790148498;
        Thu, 29 Aug 2013 08:29:08 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm32918678oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:29:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233274>

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
+			refspec->dst, sha1_to_hex(null_sha1));
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
