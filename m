From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 08/10] Make setup_git_directory() auto-setup worktree if
	found
Date: Sun, 2 Mar 2008 17:35:01 +0700
Message-ID: <20080302103501.GA8996@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:35:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlXu-0003Xn-5e
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbYCBKfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbYCBKfR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:35:17 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:54970 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYCBKfP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:35:15 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2353724gve.37
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=xljgUG7FXSK7eAEYbPyeK4FiyfPm2YIQ5jxPl7UNHOo=;
        b=YrU2tQ4cuy4IIZPM9GtWkJftmzK0fa64Gt5zCL20tsmbOtBouNi8j29fUMDhLdtZsckLtjqWWOK4auM7Mr8x5Lsc0AVfXjGnTI8889HQrZfPFZ4lFFaYt7XrPT7pXqdfQuCsl43qzNGCf4d1iVUJPJTQuh/jurdf3v5NcC6xwiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=Eme5pUPa0lsj4EdWesvSrXR5sAnCaOSMFddadTFvTblfcoixEPIng6T3OzTgnJH28Ilx6KfdYo9NvU2G/8LSrrqR85nQ1PO4PMLwjUZeE6Vk2waxu5LQdtiGJJRykYMiqWd65BfeoTvBOfwOHfDNDnHlFtxSa5cSdQi3lKAqj3s=
Received: by 10.114.209.1 with SMTP id h1mr539358wag.130.1204454113747;
        Sun, 02 Mar 2008 02:35:13 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id l22sm23152235waf.10.2008.03.02.02.35.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:35:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:35:01 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75768>

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
index 3d3a309..5016890 100644
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
