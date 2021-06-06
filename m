Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B531C4743D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA0461029
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFFTIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 15:08:37 -0400
Received: from elephants.elehost.com ([216.66.27.132]:62490 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFFTIg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 15:08:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 156J6cwQ069558
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 6 Jun 2021 15:06:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>     <YLfc2+Te7Y3UY+Sm@nand.local>   <YLfgy94sbmStC0mR@coredump.intra.peff.net>      <YLfl4jkuwSCiNrrS@nand.local>   <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>      <xmqqk0na2yyc.fsf@gitster.g>    <YLmkI4a4J60KFY2W@coredump.intra.peff.net> <xmqq7dja2oyd.fsf@gitster.g>
In-Reply-To: <xmqq7dja2oyd.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
Date:   Sun, 6 Jun 2021 15:06:31 -0400
Message-ID: <015301d75b07$132a0aa0$397e1fe0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ7fmH3rhE7hkXT/heyzvk47BFclgE1aUB7AUaXbccDGYfiRAHqs6saAd+WcrYCxDKfhgHCGre5qU/FngA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 4, 2021 1:12 AM, Junio C Hamano wrote:
>To: Jeff King <peff@peff.net>
>Cc: Taylor Blau <me@ttaylorr.com>; Randall S. Becker <rsbecker@nexbridge.com>; git@vger.kernel.org
>Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
>
>Jeff King <peff@peff.net> writes:
>
>> One brief aside: I'm still not entirely convinced that NonStop isn't
>> violating POSIX. Yes, as Eric noted, fsync() is allowed to return EINTR.
>> But should it do so when the signal it got was set up with SA_RESTART?
>>
>> The sigaction(3posix) page says:
>>
>>      SA_RESTART   This flag affects the behavior of interruptible functions;
>> 		  that is, those specified to fail with errno set to
>> 		  [EINTR]. If set, and a function specified as
>> 		  interruptible is interrupted by this signal, the
>> 		  function shall restart and shall not fail with [EINTR]
>> 		  unless otherwise specified. [...]
>>
>> and I could not find anywhere that it is "otherwise specified" for
>> fsync(). Of course, whatever POSIX says, if NonStop needs this
>> workaround, we should provide it. But this may explain why we never
>> saw it on other systems.
>
>Yeah, I think all of the above makes sense.
>
>> It also means it's less important for this workaround to kick in
>> everywhere. But given how low-cost it is, I'm just as happy to avoid
>> having a separate knob to enable it.
>
>Yes, any caller who cares about the result of fsync() is willing to wait, and on a well benaved system, we would never see EINTR so
the
>loop won't iterate.  Having to carry just a handful of extra bytes in ICache in a codepath that is not performance critical is
probably an
>acceptable cost for simpler code.

Just something to note: I was running git gc --aggressive on OpenSSL today and got the same error as in this case. I'm assuming that
the fix will apply to that too. In this situation, the gc ran for over 2 hours until failing. This may be a more widely available
test condition for fsync() EINTR, possibly.

-Randall

