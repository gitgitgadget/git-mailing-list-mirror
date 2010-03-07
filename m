From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/12] grep: do not return early in cmd_grep() if there is no error
Date: Sun,  7 Mar 2010 19:09:44 +0700
Message-ID: <1267963785-473-12-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFNP-0000oh-4m
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab0CGMNx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:53 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33676 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0CGMNv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:51 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3254848pwj.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/qiPV9X8nhIUlSy523f5AVRmrND+OP+1Xl2dTgn1uWk=;
        b=qkwf9TXriHiSxUu24z3CnAF3oEgJJBrUh4/Li+CKHwTlBdWfZDsG6INwe+VQFBp3z0
         X7PZ/vvQ1Q9wzrUI6LEaeKwd1KX/hGnLwkkZL2w5V/m1hPWL/y49BVDl8GnicpUxOBnm
         BmTR6bV1BKcWS25mtbt7YzhfRpX7bIaRt3RvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kLFKr3r+mnBkk24Te9qQORF8fjGrgUe5MRKllaij99emw4XQZVTDsIcVjaKeQYnwUz
         eRWoHGM5/rg5YeN0VkgEXsfSvg9oJL+Nah5iAvE+qbl2SHoEsujifg6w4m58G3QvlrzN
         kg8DjLD7Ca4iEHUatqE8N5CXkx4btxnxrMhsY=
Received: by 10.142.249.10 with SMTP id w10mr2293199wfh.207.1267964030294;
        Sun, 07 Mar 2010 04:13:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 21sm3585313pzk.8.2010.03.07.04.13.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:49 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:34 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141684>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |   39 +++++++++++++++++----------------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 40b9a93..b8a1d5c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -568,7 +568,6 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached)
 		if (hit && opt->status_only)
 			break;
 	}
-	free_grep_patterns(opt);
 	return hit;
 }
=20
@@ -969,7 +968,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	}
=20
 	if (!use_index) {
-		int hit;
 		if (cached)
 			die("--cached cannot be used with --no-index.");
 		if (list.nr)
@@ -977,35 +975,32 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		hit =3D grep_directory(&opt, paths);
 		if (use_threads)
 			hit |=3D wait_all();
-		return !hit;
 	}
-
-	if (!list.nr) {
-		int hit;
+	else if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
-
 		hit =3D grep_cache(&opt, paths, cached);
 		if (use_threads)
 			hit |=3D wait_all();
-		return !hit;
+		free_grep_patterns(&opt);
 	}
-
-	if (cached)
-		die("both --cached and trees are given.");
-
-	for (i =3D 0; i < list.nr; i++) {
-		struct object *real_obj;
-		real_obj =3D deref_tag(list.objects[i].item, NULL, 0);
-		if (grep_object(&opt, paths, real_obj, list.objects[i].name)) {
-			hit =3D 1;
-			if (opt.status_only)
-				break;
+	else {
+		if (cached)
+			die("both --cached and trees are given.");
+
+		for (i =3D 0; i < list.nr; i++) {
+			struct object *real_obj;
+			real_obj =3D deref_tag(list.objects[i].item, NULL, 0);
+			if (grep_object(&opt, paths, real_obj, list.objects[i].name)) {
+				hit =3D 1;
+				if (opt.status_only)
+					break;
+			}
 		}
+		if (use_threads)
+			hit |=3D wait_all();
+		free_grep_patterns(&opt);
 	}
=20
-	if (use_threads)
-		hit |=3D wait_all();
-	free_grep_patterns(&opt);
 	return !hit;
 }
--=20
1.7.0.1.370.gd3c5
