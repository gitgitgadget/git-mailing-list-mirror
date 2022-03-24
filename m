Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A8C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 19:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352819AbiCXTGo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 24 Mar 2022 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345568AbiCXTGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 15:06:43 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4C344CD
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 12:05:10 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22OJ55Ol007715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Mar 2022 15:05:09 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff Hostetler via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'Bagas Sanjaya'" <bagasdotme@gmail.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Tao Klerks'" <tao@klerks.biz>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>        <c8709da9457eb303132b5cad6a204a1de27aabc0.1648140586.git.gitgitgadget@gmail.com> <xmqqils3gort.fsf@gitster.g>
In-Reply-To: <xmqqils3gort.fsf@gitster.g>
Subject: RE: [PATCH v8 21/30] t7527: create test for fsmonitor--daemon
Date:   Thu, 24 Mar 2022 15:05:00 -0400
Organization: Nexbridge Inc.
Message-ID: <075d01d83fb2$1506ded0$3f149c70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKGzDsbg2lz67pgmA1z2cDpXTOUgQHHL5OMAJXlRvoBuEN8YqtRIDYA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 24, 2022 3:00 PM, Junio C Hamano wrote:
>Subject: Re: [PATCH v8 21/30] t7527: create test for fsmonitor--daemon
>
>"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>I hadn't signed off on this one yet ;-)
>
>> +is_value () {
>> +	test -n "$1" && test "${1::1}" != "-"
>> +}
>
>${var:ofs:len} is a bash-ism.  If you run this test under /bin/dash instead of
>/bin/dash, you'll likely see it fail.
>
>If it were a good idea to see if $1 begins with a dash, a more natural (to shell
>programmers) way to do so is
>
>	case "$1" in -*) false ;; ?*) true ;; *) false ;; esac
>
>but given how this is used below, we do not want to special case dash.
>
>There isn't anything wrong in "mkdir ./-foo && start_daemon -C -foo"
>in other words.
>
>> +start_daemon () {
>> +	r= &&
>> +	tf= &&
>> +	t2= &&
>> +	tk= &&
>
>FYI, you can write these on a single line, i.e.
>
>	r= tf= t2= tk= &&
>
>Spending lines and spaces for the meat of the script would enhance readability but
>for things like a boilerplate "we clear variables before using them", being concise
>may be less distracting.
>
>> +	while test "$#" -ne 0
>> +	do
>> +		case "$1" in
>> +		-C)
>> +			shift;
>> +			is_value $1 || BUG "error: -C requires value"
>> +			r="-C $1"
>> +			shift
>> +			;;
>> +	...
>> +		esac
>> +	done &&
>
>A more natural way to write these loops is
>
>	while ...
>	do
>		case "$1" in
>		-C)
>			r="-C ${2?}"
>			shift
>			;;
>		... all other options you handle ...
>		-*)
>			echo >&2 "unknown option $1"
>			exit 1
>			;;
>		*)
>			break
>			;;
>		esac
>		shift
>	done
>
>i.e. shifting out what we just saw is the default and happens immediately after the
>case/esac, and extra shift after consuming an option parameter happens in each
>case arm.
>
>An acceptable slight variation is
>
>		-C)
>			shift
>			r="-C ${1?}"
>			;;
>
>but the first form is more logical and clear, i.e. "when we see '-C', we want two on
>the command line, -C itself and the parameter it takes"
>is conveyed more strongly with "${2?}" there.
>
>For an additional bonus, we could also accept the stuck form, i.e.
>
>		case "$1" in
>		-C)
>			r="-C ${2?}"
>			shift
>			;;
>		-C*)
>			r="-C {$1#-C}"
>			;;
>		...

May I request a bit of extra time on the -rc0 to -rc1 cycle for this? I have a feeling that while testing this is probably going to go well, I would like to have a bit of extra time for anything that might come up. There are a lot of moving parts to this series. Not being critical, but debugging scripts on my platforms can be a bit rough at times.

Thanks,
Randall

