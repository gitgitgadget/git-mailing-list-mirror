From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] Add default merge options for all branches
Date: Tue, 3 May 2011 15:44:42 -0500
Message-ID: <20110503204442.GI1019@elie>
References: <20110503090351.GA27862@elie>
 <4DC0608F.9040208@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	vmiklos@frugalware.org
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Tue May 03 22:44:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHMSk-0005Wn-RM
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 22:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152Ab1ECUot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 16:44:49 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55159 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab1ECUot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 16:44:49 -0400
Received: by yia27 with SMTP id 27so185110yia.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aVjYYahC8c0ksQwChN0cvDILfv4gzrUoTzJuoOosMmQ=;
        b=Gr0L8OxAkq/LCtrx2CUoHJ2PLHqwm4Z/CY5pQtQUeBZBQ9utWYwnNg/NdDVcKeUrgC
         xfX3nE/wmXKGogmippZ1ZvUjCCOZs70X5EAFsRwaw101Ub6NcKuAw53+3Bs5Qyjlfv8/
         0judUOnTJl7dAYveX0bmNHPUM74nky4zYZcJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w7d9WOnoyGt2hSO2PMup84VdAafKJerbUQOuI4jO4JmnE+ygg78TTNEn4DNmmJLLfu
         w8dUyoGmS2K+he1pZkZ6DHufIeax8AAU3GMhCx8kmMMEMVacDC28Nbsm3ZgEjDWSXufY
         BEWD3adY8KN4z+MolBOOWgZZyjheef9iV8MzM=
Received: by 10.100.214.16 with SMTP id m16mr223025ang.41.1304455488449;
        Tue, 03 May 2011 13:44:48 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.sbcglobal.net [69.209.62.211])
        by mx.google.com with ESMTPS id w1sm409591anh.36.2011.05.03.13.44.46
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 13:44:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DC0608F.9040208@dailyvoid.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172692>

Michael Grubb wrote:

> In order to facilitate future features centered around this new
> "globlike" syntax a new struct has been created to keep track of the
> branch.*.* options.  Currently it only supports branch.*.mergeoptions,
> but can be easily modified in the future to support other branch
> specific options as well. The mechanism will "vote" on specific-"ness"
> of the configuration key and ultimately only use the most specific
> options.

My immediate reactions:

 - Is this really needed?  If we need some priority field when other
   branch globs are being supported, can't we add it then?

 - Floating point?  *turns to flee*

> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -307,6 +307,9 @@ branch.<name>.mergeoptions::
>  	Sets default options for merging into branch <name>. The syntax and
>  	supported options are the same as those of 'git merge', but option
>  	values containing whitespace characters are currently not supported.
> +	The special value '*' for <name> may be used to configure default
> +	options for all branches.  Values for specific branch names will
> +	override the this default.

In what sense are they overridden?  For example, if I write

	[branch "*"]
		mergeoptions = --no-ff

	[branch "master"]
		mergeoptions = --log=5

and merge another branch into master, will the effect be as though I
wrote --no-ff --log=5 or just --log=5?

I'm starting to suspect it might be simpler to add a new "[merge] no-ff"
configuration item, like the existing "[merge] log".

> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -32,6 +32,21 @@
>  #define NO_FAST_FORWARD (1<<2)
>  #define NO_TRIVIAL      (1<<3)
>  
> +/* This is for branch.<foo>. blocks
> + * the vote member holds a value between
> + * 0.0 and 1.0 which measures how closely
> + * a branch name matches the key member.
> + * where branch.*.mergeoptions would be 0.1 and
> + * branch.<name>.mergeoptions would be 1.0
> + * Also it is called vote because I couldn't come
> + * up with a better name.
> + */

Style: comments should look like this:

	/*
	 * Explanation comes here, with each line being
	 * approximately the same length as the next one.
	 */

"It is called vote because I couldn't come up with a better name" does
not belong in a comment unless you are asking the reader to fix it.
In that case, I would write something like

	float vote;	/* NEEDSWORK: give this a better name */

or

	float priority;

> +struct merge_options_cb {
> +	char *key;
> +	char *value;
> +	float vote;
> +};

Since I didn't read the comment, I'm not sure what these represent.
Who is responsible for freeing them?  Is the key a glob?

