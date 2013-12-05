From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 26/28] clone: use git protocol for cloning shallow repo locally
Date: Thu,  5 Dec 2013 20:02:53 +0700
Message-ID: <1386248575-10206-27-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYYM-000394-5E
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249Ab3LENBJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:01:09 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:63183 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab3LENBH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:01:07 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so25859249pbb.32
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tOkziBvEGWmkfj2AvETTSWOn8pZXtaLQPawtpTi44Oo=;
        b=z2FmKyVrEb2NFWSo5E2/0bY9QG8hzcZorMJzOXOKjuaNbaTLVRaD7hfEINV6T92flF
         Qrl5nrAewxgyHat/lebM3nYyNRvLuKIGqCTWztG8pggZZ+1rDbsFSdlAzv1Sl6/QtNZV
         tfDZCZms6SHazr1EYQuePCVvJmdZFzh3gGMTIJbbnvqKfPTvpBQS+ug6veLVlGtDfv/L
         DFaH8HSyRQ/Jyo5ZHyM9e9uaI8gkl6k2CC3V5v9G5COcYF5lx3FwBjkN02m/C9zXO3QR
         o6ZluKz7uffDKYooHwwqgQm580ALNEOlTvY37ZbdBrMTMsq6vkAwew1PL73Ch0F017QP
         ZrEw==
X-Received: by 10.68.193.233 with SMTP id hr9mr52871267pbc.26.1386248465181;
        Thu, 05 Dec 2013 05:01:05 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id b3sm1462841pbu.38.2013.12.05.05.01.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:01:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:05:48 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238882>

clone_local() does not handle $SRC/shallow. It could be made so, but
it's simpler to use fetch-pack/upload-pack instead.

This used to be caught by the check in upload-pack, which is triggered
by transport_get_remote_refs(), even in local clone case. The check is
now gone and check_everything_connected() should catch the result
incomplete repo. But check_everything_connected() will soon be skipped
in local clone case, opening a door to corrupt repo. This patch should
close that door.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c  | 11 +++++++++--
 t/t5601-clone.sh |  7 +++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0b182ce..71ee68b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -797,8 +797,15 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	else
 		repo =3D repo_name;
 	is_local =3D option_local !=3D 0 && path && !is_bundle;
-	if (is_local && option_depth)
-		warning(_("--depth is ignored in local clones; use file:// instead."=
));
+	if (is_local) {
+		if (option_depth)
+			warning(_("--depth is ignored in local clones; use file:// instead.=
"));
+		if (!access(mkpath("%s/shallow", path), F_OK)) {
+			if (option_local > 0)
+				warning(_("source repository is shallow, ignoring --local"));
+			is_local =3D 0;
+		}
+	}
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
=20
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 1d1c875..c226cff 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -340,4 +340,11 @@ test_expect_success 'clone from a repository with =
two identical branches' '
=20
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
1.8.5.1.25.g8667982
