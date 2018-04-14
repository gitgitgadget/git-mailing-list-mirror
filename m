Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7BD1F424
	for <e@80x24.org>; Sat, 14 Apr 2018 11:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbeDNLYj (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 07:24:39 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:45726 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeDNLYi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 07:24:38 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Apr 2018 07:24:37 EDT
Received: from barra ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 7JASfnpSQ4Zqz7JASfhwAG; Sat, 14 Apr 2018 12:16:29 +0100
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
 a=sZ37js8MScgkEhjnxmUA:9 a=QEXdDO2ut3YA:10
To:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Sat, 14 Apr 2018 12:15:39 +0100
Subject: Re: Bug: rebase -i creates committer time inversions on 'reword'
Envelope-To: git@vger.kernel.org,johannes.schindelin@gmx.de,j6t@kdbg.org
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
CC:     Git Mailing List <git@vger.kernel.org>
Message-ID: <f56b84fa-9286-3a7b-fc5b-2307c9ff5b5e@philandanna.no-ip.org>
From:   "Phillip Wood" <phil@philandanna.no-ip.org>
Received: from [192.168.2.201] (lindisfarne.local [192.168.2.201])
        by barra; Sat, 14 Apr 2018 12:15:39 +0100
Reply-To: phillip.wood@dunelm.org.uk
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOzFwQfErhViPyna45KDhUmctwn/mVde2nNMqX0I5ooAccIQP9OaU168uKhjpLybOO8Mzu619ZAI7LErRpsPPdpC7EefiAQs4ZY9hcEFD1Wb93kJ5OjH
 SjsPssk8ElNKlqsHsH1R6pA0p+8d987IhUy3QucMl0kVWhLep5uFqgJi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 13/04/18 17:52, Johannes Sixt wrote:
> 
> I just noticed that all commits in a 70-commit branch have the same
> committer timestamp. This is very unusual on Windows, where rebase -i of
> such a long branch takes more than one second (but not more than 3 or
> so thanks to the builtin nature of the command!).
> 
> And, in fact, if you mark some commits with 'reword' to delay the quick
> processing of the patches, then the reworded commits have later time
> stamps, but subsequent not reworded commits receive the earlier time
> stamp. This is clearly not intended.

Oh dear, I think this is probably due to my series making rebase commit
in-process when the commit message isn't being edited. I didn't realize
that git cached the commit date rather than using the current time when
calling commit_tree_extended(). I'll take a look at it next week. I
think 'git am' probably gives all patches the same commit time as well
if the commit date is cached though it wont suffer from the time-travel
problem.

Best Wishes

Phillip

> Perhaps something like this below is needed.
> 
> diff --git a/ident.c b/ident.c
> index 327abe557f..2c6bff7b9d 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -178,8 +178,8 @@ const char *ident_default_email(void)
>  
>  static const char *ident_default_date(void)
>  {
> -	if (!git_default_date.len)
> -		datestamp(&git_default_date);
> +	strbuf_reset(&git_default_date);
> +	datestamp(&git_default_date);
>  	return git_default_date.buf;
>  }
>  
> 

