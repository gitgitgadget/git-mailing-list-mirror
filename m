From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/25] upload-pack: move rev-list code out of check_non_tip()
Date: Tue, 23 Feb 2016 20:44:47 +0700
Message-ID: <1456235103-26317-10-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:45:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDHg-00009w-AX
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbcBWNpq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:45:46 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35083 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbcBWNpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:45:44 -0500
Received: by mail-pf0-f170.google.com with SMTP id c10so116383841pfc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5K43cff3oQHqkXMbCmRcEhP6lupHvtKforBHZ9Xbi7c=;
        b=R+yTpvZzPvgZUaWh6HtH48flmj7lqRxi2QywDX1/qf1OAMGu1QkM2QsPD9E3/bm3bx
         by0+9EVLKHENYN2NIzSlZSlUcVkF8d4fpfqiL/HuFM3t/6Tdr1SEXFXrl4vjTivVJ2I+
         t+xntA6DjOi49IeztTg86Z1oJjvr2VlCaf9tDc2FDauAN5QwHrwffmRoUzLwfPu807rp
         dCKMxX+O4Izf1YqPrqDrkyqwJIwfm1qf79qERNvdz5jK5ZNMQsibz/b/5vzhyIywQwQx
         C2PZW0eNR5Lx817Ru1MJmBeZd9bJyMYtAyJGuWoH6maEXdrh0GLicgzoEFms32Wc3zLZ
         WNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=5K43cff3oQHqkXMbCmRcEhP6lupHvtKforBHZ9Xbi7c=;
        b=nHDIWdQ7HvIJUxbE/43wTIoPCZrl6Sue20VMZVx27iTBfmTGAuk3oNGEYpCIMBF4mF
         3hg103CMKKZc95RcI+CPWW+xrCvGm+1QMqarN/d1459Jy1+abc0xBKicaDqRG7ZlpXuJ
         JDQjX2PUR+m0FCGV31bp4Kp4ipB4dU3r3Bz0q5bDU9uBTDH8ezkx9rS/yfUO8NC/YQVK
         kibywnXIgxfzaq7Nevz3QuMuPwqvWVX9L4ydxnkwiKZ6hMIZ3YQ1rsBz9N4hdghN6iWv
         9R/9xgLKm7F0vy9SgF9dP6GYaA3N7B2BmPz19/4z86fJoGUMyAEBfysJByFoyihOMn+K
         FHfA==
X-Gm-Message-State: AG10YOQB9lShe1sCaFUEl/JlxBShTZjgka3gFAZfVrt+yUhijKtyexxB/GVMzOUjoXM+sQ==
X-Received: by 10.98.67.153 with SMTP id l25mr46436847pfi.111.1456235143530;
        Tue, 23 Feb 2016 05:45:43 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id w9sm30863806pfa.21.2016.02.23.05.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:45:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:46:13 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287059>

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
2.7.1.532.gd9e3aaa
