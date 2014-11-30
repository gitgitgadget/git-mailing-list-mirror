From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/34] reflog: avoid constructing .lock path with git_path
Date: Sun, 30 Nov 2014 15:24:33 +0700
Message-ID: <1417335899-27307-9-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:26:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuzqG-0007ch-JS
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbaK3I0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:26:49 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:38389 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaK3I0s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:26:48 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so9166828pad.1
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Qosq9HzPRHLGVT+jl1GRfMGo9yGgg4aoun38EwAWm5o=;
        b=Bp7Ggz1Bhogu1RYUnu2T0EfnHKZ4zD1Sbh1aPCJbs8asMMms9xBmp1zE5fDSnf9WdW
         Hj4NVaNuQJhQBeF3ROqwbl3i7EGkD/ZVGWAqI0maV5Dp10SAQJaxGE+Kkc5FRv3SeHLz
         pwv1i+FVAfqg6Gt7Tsx4jrbYsPyJJWf2moNS4SY0VJiFhYxqeKLg2vhhq5bf2aBgADYu
         xftZeXH9mpTD5eSUA96VzWPvq3iR2w1b9FGpJj8g2vy/Miu3JGeqr60VEUE8V7htQP2W
         NJ2HhBi3pyPqD/w/A3Ja/UG3+mOvVZGIcaV47khyyWGwBjd9PQSANImg5iB1nHw9FFPS
         CpSw==
X-Received: by 10.70.51.98 with SMTP id j2mr29184354pdo.1.1417336008203;
        Sun, 30 Nov 2014 00:26:48 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ov2sm14301404pdb.91.2014.11.30.00.26.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:26:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:26:44 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260395>

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
index 2d85d26..fb07c66 100644
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
2.1.0.rc0.78.gc0d8480
