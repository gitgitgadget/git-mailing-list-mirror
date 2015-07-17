From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 14/22] worktree: add: suppress auto-vivication with --detach and no <branch>
Date: Fri, 17 Jul 2015 19:00:09 -0400
Message-ID: <1437174017-81687-15-git-send-email-sunshine@sunshineco.com>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEdK-0002NX-7X
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbbGQXB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:01:27 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34990 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbbGQXB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:01:26 -0400
Received: by igcqs7 with SMTP id qs7so47719250igc.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MkiZGMgWHBNRzJxZAmltUTJxH/diqq/TAr1jINoGTpU=;
        b=Cgz1kKBbuwkIdpRk7HL4qC3MTgwEUEaOyKFVEUlLRLEIeEc3W8+6/60UsSd6ycMTha
         wA8urARgF51oI+WckX7Jv+ir6X1L6Re/eVllSp4DIsIf39XTsM5qEPuFk7dStVJI7oqk
         QoB8HOEcxAW7UY75FoQhBqMnFbutOKLRQDN7rxuiEDdl50TkqqATNqIPLk6ddZNVm08E
         nLXkWyrfdlH1ChSvB489PB5ka7tVJvA4o5EH8pLMn/m0wBzsbNmIwXTp5vk+HnYbA/YD
         5SUcjuucJiHD22kyzKcZ1r5nAOZqt493CEWvnNcqHSF85kDoJnPKESMzyRtWQakeLUqA
         JLJA==
X-Received: by 10.107.149.14 with SMTP id x14mr19844153iod.87.1437174085651;
        Fri, 17 Jul 2015 16:01:25 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id 140sm8414824ion.16.2015.07.17.16.01.24
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 16:01:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.378.g0af52e8
In-Reply-To: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274135>

Fix oversight where branch auto-vivication incorrectly kicks in when
--detach is specified and <branch> omitted. Instead, treat:

    git worktree add --detach <path>

as shorthand for:

    git worktree add --detach <path> HEAD

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

New in v3.

 builtin/worktree.c      |  2 +-
 t/t2025-worktree-add.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 813e016..83484ad 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -308,7 +308,7 @@ static int add(int ac, const char **av, const char *prefix)
 	if (opts.force_new_branch)
 		opts.new_branch = new_branch_force;
 
-	if (ac < 2 && !opts.new_branch) {
+	if (ac < 2 && !opts.new_branch && !opts.detach) {
 		int n;
 		const char *s = worktree_basename(path, &n);
 		opts.new_branch = xstrndup(s, n);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 249e454..8267411 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -153,6 +153,14 @@ test_expect_success '"add -b" with <branch> omitted' '
 	test_cmp_rev HEAD burble
 '
 
+test_expect_success '"add --detach" with <branch> omitted' '
+	git worktree add --detach fishhook &&
+	git rev-parse HEAD >expected &&
+	git -C fishhook rev-parse HEAD >actual &&
+	test_cmp expected actual &&
+	test_must_fail git -C fishhook symbolic-ref HEAD
+'
+
 test_expect_success '"add" with <branch> omitted' '
 	git worktree add wiffle/bat &&
 	test_cmp_rev HEAD bat
@@ -167,6 +175,12 @@ test_expect_success '"add" auto-vivify does not clobber existing branch' '
 	test_path_is_missing precious
 '
 
+test_expect_success '"add" no auto-vivify with --detach and <branch> omitted' '
+	git worktree add --detach mish/mash &&
+	test_must_fail git rev-parse mash -- &&
+	test_must_fail git -C mish/mash symbolic-ref HEAD
+'
+
 test_expect_success '"add" -b/-B mutually exclusive' '
 	test_must_fail git worktree add -b poodle -B poodle bamboo master
 '
-- 
2.5.0.rc2.378.g0af52e8
