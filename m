Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD891FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 17:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbcLFRAh (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 12:00:37 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:43376 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbcLFRAg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 12:00:36 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id D420F202AB
        for <git@vger.kernel.org>; Tue,  6 Dec 2016 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1481043635;
        bh=5ieQUlhqK0m4g4A/npRjzQR5KMCmL/7A/tmxTvcok3Q=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=bgt+TIiXunTL8ht2zLSXL3P6nUyA1z2h6Jk23dDc+D7jNVgrVtiI4BP4P6DM/C7gT
         7fSTGwtlhgnqutLEY0v10Fkm1cYa043tbb6XLunljzL5PoycOsEpuLyW9k/zXncDcm
         2kMy9Qk9IFNKNYpbo3ab73Wbv2QrK4BzsjsgXdig=
Received: from [192.168.0.10] (S0106c8fb26402908.ek.shawcable.net [24.66.132.201])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA;
        Tue,  6 Dec 2016 17:00:35 +0000 (UTC)
Subject: Re: [PATCH v4] diff: handle --no-abbrev in no-index case
To:     git@vger.kernel.org
References: <20161206010134.21856-1-jack@nottheoilrig.com>
 <20161206165614.22921-1-jack@nottheoilrig.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   Jack Bates <bk874k@nottheoilrig.com>
Message-ID: <968b011f-c4b6-47af-ca98-8b2eae9a11d0@nottheoilrig.com>
Date:   Tue, 6 Dec 2016 10:00:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161206165614.22921-1-jack@nottheoilrig.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12/16 09:56 AM, Jack Bates wrote:
> There are two different places where the --no-abbrev option is parsed,
> and two different places where SHA-1s are abbreviated. We normally parse
> --no-abbrev with setup_revisions(), but in the no-index case, "git diff"
> calls diff_opt_parse() directly, and diff_opt_parse() didn't handle
> --no-abbrev until now. (It did handle --abbrev, however.) We normally
> abbreviate SHA-1s with find_unique_abbrev(), but commit 4f03666 ("diff:
> handle sha1 abbreviations outside of repository, 2016-10-20) recently
> introduced a special case when you run "git diff" outside of a
> repository.
>
> setup_revisions() does also call diff_opt_parse(), but not for --abbrev
> or --no-abbrev, which it handles itself. setup_revisions() sets
> rev_info->abbrev, and later copies that to diff_options->abbrev. It
> handles --no-abbrev by setting abbrev to zero. (This change doesn't
> touch that.)
>
> Setting abbrev to zero was broken in the outside-of-a-repository special
> case, which until now resulted in a truly zero-length SHA-1, rather than
> taking zero to mean do not abbreviate. The only way to trigger this bug,
> however, was by running "git diff --raw" without either the --abbrev or
> --no-abbrev options, because 1) without --raw it doesn't respect abbrev
> (which is bizarre, but has been that way forever), 2) we silently clamp
> --abbrev=0 to MINIMUM_ABBREV, and 3) --no-abbrev wasn't handled until
> now.
>
> The outside-of-a-repository case is one of three no-index cases. The
> other two are when one of the files you're comparing is outside of the
> repository you're in, and the --no-index option.
>
> Signed-off-by: Jack Bates <jack@nottheoilrig.com>
> ---
>  diff.c                                                  | 6 +++++-
>  t/t4013-diff-various.sh                                 | 7 +++++++
>  t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir  | 3 +++
>  t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir | 3 +++
>  t/t4013/diff.diff_--no-index_--raw_dir2_dir             | 3 +++
>  t/t4013/diff.diff_--raw_--abbrev=4_initial              | 6 ++++++
>  t/t4013/diff.diff_--raw_--no-abbrev_initial             | 6 ++++++
>  t/t4013/diff.diff_--raw_initial                         | 6 ++++++
>  8 files changed, 39 insertions(+), 1 deletion(-)
>  create mode 100644 t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir
>  create mode 100644 t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir
>  create mode 100644 t/t4013/diff.diff_--no-index_--raw_dir2_dir
>  create mode 100644 t/t4013/diff.diff_--raw_--abbrev=4_initial
>  create mode 100644 t/t4013/diff.diff_--raw_--no-abbrev_initial
>  create mode 100644 t/t4013/diff.diff_--raw_initial
>
> diff --git a/diff.c b/diff.c
> index ec87283..84dba60 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3106,7 +3106,8 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
>  			abbrev = FALLBACK_DEFAULT_ABBREV;
>  		if (abbrev > GIT_SHA1_HEXSZ)
>  			die("BUG: oid abbreviation out of range: %d", abbrev);
> -		hex[abbrev] = '\0';
> +		if (abbrev)
> +			hex[abbrev] = '\0';
>  		return hex;
>  	}
>  }
> @@ -3364,6 +3365,7 @@ void diff_setup(struct diff_options *options)
>
>  	options->file = stdout;
>
> +	options->abbrev = DEFAULT_ABBREV;
>  	options->line_termination = '\n';
>  	options->break_opt = -1;
>  	options->rename_limit = -1;
> @@ -4024,6 +4026,8 @@ int diff_opt_parse(struct diff_options *options,
>  			    offending, optarg);
>  		return argcount;
>  	}
> +	else if (!strcmp(arg, "--no-abbrev"))
> +		options->abbrev = 0;
>  	else if (!strcmp(arg, "--abbrev"))
>  		options->abbrev = DEFAULT_ABBREV;
>  	else if (skip_prefix(arg, "--abbrev=", &arg)) {
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 566817e..d09acfe 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -311,6 +311,13 @@ diff --line-prefix=abc master master^ side
>  diff --dirstat master~1 master~2
>  diff --dirstat initial rearrange
>  diff --dirstat-by-file initial rearrange
> +# No-index --abbrev and --no-abbrev

I updated this comment to be consistent with the no-index vs. 
outside-of-a-repository distinction in the commit message.

> +diff --raw initial
> +diff --raw --abbrev=4 initial
> +diff --raw --no-abbrev initial
> +diff --no-index --raw dir2 dir
> +diff --no-index --raw --abbrev=4 dir2 dir
> +diff --no-index --raw --no-abbrev dir2 dir
>  EOF
>
>  test_expect_success 'log -S requires an argument' '
> diff --git a/t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir b/t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir
> new file mode 100644
> index 0000000..a71b38a
> --- /dev/null
> +++ b/t/t4013/diff.diff_--no-index_--raw_--abbrev=4_dir2_dir
> @@ -0,0 +1,3 @@
> +$ git diff --no-index --raw --abbrev=4 dir2 dir
> +:000000 100644 0000... 0000... A	dir/sub
> +$
> diff --git a/t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir b/t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir
> new file mode 100644
> index 0000000..e0f0097
> --- /dev/null
> +++ b/t/t4013/diff.diff_--no-index_--raw_--no-abbrev_dir2_dir
> @@ -0,0 +1,3 @@
> +$ git diff --no-index --raw --no-abbrev dir2 dir
> +:000000 100644 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 A	dir/sub
> +$
> diff --git a/t/t4013/diff.diff_--no-index_--raw_dir2_dir b/t/t4013/diff.diff_--no-index_--raw_dir2_dir
> new file mode 100644
> index 0000000..3cb4ee7
> --- /dev/null
> +++ b/t/t4013/diff.diff_--no-index_--raw_dir2_dir
> @@ -0,0 +1,3 @@
> +$ git diff --no-index --raw dir2 dir
> +:000000 100644 0000000... 0000000... A	dir/sub
> +$
> diff --git a/t/t4013/diff.diff_--raw_--abbrev=4_initial b/t/t4013/diff.diff_--raw_--abbrev=4_initial
> new file mode 100644
> index 0000000..c3641db
> --- /dev/null
> +++ b/t/t4013/diff.diff_--raw_--abbrev=4_initial
> @@ -0,0 +1,6 @@
> +$ git diff --raw --abbrev=4 initial
> +:100644 100644 35d2... 9929... M	dir/sub
> +:100644 100644 01e7... 10a8... M	file0
> +:000000 100644 0000... b1e6... A	file1
> +:100644 000000 01e7... 0000... D	file2
> +$
> diff --git a/t/t4013/diff.diff_--raw_--no-abbrev_initial b/t/t4013/diff.diff_--raw_--no-abbrev_initial
> new file mode 100644
> index 0000000..c87a125
> --- /dev/null
> +++ b/t/t4013/diff.diff_--raw_--no-abbrev_initial
> @@ -0,0 +1,6 @@
> +$ git diff --raw --no-abbrev initial
> +:100644 100644 35d242ba79ae89ac695e26b3d4c27a8e6f028f9e 992913c5aa0a5476d10c49ed0f21fc0c6d1aedf3 M	dir/sub
> +:100644 100644 01e79c32a8c99c557f0757da7cb6d65b3414466d 10a8a9f3657f91a156b9f0184ed79a20adef9f7f M	file0
> +:000000 100644 0000000000000000000000000000000000000000 b1e67221afe8461efd244b487afca22d46b95eb8 A	file1
> +:100644 000000 01e79c32a8c99c557f0757da7cb6d65b3414466d 0000000000000000000000000000000000000000 D	file2
> +$
> diff --git a/t/t4013/diff.diff_--raw_initial b/t/t4013/diff.diff_--raw_initial
> new file mode 100644
> index 0000000..a3e9780
> --- /dev/null
> +++ b/t/t4013/diff.diff_--raw_initial
> @@ -0,0 +1,6 @@
> +$ git diff --raw initial
> +:100644 100644 35d242b... 992913c... M	dir/sub
> +:100644 100644 01e79c3... 10a8a9f... M	file0
> +:000000 100644 0000000... b1e6722... A	file1
> +:100644 000000 01e79c3... 0000000... D	file2
> +$
>
