Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29FEF2018E
	for <e@80x24.org>; Sat, 13 Aug 2016 16:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbcHMQuZ (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 12:50:25 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:56889 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695AbcHMQuY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 12:50:24 -0400
Received: from [192.168.1.100] (213162068183.public.t-mobile.at [213.162.68.183])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sBSRc6yJ7z5tlD;
	Sat, 13 Aug 2016 18:50:20 +0200 (CEST)
Subject: Re: [PATCH v1 1/2] t0027: Correct raciness in NNO test
To:	tboegi@web.de
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
 <1471020662-20746-1-git-send-email-tboegi@web.de>
Cc:	git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <57AF4FCB.7090409@kdbg.org>
Date:	Sat, 13 Aug 2016 18:50:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1471020662-20746-1-git-send-email-tboegi@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 12.08.2016 um 18:51 schrieb tboegi@web.de:
> From: Torsten Bögershausen <tboegi@web.de>
>
> When a non-reversible CRLF conversion is done in "git add",
> a warning is printed on stderr (or Git dies, depending on checksafe)
>
> The function commit_chk_wrnNNO() in t0027 was written to test this,
> but did the wrong thing: Instead of looking at the warning
> from "git add", it looked at the warning from "git commit".
>
> This is racy because "git commit" may not have to do CRLF conversion
> at all if it can use the sha1 value from the index (which depends on
> whether "add" and "commit" run in a single second).
>
> Correct this and replace the commit for each and every file with a commit
> of all files in one go.

The new test code does not only fix the race condition, but also tests 
different things, or prepares test cases in a different manner. I would 
have appreciated an explanation why this is necessary. Is it "on my 
machine, the race condition was triggered consistently for a bunch of 
tests, and so I recorded the wrong expected output in the test cases"?

>
> The function commit_chk_wrnNNO() will to be renamed in a separate commit.
> Thanks to Jeff King <peff@peff.net> for analyzing t0027.
>
> Reported-By: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>   t/t0027-auto-crlf.sh | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 2860d2d..ab6e962 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -119,8 +119,7 @@ commit_chk_wrnNNO () {
>   		fname=${pfx}_$f.txt &&
>   		cp $f $fname &&
>   		printf Z >>"$fname" &&
> -		git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
> -		git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1
> +		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
>   	done
>
>   	test_expect_success "commit NNO files crlf=$crlf attr=$attr LF" '
> @@ -394,11 +393,11 @@ test_expect_success 'commit files attr=crlf' '
>
>   #                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
>   commit_chk_wrnNNO ""      ""      false   ""        ""        ""          ""          ""
> -commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""          ""          ""
> +commit_chk_wrnNNO ""      ""      true    ""        ""        ""          ""          ""
>   commit_chk_wrnNNO ""      ""      input   ""        ""        ""          ""          ""
>
> -commit_chk_wrnNNO "auto"  ""      false   "$WILC"   ""        ""          ""          ""
> -commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""          ""          ""
> +commit_chk_wrnNNO "auto"  ""      false   ""        ""        ""          ""          ""
> +commit_chk_wrnNNO "auto"  ""      true    ""        ""        ""          ""          ""
>   commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""          ""          ""
>   for crlf in true false input
>   do
> @@ -408,7 +407,7 @@ do
>   	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF      ""         CRLF_LF
>   	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
>   	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""          ""          ""
> -	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        ""          ""          ""
> +	commit_chk_wrnNNO auto  crlf  	$crlf   ""        ""        ""          ""          ""
>   	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF     ""          CRLF_LF
>   	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
>   done
> @@ -417,7 +416,8 @@ commit_chk_wrnNNO "text"  ""      false   "$WILC"   "$WICL"   "$WAMIX"    "$WILC
>   commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        LF_CRLF     LF_CRLF     ""
>   commit_chk_wrnNNO "text"  ""      input   ""        CRLF_LF   CRLF_LF     ""          CRLF_LF
>
> -test_expect_success 'create files cleanup' '
> +test_expect_success 'commit NNO and cleanup' '
> +	git commit -m "commit files on top of NNO" &&
>   	rm -f *.txt &&
>   	git -c core.autocrlf=false reset --hard
>   '
>

