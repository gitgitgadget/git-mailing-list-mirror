Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127521F667
	for <e@80x24.org>; Sat, 12 Aug 2017 08:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdHLI7g (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 04:59:36 -0400
Received: from e1i188.smtp2go.com ([103.36.108.188]:56349 "EHLO
        e1i188.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdHLI7f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 04:59:35 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Aug 2017 04:59:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtphost.com; s=m1fbw0.a1-4.dyn; h=Feedback-ID:X-Smtpcorp-Track:Date:
        Subject:To:From:Reply-To:Message-ID:Sender:List-Unsubscribe;
        bh=aynmcWTkypGT1LkFiwOUZ3AdQfAB1Tib7ASNogYnhbQ=; b=EZgsg4y/j7CUvcgtWlxqKx9lDU
        L7RE3FVdllimd6lC6ofDu6/q687G1eR6o31WxvKJXUW9g0lLCIQxiJz540FUoQFf/8arUNrfzI53f
        GYwBui/RuWt4JXXvmz9V9C6Kv2iQubQGUVQ3GCmtnXXpGcda6SBYzrsSALDf16ZQqoGJ0tyqBMmUW
        2PlWh7R1H0GaN/KrBgks5LFEonhLtkFZWFB1BYvH83w/ljTJgRneC6PkxpfeSM8FIZYW6+fcZicoZ
        uLE2VdQcK7ALfb05BhE3c68T2nhs5JMkoKgi0cMn3WencW/IlZ/v7cGoP3OHry2kM+9rB+5Xhvu8p
        NjfrITyw==;
Message-ID: <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
Cc:     "Kevin Willford" <kcwillford@gmail.com>, <git@vger.kernel.org>,
        "Kevin Willford" <kewillf@microsoft.com>
References: <20170531150427.7820-1-kewillf@microsoft.com>        <20170810183256.12668-2-kewillf@microsoft.com>        <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net> <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v2 1/2] format-patch: have progress option while generating patches
Date:   Sat, 12 Aug 2017 09:06:18 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1dgS7qr_ZjZvRD.MIFSC0-s5
Feedback-ID: 66524m:66524aMf6O2Y:66524sgKmGmluqH:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse-contact@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Jeff King <peff@peff.net> writes:
>
>> On Thu, Aug 10, 2017 at 02:32:55PM -0400, Kevin Willford wrote:
>>
>>> @@ -1493,6 +1496,8 @@ int cmd_format_patch(int argc, const char **argv, 
>>> const char *prefix)
>>>  OPT_FILENAME(0, "signature-file", &signature_file,
>>>  N_("add a signature from a file")),
>>>  OPT__QUIET(&quiet, N_("don't print the patch filenames")),
>>> + OPT_BOOL(0, "progress", &show_progress,
>>> + N_("show progress while generating patches")),
>>
>> Earlier I suggested allowing --progress="custom text" since this may be
>> driven as plumbing for other commands. But I don't think there's any
>> need to worry about it now. It can be added seamlessly later if we find
>> such a caller.
>>
>>> @@ -1752,8 +1757,12 @@ int cmd_format_patch(int argc, const char **argv, 
>>> const char *prefix)
>>>  start_number--;
>>>  }
>>>  rev.add_signoff = do_signoff;
>>> +
>>> + if (show_progress)
>>> + progress = start_progress_delay(_("Generating patches"), total, 0, 1);
>>
>> I don't really have an opinion on a 1 second delay versus 2. I thought
>> we used 2 pretty consistently, though grepping around I do see a couple
>> of 1's. It probably doesn't matter, but just a curiosity.
>
> Yeah, I also thought 2-second was what we used by default.  Perhaps
> we would want to bring others in line?

<bikeshed> Surely the choice should depend on the purpose of the delay. IIRC 
the 1 second between patches on the formal 'sent' time was simply to ensure 
the patches had the right sequence. Delays for warnings and progress have 
different purposes, so I think it's more about the purpose than 
standardising the time (along with expectations [least surprise] if other 
messages are displayed).
--
Philip 

