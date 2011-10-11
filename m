From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] Convert simple init_pathspec() cases to parse_pathspec()
Date: Wed, 12 Oct 2011 09:44:42 +1100
Message-ID: <1318373083-13840-6-git-send-email-pclouds@gmail.com>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 00:45:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDl4y-00073A-RR
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649Ab1JKWpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 18:45:33 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35345 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab1JKWpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:45:33 -0400
Received: by mail-vx0-f174.google.com with SMTP id gb30so85726vcb.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mGa21EoXSSSSk5UdyI8enBEDsiOpr3bwPu2If55RoLs=;
        b=LDvNIPGsuUL3Pln+l96VJQ7nLODxryXcfYZI8FbCcDTCLhJ4NsmX5TpfMSSwnHqkoq
         f38tHsENwfJvJOL4M5AJftn7UHyoY9lfC1LGEOnBXLgZyQkN6mutVRwJzi0urR+armeI
         2EGw8hMP1xP2Zy1nf2F7S71l29ClS087xKkjo=
Received: by 10.52.35.44 with SMTP id e12mr20311455vdj.108.1318373132843;
        Tue, 11 Oct 2011 15:45:32 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id hl5sm154704vdb.18.2011.10.11.15.45.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 15:45:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 09:45:25 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183339>

These commands can now take advantage of new pathspec magic, if both
tree_entry_interesting() and match_pathspec_depth() support them proper=
ly

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c    |    4 +---
 builtin/ls-tree.c |    2 +-
 builtin/reset.c   |    2 +-
 revision.c        |    9 +++++----
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index a286692..e171a9d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -759,7 +759,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	const char *show_in_pager =3D NULL, *default_pager =3D "dummy";
 	struct grep_opt opt;
 	struct object_array list =3D OBJECT_ARRAY_INIT;
-	const char **paths =3D NULL;
 	struct pathspec pathspec;
 	struct string_list path_list =3D STRING_LIST_INIT_NODUP;
 	int i;
@@ -1020,8 +1019,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 			verify_filename(prefix, argv[j]);
 	}
=20
-	paths =3D get_pathspec(prefix, argv + i);
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, prefix, -1, argv + i);
 	pathspec.max_depth =3D opt.max_depth;
 	pathspec.recursive =3D 1;
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f0fa7dd..b717bb2 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -166,7 +166,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
=20
-	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
+	parse_pathspec(&pathspec, prefix, -1, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
 		pathspec.items[i].magic =3D PATHSPEC_NOGLOB;
 	pathspec.magic |=3D PATHSPEC_NOGLOB;
diff --git a/builtin/reset.c b/builtin/reset.c
index 811e8e2..8126e69 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -176,7 +176,7 @@ static int read_from_tree(const char *prefix, const=
 char **argv,
 	struct diff_options opt;
=20
 	memset(&opt, 0, sizeof(opt));
-	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt=
);
+	parse_pathspec(&opt.pathspec, prefix, -1, argv);
 	opt.output_format =3D DIFF_FORMAT_CALLBACK;
 	opt.format_callback =3D update_index_from_diff;
 	opt.format_callback_data =3D &index_was_discarded;
diff --git a/revision.c b/revision.c
index 9bae329..cba32e8 100644
--- a/revision.c
+++ b/revision.c
@@ -1770,8 +1770,7 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 		 */
 		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
 		prune_data.path[prune_data.nr++] =3D NULL;
-		init_pathspec(&revs->prune_data,
-			      get_pathspec(revs->prefix, prune_data.path));
+		parse_pathspec(&revs->prune_data, revs->prefix, -1, prune_data.path)=
;
 	}
=20
 	if (revs->def =3D=3D NULL)
@@ -1804,12 +1803,14 @@ int setup_revisions(int argc, const char **argv=
, struct rev_info *revs, struct s
 		revs->limited =3D 1;
=20
 	if (revs->prune_data.nr) {
-		diff_tree_setup_paths(revs->prune_data.raw, &revs->pruning);
+		/* Careful, we share a lot of pointers here, do not free 1st arg */
+		memcpy(&revs->pruning.pathspec, &revs->prune_data, sizeof(struct pat=
hspec));
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 			revs->prune =3D 1;
 		if (!revs->full_diff)
-			diff_tree_setup_paths(revs->prune_data.raw, &revs->diffopt);
+			/* Careful, we share a lot of pointers here, do not free 1st arg */
+			memcpy(&revs->diffopt.pathspec, &revs->prune_data, sizeof(struct pa=
thspec));
 	}
 	if (revs->combine_merges)
 		revs->ignore_merges =3D 0;
--=20
1.7.3.1.256.g2539c.dirty
