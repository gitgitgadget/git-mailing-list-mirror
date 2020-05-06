Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA12C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BCE20708
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sicayi/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgEFS4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 14:56:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65008 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgEFS4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 14:56:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31EDAC6634;
        Wed,  6 May 2020 14:56:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:sender:date:in-reply-to:message-id
        :mime-version:content-type; s=sasl; bh=Fgz8iNOPisSqsBguVE6GeVw8A
        6g=; b=sicayi/tKCAzgk+S5f8ga2sSDBWG+GMMjRLBu1+baQFjBK4CdVJb8rL6n
        LYTuPOMcfJjKS5EZ2QFKw12KY2ydu55Ztsnd4gKhb3qa7UbXbN7Mcant9VjOAjb7
        7o1szne48DyjdkmJ008i0IP6zutL47ldsLN9hYVD0Zk6F4g8lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:sender:date:in-reply-to:message-id
        :mime-version:content-type; q=dns; s=sasl; b=XMzX7kej4yUSft7HHgT
        /J8lMYh2idDjZcMXtEIP1mDuZw5xxJ1b688bTnhb+3Sdo3ug3bulrai+GYAcLkPS
        3fAKnKsdDt/ECE4p0l1QjWNBrhVr7Ki+fiyRLXJbpYSOsJRiSez1iW+Wiahksei7
        L2fNU2FgsbQTCI+X6SqEgANk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A6B6C6631;
        Wed,  6 May 2020 14:56:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6FDD8C6630;
        Wed,  6 May 2020 14:56:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pierrick Gaudry <pierrick.gaudry@loria.fr>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re* option -q not passed from "git commit" to "git gc --auto"
References: <20200506094327.GC31637@rillettes>
        <xmqqd07h6kcs.fsf@gitster.c.googlers.com>
Date:   Wed, 06 May 2020 11:56:04 -0700
In-Reply-To: <xmqqd07h6kcs.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 06 May 2020 10:31:31 -0700")
Message-ID: <xmqqpnbg6gfv.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DB6A16E-8FCB-11EA-98B4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> An illustration to cover these (not even compile tested) to show
> what I mean and help anybody get started.


And this would be a good first step in the conversion.

-- >8 --
Subject: [PATCH] run_auto_gc(): extract a reusable helper

Earlier we taught "git fetch --quiet" to pass the "--quiet" option
down to "gc --auto".  This, however, is not limited to "fetch":

    $ git grep -e 'gc.*--auto' \*.c

finds hits in "am", "commit", "merge", and "rebase".

As a preparatory step, let's introduce a helper function
run_auto_gc(), that the caller can pass a boolean "quiet".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 10 ++--------
 run-command.c   | 13 +++++++++++++
 run-command.h   |  5 +++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bf6bab80fa..3e580b9559 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1759,7 +1759,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	struct remote *remote = NULL;
 	int result = 0;
 	int prune_tags_ok = 1;
-	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
 
 	packet_trace_identity("fetch");
 
@@ -1886,13 +1885,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	close_object_store(the_repository->objects);
 
-	if (enable_auto_gc) {
-		argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
-		if (verbosity < 0)
-			argv_array_push(&argv_gc_auto, "--quiet");
-		run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
-		argv_array_clear(&argv_gc_auto);
-	}
+	if (enable_auto_gc)
+		run_auto_gc(verbosity < 0);
 
 	return result;
 }
diff --git a/run-command.c b/run-command.c
index f5e1149f9b..2771eb936f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1864,3 +1864,16 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 
 	return result;
 }
+
+int run_auto_gc(int quiet)
+{
+	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
+	int status;
+
+	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+	if (quiet)
+		argv_array_push(&argv_gc_auto, "--quiet");
+	status = run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
+	argv_array_clear(&argv_gc_auto);
+	return status;
+}
diff --git a/run-command.h b/run-command.h
index 0f3cc73ab6..191dfcdafe 100644
--- a/run-command.h
+++ b/run-command.h
@@ -218,6 +218,11 @@ LAST_ARG_MUST_BE_NULL
 int run_hook_le(const char *const *env, const char *name, ...);
 int run_hook_ve(const char *const *env, const char *name, va_list args);
 
+/*
+ * Trigger an auto-gc
+ */
+int run_auto_gc(int quiet);
+
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
