From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 29/45] checkout: convert read_tree_some to take struct pathspec
Date: Fri, 15 Mar 2013 13:06:44 +0700
Message-ID: <1363327620-29017-30-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:27:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO7M-0006uH-99
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab3COG1Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:27:25 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38067 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab3COG1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:27:24 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so4018394ied.30
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=BxjYYqLHqzO+fAQacJjijidYiqGyu+yFhO10CfJGC1o=;
        b=rioKpcWKtMeSUqSq0pB32PPFZ4Kf+o/06qrTVIAR4CxuVmKsWCX6F0sQsiUvUs965Z
         g9FQ7pglLDSVPcFYVq+mp7ho/etSCD6uD0rGb46VvPpEWN0pZRmNIhXpsjgPbZGlW1Yr
         j1An7fcVLfRr56lVtBJdQNfHlOdb/faOdF+r7P2KXKmdeuEB0BprViCZxOdvWQ44FLAE
         M4NRFDnwlcrmtax4uR4EolRDZv5fF6fvl1fSW24o9cSxoarAdWA1Glzu4sGdjDb61VhZ
         q+0ngyTUdPKY3htHq+xruW/SgO5LajeAFOkToAwL1P4ZY1fdvMOCbrNU9RdoMrf2aNGb
         /N4w==
X-Received: by 10.50.56.236 with SMTP id d12mr22797281igq.92.1363328844432;
        Thu, 14 Mar 2013 23:27:24 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ip2sm620275igc.5.2013.03.14.23.27.21
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:27:23 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:10:27 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218216>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 9 +++------
 tree.c             | 4 ++--
 tree.h             | 2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ba5a5c0..132bfe6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -82,12 +82,9 @@ static int update_some(const unsigned char *sha1, co=
nst char *base, int baselen,
 	return 0;
 }
=20
-static int read_tree_some(struct tree *tree, const char **pathspec)
+static int read_tree_some(struct tree *tree, const struct pathspec *pa=
thspec)
 {
-	struct pathspec ps;
-	init_pathspec(&ps, pathspec);
-	read_tree_recursive(tree, "", 0, 0, &ps, update_some, NULL);
-	free_pathspec(&ps);
+	read_tree_recursive(tree, "", 0, 0, pathspec, update_some, NULL);
=20
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
@@ -265,7 +262,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		return error(_("corrupt index file"));
=20
 	if (opts->source_tree)
-		read_tree_some(opts->source_tree, opts->pathspec.raw);
+		read_tree_some(opts->source_tree, &opts->pathspec);
=20
 	ps_matched =3D xcalloc(1, opts->pathspec.nr);
=20
diff --git a/tree.c b/tree.c
index 62fed63..ff72f67 100644
--- a/tree.c
+++ b/tree.c
@@ -47,7 +47,7 @@ static int read_one_entry_quick(const unsigned char *=
sha1, const char *base, int
 }
=20
 static int read_tree_1(struct tree *tree, struct strbuf *base,
-		       int stage, struct pathspec *pathspec,
+		       int stage, const struct pathspec *pathspec,
 		       read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
@@ -116,7 +116,7 @@ static int read_tree_1(struct tree *tree, struct st=
rbuf *base,
=20
 int read_tree_recursive(struct tree *tree,
 			const char *base, int baselen,
-			int stage, struct pathspec *pathspec,
+			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb =3D STRBUF_INIT;
diff --git a/tree.h b/tree.h
index 69bcb5e..9dc90ba 100644
--- a/tree.h
+++ b/tree.h
@@ -25,7 +25,7 @@ typedef int (*read_tree_fn_t)(const unsigned char *, =
const char *, int, const ch
=20
 extern int read_tree_recursive(struct tree *tree,
 			       const char *base, int baselen,
-			       int stage, struct pathspec *pathspec,
+			       int stage, const struct pathspec *pathspec,
 			       read_tree_fn_t fn, void *context);
=20
 extern int read_tree(struct tree *tree, int stage, struct pathspec *pa=
thspec);
--=20
1.8.0.rc0.19.g7bbb31d
