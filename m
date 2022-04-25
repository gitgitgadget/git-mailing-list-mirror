Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931D7C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 08:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiDYIR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 04:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiDYIRS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 04:17:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385765AEEB
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 01:14:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 037F11A1915;
        Mon, 25 Apr 2022 04:14:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=myMf4CE0Ieum9+R1S3ocCFC393pugtEVgUt1O1dbWtQ=; b=ccal
        gRfIpxAqAYIL+sHx85bf7c/AkjZox99XgFFTuYc/2/E4oy/kJHjZOZxMNrzm2M+n
        eZsRMexYzn1qbGhOkLqR8E3pMHSGNq/MxDtAKFmdC7wyR2kRlzRoURu8uiqzin8y
        oEDRtH+2WysNOEY1amh5ZTDp2DfOiSMX+y0qvbw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0ABE1A1914;
        Mon, 25 Apr 2022 04:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 831F21A1912;
        Mon, 25 Apr 2022 04:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     FanJun Kong <bh1scw@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: help for git format-patch lost diffstat
References: <20220424064114.nwzldz5s2bnkrlu5@kong-HP>
Date:   Mon, 25 Apr 2022 01:14:04 -0700
Message-ID: <xmqqk0bdy3zn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC76D436-C46F-11EC-AA8F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FanJun Kong <bh1scw@gmail.com> writes:

> First, I created two commits to a demo project.
>
> when I use command:
> git format-patch --cover-letter -1
> ...
> Then I change command to:
>
> git format-patch --cover-letter -2


Here is _one_ way I just came up with, that gives you a result
identical to what you reported, and it is a perfectly understandable
and expected outcome in _this_ scenario.

Preparation goes like this.  Go to any single-parent commit and
revert it.

  $ git checkout --detach seen^2
  $ GIT_EDITOR=: git revert HEAD

Now we have two commits.  Try formatting the topmost one:

  $ git format-patch --stdout --cover-letter -1 |
    sed -e "1,/^$/d" -e "/^-- /q"
  *** BLURB HERE ***

  Junio C Hamano (1):
    Revert "ci: call `finalize_test_case_output` a little later"

   t/test-lib.sh | 11 +++++------
   1 file changed, 5 insertions(+), 6 deletions(-)

  -- 

Now try formatting the twomost two:

  $ git format-patch --stdout --cover-letter -2 |
    sed -e "1,/^$/d" -e "/^-- /q"
  *** BLURB HERE ***

  Johannes Schindelin (1):
    ci: call `finalize_test_case_output` a little later

  Junio C Hamano (1):
    Revert "ci: call `finalize_test_case_output` a little later"


  -- 

The topmost commit had some effect on a single file, but when the
effect of two topmost commits are taken together, they cancel out.

I am not saying these two commits are what you have, but the outcome
obviously depends on what these two commits are, and if you do not
show them, nobody would be able to help you.

