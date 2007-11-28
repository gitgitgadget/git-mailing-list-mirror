From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Do check_repository_format() early
Date: Wed, 28 Nov 2007 23:58:37 +0700
Message-ID: <20071128165837.GA5903@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 17:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQFa-0008IR-Ta
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761497AbXK1Q6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 11:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757148AbXK1Q6o
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:58:44 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:46987 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704AbXK1Q6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:58:43 -0500
Received: by an-out-0708.google.com with SMTP id d31so313766and
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 08:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=68AemYiaRIlLlW+svMyAldBeRDW5pdOA7Lce0GUABdw=;
        b=CP5peh+Ls1ZCWGh9ZjBwI8Eyi8Nc3d5NppzZ59iQAgmnkmfp/GgNMXPwS+5tFtU3yr6Ov977WMjwhz+CKe6q3ckEnwAfROtMlPcDY754susxU8yykUhDm9FgR8U+ydMlwN4iHcK/lgRGJwg+rHiR9Kt7kCcIqkUkd0SUji6T2oM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=DD5MPG3sNZWL1Glad8rj1gI0ooGtNTe4l0dAJqDzko1FG9+HNI77HLf0Lrmvbycy5hUJs0Ad5duGJTDt3H7b8//DKHT4WHDBp3F/rMoAi4gqHw4Py5ldQSXOkIJELZIGerZTSfc+3iVLoVzWHneAMYYbG0u0t8BC2RzwC//b26M=
Received: by 10.101.71.16 with SMTP id y16mr9415114ank.1196269122753;
        Wed, 28 Nov 2007 08:58:42 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.8])
        by mx.google.com with ESMTPS id b19sm2119414ana.2007.11.28.08.58.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2007 08:58:41 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 28 Nov 2007 23:58:37 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66383>

Repository version check is only performed when
setup_git_directory() is called. This makes sure
setup_git_directory_gently() does the check too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 My worktree work still not done yet, so push this first.

 setup.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index faf4137..19a8a77 100644
--- a/setup.c
+++ b/setup.c
@@ -246,8 +246,13 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 			static char buffer[1024 + 1];
 			const char *retval;
=20
-			if (!work_tree_env)
-				return set_work_tree(gitdirenv);
+			if (!work_tree_env) {
+				retval =3D set_work_tree(gitdirenv);
+				/* config may override worktree */
+				check_repository_format();
+				return retval;
+			}
+			check_repository_format();
 			retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
 					get_git_work_tree());
 			if (!retval || !*retval)
@@ -287,6 +292,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
 			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			check_repository_format();
 			return NULL;
 		}
 		chdir("..");
@@ -307,6 +313,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	if (!work_tree_env)
 		inside_work_tree =3D 1;
 	git_work_tree_cfg =3D xstrndup(cwd, offset);
+	check_repository_format();
 	if (offset =3D=3D len)
 		return NULL;
=20
@@ -367,7 +374,6 @@ int check_repository_format(void)
 const char *setup_git_directory(void)
 {
 	const char *retval =3D setup_git_directory_gently(NULL);
-	check_repository_format();
=20
 	/* If the work tree is not the default one, recompute prefix */
 	if (inside_work_tree < 0) {
--=20
1.5.3.6.2041.g106f-dirty
