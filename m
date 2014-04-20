From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/8] fast-export: add support to delete refs
Date: Sun, 20 Apr 2014 13:59:28 -0500
Message-ID: <1398020370-11406-7-git-send-email-felipe.contreras@gmail.com>
References: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:10:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbx8Q-0005mr-IB
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbaDTTKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:10:33 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:36178 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469AbaDTTKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:10:11 -0400
Received: by mail-yh0-f45.google.com with SMTP id a41so2956252yho.32
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOJhyqDM50PVnUAfGHHpt0t/YmHfVA80NnECr91BmRc=;
        b=AXzNP6N8EKy/g843dTShSVG7flH9PWFyoOyMYu1xyLfyDsZVoWLCT/8DZIlNUj4JLE
         xlyDO4UvLeEghpaatw4uysAni/mwhlRDdl9U9w3FGyQogsm4fSgVeY8JgEYrhb7imDM+
         9aRz9bQNbVRyadH8083tTQ8mkazsTGDJHIuh1qSZBURY122qis6uSitWbJDUhp9eUf3j
         n1aa2wB0T5Y5gBgLVBie4vxwpkP1XjhcFFoBf/Td4iDiwawVjxua2+zquCKid3Xl4oV3
         WSL50Zcd354W3Ngr2mfeIpQ3lumMtm7Zivq5ErhAOfcI8hNvqwljcLkP4OQ6kCyt+99k
         GdAg==
X-Received: by 10.236.81.201 with SMTP id m49mr4012640yhe.81.1398021011355;
        Sun, 20 Apr 2014 12:10:11 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id u5sm65408515yhg.25.2014.04.20.12.10.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:10:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246564>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fast-export.c  | 14 ++++++++++++++
 t/t9350-fast-export.sh | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ad9c17e..ef44816 100644
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
1.9.1+fc3.9.gc73078e
