From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] archive: use index instead of parsing tree directly
Date: Wed,  8 Apr 2009 20:05:31 +1000
Message-ID: <1239185133-4181-7-git-send-email-pclouds@gmail.com>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
 <1239185133-4181-4-git-send-email-pclouds@gmail.com>
 <1239185133-4181-5-git-send-email-pclouds@gmail.com>
 <1239185133-4181-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 12:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUjG-0005yX-Co
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763884AbZDHKHS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 06:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761697AbZDHKHR
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:07:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:44704 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757405AbZDHKHO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:07:14 -0400
Received: by rv-out-0506.google.com with SMTP id f9so37692rvb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ncICcL/I2NTTywwQVHGqZaBDKcA58D6JclDoWKo6TYg=;
        b=KwRLSb6gdoCP32VLAv4YO4c5VPCKlleh80fApZhyAGHrVrTeJx2N6fbzfzq2XFhowM
         yVXqcrSz0msVCroRIU00PmNlJaaHEMf2dLZa0kPHomcPwL8cTmD1mfJUbfhQoXGcr4o1
         XfybFE9yQYpCUfs/gOfL1CKcpGZkzJhLfsf3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OOW3bgdYMeXXHMw7YdTVz+l3vI91ITXD/rUZBbofOpPgAwKuVJV8hGb49D3IrKBnSW
         ij4Y4AAnHANQa18MVlUh6Ci6FbgNrCqwLS5SChP+OtcECbTizA6DP67HHy+WgrLDoxjt
         NvqydV73AWqb/scv0KFMiWdazFKOwsWgKohKM=
Received: by 10.140.165.17 with SMTP id n17mr461570rve.248.1239185234209;
        Wed, 08 Apr 2009 03:07:14 -0700 (PDT)
Received: from dektop ([121.91.216.142])
        by mx.google.com with ESMTPS id k41sm24879560rvb.16.2009.04.08.03.07.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:07:13 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Apr 2009 20:07:08 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239185133-4181-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116071>

Currently:

 - "git archive" parses trees directly
 - attr mechanism does not support in-tree attributes

Making attr.c support in-tree attributes is quite a non-trivial task,
IMHO. Instead this patch makes "git archive" read tree to index first,
then start exporting from there.

One minor regression: "git archive" now will no longer generate
directory entries, only files.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c               |   66 ++++++++++++++++++++++++++++++++-------=
--------
 t/t0024-crlf-archive.sh |    2 -
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/archive.c b/archive.c
index 5b54d95..402f6d4 100644
--- a/archive.c
+++ b/archive.c
@@ -4,6 +4,8 @@
 #include "attr.h"
 #include "archive.h"
 #include "parse-options.h"
+#include "unpack-trees.h"
+#include "dir.h"
=20
 static char const * const archive_usage[] =3D {
 	"git archive [options] <tree-ish> [path...]",
@@ -167,7 +169,9 @@ int write_archive_entries(struct archiver_args *arg=
s,
 		write_archive_entry_fn_t write_entry)
 {
 	struct archiver_context context;
-	int err;
+	struct unpack_trees_options opts;
+	struct tree_desc t;
+	int i, prefix_len, err;
=20
 	if (args->baselen > 0 && args->base[args->baselen - 1] =3D=3D '/') {
 		size_t len =3D args->baselen;
@@ -185,11 +189,42 @@ int write_archive_entries(struct archiver_args *a=
rgs,
 	context.args =3D args;
 	context.write_entry =3D write_entry;
=20
-	err =3D  read_tree_recursive(args->tree, args->base, args->baselen, 0=
,
-			args->pathspec, write_archive_entry, &context);
-	if (err =3D=3D READ_TREE_RECURSIVE)
-		err =3D 0;
-	return err;
+	memset(&opts, 0, sizeof(opts));
+	opts.index_only =3D 1;
+	opts.head_idx =3D -1;
+	opts.src_index =3D &the_index;
+	opts.dst_index =3D &the_index;
+	opts.fn =3D oneway_merge;
+	init_tree_desc(&t, args->tree->buffer, args->tree->size);
+	if (unpack_trees(1, &t, &opts))
+		return -1;
+	prefix_len =3D common_prefix(args->pathspec);
+	if (prefix_len)
+		prune_cache(args->pathspec[0], prefix_len);
+
+	for (i =3D 0;i < active_nr;i++) {
+		struct cache_entry *ce =3D active_cache[i];
+		const char **path;
+		const char *str, *prefix;
+		int match =3D 0;
+
+		if (!args->pathspec || !args->pathspec[0] || !*args->pathspec[0])
+			match =3D 1;
+
+		/* It's not really pathspec, so match_pathspec can't be used */
+		for (path =3D args->pathspec;!match && *path;path++) {
+			for (str =3D ce->name, prefix =3D *path;*prefix && *str =3D=3D *pre=
fix; str++, prefix++)
+				;
+			if (!*prefix && *str =3D=3D '/')
+				match =3D 1;
+		}
+
+		if (match)
+			write_archive_entry(ce->sha1, args->base, args->baselen,
+					    ce->name, ce->ce_mode, ce_stage(ce),
+					    &context);
+	}
+	return 0;
 }
=20
 static const struct archiver *lookup_archiver(const char *name)
@@ -207,9 +242,10 @@ static const struct archiver *lookup_archiver(cons=
t char *name)
 }
=20
 static void parse_pathspec_arg(const char **pathspec,
-		struct archiver_args *ar_args)
+			       struct archiver_args *ar_args,
+			       const char *prefix)
 {
-	ar_args->pathspec =3D get_pathspec(ar_args->base, pathspec);
+	ar_args->pathspec =3D get_pathspec(prefix, pathspec);
 }
=20
 static void parse_treeish_arg(const char **argv,
@@ -238,18 +274,6 @@ static void parse_treeish_arg(const char **argv,
 	if (tree =3D=3D NULL)
 		die("not a tree object");
=20
-	if (prefix) {
-		unsigned char tree_sha1[20];
-		unsigned int mode;
-		int err;
-
-		err =3D get_tree_entry(tree->object.sha1, prefix,
-				     tree_sha1, &mode);
-		if (err || !S_ISDIR(mode))
-			die("current working directory is untracked");
-
-		tree =3D parse_tree_indirect(tree_sha1);
-	}
 	ar_args->tree =3D tree;
 	ar_args->commit_sha1 =3D commit_sha1;
 	ar_args->commit =3D commit;
@@ -356,7 +380,7 @@ int write_archive(int argc, const char **argv, cons=
t char *prefix,
 		prefix =3D setup_git_directory();
=20
 	parse_treeish_arg(argv, &args, prefix);
-	parse_pathspec_arg(argv + 1, &args);
+	parse_pathspec_arg(argv + 1, &args, prefix);
=20
 	git_config(git_default_config, NULL);
=20
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index 695ad5a..1cbe511 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -21,7 +21,6 @@ test_expect_success setup '
=20
 cat <<\EOF > expected
 sample
-sub/
 sub/sample
 EOF
=20
@@ -31,7 +30,6 @@ test_expect_success 'archive without subdir' '
 '
=20
 cat <<\EOF > expected
-sub/
 sub/sample
 EOF
=20
--=20
1.6.2.2.602.g83ee9f
