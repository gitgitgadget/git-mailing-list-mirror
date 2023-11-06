Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E145393
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k3Pd4OS+"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E0D8
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 16:50:47 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E43BE29C5F;
	Sun,  5 Nov 2023 19:50:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wns729h488CY1ziO3suOu2BSM7toKL9dQiX8Jr
	VfdC4=; b=k3Pd4OS+6P7lWmRFOU8fMqHDzkdb4+hKt8kZxLE1wSIk5ghF9O8Sh8
	LU7spo88g8fhFe+Nd3Kq5aROJjEE6+O9YRGtwW3fOZL2HbOgPCkOgFLz2CC3o/Kh
	QGZ+My1AeDpkYXO5mepyBXhTyv1xD6qkLFUPaILloZ1VF+OGiGO/U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD72429C5E;
	Sun,  5 Nov 2023 19:50:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7CD3329C58;
	Sun,  5 Nov 2023 19:50:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com
Subject: Re: [PATCH v2 1/2] rebase: support non-interactive autosquash
In-Reply-To: <20231104220330.14577-1-andy.koppe@gmail.com> (Andy Koppe's
	message of "Sat, 4 Nov 2023 22:03:29 +0000")
References: <20231103212958.18472-1-andy.koppe@gmail.com>
	<20231104220330.14577-1-andy.koppe@gmail.com>
Date: Mon, 06 Nov 2023 09:50:41 +0900
Message-ID: <xmqqcywng0wu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83BF25A6-7C3E-11EE-A515-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Andy Koppe <andy.koppe@gmail.com> writes:

> So far, the rebase --autosquash option and rebase.autoSquash=true
> config setting are quietly ignored when used without --interactive,
> except that they prevent fast-forward and that they trigger conflicts
> with --apply and relatives, which is less than helpful particularly for
> the config setting.

OK.  You do not explicitly say "So far," by the way.  Our log
message convention is to first describe what happens in the system
in the present tense to illustrate why it is suboptimal, to prepare
readers' minds to anticipate the solution, which is described next.

> Since the "merge" backend used for interactive rebase also is the
> default for non-interactive rebase, there doesn't appear to be a
> reason not to do --autosquash without --interactive, so support that.

Nice.

> Turn rebase.autoSquash into a comma-separated list of flags, with
> "interactive" or "i" enabling auto-squashing with --interactive, and
> "no-interactive" or "no-i" enabling it without. Make boolean true mean
> "interactive" for backward compatibility.

"i" and "no-i" are questionable (will talk about them later), but
otherwise, nicely explained.

> Don't prevent fast-forwards or report conflicts with --apply options
> when auto-squashing is not active.
>
> Change the git-rebase and config/rebase documentation accordingly, and
> extend t3415-rebase-autosquash.sh to test the new rebase.autosquash
> values and combinations with and without --interactive.
>
> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---

When asking reviews on a new iteration [PATCH v(N+1)], please
summarize the differences relative to [PATCH vN].  For explaining
such incremental changes for individual patches, here between the
three-dash line and the diffstat is the place to do so.  When you
have a cover letter [PATCH 0/X], it can be done in that messaage.
Either way is OK.  Doing both is also helpful as long as the
explanation done in two places do not contradict with each other.

>  Documentation/config/rebase.txt        | 11 +++-
>  Documentation/git-rebase.txt           |  2 +-
>  builtin/rebase.c                       | 63 ++++++++++++++-----
>  t/t3415-rebase-autosquash.sh           | 83 +++++++++++++++++++++-----
>  t/t3422-rebase-incompatible-options.sh |  2 +-
>  5 files changed, 129 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index 9c248accec..68191e5673 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -9,7 +9,16 @@ rebase.stat::
>  	rebase. False by default.
>  
>  rebase.autoSquash::
> -	If set to true enable `--autosquash` option by default.
> +	A comma-separated list of flags for when to enable auto-squashing.
> +	Specifying `interactive` or `i` enables auto-squashing for rebasing with
> +	`--interactive`, whereas `no-interactive` or `no-i` enables it for
> +	rebasing without that option. For example, setting this to `i,no-i`
> +	enables auto-squashing for both types. Setting it to true is equivalent
> +	to setting it to `interactive`.
> +
> +	The `--autosquash` and `--no-autosquash` options of
> +	linkgit:git-rebase[1] override the setting here.
> +	Auto-squashing is disabled by default.

