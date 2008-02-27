From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 8/9] Make setup_git_directory() auto-setup worktree if found
Date: Wed, 27 Feb 2008 23:40:27 +0700
Message-ID: <20080227164027.GA28128@laptop>
References: <cover.1204130175.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 17:41:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUPLH-0002Ep-Pp
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 17:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbYB0Qkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 11:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754359AbYB0Qkh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 11:40:37 -0500
Received: from hs-out-0708.google.com ([64.233.178.244]:31141 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbYB0Qkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 11:40:36 -0500
Received: by hs-out-0708.google.com with SMTP id 54so2759716hsz.5
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=L3Hth9YQ3H90Pp3qQ4AVVTquX/n7iObNuMYFuVqUcv0=;
        b=uOn6C86k32YQZmL/4n3e1fmKLqCSfRi5faGkdVmFUaU7F+ThmAY9ZG/3MJf90hh0/67ivDrz9+hQUOxJvmC8eBpwAsuudbbwslYQy172p83ir8QSmnXiaqXLO2lSunp562n4M6SBo6eyMO5ZHzhNM8qY3bQ1jEXjus/+r9+u0ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=H2oubjN4NbofZO4wn7pvna/NmP98QW4ch9LRjzu2tvl49yW1BpDScIvjTifWMvnc6w3D6YJYigMFpf6lB+fUKLpLxwKwwW6EcFQiGJgKgtGIl5TVo42DVaSpcfAjUarenhQXWWUooPjye1Tx0ZOuA1u05nPQTowNpzxXCBnKBso=
Received: by 10.100.241.17 with SMTP id o17mr7971864anh.74.1204130435497;
        Wed, 27 Feb 2008 08:40:35 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.231])
        by mx.google.com with ESMTPS id p27sm10516607ele.8.2008.02.27.08.40.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 08:40:34 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Feb 2008 23:40:27 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204130175.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75239>

The semantic is simpler: if worktree is found, use it or die.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-ls-files.c  |    4 ++--
 builtin-rev-parse.c |    7 +++++--
 builtin-rm.c        |    5 ++---
 setup.c             |    2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index cf4c492..a53881d 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -566,8 +566,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		break;
 	}
=20
-	if (require_work_tree && !is_inside_work_tree())
-		prefix =3D setup_work_tree(prefix);
+	if (require_work_tree && !get_git_work_tree())
+		die("This operation must be run in a work tree");
 	if (prefix_offset =3D=3D -1)
 		prefix_offset =3D prefix ? strlen(prefix) : 0;
=20
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index e82cac2..384e23f 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -359,15 +359,16 @@ static int cmd_parseopt(int argc, const char **ar=
gv, const char *prefix)
 	return 0;
 }
=20
-int cmd_rev_parse(int argc, const char **argv, const char *prefix)
+int cmd_rev_parse(int argc, const char **argv, const char *unused_pref=
ix)
 {
 	int i, as_is =3D 0, verify =3D 0;
 	unsigned char sha1[20];
+	const char *prefix =3D NULL;
=20
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
=20
-	prefix =3D setup_git_directory();
+	setup_git_directory_gently(NULL);
 	git_config(git_default_config);
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
@@ -487,6 +488,8 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 						printf("%s\n", work_tree);
 					continue;
 				}
+				else
+					pfx =3D prefix =3D setup_work_tree(prefix);
 				while (pfx) {
 					pfx =3D strchr(pfx, '/');
 					if (pfx) {
diff --git a/builtin-rm.c b/builtin-rm.c
index 2c15d66..dedef9f 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -155,10 +155,9 @@ int cmd_rm(int argc, const char **argv, const char=
 *prefix)
 	if (!argc)
 		usage_with_options(builtin_rm_usage, builtin_rm_options);
=20
-	if (!index_only)
-		prefix =3D setup_work_tree(prefix);
-
 	pathspec =3D get_pathspec(prefix, argv);
+	if (!pathspec)
+		die("No valid pathspec");
 	seen =3D NULL;
 	for (i =3D 0; pathspec[i] ; i++)
 		/* nothing */;
diff --git a/setup.c b/setup.c
index 78ae2f9..f0de42f 100644
--- a/setup.c
+++ b/setup.c
@@ -444,5 +444,5 @@ int check_repository_format(void)
 const char *setup_git_directory(void)
 {
 	setup_git_directory_gently(NULL);
-	return is_inside_work_tree() ? setup_work_tree(NULL) : NULL;
+	return get_git_work_tree() ? setup_work_tree(NULL) : NULL;
 }
--=20
1.5.4.2.281.g28d0e
