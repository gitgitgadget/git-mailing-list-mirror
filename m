From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 09/45] Convert some get_pathspec() calls to parse_pathspec()
Date: Fri, 15 Mar 2013 13:06:24 +0700
Message-ID: <1363327620-29017-10-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:25:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5C-0004VB-E6
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab3COGZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:25:07 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:36334 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3COGZE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:25:04 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so2934427iae.11
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=dkWcxY9Jzmu8bTvozy2eEX02ftaoYdanEz6PMMn0FBY=;
        b=UI4pUb0ZMgnkUA0yDeuLKHKZjb7ICmix71ygD4QnHCukwM3Lm79LAsA1q3+wdgrgI3
         HeodzT47wQrsRRq8noZnev8YsiukJjSD2HJ3b9hL3YyrOuhyKRf80QBO78QpTYQQK2BX
         wkm9JTw7TvmU7umlBnwRlCXiAThGd8Wdmw1bltyH2jeh0mDZ+KbUrIBtwPluJ4KgTxPn
         aTQwvAtrCGnuilnvDZBtR3mLTjsQXJ6BM1vbAbWj9g81BqMSchteS807cEO977/YhKBz
         OfM5dCdNW9BvPokH53SA1zkKpbg9fpPjIha/NdBXvBvYyQ7maFF9g5+R7gX7ThtUNrIF
         s1SQ==
X-Received: by 10.50.47.202 with SMTP id f10mr381084ign.8.1363328704056;
        Thu, 14 Mar 2013 23:25:04 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id vb15sm732691igb.9.2013.03.14.23.25.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:25:03 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:08:06 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218196>

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
index 3701c2e..54b089e 100644
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
@@ -860,8 +859,9 @@ int cmd_grep(int argc, const char **argv, const cha=
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
index ffae585..3c6905d 100644
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
index ef60205..e257614 100644
--- a/revision.c
+++ b/revision.c
@@ -1852,8 +1852,8 @@ int setup_revisions(int argc, const char **argv, =
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
1.8.0.rc0.19.g7bbb31d
