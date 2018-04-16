Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948201F404
	for <e@80x24.org>; Mon, 16 Apr 2018 16:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbeDPQZn (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 12:25:43 -0400
Received: from avasout01.plus.net ([84.93.230.227]:33457 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeDPQZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 12:25:42 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 86wlfr5KUAMPh86wnfNJos; Mon, 16 Apr 2018 17:25:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=dMGIZtRb c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=PRC5cE5RpkGDaY7hVdEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 3/6] generate-cmdlist.sh: keep all information in
 common-cmds.h
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180326165520.802-1-pclouds@gmail.com>
 <20180415164238.9107-1-pclouds@gmail.com>
 <20180415164238.9107-4-pclouds@gmail.com>
 <CAM0VKjkns+AsVyMSe2fxzT8a8oqYdNX3qO8mnw2juOgFC7LHYA@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9f5d2533-1012-aaf6-2703-88525236800f@ramsayjones.plus.com>
Date:   Mon, 16 Apr 2018 17:25:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKjkns+AsVyMSe2fxzT8a8oqYdNX3qO8mnw2juOgFC7LHYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfN/x81Dd2pRR0LBNlJIhHO6322M8BJlDirAvW0tk0AlaaWaCRZpVF+vgwxHU6M3NkUtIo+C22YoU9neIj8D02ZCuDHBUuDkKbhAe5+qOaqO1Pced6ttQ
 P1ugNSg1ykBF3U9Ehysuwn52V/O4D0o53LS7HoF7CDWO/J4HOzDS48kI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/04/18 16:43, SZEDER Gábor wrote:
> On Sun, Apr 15, 2018 at 6:42 PM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> common-cmds.h is used to extract the list of common commands (by
>> group) and a one-line summary of each command. Some information is
>> dropped, for example command category or summary of other commands.
>> Update generate-cmdlist.sh to keep all the information. The extra info
>> will be used shortly.
>>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  generate-cmdlist.sh | 61 +++++++++++++++++++++++++++++++++------------
>>  help.c              | 42 ++++++++++++++++++++++++++-----
>>  2 files changed, 81 insertions(+), 22 deletions(-)
>>
>> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
>> index eeea4b67ea..e0893e979a 100755
>> --- a/generate-cmdlist.sh
>> +++ b/generate-cmdlist.sh
> 
>> -printf 'static struct cmdname_help common_cmds[] = {\n'
>> -grep -f "$match" "$1" |
>> -sed 's/^git-//' |
>> +printf 'static struct cmdname_help command_list[] = {\n'
>> +command_list "$1" |
>>  sort |
>> -while read cmd tags
>> +while read cmd category tags
>>  do
>> -       tag=$(echo "$tags" | sed "$substnum; s/[^0-9]//g")
>> +       name=${cmd/git-}
> 
> There are two issues with this line:
> 
> - This is a "regular" shell script, therefore it must not use pattern
>   substitution.
> 
> - The pattern substitution would remove the string "git-" in the middle of
>   the variable as well; I suspect this is undesired.
> 
> I think that the remove matching prefix pattern substitution should be
> used here.


This also, apparently, doesn't work with dash. On cygwin, which has
bash as /bin/sh, this builds common-cmds.h just fine. On linux, which
has dash as /bin/sh, this fails, leaving a truncated file:

  $ bash generate-cmdlist.sh command-list.txt >zzz
  $ tail -3 zzz
  	{"gitweb", N_("Git web interface (web frontend to Git repositories)"), CAT_ancillaryinterrogators, GROUP_NONE },
  	{"workflows", N_("An overview of recommended workflows with Git"), CAT_guide, GROUP_NONE },
  };

  $ dash generate-cmdlist.sh command-list.txt >zzz
  generate-cmdlist.sh: 73: generate-cmdlist.sh: Bad substitution
  $ tail -3 zzz

  static struct cmdname_help command_list[] = {
  };
  $ 

This leads to a very broken 'git help'.

ATB,
Ramsay Jones


