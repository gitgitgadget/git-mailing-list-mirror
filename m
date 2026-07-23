Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA73CE4A3
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798261; cv=none; b=iYeaf7qygfI9fy4xMIN/qIeOFy+ff+dFKkb84KTrjW11SJaOW20X+Ej8ET/9GGkJTWY0/3HGVdHSGwaP7t56Zcvqk7AKEA9t0r3Lt4jERXP1ypUTthbXoXYMHcILHo2ZcQopDiW8bJXpCA6fK193s00T0VyBFxdhAV0FquQ/Wnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798261; c=relaxed/simple;
	bh=QQsqxonltSc4EoH9fcFdj5MDSb1nruH312pWlbf6Qws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzOjDLatSuZFDKeBmy6fFPP6l7R188OkhlXONdZFFl95Vm9DH3zntgOcPyQ/mxkoXtsXyJ8g8yxFze2i4jCDEsiXVTqt4frgleVbg8QyNUaIGo4BI68HXLVlG0sraQhxx/gODKue9/yJGznHClXIyJCfvH3k+JQDzPDWv7mxqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (213-147-165-249.nat.highway.webapn.at [213.147.165.249])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4h5QWF2sp0zRnPp;
	Thu, 23 Jul 2026 11:17:29 +0200 (CEST)
Message-ID: <faa22968-54ac-4e4f-8324-3326ffb00c5b@kdbg.org>
Date: Thu, 23 Jul 2026 11:17:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] bisect: add --reset-when-found to leave when done
Content-Language: en-US
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
 <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
 <542f4b2c8065818b887437add90130d2090fa0f2.1784538619.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <542f4b2c8065818b887437add90130d2090fa0f2.1784538619.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.07.26 um 11:10 schrieb Harald Nordgren via GitGitGadget:
> @@ -784,6 +859,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
>  			break;
>  		}
>  	}
> +	if (reset_when_found != RESET_WHEN_FOUND_NONE && no_checkout) {
> +		res = error(_("'--reset-when-found' cannot be used with '--no-checkout'"));

We have a boilerplate text for this kind of error that saves a translation:

		res = error(_("options '%s' and '%s' cannot be used together"),
"--reset-when-found", "--no-checkout");

> +		goto finish;
> +	}
>  	pathspec_pos = i;
>  
>  	/*

> @@ -1246,6 +1331,23 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  	if (bisect_next_check(terms, NULL))
>  		return BISECT_FAILED;
>  
> +	if (argc && !strcmp(argv[0], "--reset-when-found"))
> +		reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
> +	else if (argc && skip_prefix(argv[0], "--reset-when-found=",
> +				    &reset_when_found_arg)) {
> +		if (parse_reset_when_found(reset_when_found_arg, &reset_when_found))
> +			return BISECT_FAILED;
> +	}
> +
> +	if (reset_when_found != RESET_WHEN_FOUND_NONE) {
> +		if (refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
> +			return error(_("'--reset-when-found' cannot be used with '--no-checkout'"));

Ditto.

> +		write_file(git_path_bisect_reset_when_found(), "%s\n",
> +			   reset_when_found_mode_name(reset_when_found));
> +		argc--;
> +		argv++;
> +	}
> +
>  	if (!argc) {
>  		error(_("bisect run failed: no command provided."));
>  		return BISECT_FAILED;

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 081116220a..7dfb871ab9 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -43,6 +43,38 @@ test_bisect_usage () {
>  	test_cmp expect actual
>  }
>  
> +test_bisect_state_file () {
> +	test_path_is_file "$(git rev-parse --git-path "$1")"
> +}
> +
> +test_bisect_state_missing () {
> +	test_path_is_missing "$(git rev-parse --git-path "$1")"
> +}

These should not use `git` in a $( ) subshell to avoid a case of "ignore
failure in upstream of pipe". Note that

	local file=$(git rev-parse ...) &&
	test_path...

would be wrong, too, for the same reason. But

	local file
	file=$(git rev-parse ...) &&
	test_path...

works as desired.

> +test_expect_success '"git bisect start --reset-when-found" defaults to original' '
> +	test_when_finished "git bisect reset; git checkout main" &&

Looking at other cases where more than one git command is invoked by
test_when_finished, it seems that they are chained with '&&'. `git grepc
"&& git checkout main"` does find a few hits.

> +	git checkout main &&
> +	bisect_start_and_finish --reset-when-found &&
> +	test "$HASH4" = "$(git rev-parse HEAD)" &&
> +	test main = "$(git branch --show-current)" &&
> +	test_bisect_state_missing BISECT_START &&
> +
> +	bisect_start_and_finish --reset-when-found=original &&
> +	test "$HASH4" = "$(git rev-parse HEAD)" &&
> +	test main = "$(git branch --show-current)" &&
> +	test_bisect_state_missing BISECT_START
> +'

More cases of `git` in a subshell above and below. I notice that you are
mimicking existing practice in this file. I'm torn whether to change
this or not. After all, there are also a lot of cases in the file that
uses the correct pattern where the subshell is in a variable assignment.

> +
> +test_expect_success '"git bisect start --reset-when-found=found" leaves first bad checked out' '
> +	test_when_finished "git bisect reset; git checkout main" &&
> +	bisect_start_and_finish --reset-when-found=found &&
> +	test "$HASH3" = "$(git rev-parse HEAD)" &&
> +	test_bisect_state_missing BISECT_START
> +'
> +
> +test_expect_success '"git bisect run --reset-when-found" defaults to original' '
> +	test_when_finished "git bisect reset; git checkout main" &&
> +	bisect_run_reset_when_found --reset-when-found &&
> +	test "$HASH4" = "$(git rev-parse HEAD)" &&
> +	test main = "$(git branch --show-current)" &&
> +	test_bisect_state_missing BISECT_START
> +'
> +
> +test_expect_success '"git bisect run --reset-when-found=found" leaves first bad checked out' '
> +	test_when_finished "git bisect reset; git checkout main" &&
> +	bisect_run_reset_when_found --reset-when-found=found &&
> +	test "$HASH3" = "$(git rev-parse HEAD)" &&
> +	test_bisect_state_missing BISECT_START
> +'
-- Hannes

