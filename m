From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 02/10] Stop starting pager recursively
Date: Tue, 28 Feb 2012 18:58:43 +0700
Message-ID: <1330430331-19945-3-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 12:59:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Li0-0005Cx-7I
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 12:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965457Ab2B1L7D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 06:59:03 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46462 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965344Ab2B1L7B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 06:59:01 -0500
Received: by pbcup15 with SMTP id up15so3213892pbc.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 03:59:00 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.130.131 as permitted sender) client-ip=10.68.130.131;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.130.131 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.130.131])
        by 10.68.130.131 with SMTP id oe3mr35857954pbb.60.1330430340550 (num_hops = 1);
        Tue, 28 Feb 2012 03:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bJTq6C1hzvr0vItmwGaCJSFuR6sljeuRvUlS21mCgVs=;
        b=nbMxni44JUUb15TIFNROqJicM1JMDm9TxD1yijfhB9cVYe4l9p+zUbmWL1uulQWdeM
         a26eDThqgwIRhkXHPzLjGUp7I3aORdIqeRExSFl5nBni8+weCskT76BhVPdTo8ToC/lO
         u3q/grgSfckWcQ3UdkaMtoj12/pFtexsNbgYI=
Received: by 10.68.130.131 with SMTP id oe3mr30565877pbb.60.1330430340426;
        Tue, 28 Feb 2012 03:59:00 -0800 (PST)
Received: from tre ([115.74.56.186])
        by mx.google.com with ESMTPS id i3sm6553641pbe.33.2012.02.28.03.58.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 03:58:59 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 28 Feb 2012 18:59:06 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191716>

git-column can be used as a pager for other git commands, something
like this:

    GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p branch

The problem with this is that "git -p column" also has $GIT_PAGER
set so the pager runs itself again as a pager, then again and again.

Stop this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pager.c b/pager.c
index 05584de..4dcb08d 100644
--- a/pager.c
+++ b/pager.c
@@ -73,7 +73,7 @@ void setup_pager(void)
 {
 	const char *pager =3D git_pager(isatty(1));
=20
-	if (!pager)
+	if (!pager || pager_in_use())
 		return;
=20
 	/*
--=20
1.7.8.36.g69ee2
