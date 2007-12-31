From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [MinGW PATCH] spawn*: default extension to .exe if none is given
Date: Mon, 31 Dec 2007 18:45:52 +0700
Message-ID: <20071231114552.GA32421@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Dec 31 12:47:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9J6o-0001vN-82
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 12:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185AbXLaLqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2007 06:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756295AbXLaLqe
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 06:46:34 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:42499 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbXLaLqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 06:46:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4523905rvb.1
        for <git@vger.kernel.org>; Mon, 31 Dec 2007 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=JuC26/2GdbFTOwAsBJIjGizg3mXkOTxSYpR12Uo/ixA=;
        b=fiBC/C32/Xu2mssKeUG09eGqMFvNBNGWTMZu1yurKfJ4AJ4g/uay4F7Tf9ONX8TBeZwPumwhYAMaSXrMX/qWToPLFWhq758ozs2vS69okeOUqjaxM5dYN0+jJi9RoD4uoDZv8AmWcUXjV951nGoSGNYT1WZmM107n8tM6U9ZvTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=SV7hH9ctiZV0fJ5+k3qEEBUhoFrjn1yajzNauEpCOgkQ+RRDRgfqqnW8LIBkFnmn9MW4thZX49Cu87uv4vgxui/l+PNc9InYznLieb/1AS1EYosk6FnQZ5thMYxRd8FN1WjuAxCuavU6EwSwaRKGBGlYR48oMfcDhGmxr3/5s8Q=
Received: by 10.141.203.7 with SMTP id f7mr6253093rvq.185.1199101590910;
        Mon, 31 Dec 2007 03:46:30 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.3.149])
        by mx.google.com with ESMTPS id f21sm443057rvb.15.2007.12.31.03.46.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2007 03:46:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 31 Dec 2007 18:45:52 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69400>

This is the behavior of spawn* (or at least Wine source does it).
CreateProcess() does not have such assumption.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/mingw.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8bbe21b..dc54303 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -533,8 +533,9 @@ static pid_t mingw_spawnve(const char *cmd, const c=
har **argv, char **env,
 {
 	STARTUPINFO si;
 	PROCESS_INFORMATION pi;
-	struct strbuf envblk, args;
+	struct strbuf envblk, args, newcmd;
 	unsigned flags;
+	const char *basename;
 	BOOL ret;
=20
 	/* Determine whether or not we are associated to a console */
@@ -565,6 +566,21 @@ static pid_t mingw_spawnve(const char *cmd, const =
char **argv, char **env,
 	si.hStdOutput =3D (HANDLE) _get_osfhandle(1);
 	si.hStdError =3D (HANDLE) _get_osfhandle(2);
=20
+	/* Assume .exe if there is no extension */
+	strbuf_init(&newcmd, 0);
+	basename =3D strrchr(cmd, '/');
+	if (strrchr(cmd, '\\') > basename)
+		basename =3D strrchr(cmd, '\\');
+	if (basename)
+		basename ++;
+	else
+		basename =3D cmd;
+	if (!strchr(basename, '.')) {
+		strbuf_addstr(&newcmd, cmd);
+		strbuf_addstr(&newcmd, ".exe");
+		cmd =3D newcmd.buf;
+	}
+
 	/* concatenate argv, quoting args as we go */
 	strbuf_init(&args, 0);
 	if (prepend_cmd) {
@@ -609,6 +625,7 @@ static pid_t mingw_spawnve(const char *cmd, const c=
har **argv, char **env,
 	if (env)
 		strbuf_release(&envblk);
 	strbuf_release(&args);
+	strbuf_release(&newcmd);
=20
 	if (!ret) {
 		errno =3D ENOENT;
--=20
1.5.4.rc2.1097.gb6e0d
