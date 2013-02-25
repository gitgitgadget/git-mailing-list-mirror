From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] diff-lib: drop return value from do_diff_cache()
Date: Mon, 25 Feb 2013 21:00:45 +0700
Message-ID: <1361800845-21958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 15:00:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9ybT-0005at-Hv
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 15:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab3BYOAA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 09:00:00 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38981 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094Ab3BYN77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 08:59:59 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so1762156pad.11
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 05:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=eAGHqCI3lqLzxgo2oGW0tsPr0OfrD24zEKg7guBidtQ=;
        b=UGAAqExPAGAaR6bzZPJGjMDBpfqEmWSN78nn0DP8ol2041iTG9sv5rvBJtudY5Nwyr
         5bN3deQyjvIlwMb66Txy2j2CItAJz0QgdXMS2zbBO26pd9m7xwmgXBugVlRL75F08DFx
         cCPUGLeepuyaHOcaPuFjepaBeMqURgOc3DHnaDCfnwApV2Hc22Sf8haVSW59NKddQjaC
         CYSwNL0i13rxi3v0sFml9O+9Zg6f6NVivd5wvsG6higsSs0wQ6bi6V9VJUTYEbddFOlj
         iAcA+3VkgJu2Zng6gF8PO2iMcpcLoZIaACv3cMdjrxILTUvb/YNKGiZDHsTnn2pncjS9
         o38A==
X-Received: by 10.68.42.9 with SMTP id j9mr18148694pbl.142.1361800798829;
        Mon, 25 Feb 2013 05:59:58 -0800 (PST)
Received: from lanh ([115.74.61.117])
        by mx.google.com with ESMTPS id pg6sm12848739pbb.0.2013.02.25.05.59.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Feb 2013 05:59:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Feb 2013 21:00:55 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217057>

Since 204ce97 (Also use unpack_trees() in do_diff_cache() -
2008-01-20), do_diff_cache() always returns zero. It does not make
sense to check its return value any more.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I don't know the history behind this function. But it feels not right
 to do exit(128) in do_diff_cache (since 203a2fe (Allow callers of
 unpack_trees() to handle failure - 2008-02-07) and limit the caller's
 control here.

 builtin/reset.c | 3 +--
 diff-lib.c      | 3 +--
 diff.h          | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 6032131..843d337 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -140,8 +140,7 @@ static int read_from_tree(const char **pathspec, un=
signed char *tree_sha1)
 	opt.format_callback =3D update_index_from_diff;
=20
 	read_cache();
-	if (do_diff_cache(tree_sha1, &opt))
-		return 1;
+	do_diff_cache(tree_sha1, &opt);
 	diffcore_std(&opt);
 	diff_flush(&opt);
 	diff_tree_release_paths(&opt);
diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..5a5fc94 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -495,7 +495,7 @@ int run_diff_index(struct rev_info *revs, int cache=
d)
 	return 0;
 }
=20
-int do_diff_cache(const unsigned char *tree_sha1, struct diff_options =
*opt)
+void do_diff_cache(const unsigned char *tree_sha1, struct diff_options=
 *opt)
 {
 	struct rev_info revs;
=20
@@ -505,7 +505,6 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
truct diff_options *opt)
=20
 	if (diff_cache(&revs, tree_sha1, NULL, 1))
 		exit(128);
-	return 0;
 }
=20
 int index_differs_from(const char *def, int diff_flags)
diff --git a/diff.h b/diff.h
index 78b4091..aaa9a4e 100644
--- a/diff.h
+++ b/diff.h
@@ -319,7 +319,7 @@ extern const char *diff_unique_abbrev(const unsigne=
d char *, int);
 extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int run_diff_index(struct rev_info *revs, int cached);
=20
-extern int do_diff_cache(const unsigned char *, struct diff_options *)=
;
+extern void do_diff_cache(const unsigned char *, struct diff_options *=
);
 extern int diff_flush_patch_id(struct diff_options *, unsigned char *)=
;
=20
 extern int diff_result_code(struct diff_options *, int);
--=20
1.8.1.2.536.gf441e6d
