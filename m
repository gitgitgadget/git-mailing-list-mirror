From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/25] fetch-pack: use skip_prefix() instead of starts_with() when possible
Date: Thu,  4 Feb 2016 16:03:47 +0700
Message-ID: <1454576641-29615-12-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:05:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFrK-0006rh-7n
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965514AbcBDJFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:05:46 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36725 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965441AbcBDJFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:05:16 -0500
Received: by mail-pf0-f179.google.com with SMTP id n128so38161176pfn.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/7B2RnK7VIQ1tHFQjwyQb2pVsgVLzaOZcFYMUqSqej0=;
        b=rOix4Hc04FJNQn5YKno06oZm2TR/IDmZcorRNdNx052o0EynjDFHjePHCis5v92l3t
         21353SsQXJ9T8bxR1IWJ2rWWe3igcuUBHztrcr8HZlBUXLxM0VibhPY/rjTPG1BUQYLg
         QjBd/HoHtxxEFaF9XNsTLMKyolHuqpI+svBv1kLYbYDgxxZUR2gNamPCdT2YGpqF9w1R
         icdlQijdbQWSQbQyatk67viCPt7vsxrBq5Bir+RzxV13h+lPKkfNGAbuCEkao8FPeIHk
         sVtT8XZRj0kCmWWjVteuKsLe97q5sMKQk+prqHVt86rhb4Q49402kt3fr3q7bZRHsx7C
         hEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=/7B2RnK7VIQ1tHFQjwyQb2pVsgVLzaOZcFYMUqSqej0=;
        b=bqDxRreMpaiiw73Je+ETLpDo9egiZbVEz6sd8ckldjn8jZx7DZWECTspgPmdcuEtdI
         qRnS5OZ1e8OReNxr4m4p5Xu5u9qBb2GjLP3+bP49NIQ99gf34XgfNjlciCBoOO0BQKuD
         mXLd2GgWHArkeBJuGQ4BfnOacWx5l0ckgJZImxp5balRGDZQ03A8INfKUx6+3AplhUpJ
         lpeIYNRHdbsycZMghcH9u1wDwgy1X7Extf4Oqarikn8VfApkJO4yiBx9hO0pxYnn6Y+T
         Db3TyKx/fiYbYsv0cDfmDMOQVkMBWfopkEdEAplZuFbMfKEng+/FOLADF5Wlht4QzG7K
         GKZQ==
X-Gm-Message-State: AG10YOQo/1sRXED+RDpZ2mgQOoxyIhLeN0ZLqex+khbHxGXOwHtBWiDB0cc0P6le7ehtUg==
X-Received: by 10.98.64.83 with SMTP id n80mr9285293pfa.149.1454576716285;
        Thu, 04 Feb 2016 01:05:16 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id p9sm15435423pfa.11.2016.02.04.01.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:05:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:05:28 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285423>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9b2a514..0482077 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -58,13 +58,14 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
=20
 	for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
 		const char *arg =3D argv[i];
+		const char *value;
=20
-		if (starts_with(arg, "--upload-pack=3D")) {
-			args.uploadpack =3D arg + 14;
+		if (skip_prefix(arg, "--upload-pack=3D", &value)) {
+			args.uploadpack =3D value;
 			continue;
 		}
-		if (starts_with(arg, "--exec=3D")) {
-			args.uploadpack =3D arg + 7;
+		if (skip_prefix(arg, "--exec=3D", &value)) {
+			args.uploadpack =3D value;
 			continue;
 		}
 		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
@@ -100,8 +101,8 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 			args.verbose =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--depth=3D")) {
-			args.depth =3D strtol(arg + 8, NULL, 0);
+		if (skip_prefix(arg, "--depth=3D", &value)) {
+			args.depth =3D strtol(value, NULL, 0);
 			continue;
 		}
 		if (!strcmp("--no-progress", arg)) {
--=20
2.7.0.377.g4cd97dd
