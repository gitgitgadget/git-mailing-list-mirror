From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] system_path: use a static buffer
Date: Wed, 16 Mar 2011 12:26:10 +0100
Message-ID: <1300274770-4798-1-git-send-email-cmn@elego.de>
References: <20110314200958.GC22602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 12:26:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzoro-00058m-PU
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab1CPL0M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 07:26:12 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:43527 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab1CPL0L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:26:11 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id D4D30460FD;
	Wed, 16 Mar 2011 12:26:04 +0100 (CET)
Received: (nullmailer pid 4846 invoked by uid 1000);
	Wed, 16 Mar 2011 11:26:10 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <20110314200958.GC22602@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169140>

Make system_path behave like the other path functions by using a
static buffer, fixing a memory leak.

Also make sure the prefix pointer is always initialized to either
PREFIX or NULL.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

This fixes the leak I was trying to fix with my original patch, but
this seems much cleaner

 exec_cmd.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 38545e8..12ce017 100644
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
+	static char buf[PATH_MAX+1];
=20
 	if (is_absolute_path(path))
 		return path;
@@ -33,9 +33,8 @@ const char *system_path(const char *path)
 	}
 #endif
=20
-	strbuf_addf(&d, "%s/%s", prefix, path);
-	path =3D strbuf_detach(&d, NULL);
-	return path;
+	snprintf(buf, PATH_MAX, "%s/%s", prefix, path);
+	return buf;
 }
=20
 const char *git_extract_argv0_path(const char *argv0)
--=20
1.7.4.1
