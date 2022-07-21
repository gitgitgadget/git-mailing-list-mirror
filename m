Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50026CCA479
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiGUGLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGUGLw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:11:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6BA64C9
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:11:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC4E81A8D42;
        Thu, 21 Jul 2022 02:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N8JeVGsZ1GQ4SAo+wFUwRYBD7N80bNjELLTuNi
        ZGO2k=; b=F5A1a5YUqlV82dLLbx7zI91UAPLkHpB0o60QeWyk913lKyFpexe9oJ
        G6GwDf5Lgig2vgClfLyjBTdFRBh1gBJjTpqmc6zJOJEGtSqTHVM8B37xNTld6HQb
        PPk7EOA3f10vSBpiSDSHjla5Ma1dqX3ImXtmZWpZM0Iqz0t/4WkpE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3F021A8D41;
        Thu, 21 Jul 2022 02:11:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 715861A8D3D;
        Thu, 21 Jul 2022 02:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: On-branch topic description support?
References: <xmqqilnr1hff.fsf@gitster.g>
        <CABPp-BFm2c2Mpdj6pTR2-WPEsnQWTJpH70xrZoqUrwOed9o9=w@mail.gmail.com>
Date:   Wed, 20 Jul 2022 23:11:46 -0700
In-Reply-To: <CABPp-BFm2c2Mpdj6pTR2-WPEsnQWTJpH70xrZoqUrwOed9o9=w@mail.gmail.com>
        (Elijah Newren's message of "Wed, 20 Jul 2022 22:25:19 -0700")
Message-ID: <xmqqbktjm1ul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00920D02-08BC-11ED-B09B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> The cover letter material often includes stuff that would not make
> sense for the merge message (e.g. "Rebased this version on master
> because of conflicts with ...", "Changes since v3", "I'm a little
> unsure of the logic in Patch 5", "Patch 3 might be controversial; take
> a look", etc.)  Would there be some kind of syntax for specifying the
> part of the cover letter meant to be used in the merge commit message,
> or would we just start out with it pre-populating the commit message
> and expect the integrator to cull out the irrelevant parts?

Yeah, I wanted to flesh out a bit more details on how this may work
before writing more about it, but what I envisioned would go
something along this line:

 * The authoring side would keep track of the description of the
   topic as a whole plus the description of inter-iteration changes,
   in the empty tip commit.  There may be some convention with a
   minimum mark-up (similar to how an innocuous three-dash line
   serves the "end of the message" marker in a patch e-mail) to
   separate the latter from the former.

 * "format-patch --cover-letter" would take the above, and add
   range-diff etc. that is easier to compute mechanically;

 * "am" may take the above, and keep the whole thing;

 * "merge" would keep the "main topic description" part and strip
   out everything after it, including the inter-iteration comparison
   and the range-diff, most likely by commenting the latter out when
   presenting it to the integrator.  So a lazy integrator can simply
   exit the editor to lose everything other than the topic
   description, and a more careful ones may refer to the supporting
   material to enhance/extend the topic description.

