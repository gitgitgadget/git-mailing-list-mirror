Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C944DC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiBHBFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbiBHAt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 19:49:58 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781DCC061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 16:49:57 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CF3C17D9A2;
        Mon,  7 Feb 2022 19:49:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rKYRiVXhbqKF2WEx0w4e28jnuAUQ9ZMZ9hxwHt
        B7Xww=; b=LPlZWSkTeGrk3TiGn4WWomPpwG0NVU7NFif6Y/6HEQAA70DUIbtXgj
        4IIsId28MnntQ17JETr9PYaEU3ZlQjaX7+DvRGZh7RnV5p82cb69ZphMil8eb+E1
        cK4MX19B+KhhJ6YsGMht9aywpDLp5e26xr9TeljTjekjL1Qk77PZ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 050BE17D9A1;
        Mon,  7 Feb 2022 19:49:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6207F17D99F;
        Mon,  7 Feb 2022 19:49:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/2] cat-file: add --batch-command mode
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
        <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
        <1b63164ad4d9ec6b5fa6f733b6095b2779298b36.1644251611.git.gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 16:49:52 -0800
In-Reply-To: <1b63164ad4d9ec6b5fa6f733b6095b2779298b36.1644251611.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Mon, 07 Feb 2022 16:33:31
        +0000")
Message-ID: <xmqq35kufahb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07289EB0-8879-11EC-94C6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Add a new flag --batch-command that accepts commands and arguments
> from stdin, similar to git-update-ref --stdin.
>
> At GitLab, we use a pair of long running cat-file processes when
> accessing object content. One for iterating over object metadata with
> --batch-check, and the other to grab object contents with --batch.
>
> However, if we had --batch-command, we wouldn't need to keep both
> processes around, and instead just have one --batch-command process
> where we can flip between getting object info, and getting object
> contents. Since we have a pair of cat-file processes per repository,
> this means we can get rid of roughly half of long lived git cat-file
> processes. Given there are many repositories being accessed at any given
> time, this can lead to huge savings since on a given server.
>
> git cat-file --batch-command
>
> will enter an interactive command mode whereby the user can enter in
> commands and their arguments that get queued in memory:
>
> <command1> [arg1] [arg2] NL
> <command2> [arg1] [arg2] NL

If you mean you take one command with its args per line, use LF not
NL.

    $ git grep '\<NL\>' Documentation
    $ git grep '\<LF\>' Documentation

