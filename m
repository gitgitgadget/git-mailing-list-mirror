From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 13/22] worktree: make --detach mutually exclusive with -b/-B
Date: Fri, 17 Jul 2015 19:00:08 -0400
Message-ID: <1437174017-81687-14-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdj-0002al-2o
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbbGQXBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:54 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33408 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbbGQXBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:25 -0400
Received: by ietj16 with SMTP id j16so86625541iet.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xmO4+ebdtfNFXKDRkqH5LcNKajXN9pr9QSQLVSQi8o8=;
        b=kgb1lCwhppUFQUq7RcQyD7oZyRfI+OPpI3D1zFrlz/GPUtYOfjYqBsyheXmxatp/qP
         +dAMlbJK7g/TrsgzWviTmwJl5EO/bqhu40zScU/ehpbjgAA0DB4Kwt/wil2hTlvzcp4b
         0x1PXafcYIC6K4OG+jrydAmWn5IqQ6iK3NqXfQJTKvUhGhoyXNmXosoPfBzWFFdr1BqL
         VUS1HNlVxXESONgkKdPaKlL082UD7am/mZ3QOP6zHWWbLShfimqmkZs2DrTYdDP1xfzD
         IALdE+Z/r7OqttuhW6h/jvDxFiHcmr9IAFUvllctB+TVRxoDKLwb1lu/MehGWo0l0ht3
         J6yQ==
X-Received: by 10.107.169.10 with SMTP id s10mr20838072ioe.138.1437174084825;
        Fri, 17 Jul 2015 16:01:24 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.23
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274145>

Be consistent with git-checkout which disallows this (not particularly
meaningful) combination.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v2: add tests

 builtin/worktree.c      |  4 ++--
 t/t2025-worktree-add.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7d70eb6..813e016 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -296,8 +296,8 @@ static int add(int ac, const char **av, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
-	if (opts.new_branch && new_branch_force)
-		die(_("-b and -B are mutually exclusive"));
+	if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
+		die(_("-b, -B, and --detach are mutually exclusive"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 9e30690..249e454 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -167,4 +167,16 @@ test_expect_success '"add" auto-vivify does not clobber existing branch' '
 	test_path_is_missing precious
 '
 
+test_expect_success '"add" -b/-B mutually exclusive' '
+	test_must_fail git worktree add -b poodle -B poodle bamboo master
+'
+
+test_expect_success '"add" -b/--detach mutually exclusive' '
+	test_must_fail git worktree add -b poodle --detach bamboo master
+'
+
+test_expect_success '"add" -B/--detach mutually exclusive' '
+	test_must_fail git worktree add -B poodle --detach bamboo master
+'
+
 test_done
-- 
2.5.0.rc2.378.g0af52e8
