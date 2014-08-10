From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/8] mv: flatten error handling code block
Date: Sun, 10 Aug 2014 09:29:30 +0700
Message-ID: <1407637776-19794-3-git-send-email-pclouds@gmail.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 04:30:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGItR-0003Nh-UF
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbaHJC3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2014 22:29:54 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34277 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHJC3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:29:53 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so9089349pab.6
        for <git@vger.kernel.org>; Sat, 09 Aug 2014 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pNZz0PnaaslZIlDr4oPkNnJA6zPzqgGfQDpEY590Toc=;
        b=gKGtLqZE/L95B8Zx+/h5WFbOE2ahJyzKCrr1HsTwP2PEoma2Qbynhl6HS9kNYnfWzz
         8C0KiPxTb5k82pqL52jJOvN447SvGtVTR8sOAe9QOlapWiGUVm4onYYglruo+oAN7Yey
         +rPiOMPX0iARvVYjwI4HJk88z71/Kc3zYA9vlgYuZTtX4WK1OFJmsr0FrdMmo46g4stW
         9ksxQn/U5ewzLI+d5AOzUP/T1wWLwLEJpl0gPqJvBMXfwfn194fUQw+6VCa0iSgBkmh7
         6xy+X8lBVak9AqRJT5jv6ekokIKhs/B6fMIOzJ/O/01lFA5EL6vzS4hwVv8OH0U6r5aG
         DGpg==
X-Received: by 10.69.19.193 with SMTP id gw1mr33104074pbd.106.1407637792635;
        Sat, 09 Aug 2014 19:29:52 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id h10sm41871352pat.11.2014.08.09.19.29.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2014 19:29:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 09:29:56 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255078>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index b892f63..c48129e 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -225,24 +225,22 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 		else
 			string_list_insert(&src_for_dst, dst);
=20
-		if (bad) {
-			if (ignore_errors) {
-				if (--argc > 0) {
-					memmove(source + i, source + i + 1,
-						(argc - i) * sizeof(char *));
-					memmove(destination + i,
-						destination + i + 1,
-						(argc - i) * sizeof(char *));
-					memmove(modes + i, modes + i + 1,
-						(argc - i) * sizeof(enum update_mode));
-					memmove(submodule_gitfile + i,
-						submodule_gitfile + i + 1,
-						(argc - i) * sizeof(char *));
-					i--;
-				}
-			} else
-				die (_("%s, source=3D%s, destination=3D%s"),
-				     bad, src, dst);
+		if (!bad)
+			continue;
+		if (!ignore_errors)
+			die (_("%s, source=3D%s, destination=3D%s"),
+			     bad, src, dst);
+		if (--argc > 0) {
+			int n =3D argc - i;
+			memmove(source + i, source + i + 1,
+				n * sizeof(char *));
+			memmove(destination + i, destination + i + 1,
+				n * sizeof(char *));
+			memmove(modes + i, modes + i + 1,
+				n * sizeof(enum update_mode));
+			memmove(submodule_gitfile + i, submodule_gitfile + i + 1,
+				n * sizeof(char *));
+			i--;
 		}
 	}
=20
--=20
2.1.0.rc0.78.gc0d8480
