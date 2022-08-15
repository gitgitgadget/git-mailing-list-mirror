Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71549C25B08
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 18:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbiHOS1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiHOSZO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 14:25:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAF92F004
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 11:18:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5DBC152E8E;
        Mon, 15 Aug 2022 14:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RxtI0qGRjCE7eR0XlttRhCtBaO6x4rK1VVfvgl
        BNEmI=; b=coIX2SbERqRiXeyUjd1j71ysyj7h7rnAqKaon6Xz8SnCfQJ9zIplq9
        0nvIEBLYzVAKhNXOCiff90o5PHGzTFGlbydpj32ZBFHBUQ8WjYE4fnty4Ujbvg9P
        7RHI0km3Iizle8IPLrEbLa46CKp6yH0kq+XHnYxX9H8ITTU9rktBM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD265152E8D;
        Mon, 15 Aug 2022 14:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27B68152E8A;
        Mon, 15 Aug 2022 14:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sun Chao <16657101987@163.com>,
        Sun Chao <sunchao9@huawei.com>
Subject: Re: [PATCH v4 1/3] hide-refs: add hook to force hide refs
References: <pull.1301.v3.git.git.1660575384.gitgitgadget@gmail.com>
        <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
        <01c63ea5feefd57721bdcab9f0a30d9c0112e753.1660575688.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 11:18:14 -0700
