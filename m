Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61784C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 04:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbiEZERV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 00:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiEZERT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 00:17:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C69B41C3
        for <git@vger.kernel.org>; Wed, 25 May 2022 21:17:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0678919936A;
        Thu, 26 May 2022 00:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jFVKVzhmNHFde1rNevsaMi/Gcs3CHumHwegDld
        xV6cI=; b=x/btBm0q5W8n9jlZWZZj3OMxofHXHzt39bzzXMttardzi47wRjFsUk
        FZzOWwRYNa7m2gdNlxmiczoUjE6H+OljrTx4pHQNTTnjibTwmHeidTl8zubzim9t
        R3Uoy5SZRmhTBkfRRCIonmdZxaJEuDXdW70GKNxDMCKla2I7BPaP8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F41BC199369;
        Thu, 26 May 2022 00:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6D49199368;
        Thu, 26 May 2022 00:17:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with
 BUG()
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
        <xmqqpmk15o46.fsf@gitster.g>
Date:   Wed, 25 May 2022 21:17:12 -0700
In-Reply-To: <xmqqpmk15o46.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        25 May 2022 13:55:05 -0700")
Message-ID: <xmqqh75d2aif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8584FF2-DCAA-11EC-9D97-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +/* usage.c: if bug() is called we should have a BUG_if_bug() afterwards */
>> +extern int bug_called_must_BUG;
>
> I am not sure about the name, ...

I finally figured out why I found this name so disturbing.  This is
written from the viewpoint of somebody who is trying to catch a
programmer's error of calling bug() without calling BUG_if_bug();
it is not named to help the users of API to understand it better.

I wonder if it makes sense to make the call to BUG_if_bug() totally
optional.  The rule becomes slightly different:

 * You can call bug() zero or more times.  It issues a fatal error
   message, and internally remembers the fact that we detected a
   programming error that invalidates the execution of this program,
   without immediately terminating the program.

 * When you exit() from the program, the runtime consults that "did
   we call bug()?" record and makes the program exit with known exit
   code (we could arrange it to abort() just like BUG, but I'd
   prefer controlled crash).

 * But it is inconvenient to always keep going, after you may have
   called one or more bug(), to the normal program completion.  So
   there is a helper exit_if_called_bug(), which is an equivalent to
   checking the "did we call bug()?" record and calling exit().

By making BUG_if_bug() optional, we can lose a handful of lines from
the test helper, because it makes it a non-issue to exit the program
without calling it.

Hmm?
