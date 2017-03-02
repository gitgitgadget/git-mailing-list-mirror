Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885EB1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 14:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbdCBOX3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 09:23:29 -0500
Received: from avasout05.plus.net ([84.93.230.250]:55645 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbdCBOWi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 09:22:38 -0500
Received: from deneb ([80.229.24.9])
        by avasout05 with smtp
        id r2Lx1u0010BmcFC012Lyr8; Thu, 02 Mar 2017 14:20:58 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Hr8GIwbS c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=8nJEP1OIZ-IA:10 a=6Iz7jQTuP9IA:10 a=-An2I_7KAAAA:8 a=ybZZDoGAAAAA:8
 a=iRSbcqModfqNRAH3IDwA:9 a=wPNLvfGTeEIA:10 a=Sq34B_EcNBM9_nrAYB9S:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
Received: from mac by deneb with local (Exim 4.84_2)
        (envelope-from <mac@mcrowe.com>)
        id 1cjRbE-00041c-Oa; Thu, 02 Mar 2017 14:20:56 +0000
Date:   Thu, 2 Mar 2017 14:20:56 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tboegi@web.de, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
Message-ID: <20170302142056.GB7821@mcrowe.com>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de>
 <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
 <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 01 March 2017 at 13:54:26 -0800, Junio C Hamano wrote:
> Now I thought about it through a bit more thoroughly, I think this
> is the right approach, so here is my (tenative) final version.
> 
> I seem to be getty really rusty---after all the codepaths involved
> are practically all my code and I should have noticed the real
> culprit during my first attempt X-<.
> 
> Thanks for helping.
> 
> -- >8 --
> Subject: [PATCH] diff: do not short-cut CHECK_SIZE_ONLY check in diff_populate_filespec()
> 
> Callers of diff_populate_filespec() can choose to ask only for the
> size of the blob without grabbing the blob data, and the function,
> after running lstat() when the filespec points at a working tree
> file, returns by copying the value in size field of the stat
> structure into the size field of the filespec when this is the case.
> 
> However, this short-cut cannot be taken if the contents from the
> path needs to go through convert_to_git(), whose resulting real blob
> data may be different from what is in the working tree file.
> 
> As "git diff --quiet" compares the .size fields of filespec
> structures to skip content comparison, this bug manifests as a
> false "there are differences" for a file that needs eol conversion,
> for example.
> 
> Reported-by: Mike Crowe <mac@mcrowe.com>
> Helped-by: Torsten Bögershausen <tboegi@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c                    | 19 ++++++++++++++++++-
>  t/t0028-diff-converted.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100755 t/t0028-diff-converted.sh
> 
> diff --git a/diff.c b/diff.c
> index 8c78fce49d..dc51dceb44 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2792,8 +2792,25 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  			s->should_free = 1;
>  			return 0;
>  		}
> -		if (size_only)
> +
> +		/*
> +		 * Even if the caller would be happy with getting
> +		 * only the size, we cannot return early at this
> +		 * point if the path requires us to run the content
> +		 * conversion.
> +		 */
> +		if (!would_convert_to_git(s->path) && size_only)
>  			return 0;
> +
> +		/*
> +		 * Note: this check uses xsize_t(st.st_size) that may
> +		 * not be the true size of the blob after it goes
> +		 * through convert_to_git().  This may not strictly be
> +		 * correct, but the whole point of big_file_threashold
> +		 * and is_binary check being that we want to avoid
> +		 * opening the file and inspecting the contents, this
> +		 * is probably fine.
> +		 */
>  		if ((flags & CHECK_BINARY) &&
>  		    s->size > big_file_threshold && s->is_binary == -1) {
>  			s->is_binary = 1;

This patch solves the problem for me. Including my tests where the file
size doesn't change but the file has been touched. It also doesn't have the
side effect of failing to report the extra trailing newline that the
original fix suffered from.

All the solutions presented so far do cause a small change in behaviour
when using git diff --quiet: they may now cause warning messages like:

 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.

to be emitted (unless of course core.safecrlf=false.) I think this is an
unavoidable side-effect of doing the job properly but it might be worth
mentioning.

> diff --git a/t/t0028-diff-converted.sh b/t/t0028-diff-converted.sh
> new file mode 100755
> index 0000000000..3d5ab9565b
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

As I said before, this doesn't actually test the case when the file sizes
match. However, given the way that the code has changed the actual file
sizes are not compared, so perhaps this doesn't matter.

Thanks for all your help investigating this.

Mike.
