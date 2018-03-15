Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C981FAE2
	for <e@80x24.org>; Thu, 15 Mar 2018 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeCOK4C (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 06:56:02 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:59508 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCOK4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 06:56:02 -0400
Received: from [192.168.2.201] ([89.242.187.47])
        by smtp.talktalk.net with SMTP
        id wQXpebaXKwheawQY1en7o7; Thu, 15 Mar 2018 10:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521111360;
        bh=TE3hq8QVMOjEzPMbg8bsJ1JSsBqznjw+XwuOVN0ee0Q=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LqmuZl8/oMfv87VDgryyygTSIadmxNKUdCqBEYl1jLpw0qE0OWnuawTLG/pA8978z
         TFuAGaziWkD6xJBvvjFB+dOkiClNhi9w/81I5knqb+zyd+XekKelxwyrGiyG/5KtDd
         C4nsi0i3pjf/QXYcIqkXLNP1CAYlnxfDsFA3Vj50=
X-Originating-IP: [89.242.187.47]
X-Spam: 0
X-OAuthority: v=2.3 cv=ZJr5Z0zb c=1 sm=1 tr=0 a=xTMdeSjPtcrjTRwaJcecEQ==:117
 a=xTMdeSjPtcrjTRwaJcecEQ==:17 a=IkcTkHD0fZMA:10 a=KWSUIw9p8R2CV9tWRfAA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] rebase: support --signoff with implicit rebase
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20180314111127.14217-1-phillip.wood@talktalk.net>
 <nycvar.QRO.7.76.6.1803151112390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <c9978ac6-ded3-592e-aa49-53172aad75bf@talktalk.net>
Date:   Thu, 15 Mar 2018 10:55:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803151112390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL0ONNgu9X9zHx7GHdZ3d8w4gKSIafPJiPhJSKtt/piErejzs5yDs7OFPe3uSA+/7kEdHSj96eGA1amTPwGdayvMfJeMNWujHAxvjGKbnzD8ex3wFH3o
 gArCa4aMzeboeMt0NaYpfVPbz7BaIHkHzE3JwdqD7MBkY5C4wKIQWEQUv5678hgRLJXjyTLFFXfkhdtZmGJaRdKbMLJJjTUi9NfNM5iVxBhWX2vS2E5D8b+v
 RU2ytjscnlPIQ2Rq3aLg8hJVW8ryVCgus7IcI37XtA4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/03/18 10:18, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 14 Mar 2018, Phillip Wood wrote:
> 
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index b353c33d41..40301756be 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -459,6 +471,18 @@ then
>>  	git_format_patch_opt="$git_format_patch_opt --progress"
>>  fi
>>  
>> +if test -n "$signoff"
>> +then
>> +	test "$interactive_rebase" = explicit &&
>> +		die "$(gettext "error: interactive rebase does not support --signoff")"
>> +	test "$type" = merge &&
>> +		die "$(gettext "error: merge rebase does not support --signoff")"
>> +	test -n "$preserve_merges" &&
>> +		die "$(gettext "error: cannot combine '--signoff' with '--preserve-merges'")"
>> +	git_am_opt="$git_am_opt $signoff"
>> +	force_rebase=t
>> +fi
> 
> I wonder whether we can have this change as a separate commit? Otherwise
> we would lump that change (--interactive --signoff was previously allowed
> but the --signoff was simply ignored) with the other changes...
> 
> As I mentioned in my reply to Junio's comment, it'd be awesome if
> --interactive --signoff was supported (and likewise --merge --signoff),
> but it feels like an undue feature request to be dumped on you, so I'm
> fine with the patch series simply erroring out on those combinations.

I'll have a look, if it's not too much work I'll do that, it would be
nice to have --signoff better supported.

> (I don't care about --preserve-merges anymore, as everybody knows by now.)
> 
> Ciao,
> Dscho
> 

