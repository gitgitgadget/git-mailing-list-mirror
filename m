From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] config: be strict on core.commentChar
Date: Sat, 17 May 2014 08:52:22 +0700
Message-ID: <1400291543-1371-1-git-send-email-pclouds@gmail.com>
References: <1400248283-303-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 03:45:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlTh0-00041j-Ij
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 03:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbaEQBpf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 21:45:35 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:62900 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbaEQBpe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 21:45:34 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3276484pbb.8
        for <git@vger.kernel.org>; Fri, 16 May 2014 18:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=f4jxjnIPDvffqw7tliq60wRR6jjY0KMlDl6+tgSxmyo=;
        b=sy4AD804MaFDX9ZYXgRB8B3JQRDu5w8I68pwI+7iaLI+c8OWyg8dysO7owBDbyzDUC
         EJTP8waByHn4La84YIohgfDb15TIs8CgM1YdVBkMk6ZF0MyQLUPv7BeVhAxECoNCp0jM
         Mw/C6JmKdmI3ZXEIRb5B+pG03Sajbdg/2yTW5Mp2pniRER5pli8Y60i2HInT83rVDYdc
         3z4WwFaHp38Oh5FVniWLTRsy3p8aB7aZTxosTOwZzSm6t/umIWGgnVPHCvn6u6RJYZQV
         /562XY0ixP3tYFtxr+YHAjEBDGNhnpGjwVckZTjNSQp4waLdmJ7UxZnzc07t3jDZITvr
         O7rQ==
X-Received: by 10.68.204.225 with SMTP id lb1mr25313540pbc.63.1400291133630;
        Fri, 16 May 2014 18:45:33 -0700 (PDT)
Received: from lanh ([115.73.230.255])
        by mx.google.com with ESMTPSA id qh2sm40957213pab.13.2014.05.16.18.45.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 18:45:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 17 May 2014 08:53:05 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1400248283-303-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249433>

We don't support comment _strings_ (at least not yet). And multi-byte
character encoding could also be misinterpreted.

The test with two commas is updated because it violates this. It's
added with the patch that introduces core.commentChar in eff80a9
(Allow custom "comment char" - 2013-01-16). It's not clear to me _why_
that behavior is wanted.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.c          | 8 ++++++--
 t/t7508-status.sh | 3 +--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index a30cb5c..491a905 100644
--- a/config.c
+++ b/config.c
@@ -826,9 +826,13 @@ static int git_default_core_config(const char *var=
, const char *value)
 	if (!strcmp(var, "core.commentchar")) {
 		const char *comment;
 		int ret =3D git_config_string(&comment, var, value);
-		if (!ret)
+		if (ret)
+			return ret;
+		else if (comment[0] && !comment[1]) {
 			comment_line_char =3D comment[0];
-		return ret;
+		} else
+			return error("core.commentChar should only be one character");
+		return 0;
 	}
=20
 	if (!strcmp(var, "core.askpass"))
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c987b5e..148ab9e 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1350,8 +1350,7 @@ test_expect_success "status (core.commentchar wit=
h submodule summary)" '
=20
 test_expect_success "status (core.commentchar with two chars with subm=
odule summary)" '
 	test_config core.commentchar ";;" &&
-	git -c status.displayCommentPrefix=3Dtrue status >output &&
-	test_i18ncmp expect output
+	test_must_fail git -c status.displayCommentPrefix=3Dtrue status
 '
=20
 test_expect_success "--ignore-submodules=3Dall suppresses submodule su=
mmary" '
--=20
1.9.1.346.ga2b5940
