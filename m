Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F5620A40
	for <e@80x24.org>; Wed, 29 Nov 2017 22:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752157AbdK2WJh (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 17:09:37 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:58822 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbdK2WJg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 17:09:36 -0500
Received: from [192.168.178.21] (x4d071942.dyn.telefonica.de [77.7.25.66])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id DD720140CDD;
        Wed, 29 Nov 2017 23:09:34 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.25.66) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Received-SPF: pass (mxf98a: connection is authenticated)
Subject: Re: [PATCH] git-prompt: fix reading files with windows line endings
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <20171128201818.4132-1-rabel@robertabel.eu>
 <20171128201818.4132-2-rabel@robertabel.eu>
 <alpine.DEB.2.21.1.1711291519290.6482@virtualbox>
From:   Robert Abel <rabel@robertabel.eu>
Message-ID: <d57e4cb9-b0b4-314e-370a-e0db58a2a7da@robertabel.eu>
Date:   Wed, 29 Nov 2017 23:09:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711291519290.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20171129220934.12978.54833@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 29 Nov 2017 15:27, Johannes Schindelin wrote:
>> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
>> index c6cbef38c2..71a64e7959 100644
>> --- a/contrib/completion/git-prompt.sh
>> +++ b/contrib/completion/git-prompt.sh
>> @@ -282,7 +282,7 @@ __git_eread ()
>>  {
>>  	local f="$1"
>>  	shift
>> -	test -r "$f" && read "$@" <"$f"
>> +	test -r "$f" && read "$@" <"$f" && export $@="${!@%$'\r'}"
> 
> As far as I understand, $'\r' is a Bash-only construct, and this file
> (git-prompt.sh) is targeting other Unix shells, too.

Sorry, I wasn't really aware about this bash-ism. I agree that a generic
solution would be best.

> So how about using `tr -d '\r' <"$f" | read "$@"` instead?

That doesn't work for me. Apparently, the variable is always reset to ""
and hence the prompt will always display the shortened sha1.
Maybe it has something to do with variable scoping inside the backtick
evaluation?

> Or maybe keep with the Bash construct, but guarded behind a test that we
> area actually running in Bash? Something like
> 
> 	test -z "$BASH" || IFS=$' \t\r\n'

Actually, this got me thinking and reading the POSIX.1-2008, specifically
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/read.html.

It seems POSIX states that IFS should be supported by read. This means
that it should be okay to just do

> test -r "$f" && IFS=" \t\r\n" read "$@" < "$f"

This would also get rid of the export and avoid introducing backtick
evaluation.

Regards,

Robert
