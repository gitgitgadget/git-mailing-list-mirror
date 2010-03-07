From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/18] builtin: Support RUN_SETUP_GENTLY to set up repository early if found
Date: Sun,  7 Mar 2010 11:55:51 +0700
Message-ID: <1267937767-12504-3-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:07:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8hg-0002DI-9j
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245Ab0CGFGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:06:54 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42653 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0CGFGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:06:53 -0500
Received: by pvb32 with SMTP id 32so1120758pvb.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=a7iUJot3mNJauz4AQp/nv7hXJ4VOMQTsvLWxHim+2sI=;
        b=TCOJDOYjIXb0j/FBTstMokG3Q7K3CqAEyV/5G9MOg+IVef0oqjl+G0jFkhmT7pHs50
         Q4jFmUWo8Fql4Avud73ivuhFo1hCvVtTX+eR9KnmFOxcpmVjsuTrbIJBviYgipAz2HKO
         hjFC5FtxquBi1m//l4TNhxKwxUAwgH+ijsyT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fg/xX1FJ0UD3lMPwG6U5gt6VfY/A7DrepdfSZ0n6ei8D+ucxXOm8HVyjTGYrA9Y4Rw
         KhTHpVJSvGNYKyRJnS58xsBR8c1lsuX6W8gwkFUAHXMy5cOgYzQX3S39qMLmj3S2QbVL
         dsj5aoE7FNUr1xDxRdirLTsLgi5cpXgxIbVRU=
Received: by 10.142.65.22 with SMTP id n22mr2098224wfa.113.1267937972484;
        Sat, 06 Mar 2010 20:59:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 22sm3257398pzk.5.2010.03.06.20.59.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 20:59:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:17 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141666>

Attempts to access gitdir are everywhere, even before cmd_*() is
called. Because repository has not been found, repository-specific
information (i.e. $GIT_DIR/config) may not be read. This leads to
obscure bugs.

So the sooner we setup gitdir, the less trouble we may have to deal wit=
h.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    1 +
 git.c   |   11 ++++++++---
 setup.c |    4 +++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 30fddf1..68412c0 100644
--- a/cache.h
+++ b/cache.h
@@ -1057,6 +1057,7 @@ int split_cmdline(char *cmdline, const char ***ar=
gv);
 /* git.c */
 struct startup_info {
 	const char *prefix;
+	int have_repository;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/git.c b/git.c
index 4be34e4..9e0e2d0 100644
--- a/git.c
+++ b/git.c
@@ -220,13 +220,14 @@ static int handle_alias(int *argcp, const char **=
*argv)
=20
 const char git_version_string[] =3D GIT_VERSION;
=20
-#define RUN_SETUP	(1<<0)
-#define USE_PAGER	(1<<1)
+#define RUN_SETUP		(1<<0)
+#define USE_PAGER		(1<<1)
 /*
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NEED_WORK_TREE	(1<<2)
+#define NEED_WORK_TREE		(1<<2)
+#define RUN_SETUP_GENTLY	(1<<3)
=20
 struct cmd_struct {
 	const char *cmd;
@@ -245,6 +246,10 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
 	if (!help) {
 		if (p->option & RUN_SETUP)
 			setup_git_directory();
+		if (p->option & RUN_SETUP_GENTLY) {
+			int nongit_ok;
+			setup_git_directory_gently(&nongit_ok);
+		}
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
 			use_pager =3D check_pager_config(p->cmd);
diff --git a/setup.c b/setup.c
index cf1b37d..bb3648c 100644
--- a/setup.c
+++ b/setup.c
@@ -448,8 +448,10 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	const char *prefix;
=20
 	prefix =3D setup_git_directory_gently_1(nongit_ok);
-	if (startup_info)
+	if (startup_info) {
 		startup_info->prefix =3D prefix;
+		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
+	}
 	return prefix;
 }
=20
--=20
1.7.0.195.g637a2
