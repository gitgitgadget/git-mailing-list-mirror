Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC19C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 21:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiL3VsR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 30 Dec 2022 16:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3VsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 16:48:16 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C929F113
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 13:48:15 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BULmCf0013011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Dec 2022 16:48:12 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>,
        "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com> <xmqqilhwp5g4.fsf@gitster.g> <011201d91aca$a5db7800$f1926800$@nexbridge.com> <Y6y+zkUsPhknTYH/@google.com> <Y69TMzIf/bdsZe6/@nand.local>
In-Reply-To: <Y69TMzIf/bdsZe6/@nand.local>
Subject: RE: [BUG] fatal: transport 'file' not allowed during submodule add
Date:   Fri, 30 Dec 2022 16:48:07 -0500
Organization: Nexbridge Inc.
Message-ID: <000801d91c98$6a8bbdd0$3fa33970$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIU6GJDc0yG7ZReRHFxQVmMhwXR0AFwOXgbAkFw3nkCX13a/gIw2KbNrc1P+CA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 30, 2022 4:08 PM, Taylor Blau wrote:
>On Wed, Dec 28, 2022 at 02:10:42PM -0800, Jonathan Nieder wrote:
>> Hi Randall,
>>
>> rsbecker@nexbridge.com wrote:
>> > Junio C Hamano wrote:
>>
>> >> This suspiciously sounds like what a1d4f67c (transport: make
>> >> `protocol.file.allow` be "user" by default, 2022-07-29) is doing deliberately.
>> >
>> > I have tried using 'git config --local protocol.file.allow always'
>> > and/or 'git config --local protocol.allow always' to get past this,
>> > without success.
>>
>> Does `git config --global protocol.file.allow always` do the trick?
>>
>> >>                                                           Taylor,
>> >> does this look like a corner case the 2.30.6 updates forgot to consider?
>>
>> I think it's the intended effect (preventing file:// submodules), but
>> I wonder if this hints that we'd want that protection to be more
>> targeted.  A file:// submodule (as opposed to a bare path without URL
>> scheme) wouldn't trigger the "git clone --local" behavior that that
>> commit mentions wanting to protect against, so at first glance it
>> would appear to be no more or less dangerous than cloning from a
>> remote repository.
>
>Changing the default value of 'protocol.file.allow' isn't solely about whether or not
>we use the `file://` scheme and transport or not. Instead, it's about preventing the
>user from accidentally cloning local repositories containing sensitive data into the
>working copy of a malicious repository.
>
>One example might be that I convince you to clone my malicious repository, which
>has a Dockerfile that uploads everything in the container filesystem to some data
>harvesting server. Since 'docker run'
>automatically puts everything in '.' into the volume mount, anything in the working
>copy of my malicious repository will get exfiltrated.
>
>The worry that I wrote about in a1d4f67c was that if I knew that you stored, say,
>your SSH private key material in a repository that is at `$HOME/.git` (as is
>sometimes common practice), then I could add a submodule at
>/home/jrnieder/.git, and extract any sensitive data therein.
>
>So I think our new default is sensible here if we are concerned with preventing
>such a case.

I think the new default is reasonable but this did catch me by surprise as it broke our workflows. I guess I need to look at the release notes in more depth - that's my bad. With the caveat that I do not think this is working as intended, which I am finding, because changing the configuration does not make any behavioural difference on any platform I can test on.

