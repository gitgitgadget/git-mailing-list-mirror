From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname concatenation
Date: Mon, 13 Dec 2010 16:46:46 +0700
Message-ID: <1292233616-27692-10-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:49:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS52M-0005A4-N4
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab0LMJtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:49:08 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50229 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab0LMJtD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:49:03 -0500
Received: by pva4 with SMTP id 4so1079600pva.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=nCNDffC68N4+L2ftkcJAbuNdUnBhNTlybXjLtwlqVhg=;
        b=sy+u/TEWPhJyOnb/maZ1i5nFS8jL2eqxBB8J+IVbtob3sprr4w4VAMICyRubOfklL8
         RCyDKD0YJD6cBZq5dbzEC1qptwFIfcaRXDp96lYt3RNnLHiFktWTDOkx+pdTYdtaHipq
         uY9YQ7pUMUvMSPswWHcdrYu/upIZQdIReiLS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Dl/eRfy8IsV8mpy/AKVXxVqm0kXrIYdyxNq8Cd5+YZ2hJzdkP+8GNY5dU7Ir2iTEyR
         R0odCwKRmy55QqHqgjInFrVeYVrkdRyxxaR9dysoGIPMrwvl5bEJgP9e9l3wdqSFya5N
         +a7cqJqGWGj0vz4zka9uXrqE9NmaENYM101Cs=
Received: by 10.142.12.2 with SMTP id 2mr3039410wfl.241.1292233742468;
        Mon, 13 Dec 2010 01:49:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id v19sm8676779wfh.12.2010.12.13.01.48.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:49:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:48:09 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163539>

This patch make sure that "base" parameter is writable. The callees
are free to modify it as long as base remains the same before
entering and after leaving the callee.

This avoids quite a bit of malloc and memcpy().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-diff.c |   87 +++++++++++++++++++++++++++------------------------=
-------
 1 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 50d7e6d..a870f6c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -6,34 +6,17 @@
 #include "diffcore.h"
 #include "tree.h"
=20
-static char *malloc_base(const char *base, int baselen, const char *pa=
th, int pathlen)
-{
-	char *newbase =3D xmalloc(baselen + pathlen + 2);
-	memcpy(newbase, base, baselen);
-	memcpy(newbase + baselen, path, pathlen);
-	memcpy(newbase + baselen + pathlen, "/", 2);
-	return newbase;
-}
+static void show_entry(struct diff_options *opt, const char *prefix,
+		       struct tree_desc *desc, char *base, int baselen);
=20
-static char *malloc_fullname(const char *base, int baselen, const char=
 *path, int pathlen)
-{
-	char *fullname =3D xmalloc(baselen + pathlen + 1);
-	memcpy(fullname, base, baselen);
-	memcpy(fullname + baselen, path, pathlen);
-	fullname[baselen + pathlen] =3D 0;
-	return fullname;
-}
-
-static void show_entry(struct diff_options *opt, const char *prefix, s=
truct tree_desc *desc,
-		       const char *base, int baselen);
-
-static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *=
t2, const char *base, int baselen, struct diff_options *opt)
+static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *=
t2,
+			      char *base, int baselen,
+			      struct diff_options *opt)
 {
 	unsigned mode1, mode2;
 	const char *path1, *path2;
 	const unsigned char *sha1, *sha2;
 	int cmp, pathlen1, pathlen2;
-	char *fullname;
=20
 	sha1 =3D tree_entry_extract(t1, &path1, &mode1);
 	sha2 =3D tree_entry_extract(t2, &path2, &mode2);
@@ -64,26 +47,31 @@ static int compare_tree_entry(struct tree_desc *t1,=
 struct tree_desc *t2, const
=20
 	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode1)) {
 		int retval;
-		char *newbase =3D malloc_base(base, baselen, path1, pathlen1);
+
+		memcpy(base + baselen, path1, pathlen1);
+		memcpy(base + baselen + pathlen1, "/", 2);
+
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
-			newbase[baselen + pathlen1] =3D 0;
+			base[baselen + pathlen1] =3D 0;
 			opt->change(opt, mode1, mode2,
-				    sha1, sha2, newbase, 0, 0);
-			newbase[baselen + pathlen1] =3D '/';
+				    sha1, sha2, base, 0, 0);
+			base[baselen + pathlen1] =3D '/';
 		}
