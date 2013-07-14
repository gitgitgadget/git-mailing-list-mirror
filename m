From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/4] commit: Fix a memory leak in determine_author_info
Date: Sun, 14 Jul 2013 23:35:47 +0200
Message-ID: <1373837749-14402-2-git-send-email-stefanbeller@googlemail.com>
References: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 23:35:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyTxU-0001TD-Ts
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 23:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329Ab3GNVfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 17:35:50 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:51263 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab3GNVfq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 17:35:46 -0400
Received: by mail-ea0-f182.google.com with SMTP id d10so7401528eaj.41
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ukofOaQ9J6vSVCcJlo1Ya3KrYQ6IW+Pont7CH2S1vzg=;
        b=FaghuqCuNsgR+Fl6MeeCkTcrMbRLZ0TnTDMmK1oPcQ5sDxh5J1BxwHRaXbYlQjniRt
         Npd31xUg5uwf1hQwNCcJGg0Us/VddSzIPN2IkBusMDlhxJWXFDYCck/ySzNRZXeiNOJh
         3cRIMHFj+PR9Ho4l1FGhDyG90k07LIBOepXVl1pr1wkaZeiZboGrXgYWRyCeXUCyEd55
         NrCyD6ZxAhsairama46hqtKGbncrTmBvKdAV4OZPSw0L8bCcGEGa98YkLOXP2PoMuZ8k
         EE73ai/ie6uBId9Pa3DBa2D/gz5NBC/ceON6LnCcVGCMC9kz0gYN++Ni5KIrH1p6/CGO
         JAYw==
X-Received: by 10.15.44.67 with SMTP id y43mr20625247eev.20.1373837744743;
        Sun, 14 Jul 2013 14:35:44 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m1sm97494861eex.17.2013.07.14.14.35.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 14:35:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.806.gdee5b9b
In-Reply-To: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230394>

The date variable is assigned new memory via xmemdupz and 2 lines later
it is assigned new memory again via xmalloc, but the first assignment
is never freed nor used.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/commit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 790e5ab..00da83c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -528,19 +528,18 @@ static void determine_author_info(struct strbuf *author_ident)
 
 		if (lb == a + strlen("\nauthor "))
 			/* \nauthor <foo@example.com> */
 			name = xcalloc(1, 1);
 		else
 			name = xmemdupz(a + strlen("\nauthor "),
 					(lb - strlen(" ") -
 					 (a + strlen("\nauthor "))));
 		email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
-		date = xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
 		len = eol - (rb + strlen("> "));
 		date = xmalloc(len + 2);
 		*date = '@';
 		memcpy(date + 1, rb + strlen("> "), len);
 		date[len + 1] = '\0';
 	}
 
 	if (force_author) {
 		const char *lb = strstr(force_author, " <");
-- 
1.8.3.2.806.gdee5b9b
