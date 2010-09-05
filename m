From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/17] pathspec retrieval fix
Date: Sun,  5 Sep 2010 16:47:38 +1000
Message-ID: <1283669264-15759-12-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:50:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os93F-0008LL-EO
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab0IEGt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:49:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53862 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab0IEGt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:49:56 -0400
Received: by pvg2 with SMTP id 2so1071800pvg.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uS1V/npSRwEFvx9i3zqZyicBQwsxJ42FJalHgkBWZeU=;
        b=rLgPyRcZY/2Hx2g4HpiIOHNrul/t3qiVMXw+pZufHLurxYZf1V+DS1rnw0CQzbXfbh
         Bsga7IMHy67iXpNu8Wzy3Z6/Jmpu/M7jCopQnSJA4y8Muyc97tAxJlmR64Jy4V5z4bRJ
         zrcLHCX0qn4X2CAocTOz2GWZpMLvn4zNgwQDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fzROpqLMIy0kuFPK6zKWAsJCHm3ShaXQ8LuqigQCw60X8rlhwZLw+yKpvei9PbZlxG
         dzY010INBbMOPHfkOllr37ZMPRmmKBZZoqQEsS48qDXjDjiJhus7DcnZ0oU9nmB0FlNa
         /qY/3tMif7GdMiQ7nSbmx8VvG16LJ1ubPTFfE=
Received: by 10.114.112.6 with SMTP id k6mr1828610wac.194.1283669395903;
        Sat, 04 Sep 2010 23:49:55 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id d2sm8034138wam.14.2010.09.04.23.49.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:49:55 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:49:47 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155437>

In normal repos, when there is no command line argument, it's safe to
say we don't have pathspec. In narrow repos, get_pathspec() in that
case will still generate some pathspecs (the narrow prefix). Make sure
get_pathspec() is always called.

Some commands however, especially plumbings, won't want narrow prefix
to get in the way. Use get_pathspec_narrow(...., 0); in those cases to
disable narrow pathspec rewriting.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c   |    6 ++----
 builtin/grep.c     |    5 ++---
 builtin/ls-files.c |    2 +-
 builtin/ls-tree.c  |    2 +-
 builtin/reset.c    |    3 +--
 revision.c         |    5 +++++
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..d8c5273 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -303,8 +303,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		return get_index_file();
 	}
=20
-	if (*argv)
-		pathspec =3D get_pathspec(prefix, argv);
+	pathspec =3D get_pathspec(prefix, argv);
=20
 	if (read_cache_preload(pathspec) < 0)
 		die("index file corrupt");
@@ -1083,8 +1082,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
 		s.show_ignored_files =3D 1;
-	if (*argv)
-		s.pathspec =3D get_pathspec(prefix, argv);
+	s.pathspec =3D get_pathspec(prefix, argv);
=20
 	read_cache_preload(s.pathspec);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec,=
 NULL, NULL);
diff --git a/builtin/grep.c b/builtin/grep.c
index cf6c29f..b55a0a4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1058,9 +1058,8 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 			verify_filename(prefix, argv[j]);
 	}
=20
-	if (i < argc)
-		paths =3D get_pathspec(prefix, argv + i);
-	else if (prefix) {
+	paths =3D get_pathspec(prefix, argv + i);
+	if (prefix && !paths) {
 		paths =3D xcalloc(2, sizeof(const char *));
 		paths[0] =3D prefix;
 		paths[1] =3D NULL;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bb4f612..27610ab 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -565,7 +565,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
-	pathspec =3D get_pathspec(prefix, argv);
+	pathspec =3D get_pathspec_narrow(prefix, argv, 0);
=20
 	/* be nice with submodule paths ending in a slash */
 	if (pathspec)
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index dc86b0d..d37eaa5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -164,7 +164,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
=20
-	pathspec =3D get_pathspec(prefix, argv + 1);
+	pathspec =3D get_pathspec_narrow(prefix, argv + 1, 0);
 	tree =3D parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
diff --git a/builtin/reset.c b/builtin/reset.c
index 1283068..ae96c8b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -181,8 +181,7 @@ static int interactive_reset(const char *revision, =
const char **argv,
 {
 	const char **pathspec =3D NULL;
=20
-	if (*argv)
-		pathspec =3D get_pathspec(prefix, argv);
+	pathspec =3D get_pathspec(prefix, argv);
=20
 	return run_add_interactive(revision, "--patch=3Dreset", pathspec);
 }
diff --git a/revision.c b/revision.c
index ea64970..73fe894 100644
--- a/revision.c
+++ b/revision.c
@@ -1625,6 +1625,11 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, struct s
=20
 	if (prune_data)
 		revs->prune_data =3D get_pathspec(revs->prefix, prune_data);
+	else if (get_narrow_prefix()) {
+		const char *nul =3D NULL;
+		prune_data =3D &nul;
+		revs->prune_data =3D get_pathspec(revs->prefix, prune_data);
+	}
=20
 	if (revs->def =3D=3D NULL)
 		revs->def =3D opt ? opt->def : NULL;
--=20
1.7.1.rc1.69.g24c2f7
