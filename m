From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/20] checkout: die_if_checked_out: simplify strbuf management
Date: Thu, 16 Jul 2015 04:20:09 -0400
Message-ID: <1437034825-32054-5-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:23:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFeSD-0000y8-3f
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbbGPIXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:23:24 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36572 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbbGPIUw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:52 -0400
Received: by igbij6 with SMTP id ij6so8311709igb.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYVfgXQL0yECP3724k6htyEKstHh8HFsmYToO66w/bg=;
        b=lnQIZzdr91nDNBU7futwyVB/GenY54loxBqORWjAsPjhFkjXSsCUjNH/77wXeCGBX9
         iOqyNWHkU1oFczWQgODdU7Fx+PG5CP0X0bFxf0tA6l78DILMOxrUIEjmN+dp4ZrHpsfZ
         Z9Z6+tmZZPDC1H6tNSVL+M4nEDKA0QDxbpj3dYrYKt2LBE4cY8UuN0Jh84MVXpF/GsBr
         4cvZ4qxxcQ0kXO0plqriOoGeEI/KE6P6707j4OB62UpVV76T7spcUbvMCh4y/1ogyG0q
         NqRZmW3d7FZP1OwI4eZ0+hP/Mk/F1bqJT9ZfzmhK5fhQlfVfzM+f+W3nEJ72lybIVFYp
         C/qA==
X-Received: by 10.107.12.143 with SMTP id 15mr11072530iom.75.1437034851377;
        Thu, 16 Jul 2015 01:20:51 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.50
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274028>

There is no reason to keep the strbuf active long after its last use.
By releasing it as early as possible, resource management is simplified
and there is less worry about future changes resulting in a leak.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

 builtin/checkout.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1992c41..c36bf8a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -924,17 +924,16 @@ static void die_if_checked_out(struct branch_info *new)
 	check_linked_checkout(new, NULL);
 
 	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
-	if ((dir = opendir(path.buf)) == NULL) {
-		strbuf_release(&path);
+	dir = opendir(path.buf);
+	strbuf_release(&path);
+	if (!dir)
 		return;
-	}
 
 	while ((d = readdir(dir)) != NULL) {
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 		check_linked_checkout(new, d->d_name);
 	}
-	strbuf_release(&path);
 	closedir(dir);
 }
 
-- 
2.5.0.rc2.378.g0af52e8
