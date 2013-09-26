From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/10] upload-pack: new capability to send pack v4
Date: Thu, 26 Sep 2013 09:26:42 +0700
Message-ID: <1380162409-18224-4-git-send-email-pclouds@gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:27:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1IZ-0002ae-LG
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab3IZC1U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 22:27:20 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:53991 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab3IZC1T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:27:19 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so477725pbc.17
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 19:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DWP+9aomnL7VBC9LbU8GV0btGwFCzp81iLJLz3vbb0w=;
        b=gRqKsbHUUoiomDHrrXKxij5jXMii0VKyBv4xbKlTnR7V1HYPQVIAmxN/YjYY4ASVac
         T48D0k+mjkEjncr7u62W7uu5pJdtZ7umz42/txGNdnT5lLou3OHSuLZxjHZu7CrPJHP+
         OXZKDUWCYyZYwO2e+SzEI8a5/1ttToy9zcnV6jF0z8Sb+izpl2dp5k5GcHyKoUwT/D6b
         2HlzpkN1UqphegBqjKCe8Bk4Ac61B2lTKUzcQam902CGby8fTv/m6vL9YaQqXSflH71G
         SonsI18MXf2kN6BK49zAyZyr385Ufl/E5T8rE6r/KfgH36g45qfNfLtoNZPlWwl7nfC8
         nndA==
X-Received: by 10.66.179.143 with SMTP id dg15mr2590347pac.52.1380162438561;
        Wed, 25 Sep 2013 19:27:18 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id go4sm50831102pbb.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 19:27:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 26 Sep 2013 09:27:13 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1380162409-18224-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235390>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/protocol-capabilities.txt | 10 ++++++++++
 upload-pack.c                                     | 16 +++++++++++++--=
-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index fd8ffa5..be09792 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -217,3 +217,13 @@ allow-tip-sha1-in-want
 If the upload-pack server advertises this capability, fetch-pack may
 send "want" lines with SHA-1s that exist at the server but are not
 advertised by upload-pack.
+
+packv4
+------
+
+The upload-server can generate .pack version 4. If the client accepts
+this capability, the server may send a pack version 4. The server can
+choose to send pack version 2 even if the client accepts this
+capability.
+
+This capability does not include multi-base tree support.
diff --git a/upload-pack.c b/upload-pack.c
index ccf76d9..291d366 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -32,7 +32,7 @@ static unsigned long oldest_have;
=20
 static int multi_ack;
 static int no_done;
-static int use_thin_pack, use_ofs_delta, use_include_tag;
+static int use_thin_pack, use_ofs_delta, use_include_tag, packv4_ok;
 static int no_progress, daemon_mode;
 static int allow_tip_sha1_in_want;
 static int shallow_nr;
@@ -140,7 +140,7 @@ static void create_pack_file(void)
 		"corruption on the remote side.";
 	int buffered =3D -1;
 	ssize_t sz;
-	const char *argv[10];
+	const char *argv[11];
 	int arg =3D 0;
=20
 	argv[arg++] =3D "pack-objects";
@@ -157,6 +157,14 @@ static void create_pack_file(void)
 		argv[arg++] =3D "--delta-base-offset";
 	if (use_include_tag)
 		argv[arg++] =3D "--include-tag";
+	/*
+	 * The client may have requested pack v4. But if this is a v2
+	 * repo on a busy machine, we may want to send v2 and let the
+	 * client do the v2->v4 conversion to reduce the cost on the
+	 * server side.
+	 */
+	if (packv4_ok)
+		argv[arg++] =3D "--version=3D4";
 	argv[arg++] =3D NULL;
=20
 	memset(&pack_objects, 0, sizeof(pack_objects));
@@ -633,6 +641,8 @@ static void receive_needs(void)
 			no_progress =3D 1;
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag =3D 1;
+		if (parse_feature_request(features, "packv4"))
+			packv4_ok =3D 1;
=20
 		o =3D parse_object(sha1_buf);
 		if (!o)
@@ -738,7 +748,7 @@ static int send_ref(const char *refname, const unsi=
gned char *sha1, int flag, vo
 {
 	static const char *capabilities =3D "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
-		" include-tag multi_ack_detailed";
+		" include-tag multi_ack_detailed packv4";
 	const char *refname_nons =3D strip_namespace(refname);
 	unsigned char peeled[20];
=20
--=20
1.8.2.82.gc24b958
