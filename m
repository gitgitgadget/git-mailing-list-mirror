Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B2CC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 22:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E706020732
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 22:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JnHPQaI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgFRWXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:23:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51050 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgFRWXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 18:23:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2997FDD210;
        Thu, 18 Jun 2020 18:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SN3kPYeHjl2ixc+YNPN0sQA2/aY=; b=JnHPQa
        I2CuxNcz6omZ95nA+7rZRa1r6XhBTerooKA+ttp+d7EDtCcS2RCIiL9MKHHge61G
        +JqIHu3tC8+T1R9QYZbjxxPkmvGT9D9lXTcPRCj9o7mzyZpt1doVS3yM1h1+cSb8
        fubi5EZynfBb6l33Ua5bg/oxHI+VYZPYl/ap4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fuXWJ/EOE6ncqpdTm9Otsxn09srpzJ1C
        3EGB9WOU++KrQkhlzPGL/tHFR2YP2Wm/rv61sJMpHqFxLT671aNHOI50fmhHGbN/
        CFLlxdXoD9Jj6X1+e9CvUBYy8hasm3AaVy57j/cNJe2DxccStQmKCRLRos8uRxL/
        V3kUfqWe57k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2183ADD20F;
        Thu, 18 Jun 2020 18:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C717DD20E;
        Thu, 18 Jun 2020 18:23:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3] refs: implement reference transaction hook
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
        <1de96b96e3448c8f7e7974f7c082fd08d2d14e96.1592475610.git.ps@pks.im>
Date:   Thu, 18 Jun 2020 15:23:07 -0700
In-Reply-To: <1de96b96e3448c8f7e7974f7c082fd08d2d14e96.1592475610.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 18 Jun 2020 12:27:43 +0200")
Message-ID: <xmqqo8pgko8k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A2723B6-B1B2-11EA-A5D8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +static const char hook_not_found;
> +static const char *hook;

;-)  Nice.

> +static int run_transaction_hook(struct ref_transaction *transaction,
> +				const char *state)
> +{
> +	struct child_process proc = CHILD_PROCESS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	int saved_errno = 0, ret, i;
> +...
> +	ret = start_command(&proc);
> +	if (ret)
> +		return ret;
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	for (i = 0; i < transaction->nr; i++) {
> +		struct ref_update *update = transaction->updates[i];
> + ...
> +		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
> +			if (errno != EPIPE)
> +				saved_errno = errno;
> +			break;
> +		}
> +	}
> +
> +	close(proc.in);
> +	sigchain_pop(SIGPIPE);
> +	strbuf_release(&buf);
> +
> +	ret = finish_command(&proc);
> +	if (ret)
> +		return ret;
> +
> +	return saved_errno;
> +}

OK, the only thing that looked a bit tricky was the "saved_errno"
that is used in an unusual (relative to its name) way.  The use
isn't incorrect per-se, but it rubs readers' expectation the wrong
way to use the variable named saved_errno for any purpose other than
the established pattern:

	saved_errno = errno;
	if (some_libcall_that_may_update_errno()) {
		... deal with an error and perform
		... some fallback action
	}
	errno = saved_errno;

that allows the caller to be oblivious to the library call that is
made as a mere implementation detail whose failure does not matter
to the caller.

In any case, the idea of the code in the patch is to make sure we
remember the fact that we failed to write (or caught any other
error, if we added more calls in the future) in a variable, and make
sure we return an error even if we manage to cleanly call
"finish_command()".  For that purpose, in order to avoid overwriting
the "ret" variable with the returned value from finish_command(), a
separate variable is needed, and "saved_errno" was picked for the
name of the variable.

But I do not think it is a good idea to return the errno in one
codepath when the function can return an error status that is not an
errno that is received from start_command() and finish_command().
The caller of this function cannot (and probably do not want to)
tell what the failed syscall was and would be checking if the return
value was success (=0) or failure (<0).

So I'd rather simplify the error handling to

 - Remove "saved_errno"; instead initialize ret to 0 at the beginning;

 - Return "ret" even if we return hardcoded 0 in the earlier part
   for consistency;

 - Update "ret" in the loop to -1 (the same error return status that
   is returned by start_command() and finish_command()) when we
   found a write error that we are not ignoring before breaking out
   of the loop.

 - We need to call finish_command() even if we earlier saw an error
   once we successfully called start_command().  So do something
   like this:

	ret |= finish_command(&proc);
	return ret;

   to make sure we retain an earlier error in "ret", we
   unconditionally call finish_command() when the control reaches
   there, and we mark the result a failure when finish_command()
   fails.

if I were writing this function.

Thanks.
