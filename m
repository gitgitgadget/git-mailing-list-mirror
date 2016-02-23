From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/25] remote-curl.c: convert fetch_git() to use argv_array
Date: Tue, 23 Feb 2016 20:44:39 +0700
Message-ID: <1456235103-26317-2-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:45:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDGr-0007yb-VW
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbcBWNox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:44:53 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34196 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbcBWNox (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:44:53 -0500
Received: by mail-pf0-f179.google.com with SMTP id x65so112618203pfb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QJqJveBGAy/PR97/j+U1rPNV8ppvia6MQ0cOlSUex+k=;
        b=blmfmEOD3W3ZwCc04KHMiD3y9m6zA2zDCYMa0VmntkfHRp6Y6Yynj7/9fRcdaLa2P1
         Hmp8uWXLyntodqWeyISpr6BXxcKOMe8CuCjdLT6+nOHLajdMU4NjQQfdbbs5tVvghukb
         56rGn2x3E17eILlPje8kL+b7iSI0a40/GkgknU/t1lAc1Ii5Y8D5pgtCDVch8QUh+IGR
         ZJhJ6iiH+qKj46IVrARqd7R40k4RLoAaZidIRIcp1i01ZvssNzYI2FR6GzNpN75mTw6k
         jQbo6KhOx3NUTAsHRaZ9qfDDsV3aNAIeHmxhPbvZY0O/SW2iq9tXXJnxk7PYQxKt1LOn
         hNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=QJqJveBGAy/PR97/j+U1rPNV8ppvia6MQ0cOlSUex+k=;
        b=YMYp8BsJwGga9ayXlp2cQZ2ajFwhb2gwCVziBadXYvcyB25zxFJIfUWyb5j8FAIHyr
         kOaIeH97f4yysXBQfWdPX+s+yQiT/yyKmkj8ReRyqkujN5OotArkBe4ftgu/wBukUCnx
         aL3J0hjiRhNsPB//bpkuVybBAhaNPzvYypQxEeZfFeREllcBeCtU8Yh6z83Rx8hpyh1A
         gjnwhUlNKu8grb1CDTUSr44QxaNSkjZ2ob2WHGFOf140IKtSt32scW9wR0IqAYAK2L+q
         fWGat7MLhH5/tI6rq4NsPHQsJ/CPaauwZ+MoCrkQiBo5fRR3vrHncnrBtXSOxvPHdvjp
         zX4g==
X-Gm-Message-State: AG10YOSuUdDNtcB/Cg6s/WLfP+TILmSO9UtptqzSTIW1NHrJzChAId3cs8vGX7fFqCsIww==
X-Received: by 10.98.73.2 with SMTP id w2mr45766563pfa.106.1456235092517;
        Tue, 23 Feb 2016 05:44:52 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id dz8sm44709338pab.19.2016.02.23.05.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:44:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:45:21 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287052>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 remote-curl.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index c704857..4289c20 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -726,37 +726,30 @@ static int fetch_git(struct discovery *heads,
 	struct rpc_state rpc;
 	struct strbuf preamble =3D STRBUF_INIT;
 	char *depth_arg =3D NULL;
-	int argc =3D 0, i, err;
-	const char *argv[17];
+	int i, err;
+	struct argv_array args =3D ARGV_ARRAY_INIT;
=20
-	argv[argc++] =3D "fetch-pack";
-	argv[argc++] =3D "--stateless-rpc";
-	argv[argc++] =3D "--stdin";
-	argv[argc++] =3D "--lock-pack";
+	argv_array_pushl(&args, "fetch-pack", "--stateless-rpc",
+			 "--stdin", "--lock-pack", NULL);
 	if (options.followtags)
-		argv[argc++] =3D "--include-tag";
+		argv_array_push(&args, "--include-tag");
 	if (options.thin)
-		argv[argc++] =3D "--thin";
+		argv_array_push(&args, "--thin");
 	if (options.verbosity >=3D 3) {
-		argv[argc++] =3D "-v";
-		argv[argc++] =3D "-v";
+		argv_array_push(&args, "-v");
+		argv_array_push(&args, "-v");
 	}
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
@@ -769,7 +762,7 @@ static int fetch_git(struct discovery *heads,
=20
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name =3D "git-upload-pack",
-	rpc.argv =3D argv;
+	rpc.argv =3D args.argv;
 	rpc.stdin_preamble =3D &preamble;
 	rpc.gzip_request =3D 1;
=20
@@ -779,6 +772,7 @@ static int fetch_git(struct discovery *heads,
 	strbuf_release(&rpc.result);
 	strbuf_release(&preamble);
 	free(depth_arg);
+	argv_array_clear(&args);
 	return err;
 }
=20
--=20
2.7.1.532.gd9e3aaa
