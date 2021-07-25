Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56272C432BE
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD9260F11
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhGYM3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:29:11 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:26146 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230356AbhGYM2n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:28:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 8A363D65;
        Sun, 25 Jul 2021 15:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627218525; x=1629032926;
         bh=GH+iH7ohguPndgzqgfRzdQnYPzn47Zsc5b/cyc6Q3LE=; b=gIXXpUxtdpfD
        19GNDEK0jTGxwqE493m1rGhJ52N//NRwQd2LgQe7kdModg5nd5RzUB3N6zejvwBV
        oWuP0SfohTpE3g2e0hxILoIijDlQ3Xb6PEeH1Yh6d9DW+oQQOvk15W8ceEehZEcz
        czu9MfNI84xqxWHlIbSM8+p1383NP8JdyktPSqWglV1SMVqB3vy3faQTVLLm6Xt5
        ZPipFG7shBPJjbdjg5fFB55/tka0JTc8pmbLH7gi42rQ+A11IhlCjfjsvLUQG7hy
        Cx31FKfG7u3RpHRUdJ+VHc6c65jJNTliBe/FbM/LERqWtv9YDx87KQbiysT8Z7SN
        eIWbIsjt+2MRNdw2o5h4JZqmOq+Hc3CDIhbxMpakWC1uZESdFENdm+qxr8O/HZUd
        BTNiQqeyFu+hBni020Ukng5lyFuoX4XmNj6Qd+b+kE2m2kqrymq46UM4Wn+u/PUD
        SkrMIqDTnBbg7wGID8p3WFH1cExzqWmPCz2uwaur3UXIPjImJ2ybpZgdYGcU3U5j
        0e/3wlwonay21AhfmWaFRNA9FRK/sxavsZQ738X4KQ730jwDbcu74CGmg8Hx0zgO
        zYwOuV5V2JyfVBn3WgqwPZ5cObyCKvMDs95i4XA8Zt5VvgDyBKb84P0FTImowI7P
        KceK16sNW1jApJ3wxDYdPEeHNWcO5mM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HQZnKwyNYmnE; Sun, 25 Jul 2021 15:08:45 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id C4478702;
        Sun, 25 Jul 2021 15:08:44 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 1107B3F28;
        Sun, 25 Jul 2021 15:08:42 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: [PATCH v2 04/12] builtin/for-each-repo: remove unnecessary argv copy to plug leak
Date:   Sun, 25 Jul 2021 15:08:22 +0200
Message-Id: <20210725130830.5145-5-andrzej@ahunt.org>
In-Reply-To: <20210725130830.5145-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210725130830.5145-1-andrzej@ahunt.org>
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
@@ -31,7 +29,6 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	static const char *config_key = NULL;
 	int i, result = 0;
 	const struct string_list *values;
-	struct strvec args = STRVEC_INIT;
 
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
@@ -45,9 +42,6 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	for (i = 0; i < argc; i++)
-		strvec_push(&args, argv[i]);
-
 	values = repo_config_get_value_multi(the_repository,
 					     config_key);
 
@@ -59,7 +53,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 		return 0;
 
 	for (i = 0; !result && i < values->nr; i++)
-		result = run_command_on_repo(values->items[i].string, &args);
+		result = run_command_on_repo(values->items[i].string, argc, argv);
 
 	return result;
 }
-- 
2.26.2

