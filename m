Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328D3203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 20:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756877AbcKKUpa (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:45:30 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:56648 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756146AbcKKUp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:45:28 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tFsNK2RB4z5tlF;
        Fri, 11 Nov 2016 21:44:33 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6EA73145;
        Fri, 11 Nov 2016 21:44:32 +0100 (CET)
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
To:     Lars Schneider <larsxschneider@gmail.com>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
 <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611111711210.3746@virtualbox>
 <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com>
 <89DB812E-EC29-4D12-97EA-6E8FF6F86FE5@gmail.com>
 <C3840B91-58E2-4563-9597-5EE514D97CC1@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e0785e35-b43d-37ed-598d-b458daf3c355@kdbg.org>
Date:   Fri, 11 Nov 2016 21:44:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <C3840B91-58E2-4563-9597-5EE514D97CC1@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.11.2016 um 18:38 schrieb Lars Schneider:
>> On 11 Nov 2016, at 18:31, Lars Schneider <larsxschneider@gmail.com> wrote:
>>> On 11 Nov 2016, at 18:05, Lars Schneider <larsxschneider@gmail.com> wrote:
>>> @Dscho:
>>> There is still one remaining new issue with t0021 ... investigating!
>>
>> "17 - required process filter should be used only for "clean" operation only"
>> seems flaky.
>>
>> I don't have any more time today but I will look into it tomorrow.

Good to know that I am not alone. This one fails consistently for me. I 
dug into it a bit today, but it drives me mad. Process Monitor reports 
that the redirected-to file (git-stderr.log) gets marked as "Delete 
pending" by git.exe, but I have absolutely no clue where this is coming 
from. Git.exe has no business fuzzing with the file; it just has to 
write() something into it, if at all. When 'git checkout' ends, the file 
is closed, and removed due to the "Delete pending" mark. At the same 
time, git.exe finishes with non-zero exit code. For whatever reason.

> FWIW: This patch (which would be the right thing to do anyways) seems to fix
> the flakyness but I can't be sure ... it needs to run longer...
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 9ff5027..107766b 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -29,8 +29,7 @@ file_size () {
>
>  filter_git () {
>  	rm -f rot13-filter.log &&
> -	git "$@" 2>git-stderr.log &&
> -	rm -f git-stderr.log
> +	git "$@" 2>/dev/null

If I remove the redirection altogether, the test passes for me 
consistently. The redirection isn't necessary anyway, it looks like a 
debugging left-over.

>  }
>
>  # Compare two files and ensure that `clean` and `smudge` respectively are
>
>

-- Hannes

