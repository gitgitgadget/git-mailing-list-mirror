Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A28C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244965AbiCOTUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiCOTUc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:20:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CF239B90
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:19:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 062D411D2B9;
        Tue, 15 Mar 2022 15:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tU7t6I3cM3Arh0k2JHkOdB3gEh8GBQ0DbGlZ6T
        y3jXU=; b=opd6dvlvjFF/a4Y9wZ5VazOpMMY+W7cnATH3b9nR1wXAz5tE8uDtNJ
        rHzScQ0m7NdS9wCciOsGpcssVJZGFWXZ4Wp0DsJTclSIDivM7rPa6QoUetTWdtRj
        kZQDuBpBnJCJYjzuOyApvHm/v+A6Sjq85LueHgdYHRqOAe6JIdiqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFC3911D2B7;
        Tue, 15 Mar 2022 15:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D13E11D2B6;
        Tue, 15 Mar 2022 15:19:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
References: <20220310004423.2627181-1-emilyshaffer@google.com>
        <20220310004423.2627181-3-emilyshaffer@google.com>
        <xmqqtuc6h83m.fsf@gitster.g>
        <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqwnh1bgr4.fsf@gitster.g> <YjDdRiRvvDtKZyq4@google.com>
Date:   Tue, 15 Mar 2022 12:19:15 -0700
In-Reply-To: <YjDdRiRvvDtKZyq4@google.com> (Emily Shaffer's message of "Tue,
        15 Mar 2022 11:39:02 -0700")
Message-ID: <xmqq5yofdnws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE3F2488-A494-11EC-B0FB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> Clearing the variable from "super" is technically wrong because the
>> repository is set up as a submodule of "recursivesuper" and if we
>> had further tests, we should restore it in "super", but the point is
>> that we are makng sure "git submodule update" sets the variable in
>> the configuration file of the submodule, and not in the superproject's. 

If we wanted to be kosher about this, we could start the test with

    git config submodule.hassuperproject 1

in the "super" repository, clear the variable in the "submodule"
repository, before running the "git submodule update" step, which
(1) should not touch the "super" configuration and (2) should touch
the "submodule" configuration.

If we inspect in the "super" repository after "submodule update"

    value=$(git config submodule.hassuperproject) &&
    test "$value" = 1

I think we can tell if a buggy "submodule update" overwrites the
"super" configuration from "1" to "true".  And downstream tests
will take "1" as true just fine.

And of course, in "submodule", the variable after "submodule update"
must be set to true, which can be checked with

    value=$(git -C submodule config --type=bool submodule.hassuperproject) &&
    test "$value" = true

The trick depends on the hardcoded value to represent "true" in the
code this patch adds, but that is the canonical way to spell true in
the config, according to "git config --type=bool", so the dependency
may not be too bad.

Just a thought.


