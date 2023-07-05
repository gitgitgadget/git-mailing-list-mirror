Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C1EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 22:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjGEWTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 18:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGEWTF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 18:19:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71A3139
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 15:19:04 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E976518B40D;
        Wed,  5 Jul 2023 18:19:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IHtTO+WuNoD4/KO44NGs0SCnmxf0qyyjIMLMAL
        33IY8=; b=ZrvIqprxj/QOov2jJB/Gs4DZR6m8Tb4z56ytPuywf98C3olEj2KBaI
        iDpVcbPdSnPPNohB62n9zLya7xC1ogzVTnf5xHLt3UsLymCxummuq8SB6qs1u5v6
        MZGAchkUJMGhR8tXVcX9gcBEjS3J5ca/KBAzvwQVEh0E5IQgkCz68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE39318B40C;
        Wed,  5 Jul 2023 18:19:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6A8D18B40B;
        Wed,  5 Jul 2023 18:19:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>
Subject: Re: [PATCH v2 4/4] diff --no-index: support reading from named pipes
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
        <cover.1688586536.git.phillip.wood@dunelm.org.uk>
        <4e05a0be54f66f2b394642762832e426a545426c.1688586536.git.phillip.wood@dunelm.org.uk>
Date:   Wed, 05 Jul 2023 15:19:01 -0700
In-Reply-To: <4e05a0be54f66f2b394642762832e426a545426c.1688586536.git.phillip.wood@dunelm.org.uk>
        (Phillip Wood's message of "Wed, 5 Jul 2023 20:49:30 +0100")
Message-ID: <xmqq1qhmvw6i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F28D521E-1B81-11EE-A3A4-C65BE52EC81B-77302942!pb-smtp1.pobox.com
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

"command substitution" -> "process substitution", I think, are the
words found in the manual pages of both shells cited as examples.

> However, this syntax does not produce useful results with "git diff
> --no-index". On macOS, the arguments to the command are named pipes
> under /dev/fd, and git diff doesn't know how to handle a named pipe. On
> Linux, the arguments are symlinks to pipes, so git diff "helpfully"
> diffs these symlinks, comparing their targets like "pipe:[1234]" and
> "pipe:[5678]".

Concisely and clearly described.  Very nice.

> To address this "diff --no-index" is changed so that if a path given on

"this" -> "this,", probably.

> the commandline is a named pipe or a symbolic link that resolves to a
> named pipe then we read the data to diff from that pipe. This is
> implemented by generalizing the code that already exists to handle
> reading from stdin when the user passes the path "-".

Great.

> If the user tries to compare a named pipe to a directory then we die as
> we do when trying to compare stdin to a directory.
>
> As process substitution is not support by POSIX this change is tested by
> using a pipe and a symbolic link to a pipe.

People who are interested to more directly test the intended use
case can add a test "diff --no-index <(one) <(two)" under some
prerequisite (like BASH).  The test on the underlying mechansim like
this patch does is just fine in the meantime.

> diff --git a/diff-no-index.c b/diff-no-index.c
> index 4470e0271d..4771cf02aa 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -41,74 +41,119 @@ static int read_directory_contents(const char *path, struct string_list *list)
>   */
>  static const char file_from_standard_input[] = "-";
>  
> -static int get_mode(const char *path, int *mode)
> +/*
> + * For paths given on the command-line we treat "-" as stdin and named
> + * pipes and symbolic links to named pipes specially.
> + */
> +enum special {
> +	SPECIAL_NONE,
> +	SPECIAL_STDIN,
> +	SPECIAL_PIPE,
> +};
> +
> +static int get_mode(const char *path, int *mode, enum special *special)
>  {
>  	struct stat st;
>  
> -	if (!path || !strcmp(path, "/dev/null"))
> +	if (!path || !strcmp(path, "/dev/null")) {
>  		*mode = 0;
>  #ifdef GIT_WINDOWS_NATIVE
> -	else if (!strcasecmp(path, "nul"))
> +	} else if (!strcasecmp(path, "nul")) {
>  		*mode = 0;
>  #endif
> -	else if (path == file_from_standard_input)
> +	} else if (path == file_from_standard_input) {
>  		*mode = create_ce_mode(0666);
> -	else if (lstat(path, &st))
> +		*special = SPECIAL_STDIN;
> +	} else if (lstat(path, &st)) {
>  		return error("Could not access '%s'", path);
> -	else
> +	} else {
>  		*mode = st.st_mode;
> +	}
> +	/*
> +	 * For paths on the command-line treat named pipes and symbolic
> +	 * links that resolve to a named pipe specially.
> +	 */

Excellent.  The code structure is very clear.  We do what we have
already done, and in addition, treat pipes and symlinks to pipes
specially.

> +	if (special &&
> +	    (S_ISFIFO(*mode) ||
> +	     (S_ISLNK(*mode) && !stat(path, &st) && S_ISFIFO(st.st_mode)))) {
> +		*mode = create_ce_mode(0666);
> +		*special = SPECIAL_PIPE;
> +	}

What should we do when !stat(path, &st) fails here?  It may be a
dangling symbolic link, causes stat() to fail and we want to be
silent about it without changing *mode.  And that is exactly what
the code does.  Great.

Under what circumstances does a caller pass NULL to the special?  If
we were given a fifo and the caller passes NULL to the special,
*mode at this point would be S_ISFIFO() and not 0666.  It may be
what we want, but I do not immediately see why (I'll realize why
while reading the "recursing?" bit below).

> -static void populate_from_stdin(struct diff_filespec *s)
> +static void populate_common(struct diff_filespec *s, struct strbuf *buf)
>  {
> -	struct strbuf buf = STRBUF_INIT;
>  	size_t size = 0;

Not a new issue, but this initialization assignment is useless as
strbuf_detach() would always overwrite it (or die and would not come
back to us).

> -	if (strbuf_read(&buf, 0, 0) < 0)
> -		die_errno("error while reading from stdin");
> -
>  	s->should_munmap = 0;
> -	s->data = strbuf_detach(&buf, &size);
> +	s->data = strbuf_detach(buf, &size);
>  	s->size = size;

Again not a new issue, but it is unfortunate that s->size is not
size_t but ulong, which requires us to use a temporary variable of
the correct type, only to assign to it.

>  	s->should_free = 1;
>  	s->is_stdin = 1;
>  }
>  
> -static struct diff_filespec *noindex_filespec(const char *name, int mode)
> +static void populate_from_pipe(struct diff_filespec *s)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	int fd = xopen(s->path, O_RDONLY);
> +
> +	if (strbuf_read(&buf, fd, 0) < 0)
> +		die_errno("error while reading from '%s'", s->path);
> +	close(fd);
> +	populate_common(s, &buf);
> +}
> +
> +static void populate_from_stdin(struct diff_filespec *s)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (strbuf_read(&buf, 0, 0) < 0)
> +		die_errno("error while reading from stdin");
> +	populate_common(s, &buf);
> +}

