Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898A61F406
	for <e@80x24.org>; Fri, 12 Jan 2018 22:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965265AbeALWyF (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 17:54:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59838 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965257AbeALWyE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 17:54:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5436ABAC81;
        Fri, 12 Jan 2018 17:54:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HJe3ecyEts5bwetPY0q+tkY782Q=; b=vOQd/y
        n7BtFjoGVLWQ80ys8T9LvTJJL2fxbimzBP8O2rh1PzLFw2K6Sg81JjOH4XpxdqJQ
        AePpyOhmNWCGPvgmnQp9IQS1S/KtE2dduYjBQoeZbZhjwGhUnzIn6yHXhFz6vr+N
        ia2yGNNxvWIC4XXyZenjTEPBUYudyH9zqo5gs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BiV/i1rlXOkhcCotAlwwPgL83jX5ekYB
        7rETht6oxuY7rucmFwq2ejguC+yqHQh/glF1/Kkhz6oMROnfcwhJJCOkItgyI69v
        sEduTNnE13oY4sVG/Y+DGbtqOTZAUTlCoTci86kQBvAqvfFE0Z3uCPeBRv78ndMZ
        Yt0M2GM3zXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AE4DBAC80;
        Fri, 12 Jan 2018 17:54:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2EDCBAC7D;
        Fri, 12 Jan 2018 17:54:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 4/4] trace.c: be smart about what env to print in trace_run_command()
References: <20180111094712.2551-1-pclouds@gmail.com>
        <20180112095607.18293-1-pclouds@gmail.com>
        <20180112095607.18293-5-pclouds@gmail.com>
        <20180112133355.GE27499@sigill.intra.peff.net>
Date:   Fri, 12 Jan 2018 14:54:00 -0800
In-Reply-To: <20180112133355.GE27499@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 12 Jan 2018 08:33:55 -0500")
Message-ID: <xmqq7esmwuwn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B58EE8E-F7EB-11E7-A383-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also think this is a special case of a more general problem. FOO could
> appear any number of times in the "env" array, as a deletion or with
> multiple values. Our prep_childenv() would treat that as "last one
> wins", I think. Could we just do the same here?

Perhaps this should be squashed into the original 4/4 instead of
being a separate patch.  We'd probably want some sort of test, I
wonder?  Not tested at all beyond compiling...

-- >8 --
Subject: [PATCH 7/4] run-command.c: don't be too cute in concatenate_env()

Instead of relying on "sort" being stable to sort "unset VAR"
immediately before "VAR=VAL" to remove the former, just pick the
last manipulation for each VAR from the list of environment tweaks
and show them in the output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace.c | 68 ++++++++++++++++++++---------------------------------------------
 1 file changed, 21 insertions(+), 47 deletions(-)

diff --git a/trace.c b/trace.c
index aba2825044..9f49bcdd03 100644
--- a/trace.c
+++ b/trace.c
@@ -272,76 +272,50 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 
 #endif /* HAVE_VARIADIC_MACROS */
 
-static void sort_deltaenv(struct string_list *envs,
-			  const char *const *deltaenv)
+static void concatenate_env(struct strbuf *dst, const char *const *deltaenv)
 {
-	struct strbuf key = STRBUF_INIT;
+	struct string_list envs = STRING_LIST_INIT_DUP;
 	const char *const *e;
+	int i;
 
+	/* Last one wins... */
 	for (e = deltaenv; e && *e; e++) {
+		struct strbuf key = STRBUF_INIT;
 		char *equals = strchr(*e, '=');
 
 		if (equals) {
 			strbuf_reset(&key);
 			strbuf_add(&key, *e, equals - *e);
-			string_list_append(envs, key.buf)->util = equals + 1;
+			string_list_insert(&envs, key.buf)->util = equals + 1;
 		} else {
-			string_list_append(envs, *e)->util = NULL;
+			string_list_insert(&envs, *e)->util = NULL;
 		}
 	}
-	string_list_sort(envs);
-	strbuf_release(&key);
-}
-
-
-static void concatenate_env(struct strbuf *dst, const char *const *deltaenv)
-{
-	struct string_list envs = STRING_LIST_INIT_DUP;
-	int i;
-
-	/*
-	 * Construct a sorted string list consisting of the delta
-	 * env. We need this to detect the case when the same var is
-	 * deleted first, then added again.
-	 */
-	sort_deltaenv(&envs, deltaenv);
 
-	/*
-	 * variable deletion first because it's printed like separate
-	 * shell commands
-	 */
+	/* series of "unset X; unset Y;..." */
 	for (i = 0; i < envs.nr; i++) {
-		const char *env = envs.items[i].string;
-		const char *p = envs.items[i].util;
+		const char *var = envs.items[i].string;
+		const char *val = envs.items[i].util;
 
-		if (p || !getenv(env))
+		if (val)
 			continue;
-
-		/*
-		 * Do we have a sequence of "unset GIT_DIR; GIT_DIR=foo"?
-		 * Then don't bother with the unset thing.
-		 */
-		if (i + 1 < envs.nr &&
-		    !strcmp(env, envs.items[i + 1].string))
-			continue;
-
-		strbuf_addf(dst, " unset %s;", env);
+		if (getenv(var))
+			strbuf_addf(dst, " unset %s;", var);
 	}
 
+	/* ... followed by "A=B C=D ..." */
 	for (i = 0; i < envs.nr; i++) {
-		const char *env = envs.items[i].string;
-		const char *p = envs.items[i].util;
+		const char *var = envs.items[i].string;
+		const char *val = envs.items[i].util;
 		const char *old_value;
 
-		if (!p)
+		if (!val)
 			continue;
-
-		old_value = getenv(env);
-		if (old_value && !strcmp(old_value, p))
+		old_value = getenv(var);
+		if (old_value && !strcmp(old_value, val))
 			continue;
-
-		strbuf_addf(dst, " %s=", env);
-		sq_quote_buf_pretty(dst, p);
+		strbuf_addf(dst, " %s=", var);
+		sq_quote_buf_pretty(dst, val);
 	}
 	string_list_clear(&envs, 0);
 }
