From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/25] upload-pack: move rev-list code out of check_non_tip()
Date: Thu,  4 Feb 2016 16:03:46 +0700
Message-ID: <1454576641-29615-11-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:05:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFrF-00063F-Vi
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbcBDJFQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:05:16 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34318 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965438AbcBDJFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:05:10 -0500
Received: by mail-pf0-f182.google.com with SMTP id o185so38414387pfb.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=e2JjC+n4Xv8BOMEDNuu458Xprvl+w4QzV92lF0YdjEM=;
        b=XMhhApRpZIB1RKhuFjpz5KctLNo7RMO2CYZaoCKjHECUDA/Xkuw0+rggCT/MSEZm4N
         9MAojImAp0ib/QoAEx5LOul8HrI6RTeXw9d9DKI77BIjHq3cdnDy1qRzjyYp9PpyJE4A
         6lsIrn9Cy/XBDYerdlu/Tp/IIIwYP4GZmy1Z1sY+3KAwe/4WtYkMx3Ak42lzLEphQF+2
         SgblnF0DX5UMvoXjDxZxFFWVFUj1LMBiM6XIyuSDt6A8PeG+ZVKMV+j8Ya+eOIIW3LC5
         nahyo+izLu7a1/XdTi+//Zp0H91a6pjYNVCsBGCR7K/pH17NmNyHsH8z0gvLshucsZDH
         BgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=e2JjC+n4Xv8BOMEDNuu458Xprvl+w4QzV92lF0YdjEM=;
        b=AIP18aSU6h2wWbgObrDGxer8EceVt9EZG2XGhdwCMXcZUYY/OrgNsFn36i27kFvIgU
         hlFNet6K3BEbznrfSnTsVaU1q8gEqCnYpw8qs1x1hE0ZP2ytwBMg8tWmPxva+W8cVGNg
         OcDM2UO4j2LcfIP7adVftvQJezbipKWK07n6YerfwbQM+/Y0Y1aSGa2NeHx3/l6d/Oph
         K0TfBvegMC6aNDOtt553TPxOCjnc0W0CjUXWpm1yKPoy01wXbfHKQiQjjLBDwcLf+98e
         L2GwjHAZjNVwcAa/bIk7kPop8PTV4d9hrdoVxUErx4JmVx0q1Z//dXNc4bp4aDvmuzkO
         H3fw==
X-Gm-Message-State: AG10YOSpJF24LEmeauHJywc2NKOUpOUxkMcd/PqCQLmklgsa4Ly5DfPviM/9HivpQza54w==
X-Received: by 10.98.70.80 with SMTP id t77mr9240723pfa.107.1454576710167;
        Thu, 04 Feb 2016 01:05:10 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id v75sm15391139pfa.39.2016.02.04.01.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:05:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:05:22 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285424>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 9f14933..c8dafe8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -451,7 +451,7 @@ static int is_our_ref(struct object *o)
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
=20
-static void check_non_tip(void)
+static int check_unreachable(struct object_array *src)
 {
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
@@ -461,14 +461,6 @@ static void check_non_tip(void)
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
=20
-	/*
-	 * In the normal in-process case without
-	 * uploadpack.allowReachableSHA1InWant,
-	 * non-tip requests can never happen.
-	 */
-	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REA=
CHABLE_SHA1))
-		goto error;
-
 	cmd.argv =3D argv;
 	cmd.git_cmd =3D 1;
 	cmd.no_stderr =3D 1;
@@ -476,7 +468,7 @@ static void check_non_tip(void)
 	cmd.out =3D -1;
=20
 	if (start_command(&cmd))
-		goto error;
+		return 0;
=20
 	/*
 	 * If rev-list --stdin encounters an unknown commit, it
@@ -495,16 +487,16 @@ static void check_non_tip(void)
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
 		if (write_in_full(cmd.in, namebuf, 42) < 0)
-			goto error;
+			return 0;
 	}
 	namebuf[40] =3D '\n';
-	for (i =3D 0; i < want_obj.nr; i++) {
-		o =3D want_obj.objects[i].item;
+	for (i =3D 0; i < src->nr; i++) {
+		o =3D src->objects[i].item;
 		if (is_our_ref(o))
 			continue;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
 		if (write_in_full(cmd.in, namebuf, 41) < 0)
-			goto error;
+			return 0;
 	}
 	close(cmd.in);
=20
@@ -516,7 +508,7 @@ static void check_non_tip(void)
 	 */
 	i =3D read_in_full(cmd.out, namebuf, 1);
 	if (i)
-		goto error;
+		return 0;
 	close(cmd.out);
=20
 	/*
@@ -525,15 +517,29 @@ static void check_non_tip(void)
 	 * even when it showed no commit.
 	 */
 	if (finish_command(&cmd))
-		goto error;
+		return 0;
=20
 	/* All the non-tip ones are ancestors of what we advertised */
-	return;
+	return 1;
+}
+
+static void check_non_tip(void)
+{
+	int i;
+
+	/*
+	 * In the normal in-process case without
+	 * uploadpack.allowReachableSHA1InWant,
+	 * non-tip requests can never happen.
+	 */
+	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REA=
CHABLE_SHA1))
+		;		/* error */
+	else if (check_unreachable(&want_obj))
+		return;
=20
-error:
 	/* Pick one of them (we know there at least is one) */
 	for (i =3D 0; i < want_obj.nr; i++) {
-		o =3D want_obj.objects[i].item;
+		struct object *o =3D want_obj.objects[i].item;
 		if (!is_our_ref(o))
 			die("git upload-pack: not our ref %s",
 			    oid_to_hex(&o->oid));
--=20
2.7.0.377.g4cd97dd
