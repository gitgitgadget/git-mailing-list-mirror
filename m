From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 07/32] setup_git_env(): introduce git_path_from_env() helper
Date: Wed,  9 Jul 2014 14:32:52 +0700
Message-ID: <1404891197-18067-8-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:34:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mOJ-0003DI-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbaGIHeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:34:07 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47377 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbaGIHeG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:34:06 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so8764534pab.2
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hXdukBAJXoxsIMTQlz9ovFNXy8ZOA7WjPVuJjBhsmpY=;
        b=jiVrb/hVlEUGe6Q04jp1CvkxtOaov6ZrZGPWGcoioeSXz2cGv16rkJjIBB1o9OlqVr
         xhCRhoJsLEB0WspmXcyLmnxdVzKyALNnC+kNLxo1oblBZvU3vX3vC7lrLekyS4PEVA0f
         muA2HdhCW4S8oMAp+Zf1Ore7wBnNu6QhuJldbMaD+HHqBGUxis5rJyBuqCwNPJYm5zhN
         2JXLoo1V+0rfweZ2dy89c801AXdVSFrB+6dgQU8bE89Sf/9B55IiUtR69HC74m2Yxeek
         rUjZ37SsDgxOP/AqdpgnKL8b6rY19pL7J9OVlpFDGDD6jebX0WrHzXWuOMw1Y21JZaIA
         CUtQ==
X-Received: by 10.70.34.73 with SMTP id x9mr9691739pdi.27.1404891245090;
        Wed, 09 Jul 2014 00:34:05 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id cr4sm731122pbb.86.2014.07.09.00.34.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:34:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:34:02 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253082>

=46rom: Jeff King <peff@peff.net>

"Check the value of an environment and fall back to a known path
inside $GIT_DIR" is repeated a few times to determine the location
of the data store, the index and the graft file, but the return
value of getenv is not guaranteed to survive across further
invocations of setenv or even getenv.

Make sure to xstrdup() the value we receive from getenv(3), and
encapsulate the pattern into a helper function.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 environment.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/environment.c b/environment.c
index 4de7b81..565f652 100644
--- a/environment.c
+++ b/environment.c
@@ -124,6 +124,12 @@ static char *expand_namespace(const char *raw_name=
space)
 	return strbuf_detach(&buf, NULL);
 }
=20
+static char *git_path_from_env(const char *envvar, const char *path)
+{
+	const char *value =3D getenv(envvar);
+	return value ? xstrdup(value) : git_pathdup("%s", path);
+}
+
 static void setup_git_env(void)
 {
 	const char *gitfile;
@@ -134,15 +140,9 @@ static void setup_git_env(void)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 	gitfile =3D read_gitfile(git_dir);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
-	git_object_dir =3D getenv(DB_ENVIRONMENT);
-	if (!git_object_dir)
-		git_object_dir =3D git_pathdup("objects");
-	git_index_file =3D getenv(INDEX_ENVIRONMENT);
-	if (!git_index_file)
-		git_index_file =3D git_pathdup("index");
-	git_graft_file =3D getenv(GRAFT_ENVIRONMENT);
-	if (!git_graft_file)
-		git_graft_file =3D git_pathdup("info/grafts");
+	git_object_dir =3D git_path_from_env(DB_ENVIRONMENT, "objects");
+	git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, "index");
+	git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, "info/grafts"=
);
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs =3D 0;
 	namespace =3D expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
--=20
1.9.1.346.ga2b5940
