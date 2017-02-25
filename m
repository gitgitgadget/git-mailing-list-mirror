Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1839201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 15:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdBYPce (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 10:32:34 -0500
Received: from avasout06.plus.net ([212.159.14.18]:54744 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdBYPce (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 10:32:34 -0500
Received: from deneb ([80.229.24.9])
        by avasout06 with smtp
        id p3YW1u0030BmcFC013YXu9; Sat, 25 Feb 2017 15:32:32 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QoEu5R6d c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=kj9zAlcOel0A:10 a=n2v9WMKugxEA:10 a=7Vg1xjiWCS8XCm36e8cA:9 a=CjuIK1q_8ugA:10
Received: from mac by deneb with local (Exim 4.84_2)
        (envelope-from <mac@mcrowe.com>)
        id 1cheKk-0002Kr-DT; Sat, 25 Feb 2017 15:32:30 +0000
Date:   Sat, 25 Feb 2017 15:32:30 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff --quiet exits with 1 on clean tree with CRLF conversions
Message-ID: <20170225153230.GA30565@mcrowe.com>
References: <20170217212633.GA24937@mcrowe.com>
 <xmqqr32wqxr6.fsf@gitster.mtv.corp.google.com>
 <20170217221958.GA12163@mcrowe.com>
 <20170220153322.GA8352@mcrowe.com>
 <xmqqlgt0imhe.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgt0imhe.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 20 February 2017 at 13:25:01 -0800, Junio C Hamano wrote:
> This almost makes me suspect that the place that checks lengths of
> one and two in order to refrain from running more expensive content
> comparison you found earlier need to ask would_convert_to_git()
> before taking the short-cut, something along the lines of this (for
> illustration purposes only, not even compile-tested).  The "almost"
> comes to me because I do not offhand know the performance implications
> of making calls to would_convert_to_git() here.
> 
>  diff.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 051761be40..094d5913da 100644
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
> 
> 

Thanks for investigating this. I think you are correct that I was misguided
in my previous "fix". However, your change above does fix the problem for
me.

It looks like the main cost of convert_to_git is in convert_attrs which
ends up doing various path operations in attr.c. After that, both
apply_filter and crlf_to_git return straight away if there's nothing to do.

I experimented several times with running "git diff -quiet" after touching
every file in Git's own worktree and any difference in total time was lost
in the noise.

I've further improved my test case. Tests 3 and 4 fail without the above
change but pass with it. Unfortunately I'm still unable to get those tests
to fail without the above fix unless the sleeps are present. I've tried
using the "touch -r .datetime" technique from racy-git.txt but it doesn't
help. It seems that I'm unable to stop Git from using its cache without
sleeping. :(

diff --git a/t/t4063-diff-converted.sh b/t/t4063-diff-converted.sh
new file mode 100755
index 0000000..31a730d
--- /dev/null
+++ b/t/t4063-diff-converted.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+#
+# Copyright (c) 2017 Mike Crowe
+#
+# These tests ensure that files changing line endings in the presence
+# of .gitattributes to indicate that line endings should be ignored
+# don't cause 'git diff' or 'git diff --quiet' to think that they have
+# been changed.
+#
+# The sleeps are necessary to reproduce the problem for reasons that I
+# don't understand.
+
+test_description='git diff with files that require CRLF conversion'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo "* text=auto" > .gitattributes &&
+	printf "Hello\r\nWorld\r\n" > crlf.txt &&
+	printf "Hello\nWorld\n" > lf.txt &&
+	git add .gitattributes crlf.txt lf.txt &&
+	git commit -m "initial" && echo three
+'
+test_expect_success 'noisy diff works on file that requires CRLF conversion' '
+	git status >/dev/null &&
+	git diff >/dev/null &&
+	sleep 1 &&
+	touch crlf.txt lf.txt &&
+	git diff >/dev/null
+'
+test_expect_success 'quiet diff works on file that requires CRLF conversion with no changes' '
+	git status &&
+	git diff --quiet &&
+	sleep 1 &&
+	touch crlf.txt lf.txt &&
+	git diff --quiet
+'
+
+test_expect_success 'quiet diff works on file with line-ending change that has no effect on repository' '
+	printf "Hello\nWorld\n" > crlf.txt &&
+	printf "Hello\r\nWorld\r\n" > lf.txt &&
+	git diff --quiet
+'
+test_done


Mike.
