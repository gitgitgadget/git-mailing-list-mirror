From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-log: added --invert-grep option
Date: Thu, 18 Dec 2014 22:50:16 -0800
Message-ID: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
References: <1418955250-22402-1-git-send-email-ottxor@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christoph Junghans <ottxor@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 07:50:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1rOM-0008Gh-G4
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 07:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbaLSGuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 01:50:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751871AbaLSGuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 01:50:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBF701B5D9;
	Fri, 19 Dec 2014 01:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zdJqTHNpn5Xg+Cgegpmcyc2R0GM=; b=XUY9qD
	FJFtjdEZ/Qa7RgGbHbgMygQE5XP/8t1ByBL6zH8FoR5+tLJUBVg59O7VZYCsuxWX
	tpPuhim2GIV2599qnjZC0idpizjtfinZ3PrnK6lnQdS1DrciLaHpDtEHO1jg71cV
	+ujVvCqVm7SY+7JSkn/0TtaaDKEfALYIg3TEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wlBD2cvElAQLKnWKvh0rUup7aKz514Yc
	yq7+3HKnbGgV49xuzMO2aXTsqQ5cg3KiEDGRVXm19/ZbtjViwzL5xqij+qVTS9Tx
	Cm6C664znkpO1boHL8Bl02iqgGem+y8XLJbMa+EJbDQbrA0nGFUSNhdXrgnM6x9G
	Cor/IhAzKfI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2D761B5D8;
	Fri, 19 Dec 2014 01:50:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40DA51B5D7;
	Fri, 19 Dec 2014 01:50:20 -0500 (EST)
In-Reply-To: <1418955250-22402-1-git-send-email-ottxor@gentoo.org> (Christoph
	Junghans's message of "Thu, 18 Dec 2014 19:14:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C71A07A-874B-11E4-8C54-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261549>

Christoph Junghans <ottxor@gentoo.org> writes:

> Implements a inverted match for "git log", like in the case of
> "git grep -v", which is useful from time to time to e.g. filter
> FIXUP message out of "git log".
>
> Internally, a new bol 'global_invert' has been introduces as
> revs->grep_filter.invert inverts the match line-wise, which cannot
> work as i.e. empty line always not match the pattern given.

While I am very sympathetic to those who feel the pain, i.e. the
need for something like this, I do not think this patch takes the
right approach.

The pain is that "git log --grep=..." can express only a limited
subset of what "git grep" can express.  The latter supports a very
rich set of logical operations, with operators like --and and --not,
and grouping, e.g. "git grep \( -e foo --or -e bar \) --and --not -e
baz" (i.e. "has either foo or bar but not baz").  It also can turn
the list of top-level predicates into "all of these predicates must
match somewhere in the entire file" with --all-match option.  None
of this richness is available to "git log --grep=...".

The root cause of the pain comes from the fact that it needs to
share the command line parsing with the revision list commands to
drive the underlying "grep" machinery, so you cannot say

    git log --not --grep=FIXUP

because "--not" is taken as "commits reachable from revs listed after
this point are to be excluded from the result" and not passed to the
underlying grep machinery.

The right way to do this is to somehow find a way to allow you to
express the full "grep" logical operations to the command line
parser that is used by the "log" family of commands.  That would
allow you to express something like "Show only commits that has
either foo or bar and does not have baz".  I am not going to
advocate this exact syntax, but to illustrate the idea, if you had
something like this supported:

    git log --grep-begin \
    	\( -e foo --or -e bar \) --and --not -e baz \
        --grep-end

by stopping the revision.c parser between --grep-{begin,end} and
instead feeding the arguments to the grep expression builder, we may
be able to get the full expressiveness of the logical operations
offered by the grep machinery.

And you shouldn't need to add any new field to grep_opt for that.
All you need is a design of a new syntax and a tweak to the revision
argument parser to understand the new syntax to redirect some
arguments to the grep command line parser.

A new option that allows you to _only_ negate without allowing you
to enable other richer logical operations of the underlying grep
machinery is going in a wrong direction, isn't it?

> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> ---
>  Documentation/rev-list-options.txt     | 4 ++++
>  contrib/completion/git-completion.bash | 2 +-
>  grep.h                                 | 3 ++-
>  revision.c                             | 4 +++-
>  4 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index afccfdc..6d4671f 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -66,6 +66,10 @@ if it is part of the log message.
>  	Limit the commits output to ones that match all given `--grep`,
>  	instead of ones that match at least one.
>  
> +--invert-grep::
> +	Limit the commits output to ones with log message that do not
> +	match the pattern specified with `--grep=<pattern>`.
> +
>  -i::
>  --regexp-ignore-case::
>  	Match the regular expression limiting patterns without regard to letter
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2fece98..914c317 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1425,7 +1425,7 @@ __git_log_gitk_options="
>  # Options that go well for log and shortlog (not gitk)
>  __git_log_shortlog_options="
>  	--author= --committer= --grep=
> -	--all-match
> +	--all-match --invert-grep
>  "
>  
>  __git_log_pretty_formats="oneline short medium full fuller email raw format:"
> diff --git a/grep.h b/grep.h
> index 95f197a..c137103 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -93,7 +93,8 @@ struct grep_opt {
>  	int prefix_length;
>  	regex_t regexp;
>  	int linenum;
> -	int invert;
> +	int invert; /** line-wise invert match */
> +	int global_invert; /** final global invert match */
>  	int ignore_case;
>  	int status_only;
>  	int name_only;
> diff --git a/revision.c b/revision.c
> index 75dda92..c8d4c49 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2011,6 +2011,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
>  	} else if (!strcmp(arg, "--all-match")) {
>  		revs->grep_filter.all_match = 1;
> +	} else if (!strcmp(arg, "--invert-grep")) {
> +		revs->grep_filter.global_invert = 1;
>  	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
>  		if (strcmp(optarg, "none"))
>  			git_log_output_encoding = xstrdup(optarg);
> @@ -2909,7 +2911,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  				     (char *)message, strlen(message));
>  	strbuf_release(&buf);
>  	unuse_commit_buffer(commit, message);
> -	return retval;
> +	return opt->grep_filter.global_invert ? !retval : retval;
>  }
>  
>  static inline int want_ancestry(const struct rev_info *revs)
