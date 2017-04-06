Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89317209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 10:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757255AbdDFKYM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 06:24:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:42251 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757237AbdDFKXz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 06:23:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2A492AB5F;
        Thu,  6 Apr 2017 10:23:54 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] Fix stack-use-after-scope error reported by ASAN
 by GCC 7.
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <072afb58-6159-ddeb-b7dc-40a87e8c6ae7@suse.cz>
 <alpine.DEB.2.20.1704061051130.4268@virtualbox>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <28c22c5e-677b-1554-6156-4e31cc0f0913@suse.cz>
Date:   Thu, 6 Apr 2017 12:23:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1704061051130.4268@virtualbox>
Content-Type: multipart/mixed;
 boundary="------------FFC06FA19F54CF690EA8876B"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------FFC06FA19F54CF690EA8876B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 04/06/2017 10:55 AM, Johannes Schindelin wrote:
> Hi Martin,
> 
> On Thu, 6 Apr 2017, Martin Liška wrote:
> 
>> Following patch fixes issues that can be seen with -fsanitize=address on
>> GCC 7.
> 
> Good catch.

Yep, actually it was me who wrote the new use-after-scope support in GCC 7.
And I was bit pessimistic about real examples of such errors, but one popped
up very soon.

> 
> However, it may make more sense to switch to using the "args" field
> instead of the "argv" field: it is of type "struct argv_array" and is
> released automagically by finish_command().
> 
> In other words, you would use something like
> 
> @@ -600,7 +601,8 @@ static struct cmd2process
> *start_multi_file_filter(struct hashmap *hashmap, cons
>         process = &entry->process;
> 
>         child_process_init(process);
> -       process->argv = argv;
> +	argv_array_push(&process->args, cmd);
> 
> instead, making even for a nice LOC reduction.

Done that way, survives tests.

Martin

> 
> Ciao,
> Johannes
> 


--------------FFC06FA19F54CF690EA8876B
Content-Type: text/x-patch;
 name="0002-Fix-stack-use-after-scope-error-reported-by-ASAN-by-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-Fix-stack-use-after-scope-error-reported-by-ASAN-by-.pa";
 filename*1="tch"

From 4e80f9bddff3c29fefb3628e0e920ca265d55e65 Mon Sep 17 00:00:00 2001
From: marxin <mliska@suse.cz>
Date: Thu, 6 Apr 2017 11:40:24 +0200
Subject: [PATCH 2/2] Fix stack-use-after-scope error reported by ASAN by GCC
 7.

The use-after-scope is triggered here:
READ of size 8 at 0x7ffc4f674e20 thread T0
    #0 0x6f0b69 in finish_command /home/marxin/Programming/git/run-command.c:570
    #1 0x5b6101 in kill_multi_file_filter /home/marxin/Programming/git/convert.c:570
    #2 0x5b798a in kill_multi_file_filter /home/marxin/Programming/git/convert.c:770
---
 convert.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 8d652bf27..73eb28eb8 100644
--- a/convert.c
+++ b/convert.c
@@ -589,7 +589,6 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	int err;
 	struct cmd2process *entry;
 	struct child_process *process;
-	const char *argv[] = { cmd, NULL };
 	struct string_list cap_list = STRING_LIST_INIT_NODUP;
 	char *cap_buf;
 	const char *cap_name;
@@ -600,7 +599,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	process = &entry->process;
 
 	child_process_init(process);
-	process->argv = argv;
+	argv_array_push(&process->args, cmd);
 	process->use_shell = 1;
 	process->in = -1;
 	process->out = -1;
-- 
2.12.2


--------------FFC06FA19F54CF690EA8876B--
