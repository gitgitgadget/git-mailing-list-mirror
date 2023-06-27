Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBDAEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF0Toi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0Toh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:44:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15391B3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:44:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A1001D898;
        Tue, 27 Jun 2023 15:44:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aJh2s5ix7s5utbhIWjqT7L5ArtRanhusGEtOav
        8In/g=; b=VguHUkvxigddstCnfFIGRcNAfJC4URbTmyiAf/40NKucWjFaW46CTM
        eV0LbgpEQlCkEXhm+udkmc4BujoDDnqNqiUWLAlvTQSp5gb680ikBYTMvzYNwgf8
        cxgdc0/V3JEXX+t34GULA9RBVHf487FA2aScuYFJWgAZ5GMu6MzsY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5119D1D897;
        Tue, 27 Jun 2023 15:44:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5BB631D896;
        Tue, 27 Jun 2023 15:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>
Subject: Re: [PATCH 3/3] diff --no-index: support reading from named pipes
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
        <990e71882bfdc697285c5b04b92c290679ca22ab.1687874975.git.phillip.wood@dunelm.org.uk>
Date:   Tue, 27 Jun 2023 12:44:31 -0700
In-Reply-To: <990e71882bfdc697285c5b04b92c290679ca22ab.1687874975.git.phillip.wood@dunelm.org.uk>
        (Phillip Wood's message of "Tue, 27 Jun 2023 15:10:16 +0100")
Message-ID: <xmqqy1k4g068.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0995C19A-1523-11EE-8694-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> In some shells, such as bash and zsh, it's possible to use a command
> substitution to provide the output of a command as a file argument to
> another process, like so:
>
>   diff -u <(printf "a\nb\n") <(printf "a\nc\n")
>
> However, this syntax does not produce useful results with "git diff
> --no-index". On macOS, the arguments to the command are named pipes
> under /dev/fd, and git diff doesn't know how to handle a named pipe. On
> Linux, the arguments are symlinks to pipes, so git diff "helpfully"
> diffs these symlinks, comparing their targets like "pipe:[1234]" and
> "pipe:[5678]".
>
> To address this "diff --no-index" is changed so that if a path given on
> the commandline is a named pipe or a symbolic link that resolves to a
> named pipe then we read the data to diff from that pipe. This is
> implemented by generalizing the code that already exists to handle
> reading from stdin when the user passes the path "-".
>
> As process substitution is not support by POSIX this change is tested by
> using a pipe and a symbolic link to a pipe.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  diff-no-index.c          | 80 ++++++++++++++++++++++++----------------
>  t/t4053-diff-no-index.sh | 25 +++++++++++++
>  2 files changed, 73 insertions(+), 32 deletions(-)

This looks good, if a bit invasive, to a cursory read, at least to
me.  It is very focused to the real problem at hand, and shows that
the way we split the "no-index" mode out to its own implementation
of filespec population code does make sense.

> -static void populate_from_stdin(struct diff_filespec *s)
> +static void populate_from_pipe(struct diff_filespec *s, int is_stdin)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	size_t size = 0;
> +	int fd = 0;
>  
> -	if (strbuf_read(&buf, 0, 0) < 0)
> +	if (!is_stdin)
> +		fd = xopen(s->path, O_RDONLY);
> +	if (strbuf_read(&buf, fd, 0) < 0)
>  		die_errno("error while reading from stdin");
> +	if (!is_stdin)
> +		close(fd);

Given that the error message explicitly says "stdin", and there are
many "if ([!]is_stdin)" sprinkled in the code, I actually suspect
that there should be two separate helpers, one for stdin and one for
non-stdin pipe.  It is especially true since there is only one
caller that does this:

> +	if (is_pipe)
> +		populate_from_pipe(s, name == file_from_standard_input);

which can be

	if (is_pipe) {
		if (name == file_from_standard_input)
			populate_from_stdin(s);
		else
			populate_from_pipe(s);
	}

without losing clarity.  The code that you are sharing by forcing
them to be a single helper to wrap up a handful of members in the s
structure can become its own helper that is called from these two
helper functions.

>  static int queue_diff(struct diff_options *o,
> -		      const char *name1, const char *name2)
> +		      const char *name1, int is_pipe1,
> +		      const char *name2, int is_pipe2)
>  {
>  	int mode1 = 0, mode2 = 0;
>  
> -	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
> +	if (get_mode(name1, is_pipe1, &mode1) ||
> +	    get_mode(name2, is_pipe2, &mode2))
>  		return -1;

Makes me wonder why the caller of queue_diff() even needs to know if
these two names are pipes; we are calling get_mode() which would run
stat(2) anyway, and the result from stat(2) is what you use (in the
caller) to determine the values of is_pipeN.  Wouldn't it be more
appropriate to leave the caller oblivious of special casing of the
pipes and let get_mode() handle this?  After all, that is how the
existing code special cases the standard input so there is a strong
precedence.

If we go that route, it may make sense to further isolate the
"address comparison" trick used for the standard input mode.
Perhaps we can and do something like

    static int get_mode(const char *path, int *mode, int *special)
    {
	struct stat st;

+	*special = 0; /* default - nothing special */
	...
	else if (path == file_from_standard_input) {
		*mode = create_ce_mode(0666);
+		*pipe_kind = 1; /* STDIN */
+	} else if (stat(path, &st)) {
+		... error ...
+	} else if (S_ISFIFO(st.st_mode)) {
+		*mode = create_ce_mode(0666);
+		*pipe_kind = 2; /* FIFO */
	} else if (lstat(path, &st)) {
		... error ...
	} else {
		*mode = st.st_mode;
	}

and have the caller act on "special" to choose among calling
populate_from_stdin(), populate_from_pipe(), or do nothing for
the regular files?

    Side note: this has an added benefit of highlighting that we do
    stat() and lstat() because of dereferencing.  What I suspect is
    that "git diff --no-index" mode was primarily to give Git
    niceties like rename detection and diff algorithms to those who
    wanted to use in contexts (i.e. contents not tracked by Git)
    they use "diff" by other people like GNU, without bothering to
    update "diff" by other people.  I further suspect that "compare
    the readlink contents", which is very much necessary within the
    Git context, may not fall into the "Git niceties" when they
    invoke "--no-index" mode.  Which leads me to imagine a future
    direction where we only use stat() and not lstat() in the
    "--no-index" codepath.  Having everything including these
    lstat() and stat() calls inside get_mode() will allow such a
    future transition hopefully simpler.

I do not quite see why you decided to move the "is_dir" processing
up and made the caller responsible.  Specifically,

> -	fixup_paths(paths, &replacement);
> +	if (!is_pipe[0] && !is_pipe[1])
> +		fixup_paths(paths, is_dir, &replacement);

this seems fishy when one side is pipe and the other one is not.
When the user says

    $ git diff --no-index <(command) path

fixup_paths() are bypassed because one of them is pipe.  It makes me
suspect that it should be an error if "path" is a directory.  I do
not know if fixup_paths() is the best place for doing such checking,
but somebody should be doing that, no?


