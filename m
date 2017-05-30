Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9412027C
	for <e@80x24.org>; Tue, 30 May 2017 20:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751080AbdE3UfF (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 16:35:05 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:17544 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750824AbdE3UfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 16:35:04 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wclj24n6Tz5tl9;
        Tue, 30 May 2017 22:35:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1EADE303E;
        Tue, 30 May 2017 22:35:02 +0200 (CEST)
Subject: Re: [PATCH 1/2] mingw: verify that paths are not mistaken for remote
 nicknames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
 <20170526033510.1793-14-gitster@pobox.com>
 <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
 <CACBZZX5BgVbUFEwQjHqJVfHFUitTJRaCx-Lg+j7q54uErEpqcg@mail.gmail.com>
 <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org>
 <xmqqpoerc5oj.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2899d715-a416-1852-4399-28af0a3e9b6e@kdbg.org>
Date:   Tue, 30 May 2017 22:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqpoerc5oj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.05.2017 um 06:46 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>> Doesn't this need test_i18ngrep?:
>>
>> Good catch! It would be this one in warn_on_inaccessible:
>>
>>>       wrapper.c:581:  warning_errno(_("unable to access '%s'"), path);
>>
>> But actually, I'm more worried about the unholy mix of
>> one-test-first-then-skip_all-later that occurs in this test script (I
>> do not mean the skip_all that is visible in the context, there are
>> others later). I think there was some buzz recently that prove only
>> understands a summary line that reads "1..0", but here we would see
>> "1..1". What to do? Reorganize the test script? Dscho, any ideas?
> 
> For now I've queued this on top of 1/2, so that suggestions are not
> lost, and then tweaked 2/2 (as context for the patch to the test
> changes).
> 
> Either an ack or a reroll is appreciated (I do not think we'd
> terribly mind if this test were added to another script, or if this
> test were skipped when UNC path cannot be determined even though it
> does not need that prereq.  Also UNC_PATH can become prereq that is
> tested by individual test in this script and the new test can be
> added without requiring that prereq).
> 
> Thanks.
> 
>   t/t5580-clone-push-unc.sh | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
> index fd719a209e..944730cddc 100755
> --- a/t/t5580-clone-push-unc.sh
> +++ b/t/t5580-clone-push-unc.sh
> @@ -8,12 +8,6 @@ if ! test_have_prereq MINGW; then
>   	test_done
>   fi
>   
> -test_expect_failure 'remote nick cannot contain backslashes' '
> -	BACKSLASHED="$(pwd | tr / \\\\)" &&
> -	git ls-remote "$BACKSLASHED" >out 2>err &&
> -	! grep "unable to access" err
> -'
> -
>   UNCPATH="$(pwd)"
>   case "$UNCPATH" in
>   [A-Z]:*)
> @@ -51,4 +45,10 @@ test_expect_success push '
>   	test "$rev" = "$(git rev-parse --verify refs/heads/to-push)"
>   '
>   
> +test_expect_failure 'remote nick cannot contain backslashes' '
> +	BACKSLASHED="$(pwd | tr / \\\\)" &&
> +	git ls-remote "$BACKSLASHED" >out 2>err &&
> +	test_i18ngrep ! "unable to access" err
> +'
> +
>   test_done
> 

ACK!

-- Hannes
