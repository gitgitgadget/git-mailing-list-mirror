From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 01/16] checkout: avoid resolving HEAD unnecessarily
Date: Fri, 10 Jul 2015 20:05:31 -0400
Message-ID: <1436573146-3893-2-git-send-email-sunshine@sunshineco.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:19:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDp4m-0004rs-TZ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbbGKHTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:19:52 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34912 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbbGKHTw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:19:52 -0400
Received: by iecuq6 with SMTP id uq6so208888342iec.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pd9ZSYDRH7lQqrsO0hFZPu7Hs8zDISbasOjHc7snyJk=;
        b=GOh9LfB3bjuozGG8MMhQOO/JV9v3tJUVKW7gIkgIbVkMQ86ejzFapgLZR1NnICTOi3
         ytg6JRUwd5z2frzKWdhvhtL0OqJLWpiSsEIE9FYH0C5bUY80N80+uydxwyM2AC2itc2t
         jyg7qcB5tcMkc7Icgel3h5q/tiFsBMhWz0LdID74ijilq3uT7IyYsoDySLEggoHio06v
         TMPcIcgd/IrXHjVZSnkk5xaKHj26W7TKFduwK3uRMBjwfYgDaJQ9HqCB2dIFKRkATAgk
         snrd++JoKt7ylknlYwb9tzm9pI0FK/iQ6dBzpbDDV2eh+0koTEu9v4SrBln7WIPlfFkY
         bLCw==
X-Received: by 10.107.163.16 with SMTP id m16mr34771245ioe.31.1436573188872;
        Fri, 10 Jul 2015 17:06:28 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.27
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
In-Reply-To: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273861>

When --ignore-other-worktree is specified, we unconditionally skip the
check to see if the requested branch is already checked out in a linked
worktree. Since we know that we will be skipping that check, there is no
need to resolve HEAD in order to detect other conditions under which we
may skip the check.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
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
2.5.0.rc1.201.ga12d9f8
