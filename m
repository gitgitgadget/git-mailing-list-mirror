From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/27] remote-curl.c: convert fetch_git() to use argv_array
Date: Sun, 12 Jun 2016 17:53:43 +0700
Message-ID: <20160612105409.22156-2-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC32i-0002wW-BR
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbcFLKyx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:54:53 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35523 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcFLKyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:54:52 -0400
Received: by mail-pf0-f196.google.com with SMTP id t190so8463259pfb.2
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHzWSCzr+84mBS3J/385I59gYWCe+mWZWt2bF3BOZoQ=;
        b=1HUZBOQM0uOtL+zwm+H+qhSTt0QHDKKGilJ2wBSz422WRuktXM/2D9bqKn7pv3lp8B
         WK3qj6G0lKFse/ZG0o2LjuhwrPh1AS3euy007wFutwnQfIlpk3A6lFaMuU+eymdXm/0/
         6gWBJ8mXacwA7q0d83kiRyk1y+vy7qCgjwGs/S61+KxjNxKTw/0LvjNVwTUjE0zVgbNB
         6ofckmwFU0xnIQWNQKpjP0Ju1sa8gKWW7xjEwXI0zOXsde4J41UabOyqzbFgzVAKD9Nq
         GZAQwL4lfwO2ZloxxNXItsUDP2B6QHUFj4dp/FFMCYsdXZb9KUT01hdvjZu0bXRSg+gZ
         D7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHzWSCzr+84mBS3J/385I59gYWCe+mWZWt2bF3BOZoQ=;
        b=WFheTP/lxTdc6jMmMeeFZYonBuaiFeJcV15bbOhbtNmd4p8jvNNJXFePcNG7NGMKX5
         ScDlt6ZAo4ZpBBPDDjWt6H1tyi+mGmeLeFMZQ8pd47rnZzA3Ctu0VRmVu+PRuxAq5133
         6+r950BvYJXUXWjCuqNtv4MMB6N8Rj7ek7j4wb4MFkgY1iry6+Gf39ntbPda0Bi+wZwm
         M0GwKEudMjdNRkn+cApdzpKhS8j+US8G5BVVjpFfmGFszYi4mPsccKjIaCdJYxefNAyq
         hHKlupVkt58JmE3PT0dLnNzpsGlSBT1Ym/mKRnL0iwzt2FmDmc8P56nXWD8WI5De9pgn
         9i5g==
X-Gm-Message-State: ALyK8tIoerTEeQsRYv82ywwDlEi4I/NeDgAKw0yfqvSMXF5fzxkE/NivLM8RxHsxzGveDQ==
X-Received: by 10.98.49.133 with SMTP id x127mr14615939pfx.140.1465728891424;
        Sun, 12 Jun 2016 03:54:51 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id i5sm13935876pfk.14.2016.06.12.03.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:54:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:54:46 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297108>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-curl.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index c704857..fd030c1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -725,38 +725,28 @@ static int fetch_git(struct discovery *heads,
 {
 	struct rpc_state rpc;
 	struct strbuf preamble =3D STRBUF_INIT;
-	char *depth_arg =3D NULL;
-	int argc =3D 0, i, err;
-	const char *argv[17];
-
-	argv[argc++] =3D "fetch-pack";
-	argv[argc++] =3D "--stateless-rpc";
-	argv[argc++] =3D "--stdin";
-	argv[argc++] =3D "--lock-pack";
+	int i, err;
+	struct argv_array args =3D ARGV_ARRAY_INIT;
+
+	argv_array_pushl(&args, "fetch-pack", "--stateless-rpc",
+			 "--stdin", "--lock-pack", NULL);
 	if (options.followtags)
-		argv[argc++] =3D "--include-tag";
+		argv_array_push(&args, "--include-tag");
 	if (options.thin)
-		argv[argc++] =3D "--thin";
-	if (options.verbosity >=3D 3) {
-		argv[argc++] =3D "-v";
-		argv[argc++] =3D "-v";
-	}
+		argv_array_push(&args, "--thin");
+	if (options.verbosity >=3D 3)
+		argv_array_pushl(&args, "-v", "-v", NULL);
 	if (options.check_self_contained_and_connected)
-		argv[argc++] =3D "--check-self-contained-and-connected";
+		argv_array_push(&args, "--check-self-contained-and-connected");
 	if (options.cloning)
-		argv[argc++] =3D "--cloning";
+		argv_array_push(&args, "--cloning");
 	if (options.update_shallow)
-		argv[argc++] =3D "--update-shallow";
+		argv_array_push(&args, "--update-shallow");
 	if (!options.progress)
-		argv[argc++] =3D "--no-progress";
-	if (options.depth) {
-		struct strbuf buf =3D STRBUF_INIT;
-		strbuf_addf(&buf, "--depth=3D%lu", options.depth);
-		depth_arg =3D strbuf_detach(&buf, NULL);
-		argv[argc++] =3D depth_arg;
-	}
-	argv[argc++] =3D url.buf;
-	argv[argc++] =3D NULL;
+		argv_array_push(&args, "--no-progress");
+	if (options.depth)
+		argv_array_pushf(&args, "--depth=3D%lu", options.depth);
+	argv_array_push(&args, url.buf);
=20
 	for (i =3D 0; i < nr_heads; i++) {
 		struct ref *ref =3D to_fetch[i];
@@ -769,7 +759,7 @@ static int fetch_git(struct discovery *heads,
=20
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name =3D "git-upload-pack",
-	rpc.argv =3D argv;
+	rpc.argv =3D args.argv;
 	rpc.stdin_preamble =3D &preamble;
 	rpc.gzip_request =3D 1;
=20
@@ -778,7 +768,7 @@ static int fetch_git(struct discovery *heads,
 		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
 	strbuf_release(&preamble);
-	free(depth_arg);
+	argv_array_clear(&args);
 	return err;
 }
=20
--=20
2.8.2.524.g6ff3d78
