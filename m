Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA8AECAAA3
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 23:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiHYXrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 19:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHYXrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 19:47:21 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A7BCCF7
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 16:47:20 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id i129so10930228vke.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=iGriOuyREme7FMQqJTtJRLEeb25yMeqMone5MdtpCAk=;
        b=AIfjJy5LCLG0zZsZM68/QDHIUT4anBFGjtmTTVRwpNhoZ3U7bIYlCKobRR1YJph09Z
         2gO7RwEJFd5GRY7/BEYZWLScwCj65yZYMoRUHGuoQTvmvYn8NufbcZL0BStN+gNisMCd
         ufMrgD64b1oO3Ey9ZCVJGSnBGlkJTv+1NqTFFaf1eWyrMpw5gzCXotK9D/WT/HxSU914
         EL1+1Bo94UXXUcIWcSsBisxrvPL1E7Nfs9ZRK2a1OFkhtwgGv1HyHgWPfAtgcSRmUPus
         +b66CCqjgZev+MAfmvdIR59VAw3UcWhB4sEor2N90ZoX2McNMlKrOqbzHYyjDcWz7MKM
         irkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=iGriOuyREme7FMQqJTtJRLEeb25yMeqMone5MdtpCAk=;
        b=PQ2rJAUUEuGBZ7fhfloM5RuCnyGwfwfXa7qmnaFOChDVM+C5N1q7qH7fDuWe1jxDZa
         iwGFCdJWYRQwDbERgIO1tsouQQcXksET1dD/ZsQytC9qolsZ8k9Lt96ET14P3VmDEoPF
         dEtZtn3enAbb+Zu8+bqTxPC4ZcTzQNVmtTIyjJvuMOUkjNi6Tb7texD4ne6AfgiDuToX
         OCA8jXXw46BUY1S20weWooUj2HabDhi/adSYyiZVUlMn3AU0HERpsA+EbEaOgP8OPBzN
         sk49inpt04ppkEAGLFmh2yoKABcH02xlFdEvkSPUmUnjia/ot8Wp9kLw6+ioMZIZUSQF
         dAwA==
X-Gm-Message-State: ACgBeo1KSzXVHJQgXIxW3g5DzwoPA9C+lcWNcuwwxI4LHWR5xW/COuxT
        2hzbXDV96Kyozvwbqr5lO5uGPV46+kF55Bc88Cg1Egi+51bavQ==
X-Google-Smtp-Source: AA6agR6cpgbr9sYAkalNOZ08pOSXBZe3rEg8oV1aW1hYrULjbzpKiU85Dj4NRIEZcjxriFWIruXwr/7jdkQv63DJLfY=
X-Received: by 2002:a1f:e882:0:b0:384:194d:66bb with SMTP id
 f124-20020a1fe882000000b00384194d66bbmr2382378vkh.33.1661471239488; Thu, 25
 Aug 2022 16:47:19 -0700 (PDT)
MIME-Version: 1.0
From:   Javier Mora <cousteaulecommandant@gmail.com>
Date:   Fri, 26 Aug 2022 01:47:08 +0200
Message-ID: <CAH1-q0iPsnkypiF=2LRgXwNqE_+R0gj706FCKgqGEUum+OAhQg@mail.gmail.com>
Subject: Potential problems with url.<base>.insteadOf
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The choice of `url.<replacement>.insteadOf <original>` as a way to
replace URLs is not only a bit confusing, as it has already been
discussed[1], but also presents some problems and makes it impossible
to achieve certain configurations.
[1] https://public-inbox.org/git/20181122173109.GI28192@sigill.intra.peff.net/

SCENARIO 1:
I want to replace all references to the (now defunct)
'http://example.org/' to the new server, 'http://example.com/'.

OK, that is easy (even if a bit counter-intuitive).  Just do:
git config url.'http://example.com/'.insteadOf 'http://example.org/'

SCENARIO 2:
I want to replace BOTH 'http://example.org/' and 'http://example.net/'
with 'http://example.com/'.

Well, now I have a problem.  If I do:

git config url.'http://example.com/'.insteadOf 'http://example.org/'
git config url.'http://example.com/'.insteadOf 'http://example.net/'

the second entry will replace the first, since I'm just using the
config entry `url.http://example.com/.insteadOf` twice.
So, it appears that this simply cannot be done in Git!
(Maybe if I daisy-chain them?  like .org -> .net and then .net -> .com)

SCENARIO 3:
I had set 'http://example.org/' to redirect to 'http://example.com/',
but that was a mistake, or there has been a migration, and it should
be 'http://example.edu/'.

The "natural reaction" here is to rewrite the command with the right
replacement value, but if I write:

git config url.'http://example.com/'.insteadOf 'http://example.org/'
git config url.'http://example.edu/'.insteadOf 'http://example.org/'

the second command doesn't replace the first, but instead is added alongside.
I'll need to manually unset the first:

git config --unset url.'http://example.com/'.insteadOf

SCENARIO 4:
For some reason (e.g. because I messed up in scenario 3), there are
two insteadOf entries in the git config with the same value.
This results in an ambiguous case, and Git does nothing to prevent it!
The documentation says that the longest insteadOf value wins, but both
have the same length since both are the same URL.

----

SOLUTION:
None of this would happen if, instead of a
`url.<replacement>.insteadOf <original>` approach, Git followed the
opposite approach, `url.<original>.replaceWith <replacement>` (or
`rewriteTo`, as it is suggested in [1]).
So this approach is not only more intuitive and looks more resilient,
it IS more resilient.

Let's have a look at the previous scenarios again:

SCENARIO 1:
About as easy as before, except that it follows a more readable "from
... to ..." scheme:

git config url.'http://example.org/'.replaceWith 'http://example.com/'

(which I suspect will also give Git less trouble to find in the
config, or at least it feels like it would).

SCENARIO 2:
Easy peasy.  Two different sources with the same target = two
different keys with the same value:

git config url.'http://example.org/'.replaceWith 'http://example.com/'
git config url.'http://example.net/'.replaceWith 'http://example.com/'

And we no longer have the problem that we cannot replace two different
URLs with the same replacement.

SCENARIO 3:
Rewriting the rule will simply overwrite the old value:

git config url.'http://example.org/'.replaceWith 'http://example.com/'
git config url.'http://example.org/'.replaceWith 'http://example.edu/'

SCENARIO 4:
Scenario 4 simply cannot happen with this approach under normal
circumstances because there can't be two entries with the same key but
different values, unless the user edited the config file manually.
(But there CAN be two entries with different keys and the same value,
which is what caused scenario 4 before.)

So, it might be a good idea to implement and recommend the
`replaceWith` (or `rewriteTo`) syntax, and deprecate the `insteadOf`
syntax (although it'll probably be necessary to keep it around for
backwards compatibility).
