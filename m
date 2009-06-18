From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [RFC/PATCH 1/2] remote tracking: return the tracking branch for the given branches
Date: Thu, 18 Jun 2009 09:57:12 +0200
Message-ID: <1245311834-5290-2-git-send-email-santi@agolina.net>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 09:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCUa-00026h-Lj
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 09:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbZFRH44 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 03:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756074AbZFRH44
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 03:56:56 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:37467 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbZFRH4z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 03:56:55 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so868030bwz.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 00:56:57 -0700 (PDT)
Received: by 10.103.167.14 with SMTP id u14mr847890muo.38.1245311817571;
        Thu, 18 Jun 2009 00:56:57 -0700 (PDT)
Received: from localhost (p5B0D73A2.dip.t-dialin.net [91.13.115.162])
        by mx.google.com with ESMTPS id u26sm258567mug.22.2009.06.18.00.56.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 00:56:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.406.gd6a466
In-Reply-To: <1245311834-5290-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121801>

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/git-remote.txt |    7 +++++++
 builtin-remote.c             |   35 ++++++++++++++++++++++++++++++++++=
+
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index 9e2b4ea..e444899 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
 'git remote update' [-p | --prune] [group | remote]...
+'git remote tracking' <name> <branch>...
=20
 DESCRIPTION
 -----------
@@ -128,6 +129,12 @@ be updated.  (See linkgit:git-config[1]).
 +
 With `--prune` option, prune all the remotes that are updated.
=20
+'tracking'::
+
+Returns the tracking branch for the given remote (<name>) and branch
+(<branch>). Note that <branch> must exactly match the left hand side o=
f
+the refspec of the given remote.
+
=20
 DISCUSSION
 ----------
diff --git a/builtin-remote.c b/builtin-remote.c
index 709f8a6..bb8e73b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -16,6 +16,7 @@ static const char * const builtin_remote_usage[] =3D =
{
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [-p | --prune] [group]",
+	"git remote tracking <name> <branch>...",
 	NULL
 };
=20
@@ -665,6 +666,38 @@ static int remove_branches(struct string_list *bra=
nches)
 	return result;
 }
=20
+static int tracking(int argc, const char **argv)
+{
+	struct option options[] =3D {
+		OPT_END()
+	};
+	struct remote *remote;
+	static const char **refs =3D NULL;
+	int ref_nr =3D 0;
+	int i =3D 0;
+	struct refspec *refspec;
+
+	if (argc < 3)
+		usage_with_options(builtin_remote_usage, options);
+	remote =3D remote_get(argv[1]);
+	if (!remote)
+		die("No such remote: %s", argv[1]);
+	refs =3D xcalloc(argc + 1, sizeof(const char *));
+	for (i =3D 2; i < argc; i++) {
+		refs[ref_nr++] =3D argv[i];
+	}
+	refs[ref_nr] =3D NULL;
+	memset(&refspec, 0, sizeof(*refspec));
+	refspec =3D parse_fetch_refspec(ref_nr, refs);
+	for (i =3D 0; i < ref_nr ; i++) {
+		if (!remote_find_tracking(remote, &refspec[i]))
+			printf("%s\n", refspec[i].dst);
+		else
+			return 1;
+	}
+	return 0;
+}
+
 static int rm(int argc, const char **argv)
 {
 	struct option options[] =3D {
@@ -1348,6 +1381,8 @@ int cmd_remote(int argc, const char **argv, const=
 char *prefix)
 		result =3D show_all();
 	else if (!strcmp(argv[0], "add"))
 		result =3D add(argc, argv);
+	else if (!strcmp(argv[0], "tracking"))
+		result =3D tracking(argc, argv);
 	else if (!strcmp(argv[0], "rename"))
 		result =3D mv(argc, argv);
 	else if (!strcmp(argv[0], "rm"))
--=20
1.6.3.2.406.gd6a466
