From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] system_path: use a static buffer
Date: Thu, 17 Mar 2011 15:24:13 +0100
Message-ID: <1300371853-8965-1-git-send-email-cmn@elego.de>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 15:24:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0E7w-0002K8-7Y
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 15:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab1CQOYT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 10:24:19 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:46842 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746Ab1CQOYO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 10:24:14 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 3116F460FD;
	Thu, 17 Mar 2011 15:24:07 +0100 (CET)
Received: (nullmailer pid 9064 invoked by uid 1000);
	Thu, 17 Mar 2011 14:24:13 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1300359664-6230-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169245>

Make system_path behave like the other path functions by using a
static buffer, fixing a memory leak.

Also make sure the prefix pointer is always initialized to either
PREFIX or NULL.

git_etc_gitattributes and git_etc_gitconfig are the only users who are
affected by this change. Make them use a static buffer, which fits
their use better as well.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

It was pointed out that one should always check for an encoding error
(-1) with the printf family. I'm not sure how likely this is to
happen, but this should make the code extra portable :)

 attr.c     |    6 +++---
 config.c   |    6 +++---
 exec_cmd.c |   15 ++++++++++-----
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/attr.c b/attr.c
index 6aff695..64d803f 100644
--- a/attr.c
+++ b/attr.c
@@ -467,9 +467,9 @@ static void drop_attr_stack(void)
=20
 const char *git_etc_gitattributes(void)
 {
-	static const char *system_wide;
-	if (!system_wide)
-		system_wide =3D system_path(ETC_GITATTRIBUTES);
+	static char system_wide[PATH_MAX];
+	if (!system_wide[0])
+		strlcpy(system_wide, system_path(ETC_GITATTRIBUTES), PATH_MAX);
 	return system_wide;
 }
=20
diff --git a/config.c b/config.c
index 822ef83..cd1c295 100644
--- a/config.c
+++ b/config.c
@@ -808,9 +808,9 @@ int git_config_from_file(config_fn_t fn, const char=
 *filename, void *data)
=20
 const char *git_etc_gitconfig(void)
 {
-	static const char *system_wide;
-	if (!system_wide)
-		system_wide =3D system_path(ETC_GITCONFIG);
+	static char system_wide[PATH_MAX];
+	if (!system_wide[0])
+		strlcpy(system_wide, system_path(ETC_GITCONFIG), PATH_MAX);
 	return system_wide;
 }
=20
diff --git a/exec_cmd.c b/exec_cmd.c
index 38545e8..35d5cd8 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -9,11 +9,12 @@ static const char *argv0_path;
 const char *system_path(const char *path)
 {
 #ifdef RUNTIME_PREFIX
-	static const char *prefix;
+	static const char *prefix =3D NULL;
 #else
 	static const char *prefix =3D PREFIX;
 #endif
-	struct strbuf d =3D STRBUF_INIT;
+	static char buf[PATH_MAX];
+	int ret;
=20
 	if (is_absolute_path(path))
 		return path;
@@ -33,9 +34,13 @@ const char *system_path(const char *path)
 	}
 #endif
=20
-	strbuf_addf(&d, "%s/%s", prefix, path);
-	path =3D strbuf_detach(&d, NULL);
-	return path;
+	ret =3D snprintf(buf, sizeof(buf), "%s/%s", prefix, path);
+	if (ret >=3D sizeof(buf))
+		die("system path too long for %s", path);
+	else if (ret < 0)
+		die_errno("encoding error");
+
+	return buf;
 }
=20
 const char *git_extract_argv0_path(const char *argv0)
--=20
1.7.4.1
