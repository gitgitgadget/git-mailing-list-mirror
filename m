From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 05/26] enter_repo(): use setup_git_directory_gently internally
Date: Tue, 16 Feb 2010 23:04:56 +0700
Message-ID: <1266336317-607-6-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:09:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPyY-0006Wm-AN
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab0BPQIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:08:34 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab0BPQId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:08:33 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oTWxoOFSTcS56V2goT/wrg+PLn+FWn5O8+eRldbenbA=;
        b=UtbGm5r3E2ztu9EUwDIJUmWbtHs0noVvCGbVMzLasUzDRSnJ8byAQBTQbNY1picLlO
         btK8jCXrpbugapqa403vflWJGe3v70r8GPzXqHquswe09uXuSaW9dkMVsNs0qcEhUbBZ
         UjYTKLRQfHYk4e+eT1sasMwHd5B6b6B4Oi2W4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DnQXNWDx6Tv4Wr6CSNlrLrHvebv9b/FxLCpWKiAsbSxsb4utfelDx/wwSAb3TaOjCG
         YyNMMT1G+ouSATtPp2pZZHKW3nGPyjhMp0gulA/M8PE2bYk8uk2Sw68Jvik9xlgX7Jrf
         kMPRREDQx5fGx7BUiR09xhRNoaEBzfLg6KGUI=
Received: by 10.150.166.8 with SMTP id o8mr8360345ybe.262.1266336513166;
        Tue, 16 Feb 2010 08:08:33 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 21sm2872073ywh.31.2010.02.16.08.08.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:32 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:05:50 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140106>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/path.c b/path.c
index 0005df3..6a311d7 100644
--- a/path.c
+++ b/path.c
@@ -281,6 +281,7 @@ char *enter_repo(char *path, int strict)
 {
 	static char used_path[PATH_MAX];
 	static char validated_path[PATH_MAX];
+	int nongit_ok;
=20
 	if (!path)
 		return NULL;
@@ -334,12 +335,9 @@ char *enter_repo(char *path, int strict)
 	else if (chdir(path))
 		return NULL;
=20
-	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D 0=
 &&
-	    validate_headref("HEAD") =3D=3D 0) {
-		set_git_dir(".");
-		check_repository_format();
+	setup_git_directory_gently(&nongit_ok);
+	if (!nongit_ok)
 		return path;
-	}
=20
 	return NULL;
 }
--=20
1.7.0.195.g637a2
