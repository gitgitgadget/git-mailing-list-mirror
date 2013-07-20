From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/16] clone: use git protocol for cloning shallow repo locally
Date: Sat, 20 Jul 2013 16:58:10 +0700
Message-ID: <1374314290-5976-17-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:59:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Tx0-0001pG-RT
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797Ab3GTJ7j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:59:39 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:43442 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab3GTJ7i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:59:38 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so11054004iee.6
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TNDalQlEnVYc+KpSyYEjr+vMntgnFBJ/L9JJR/F5m+k=;
        b=g6rECucqLV/4GwQwwuSmnU/AHS3MlZjUvkYg4nZ72iGkxnCver4pWuByKLyCm/wp4Y
         aXid6jfNGGY0YvDy1Mnzr1A/a8WbY8PdA6vFOv4n8jJG5dcz0kcefsbAeaCUcw4IaSNH
         hA1DluSgyv+o9PFC9m0IpHlCzPABq0Ax/zcObWw/ECCs6lgy47vjDix2cJ3Gc8VKijiJ
         sW/9qXtomGCbk34KJ3Dli8m7LmNqJ9oGC0gFgdEWQe9bpPkGydBy+MDAQdQqYCVeaMxu
         yREF0Urb3L//Ysd1WlNm/1RoDASVfLWsR9HBGb7DLwyaHQ3CF1IqD94USMAhHloGj3bV
         hrGQ==
X-Received: by 10.50.101.36 with SMTP id fd4mr14611458igb.13.1374314377966;
        Sat, 20 Jul 2013 02:59:37 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id hj6sm2262657igb.1.2013.07.20.02.59.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:59:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:59:56 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230894>

clone_local() does not handle $SRC/shallow. It could be made so, but
it's simpler to use fetch-pack/upload-pack instead.

This used by be caught by the check in upload-pack, which is triggered
by transport_get_remote_refs(), even in local clone case. The check is
now gone and check_everything_connected() should catch the result
incomplete repo. But check_everything_connected() will soon be skipped
in local clone case, opening a door to corrupt repo. This patch should
close that door.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c  | 14 ++++++++++++--
 t/t5601-clone.sh |  7 +++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 17f57cd..09e383e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -789,8 +789,18 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	else
 		repo =3D repo_name;
 	is_local =3D option_local !=3D 0 && path && !is_bundle;
-	if (is_local && option_depth)
-		warning(_("--depth is ignored in local clones; use file:// instead."=
));
+	if (is_local) {
+		struct strbuf sb =3D STRBUF_INIT;
+		if (option_depth)
+			warning(_("--depth is ignored in local clones; use file:// instead.=
"));
+		strbuf_addf(&sb, "%s/shallow", path);
+		if (!access(sb.buf, F_OK)) {
+			if (option_local > 0)
+				warning(_("source repository is shallow, ignoring --local"));
+			is_local =3D 0;
+		}
+		strbuf_release(&sb);
+	}
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
=20
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0629149..35a2a3d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -285,4 +285,11 @@ test_expect_success NOT_MINGW,NOT_CYGWIN 'clone lo=
cal path foo:bar' '
 	git clone "./foo:bar" foobar
 '
=20
+test_expect_success 'shallow clone locally' '
+	git clone --depth=3D1 --no-local src ssrrcc &&
+	git clone ssrrcc ddsstt &&
+	test_cmp ssrrcc/.git/shallow ddsstt/.git/shallow &&
+	( cd ddsstt && git fsck )
+'
+
 test_done
--=20
1.8.2.83.gc99314b
