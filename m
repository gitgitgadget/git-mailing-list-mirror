Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E902C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhKVWbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:31:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54148 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhKVWbB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:31:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ECE4F5CA1;
        Mon, 22 Nov 2021 17:27:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=UvuFipkJfV2xoO0cuhWs1r4MxOY7TaAHiOwFmzAy6uw=; b=WwPy
        +cGswJwFSybeAEdIuyd/Z+DwZ5Cr84wQTG50/XMOM/cSOqWeBfSOZiJfwz4d+t58
        wngJMKTmJrYNq7TIKOGeORWzgRBMO744mKPDP856Vr2JDvieIs/ojIM70frZZTzy
        y2HUnGcFnwUsNA6YoZ4HQ/DrOP+A3N8/MZijPd8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36AD0F5CA0;
        Mon, 22 Nov 2021 17:27:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94151F5C9F;
        Mon, 22 Nov 2021 17:27:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:27:52 -0800
Message-ID: <xmqq35nnddw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F28970E-4BE3-11EC-AD13-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Commit 523fa69c ("reflog: cleanse messages in the refs.c layer") standardizes
> how write entries into the reflog. This commit standardizes how we get messages
> out of the reflog. Before, the files backend implicitly added '\n' to the end of
> reflog message on reading, which creates a subtle incompatibility with alternate
> ref storage backends, such as reftable.
>
> We address this by stripping LF from the message before we pass it to the
> user-provided callback.

If this were truly "user-provided", then I'd argue that all backends
should follow whatever the files backend has been doing forever---if
the files added LF implicitly, others should, too, because that is
pretty much what these "user-provided" callbacks have been expecting
to see.

In other words, it would be a bug for newer backends to behave
differently.

But I _think_ these callbacks are all under our control, and if that
is the case, I am fine either way, even though I would have a strong
preference not to have to change the API without a good reason, even
if it is a purely internal one.

So, let's go and see if we can find a good reason in the changes we
can make to the callback functions ;-)

> -			end = strchr(logmsg, '\n');
> -			if (end)
> -				*end = '\0';
> -

We could argue that the lack of LF at the end from the API output
made this caller simpler, which may be a plus.

> diff --git a/reflog-walk.c b/reflog-walk.c
> index 8ac4b284b6b..3ee59a98d2f 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -244,8 +244,6 @@ void get_reflog_message(struct strbuf *sb,
>  
>  	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
>  	len = strlen(info->message);
> -	if (len > 0)
> -		len--; /* strip away trailing newline */

Likewise.

> @@ -284,10 +282,10 @@ void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
>  		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
>  		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
>  		if (oneline) {
> -			printf("%s: %s", selector.buf, info->message);
> +			printf("%s: %s\n", selector.buf, info->message);
>  		}
>  		else {
> -			printf("Reflog: %s (%s)\nReflog message: %s",
> +			printf("Reflog: %s (%s)\nReflog message: %s\n",
>  			       selector.buf, info->email, info->message);
>  		}

This is Meh either way.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 151b0056fe5..583bbc5f8b9 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1936,17 +1936,15 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
>  	int tz;
>  	const char *p = sb->buf;
>  
> -	/* old SP new SP name <email> SP time TAB msg LF */
> -	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
> -	    parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
> +	/* old SP new SP name <email> SP time TAB msg */
> +	if (!sb->len || parse_oid_hex(p, &ooid, &p) || *p++ != ' ' ||
>  	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
> -	    !(email_end = strchr(p, '>')) ||
> -	    email_end[1] != ' ' ||
> +	    !(email_end = strchr(p, '>')) || email_end[1] != ' ' ||
>  	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
>  	    !message || message[0] != ' ' ||
> -	    (message[1] != '+' && message[1] != '-') ||
> -	    !isdigit(message[2]) || !isdigit(message[3]) ||
> -	    !isdigit(message[4]) || !isdigit(message[5]))
> +	    (message[1] != '+' && message[1] != '-') || !isdigit(message[2]) ||
> +	    !isdigit(message[3]) || !isdigit(message[4]) ||
> +	    !isdigit(message[5]))
>  		return 0; /* corrupt? */
>  	email_end[1] = '\0';
>  	tz = strtol(message + 1, NULL, 10);
> @@ -2038,6 +2036,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
>  				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
>  				scanp = bp;
>  				endp = bp + 1;
> +				strbuf_trim_trailing_newline(&sb);
>  				ret = show_one_reflog_ent(&sb, fn, cb_data);
>  				strbuf_reset(&sb);
>  				if (ret)
> @@ -2050,6 +2049,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
>  				 * Process it, and we can end the loop.
>  				 */
>  				strbuf_splice(&sb, 0, 0, buf, endp - buf);
> +				strbuf_trim_trailing_newline(&sb);
>  				ret = show_one_reflog_ent(&sb, fn, cb_data);
>  				strbuf_reset(&sb);
>  				break;
> @@ -2099,7 +2099,7 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
>  	if (!logfp)
>  		return -1;
>  
> -	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
> +	while (!ret && !strbuf_getline(&sb, logfp))
>  		ret = show_one_reflog_ent(&sb, fn, cb_data);
>  	fclose(logfp);
>  	strbuf_release(&sb);
> @@ -3059,18 +3059,18 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
>  	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
>  				   message, policy_cb)) {
>  		if (!cb->newlog)
> -			printf("would prune %s", message);
> +			printf("would prune %s\n", message);
>  		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
> -			printf("prune %s", message);
> +			printf("prune %s\n", message);
>  	} else {
>  		if (cb->newlog) {
> -			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
> -				oid_to_hex(ooid), oid_to_hex(noid),
> -				email, timestamp, tz, message);
> +			fprintf(cb->newlog, "%s %s %s %" PRItime " %+05d\t%s\n",
> +				oid_to_hex(ooid), oid_to_hex(noid), email,
> +				timestamp, tz, message);
>  			oidcpy(&cb->last_kept_oid, noid);
>  		}
>  		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
> -			printf("keep %s", message);
> +			printf("keep %s\n", message);
>  	}
>  	return 0;
>  }

