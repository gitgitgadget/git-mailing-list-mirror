From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/27] upload-pack: move rev-list code out of check_non_tip()
Date: Sun, 12 Jun 2016 17:53:52 +0700
Message-ID: <20160612105409.22156-11-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC33P-0003SD-3U
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbcFLKzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:39 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36374 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbcFLKzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:36 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so8409690pad.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/GgSoVEy70CCzm/QZeUkrri+buk10v8Fdlye+W9B4s=;
        b=eVWgKJYdc1/j0WZrGnDtxxwOveTibAk7PcvMyswtEYmddEnO97/Et/p2gB4y7dzH8n
         YVynBOtmaFk9whrQ/OGbJVaszc1BwWwvIMp3aNGFWjPNT1ChcZM2mUhzonOhqv+2RAMi
         RL0En9qu/iS+f2YUnxrogwWVfi6Q6R2jhiAo18CB0C6+tDYGCW4E7AiIBW9Ev0IgjoZK
         ebmShi2CF03QMKwwWjov0gFeFRgbnSa8S4tKQ66oitogNX6PnRNE7Bnh86IJ8p8H7I09
         lvy6OcUtBmSYqj04NUKsYs5DC+wbvrQrhLoD4GwdgIsy4FEqVxEhlL/yHPuMsFiM8nkB
         f5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/GgSoVEy70CCzm/QZeUkrri+buk10v8Fdlye+W9B4s=;
        b=FQA4/LdOQvHvDnqwmUf1L+BHV5wrp17OteYeqFZcPg4jTE0N+XOuIz9YL2+8LjooHf
         M+t36kHzjKP20XCa6ht4IlWFlBofOPISCMBFYW/w3fAJe6ExCWo6Es+Hj9BasK+Sqk6o
         Sr9nSb2Ro7ssnKnpPH1/G6Ey6bgctGzb4QBIwfAXxogclKirmnKZlKn8bWsRZHgDAQkf
         QrpBLmTDk7qVLdCpNu2J9Qf0eEQ83OidnIVlaMUVfGUYJymZtVvdXNk8GM/JsYaFnyRS
         1dIhRG3PBnLYbeLc87WwZeyPb3ACXupZhpDJoaEQOjrvyJJCfVm+ZRzFIn+hWjrZVpdi
         Ms/g==
X-Gm-Message-State: ALyK8tKBhChsZj+cyk4/M1im9q7Cuvg+qZE9kGObRefUWLBjAYslp6UF4gIFQEuCcKjKZQ==
X-Received: by 10.67.5.73 with SMTP id ck9mr14309460pad.127.1465728935230;
        Sun, 12 Jun 2016 03:55:35 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id 6sm29850073pfv.26.2016.06.12.03.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:30 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297118>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 7ce97ec..93c0522 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -451,7 +451,7 @@ static int is_our_ref(struct object *o)
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
=20
-static void check_non_tip(void)
+static int has_unreachable(struct object_array *src)
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
@@ -498,8 +490,8 @@ static void check_non_tip(void)
 			goto error;
 	}
 	namebuf[40] =3D '\n';
-	for (i =3D 0; i < want_obj.nr; i++) {
-		o =3D want_obj.objects[i].item;
+	for (i =3D 0; i < src->nr; i++) {
+		o =3D src->objects[i].item;
 		if (is_our_ref(o))
 			continue;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
@@ -530,7 +522,7 @@ static void check_non_tip(void)
 	sigchain_pop(SIGPIPE);
=20
 	/* All the non-tip ones are ancestors of what we advertised */
-	return;
+	return 0;
=20
 error:
 	sigchain_pop(SIGPIPE);
@@ -539,10 +531,28 @@ error:
 		close(cmd.in);
 	if (cmd.out >=3D 0)
 		close(cmd.out);
+	return 1;
+}
=20
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
+		goto error;
+	if (!has_unreachable(&want_obj))
+		/* All the non-tip ones are ancestors of what we advertised */
+		return;
+
+error:
 	/* Pick one of them (we know there at least is one) */
 	for (i =3D 0; i < want_obj.nr; i++) {
-		o =3D want_obj.objects[i].item;
+		struct object *o =3D want_obj.objects[i].item;
 		if (!is_our_ref(o))
 			die("git upload-pack: not our ref %s",
 			    oid_to_hex(&o->oid));
--=20
2.8.2.524.g6ff3d78
