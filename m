From: Fernando Vezzosi <buccia@repnz.net>
Subject: [PATCH 2/1] gc --auto: warn gc will soon run, give users a chance to run
 manually
Date: Sat, 5 Nov 2011 17:33:32 +0700
Message-ID: <20111105151225.EE3869004A@inscatolati.net>
References: <1320489212-524-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 16:21:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMi3U-00081C-OT
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 16:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797Ab1KEPM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 11:12:27 -0400
Received: from www.inscatolati.net ([212.45.155.126]:36888 "EHLO
	inscatolati.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1KEPM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 11:12:27 -0400
Received: by inscatolati.net (Postfix, from userid 1004)
	id EE3869004A; Sat,  5 Nov 2011 16:12:25 +0100 (CET)
In-Reply-To: <20111105140529.3A6CE9004A@inscatolati.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184851>

Signed-off-by: Fernando Vezzosi <buccia@repnz.net>
---

Rebased Nguy=E1=BB=85n's patch on top of mine.

 builtin/gc.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 65b6616..ca620e3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -25,8 +25,10 @@ static const char * const builtin_gc_usage[] =3D {
 static int pack_refs =3D 1;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
+static int gc_warn_auto_threshold =3D 6600;
 static int gc_auto_pack_limit =3D 50;
 static int gc_auto_warn_only =3D 0;
+static int gc_warn_auto_pack_limit =3D 45;
 static const char *prune_expire =3D "2.weeks.ago";
=20
 #define MAX_ADD 10
@@ -51,10 +53,12 @@ static int gc_config(const char *var, const char *v=
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
@@ -123,7 +127,13 @@ static int too_many_loose_objects(void)
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
@@ -146,7 +156,12 @@ static int too_many_packs(void)
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
1.7.5.3
