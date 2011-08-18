From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] log: decorate grafted commits with "grafted"
Date: Thu, 18 Aug 2011 19:29:37 +0700
Message-ID: <1313670578-2939-5-git-send-email-pclouds@gmail.com>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 14:30:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu1jt-0001Y0-Mo
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 14:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957Ab1HRMaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 08:30:19 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41218 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab1HRMaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 08:30:18 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so2928610pzk.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+cMHeVQqWK0RMbAddLo32G8pXqXsey1tKKzot5IpL9Y=;
        b=O/JpBHUvZvq81BHT2g1X1SoJ+P6yaFTSA8IV9ZKRPwZGHHHpMb2FK3EgVCAkjI50u0
         g4zHrSAFPFUxPl19ZQj97eAqqdFqaonOiZIQT41wF/ezZaeGVUpMaiQIUxy93s6T1CaZ
         0X6MBGbauy+0nOIPWy6uOLVCPBOujQvvPXalQ=
Received: by 10.142.112.14 with SMTP id k14mr63960wfc.323.1313670618127;
        Thu, 18 Aug 2011 05:30:18 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id c8sm1438591pbi.75.2011.08.18.05.30.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 05:30:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Aug 2011 19:30:08 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179594>

In shallow repositories, this may help detect whether a branch ends,
or it is deeper than current depth.

It also show graft points that extend a branch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 log-tree.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 344f734..5605244 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -18,6 +18,7 @@ enum decoration_type {
 	DECORATION_REF_TAG,
 	DECORATION_REF_STASH,
 	DECORATION_REF_HEAD,
+	DECORATION_GRAFTED,
 };
=20
 static char decoration_colors[][COLOR_MAXLEN] =3D {
@@ -27,6 +28,7 @@ static char decoration_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_BOLD_YELLOW,	/* REF_TAG */
 	GIT_COLOR_BOLD_MAGENTA,	/* REF_STASH */
 	GIT_COLOR_BOLD_CYAN,	/* REF_HEAD */
+	GIT_COLOR_BOLD_BLUE,	/* GRAFTED */
 };
=20
 static const char *decorate_get_color(int decorate_use_color, enum dec=
oration_type ix)
@@ -118,6 +120,15 @@ static int add_ref_decoration(const char *refname,=
 const unsigned char *sha1, in
 	return 0;
 }
=20
+static int add_graft_decoration(const struct commit_graft *graft, void=
 *cb_data)
+{
+	struct commit *commit =3D lookup_commit(graft->sha1);
+	if (!commit)
+		return 0;
+	add_name_decoration(DECORATION_GRAFTED, "grafted", &commit->object);
+	return 0;
+}
+
 void load_ref_decorations(int flags)
 {
 	static int loaded;
@@ -125,6 +136,7 @@ void load_ref_decorations(int flags)
 		loaded =3D 1;
 		for_each_ref(add_ref_decoration, &flags);
 		head_ref(add_ref_decoration, &flags);
+		for_each_commit_graft(add_graft_decoration, NULL);
 	}
 }
=20
--=20
1.7.4.74.g639db
