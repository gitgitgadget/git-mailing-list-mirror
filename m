From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clone,fetch: catch non positive --depth option value
Date: Thu,  5 Dec 2013 10:31:11 +0700
Message-ID: <1386214271-16464-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: knocte@gmail.com, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 04:26:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoPaF-0008Qa-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 04:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344Ab3LED0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 22:26:32 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:47439 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab3LED0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 22:26:31 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so24741610pbc.6
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 19:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=RPxAEJ5ur7FdZJ+B6Ya9fdDrJPUGrsByKjXO25x0Aw0=;
        b=hbDW4NCj5Q0OTbHMhsKdV0ODN7IFPGnwhI/cjSEzAyfYPkemDfb2X0qt2IO6xU6+S/
         KFsl8Rix/wsCnXnubBE4M4zmSoF2NarBmMBRA1UiFBcl4NohtbDYXJ0nEp6FyBfdBYlg
         WB24Vjk3t1BPdMj3NXmmWGsRidPKKkLLTQaHAEfbwbQxiSRPO8B8XbR+cZd2i/VxF9ZY
         73qr4YFORD3GRi70L+F8EvN0FaIXAbxvgCXP6V4TBZFWvSTCDpmt6hlph1v5EJ+Cksvj
         PTETD82yAA/6RBc2bExOSp6FCvxpTVG4ykUdYv7hnKWH3I16Jgnqs7O+YcvArZDHQfWq
         MoYA==
X-Received: by 10.68.160.69 with SMTP id xi5mr5653867pbb.168.1386213989828;
        Wed, 04 Dec 2013 19:26:29 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id i10sm162324020pat.11.2013.12.04.19.26.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Dec 2013 19:26:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 10:31:12 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238841>

Instead of simply ignoring the value passed to --depth option when
it is zero or negative, catch and report it as an error to let
people know that they were using the option incorrectly.

Original-patch-by: Andr=C3=A9s G. Aragoneses <knocte@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This replaces aa/transport-non-positive-depth-only

 builtin/clone.c | 4 ++++
 builtin/fetch.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 552f340..535b52f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -797,6 +797,10 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
=20
+	/* no need to be strict, transport_set_option() will validate it agai=
n */
+	if (option_depth && atoi(option_depth) < 1)
+		die(_("depth %s is not a positive number"), option_depth);
+
 	if (argc =3D=3D 2)
 		dir =3D xstrdup(argv[1]);
 	else
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2496ad2..ed399eb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1047,6 +1047,10 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
 		}
 	}
=20
+	/* no need to be strict, transport_set_option() will validate it agai=
n */
+	if (depth && atoi(depth) < 1)
+		die(_("depth %s is not a positive number"), depth);
+
 	if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
 		if (recurse_submodules_default) {
 			int arg =3D parse_fetch_recurse_submodules_arg("--recurse-submodule=
s-default", recurse_submodules_default);
--=20
1.8.5.1.25.g8667982
