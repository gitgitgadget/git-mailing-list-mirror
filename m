Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCBDC433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 00:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354453AbiBLAjM convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 11 Feb 2022 19:39:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354419AbiBLAjM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 19:39:12 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7EED79
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 16:39:09 -0800 (PST)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 21C0d7j0046978
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Feb 2022 19:39:08 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Neeraj Singh'" <nksingh85@gmail.com>
Cc:     "'Neeraj Singh via GitGitGadget'" <gitgitgadget@gmail.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Patrick Steinhardt'" <ps@pks.im>,
        "'Neeraj K. Singh'" <neerajsi@microsoft.com>
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>        <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>        <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>        <xmqqr18m8514.fsf@gitster.g> <xmqqy22u6o3d.fsf@gitster.g>        <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>        <xmqqczjt9hbz.fsf@gitster.g>        <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com> <xmqq35kp806v.fsf@gitster.g>
In-Reply-To: <xmqq35kp806v.fsf@gitster.g>
Subject: RE: [PATCH v4 2/4] core.fsync: introduce granular fsync control
Date:   Fri, 11 Feb 2022 19:39:02 -0500
Organization: Nexbridge Inc.
Message-ID: <010e01d81fa8$f22bc070$d6834150$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEMlBRvhLTQmYQtawQ1iLoAdDcgHAG8VsZhAdSK4aEBY8G+bQGbhU7QAby7A0gB0DYsFwI4pJMnAlR/ht+tsNU3AA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 11, 2022 6:15 PM, Junio C Hamano wrote:
> Neeraj Singh <nksingh85@gmail.com> writes:
> 
> > In practice, almost all users have core.fsyncObjectFiles set to the
> > platform default, which is 'false' everywhere besides Windows.  So at
> > minimum, we have to take default to mean that we maintain behavior no
> > weaker than the current version of Git, otherwise users will start
> > losing their data.
> 
> Would they?   If they think platform default is performant and safe
> enough for their use, as long as our adjustment is out outrageously more
> dangerous or less performant, I do not think "no weaker than"
> is a strict requirement.  If we were overly conservative in some areas than the
> "platform default", making it less conservative in those areas to match the
> looseness of other areas should be OK and vice versa.
> 
> > One path to get to your suggestion from the current patch series would
> > be to remove the component-specific options and only provide aggregate
> > options.  Alternatively, we could just not document the
> > component-specific options and leave them available to be people who
> > read source code. So if I rename the aggregate options in terms of
> > 'levels of durability', and only document those, would that be
> > acceptable?
> 
> In any case, if others who reviewed the series in the past are happy with the
> "two knobs" approach and are willing to jump in to help new users who will be
> confused with one knob too many, I actually am OK with the series that I called
> "overly complex".  Let me let them weigh in before I can answer that question.

On behalf of those who are likely to set fsync to true in all cases, because a SIGSEGV or some other early abort will cause changes to be lost, I am not happy with excessive knobs, as we will have to ensure that the are all set to "write this out to disk as quickly as soon as possible or else". I end up having to teach large numbers of people about these settings and think that excessive controls in this area are overwhelmingly bad. This is not a "windows vs. everything else" situation. Not all platforms write buffered by default. fwrite and write behave different on NonStop (and other POSIXy things, and some variants are fully virtualized, so who knows what the hypervisor will do - it's bad enough that there is even an option to tell the hypervisor to keep things in memory until convenient to write even on RAID 0/1 emulation). Teaching people how to use the knobs correctly is going to be a challenge. For me, I'm always willing to sacrifice performance for reliability - 100% of the time. I'm sure this whole series is going to be problematic. I'm sorry but that's my position on it. The default position of all knobs must be to force the write and keeping it simple so that variations on knob settings give different results is not going to end well.

Sincerely,
Randall

