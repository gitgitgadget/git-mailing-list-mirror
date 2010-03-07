From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/12] setup_pager(): save terminal width before redirecting stdout
Date: Sun,  7 Mar 2010 19:09:35 +0700
Message-ID: <1267963785-473-3-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:13:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFMY-0006M7-NX
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab0CGMNQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:16 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:43117 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab0CGMNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:11 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so2186141pzk.4
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=35QGZVWqJ/skrWNBKPrXj8bBJUBwP/n/PluWAvO4n8k=;
        b=dWANEUw6Mct/9BxQsB7BJ1p8rZ0gbcXUet6hS1CFqenxBt3Ki8tTgxH+SrGPk6LVJL
         A9g/5UWR92q+Snc/x31R4fpFVPAWtLLAEQI/UnEZ9Nw4j3zDGqHlCoRnFCDuChdgvmSF
         YZonMSi0DrfMEPessufrW9bE7d9XiRhJHGVak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=e0n3pVlYlWuVjuDfmf9exkMXwgAwu+bq7t3fzjEMzv5Kks+Xgb0i44WpW3qcuJXwGH
         BXQkgRxPRNhPEEVERuCtvLxpkQANPZYf0HZW6Zuyq9d2ocPMt0AccYON0ynPy7+Zb3In
         JDOPmVQIxv0DcALQ1NZ0DqJvTPD+X6IVWYNkQ=
Received: by 10.141.214.1 with SMTP id r1mr2219967rvq.251.1267963991201;
        Sun, 07 Mar 2010 04:13:11 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 22sm3612843pzk.1.2010.03.07.04.13.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:09:55 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141677>

After redirecting, we may no longer read terminal width.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pager.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/pager.c b/pager.c
index fc6c3e0..ad447cf 100644
--- a/pager.c
+++ b/pager.c
@@ -81,6 +81,15 @@ void setup_pager(void)
=20
 	spawned_pager =3D 1; /* means we are emitting to terminal */
=20
+#ifdef TIOCGWINSZ
+	{
+		struct winsize ws;
+		if (!ioctl(1, TIOCGWINSZ, &ws)) {
+			if (ws.ws_col)
+				max_columns =3D ws.ws_col;
+		}
+	}
+#endif
 	/* spawn the pager */
 	pager_argv[0] =3D pager;
 	pager_process.use_shell =3D 1;
--=20
1.7.0.1.370.gd3c5
