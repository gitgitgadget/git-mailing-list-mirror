From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 41/45] Kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
Date: Fri, 15 Mar 2013 13:06:56 +0700
Message-ID: <1363327620-29017-42-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO8e-0008MO-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab3COG2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:28:46 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:51307 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab3COG2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:28:46 -0400
Received: by mail-ie0-f182.google.com with SMTP id k14so3956939iea.41
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=r4DUwkTP13/3z8cG3lGFl8qSO2P4SU3PVET72mxgFPA=;
        b=zqhVaCuSwdezpySD/ZErQnmQ1gjh/PC/DJKPR4y7VTB1w6/iYF9GJj6L3kpsBqcnw6
         683LBFefMaFB5dajLpb2Oo2ijiQojUSA0964e6rCbXB4pHlvFS3sBHWccrbut9JAwbHx
         PGTGD9U97JzNeL79di93T3KQfzLkYkZ2zLax8LXgad2GpTm+DcB8zDtJJ31hwhkcgc3o
         livO/kObzDayKCAz2hztmfBNMFer7fXJdAKybyx95pjI4PfDU6hL7gXbWw5CAqa7Qttf
         axIflslri8nZzsrKEdUkQsmMx9/rg4GLdogHEuonm3lH5p31Rt2sdw2HehbsqiwtrSA/
         z5Hg==
X-Received: by 10.50.11.229 with SMTP id t5mr421549igb.65.1363328925652;
        Thu, 14 Mar 2013 23:28:45 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ew5sm759252igc.2.2013.03.14.23.28.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:28:45 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:11:47 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218228>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c      | 8 --------
 pathspec.c | 8 ++++++--
 pathspec.h | 2 --
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index 9627d7e..4f5a2c9 100644
--- a/dir.c
+++ b/dir.c
@@ -1523,14 +1523,6 @@ int remove_path(const char *name)
 	return 0;
 }
=20
-int limit_pathspec_to_literal(void)
-{
-	static int flag =3D -1;
-	if (flag < 0)
-		flag =3D git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0);
-	return flag;
-}
-
 /*
  * Frees memory within dir which was allocated for exclude lists and
  * the exclude_stack.  Does not free dir itself.
diff --git a/pathspec.c b/pathspec.c
index 3291b58..7b3dfc0 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -91,11 +91,15 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 				const char *prefix, int prefixlen,
 				const char *elt)
 {
+	static int literal_global =3D -1;
 	unsigned magic =3D 0, short_magic =3D 0;
 	const char *copyfrom =3D elt, *long_magic_end =3D NULL;
 	char *match;
 	int i, pathspec_prefix =3D -1;
=20
+	if (literal_global < 0)
+		literal_global =3D git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT, 0=
);
+
 	if (elt[0] !=3D ':') {
 		; /* nothing to do */
 	} else if (elt[1] =3D=3D '(') {
@@ -183,7 +187,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	if (flags & PATHSPEC_PREFIX_ORIGIN) {
 		struct strbuf sb =3D STRBUF_INIT;
 		const char *start =3D elt;
-		if (prefixlen && !limit_pathspec_to_literal()) {
+		if (prefixlen && !literal_global) {
 			/* Preserve the actual prefix length of each pattern */
 			if (long_magic_end) {
 				strbuf_add(&sb, start, long_magic_end - start);
@@ -231,7 +235,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 				     elt, ce_len, ce->name);
 		}
=20
-	if (limit_pathspec_to_literal())
+	if (literal_global)
 		item->nowildcard_len =3D item->len;
 	else {
 		item->nowildcard_len =3D simple_length(item->match);
diff --git a/pathspec.h b/pathspec.h
index 9f9ecd2..8f339a5 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -52,8 +52,6 @@ extern void parse_pathspec(struct pathspec *pathspec,
 extern void copy_pathspec(struct pathspec *dst, const struct pathspec =
*src);
 extern void free_pathspec(struct pathspec *);
=20
-extern int limit_pathspec_to_literal(void);
-
 extern char *find_pathspecs_matching_against_index(const struct pathsp=
ec *pathspec);
 extern void add_pathspec_matches_against_index(const struct pathspec *=
pathspec, char *seen);
 extern const char *check_path_for_gitlink(const char *path);
--=20
1.8.0.rc0.19.g7bbb31d
