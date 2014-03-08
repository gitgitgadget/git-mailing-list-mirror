From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 08/28] reflog: avoid constructing .lock path with git_path
Date: Sat,  8 Mar 2014 09:48:00 +0700
Message-ID: <1394246900-31535-9-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7Jr-000599-CO
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbaCHCsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:48:47 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:57448 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbaCHCsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:48:45 -0500
Received: by mail-pa0-f50.google.com with SMTP id kq14so4952019pab.37
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eEBv/zEgv6Kkdx1XQWoNiEKziBf2sxC25kFrQNzmRCM=;
        b=BbKGYSSsaexCigAorkxtlFwrwX/XFdeKnxXG5zIkJICIBYPJk0q9niWX6qH1wdixgM
         MQyniYrXcHhOBYS/RaBtMpUpr3QEXauAJPbDKF2kmYnJE3/HkCAerbNLJMCyfpKGFcyd
         C2+pd7CX/ojI+7DEF6aHL1XaaBXR7KjxUonKE6OT6jwwOpfifsEWR5Lwqz+YaLbqCXMi
         c9MbZGtgC5Evdt0n6gDpOZFbDswEZDHrJjhnfbHq9416uYM19eklZEj6JJATxJjwOMes
         G7DjCUiLsEKn+1IUec9EXLzVlSb8mIi6jtQ/eb3jSIZesWSCk763yJvxFvYFjUnNgYQG
         UczA==
X-Received: by 10.68.201.10 with SMTP id jw10mr26070786pbc.25.1394246924878;
        Fri, 07 Mar 2014 18:48:44 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id z3sm18694701pas.15.2014.03.07.18.48.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:48:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:49:15 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243648>

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
1.9.0.40.gaa8c3ea