-		retval =3D diff_tree_sha1(sha1, sha2, newbase, opt);
-		free(newbase);
+		retval =3D diff_tree_sha1(sha1, sha2, base, opt);
+		base[baselen] =3D 0;
 		return retval;
 	}
=20
-	fullname =3D malloc_fullname(base, baselen, path1, pathlen1);
-	opt->change(opt, mode1, mode2, sha1, sha2, fullname, 0, 0);
-	free(fullname);
+	memcpy(base + baselen, path1, pathlen1);
+	base[baselen + pathlen1] =3D 0;
+	opt->change(opt, mode1, mode2, sha1, sha2, base, 0, 0);
+	base[baselen] =3D 0;
 	return 0;
 }
=20
 /* A whole sub-tree went away or appeared */
-static void show_tree(struct diff_options *opt, const char *prefix, st=
ruct tree_desc *desc, const char *base, int baselen)
+static void show_tree(struct diff_options *opt, const char *prefix,
+		      struct tree_desc *desc, char *base, int baselen)
 {
 	int all_interesting =3D 0;
 	while (desc->size) {
@@ -105,8 +93,8 @@ static void show_tree(struct diff_options *opt, cons=
t char *prefix, struct tree_
 }
=20
 /* A file entry went away or appeared */
-static void show_entry(struct diff_options *opt, const char *prefix, s=
truct tree_desc *desc,
-		       const char *base, int baselen)
+static void show_entry(struct diff_options *opt, const char *prefix,
+		       struct tree_desc *desc, char *base, int baselen)
 {
 	unsigned mode;
 	const char *path;
@@ -115,34 +103,38 @@ static void show_entry(struct diff_options *opt, =
const char *prefix, struct tree
=20
 	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode)) {
 		enum object_type type;
-		char *newbase =3D malloc_base(base, baselen, path, pathlen);
 		struct tree_desc inner;
 		void *tree;
 		unsigned long size;
=20
+		memcpy(base + baselen, path, pathlen);
+		memcpy(base + baselen + pathlen, "/", 2);
+
 		tree =3D read_sha1_file(sha1, &type, &size);
 		if (!tree || type !=3D OBJ_TREE)
 			die("corrupt tree sha %s", sha1_to_hex(sha1));
=20
 		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE)) {
-			newbase[baselen + pathlen] =3D 0;
-			opt->add_remove(opt, *prefix, mode, sha1, newbase, 0);
-			newbase[baselen + pathlen] =3D '/';
+			base[baselen + pathlen] =3D 0;
+			opt->add_remove(opt, *prefix, mode, sha1, base, 0);
+			base[baselen + pathlen] =3D '/';
 		}
=20
 		init_tree_desc(&inner, tree, size);
-		show_tree(opt, prefix, &inner, newbase, baselen + 1 + pathlen);
+		show_tree(opt, prefix, &inner, base, baselen + 1 + pathlen);
=20
+		base[baselen] =3D 0;
 		free(tree);
-		free(newbase);
 	} else {
-		char *fullname =3D malloc_fullname(base, baselen, path, pathlen);
-		opt->add_remove(opt, prefix[0], mode, sha1, fullname, 0);
-		free(fullname);
+		memcpy(base + baselen, path, pathlen);
+		base[baselen + pathlen] =3D 0;
+		opt->add_remove(opt, prefix[0], mode, sha1, base, 0);
+		base[baselen] =3D 0;
 	}
 }
=20
-static void skip_uninteresting(struct tree_desc *t, const char *base, =
int baselen, struct diff_options *opt)
+static void skip_uninteresting(struct tree_desc *t, char *base,
+			       int baselen, struct diff_options *opt)
 {
 	int all_interesting =3D 0;
 	while (t->size) {
@@ -166,10 +158,13 @@ static void skip_uninteresting(struct tree_desc *=
t, const char *base, int basele
 	}
 }
=20
-int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *=
base, struct diff_options *opt)
+int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
+	      const char *base_, struct diff_options *opt)
 {
-	int baselen =3D strlen(base);
+	char base[PATH_MAX];
+	int baselen =3D strlen(base_);
=20
+	memcpy(base, base_, baselen+1);
 	for (;;) {
 		if (DIFF_OPT_TST(opt, QUICK) &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
--=20
1.7.3.3.476.g10a82