We may want to fix the sole offender in Documentation/config.txt
file (#leftoverbits).

> With this mechanism of queueing up commands and letting (A) issue a
> flush command, process (A) can control when the buffer is flushed and
> can guarantee it will receive all of the output when in --buffer mode.

Are we giving them guarantee when output will *not* come?  If (B) is
allowed to flush when it thinks it has too much in-core, it would
mean that (A) cannot keep issuing commands forever without reading
the response from (B), because (B) will eventually be blocked when
it tries to flush to a pipe that (A) is not reading.  I think there
should be some discussion on that, too.  IOW, --batch-command does
not allow (B) to flush until it gets "flush", or something like that.

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index bef76f4dd06..618dbd15338 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -96,6 +96,25 @@ OPTIONS
>  	need to specify the path, separated by whitespace.  See the
>  	section `BATCH OUTPUT` below for details.
>  
> +--batch-command::
> +	Enter a command mode that reads commands and arguments from stdin.
> +	May not be combined with any other options or arguments except
> +	`--textconv` or `--filters`, in which case the input lines also need to
> +	specify the path, separated by whitespace.  See the section
> +	`BATCH OUTPUT` below for details.
> +
> +contents <object>::
> +	Print object contents for object reference <object>

Presumably this corresponds to what you get out of "--batch"?

> +info <object>::
> +	Print object info for object reference <object>

and this one "--batch-check"?

I expect that future readers will ask this same question because it
is not clear how "object contents" and "object info" are exactly
printed.  These two paragraphs may want to anticipate it and reduce
the need for readers to ask such a question.  

> +flush::
> +	Execute all preceding commands that were issued since the beginning or
> +	since the last flush command was issued. Only used with --buffer. When
> +	--buffer is not used, commands are flushed each time without issuing
> +	`flush`.

Here is a good place to also say "When --buffer is used, no output
will come until this is issued" or something.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 5f015e71096..6bfab74b58a 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -26,6 +26,7 @@ struct batch_options {
>  	int unordered;
>  	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
>  	const char *format;
> +	int command;

I am not sure if "command" is a good name.  Does it answer this
question clearly? "'command' as opposed to what?"

> @@ -508,6 +509,118 @@ static int batch_unordered_packed(const struct object_id *oid,
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
> +	opt->print_contents = 1;
> +	batch_one_object(line, output, opt, data);
> +}
> +
> +static void parse_cmd_info(struct batch_options *opt,
> +			   const char *line,
> +			   struct strbuf *output,
> +			   struct expand_data *data)
> +{
> +	opt->print_contents = 0;
> +	batch_one_object(line, output, opt, data);
> +}

OK, these are as simple as expected.

> +static void flush_batch_calls(struct batch_options *opt,
> +		struct strbuf *output,
> +		struct expand_data *data,
> +		struct queued_cmd *cmds,
> +		int queued)
> +{
> +	int i;
> +	for(i = 0; i < queued; i++){

Missing SP around parentheses.

Excess brace pair wround a single-statement block.

> +		cmds[i].fn(opt, cmds[i].line, output, data);
> +	}
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
> +	int queued = 0;
> +
> +	while (!strbuf_getline(&input, stdin)) {
> +		int i;
> +		const struct parse_cmd *cmd = NULL;
> +		const char *p, *cmd_end;
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
> +			if (!queued)
> +				die(_("nothing to flush"));

I am not sure if this is a good idea at all.  What do we gain from
punishing an automated stupid loop that issues flush every once in a
while after issuing a handful real commands and issues another flush
after running out of the real commands for a good measure?

> +			flush_batch_calls(opt, output, data, cmds, queued);
> +			queued = 0;
> +			continue;
> +		}
> +
> +		for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +			if (!skip_prefix(input.buf, commands[i].prefix, &cmd_end))
> +				continue;
> +
> +			cmd = &commands[i];
> +			if (cmd->takes_args)
> +				p = cmd_end + 1;

If somebody adds an entry with .takes_args==false, p will stay
uninitialized and used in the call ->fn() below, or passed to
xstrdup(p).  It probabloy should be initialized to NULL, and
xstrdup(p) below replaced with xstrdup_or_null(p).

> +			break;
> +		}
> +
> +		if (!cmd)
> +			die(_("unknown command: '%s'"), input.buf);
> +
> +		if (!opt->buffer_output) {
> +			cmd->fn(opt, p, output, data);
> +			continue;
> +		}
> +


> +		queued++;
> +		if (queued > nr) {
> +			ALLOC_GROW(cmds, nr+1, alloc);
> +			nr++;
> +		}
> +
> +		call.fn = cmd->fn;
> +		call.line = xstrdup(p);
> +		cmds[queued-1] = call;

Can nr and queued ever go out of sync?

If cmds is the usual <array, nr, alloc> tuple we let ALLOC_GROW() to
manage, alloc keeps track of how physically large the array is, and
nr indicates how many slots are filled.  Holding onto the block of
memory we used when discarding the accumulated items and reusing
that block without having to reallocate until we use the slots that
we have allocated is done by using only <nr, alloc> pair.

But the above code seems that it does not understand that, and
instead thinks it has to use "nr" for the "we have made the array
this big, so we do not have to realloc up to that point" pointer,
hence its use of a separate "queued".  IOW, the array growing code
above seems confused.

It is more customery (hence easier to follow by readers who work on
our code base) to lose queued and say

		ALLOC_GROW(cmds, nr + 1, alloc);
		cmds[nr++] = call;
		call.fn = cmd->fn;
		call.line = xstrdup_or_null(p);

instead of the above 9 lines.

> @@ -515,6 +628,7 @@ static int batch_objects(struct batch_options *opt)
>  	struct expand_data data;
>  	int save_warning;
>  	int retval = 0;
> +	const int command = opt->command;

This tells me that it is quite a misnomer.  This single bit is used
to differentiate between "other batch modes" and "--batch-command"
mode, which already smells like a misdesign, because we have, from
an end-user's point of view, three modes:

    --batch
    --batch-check
    --batch-command

so it would be far cleaner to have a single batch_mode enum that can
represent these three "batch modes", no?

>  	if (!opt->format)
>  		opt->format = "%(objectname) %(objecttype) %(objectsize)";
> @@ -590,6 +704,10 @@ static int batch_objects(struct batch_options *opt)
>  	save_warning = warn_on_object_refname_ambiguity;
>  	warn_on_object_refname_ambiguity = 0;
>  
> +	if (command) {
> +		batch_objects_command(opt, &output, &data);
> +		goto cleanup;
> +	}
>  	while (strbuf_getline(&input, stdin) != EOF) {
>  		if (data.split_on_whitespace) {
>  			/*
> @@ -608,6 +726,7 @@ static int batch_objects(struct batch_options *opt)
>  		batch_one_object(input.buf, &output, opt, &data);
>  	}
>  
> + cleanup:
>  	strbuf_release(&input);
>  	strbuf_release(&output);
>  	warn_on_object_refname_ambiguity = save_warning;
> @@ -636,6 +755,7 @@ static int batch_option_callback(const struct option *opt,
>  
>  	bo->enabled = 1;
>  	bo->print_contents = !strcmp(opt->long_name, "batch");
> +	bo->command = !strcmp(opt->long_name, "batch-command");

And this part needs fixing.  The original used to say

	we supoprt "batch" and something else (it turns out that
	"batch-check" is that something else, but the above code is
	so sloppy that it does not even tell readers that), and
	the .print_contents member is how you can tell them apart.

This patch is making it worse by introducing another member that can
be independently set or unset, pretending that the four combinations
all can make sense, but that is not the case, right?

So, perhaps a good first step would be to lose .print_contents
member and add .batch_command member that is used to more explicitly
name one of the three possibilities?
