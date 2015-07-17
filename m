From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/22] checkout: die_if_checked_out: simplify strbuf management
Date: Fri, 17 Jul 2015 18:59:59 -0400
Message-ID: <1437174017-81687-5-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdD-0002J0-Os
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbbGQXBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:17 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:32954 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbbGQXBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:16 -0400
Received: by igbpg9 with SMTP id pg9so5820095igb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lHt/Ts+rr/CWaTIu+GgIHwE47cHOoTpe3Nx63jObXns=;
        b=e/D0rN7ryBrLNMH0SRb9QYlhfJ/LBQ+gaZMsvewTp23lFQqdhuFc4b2WpC6uKWs7U7
         TJaRw5WnBrgWwokNbIEq7QNs0iK3cSoATIoKoKVIeQs7JM0FUynJlTu2Vngyb1GD8L+y
         xNA9++fFNiKodpVorgaE9IUziZoVVJozosOiuppQOjevU5lBQH5MhKxgn5eH7spKg1GI
         406Dd5HzW/TN4YXD0YfxDYuAq9lWJtIuOv8rzFyj6TzuxxAXZLBGiQpEmmKiFC0n1VTh
         5kyICo4FzGyRHTNB34oWNebXjMoIMzhI/kFtJKWb+HEggs5N9w3wmytfIgsSEr2hNci7
         5azw==
X-Received: by 10.107.34.81 with SMTP id i78mr13431957ioi.40.1437174075698;
        Fri, 17 Jul 2015 16:01:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.14
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274131>

There is no reason to keep the strbuf active long after its last use.
By releasing it as early as possible, resource management is simplified
and there is less worry about future changes resulting in a leak.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

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
