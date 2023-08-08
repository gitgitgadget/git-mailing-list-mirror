Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6C0C001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 15:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjHHP6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjHHP5P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 11:57:15 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43D159F9
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:44:00 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 800F12422A;
        Tue,  8 Aug 2023 06:55:09 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTKMn-4V8-00; Tue, 08 Aug 2023 12:55:09 +0200
Date:   Tue, 8 Aug 2023 12:55:09 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] send-email: prompt-dependent exit codes
Message-ID: <ZNIfDXJBqEVcHh+D@ugly>
References: <xmqqttx1l3zp.fsf@gitster.g>
 <20230807165850.2335067-1-oswald.buddenhagen@gmx.de>
 <xmqqbkfifzry.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqbkfifzry.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 11:55:29AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> From the perspective of a scripted caller, failure to send (some) mails
>> is an error even if it was interactively requested, so it should be
>> indicated by the exit code.
>
>I am not sure if unconditional change of exit code this late in the
>game.

> When was the interactive "no, do not send this one" feature 
> introduced? 
>
c1f2aa45b7 (add --confirm option and configuration setting, 2009-03-02), 
and extended by 5c80afed02 (ask what to do with an invalid email 
address, 2012-11-26), so basically it's been there forever.

>I wonder if this should be hidden behind an opt-in command line option 
>and possibly a configuration variable that defaults to "no".
>
i wondered, too, but i think it isn't really worth it.
interactive users won't really care (see below), and most scripted users 
presumably simply suppressed the condition by passing --confirm=never 
and/or appropriate --suppress* options. others didn't notice (possibly 
because of their config options), or ignored the problem, and therefore 
have a good chance of being broken. some were unhappy about it, but 
didn't bother reporting/patching it, which always constitutes the vast 
majority of affected users. this still leaves us with a hypothetical 
small set of wrapper scripts that _really_ want to remain ignorant of 
messages being skipped. i think it's acceptable to expect them to adjust 
to the (from their POV) false positives, as it should be mostly 
harmless, and have the effect of getting some scripts fixed.

>> To make it somewhat specific, the exit code is 10 when only some 
>> mails
>> were skipped, and 11 if the user quit on the first prompt.
>
>If 10 and 11 were *not* taken out of thin air, but there is a
>precedent to use these two values in e-mail related programs, please
>share.  It may give us a good justification.
>
the numbers are indeed pulled out of thin air. the offset is chosen such 
that it's sufficiently far off normally expected exit codes.

>With or without other people's precedents, and with or without
>making it conditional, the new behaviour must be documented, if the
>command has already a documentation (and it seems that there exists
>the Documentation/git-send-email.txt file).
>
ack, will add an EXIT STATUS section.

>It may be preferrable
>to protect the new feature with a test or two added to t9001 but it
>obviously depends on how hard you find testing interactive stuff is.
>
shouldn't be too hard; test_{,no_}confirm show how to do it.

>> For interactive calls from the command line, interactive cancellation is
>> arguably not really an error, but there the exit code will be more or
>> less ignored anyway.
>
>Not necessarily.  Some people prefer to see it and show it in their
>command line prompt.
>
hence "mostly".
but users generally know what they did just a few secs ago, so likely 
won't be bothered by the special exit code.

>Thanks.  Will queue but expect at least some documentation updates.
>
do you want a followup, or a v4 to replace the commit?

regards
