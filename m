Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF788C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 867282074B
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TKHuKxz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgFBRsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:48:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65143 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBRsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 13:48:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12B78CBCB2;
        Tue,  2 Jun 2020 13:48:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AX8QCqluyfOfIOcbigQG84azvmg=; b=TKHuKx
        z5rZG6SnU9tV8mI0UDDiYz/4+07SRcdiEANfWIeZ1uQy/PhUvawi2m08pFXeL7+8
        AneuYnvlq3PWDQt205q87IQXqpUrVmd9fmQwpJoNidYj6wMEg5XYQ+vysQkSzepc
        zIYmMq19zjoHmdzwAUi1lcV2vzpO1TvpuFsSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oy0vgvxJTySRO8KJ/EOH2F/FiUSD/UmB
        6/gdbFswwg9cwvgaQmNBISXqvYb2R1+ZESm3t4k9PVjEw0ry7KXXCGnoxjXpYwJD
        juELCQCTytwKW497AZNS25Xa9FHRQNVDQZ7zImjrTJ1zkUIBf8qlv+d+gZsiR88S
        ALvC7bjMQ38=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B218CBCAE;
        Tue,  2 Jun 2020 13:48:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42CD5CBCAA;
        Tue,  2 Jun 2020 13:47:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: implement reference transaction hooks
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
Date:   Tue, 02 Jun 2020 10:47:55 -0700
In-Reply-To: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 2 Jun 2020 10:25:44 +0200")
Message-ID: <xmqq4krttl4k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3186285E-A4F9-11EA-96BE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The above scenario is the motivation for a set of three new hooks that
> reach directly into Git's reference transaction. Each of the following
> new hooks (currently) doesn't accept any parameters and receives the set
> of queued reference updates via stdin:

Do we have something (e.g. performance measurement) to convince
ourselves that this won't incur unacceptable levels of overhead in
null cases where there is no hook installed in the repository?

