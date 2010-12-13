From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/19] grep: convert to use struct pathspec
Date: Mon, 13 Dec 2010 16:46:53 +0700
Message-ID: <1292233616-27692-17-git-send-email-pclouds@gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 10:50:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS52j-0005JJ-MX
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab0LMJt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 04:49:56 -0500
Received: from mail-px0-f179.google.com ([209.85.212.179]:39098 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0LMJtz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:49:55 -0500
Received: by mail-px0-f179.google.com with SMTP id 20so1600488pxi.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xerKnfRXwat8O1X/VJVJYKUCYjI9fF1gsu96bvdDU34=;
        b=QGp0iQySFCjyV2POMpRvT2O/ogXFbI8ihpzF7cHdUjUl+O0I9lc0DK1dQbYxFgVd0/
         gMCRn+Iz4T5qjEkghnahwtFmbfWxAr/At8YXERFMFN/esAwIWX6pWAWbAWWtVOm1Ihur
         XT2kj52CsSjBZGfRBNOJJDozg1kJ7KG7dHdgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=M6ucu8cMlzpgewXysSS/317EPTO/g/EmFGD0B1sQeFx7uu7/fgLCb7iZugeaXcV8pD
         G72icptox5d5ZPHBd/IAWU/nil+xH7/CxYM/I6TTa4umn7s161SriMo4vCsjwq/UnBwL
         abbsCdCsxWMxFxhgAgLnoPcmQBWOwZwN2l/UA=
Received: by 10.142.131.7 with SMTP id e7mr3063771wfd.316.1292233793680;
        Mon, 13 Dec 2010 01:49:53 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id v19sm8677640wfh.12.2010.12.13.01.49.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:49:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 13 Dec 2010 16:49:01 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163544>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index da32f3d..4179af8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -585,7 +585,7 @@ static void run_pager(struct grep_opt *opt, const c=
har *prefix)
 	free(argv);
 }
=20
-static int grep_cache(struct grep_opt *opt, const char **paths, int ca=
ched)
+static int grep_cache(struct grep_opt *opt, const struct pathspec *pat=
hspec, int cached)
 {
 	int hit =3D 0;
 	int nr;
@@ -595,7 +595,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached)
 		struct cache_entry *ce =3D active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(paths, ce->name, opt->max_depth))
+		if (!pathspec_matches(pathspec->raw, ce->name, opt->max_depth))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
@@ -622,7 +622,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached)
 	return hit;
 }
=20
-static int grep_tree(struct grep_opt *opt, const char **paths,
+static int grep_tree(struct grep_opt *opt, const struct pathspec *path=
spec,
 		     struct tree_desc *tree,
 		     const char *tree_name, const char *base)
 {
@@ -656,7 +656,7 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
 			strbuf_addch(&pathbuf, '/');
=20
 		down =3D pathbuf.buf + tn_len;
-		if (!pathspec_matches(paths, down, opt->max_depth))
+		if (!pathspec_matches(pathspec->raw, down, opt->max_depth))
 			;
 		else if (S_ISREG(entry.mode))
 			hit |=3D grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
@@ -671,7 +671,7 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
 			init_tree_desc(&sub, data, size);
-			hit |=3D grep_tree(opt, paths, &sub, tree_name, down);
+			hit |=3D grep_tree(opt, pathspec, &sub, tree_name, down);
 			free(data);
 		}
 		if (hit && opt->status_only)
@@ -681,7 +681,7 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
 	return hit;
 }
=20
-static int grep_object(struct grep_opt *opt, const char **paths,
+static int grep_object(struct grep_opt *opt, const struct pathspec *pa=
thspec,
 		       struct object *obj, const char *name)
 {
 	if (obj->type =3D=3D OBJ_BLOB)
@@ -696,14 +696,14 @@ static int grep_object(struct grep_opt *opt, cons=
t char **paths,
 		if (!data)
 			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
 		init_tree_desc(&tree, data, size);
-		hit =3D grep_tree(opt, paths, &tree, name, "");
+		hit =3D grep_tree(opt, pathspec, &tree, name, "");
 		free(data);
 		return hit;
 	}
 	die("unable to grep from object of type %s", typename(obj->type));
 }
=20
-static int grep_objects(struct grep_opt *opt, const char **paths,
+static int grep_objects(struct grep_opt *opt, const struct pathspec *p=
athspec,
 			const struct object_array *list)
 {
 	unsigned int i;
@@ -713,7 +713,7 @@ static int grep_objects(struct grep_opt *opt, const=
 char **paths,
 	for (i =3D 0; i < nr; i++) {
 		struct object *real_obj;
 		real_obj =3D deref_tag(list->objects[i].item, NULL, 0);
-		if (grep_object(opt, paths, real_obj, list->objects[i].name)) {
+		if (grep_object(opt, pathspec, real_obj, list->objects[i].name)) {
 			hit =3D 1;
 			if (opt->status_only)
 				break;
@@ -722,7 +722,7 @@ static int grep_objects(struct grep_opt *opt, const=
 char **paths,
 	return hit;
 }
=20
-static int grep_directory(struct grep_opt *opt, const char **paths)
+static int grep_directory(struct grep_opt *opt, const struct pathspec =
*pathspec)
 {
 	struct dir_struct dir;
 	int i, hit =3D 0;
@@ -730,7 +730,7 @@ static int grep_directory(struct grep_opt *opt, con=
st char **paths)
 	memset(&dir, 0, sizeof(dir));
 	setup_standard_excludes(&dir);
=20
-	fill_directory(&dir, paths);
+	fill_directory(&dir, pathspec->raw);
 	for (i =3D 0; i < dir.nr; i++) {
 		hit |=3D grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
@@ -836,6 +836,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	struct grep_opt opt;
 	struct object_array list =3D OBJECT_ARRAY_INIT;
 	const char **paths =3D NULL;
+	struct pathspec pathspec;
 	struct string_list path_list =3D STRING_LIST_INIT_NODUP;
 	int i;
 	int dummy;
@@ -1063,6 +1064,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		paths[0] =3D prefix;
 		paths[1] =3D NULL;
 	}
+	init_pathspec(&pathspec, paths);
=20
 	if (show_in_pager && (cached || list.nr))
 		die("--open-files-in-pager only works on the worktree");
@@ -1093,16 +1095,16 @@ int cmd_grep(int argc, const char **argv, const=
 char *prefix)
 			die("--cached cannot be used with --no-index.");
 		if (list.nr)
 			die("--no-index cannot be used with revs.");
-		hit =3D grep_directory(&opt, paths);
+		hit =3D grep_directory(&opt, &pathspec);
 	} else if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
=20
-		hit =3D grep_cache(&opt, paths, cached);
+		hit =3D grep_cache(&opt, &pathspec, cached);
 	} else {
 		if (cached)
 			die("both --cached and trees are given.");
-		hit =3D grep_objects(&opt, paths, &list);
+		hit =3D grep_objects(&opt, &pathspec, &list);
 	}
=20
 	if (use_threads)
--=20
1.7.3.3.476.g10a82
