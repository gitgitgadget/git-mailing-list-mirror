From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gc --auto: warn gc will soon run, give users a chance to run manually
Date: Sat,  5 Nov 2011 17:33:32 +0700
Message-ID: <1320489212-524-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 11:34:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMdaU-00062a-N9
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 11:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab1KEKey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 06:34:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44289 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab1KEKex (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 06:34:53 -0400
Received: by iage36 with SMTP id e36so3628834iag.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=65t9vC0uIVai7n6CevVN2A6a2bvmzCLcPmUyguGIm64=;
        b=k3zfTiN9Yig2/oF5MCyu3kZ8GkipTa2lOG3PzThN/oYGaHHU+1bJbl27OsHsp/5cRE
         paoc68mpbWIkVNuIrqhE9NCAxEOLHcyWu4yID+sINMImN7YNkLnuvx+CBIx+Kkwh4Qec
         p/63FFR7oOb+QCHZvMUbeHZG7QN/X094zsHKc=
Received: by 10.42.155.74 with SMTP id t10mr23997076icw.49.1320489293121;
        Sat, 05 Nov 2011 03:34:53 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.234.208])
        by mx.google.com with ESMTPS id b4sm5204798pbc.19.2011.11.05.03.34.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 03:34:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 05 Nov 2011 17:33:33 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184844>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I hate it every single time git hangs because gc is activated.
 Opening another terminal is an option but I would lose all terminal
 settings I have on the current one (e.g. access to suspended vim
 sessions).

 I don't think gc_warn_* need their own config vars. Hopefully
 hardcoded offset is good enough.

 builtin/gc.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 0498094..1f4555e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -25,7 +25,9 @@ static const char * const builtin_gc_usage[] =3D {
 static int pack_refs =3D 1;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
+static int gc_warn_auto_threshold =3D 6600;
 static int gc_auto_pack_limit =3D 50;
+static int gc_warn_auto_pack_limit =3D 45;
 static const char *prune_expire =3D "2.weeks.ago";
=20
 #define MAX_ADD 10
@@ -50,10 +52,12 @@ static int gc_config(const char *var, const char *v=
alue, void *cb)
 	}
 	if (!strcmp(var, "gc.auto")) {
 		gc_auto_threshold =3D git_config_int(var, value);
+		gc_warn_auto_threshold =3D gc_auto_threshold - 100;
 		return 0;
 	}
 	if (!strcmp(var, "gc.autopacklimit")) {
 		gc_auto_pack_limit =3D git_config_int(var, value);
+		gc_warn_auto_pack_limit =3D gc_auto_pack_limit - 5;
 		return 0;
 	}
 	if (!strcmp(var, "gc.pruneexpire")) {
@@ -118,7 +122,13 @@ static int too_many_loose_objects(void)
 		}
 	}
 	closedir(dir);
-	return needed;
+	if (needed)
+		return 1;
+
+	auto_threshold =3D (gc_warn_auto_threshold + 255) / 256;
+	if (num_loose > auto_threshold)
+		warning(_("Too many loose objects. \"git gc\" will soon run automati=
cally"));
+	return 0;
 }
=20
 static int too_many_packs(void)
@@ -141,7 +151,12 @@ static int too_many_packs(void)
 		 */
 		cnt++;
 	}
-	return gc_auto_pack_limit <=3D cnt;
+	if (gc_auto_pack_limit <=3D cnt)
+		return 1;
+
+	if (gc_warn_auto_pack_limit <=3D cnt)
+		warning(_("Too many packs, \"git gc\" will soon run automatically.")=
);
+	return 0;
 }
=20
 static int need_to_gc(void)
--=20
1.7.4.74.g639db