Both look OK.  I would have named "_common" -> "_finalize" or
something to signal that this is the shared "tail" part of the two
callers, but it is minor.

> +static struct diff_filespec *noindex_filespec(const char *name, int mode,
> +					      enum special special)
>  {
>  	struct diff_filespec *s;
>  
>  	if (!name)
>  		name = "/dev/null";
>  	s = alloc_filespec(name);
>  	fill_filespec(s, null_oid(), 0, mode);
> -	if (name == file_from_standard_input)
> +	if (special == SPECIAL_STDIN)
>  		populate_from_stdin(s);
> +	else if (special == SPECIAL_PIPE)
> +		populate_from_pipe(s);
>  	return s;
>  }

Great.

>  static int queue_diff(struct diff_options *o,
> -		      const char *name1, const char *name2)
> +		      const char *name1, const char *name2, int recursing)
>  {
>  	int mode1 = 0, mode2 = 0;
> +	enum special special1 = SPECIAL_NONE, special2 = SPECIAL_NONE;
>  
> -	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
> +	/* Paths can only be special if we're not recursing. */
> +	if (get_mode(name1, &mode1, recursing ? NULL : &special1) ||
> +	    get_mode(name2, &mode2, recursing ? NULL : &special2))
>  		return -1;

Ahh, OK.  If we are told to "diff --no-index D1 D2", even if we find
a fifo or symlink to a fifo, they aren't "<(foo)" process
substitutions.  Makes sense.  And because we do not handle FIFO in
such a case, we'd leave *mode (in get_mode()) to a value that we
never use (i.e. S_ISFIFO(*mode) is true); hopefully later part of
the control flow somewhere we will notice it and die?

>  	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
>  		struct diff_filespec *d1, *d2;
>  
>  		if (S_ISDIR(mode1)) {
>  			/* 2 is file that is created */
> -			d1 = noindex_filespec(NULL, 0);
> -			d2 = noindex_filespec(name2, mode2);
> +			d1 = noindex_filespec(NULL, 0, SPECIAL_NONE);
> +			d2 = noindex_filespec(name2, mode2, special2);
>  			name2 = NULL;
>  			mode2 = 0;
>  		} else {
>  			/* 1 is file that is deleted */
> -			d1 = noindex_filespec(name1, mode1);
> -			d2 = noindex_filespec(NULL, 0);
> +			d1 = noindex_filespec(name1, mode1, special1);
> +			d2 = noindex_filespec(NULL, 0, SPECIAL_NONE);
>  			name1 = NULL;
>  			mode1 = 0;
>  		}
> @@ -173,7 +218,7 @@ static int queue_diff(struct diff_options *o,
>  				n2 = buffer2.buf;
>  			}
>  
> -			ret = queue_diff(o, n1, n2);
> +			ret = queue_diff(o, n1, n2, 1);
>  		}
>  		string_list_clear(&p1, 0);
>  		string_list_clear(&p2, 0);
> @@ -189,8 +234,8 @@ static int queue_diff(struct diff_options *o,
>  			SWAP(name1, name2);
>  		}
>  
> -		d1 = noindex_filespec(name1, mode1);
> -		d2 = noindex_filespec(name2, mode2);
> +		d1 = noindex_filespec(name1, mode1, special1);
> +		d2 = noindex_filespec(name2, mode2, special2);
>  		diff_queue(&diff_queued_diff, d1, d2);
>  		return 0;
>  	}

