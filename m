From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/27] remote-curl.c: convert fetch_git() to use argv_array
Date: Fri, 10 Jun 2016 19:26:48 +0700
Message-ID: <20160610122714.3341-2-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:30:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLXf-0000LX-5G
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbcFJM16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:27:58 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36207 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbcFJM15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:27:57 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so5020546pad.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHj3ADJ0YdGfNP8Cm/IyivT+bVIA6tTnRk3KQjunQUY=;
        b=WXwuHJ6BOgcbfZHdX8hCTUGjoznwTc/ZJqvwlw8VInjJIT4HKV0YXqy/kqGos69JIV
         c4Ycedxt7NPcpgKfmnK4dEPdm0PffN7rb7BKCF8FxQm78IBxgtXN+izcUQ1EZnfelaMq
         uyvRhIkG+FT0tMet4re4BSkkIOpA5J8xLbAIozTdq2nRbqRT4ukROJZztN23Q4KD8twC
         Qm3GM6xrGb1VjqG/LRnWVpBH3scttis5MxOZQEglhe+Jxb4TTBn9d859aC7yJ/NxHfF8
         DKQL53J2PoK1vsBjmDx2vCXRyB9QaIDEmhgMFR3GUU+o7gyyttZvx/LZLVQ1YBPA5KCS
         Jx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHj3ADJ0YdGfNP8Cm/IyivT+bVIA6tTnRk3KQjunQUY=;
        b=k0TrPj77vKJO/kCw5KvjQDUI/m9PFrtEpTEucC/bBVWCPeLuivvkE60OQuwB1ep2xM
         Qs7chDQs8MUKAA4Xqay5/8jsztSVVFZPUcqyRcTXjqnPAnoFsqHN2FGxjSlny5smF6PQ
         w5j76tsI+ud98hBQNi+IXr2Nm8CJjY31EDDrHkMp3xWF7Fy5opbtjvvApRoYZIxlOOLH
         0FJ68FI8aCfDcBdOGuClOc08SjIFxpng821M1WwT1vw86DrTsTRLgoZ3r7uswClQH10q
         X07ACbzBxJVcbrlUxwOUjW1LdnnMg9YYnqk0J4G/ykiafyBIDqLKUCHwsiFkjQwhICju
         BhRw==
X-Gm-Message-State: ALyK8tJnqc8LjA6yOaX6BqYGo2B2HX/3Py7i0IeNtlqyHheXw/tGp758qDgDFgxBFetHog==
X-Received: by 10.66.144.228 with SMTP id sp4mr2132185pab.107.1465561676706;
        Fri, 10 Jun 2016 05:27:56 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id b186sm17494004pfa.61.2016.06.10.05.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:27:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:27:52 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296983>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
