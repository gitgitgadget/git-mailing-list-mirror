Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033192036B
	for <e@80x24.org>; Wed,  4 Oct 2017 04:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdJDE7j (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 00:59:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64951 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751275AbdJDE7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 00:59:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E19B95B9F;
        Wed,  4 Oct 2017 00:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1O8djK2Zc0SrgL4tdrEuB/U+4JA=; b=BRqyTK
        q456wq/7BECydt7RbDZbPmbXdYxc01tVhx3Df6FwF/hUvVIgs5GwIRZHC3qtfwH8
        4He8GB4Uh/mU1bSMNg9nz2zYwkIw1+JmMO1BkV380VYO6gx7yT35oxap7KqSpPBj
        CcQXcV3fPEcleZzV4WTbNqtH71SNYe4XgOX7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eV1VEl0ewpuS9dLLqB4RfnnUzvsXyNkU
        EzS80SHWITXLpDaN6o1JzzpOCvp0CqWkUvCFvf2Efjb8gZjUL0a0DIn2TsAWcQnR
        qHnwz+TwYAtkNtsYAQR0ufuvVVoOD+biDKJWVbAE+uho9YIKb/YFMVb7sRRTZnge
        IPfd1tT6X+s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 757E895B9E;
        Wed,  4 Oct 2017 00:59:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9519195B9D;
        Wed,  4 Oct 2017 00:59:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] sub-process: allocate argv on the heap
References: <20171003195713.13395-1-t.gummerer@gmail.com>
        <20171003195713.13395-4-t.gummerer@gmail.com>
        <85456f81-9e9f-d0e4-86f7-9f546691dee3@kdbg.org>
Date:   Wed, 04 Oct 2017 13:59:31 +0900
In-Reply-To: <85456f81-9e9f-d0e4-86f7-9f546691dee3@kdbg.org> (Johannes Sixt's
        message of "Tue, 3 Oct 2017 22:24:57 +0200")
Message-ID: <xmqq7ewbecek.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF851B42-A8C0-11E7-BF84-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 03.10.2017 um 21:57 schrieb Thomas Gummerer:
>> diff --git a/sub-process.c b/sub-process.c
>> index 6dde5062be..4680af8193 100644
>> --- a/sub-process.c
>> +++ b/sub-process.c
>> @@ -77,7 +77,9 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
>>   {
>>   	int err;
>>   	struct child_process *process;
>> -	const char *argv[] = { cmd, NULL };
>> +	const char **argv = xmalloc(2 * sizeof(char *));
>> +	argv[0] = cmd;
>> +	argv[1] = NULL;
>>     	entry->cmd = cmd;
>>   	process = &entry->process;
>>
>
> Perhaps this should become
>
> 	argv_array_push(&process->args, cmd);
>
> so that there is no new memory leak?

Sounds like a good idea (if I am not grossly mistaken as to what is
being suggested).

Here is what I am planning to queue.

-- >8 --
From: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 3 Oct 2017 22:24:57 +0200
Subject: [PATCH] sub-process: use child_process.args instead of child_process.argv

Currently the argv is only allocated on the stack, and then assigned to
process->argv.  When the start_subprocess function goes out of scope,
the local argv variable is eliminated from the stack, but the pointer is
still kept around in process->argv.

Much later when we try to access the same process->argv in
finish_command, this leads us to access a memory location that no longer
contains what we want.  As argv0 is only used for printing errors, this
is not easily noticed in normal git operations.  However when running
t0021-conversion.sh through valgrind, valgrind rightfully complains:

==21024== Invalid read of size 8
==21024==    at 0x2ACF64: finish_command (run-command.c:869)
==21024==    by 0x2D6B18: subprocess_exit_handler (sub-process.c:72)
==21024==    by 0x2AB41E: cleanup_children (run-command.c:45)
==21024==    by 0x2AB526: cleanup_children_on_exit (run-command.c:81)
==21024==    by 0x54AD487: __run_exit_handlers (in /usr/lib/libc-2.26.so)
==21024==    by 0x54AD4D9: exit (in /usr/lib/libc-2.26.so)
==21024==    by 0x11A9EF: handle_builtin (git.c:550)
==21024==    by 0x11ABCC: run_argv (git.c:602)
==21024==    by 0x11AD8E: cmd_main (git.c:679)
==21024==    by 0x1BF125: main (common-main.c:43)
==21024==  Address 0x1ffeffec00 is on thread 1's stack
==21024==  1504 bytes below stack pointer
==21024==

These days, the child_process structure has its own args array, and
the standard way to set up its argv[] is to use that one, instead of
assigning to process->argv to point at an array that is outside.
Use that facility automatically fixes this issue.

Reported-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sub-process.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index fcc4832c14..648b3a3943 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -74,13 +74,12 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 {
 	int err;
 	struct child_process *process;
-	const char *argv[] = { cmd, NULL };
 
 	entry->cmd = cmd;
 	process = &entry->process;
 
 	child_process_init(process);
-	process->argv = argv;
+	argv_array_push(&process->args, cmd);
 	process->use_shell = 1;
 	process->in = -1;
 	process->out = -1;
-- 
2.14.2-889-gd2948f6aa6