In-Reply-To: <01c63ea5feefd57721bdcab9f0a30d9c0112e753.1660575688.git.gitgitgadget@gmail.com>
        (Sun Chao via GitGitGadget's message of "Mon, 15 Aug 2022 15:01:26
        +0000")
Message-ID: <xmqqa6851ic9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1311424-1CC6-11ED-B2EE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This step seems to do too many things at once and is hard to assess
its correctness, I am afraid.  Anybody who has deep understanding of
the protocol involved share that impression?

> To enable the `hide-refs` hook, we should config hiderefs with `force:`
> option, eg:
>
>         git config --add transfer.hiderefs force:refs/prefix1/
>         git config --add uploadpack.hiderefs force:!refs/prefix2/
>
> the `hide-refs` will be called during reference discovery phase and
> check each matched reference, a 'hide' response means the reference will
> be hidden for its private data even if `allowTipSHA1InWant` or
> `allowReachableSHA1InWant` are set to true.

If the prefix is a sign to let the external process to tell if it is
to be hidden or shown, it does not sound like "force" at all, at
least to me ("force" sounds more like "no matter what other things
may want to show it, these are hidden").

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 31b48e728be..16f2a21e97a 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -296,7 +296,7 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
>  	struct oidset *seen = data;
>  	const char *path = strip_namespace(path_full);
>  
> -	if (ref_is_hidden(path, path_full))
> +	if (ref_is_hidden(path, path_full) || ref_is_force_hidden(path, path_full))
>  		return 0;

Are there places where only ref_is_hidden() is called, or do
codepaths that used to care ref_is_hidden() now all have to write
the above (A || B) conditional?  I am wondering why the new
"force-hidden" check is not part of ref_is_hidden() so that the
callers do not have to care.

> @@ -1794,7 +1794,8 @@ static void reject_updates_to_hidden(struct command *commands)
>  		strbuf_setlen(&refname_full, prefix_len);
>  		strbuf_addstr(&refname_full, cmd->ref_name);
>  
> -		if (!ref_is_hidden(cmd->ref_name, refname_full.buf))
> +		if (!ref_is_hidden(cmd->ref_name, refname_full.buf) &&
> +			!ref_is_force_hidden(cmd->ref_name, refname_full.buf))

Likewise.

> diff --git a/ls-refs.c b/ls-refs.c
> index 98e69373c84..b5cb1316d38 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -84,7 +84,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  
>  	strbuf_reset(&data->buf);
>  
> -	if (ref_is_hidden(refname_nons, refname))
> +	if (mark_our_ref(refname_nons, refname, oid))
>  		return 0;
>  
>  	if (!ref_match(&data->prefixes, refname_nons))

It used to be that send_ref() did not touch the object flag bits.
It just said "if it is hidden, or if it is outside the namespace, do
not show and return" before telling the other side about the ref,
and even the ref we send to the other side, we did not muck with
flag bits with OUR_REF bit (and we didn't touch HIDDEN_REF bit,
either).

Now we do.  How can it be determined if this change is correct and
safe?

If the ref is not hidden (either in the traditional sense, or with
the new "force" sense), we do not return 0.  What if it is outside
the namespace so we returned without sending it to the other side?
The original code didn't touch the flags bit, but now we mark the
object with OUR_REF bit even though we ended up not sending the ref
to the other side.  Is that an intended change?

>  int parse_hide_refs_config(const char *var, const char *value, const char *section)
>  {
>  	const char *key;
> +	int force = 0;
> +
>  	if (!strcmp("transfer.hiderefs", var) ||
>  	    (!parse_config_key(var, section, NULL, NULL, &key) &&
>  	     !strcmp(key, "hiderefs"))) {
>  		char *ref;
>  		int len;
> +		int forcelen;
>  
>  		if (!value)
>  			return config_error_nonbool(var);
> +
> +		forcelen = strlen("force:");
> +		len = strlen(value);
> +		if ((len >= forcelen) && !strncmp(value, "force:", forcelen)) {

skip_prefix() would probably be a good API function to learn here, perhaps?


> +static struct child_process *hide_refs_proc;
> +static struct packet_reader *hide_refs_reader;
> +static void create_hide_refs_process(void) {

Style.  The braces around a function block occupy their own line by
themselves.

> +	struct child_process *proc;
> +	struct packet_reader *reader;
> +	const char *hook_path;
> +	int version = 0;
> +	int code;
> +
> +	hook_path = find_hook("hide-refs");
> +	if (!hook_path) {
> +		die("can not find hide-refs hook");
> +	}

No need for braces around a single statement block.

Is that a condition worth dying, indicating a misconfiguration by
the user?  Or would it make more sense to treat as if the process
says no refs are hidden (or all refs are hidden)?

I do not think we spell "cannot" as "can not" in our messages.

> +	proc = (struct child_process *) xcalloc (1, sizeof (struct child_process));
> +	reader = (struct packet_reader *) xcalloc (1, sizeof(struct packet_reader));

Style.  No SP after xcalloc, or sizeof.

> +	child_process_init(proc);
> +	strvec_push(&proc->args, hook_path);
> +	proc->in = -1;
> +	proc->out = -1;
> +	proc->trace2_hook_name = "hide-refs";
> +	proc->err = 0;
> +
> +	code = start_command(proc);
> +	if (code)
> +		die("can not run hook hide-refs");

Unusually named variable.  I think "code" here is a variable
normally called "status" (or "ret" if it eventually becomes the
return value from this function).  Shouldn't this function return an
error and have it handled by its caller, by the way, instead of
returning void and making liberal calls to die()?

> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	/* Version negotiaton */
> +	packet_reader_init(reader, proc->out, NULL, 0,
> +			   PACKET_READ_CHOMP_NEWLINE |
> +			   PACKET_READ_GENTLE_ON_EOF);
> +	code = packet_write_fmt_gently(proc->in, "version=1%c%s", '\0', hide_refs_section.buf);
> +	if (!code)
> +		code = packet_flush_gently(proc->in);

In general, it is a bad pattern to hide mainline "good case"
processing inside "if (previous steps all went fine)" conditionals,
as it makes the code unnecessarily hard to follow.

Instead, we typically write more like this:

-- >8 -- cut here -- >8 --

	int ret = -1; /* assume failure */

        if (packet_write_fmt_gently(...))
		goto error_exit;

	for (;;) {
		... interact with the other side ...
		if (error)
			goto error_exit;
	}

	... continue with mainline "good case" processing ...

	... after all went well ...
	ret = 0;

error_exit:
	if (ret < 0) {
		... emit error message ...
		... clean-up specific to error case if necessary
	}
	... clean-up as needed ...

	return ret;

-- 8< -- cut here -- 8< --

I am not reviewing the rest of the patch in this sitting---I may
later come back to continue reading it, but I'll stop here and send
out comments on what I have seen first.

Thanks.
