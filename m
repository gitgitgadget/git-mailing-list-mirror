Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3154720248
	for <e@80x24.org>; Tue,  2 Apr 2019 11:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfDBLwz (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 07:52:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41036 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbfDBLwy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 07:52:54 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e]:37605)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <dak@gnu.org>)
        id 1hBHyE-0000yg-Sk; Tue, 02 Apr 2019 07:52:50 -0400
Received: from x5d84a179.dyn.telefonica.de ([93.132.161.121]:54556 helo=lola)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <dak@gnu.org>)
        id 1hBHyE-0000tl-GW; Tue, 02 Apr 2019 07:52:50 -0400
From:   David Kastrup <dak@gnu.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Zager <szager@chromium.org>,
        Stefan Zager <szager@google.com>,
        Zachary Turner <zturner@chromium.org>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Alfredo Goldman <gold@ime.usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C1?= =?utf-8?B?0LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Make the git codebase thread-safe
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
        <20190402005245.4983-1-matheus.bernardino@usp.br>
        <CACsJy8BSDz1JO+w1N9w2W1zxY+EWTxiU6yB_V0eeOD--g-TzeA@mail.gmail.com>
        <87lg0s66nm.fsf@fencepost.gnu.org>
        <CACsJy8BuJbxj5fHwTc+aogWcWGR_6A0CXS78-h0zi4rYLa0kXQ@mail.gmail.com>
Date:   Tue, 02 Apr 2019 13:52:46 +0200
In-Reply-To: <CACsJy8BuJbxj5fHwTc+aogWcWGR_6A0CXS78-h0zi4rYLa0kXQ@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 2 Apr 2019 18:35:04 +0700")
Message-ID: <87d0m462up.fsf@fencepost.gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Apr 2, 2019 at 5:30 PM David Kastrup <dak@gnu.org> wrote:
>>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> > On Tue, Apr 2, 2019 at 7:52 AM Matheus Tavares
>> > <matheus.bernardino@usp.br> wrote:
>> >> I downloaded chromium to give it a try and got (on a machine with i7 and
>> >> SSD, running Manjaro Linux):
>> >>
>> >> - 17s on blame for a file with long history[2]
>> >> - 2m on blame for a huge file[3]
>> >> - 15s on log for both [2] and [3]
>> >> - 1s for git status
>> >>
>> >> It seems quite a lot, especially with SSD, IMO.
>> >
>> > There have been a couple of optimizations that are probably still not
>> > enabled by default because they only benefit large repos.
>>
>> I've proposed a trivial change in 2014 that could have cut down typical
>> blame times significantly but nobody was interested in testing and
>> committing it, and it is conceivable that in limited-memory situations
>> it might warrant some accounting/mitigation for weird histories (not
>> that there isn't other code like that).
>
> I didn't really read the patch (I don't know much about blame.c to
> really contribute anything there). But a quick "git blame --show-stats
> unpack-trees.c" shows this
>
> Without the patch:
>
> num read blob: 767
> num get patch: 425
> num commits: 343
>
> With the patch:
>
> num read blob: 419
> num get patch: 425
> num commits: 343
>
> That's a nice reduction of blob reading. On a typical small file, the
> actual time saving might be not much. But it could really help when
> you blame a large file.
>
> Perhaps you could resubmit it again for inclusion? (at least a
> sign-off-by is missing then)

I don't expect it to go anywhere but will do.  Feel free to herd it.

-- 
David Kastrup
