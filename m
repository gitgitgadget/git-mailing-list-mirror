From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/5] enter_repo: allow .git files in strict mode
Date: Sun, 13 Sep 2015 08:02:26 +0700
Message-ID: <1442106148-22895-4-git-send-email-pclouds@gmail.com>
References: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
 <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:02:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavgj-0006lM-23
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbbIMBC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:02:28 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35274 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007AbbIMBC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:02:26 -0400
Received: by pacfv12 with SMTP id fv12so110680448pac.2
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hchHqz4p4mCxuXXr3JH2oSPviPWXQUnPonhEpFEBU5A=;
        b=Wxww7ePI/4LJlUBZGrQD3IDz00OcZnMnOQpYZ1g7AXl9ZYS6XrftRE0BohSW88KOxk
         oWMIgcxlcY4qcRSbYbk7sHE5+9T/eNWkbZ+VFQNaE5toX4z9kCszy8lUjvyKE2wQES4u
         JjWXfdpvP9HVXlSAIpe4czVy3oS2WmTK7cqSkoFzeozZmdBjn+dUjS6L2Xf/NaqIecg5
         gv9UR4OZFuSZRhRw1HdDaCj5ARy8Tv6BIL8cPlODyI0g2j6QQiZ5b+SJSzDSEreWysaB
         /JChlXSZjMURoTaI/Txk0/w3OXbfSbWZ+yxhnMgsPzetkGUReOsOoLir3j+a7WhL3Qrj
         oXhg==
X-Received: by 10.68.249.36 with SMTP id yr4mr16033857pbc.18.1442106146327;
        Sat, 12 Sep 2015 18:02:26 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id sl7sm7964605pbc.54.2015.09.12.18.02.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:02:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:02:45 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277747>

Strict mode is about not guessing where .git is. If the user points to =
a
=2Egit file, we know exactly where the target .git dir will be.

This is needed even in local clone case because transport.c code uses
upload-pack for fetching remote refs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index 7340e11..32d4ca6 100644
--- a/path.c
+++ b/path.c
@@ -438,8 +438,13 @@ const char *enter_repo(const char *path, int stric=
t)
 			return NULL;
 		path =3D validated_path;
 	}
-	else if (chdir(path))
-		return NULL;
+	else {
+		const char *gitfile =3D read_gitfile(used_path);
+		if (gitfile)
+			path =3D gitfile;
+		if (chdir(path))
+			return NULL;
+	}
=20
 	if (is_git_directory(".")) {
 		set_git_dir(".");
--=20
2.3.0.rc1.137.g477eb31
