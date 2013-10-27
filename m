From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 08/10] fast-export: add support to delete refs
Date: Sun, 27 Oct 2013 01:05:18 -0600
Message-ID: <1382857521-7005-8-git-send-email-felipe.contreras@gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKWV-0006tM-3H
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab3J0HMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:24 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37480 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab3J0HMS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:18 -0400
Received: by mail-ob0-f174.google.com with SMTP id vb8so2460527obc.19
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lUeSKy79yqvkNi2PlyHmvL4yJWuAZfExNg7SiEunzAE=;
        b=ZUCe3ob88uLi1YIwAUKn2dbqrYGlDwB0Nad9dz4Aa90/VrVACqbILwJrc+uMhPWnpp
         McJ/ohIjfmw8QJWSHLH7NhItmlB0h/OlVg90LgMUM6DRwuf7EXM79x08YPtZuYNTr9td
         YZBgrhHpM5gPORans6EnL80zwxJxT2992t3ZHGc1zD/d0rOL+T3QLdWS3O4vyEax3WWZ
         F39iywrQPdEsRKd89WQWPvx+PzO9t94jm6F1UquOREEfMQZ0KHNKB30WGeZv+zz1JN8V
         CuSVVWW5pjyIOzt4CAXB0SSJ0rSRlGOzrv40l6NLg1xJLiFfZIUqV7WwiCK+6F7PgyDa
         oGHA==
X-Received: by 10.182.166.40 with SMTP id zd8mr9598009obb.25.1382857937541;
        Sun, 27 Oct 2013 00:12:17 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm18078811obu.4.2013.10.27.00.12.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236784>

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
1.8.4-fc
