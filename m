Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86553C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 18:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659A460724
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 18:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349091AbhICSfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 14:35:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61286 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245191AbhICSfu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 14:35:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2311A141F8B;
        Fri,  3 Sep 2021 14:34:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WnvUzbQjw8/rTwnFFaJCrELMqFhJUAAqhb6FAq
        lIHmI=; b=hiw8AFyl0nve7JzV/sDDK69kjJpuV/ps5Smpo33weV/7otwgMJ8mqJ
        pNg8/xYeeFFQ0UZp2Ykk9HGUsURxCBRAAW/7ZGh7t86jIwLnXMMTJ4T+LaAV8KbQ
        9pd2vfq0n2Yk/GtwaMi9tsWJgKgeKpgcaON6nrEHmMCJzFzN4yqPc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C574141F89;
        Fri,  3 Sep 2021 14:34:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 658AC141F87;
        Fri,  3 Sep 2021 14:34:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] update-ref: fix streaming of status updates
References: <1e9e62a2c5f74db91aaded83783076c28b757836.1630659922.git.ps@pks.im>
Date:   Fri, 03 Sep 2021 11:34:45 -0700
In-Reply-To: <1e9e62a2c5f74db91aaded83783076c28b757836.1630659922.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 3 Sep 2021 11:06:37 +0200")
Message-ID: <xmqqfsulfqyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DB0C606-0CE5-11EC-BCA2-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When executing git-update-ref(1) with the `--stdin` flag, then the user
> can queue updates and, since e48cf33b61 (update-ref: implement
> interactive transaction handling, 2020-04-02), interactively drive the
> transaction's state via a set of transactional verbs. This interactivity
> is somewhat broken though: while the caller can use these verbs to drive
> the transaction's state, the status messages which confirm that a verb
> has been processed is not flushed. The caller may thus be left hanging
> waiting for the acknowledgement.
>
> Fix the bug by flushing stdout after writing the status update. Add a
> test which catches this bug.

Nobody hit by this for more than a year is interesting.

Will queue.  Thanks.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/update-ref.c  | 14 ++++++++++----
>  t/t1400-update-ref.sh | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 6029a80544..a84e7b47a2 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -302,6 +302,12 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
>  	strbuf_release(&err);
>  }
>  
> +static void report_ok(const char *command)
> +{
> +	fprintf(stdout, "%s: ok\n", command);
> +	fflush(stdout);
> +}
> +
>  static void parse_cmd_option(struct ref_transaction *transaction,
>  			     const char *next, const char *end)
>  {
> @@ -317,7 +323,7 @@ static void parse_cmd_start(struct ref_transaction *transaction,
>  {
>  	if (*next != line_termination)
>  		die("start: extra input: %s", next);
> -	puts("start: ok");
> +	report_ok("start");
>  }
>  
>  static void parse_cmd_prepare(struct ref_transaction *transaction,
> @@ -328,7 +334,7 @@ static void parse_cmd_prepare(struct ref_transaction *transaction,
>  		die("prepare: extra input: %s", next);
>  	if (ref_transaction_prepare(transaction, &error))
>  		die("prepare: %s", error.buf);
> -	puts("prepare: ok");
> +	report_ok("prepare");
>  }
>  
>  static void parse_cmd_abort(struct ref_transaction *transaction,
> @@ -339,7 +345,7 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
>  		die("abort: extra input: %s", next);
>  	if (ref_transaction_abort(transaction, &error))
>  		die("abort: %s", error.buf);
> -	puts("abort: ok");
> +	report_ok("abort");
>  }
>  
>  static void parse_cmd_commit(struct ref_transaction *transaction,
> @@ -350,7 +356,7 @@ static void parse_cmd_commit(struct ref_transaction *transaction,
>  		die("commit: extra input: %s", next);
>  	if (ref_transaction_commit(transaction, &error))
>  		die("commit: %s", error.buf);
> -	puts("commit: ok");
> +	report_ok("commit");
>  	ref_transaction_free(transaction);
>  }
>  
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 4506cd435b..1e754e258f 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1598,6 +1598,38 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
>  	test_must_fail git show-ref --verify refs/heads/restart
>  '
>  
> +test_expect_success PIPE 'transaction flushes status updates' '
> +	mkfifo in out &&
> +	(git update-ref --stdin <in >out &) &&
> +
> +	exec 9>in &&
> +	test_when_finished "exec 9>&-" &&
> +
> +	echo "start" >&9 &&
> +	echo "start: ok" >expected &&
> +	read line <out &&
> +	echo "$line" >actual &&
> +	test_cmp expected actual &&
> +
> +	echo "create refs/heads/flush $A" >&9 &&
> +
> +	echo prepare >&9 &&
> +	echo "prepare: ok" >expected &&
> +	read line <out &&
> +	echo "$line" >actual &&
> +	test_cmp expected actual &&
> +
> +	# This must now fail given that we have locked the ref.
> +	test_must_fail git update-ref refs/heads/flush $B 2>stderr &&
> +	grep "fatal: update_ref failed for ref ${SQ}refs/heads/flush${SQ}: cannot lock ref" stderr &&
> +
> +	echo commit >&9 &&
> +	echo "commit: ok" >expected &&
> +	read line <out &&
> +	echo "$line" >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'directory not created deleting packed ref' '
>  	git branch d1/d2/r1 HEAD &&
>  	git pack-refs --all &&
