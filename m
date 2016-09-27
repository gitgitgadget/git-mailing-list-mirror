Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3946F20986
	for <e@80x24.org>; Tue, 27 Sep 2016 18:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755702AbcI0S3v (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:29:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56424 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751496AbcI0S3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:29:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB87B4041C;
        Tue, 27 Sep 2016 14:29:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wl3NDSQ9NDrrUPA7JNqt2bng0u4=; b=A/B6YT
        tAblkgxvjxODDyFhgI0cbndcjUNt9VteUdhAFekGg4PjqQ4/Tr4X7QPl5yeERJKU
        TqS7EYMHTA8c1CQr+rax2NXfcM2vTBv8INwMRyMQWhA3jt/Uiw2fTOTFc8amp8sY
        BigSSerfkEoVHgTrdopVpaVRSE0O9AHw9oL/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I+Q0JQI0CYjZTrPR9RWVTGp4HFi8v76k
        Hz560k7p1mLdhAily8PwK+Ysn5xsbTJKMkYOZkUpvgLdzYf633hoG4ogaQ1wmKju
        6bEK5oYazKsTjKSxQiqqHG5NCJ79V1BUOizmElvbi4qqGJy3ENv729Fp34C4v4Bx
        C5wX6fHHyCQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A456A4041B;
        Tue, 27 Sep 2016 14:29:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BCA64041A;
        Tue, 27 Sep 2016 14:29:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4 v4] ls-files: optionally recurse into submodules
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-3-git-send-email-bmwill@google.com>
Date:   Tue, 27 Sep 2016 11:29:46 -0700
In-Reply-To: <1474930003-83750-3-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 26 Sep 2016 15:46:41 -0700")
Message-ID: <xmqqlgydnqlh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EF3272A-84E0-11E6-B6B4-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Allow ls-files to recognize submodules in order to retrieve a list of
> files from a repository's submodules.  This is done by forking off a
> process to recursively call ls-files on all submodules. Use top-level
> --submodule_prefix option to pass a path to the submodule which it can
> use to prepend to output or pathspec matching logic.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/git-ls-files.txt         |   7 +-
>  builtin/ls-files.c                     | 143 ++++++++++++++++++++++++---------
>  git.c                                  |   2 +-
>  t/t3007-ls-files-recurse-submodules.sh | 100 +++++++++++++++++++++++
>  4 files changed, 212 insertions(+), 40 deletions(-)
>  create mode 100755 t/t3007-ls-files-recurse-submodules.sh
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 0d933ac..446209e 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -18,7 +18,8 @@ SYNOPSIS
>  		[--exclude-per-directory=<file>]
>  		[--exclude-standard]
>  		[--error-unmatch] [--with-tree=<tree-ish>]
> -		[--full-name] [--abbrev] [--] [<file>...]
> +		[--full-name] [--recurse-submodules]
> +		[--abbrev] [--] [<file>...]
>  
>  DESCRIPTION
>  -----------
> @@ -137,6 +138,10 @@ a space) at the start of each line:
>  	option forces paths to be output relative to the project
>  	top directory.
>  
> +--recurse-submodules::
> +	Recursively calls ls-files on each submodule in the repository.
> +	Currently there is only support for the --cached mode.
> +
>  --abbrev[=<n>]::
>  	Instead of showing the full 40-byte hexadecimal object
>  	lines, show only a partial prefix.
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 00ea91a..d4bfc60 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -14,6 +14,7 @@
>  #include "resolve-undo.h"
>  #include "string-list.h"
>  #include "pathspec.h"
> +#include "run-command.h"
>  
>  static int abbrev;
>  static int show_deleted;
> @@ -28,6 +29,8 @@ static int show_valid_bit;
>  static int line_terminator = '\n';
>  static int debug_mode;
>  static int show_eol;
> +static int recurse_submodules;
> +static const char *submodule_prefix;

I would have expected this to added to environment.c in the previous
step, but it is OK--I'd imagine you'd grab this from the environment
and carrying a piece of information from git.c to here by setenv()
followed by getenv() feels somewhat roundabout, though.

>  static const char *prefix;
>  static int max_prefix_len;
> @@ -68,6 +71,21 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
>  static void write_name(const char *name)
>  {
>  	/*
> +	 * NEEDSWORK: To make this thread-safe, full_name would have to be owned
> +	 * by the caller.

As Peff mentioned in his review in another thread, a large number of
functions in git are not reentrant, and I do not think we would want
to give the impression that those missing a warning are safe to use.

Other than that, this step looks OK.  3/4 and later would be a lot
more fun to review ;-)
