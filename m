From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/20] checkout: avoid resolving HEAD unnecessarily
Date: Thu, 16 Jul 2015 04:20:06 -0400
Message-ID: <1437034825-32054-2-git-send-email-sunshine@sunshineco.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 10:20:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFePa-0008Dm-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 10:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbbGPIUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 04:20:53 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36320 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbbGPIUt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 04:20:49 -0400
Received: by ieik3 with SMTP id k3so51217702iei.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eFHOjIfh4wpa6h2S0rNniLzgAC8XljKnJrECYnvKmxc=;
        b=CqBvsn5z88mfoiFEGciWOHNGMHDZvXwX2Jfgrmo+QyEFwCWUaBwpuFix9IVHTSfBGj
         FMX+SZIGJ3uSg/aWbysy1bVs8ynhKVkqNgA27Lpq33q6JfJSWM+yNIhQI8ECaBIiEUrA
         eAP9d1qh77sVC4+eHSq46rWF6vB65RKx7DAK9SYSfuij9OatZwzFJF31ald3V9mjZGHH
         QtegOrBC0cT+jMA0IWFO3B1+DRgr+5Rs8eJcT2eFXP6PQ26ecFL7qejmDS6ZP6N9YEIV
         n2NPN5Vq7dWOUeUtyCGyyfH5PHRETRKabkHIJCanuYTFIj3s1sCzQQPVvKyHw4A8W/ga
         KK4A==
X-Received: by 10.107.133.94 with SMTP id h91mr11278533iod.1.1437034848939;
        Thu, 16 Jul 2015 01:20:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm4581146iod.25.2015.07.16.01.20.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jul 2015 01:20:48 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274010>

When --ignore-other-worktree is specified, we unconditionally skip the
check to see if the requested branch is already checked out in a linked
worktree. Since we know that we will be skipping that check, there is no
need to resolve HEAD in order to detect other conditions under which we
may skip the check.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

 builtin/checkout.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5754554..75f90a9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1145,13 +1145,13 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new->name);
 
-	if (new->path && !opts->force_detach && !opts->new_branch) {
+	if (new->path && !opts->force_detach && !opts->new_branch &&
+	    !opts->ignore_other_worktrees) {
 		unsigned char sha1[20];
 		int flag;
 		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
-		    !opts->ignore_other_worktrees)
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
 			check_linked_checkouts(new);
 		free(head_ref);
 	}
-- 
2.5.0.rc2.378.g0af52e8
