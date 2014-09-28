From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/32] reflog: avoid constructing .lock path with git_path
Date: Sun, 28 Sep 2014 08:22:22 +0700
Message-ID: <1411867366-3821-9-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:23:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3D9-0002Gu-Gu
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbaI1BXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:23:35 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:49127 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:23:34 -0400
Received: by mail-pd0-f176.google.com with SMTP id fp1so2143966pdb.7
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GzzLZWyanTSqrGXiazAN/gukwyPFzQp4vKraixB0IOU=;
        b=a5E7utgPCiAPEwZN8wsHb/BCtXW4iICjmE/BligJmuvIat2VRGh6VG8kuIUb80/hm7
         TifVApCONma4ymRmsB2fxHHoXqs7R/Un5ZV+I+eNSWOGpfyYcFZB6cZQ1qr54/icgrOY
         tcjdO/zkgy4Koyn3TP9MUp9T8LJeT0+iVzGSYsiOJYQzlCs+sFd/euxbTCfpQM5DC9dc
         e+1iC5mQaXPajE/U/ZBGS9CiTqFGwxPmXCV/EEbCPinPxt0q/CqSBlCGKKjpRPJOh1a4
         LU1A25Bc5KbXs8fKTkKlIP4DqlrKXRtZesNB/JzB3eSlfK1RCXXB8FXUJLgcnhBNW8OO
         HU8Q==
X-Received: by 10.70.55.232 with SMTP id v8mr37978041pdp.93.1411867414034;
        Sat, 27 Sep 2014 18:23:34 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id gz1sm8552802pbb.8.2014.09.27.18.23.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:23:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:23:36 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257567>

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
