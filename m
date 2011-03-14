From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 2/3] setup_path(): Free temporary buffer
Date: Mon, 14 Mar 2011 20:18:37 +0100
Message-ID: <1300130318-11279-3-git-send-email-cmn@elego.de>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 20:28:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDRl-0004Lj-EG
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab1CNT2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 15:28:46 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:51618 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564Ab1CNT2p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:28:45 -0400
Received: from bee.lab.cmartin.tk (brln-4dbc728c.pool.mediaWays.net [77.188.114.140])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 77F2046101;
	Mon, 14 Mar 2011 20:19:02 +0100 (CET)
Received: (nullmailer pid 11314 invoked by uid 1000);
	Mon, 14 Mar 2011 19:18:38 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1300130318-11279-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169013>

Make sure the pointer git_exec_path() returns is in the heap and free
it after it's no longer needed.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 exec_cmd.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 38545e8..c16c3d4 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -73,11 +73,11 @@ const char *git_exec_path(void)
 	const char *env;
=20
 	if (argv_exec_path)
-		return argv_exec_path;
+		return xstrdup(argv_exec_path);
=20
 	env =3D getenv(EXEC_PATH_ENVIRONMENT);
 	if (env && *env) {
-		return env;
+		return xstrdup(env);
 	}
=20
 	return system_path(GIT_EXEC_PATH);
@@ -99,10 +99,13 @@ void setup_path(void)
 {
 	const char *old_path =3D getenv("PATH");
 	struct strbuf new_path =3D STRBUF_INIT;
+	char *exec_path =3D (char *) git_exec_path();
=20
-	add_path(&new_path, git_exec_path());
+	add_path(&new_path, exec_path);
 	add_path(&new_path, argv0_path);
=20
+	free(exec_path);
+
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
 	else
--=20
1.7.4.1
