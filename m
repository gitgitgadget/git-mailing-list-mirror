From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/43] builtin: Support RUN_SETUP_GENTLY to set up repository early if found
Date: Mon,  5 Apr 2010 20:40:47 +0200
Message-ID: <1270492888-26589-3-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFc-0005ZJ-55
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701Ab0DESlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:41:44 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552Ab0DESll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:41:41 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Qi/olCeTqCF2IDRHdQ0jimyNUrec9Ap3DSfuSHrrfVk=;
        b=qKv+yZUh8foaBN1ElYXpYxnUC1o6BWiggL7caJF11js47LvlSqKOyzInpZCsQh2Ht4
         6VF5+KOI+B3srZSVhVTledATeJvMcLoQjeQdkhfXI0EThlV0D2lxn13eCMdkrYIjr7zI
         VMDflykLEmvTECf6LyorzJvKUCvjD6BZ+Y2dE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oNFR8aExaxN8MUgCHb2pFm0oSzKtLKeyetRIzMoXTZKygYApcPAplS1xbJzV6KVp53
         1ge6jx6M4lY/S/lHTZlGxOxZBOrtlGFwgKeOe2ZgSUYjAkpcCPnVQM1zoTshEh5O1jUo
         xv0+zK7JAkehi4QLpAP5gaVcbU8+YVyTWcsZM=
Received: by 10.223.21.17 with SMTP id h17mr6071165fab.45.1270492900684;
        Mon, 05 Apr 2010 11:41:40 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id f31sm13673219fkf.48.2010.04.05.11.41.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:41:40 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:41:39 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144002>

Attempts to access gitdir are everywhere, even before cmd_*() is
called. Because repository has not been found, repository-specific
information (i.e. $GIT_DIR/config) may not be read. This leads to
obscure bugs.

So the sooner we setup gitdir, the less trouble we may have to deal wit=
h.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    1 +
 git.c   |   11 ++++++++---
 setup.c |    4 +++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 8d8f8ee..fa13bf7 100644
--- a/cache.h
+++ b/cache.h
@@ -1064,6 +1064,7 @@ int checkout_fast_forward(const unsigned char *fr=
om, const unsigned char *to);
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
1.7.0.rc1.541.g2da82.dirty
