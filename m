From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 03/11] Stop starting pager recursively
Date: Sat, 25 Feb 2012 18:41:10 +0700
Message-ID: <1330170078-29353-4-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 12:39:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1FyK-0001uW-SP
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 12:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408Ab2BYLjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 06:39:22 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52288 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389Ab2BYLjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 06:39:20 -0500
Received: by pbcup15 with SMTP id up15so414856pbc.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 03:39:20 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.135.71 as permitted sender) client-ip=10.68.135.71;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.135.71 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.135.71])
        by 10.68.135.71 with SMTP id pq7mr18482128pbb.27.1330169960216 (num_hops = 1);
        Sat, 25 Feb 2012 03:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=knPa6ATzZ5xp7ivXEt+FB9PURYNWcNev9lq4qXnFc8U=;
        b=gHx479RaFkXKfWXtJjUutD51Ci89upDrYgA9aCE0eI71ijPri2Lkxp+4wleB3XwXrs
         56SL0tZIGfSuxlPKXbyK+CtUDRuUycb47RLlH6RQsTpvvpzLRVAuG+dTI+98FFiUju/5
         dNrzyCaspwNDoawSQHh1+DmmsMsgNnIgrCpNE=
Received: by 10.68.135.71 with SMTP id pq7mr15335976pbb.27.1330169960181;
        Sat, 25 Feb 2012 03:39:20 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id y9sm7003656pbu.40.2012.02.25.03.39.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 03:39:19 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 25 Feb 2012 18:41:38 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191524>

git-column can be used as a pager for other git commands, something
like this:

    GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p branch

The problem with this is that "git -p column" also has $GIT_PAGER
set so the pager runs itself again as a pager, then again and again.

Stop this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
