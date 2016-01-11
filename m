From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 09:30:20 -0800
Message-ID: <xmqqh9ikxbv7.fsf@gitster.mtv.corp.google.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
	<1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 18:30:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIgIY-0002cL-QD
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761450AbcAKRaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:30:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757612AbcAKRaX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:30:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A807738F28;
	Mon, 11 Jan 2016 12:30:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=za8D+VxY7ZLIwBia6gBIi6TBhf4=; b=XSeuyY
	v3OtKCN4kE5va5TVn7le81LubhRC7ceGTxqDoqQEuPGZ6UI3FvC5w0npmJkZLJ2n
	3Vzf9SEaIDQSmAVqDuv6CurEfOw5/Y6Y0DTtmruzk6ZnN7JE00V2+08VTQZhPrV9
	ifMK+kfrCvdFLVzvYEoHQta+Gc/JWp8eqI/ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R9ZaTUd66C0QyFzkBe9PsyytaZLamztl
	He/B0sZJbgWkoOQ5Vm+Sd0H2CawR1Dw9lJridWYAJa/Ia5WCkWVuaGW9E/t6ZMzd
	2wYartryYPipaMvhwMIioIxTtd7tTfAcFzBWY7SHYLiK9Gc97A5rrjZyFSFgCGq4
	Fb/WlecXUxc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D97E38F27;
	Mon, 11 Jan 2016 12:30:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 07BAA38F25;
	Mon, 11 Jan 2016 12:30:21 -0500 (EST)
In-Reply-To: <1452435597-12099-4-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Sun, 10 Jan 2016 15:19:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDF55A8E-B888-11E5-836E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283679>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Currently when git grep is used outside of a git repository without the
> --no-index option git simply dies.  For convenience, implicitly make git
> grep behave like git grep --no-index when it is called outside of a git
> repository.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/grep.c  | 32 ++++++++++++++++++++++++--------
>  t/t7810-grep.sh | 41 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 62 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 3a27bd5..a886af1 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -19,6 +19,9 @@
>  #include "dir.h"
>  #include "pathspec.h"
>  
> +#define GREP_NO_INDEX_EXPLICIT 1
> +#define GREP_NO_INDEX_IMPLICIT 2

I am not sure this is the best way to do this.  For things like
this, the usual pattern is to initialize "no_index" to an "unknown"
value, allow "--no-index" to toggle it to true (by the way, I think
we should reject "--no-no-index", but that is a separate topic), and
then after command line parsing finishes, tweak the no_index if it
is still "unknown".

>  static char const * const grep_usage[] = {
>  	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
>  	NULL
> @@ -632,7 +635,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "cached", &cached,
>  			N_("search in index instead of in the work tree")),
>  		OPT_BIT(0, "no-index", &no_index,
> -			N_("find in contents not managed by git"), 1),
> +			N_("find in contents not managed by git"),
> +			GREP_NO_INDEX_EXPLICIT),
>  		OPT_BOOL(0, "untracked", &untracked,
>  			N_("search in both tracked and untracked files")),
>  		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
> @@ -755,9 +759,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  	grep_commit_pattern_type(pattern_type_arg, &opt);
>  
> -	if (!no_index && !startup_info->have_repository)
> -		/* die the same way as if we did it at the beginning */
> -		setup_git_directory();
> +	if (!no_index && !startup_info->have_repository) {
> +		int nongit = 0;
> +
> +		setup_git_directory_gently(&nongit);
> +		if (nongit)
> +			no_index = GREP_NO_INDEX_IMPLICIT;
> +	}
>  
>  	/*
>  	 * skip a -- separator; we know it cannot be
> @@ -873,13 +881,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	if (!show_in_pager && !opt.status_only)
>  		setup_pager();
>  
> -	if (no_index && (untracked || cached))
> -		die(_("--cached or --untracked cannot be used with --no-index."));
> +	if (untracked || cached) {
> +		if (no_index == GREP_NO_INDEX_EXPLICIT)
> +			die(_("--cached or --untracked cannot be used with --no-index."));
> +		else if (no_index == GREP_NO_INDEX_IMPLICIT)
> +			die(_("--cached or --untracked cannot be used outside a git repository."));
> +	}
>  
>  	if (no_index || untracked) {
>  		int use_exclude = (opt_exclude < 0) ? !no_index : !!opt_exclude;
> -		if (list.nr)
> -			die(_("--no-index or --untracked cannot be used with revs."));
> +		if (list.nr) {
> +			if (no_index == GREP_NO_INDEX_IMPLICIT)
> +				die(_("cannot use revs outside of a git repository."));
> +			else
> +				die(_("--no-index or --untracked cannot be used with revs."));
> +		}
>  		hit = grep_directory(&opt, &pathspec, use_exclude);
>  	} else if (0 <= opt_exclude) {
>  		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index ab94716..4ba955d 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -794,11 +794,9 @@ test_expect_success 'outside of git repository' '
>  		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
>  		export GIT_CEILING_DIRECTORIES &&
>  		cd non/git &&
> -		test_must_fail git grep o &&
>  		git grep --no-index o >../actual.full &&
>  		test_cmp ../expect.full ../actual.full
>  		cd sub &&
> -		test_must_fail git grep o &&
>  		git grep --no-index o >../../actual.sub &&
>  		test_cmp ../../expect.sub ../../actual.sub
>  	) &&
> @@ -808,7 +806,6 @@ test_expect_success 'outside of git repository' '
>  		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
>  		export GIT_CEILING_DIRECTORIES &&
>  		cd non/git &&
> -		test_must_fail git grep o &&
>  		git grep --no-index --exclude-standard o >../actual.full &&
>  		test_cmp ../expect.full ../actual.full &&
>  
> @@ -821,6 +818,44 @@ test_expect_success 'outside of git repository' '
>  	)
>  '
>  
> +test_expect_success 'outside of git repository without --no-index' '
> +	rm -fr non &&
> +	mkdir -p non/git/sub &&
> +	echo hello >non/git/file1 &&
> +	echo world >non/git/sub/file2 &&
> +	{
> +		echo file1:hello &&
> +		echo sub/file2:world
> +	} >non/expect.full &&
> +	echo file2:world >non/expect.sub &&
> +	(
> +		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd non/git &&
> +		git grep o >../actual.full &&
> +		test_cmp ../expect.full ../actual.full
> +		cd sub &&
> +		git grep o >../../actual.sub &&
> +		test_cmp ../../expect.sub ../../actual.sub
> +	) &&
> +
> +	echo ".*o*" >non/git/.gitignore &&
> +	(
> +		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd non/git &&
> +		git grep --exclude-standard o >../actual.full &&
> +		test_cmp ../expect.full ../actual.full &&
> +
> +		{
> +			echo ".gitignore:.*o*"
> +			cat ../expect.full
> +		} >../expect.with.ignored &&
> +		git grep --no-exclude o >../actual.full &&
> +		test_cmp ../expect.with.ignored ../actual.full
> +	)
> +'
> +
>  test_expect_success 'inside git repository but with --no-index' '
>  	rm -fr is &&
>  	mkdir -p is/git/sub &&
