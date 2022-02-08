Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA1CC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 23:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiBHX7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiBHX7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 18:59:18 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73100C061576
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 15:59:17 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C75511067C0;
        Tue,  8 Feb 2022 18:59:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ByUQzZ07Qfi3LIw/fNqSRFBEaUiTXbSaj+Q27X
        NUMNA=; b=sNMvCSVgfnGbBnQkt3ylx0RZXwZVu14B/sQEmladVeC4Y5c3z+eNRe
        U7V2a7xckrJjWgNnym53Xmvqk13Gsl1Xs9oeKJs+QUZPPLx8GTmJmZcAEJQJbbrI
        vrnX+9v3mQy0vUPVxpcbHs4C1TT3eDM6ef6kr6TC6agfL8KdP+di0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC9AE1067BC;
        Tue,  8 Feb 2022 18:59:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 292AA1067BB;
        Tue,  8 Feb 2022 18:59:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 3/3] cat-file: add --batch-command mode
References: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
        <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
        <1ab5524ee874fc7af65efaca37fb7cd933ea8913.1644353884.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 15:59:14 -0800
In-Reply-To: <1ab5524ee874fc7af65efaca37fb7cd933ea8913.1644353884.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 08 Feb 2022 20:58:04
        +0000")
Message-ID: <xmqqwni4ap0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F3DDC8C-893B-11EC-B2B7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 1c673385868..ec266ff95e9 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -17,15 +17,16 @@
>  #include "object-store.h"
>  #include "promisor-remote.h"
>  
> -enum batch_command {
> -	BATCH_COMMAND_CONTENTS,
> -	BATCH_COMMAND_INFO,
> +enum batch_mode {
> +	BATCH_MODE_CONTENTS,
> +	BATCH_MODE_INFO,

Would have been better to introduce batch_mode at [2/3] insteads of
having to rename it like this, I guess.

> +	BATCH_MODE_PARSE_CMDS,

What the new mode does looks more like queue-and-dispatch, as
opposed to a mode that can only do "info" or another mode that can
only do "contents".

> @@ -513,6 +514,117 @@ static int batch_unordered_packed(const struct object_id *oid,
>  				      data);
>  }
>  
> +typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
> +			       struct strbuf *, struct expand_data *);
> +
> +struct queued_cmd {
> +	parse_cmd_fn_t fn;
> +	const char *line;
> +};
> +
> +static void parse_cmd_contents(struct batch_options *opt,
> +			     const char *line,
> +			     struct strbuf *output,
> +			     struct expand_data *data)
> +{
> +	opt->batch_mode = BATCH_MODE_CONTENTS;
> +	batch_one_object(line, output, opt, data);
> +}
> +
> +static void parse_cmd_info(struct batch_options *opt,
> +			   const char *line,
> +			   struct strbuf *output,
> +			   struct expand_data *data)
> +{
> +	opt->batch_mode = BATCH_MODE_INFO;
> +	batch_one_object(line, output, opt, data);
> +}

OK.

> +static void flush_batch_calls(struct batch_options *opt,
> +		struct strbuf *output,
> +		struct expand_data *data,
> +		struct queued_cmd *cmds,
> +		int nr)
> +{
> +	int i;

Have a blank line here between the decl(s) and the first statement.

> +	for (i = 0; i < nr; i++)
> +		cmds[i].fn(opt, cmds[i].line, output, data);
> +
> +	fflush(stdout);
> +}
> +
> +static const struct parse_cmd {
> +	const char *prefix;
> +	parse_cmd_fn_t fn;
> +	unsigned takes_args;
> +} commands[] = {
> +	{ "contents", parse_cmd_contents, 1},
> +	{ "info", parse_cmd_info, 1},
> +};
> +
> +static void batch_objects_command(struct batch_options *opt,
> +				    struct strbuf *output,
> +				    struct expand_data *data)
> +{
> +	struct strbuf input = STRBUF_INIT;
> +	struct queued_cmd *cmds = NULL;
> +	size_t alloc = 0, nr = 0;
> +
> +	while (!strbuf_getline(&input, stdin)) {
> +		int i;
> +		const struct parse_cmd *cmd = NULL;
> +		const char *p = NULL, *cmd_end;
> +		struct queued_cmd call = {0};
> +
> +		if (!input.len)
> +			die(_("empty command in input"));
> +		if (isspace(*input.buf))
> +			die(_("whitespace before command: '%s'"), input.buf);
> +
> +		if (skip_prefix(input.buf, "flush", &cmd_end)) {
> +			if (!opt->buffer_output)
> +				die(_("flush is only for --buffer mode"));
> +			if (*cmd_end)
> +				die(_("flush takes no arguments"));
> +			if (!nr)
> +				error(_("nothing to flush"));

I am not sure if "you already gave us flush and haven't given a new
command, saying 'flush' in such a state is an error" is a good
interface.  What does it achieve to punish such a caller like this
(as opposed to just iterate the loop zero times)?

> +			flush_batch_calls(opt, output, data, cmds, nr);

This iterated cmds[] array and called .fn() for each.  For a command
in the cmds[] array that takes an argument, each element in cmds[]
has a pointer that holds memory obtained from xstrdup_or_null().

Rewinding the array with "nr = 0" to reuse the slots we have
allocated is good, but the memory pointed at by the .line member of
these elements must be freed when this happens.

Perhaps flush_batch_calls() should do so while iterating, i.e.

	for (i = 0; i < nr; i++) {
		cmds[i].fn(opt, cmds[i].line, output, data);
		free(cmds[i].line);
	}
	fflush(stdout);

or something like that?

A tangent, but naming an array as singular, cmd[], would work more
natural when the code often works on individual elements of the
array, i.e. work_on(cmd[4]) would name the "4th cmd", which would
not work well if the array were named cmds[].

