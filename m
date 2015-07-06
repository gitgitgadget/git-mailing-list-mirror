From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 12/23] checkout: drop 'checkout_opts' dependency from prepare_linked_checkout
Date: Mon,  6 Jul 2015 13:30:49 -0400
Message-ID: <1436203860-846-13-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:32:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFp-00087w-BX
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbbGFRcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:32:23 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34017 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbbGFRbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:46 -0400
Received: by iebmu5 with SMTP id mu5so117797820ieb.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K43j/08pCcGpELM4kS+EMFz2QbOZnwLOpmiHW+cbQSw=;
        b=RlaoP4k5sMz8NCP7EgmerOzFUY5w0pW74XljlehWDhs85qv8/ZKkfSp7jueojlYy+G
         rZeKrfE4KGP9One0o/q/zWaW1Bqt+9F5y0hOh0iWPOVHXXbBZ93PhJQNaL32TAnuYbx6
         E6/UUhCEqNgF3j4SEIXO+YsaVrc47AAEIeqVurvMjYSe0mAuy0X/pB+hmnT5u1uJ++mp
         k4mgZ7g4SQOYeQwj9/hBTbFhaOvnuDDh/EeUg2Q73i6G2x1FtvlNoxX7ekJq9EmpRRpJ
         MZaGt1+TlFl4c4xeAcEgCcPuZfsGQwoH/X1EW3knKg+uqKW8tW2yng6rLi01MxfEZ7Ti
         rDNA==
X-Received: by 10.50.117.66 with SMTP id kc2mr44757215igb.31.1436203901175;
        Mon, 06 Jul 2015 10:31:41 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.39
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273424>

The plan is to relocate "git checkout --to" functionality to "git
worktree add", however, worktree.c won't have access to the 'struct
checkout_opts' passed to prepare_linked_worktree(), which it consults
for the pathname of the new worktree and the argv[] of the command it
should run to populate the new worktree. Facilitate relocation of
prepare_linked_worktree() by instead having it accept the pathname and
argv[] directly, thus eliminating the final references to 'struct
checkout_opts'.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 90bb3cd..e4064a8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -854,11 +854,11 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
 
-static int prepare_linked_checkout(const struct checkout_opts *opts)
+static int prepare_linked_checkout(const char *path, const char **child_argv)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
-	const char *path = opts->new_worktree, *name;
+	const char *name;
 	struct stat st;
 	struct child_process cp;
 	int counter = 0, len, ret;
@@ -943,7 +943,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts)
 	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
-	cp.argv = opts->saved_argv;
+	cp.argv = child_argv;
 	ret = run_command(&cp);
 	if (!ret) {
 		is_junk = 0;
@@ -1302,7 +1302,8 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (opts->new_worktree) {
 		if (!new->commit)
 			die(_("no branch specified"));
-		return prepare_linked_checkout(opts);
+		return prepare_linked_checkout(opts->new_worktree,
+					       opts->saved_argv);
 	}
 
 	if (!new->commit && opts->new_branch) {
-- 
2.5.0.rc1.197.g417e668
