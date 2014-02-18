From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/25] reflog: avoid constructing .lock path with git_path
Date: Tue, 18 Feb 2014 20:39:56 +0700
Message-ID: <1392730814-19656-8-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:41:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkvC-00071h-2z
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643AbaBRNk7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:40:59 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:60838 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636AbaBRNk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:40:57 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so16854962pad.27
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=u/PiROeQF/UlFpVDbol3J726iXy0/iJywWGsSt/PQk8=;
        b=sLRaD835Se2weZoBkYe2uW+hj7lEFciMpsypPaKT0+Ky1aKgfcbOQWfqG8yd6gwJWM
         W5+Aho25UF76tGoKOdO3mSNzULWTtrIRP988f8UmP2V6XDVKkiu0RkV1IaW4aVIqumYu
         nEvPNkcWmd8Rnm0bQ60j24xy5aG24weZtUXMHCPymcXDUN+59IPhaFfGD/cX8sXVO8cN
         Wrjj7osQqiuOGY89OXUAhhqHopcxI3JPa7ciiVTSv+SfL2TG59GTzZT97iTytgy4cO0B
         7cmftUpP3lSI7pwM94ImPuA5PaiF8UNDxAiziCJIoRQztFcm259rOKQKdt3RSVsp6rgT
         NYBA==
X-Received: by 10.66.251.42 with SMTP id zh10mr33509099pac.84.1392730856744;
        Tue, 18 Feb 2014 05:40:56 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id e3sm56101436pbc.17.2014.02.18.05.40.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:40:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:41:08 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242308>

git_path() soon understands the path given to it. Some paths "abc" may
become "def" while other "ghi" may become "ijk". We don't want
git_path() to interfere with .lock path construction. Concatenate
".lock" after the path has been resolved by git_path() so if "abc"
becomes "def", we'll have "def.lock", not "ijk".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reflog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 852cff6..ccf2cf6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -372,7 +372,7 @@ static int expire_reflog(const char *ref, const uns=
igned char *sha1, int unused,
 	if (!file_exists(log_file))
 		goto finish;
 	if (!cmd->dry_run) {
-		newlog_path =3D git_pathdup("logs/%s.lock", ref);
+		newlog_path =3D mkpathdup("%s.lock", log_file);
 		cb.newlog =3D fopen(newlog_path, "w");
 	}
=20
--=20
1.8.5.2.240.g8478abd