Looks quite straight-forward.

> @@ -215,15 +260,27 @@ static void append_basename(struct strbuf *path, const char *dir, const char *fi
>   */
>  static void fixup_paths(const char **path, struct strbuf *replacement)
>  {
> -	unsigned int isdir0, isdir1;
> -
> -	isdir0 = path[0] != file_from_standard_input && is_directory(path[0]);
> -	isdir1 = path[1] != file_from_standard_input && is_directory(path[1]);
> +	struct stat st;
> +	unsigned int isdir0 = 0, isdir1 = 0;
> +	unsigned int ispipe0 = 0, ispipe1 = 0;
> +
> +	if (path[0] != file_from_standard_input && !stat(path[0], &st)) {
> +		isdir0 = S_ISDIR(st.st_mode);
> +		ispipe0 = S_ISFIFO(st.st_mode);
> +	}
> +
> +	if (path[1] != file_from_standard_input && !stat(path[1], &st)) {
> +		isdir1 = S_ISDIR(st.st_mode);
> +		ispipe1 = S_ISFIFO(st.st_mode);
> +	}
>  
>  	if ((path[0] == file_from_standard_input && isdir1) ||
>  	    (isdir0 && path[1] == file_from_standard_input))
>  		die(_("cannot compare stdin to a directory"));
>  
> +	if ((isdir0 && ispipe1) || (ispipe0 && isdir1))
> +		die(_("cannot compare a named pipe to a directory"));
> +

Nice.

