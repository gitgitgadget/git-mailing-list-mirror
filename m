Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301A3C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 23:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiGTXk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 19:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGTXk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 19:40:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C172219C01
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 16:40:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D1821A6A7C;
        Wed, 20 Jul 2022 19:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=X
        YNThCKRIfThZv9Vd3iDxjG2cL4lxZMuMcyd43tZX0c=; b=VyRT9DCq9InshSPzq
        +8nMwc6S4I5O23af2EGBhe/vxAWFkoE8rb2z1wxdUJSfKFyIKtwHHOmwhzXYRm6V
        BeCbrwiup1CtxeWDCZBkioqzpQFBrJJOuXEwAX63O4Zp+48JDyLaLuFvx7bIpQgn
        9uAlGiU7LsmAkco+UEis2URK34=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 257391A6A7B;
        Wed, 20 Jul 2022 19:40:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B16F21A6A7A;
        Wed, 20 Jul 2022 19:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: On-branch topic description support?
Date:   Wed, 20 Jul 2022 16:40:52 -0700
Message-ID: <xmqqilnr1hff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 650DCBFE-0885-11ED-8902-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been playing with this idea from time to time, but recently I
started seeing a related discussion on the b4 front, so I thought I
would throw it out and how people would think.

We made "git merge" not to silently commit the result, but open the
editor to encourage the integrator to describe what the topic is
about.  We also made "git format-patch" prepare [PATCH 0/n] aka
"cover letter" so that the author of the patch series can express
what the overall topic is about.  What the author should say in the
cover letter very much overlaps what the integrator wants to have in
the log message of the commit that merges the topic to the
integration branch.

But there are two (and half) links from format-patch to that merge
commit that are missing.  

 - You cannot prepare the cover letter material while working on the
   topic---instead, you have to write one by editing the output from
   "format-patch --cover-letter";

 - "git am" at the receiving end discards the cover letter when
   queuing the e-mailed patches to a topic.

 - "git merge" cannot take advantage of the cover letter that was
   discarded when the topic was queued.

So, here is how I would imagine a slightly better world may work.

 * When you are almost finished with the initial draft of your
   topic, you'd write a cover letter, and record it as the log
   message of an empty commit at the tip of the topic.  As you go on
   polishing the topic with "rebase -i", the empty commit would be
   kept (if we currently lose an empty commit by default, we may
   need to teach "rebase -i" to special case an empty commit at the
   tip of the range to make this convenient to use), and you would
   keep it up to date as you update the topic.

 * "git format-patch" would notice that the topic has such an empty
   commit at the tip, and use the log message from it to
   pre-populate the cover letter.

 * "git am" would learn an option to save the cover letter [0/n] and
   create such an empty commit at the tip of the branch.

 * "git merge" would learn an option to recognize that the branch
   being merged has such an empty commit at the tip, and instead
   merge the parent of the tip of the branch into the integration
   branch, while using the log message of the discarded tip commit
   in the log message of the merge itself.

Yes, there is "git config branch.mytopic.description" that helps
when pre-populating the cover letter, but that only helps at the
origin, and it is not shared between your personal repositories.
If you have the draft of the cover letter as part of the branch,
you can push/fetch them around just like all the "real" commits
you are working on.

Regardless of where the cover letter comes from, the changes to "am"
and "merge" dreamed above in this message would be useful, and that
is the primary reason why I am envisioning that right at the origin
having the topic description as an empty commit at the tip would be
the most convenient.  It would match the shape of the history at the
author side and at the side who runs "git am".