Hmmmm.  I'll defer my judgment to the end.

> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> index 49718b7ea7f..a600bedf2cd 100755
> --- a/t/t1405-main-ref-store.sh
> +++ b/t/t1405-main-ref-store.sh
> @@ -89,13 +89,12 @@ test_expect_success 'for_each_reflog()' '
>  test_expect_success 'for_each_reflog_ent()' '
>  	$RUN for-each-reflog-ent HEAD >actual &&
>  	head -n1 actual | grep one &&
> -	tail -n2 actual | head -n1 | grep recreate-main
> +	tail -n1 actual | grep recreate-main
>  '
>  
>  test_expect_success 'for_each_reflog_ent_reverse()' '
>  	$RUN for-each-reflog-ent-reverse HEAD >actual &&
> -	head -n1 actual | grep recreate-main &&
> -	tail -n2 actual | head -n1 | grep one
> +	tail -n1 actual | grep one
>  '
>  
>  test_expect_success 'reflog_exists(HEAD)' '
> diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
> index 0a87058971e..b0365c1fee0 100755
> --- a/t/t1406-submodule-ref-store.sh
> +++ b/t/t1406-submodule-ref-store.sh
> @@ -74,13 +74,13 @@ test_expect_success 'for_each_reflog()' '
>  test_expect_success 'for_each_reflog_ent()' '
>  	$RUN for-each-reflog-ent HEAD >actual &&
>  	head -n1 actual | grep first &&
> -	tail -n2 actual | head -n1 | grep main.to.new
> +	tail -n1 actual | grep main.to.new
>  '
>  
>  test_expect_success 'for_each_reflog_ent_reverse()' '
>  	$RUN for-each-reflog-ent-reverse HEAD >actual &&
>  	head -n1 actual | grep main.to.new &&
> -	tail -n2 actual | head -n1 | grep first
> +	tail -n1 actual | grep first
>  '
>  
>  test_expect_success 'reflog_exists(HEAD)' '

I got an impression from the proposed log message and the changes to
the code (except for the refs/files-backend.c, which I only skimmed)
that the idea is that the refs API stops adding LF at the end, and
the callers got a matching change to compensate for the (now)
missing LF.  If that is the idea behind the change, why do we need
to change any existing test?  The only way any tests need to be
modified due to such a change I can think of is when we forget to or
failed to make compensating change to the callers of the API.

Puzzled...

Ah, the $RUN is hiding what is really going on; it is running the
"test-tool ref-store" helper, and we did not adjust that helper.  So
if we make a compensating change to the test-tool then we do not
have to have these changes at all?  But that point may be moot.

In any case, in order to lose 5 lines from show-branch.c, and 2
lines from reflog-walk.c, I see that we had to touch 30+ lines in
refs/files-backend.c.  I find it a bit hard to sell this as an
improvement to the API, to be honest.

Luckily, it looks to me that this step is mostly unreleated to the
main thrust of these patches in the series, which is "reading
.git/logs/ in the test would work only when testing files backend;
use for-each-ref test helper to recreate what would have been read
by such tests from the files backend's files and inspect that
instead, and that would allow us test other backends for free".

So I suspect that this step can be safely dropped?

Thanks.

