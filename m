From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 01/22] checkout: avoid resolving HEAD unnecessarily
Date: Fri, 17 Jul 2015 18:59:56 -0400
Message-ID: <1437174017-81687-2-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEd3-0002EW-Vm
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbbGQXBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:14 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37578 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbbGQXBN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:13 -0400
Received: by igbpg9 with SMTP id pg9so47227107igb.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rNwPdCPu6cv3YWomNlPY2P/TaFre+vALCrVwrcxlM4w=;
        b=LaCK1VegfvIftroLif6qGZUdrNJsjZPHdyFIcBTM5ay06qcF49rJutXklf7lrocBLC
         stDj+E4CjWkr3uFjb09+6F7JbVNy5pH8FSxjWZYqrrbBAnaTbrTy7Rdt7QhwcTiBQWRU
         +W/6QPM8CVwh2bFEyAcOPF9wiFmJWqYnMlCCM+JYrPkudihZ4MRAx6S+w8JXpyhzpGil
         he0QpVNJw4w+zR5ciq4PbiKdHzoXnq5eC6jK2gbTu8ygEfzV3G7y2sEgHwtx/SUdQ6KM
         NGey7aYCUlDi8I1KxIobPg8Cqu6HU1zZXBa8o054i4FnOd5ubOS5DWKIrRPXbrMy9VtO
         xp7g==
X-Received: by 10.107.161.206 with SMTP id k197mr20842930ioe.100.1437174072709;
        Fri, 17 Jul 2015 16:01:12 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.11
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274128>

When --ignore-other-worktree is specified, we unconditionally skip the
check to see if the requested branch is already checked out in a linked
worktree. Since we know that we will be skipping that check, there is no
need to resolve HEAD in order to detect other conditions under which we
may skip the check.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v2.

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
