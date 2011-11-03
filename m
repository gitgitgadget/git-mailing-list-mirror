From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] log: allow to specify diff pathspec in addition to prune pathspec
Date: Thu,  3 Nov 2011 19:15:56 +0700
Message-ID: <1320322556-32675-1-git-send-email-pclouds@gmail.com>
References: <1320314474-19536-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 13:17:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLwEW-00039B-AO
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 13:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933143Ab1KCMRT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 08:17:19 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36559 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933084Ab1KCMRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 08:17:18 -0400
Received: by qyk27 with SMTP id 27so289087qyk.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=A7/jVMWzTCZPyGUkI/2kxA8+k7n5ihRDN5jo3ujrn+A=;
        b=Tz0mMy33wK3NJ1YLr2RtIS9hrQmonewKEZL3Zw75osvIkq8C/YcEUDFlYCalUGOc9b
         NpcpruV5wrnedWN7g/N8AjpXM71EiqjjJwstk28F3hxWd0p/35HNImoshvGUr6eVaoX/
         4tv03HPAdq/F2TklwcAhw/1kv9xKCEV+rGapk=
Received: by 10.50.156.230 with SMTP id wh6mr3614717igb.17.1320322636998;
        Thu, 03 Nov 2011 05:17:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.206.47])
        by mx.google.com with ESMTPS id hz1sm4284858igc.5.2011.11.03.05.17.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Nov 2011 05:17:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 Nov 2011 19:15:57 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320314474-19536-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184717>

Pathspec in "git log -p <pathspec>" is used for both commit pruning
and diff generation. If --full-diff is given, then diff pathspec is
reset to generate complete diff.

This patch gives more control to diff generation. The first pathspec
in "git log -p -- <pathspec> -- <pathspec>" is used as commit pruning
as usual. The second one is used for diff generation. So --full-diff
now is essentially "git log -p -- <pathspec> --".

This form requires specifying "--" twice. If a file name happens to be
"--", it may be misunderstood as the second "--" marker. This is an
unfortunate consequence for this syntax. Users can still use "./--" or
similar to workaround this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Version 2. Now it looks more acceptable.

 Documentation/git-log.txt |    9 +++++++--
 revision.c                |   28 +++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 249fc87..8e00dbc 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,7 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 [verse]
-'git log' [<options>] [<since>..<until>] [[\--] <path>...]
+'git log' [<options>] [<since>..<until>] [[\--] <path>... [\-- <path>.=
=2E.]]
=20
 DESCRIPTION
 -----------
@@ -52,11 +52,12 @@ OPTIONS
 	commit was reached.
=20
 --full-diff::
-	Without this flag, "git log -p <path>..." shows commits that
+	Without this flag, `git log -p <path>...` shows commits that
 	touch the specified paths, and diffs about the same specified
 	paths.  With this, the full diff is shown for commits that touch
 	the specified paths; this means that "<path>..." limits only
 	commits, and doesn't limit diff for those commits.
+	It is equivalent to `git log -p \-- <path>... \--`.
 +
 Note that this affects all diff-based output types, e.g. those
 produced by --stat etc.
@@ -76,6 +77,10 @@ produced by --stat etc.
 +
 To prevent confusion with options and branch names, paths may need to
 be prefixed with "\-- " to separate them from options or refnames.
++
+If the second "\--" is found, the following pathspec is used to limit
+diff generation. Note that this affects all diff-based output types,
+e.g. those produced by --stat etc.
=20
 include::rev-list-options.txt[]
=20
diff --git a/revision.c b/revision.c
index 8764dde..f560647 100644
--- a/revision.c
+++ b/revision.c
@@ -1682,20 +1682,37 @@ static int handle_revision_pseudo_opt(const cha=
r *submodule,
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs=
, struct setup_revision_opt *opt)
 {
-	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg =3D 0=
;
+	int i, flags, left, read_from_stdin, got_rev_arg =3D 0;
+	int seen_dashdash, seen_second_dashdash;
 	struct cmdline_pathspec prune_data;
+	struct cmdline_pathspec diff_data;
 	const char *submodule =3D NULL;
=20
 	memset(&prune_data, 0, sizeof(prune_data));
+	memset(&diff_data, 0, sizeof(diff_data));
 	if (opt)
 		submodule =3D opt->submodule;
=20
 	/* First, search for "--" */
-	seen_dashdash =3D 0;
+	seen_dashdash =3D seen_second_dashdash =3D 0;
 	for (i =3D 1; i < argc; i++) {
+		int i2;
 		const char *arg =3D argv[i];
 		if (strcmp(arg, "--"))
 			continue;
+
+		/* Search for second "--" */
+		for (i2 =3D i + 1; i2 < argc; i2++) {
+			const char *arg =3D argv[i2];
+			if (strcmp(arg, "--"))
+				continue;
+			argv[i2] =3D NULL;
+			if (argv[i2 + 1])
+				append_prune_data(&diff_data, argv + i2 + 1);
+			seen_second_dashdash =3D 1;
+			break;
+		}
+
 		argv[i] =3D NULL;
 		argc =3D i;
 		if (argv[i + 1])
@@ -1817,7 +1834,12 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, struct s
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 			revs->prune =3D 1;
-		if (!revs->full_diff)
+		if (seen_second_dashdash) {
+			ALLOC_GROW(diff_data.path, diff_data.nr+1, diff_data.alloc);
+			diff_data.path[diff_data.nr++] =3D NULL;
+			diff_tree_setup_paths(diff_data.path, &revs->diffopt);
+		}
+		else if (!revs->full_diff)
 			diff_tree_setup_paths(revs->prune_data.raw, &revs->diffopt);
 	}
 	if (revs->combine_merges)
--=20
1.7.4.74.g639db
