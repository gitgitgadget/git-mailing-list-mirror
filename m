From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] commit: Fix a memory leak in determine_author_info
Date: Sun, 14 Jul 2013 16:01:03 +0200
Message-ID: <1373810463-7144-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 16:01:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyMrK-0003Ez-HH
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 16:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab3GNOBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 10:01:03 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:32936 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab3GNOBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 10:01:01 -0400
Received: by mail-we0-f170.google.com with SMTP id w57so9488584wes.15
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JTC1luq+MFQD/1Ns63X+zXZL9PgLRKvXT0L5eZdAe1k=;
        b=00+viyYhdwLjucisR7JEM7m1O89eVfZwJI+Yt3MVGfS9xS47dV9Nsvkg3SHpPS1QRy
         KxeWjpDNKj4dugPSG7eFHovc1Wd2okNkgcayItB/qBeJwuHlMDFldYSMf3cU0bnpI9l+
         aldJp5Dfc1x7NlPhNh01ccPcErdNvp/OJkbqyAltc6yopcotTVbyz6sODl1K+r48vlch
         lbQrEJHGi8a2CbcSEQi8MK8f7fzNAnYVTXDfmKh/+rSuACJbtZv5ph2ajmG7gtqeVqJE
         XEEEyrIMBJsTY0CCIvA7TaT6AtbQrXCrT4/nclEQiJY2qwp5b7ZFlF5aaJle9UbxC2JG
         llvw==
X-Received: by 10.180.184.12 with SMTP id eq12mr6235606wic.8.1373810460280;
        Sun, 14 Jul 2013 07:01:00 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id fb2sm14663152wic.4.2013.07.14.07.00.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 07:00:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.806.gdee5b9b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230364>

The date variable is assigned new memory via xmemdupz and 2 lines later
it is assigned new memory again via xmalloc, but the first assignment
is never freed nor used.
---
 builtin/commit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 790e5ab..00da83c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -534,7 +534,6 @@ static void determine_author_info(struct strbuf *author_ident)
 					(lb - strlen(" ") -
 					 (a + strlen("\nauthor "))));
 		email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
-		date = xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
 		len = eol - (rb + strlen("> "));
 		date = xmalloc(len + 2);
 		*date = '@';
-- 
1.8.3.2.806.gdee5b9b
