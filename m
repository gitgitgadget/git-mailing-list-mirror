Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DAAC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D96B610CD
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhFTPOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:14:34 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:15358 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhFTPOb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id F02A212FC
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201936; x=1626016337;
         bh=L7+XtauHck06ubzHlBTpnUza3s+jfaVwP9HiJ74yi2I=; b=r4gjZwNsN5Tc
        lrbDaEcFrAOzRDpB2+L1zHGgGbTAAc8YYzrIc/iuBGWLXIwz0zHceaGIuwoYRLpF
        wuag+y/XoCEGmgggMt2HSUs1P03DaSsddnqs+m0Kqbe75EpiGqwesHi70gHp8NaR
        DhqVFtcd0WMPrxbLAiGPF0Ui0Mzu98fAff3hdXcYO2cNKvFir4iLWMWfE1iyJpbi
        xHlJRsvCa1pJGiudCaAU7j+w1AXlxgJZHW2xZcJck/Z26c9hhhrMkz3VNdRAcN4I
        c+tJygtWtd+VbOabzQHrJ5VBuwlCtQEWG2rlnkbF7L6QL0kJPkWAp9TzA51IGgIn
        XuxGDrwYuxVkUnfcJzK7uEaRYVJUelzj4F02LXX7XaQ1j6H9CmUeLjnpnnV0KrSw
        k55r8LThs9UxHwCzHoeM2aV1qMgwSkdCptxWkSGuj4g5Hr4Dr+qWToBK8INtd/NQ
        mWOr0qBOchF06sEB/0IPwGp69TseziTT0sg6sIWJtkvu87IG+3NU5Tw0z++TGWZ/
        IDs4yJmDtHdYBLwksBIsA9sxJiU/bUqMO8FbBEXvagpAynfOqCqDUH3wkNpot0eE
        WihSw7LpNzVu2R2xHL8ygslVmDyav7oqAWQeluEx++82VjilNBuh8zn1PsSb89fg
        lSS1OAEjCEx6fb1CqCkIas7NUVCfeQ0=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gnSa79a3ojyf for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:16 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 69E595C1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:16 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id CB815A2E;
        Sun, 20 Jun 2021 17:12:14 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 04/12] builtin/for-each-repo: remove unnecessary argv copy to plug leak
Date:   Sun, 20 Jun 2021 17:11:56 +0200
Message-Id: <20210620151204.19260-5-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

cmd_for_each_repo() copies argv into args (a strvec), which is later
passed into run_command_on_repo(), which in turn copies that strvec onto
the end of child.args. The initial copy is unnecessary (we never modify
args). We therefore choose to just pass argv directly into
run_command_on_repo(), which lets us avoid the copy and fixes the leak.

LSAN output from t0068:

Direct leak of 192 byte(s) in 1 object(s) allocated from:
    #0 0x7f63bd4ab8b0 in realloc (/usr/lib64/libasan.so.4+0xdc8b0)
    #1 0x98d7e6 in xrealloc wrapper.c:126
    #2 0x916914 in strvec_push_nodup strvec.c:19
    #3 0x916a6e in strvec_push strvec.c:26
    #4 0x4be4eb in cmd_for_each_repo builtin/for-each-repo.c:49
    #5 0x410dcd in run_builtin git.c:475
    #6 0x410dcd in handle_builtin git.c:729
    #7 0x414087 in run_argv git.c:818
    #8 0x414087 in cmd_main git.c:949
    #9 0x40e9ec in main common-main.c:52
    #10 0x7f63bc9fa349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 22 byte(s) in 2 object(s) allocated from:
    #0 0x7f63bd445e30 in __interceptor_strdup (/usr/lib64/libasan.so.4+0x76e30)
    #1 0x98d698 in xstrdup wrapper.c:29
    #2 0x916a63 in strvec_push strvec.c:26
    #3 0x4be4eb in cmd_for_each_repo builtin/for-each-repo.c:49
    #4 0x410dcd in run_builtin git.c:475
    #5 0x410dcd in handle_builtin git.c:729
    #6 0x414087 in run_argv git.c:818
    #7 0x414087 in cmd_main git.c:949
    #8 0x40e9ec in main common-main.c:52
    #9 0x7f63bc9fa349 in __libc_start_main (/lib64/libc.so.6+0x24349)

See also discussion about the original implementation below - this code
appears to have evolved from a callback explaining the double-strvec-copy
pattern, but there's no strong reason to keep that now:
  https://lore.kernel.org/git/68bbeca5-314b-08ee-ef36-040e3f3814e9@gmail.com/

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 builtin/for-each-repo.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 52be64a437..fd86e5a861 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -10,18 +10,16 @@ static const char * const for_each_repo_usage[] = {
 	NULL
 };
 
-static int run_command_on_repo(const char *path,
-			       void *cbdata)
+static int run_command_on_repo(const char *path, int argc, const char ** argv)
 {
 	int i;
 	struct child_process child = CHILD_PROCESS_INIT;
-	struct strvec *args = (struct strvec *)cbdata;
 
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "-C", path, NULL);
 
-	for (i = 0; i < args->nr; i++)
-		strvec_push(&child.args, args->v[i]);
+	for (i = 0; i < argc; i++)
+		strvec_push(&child.args, argv[i]);
 
 	return run_command(&child);
 }
@@ -29,37 +27,33 @@ static int run_command_on_repo(const char *path,
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 {
 	static const char *config_key = NULL;
 	int i, result = 0;
 	const struct string_list *values;
-	struct strvec args = STRVEC_INIT;
 
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
 			   N_("config key storing a list of repository paths")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, for_each_repo_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	for (i = 0; i < argc; i++)
-		strvec_push(&args, argv[i]);
-
 	values = repo_config_get_value_multi(the_repository,
 					     config_key);
 
 	/*
 	 * Do nothing on an empty list, which is equivalent to the case
 	 * where the config variable does not exist at all.
 	 */
 	if (!values)
 		return 0;
 
 	for (i = 0; !result && i < values->nr; i++)
-		result = run_command_on_repo(values->items[i].string, &args);
+		result = run_command_on_repo(values->items[i].string, argc, argv);
 
 	return result;
 }
-- 
2.26.2

