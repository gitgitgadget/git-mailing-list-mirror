From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/23] checkout: relocate --to's "no branch specified" check
Date: Fri,  3 Jul 2015 20:17:18 -0400
Message-ID: <1435969052-540-10-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAZ-0000B6-Ue
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857AbbGDASy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:18:54 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36718 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbbGDASf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:35 -0400
Received: by igrv9 with SMTP id v9so124749635igr.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KWjAunqQeUpYrc0/oXlh8SP+i6+36WHjkrijRfSYO0k=;
        b=SJsf7Rstihf6I+TBG8ksxbZqW9mxQ+umR2HPQYWbOHxSEtKFogNTaPDLZEFE63agY8
         dUPRJe9cdE6hxaU0TWsIoxWQ8a+m0yaRvMfknLAhOHewKz0HKGubBQ/NpoyuGA7hkh3I
         KrdB5c6oR3dZ3GMCcXLSEypCMA3WsdeJ6qAqNmzrXVWudDV11wsnckXyDjEocXgKJK/T
         RMm+uCQNkVcCHXRwKmbvpUNkbe5uF9VcsFnMOiq5Ac4WjB+3A2yLH/BJsvz7m5RvgMos
         Q2eHN6ShCEbvfesXxaWXg1pKq2zxJ/1RnIRE3v8lVBGn5UmWirHbD6dKIE6aFpaC46oT
         4OQw==
X-Received: by 10.50.79.196 with SMTP id l4mr53719772igx.48.1435969114336;
        Fri, 03 Jul 2015 17:18:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.33
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273322>

The plan is to relocate "git checkout --to" functionality to "git
worktree add", however, this check expects a 'struct branch_info' which
git-worktree won't have at hand. It will, however, have access to its
own command-line from which it can pick up the branch name. Therefore,
as a preparatory step, rather than having prepare_linked_checkout()
perform this check, make it the caller's responsibility.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f5f953d..0cb81ee 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -865,8 +865,6 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	int counter = 0, len, ret;
 	unsigned char rev[20];
 
-	if (!new->commit)
-		die(_("no branch specified"));
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
@@ -1298,8 +1296,11 @@ static int checkout_branch(struct checkout_opts *opts,
 		free(head_ref);
 	}
 
-	if (opts->new_worktree)
+	if (opts->new_worktree) {
+		if (!new->commit)
+			die(_("no branch specified"));
 		return prepare_linked_checkout(opts, new);
+	}
 
 	if (!new->commit && opts->new_branch) {
 		unsigned char rev[20];
-- 
2.5.0.rc1.197.g417e668
