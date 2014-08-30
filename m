From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/32] reflog: avoid constructing .lock path with git_path
Date: Sat, 30 Aug 2014 15:33:38 +0700
Message-ID: <1409387642-24492-9-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:34:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe7T-0001hb-VY
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbaH3Iem convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:34:42 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55527 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbaH3Iej (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:34:39 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so2047080pdb.41
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GzzLZWyanTSqrGXiazAN/gukwyPFzQp4vKraixB0IOU=;
        b=WZXD3hwJk5jThzskfhE3FWEqhf/SXLWDxf8Db08d2WW2DlSAHZFEQp3Pn2Vfi0qK1V
         +Diaq7+hq8bEAgJfS3D/Wmst9pY2Cu7XfMxwdRXajVCu6X3KCySjz4LqT59iEkRSwZVm
         vLEIzXYNhBYM97iuBnlBhgbGsAzslOGSjHGO2jaGmZZuyCeH0mygKpAtyTcJjgoiuMCn
         tbEzMA7bNdsjf44d2hqlegZWYG/ijSvD2l8l93OZsKaPKjYPKz0Wjp3ch0yJKmMT23GD
         sXVxY5imiCQqJLEs0kK5eCagCTv1ur0isj4lUZmCdmuMeJRDlH+BPEma2mxgf4+0jQCl
         sU6A==
X-Received: by 10.70.118.9 with SMTP id ki9mr22524770pdb.104.1409387679237;
        Sat, 30 Aug 2014 01:34:39 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id v9sm3103961pdi.93.2014.08.30.01.34.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:34:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:34:48 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256218>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480
