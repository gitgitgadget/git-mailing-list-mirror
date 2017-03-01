Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417F72023D
	for <e@80x24.org>; Wed,  1 Mar 2017 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdCAV1c (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:27:32 -0500
Received: from avasout06.plus.net ([212.159.14.18]:56778 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdCAV12 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:27:28 -0500
Received: from deneb ([80.229.24.9])
        by avasout06 with smtp
        id qlRb1u0050BmcFC01lRc4Y; Wed, 01 Mar 2017 21:25:37 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QoEu5R6d c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=8nJEP1OIZ-IA:10 a=6Iz7jQTuP9IA:10 a=ybZZDoGAAAAA:8 a=-An2I_7KAAAA:8
 a=wmnbft_4lGLkaVGkuHcA:9 a=lyE_nechrQ3hpRQK:21 a=mBN3KicHK-o-r8ab:21
 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=Sq34B_EcNBM9_nrAYB9S:22
Received: from mac by deneb with local (Exim 4.84_2)
        (envelope-from <mac@mcrowe.com>)
        id 1cjBkd-0004Lg-KH; Wed, 01 Mar 2017 21:25:35 +0000
Date:   Wed, 1 Mar 2017 21:25:35 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
Message-ID: <20170301212535.GA6878@mcrowe.com>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170301170444.14274-1-tboegi@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 01 March 2017 at 18:04:44 +0100, tboegi@web.de wrote:
> From: Junio C Hamano <gitster@pobox.com>
> 
> git diff --quiet may take a short-cut to see if a file is changed
> in the working tree:
> Whenever the file size differs from what is recorded in the index,
> the file is assumed to be changed and git diff --quiet returns
> exit with code 1
> 
> This shortcut must be suppressed whenever the line endings are converted
> or a filter is in use.
> The attributes say "* text=auto" and a file has
> "Hello\nWorld\n" in the index with a length of 12.
> The file in the working tree has "Hello\r\nWorld\r\n" with a length of 14.
> (Or even "Hello\r\nWorld\n").
> In this case "git add" will not do any changes to the index, and
> "git diff -quiet" should exit 0.
> 
> Add calls to would_convert_to_git() before blindly saying that a different
> size means different content.
> 
> Reported-By: Mike Crowe <mac@mcrowe.com>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
> This is what I can come up with, collecting all the loose ends.
> I'm not sure if Mike wan't to have the Reported-By with a
> Signed-off-by ?
> The other question is, if the commit message summarizes the discussion
> well enough ?
> 
> diff.c                    | 18 ++++++++++++++----
>  t/t0028-diff-converted.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 4 deletions(-)
>  create mode 100755 t/t0028-diff-converted.sh
> 
> diff --git a/diff.c b/diff.c
> index 051761b..c264758 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4921,9 +4921,10 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
>  	 *    differences.
>  	 *
>  	 * 2. At this point, the file is known to be modified,
> -	 *    with the same mode and size, and the object
> -	 *    name of one side is unknown.  Need to inspect
> -	 *    the identical contents.
> +	 *    with the same mode and size, the object
> +	 *    name of one side is unknown, or size comparison
> +	 *    cannot be depended upon.  Need to inspect the
> +	 *    contents.
>  	 */
>  	if (!DIFF_FILE_VALID(p->one) || /* (1) */
>  	    !DIFF_FILE_VALID(p->two) ||
> @@ -4931,7 +4932,16 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
>  	    (p->one->mode != p->two->mode) ||
>  	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
>  	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
> -	    (p->one->size != p->two->size) ||
> +
> +	    /*
> +	     * only if eol and other conversions are not involved,
> +	     * we can say that two contents of different sizes
> +	     * cannot be the same without checking their contents.
> +	     */
> +	    (!would_convert_to_git(p->one->path) &&
> +	     !would_convert_to_git(p->two->path) &&
> +	     (p->one->size != p->two->size)) ||
> +
>  	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
>  		p->skip_stat_unmatch_result = 1;
>  	return p->skip_stat_unmatch_result;
> diff --git a/t/t0028-diff-converted.sh b/t/t0028-diff-converted.sh
> new file mode 100755
> index 0000000..3d5ab95
> --- /dev/null
> +++ b/t/t0028-diff-converted.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2017 Mike Crowe
> +#
> +# These tests ensure that files changing line endings in the presence
> +# of .gitattributes to indicate that line endings should be ignored
> +# don't cause 'git diff' or 'git diff --quiet' to think that they have
> +# been changed.
> +
> +test_description='git diff with files that require CRLF conversion'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	echo "* text=auto" >.gitattributes &&
> +	printf "Hello\r\nWorld\r\n" >crlf.txt &&
> +	git add .gitattributes crlf.txt &&
> +	git commit -m "initial"
> +'
> +
> +test_expect_success 'quiet diff works on file with line-ending change that has no effect on repository' '
> +	printf "Hello\r\nWorld\n" >crlf.txt &&
> +	git status &&
> +	git diff --quiet
> +'
> +
> +test_done

Hi Torsten,

Thanks for investigating this.

I think that you've simplified the test to the point where it doesn't
entirely prove the fix. Although you test the case where the file has
changed size, you don't test the case where it hasn't.

Unfortunately that was the part of my test that could only reproduce the
problem with the sleeps. Maybe someone who understands how the cache works
fully could explain an alternative way to force the cache not to be used.

Also, I think I've found a behaviour change with this fix. Consider:

 echo "* text=auto" >.gitattributes
 printf "Hello\r\nWorld\r\n" >crlf.txt
 git add .gitattributes crlf.txt
 git commit -m "initial"

 printf "\r\n" >>crlf.txt

With the above patch, both "git diff" and "git diff --quiet" report that
there are no changes. Previously Git would report the extra newline
correctly.

Mike.
