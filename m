From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] system_path: use a static buffer
Date: Wed, 16 Mar 2011 17:33:03 +0100
Message-ID: <1300293183-26354-1-git-send-email-cmn@elego.de>
References: <AANLkTinEMzezKdfGUrwKv7sJ+tSK5duYM6XZMvBa-yj3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 17:33:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pztf6-000383-Cw
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab1CPQdJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:33:09 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:38124 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab1CPQdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 12:33:05 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 8D60D460FD;
	Wed, 16 Mar 2011 17:32:57 +0100 (CET)
Received: (nullmailer pid 26388 invoked by uid 1000);
	Wed, 16 Mar 2011 16:33:03 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <AANLkTinEMzezKdfGUrwKv7sJ+tSK5duYM6XZMvBa-yj3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169170>

Make system_path behave like the other path functions by using a
static buffer, fixing a memory leak.

Also make sure the prefix pointer is always initialized to either
PREFIX or NULL.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 exec_cmd.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 38545e8..5686952 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -9,11 +9,11 @@ static const char *argv0_path;
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
=20
 	if (is_absolute_path(path))
 		return path;
@@ -33,9 +33,10 @@ const char *system_path(const char *path)
 	}
 #endif
=20
-	strbuf_addf(&d, "%s/%s", prefix, path);
-	path =3D strbuf_detach(&d, NULL);
-	return path;
+	if (snprintf(buf, sizeof(buf), "%s/%s", prefix, path) >=3D sizeof(buf=
))
+		die("system path too long for %s", path);
+
+	return buf;
 }
=20
 const char *git_extract_argv0_path(const char *argv0)
--=20
1.7.4.1
