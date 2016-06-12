From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 25/27] upload-pack: split check_unreachable() in two, prep for get_reachable_list()
Date: Sun, 12 Jun 2016 17:54:07 +0700
Message-ID: <20160612105409.22156-26-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC34X-0004DI-LT
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbcFLK4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:50 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35637 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbcFLK4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:49 -0400
Received: by mail-pa0-f65.google.com with SMTP id hf6so606863pac.2
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6hdMLkGD5e/a0tFO7fD47lUvXFtdievOnJ7N6JjHL8=;
        b=VAS9Mfr5cn4BMV3qjwUzkDBELiGBhSkv3NEIznu0Nk4pRx0VeINEI5JgXCApXGCbBp
         8gpgBHf72FSap0xOLhZJetWxEqUqDpFzRIC0swEEodX2V7kz4jE0JeQJXdqppYOCV8pY
         qBoEU4UmpuIX8PLGVXb1z3TDb+bhcmnKBOUPHsvHlI2b0uLOklzXBwv2MQDr2nNMOnYE
         wIiQH/ITmqcbzykYpZ9Pg6MVDI9jTtTUl2uFSXskoaeGvNuVaOuJs7ygNMIWb5TkEVM/
         +biddHEREH8BjheN1GCqztBGGt/h4JF1GyNYOzc1ekWAuAf431r3O+k6rxapwDNNpbW9
         QLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6hdMLkGD5e/a0tFO7fD47lUvXFtdievOnJ7N6JjHL8=;
        b=MaVdKlfRKQtToG+Abj24MtAwGzm7kyFJr/qYYpVbs7QkG8S6C6jKEuNjkK9Qlj2/0C
         6sAGryP1Uwvo4yZ8Q7GS31whVL6kzBSJYGwH/y8o9khcL01zJg1k+KyJvJSBFpKEyXNp
         lrh/dYKH85umW7oM5HzVGNycyWythSjp/cTsnIib1st5L0f0UihQmRxC/7HFhMBm3FfM
         F7bIXrARD+r8GkQ80B9t47VSl/ieDiRvc6RuQkzBO5R98Y1hdtEktA5PxDTkr+SWV7DK
         2mYxCS79vVVCTW7hYz6jeh38QD870tDEh7c2vIENaAK3pscCtZ1ad0WylNy8pdH0hGSZ
         vDzQ==
X-Gm-Message-State: ALyK8tK/wTdZoETsIT8jZy6qVBSfqY5PdNXxp61C2iVX2J3owbCenwpsZEFH3acfWG2VIw==
X-Received: by 10.66.154.74 with SMTP id vm10mr14825499pab.158.1465729008415;
        Sun, 12 Jun 2016 03:56:48 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id i8sm29759798pao.26.2016.06.12.03.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:56:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:56:43 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297132>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 56 ++++++++++++++++++++++++++++++++++++++-------------=
-----
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index acc6d97..adb8e33 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -452,21 +452,24 @@ static int is_our_ref(struct object *o)
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
=20
-static int has_unreachable(struct object_array *src)
+/*
+ * on successful case, it's up to the caller to close cmd->out
+ */
+static int do_reachable_revlist(struct child_process *cmd,
+				struct object_array *src)
 {
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
 	};
-	static struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct object *o;
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
=20
-	cmd.argv =3D argv;
-	cmd.git_cmd =3D 1;
-	cmd.no_stderr =3D 1;
-	cmd.in =3D -1;
-	cmd.out =3D -1;
+	cmd->argv =3D argv;
+	cmd->git_cmd =3D 1;
+	cmd->no_stderr =3D 1;
+	cmd->in =3D -1;
+	cmd->out =3D -1;
=20
 	/*
 	 * If the next rev-list --stdin encounters an unknown commit,
@@ -475,7 +478,7 @@ static int has_unreachable(struct object_array *src=
)
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
=20
-	if (start_command(&cmd))
+	if (start_command(cmd))
 		goto error;
=20
 	namebuf[0] =3D '^';
@@ -487,7 +490,7 @@ static int has_unreachable(struct object_array *src=
)
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 42) < 0)
+		if (write_in_full(cmd->in, namebuf, 42) < 0)
 			goto error;
 	}
 	namebuf[40] =3D '\n';
@@ -496,17 +499,39 @@ static int has_unreachable(struct object_array *s=
rc)
 		if (is_our_ref(o))
 			continue;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 41) < 0)
+		if (write_in_full(cmd->in, namebuf, 41) < 0)
 			goto error;
 	}
-	close(cmd.in);
-	cmd.in =3D -1;
+	close(cmd->in);
+	cmd->in =3D -1;
+	sigchain_pop(SIGPIPE);
+
+	return 0;
+
+error:
+	sigchain_pop(SIGPIPE);
+
+	if (cmd->in >=3D 0)
+		close(cmd->in);
+	if (cmd->out >=3D 0)
+		close(cmd->out);
+	return -1;
+}
+
+static int has_unreachable(struct object_array *src)
+{
+	struct child_process cmd =3D CHILD_PROCESS_INIT;
+	char buf[1];
+	int i;
+
+	if (do_reachable_revlist(&cmd, src) < 0)
+		return 1;
=20
 	/*
 	 * The commits out of the rev-list are not ancestors of
 	 * our ref.
 	 */
-	i =3D read_in_full(cmd.out, namebuf, 1);
+	i =3D read_in_full(cmd.out, buf, 1);
 	if (i)
 		goto error;
 	close(cmd.out);
@@ -520,16 +545,11 @@ static int has_unreachable(struct object_array *s=
rc)
 	if (finish_command(&cmd))
 		goto error;
=20
-	sigchain_pop(SIGPIPE);
-
 	/* All the non-tip ones are ancestors of what we advertised */
 	return 0;
=20
 error:
 	sigchain_pop(SIGPIPE);
-
-	if (cmd.in >=3D 0)
-		close(cmd.in);
 	if (cmd.out >=3D 0)
 		close(cmd.out);
 	return 1;
--=20
2.8.2.524.g6ff3d78