> +static int run_transaction_hook(struct ref_transaction *transaction,
> +				const char *hook_name)
> +{
> +	struct child_process proc = CHILD_PROCESS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *argv[2];
> +	int code, i;
> +
> +	argv[0] = find_hook(hook_name);
> +	if (!argv[0])
> +		return 0;
> +
> +	argv[1] = NULL;
> +
> +	proc.argv = argv;

Let's use proc.args and argv_push() API in newly introduced code
instead.

> +	proc.in = -1;
> +	proc.stdout_to_stderr = 1;
> +	proc.trace2_hook_name = hook_name;
> +
> +	code = start_command(&proc);
> +	if (code)
> +		return code;
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	for (i = 0; i < transaction->nr; i++) {
> +		struct ref_update *update = transaction->updates[i];
> +
> +		strbuf_reset(&buf);
> +		strbuf_addf(&buf, "%s %s %s\n",
> +			    oid_to_hex(&update->old_oid),
> +			    oid_to_hex(&update->new_oid),
> +			    update->refname);
> +
> +		if (write_in_full(proc.in, buf.buf, buf.len) < 0)
> +			break;

We leave the loop early when we detect a write failure here...

> +	}
> +
> +	close(proc.in);
> +	sigchain_pop(SIGPIPE);
> +
> +	strbuf_release(&buf);
> +	return finish_command(&proc);

... but the caller does not get notified.  Intended?

> +}
> +
>  int ref_transaction_prepare(struct ref_transaction *transaction,
>  			    struct strbuf *err)
>  {
>  	struct ref_store *refs = transaction->ref_store;
> +	int ret;
>  
>  	switch (transaction->state) {
>  	case REF_TRANSACTION_OPEN:
> @@ -2012,7 +2060,17 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
>  		return -1;
>  	}
>  
> -	return refs->be->transaction_prepare(refs, transaction, err);
> +	ret = refs->be->transaction_prepare(refs, transaction, err);
> +	if (ret)
> +		return ret;
> +
> +	ret = run_transaction_hook(transaction, "ref-transaction-prepared");

This caller does care about it, no?

> +	if (ret) {
> +		ref_transaction_abort(transaction, err);
> +		die(_("ref updates aborted by hook"));
> +	}
> +
> +	return 0;
>  }
>  
>  int ref_transaction_abort(struct ref_transaction *transaction,
> @@ -2036,6 +2094,8 @@ int ref_transaction_abort(struct ref_transaction *transaction,
>  		break;
>  	}
>  
> +	run_transaction_hook(transaction, "ref-transaction-aborted");

And I presume that the callers of "ref_xn_abort()" would, too, but
the value returned here does not get folded into 'ret'.

>  	ref_transaction_free(transaction);
>  	return ret;
>  }
> @@ -2064,7 +2124,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		break;
>  	}
>  
> -	return refs->be->transaction_finish(refs, transaction, err);
> +	ret = refs->be->transaction_finish(refs, transaction, err);
> +	if (!ret)
> +		run_transaction_hook(transaction, "ref-transaction-committed");
> +	return ret;
>  }
>  
>  int refs_verify_refname_available(struct ref_store *refs,
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> new file mode 100755
> index 0000000000..b6df5fc883
> --- /dev/null
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -0,0 +1,88 @@
> +#!/bin/sh
> +
> +test_description='reference transaction hooks'
> +
> +. ./test-lib.sh
> +
> +create_commit ()
> +{

Style (Documentation/CodingGuidelines):

 - We prefer a space between the function name and the parentheses,
   and no space inside the parentheses. The opening "{" should also
   be on the same line.

> +	test_tick &&
> +	T=$(git write-tree) &&
> +	sha1=$(echo message | git commit-tree $T) &&
> +	echo $sha1

Calling this helper in a subprocess does not have the intended
effect of calling test_tick, which increments the committer
timestamp by 1 second to prepare for the next call...

> +}
> +
> +test_expect_success setup '
> +	mkdir -p .git/hooks
> +'
> +
> +test_expect_success 'prepared hook allows updating ref' '
> +	test_when_finished "rm .git/hooks/ref-transaction-prepared" &&
> +	write_script .git/hooks/ref-transaction-prepared <<-\EOF &&
> +		exit 0
> +	EOF
> +	C=$(create_commit) &&

... like here.

Instead of creating test commits left and right at each test, how
about preparing a pair of them (PRE, POST) upfront in the "setup"
step, reset the refs involved to PRE at the very beginning of each
test, and use POST to operations that would update the refs?  We can
use a couple of calls to test_commit helper to do so, without having
to bother with the low level porcelain calls if we go that route.

> +	git update-ref HEAD $C
> +'
> +
> +test_expect_success 'prepared hook aborts updating ref' '
> +	test_when_finished "rm .git/hooks/ref-transaction-prepared" &&
> +	write_script .git/hooks/ref-transaction-prepared <<-\EOF &&
> +		exit 1
> +	EOF
> +	C=$(create_commit) &&
> +	test_must_fail git update-ref HEAD $C 2>err &&
> +	grep "ref updates aborted by hook" err

Running "make GIT_TEST_GETTEXT_POISON=Yes test" would probably break
this line.  Use test_i18ngrep instead.

> +'
> +
> +test_expect_success 'prepared hook gets all queued updates' '
> +	test_when_finished "rm .git/hooks/ref-transaction-prepared actual" &&
> +	write_script .git/hooks/ref-transaction-prepared <<-\EOF &&
> +		while read -r line; do printf "%s\n" "$line"; done >actual

Style (used in the generated script)?

> +	EOF
> +	C=$(create_commit) &&
> +	cat >expect <<-EOF &&
> +		$ZERO_OID $C HEAD
> +		$ZERO_OID $C refs/heads/master
> +	EOF
> +	git update-ref HEAD $C <<-EOF &&
> +		update HEAD $ZERO_OID $C
> +		update refs/heads/master $ZERO_OID $C
> +	EOF
> +	test_cmp expect actual

OK, good futureproofing for the hash algorithm update ;-).
