Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED443C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359465AbhKZIVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54362 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346253AbhKZITf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88A79105676;
        Fri, 26 Nov 2021 03:16:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T4a2jfb8GcCX22mdAKxeqklRwx30NHF3yQoKXD
        qijvY=; b=twaog8q7mafCL9XvT1ogRU5WpkUkKtYAY7GJmY3pKQUcecFtCiUQuV
        X/oARaXgBCzLTbb7dINrVn5IJZd1PvFsLQ2OS0XMZCAHgnF50qhH+pK8Y0FVfazo
        udOU+eI0L2GVM78CeE80HAUnmkDLUVn9cE/HNEGNvkqWKE0r6t5a4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 802FD105675;
        Fri, 26 Nov 2021 03:16:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0F89105674;
        Fri, 26 Nov 2021 03:16:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] refs/debug: trim trailing LF from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <0288e743eb2e96e2effd6b0b90c6f885009bf337.1637855872.git.gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 00:16:20 -0800
In-Reply-To: <0288e743eb2e96e2effd6b0b90c6f885009bf337.1637855872.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 25 Nov 2021
        15:57:52 +0000")
Message-ID: <xmqqilwf72nf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23CB2C6C-4E91-11EC-81F2-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> On iteration, the reflog message is always terminated by a newline. Trim it to
> avoid clobbering the console with is this extra newline.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs/debug.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/refs/debug.c b/refs/debug.c
> index 8667c640237..2631210795b 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -284,15 +284,21 @@ static int debug_print_reflog_ent(struct object_id *old_oid,
>  	int ret;
>  	char o[GIT_MAX_HEXSZ + 1] = "null";
>  	char n[GIT_MAX_HEXSZ + 1] = "null";
> +	struct strbuf trimmed = STRBUF_INIT;
>  	if (old_oid)
>  		oid_to_hex_r(o, old_oid);
>  	if (new_oid)
>  		oid_to_hex_r(n, new_oid);
>  
> +	strbuf_addstr(&trimmed, msg);
>  	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
>  		      dbg->cb_data);
> -	trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
> -		dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
> +	strbuf_trim_trailing_newline(&trimmed);

The API promises to have only LF, not CRLF, at the end, so
strbuf_trim_trailing_newline() is a bit overkill (and if payload
happened to end with CR, we would lose it).

> +	trace_printf_key(&trace_refs,
> +			 "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
> +			 dbg->refname, ret, o, n, committer,
> +			 (long int)timestamp, trimmed.buf);
> +	strbuf_release(&trimmed);
>  	return ret;
>  }

Can we use counted bytes in trace_printf()?  If we can, it would be
simpler to just scan "msg" for LF and then show only the span
between the beginning of the string and the found LF using "%.*s",
perhaps like this?

 refs/debug.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git c/refs/debug.c w/refs/debug.c
index 8667c64023..c97eeb5740 100644
--- c/refs/debug.c
+++ w/refs/debug.c
@@ -284,15 +284,20 @@ static int debug_print_reflog_ent(struct object_id *old_oid,
 	int ret;
 	char o[GIT_MAX_HEXSZ + 1] = "null";
 	char n[GIT_MAX_HEXSZ + 1] = "null";
+	int msglen;
+
 	if (old_oid)
 		oid_to_hex_r(o, old_oid);
 	if (new_oid)
 		oid_to_hex_r(n, new_oid);
 
+	msglen = strchrnul(msg, '\n') - msg;
 	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
 		      dbg->cb_data);
-	trace_printf_key(&trace_refs, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
-		dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
+	trace_printf_key(&trace_refs,
+			 "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%.*s\"\n",
+			 dbg->refname, ret, o, n, committer, (long int)timestamp,
+			 (int)msglen, msg);
 	return ret;
 }
 
