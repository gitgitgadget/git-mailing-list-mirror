From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 08/31] reflog: avoid constructing .lock path with git_path
Date: Sun, 13 Jul 2014 11:50:45 +0700
Message-ID: <1405227068-25506-9-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:53:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BnO-000854-Et
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbaGMExu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:53:50 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42073 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaGMExt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:53:49 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so3442518pdi.23
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=67MkH1d0Zo6xqJXkPIIet2ewhntnflljwcVx9f55UDs=;
        b=L3LT25Z+21rVhxV+siJXGPg4Qsw9t6HQmvzlvapG5EYcndia2h35QJmVTB1m63qoOl
         kBke+B0OlzGZxcjnZ3kNSWq/ZX9WlzEHkmBZMHITFuL0twu/8VFAF8lMR8q5PnbXeAJz
         EIywjoKlpFyxoJqih9SitKk8rRaTWJw17/obItls4S5QvEQMGEXC36+T46BrQVHAjTpm
         WD8KHPFcTcual63LvY4ypxndvcaRGScSQhNO0fxmknCpZFPJUw6S+YnuJol8zVAImCZ0
         bT0itgOkkpw7f6L84dIjZf/RbJyEn3s6+sWW1kS9QlvD7oZbLELtHcuoENADMz3zo1eq
         zdiw==
X-Received: by 10.68.136.5 with SMTP id pw5mr1382510pbb.106.1405227228992;
        Sat, 12 Jul 2014 21:53:48 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id hs5sm6737261pbb.92.2014.07.12.21.53.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:53:48 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:53:49 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253411>

Among pathnames in $GIT_DIR, e.g. "index" or "packed-refs", we want to
automatically and silently map some of them to the $GIT_DIR of the
repository we are borrowing from via $GIT_COMMON_DIR mechanism.  When
we formulate the pathname for its lockfile, we want it to be in the
same location as its final destination.  "index" is not shared and
needs to remain in the borrowing repository, while "packed-refs" is
shared and needs to go to the borrowed repository.

git_path() could be taught about the ".lock" suffix and map
"index.lock" and "packed-refs.lock" the same way their basenames are
mapped, but instead the caller can help by asking where the basename
(e.g. "index") is mapped to git_path() and then appending ".lock"
after the mapping is done.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reflog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index e8a8fb1..9bd874d 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -372,7 +372,7 @@ static int expire_reflog(const char *ref, const uns=
igned char *sha1, int unused,
 	if (!reflog_exists(ref))
 		goto finish;
 	if (!cmd->dry_run) {
-		newlog_path =3D git_pathdup("logs/%s.lock", ref);
+		newlog_path =3D mkpathdup("%s.lock", log_file);
 		cb.newlog =3D fopen(newlog_path, "w");
 	}
=20
--=20
1.9.1.346.ga2b5940
