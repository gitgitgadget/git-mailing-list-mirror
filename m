From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] config: be strict on core.commentChar
Date: Fri, 16 May 2014 20:51:22 +0700
Message-ID: <1400248283-303-1-git-send-email-pclouds@gmail.com>
References: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 15:51:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlIXu-0004Ht-WA
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 15:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103AbaEPNva convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 09:51:30 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:51668 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064AbaEPNv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 09:51:26 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so2631035pbb.17
        for <git@vger.kernel.org>; Fri, 16 May 2014 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=U+oqcd92YADPh/rdPkxjyMkYWZIrhKVYoNmmY1Jiu7g=;
        b=hrwRlnyxkzzcuCeXAJv1Y4NXofepnMbGNZJ7k9vPyLVIUhbuRC4sn+U8vFjdesKxXf
         C6uv6qnIHoCLrA+7Nj0p7lTdigsN2EwybrtZOUBvMi3np87IbYwpiFL5ghXf/kBT0PbE
         gofVeGrbMQ7E5pY+3WX2NxDu6L7xi+Vgo/K362O0ow0l+dhogQbhthOh94b2ZRiB2BVt
         QWHJdCG1MGOqiNP6h0S96KruAzWVo7s1zPxw5Jju2LzPz8XHgvmb2TBgo/TxAnuifcMl
         07Mpvv97nVYqKuvS4wbet8zWVaTaQ3rmeIrNJoodJ5al9DnaEJzD8FvUTS9XR6rRR0LP
         rfLw==
X-Received: by 10.68.141.102 with SMTP id rn6mr21403486pbb.43.1400248285733;
        Fri, 16 May 2014 06:51:25 -0700 (PDT)
Received: from lanh ([115.73.241.6])
        by mx.google.com with ESMTPSA id mt1sm14732587pbb.31.2014.05.16.06.51.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 06:51:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 16 May 2014 20:51:34 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249306>

We don't support comment _strings_ (at least not yet). And multi-byte
character encoding could also be misinterpreted.

The test with two commas is deleted because it violates this. It's
added with the patch that introduces core.commentChar in eff80a9
(Allow custom "comment char" - 2013-01-16). It's not clear to me _why_
that behavior is wanted.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.c          | 8 ++++++--
 t/t7508-status.sh | 6 ------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index a30cb5c..05d909b 100644
--- a/config.c
+++ b/config.c
@@ -826,8 +826,12 @@ static int git_default_core_config(const char *var=
, const char *value)
 	if (!strcmp(var, "core.commentchar")) {
 		const char *comment;
 		int ret =3D git_config_string(&comment, var, value);
-		if (!ret)
-			comment_line_char =3D comment[0];
+		if (!ret) {
+			if (comment[0] && !comment[1])
+				comment_line_char =3D comment[0];
+			else
+				return error("core.commentChar should only be one character");
+		}
 		return ret;
 	}
=20
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c987b5e..98a9990 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1348,12 +1348,6 @@ test_expect_success "status (core.commentchar wi=
th submodule summary)" '
 	test_i18ncmp expect output
 '
=20
-test_expect_success "status (core.commentchar with two chars with subm=
odule summary)" '
-	test_config core.commentchar ";;" &&
-	git -c status.displayCommentPrefix=3Dtrue status >output &&
-	test_i18ncmp expect output
-'
-
 test_expect_success "--ignore-submodules=3Dall suppresses submodule su=
mmary" '
 	cat > expect << EOF &&
 On branch master
--=20
1.9.1.346.ga2b5940
