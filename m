Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A577C209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 08:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756827AbdDFICv (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 04:02:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:59334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756675AbdDFICr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 04:02:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3BFFDAC62
        for <git@vger.kernel.org>; Thu,  6 Apr 2017 08:02:46 +0000 (UTC)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH 2/2] Fix stack-use-after-scope error reported by ASAN by GCC
 7.
Message-ID: <072afb58-6159-ddeb-b7dc-40a87e8c6ae7@suse.cz>
Date:   Thu, 6 Apr 2017 10:02:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------20A9FF84E8D6B1D8852C1FFF"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------20A9FF84E8D6B1D8852C1FFF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello.

Following patch fixes issues that can be seen with -fsanitize=address on GCC 7.

Patch was tested with make test.

Thanks,
Martin

--------------20A9FF84E8D6B1D8852C1FFF
Content-Type: text/x-patch;
 name="0002-Fix-stack-use-after-scope-error-reported-by-ASAN-by-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-Fix-stack-use-after-scope-error-reported-by-ASAN-by-.pa";
 filename*1="tch"

From 79dace4bdac4f571c14c7edb9b1007c155475c3f Mon Sep 17 00:00:00 2001
From: marxin <mliska@suse.cz>
Date: Wed, 5 Apr 2017 14:32:29 +0200
Subject: [PATCH 2/2] Fix stack-use-after-scope error reported by ASAN by GCC
 7.

The use-after-scope is triggered here:
READ of size 8 at 0x7ffc4f674e20 thread T0
    #0 0x6f0b69 in finish_command /home/marxin/Programming/git/run-command.c:570
    #1 0x5b6101 in kill_multi_file_filter /home/marxin/Programming/git/convert.c:570
    #2 0x5b798a in kill_multi_file_filter /home/marxin/Programming/git/convert.c:770

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 convert.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 8d652bf27..bf4eaf10e 100644
--- a/convert.c
+++ b/convert.c
@@ -568,6 +568,7 @@ static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *
 	entry->process.clean_on_exit = 0;
 	kill(entry->process.pid, SIGTERM);
 	finish_command(&entry->process);
+	free(entry->process.argv);
 
 	hashmap_remove(hashmap, entry, NULL);
 	free(entry);
@@ -582,6 +583,7 @@ static void stop_multi_file_filter(struct child_process *process)
 	sigchain_pop(SIGPIPE);
 	/* Finish command will wait until the shutdown is complete. */
 	finish_command(process);
+	free(process->argv);
 }
 
 static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
@@ -589,7 +591,6 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	int err;
 	struct cmd2process *entry;
 	struct child_process *process;
-	const char *argv[] = { cmd, NULL };
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
@@ -600,7 +601,8 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	process = &entry->process;
 
 	child_process_init(process);
-	process->argv = argv;
+	process->argv = xcalloc(2, sizeof(const char *));
+	process->argv[0] = cmd;
 	process->use_shell = 1;
 	process->in = -1;
 	process->out = -1;
-- 
2.12.2


--------------20A9FF84E8D6B1D8852C1FFF--