> @@ -503,28 +518,60 @@ cleanup:
>  	strbuf_release(&bname);
>  }
>  
> -static int git_merge_config(const char *k, const char *v, void *cb)
> +static void parse_git_merge_options(const char *k, const char *v,
> +			void *cb)
>  {
> -	if (branch && !prefixcmp(k, "branch.") &&
> -		!prefixcmp(k + 7, branch) &&
> -		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
> -		const char **argv;
> -		int argc;
> -		char *buf;
> -
> -		buf = xstrdup(v);
> -		argc = split_cmdline(buf, &argv);
> -		if (argc < 0)
> -			die(_("Bad branch.%s.mergeoptions string: %s"), branch,
> -			    split_cmdline_strerror(argc));
> -		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
> -		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
> -		argc++;
> -		parse_options(argc, argv, NULL, builtin_merge_options,
> -			      builtin_merge_usage, 0);
> -		free(buf);
> +	struct merge_options_cb *merge_options = cb;
> +	int changed = 0;
> +
> +	/* We only handle mergeoptions for now */
> +	if (suffixcmp(k, ".mergeoptions"))
> +		return;

The function is called parse_git_merge_options; I wonder if this "for
now" is an old comment from when it had a different name.

> +
> +	if (!prefixcmp(k, "branch.*") && merge_options->vote <= 0.1 ) {
> +		merge_options->vote = 0.1;
> +		changed = 1;

Style: parens.  What happens if I use

	[branch "*aster"]
		mergeoptions = ...

or

	[branch "*.c"]
		mergeoptions = ...

?  Where does 0.1 come from?

> +	} else if (branch && !prefixcmp(k, "branch.") &&
> +				!prefixcmp(k + 7, branch) &&
> +				merge_options->vote < 1.0) {
> +		merge_options->vote = 1.0;
> +		changed = 1;

What does changed mean?

>  	}
>  
> +	if (changed) {
> +		merge_options->key = (char *)k;
> +		merge_options->value = (char *)v;

Why not make the struct fields const?

> +	}
> +}
> +
> +static void apply_merge_options(struct merge_options_cb *opts)
> +{
> +	const char **argv;
> +	int argc;
> +	char *buf;
> +
> +	if ( opts == NULL )

Style: parens.  It would be more idiomatic to say

	if (!opts)

> +		return;
> +
> +	buf = xstrdup(opts->value);
> +	argc = split_cmdline(buf, &argv);
> +	if (argc < 0)
> +		die(_("Bad %s string: %s"), 
> +			opts->key, split_cmdline_strerror(argc));
> +
> +	argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
> +	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
> +	argc++;
> +	parse_options(argc, argv, NULL, builtin_merge_options,
> +			  builtin_merge_usage, 0);
> +	free(buf);
> +}

Idea: the series could be made easier to read if splitting this off
into its own function were a separate patch.  Anyway, splitting it out
was a good idea; thanks for doing that.

It seems you changed the whitespace while unindenting?  The whitespace
on the continuation line for parse_options(...) arguments is
especially confusing (I suspect you are using a tabwidth of 6, but
that doesn't make sense, either, since opts->key is not an argument to
_.  The official rendering uses a tabwidth of 8).

> +
> +static int git_merge_config(const char *k, const char *v, void *cb)
> +{
> +	if (cb != NULL && branch && !prefixcmp(k, "branch."))
> +		parse_git_merge_options(k, v, cb);

More idiomatic to say

	if (!cb && branch && !prefixcmp(k, "branch."))
		...

Changing behavior when cb is NULL seems odd to me.  Would it ever
actually be NULL?

> @@ -1004,7 +1052,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	if (is_null_sha1(head))
>  		head_invalid = 1;
>  
> -	git_config(git_merge_config, NULL);
> +	git_config(git_merge_config, &merge_options);
> +	if (merge_options.key != NULL && merge_options.value != NULL)
> +		apply_merge_options(&merge_options);

More idiomatic to say

	if (merge_options.key && merge_options.value)

But this seems odd, too --- when would "key" be non-null without
"value" being so?

> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -415,6 +415,45 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
[...]
> +test_expect_success 'combine branch.*.mergeoptions with branch.x.mergeoptions' '
> +	git reset --hard c0 &&
> +	test_might_fail git config --remove-section branch.master &&
> +	git config "branch.*.mergeoptions" "--no-ff" &&
> +	git config branch.master.mergeoptions "--ff" &&
> +	test_tick &&
> +	git merge c1 &&
> +	git config --remove-section "branch.*" &&
> +	verify_merge file result.1 &&
> +	verify_parents "$c0"
> +'
> +
> +test_expect_success 'reverse branch.x.mergeoptions with branch.*.mergeoptions' '
> +	git reset --hard c0 &&
> +	test_might_fail git config --remove-section branch.master &&
> +	git config branch.master.mergeoptions "--ff" &&
> +	git config "branch.*.mergeoptions" "--no-ff" &&
> +	test_tick &&
> +	git merge c1 &&

Thanks.  This might pass by mistake with a "git config" implementation
that sorts its entries when writing them; since I think git is
intended to allow users writing to the config file directly, too,
maybe something along the lines of

	cat >>.git/config <<-\EOF &&
	[branch "master"]
		mergeoptions = --ff

	[branch "*"]
		mergeoptions = --no-ff
	EOF

could be interesting.

Also --ff and --no-ff do not have orthogonal effect.  What happens
when the merge options do (e.g., --ff and --log)?

> +	git config --remove-section "branch.*" &&
> +	verify_merge file result.1 &&
> +	verify_parents "$c0"
> +'

Thanks again.

Hope that helps,
Jonathan
