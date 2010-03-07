From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/18] builtin: USE_PAGER should not be used without RUN_SETUP*
Date: Sun,  7 Mar 2010 11:55:56 +0700
Message-ID: <1267937767-12504-8-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:06:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8gz-0000yt-Dz
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209Ab0CGFGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:06:13 -0500
Received: from mail-px0-f188.google.com ([209.85.216.188]:36275 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab0CGFGM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:06:12 -0500
Received: by pxi26 with SMTP id 26so1739051pxi.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UFsk1mqHxfAVAZHhGKOoCjJK1xCgCllmtt1HUgVcvB8=;
        b=aypXPe7tFIWrMspQJNwqWdI7Yg7Lde1w86CgemMFXQHSVU9JXXXkyUWFUCXed7p0uG
         zDRqhTuID7ImcKEVJExUkqNNgLKVe4wq/sKOx/wU4cq8eUcwnJ8dIUv92TOfdC7PWNvW
         zafyIXQkgyRfLzJRkVUFiRcGfFpScb/p2MvjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nJznybkNkPT1hcpi2gmsn1/qe+6svb1QLFWVIHmdtqVWYEjKOnB/QIdbshhcOmDzAL
         1n+1qHGRlN5OjBMUHej5vhLqTmad7g/BenbQuar7YpTXrEWduvIV3SMNJF1YyIiwbq2e
         1thE0/pgSct9nnNgzIrwNIcITlg+FYYsDuQhA=
Received: by 10.140.58.2 with SMTP id g2mr2024595rva.156.1267937993869;
        Sat, 06 Mar 2010 20:59:53 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 21sm3263599pzk.0.2010.03.06.20.59.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 20:59:53 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:38 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141664>

USE_PAGER may need core.pager from repository. So a repository search
should be done before core.pager is read.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 3904fe2..84dd78e 100644
--- a/git.c
+++ b/git.c
@@ -253,8 +253,11 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
 			use_pager =3D check_pager_config(p->cmd);
-		if (use_pager =3D=3D -1 && p->option & USE_PAGER)
+		if (use_pager =3D=3D -1 && p->option & USE_PAGER) {
+			if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) =3D=3D 0)
+				die("Internal error: USE_PAGER must be together with RUN_SETUP*");
 			use_pager =3D 1;
+		}
 	}
 	commit_pager_choice();
=20
--=20
1.7.0.195.g637a2