If you trid to format the documentation before sending this patch,
you'd have seen the second paragraph formatted as if it were a code
snippet.  Dedent the second paragraph (and later ones if you had
more than one extra paragraphs), and turn the blank line between the
paragraphs into a line with "+" (and nothing else) on it.  See the
description of `--autosquash` option in Documentation/git-rebase.txt
for an example.

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index e7b39ad244..102ff91493 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -592,7 +592,7 @@ See also INCOMPATIBLE OPTIONS below.
>  	When the commit log message begins with "squash! ..." or "fixup! ..."
>  	or "amend! ...", and there is already a commit in the todo list that
>  	matches the same `...`, automatically modify the todo list of
> -	`rebase -i`, so that the commit marked for squashing comes right after
> +	`rebase`, so that the commit marked for squashing comes right after
>  	the commit to be modified, and change the action of the moved commit
>  	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
>  	matches the `...` if the commit subject matches, or if the `...` refers
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 261a9a61fc..0403c7415c 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -131,7 +131,10 @@ struct rebase_options {
>  	int reapply_cherry_picks;
>  	int fork_point;
>  	int update_refs;
> -	int config_autosquash;
> +	enum {
> +		AUTOSQUASH_INTERACTIVE = 1 << 0,
> +		AUTOSQUASH_NO_INTERACTIVE = 1 << 1,
> +	} config_autosquash;
>  	int config_rebase_merges;
>  	int config_update_refs;
>  };
> @@ -149,7 +152,6 @@ struct rebase_options {
>  		.reapply_cherry_picks = -1,             \
>  		.allow_empty_message = 1,               \
>  		.autosquash = -1,                       \
> -		.config_autosquash = -1,                \
>  		.rebase_merges = -1,                    \
>  		.config_rebase_merges = -1,             \
>  		.update_refs = -1,                      \
> @@ -711,10 +713,8 @@ static int run_specific_rebase(struct rebase_options *opts)
>  	if (opts->type == REBASE_MERGE) {
>  		/* Run sequencer-based rebase */
>  		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
> -		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
> +		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT))
>  			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
> -			opts->autosquash = 0;
> -		}
>  		if (opts->gpg_sign_opt) {
>  			/* remove the leading "-S" */
>  			char *tmp = xstrdup(opts->gpg_sign_opt + 2);
> @@ -748,6 +748,27 @@ static int run_specific_rebase(struct rebase_options *opts)
>  	return status ? -1 : 0;
>  }
>  
> +static void parse_rebase_autosquash_value(struct rebase_options *opts,
> +					  const char *var, const char *value)
> +{
> +	struct string_list tokens = STRING_LIST_INIT_NODUP;
> +	char *buf = xstrdup(value);
> +
> +	opts->config_autosquash = 0;
> +	string_list_split_in_place(&tokens, buf, ",", -1);
> +
> +	for (int i = 0; i < tokens.nr; i++) {
> +		const char *s = tokens.items[i].string;
> +
> +		if (!strcmp(s, "i") || !strcmp(s, "interactive"))
> +			opts->config_autosquash |= AUTOSQUASH_INTERACTIVE;
> +		else if (!strcmp(s, "no-i") || !strcmp(s, "no-interactive"))
> +			opts->config_autosquash |= AUTOSQUASH_NO_INTERACTIVE;
> +		else
> +			die(_("invalid value for '%s': '%s'"), var, s);
> +	}
> +}

OK, by clearing opts->config_autosquash in this function, you keep
the rebase.autosquash to be "the last one wins" as a whole.  If a
configuration file with lower precedence (e.g., /etc/gitconfig) says
"[rebase] autosquash" to set it to "interactive,no-interactive", a
separate setting in your ~/.gitconfig "[rebase] autosquash = false"
would override both bits.

A more involved design may let the users override these bits
independently by allowing something like "!no-i" (take whatever the
lower precedence configuration file says for the interactive case,
but disable autosquash when running a non-interactive rebase) as the
value, but I think the approach taken by this patch to allow replacing
as a whole is OK.  It is simpler to explain.

Giving short-hands for often used command line options is one thing,
but I do not think a short-hand is warranted here, especially when
the other one needs to be a less-than-half legible "no-i" that does
not allow "no-int" and friends, for configuration variable values.
I'd strongly suggest dropping them.

Thanks.
