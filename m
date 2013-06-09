From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/45] Convert some get_pathspec() calls to parse_pathspec()
Date: Sun,  9 Jun 2013 13:25:41 +0700
Message-ID: <1370759178-1709-9-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:25:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ4X-0008Lu-1l
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab3FIGZp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:25:45 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:43048 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab3FIGZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:25:44 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so6120181pbc.12
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2d8IXlNXplXD7WeZ6wv9fv1WE+6CJU/9ilQBWCr/lN4=;
        b=gPGv0lhC8KzKSZpP+xwS0xj0k9dtjA9wO7ajSrKdTzJ8trcV3mbErvWVp5qZ+ejTHq
         YfVZfqIWWoFJ7l2dPzTMuuAbgMrzhJouaPrWOHx7xFe0ycYocWYL0n66bm5fiNLx5MCb
         oTACwyuTF8SSmRp/iFykgSZICxwhCSM9/IePKv4Lt4BShAqiqL3bXlBrYEmAlNqky0g+
         ObfhJgZESOBN1jdGYA1P1T9gXc01yZDisgn7w8jS1+zyqnAK5oO83yHq2/PM2yQm6vBn
         kNr+IApN/rN4a/pBlDE7WfZ7v05ZgBU5qVNItxeZQZuHaQf4aRvWna5uDJhrk4Wnewjl
         o0gQ==
X-Received: by 10.68.43.197 with SMTP id y5mr5079064pbl.140.1370759144014;
        Sat, 08 Jun 2013 23:25:44 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id nk2sm5477987pbc.43.2013.06.08.23.25.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:25:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:27:14 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226900>

These call sites follow the pattern:

   paths =3D get_pathspec(prefix, argv);
   init_pathspec(&pathspec, paths);

which can be converted into a single parse_pathspec() call.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c         |  6 +++---
 builtin/ls-tree.c      | 10 +++++++++-
 builtin/update-index.c |  5 +++--
 revision.c             |  4 ++--
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4de49df..1a6c028 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -631,7 +631,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	const char *show_in_pager =3D NULL, *default_pager =3D "dummy";
 	struct grep_opt opt;
 	struct object_array list =3D OBJECT_ARRAY_INIT;
-	const char **paths =3D NULL;
 	struct pathspec pathspec;
 	struct string_list path_list =3D STRING_LIST_INIT_NODUP;
 	int i;
@@ -858,8 +857,9 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			verify_filename(prefix, argv[j], j =3D=3D i);
 	}
=20
-	paths =3D get_pathspec(prefix, argv + i);
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD,
+		       prefix, argv + i);
 	pathspec.max_depth =3D opt.max_depth;
 	pathspec.recursive =3D 1;
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 93fc3a0..bdb03f3 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -167,7 +167,15 @@ int cmd_ls_tree(int argc, const char **argv, const=
 char *prefix)
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
=20
-	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
+	/*
+	 * show_recursive() rolls its own matching code and is
+	 * generally ignorant of 'struct pathspec'. The magic mask
+	 * cannot be lifted until it is converted to use
+	 * match_pathspec_depth() or tree_entry_interesting()
+	 */
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD,
+		       prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len =3D pathspec.items[i].len;
 	pathspec.has_wildcard =3D 0;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b9c2bd0..e795818 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -547,10 +547,11 @@ static int do_reupdate(int ac, const char **av,
 	 */
 	int pos;
 	int has_head =3D 1;
-	const char **paths =3D get_pathspec(prefix, av + 1);
 	struct pathspec pathspec;
=20
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD,
+		       prefix, av + 1);
=20
 	if (read_ref("HEAD", head_sha1))
 		/* If there is no HEAD, that means it is an initial
diff --git a/revision.c b/revision.c
index 518cd08..f9185d4 100644
--- a/revision.c
+++ b/revision.c
@@ -1871,8 +1871,8 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 		 */
 		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
 		prune_data.path[prune_data.nr++] =3D NULL;
-		init_pathspec(&revs->prune_data,
-			      get_pathspec(revs->prefix, prune_data.path));
+		parse_pathspec(&revs->prune_data, 0, 0,
+			       revs->prefix, prune_data.path);
 	}
=20
 	if (revs->def =3D=3D NULL)
--=20
1.8.2.83.gc99314b
