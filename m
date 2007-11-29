From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH v2] Do check_repository_format() early
Date: Thu, 29 Nov 2007 19:21:39 +0700
Message-ID: <20071129122139.GA11176@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 13:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxiPB-0001JB-V0
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 13:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbXK2MVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2007 07:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756686AbXK2MVu
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 07:21:50 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:1951 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756290AbXK2MVt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 07:21:49 -0500
Received: by rn-out-0102.google.com with SMTP id i6so1483656rng
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 04:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=tWdUQxIBrxLnv1lzBzTK+b7pRw+D2vfraGHBXBfd5iA=;
        b=pxIchlV3npR123qO2Tqsor1AkDfnQVwXb9RBR1hDqLX8Xlq8xa40OtAYcUgl/ygyXgna8ppDQSVS0lpjtKpKOCaMSjKVsZzHm8xbVPtIHrCD17/6fgg2mZybv8ikstk7J5cjQ6MizHUh9lkrlM1A9g94vzT8YF8PtGZKQqMv0C8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=pWTHBAP2hNSsrcBWUP6tbKly1E9u/EnVWdLc9bF/hZMYHNhosW9vZ5CfOfV8s0+JSTFckmKClH/n2QOvgoOpa64/08sdf1GHiH1tu4+JuZNZyUWdNcvDYBeFiOo8pZQ0Fovq3Z1uOILlKDYM51RJVTcHJ/17sQ1ufpEE5P6zIZI=
Received: by 10.150.95.20 with SMTP id s20mr147478ybb.1196338908235;
        Thu, 29 Nov 2007 04:21:48 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.8])
        by mx.google.com with ESMTPS id w29sm305249pyg.2007.11.29.04.21.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Nov 2007 04:21:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 29 Nov 2007 19:21:39 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66530>

Repository version check is only performed when
setup_git_directory() is called. This makes sure
setup_git_directory_gently() does the check too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Comment updated.

 setup.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index faf4137..8fde2b2 100644
--- a/setup.c
+++ b/setup.c
@@ -246,8 +246,14 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 			static char buffer[1024 + 1];
 			const char *retval;
=20
-			if (!work_tree_env)
-				return set_work_tree(gitdirenv);
+			if (!work_tree_env) {
+				retval =3D set_work_tree(gitdirenv);
+				/* config may override worktree
+				 * see set_work_tree comment */
+				check_repository_format();
+				return retval;
+			}
+			check_repository_format();
 			retval =3D get_relative_cwd(buffer, sizeof(buffer) - 1,
 					get_git_work_tree());
 			if (!retval || !*retval)
@@ -287,6 +293,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
 			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			check_repository_format();
 			return NULL;
 		}
 		chdir("..");
@@ -307,6 +314,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	if (!work_tree_env)
 		inside_work_tree =3D 1;
 	git_work_tree_cfg =3D xstrndup(cwd, offset);
+	check_repository_format();
 	if (offset =3D=3D len)
 		return NULL;
=20
@@ -367,7 +375,6 @@ int check_repository_format(void)
 const char *setup_git_directory(void)
 {
 	const char *retval =3D setup_git_directory_gently(NULL);
-	check_repository_format();
=20
 	/* If the work tree is not the default one, recompute prefix */
 	if (inside_work_tree < 0) {
--=20
1.5.3.6.2041.g106f-dirty
