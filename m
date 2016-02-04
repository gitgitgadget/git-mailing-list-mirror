From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/25] remote-curl.c: convert fetch_git() to use argv_array
Date: Thu,  4 Feb 2016 16:03:37 +0700
Message-ID: <1454576641-29615-2-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:04:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFq0-0005He-BS
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379AbcBDJEW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:04:22 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36761 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965373AbcBDJER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:04:17 -0500
Received: by mail-pf0-f170.google.com with SMTP id n128so38133917pfn.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gx5vhlaYTSW6PDhV/rZ+qbUFpaiEk5Kq+s4zGCiGKgg=;
        b=i+Rki4NT7dvJ5BVzqGfjIBgAjynsoNBn5ZUFBuaKAaci2gTRYr6vyVxvXcPUU92pnt
         3aeYtbaY24MbiHJS5UjjcdlUXoZotVzd0j7rWiqeNuU9iniZYI0kBDUwmeSI/WI/6P1y
         vJ40u6UG/98tO5W+foiN0jYd9AlXVccYacOD/ur0oV+VjutKA/xUm7uuF7AiaOGXprR7
         taUOoqjgqISfh10dyiDiD6zNH2e9mJvy+nApdJamWXhw4ynpZBsWnbmbNq9YPKSinhnt
         lokRmB6Sd/isMrOAvi+R75pxKXzUn+sDQYO8HgvFuFVI40igORT4WekcgKdfXKGkq+/W
         A4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gx5vhlaYTSW6PDhV/rZ+qbUFpaiEk5Kq+s4zGCiGKgg=;
        b=C7Uq309idOIU1q8DNlRWEl2fQ4bz7sSh+kkSlXrrQKFi7Kd4M/6BnPKBdGah/+lQHq
         /fVC+CRymEtBMIbqnMahvJ4QMn7r0sbAZWmCmJeQ7lG4uosOWOEb/+a4u0so4jvU/uyL
         Ppf+oTix4O8Fm+i65IIhVenOh5FUXUqjdjiS0ion29paYqi9m1flyNruSubWynPG6Sxk
         wHu4+xmovrjKNGJjPvl/nTXA+f/19rPWQs45JiGQIah9Xb0xITP15lBwxGiAV/WuhNPl
         FznJZkPGTkRR8VOxsFavK+HoD8f5g9DTHdFGI80tTnok2oBl3AICMQ6W/wtuVv+btEOS
         F27Q==
X-Gm-Message-State: AG10YOTri/raycA7scbz1OT7/WONDEB1jPfJ0OJ0xbWEBqmd0U5v4b7qWoeVvk6KwhxpfQ==
X-Received: by 10.98.89.215 with SMTP id k84mr9410921pfj.66.1454576657184;
        Thu, 04 Feb 2016 01:04:17 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id v7sm15324659pfa.77.2016.02.04.01.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:04:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:04:29 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285415>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 remote-curl.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index c704857..3ac5b6c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -726,37 +726,31 @@ static int fetch_git(struct discovery *heads,
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
+			 "--stdin", "--lock-pack",
+			 NULL);
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
@@ -769,7 +763,7 @@ static int fetch_git(struct discovery *heads,
=20
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name =3D "git-upload-pack",
-	rpc.argv =3D argv;
+	rpc.argv =3D args.argv;
 	rpc.stdin_preamble =3D &preamble;
 	rpc.gzip_request =3D 1;
=20
@@ -779,6 +773,7 @@ static int fetch_git(struct discovery *heads,
 	strbuf_release(&rpc.result);
 	strbuf_release(&preamble);
 	free(depth_arg);
+	argv_array_clear(&args);
 	return err;
 }
=20
--=20
2.7.0.377.g4cd97dd
