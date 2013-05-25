From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 8/9] fast-export: add support to delete refs
Date: Fri, 24 May 2013 21:47:39 -0500
Message-ID: <1369450060-19011-9-git-send-email-felipe.contreras@gmail.com>
References: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:50:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Z9-0005Xs-4z
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004Ab3EYCud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:50:33 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:60169 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275Ab3EYCub (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:50:31 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so7027290oag.15
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WV96Bln3Lq7l2n71ovGT098vNQ/bWDQsQG0vpPlhZFc=;
        b=l/BmVSr4cbTByzUTeCQo71cDmruOVMqyeqqvgeVIQF8ZPNFB/5JsP7LwP9tCjkv1zX
         xFaAemRKNH3UnQly8kDRKTBMJhSTQ6BhUitYullJLhMWAFpb/imEiQURc303RFZ3fih2
         GvTMHmbwkQSScwzwWImcrfjAtfnYRiomp4NSAc8XjFANaLeWRMx1ve5WigVWh50Gkslg
         uRsQxpwv4//Nyw6fLQ/w8PSCfs/EuWW5iPAaK3eDE0WfLdY25GIgIgWy6kGRRlWmswlU
         ClGYV6SxfHZQ2q17aEkT+HB3PDho7Tac9dRgozXdSTfEiRYGstzoVQhf0IQxTcfM4OXg
         nfuA==
X-Received: by 10.182.118.42 with SMTP id kj10mr13355421obb.99.1369450231317;
        Fri, 24 May 2013 19:50:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm20079278obb.13.2013.05.24.19.50.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:50:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225483>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c  | 14 ++++++++++++++
 t/t9350-fast-export.sh | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ba4b0ba..8db00a8 100644
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
index ef2d76e..779ee22 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -512,4 +512,15 @@ test_expect_success 'use refspec' '
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
1.8.3.rc3.312.g47657de
