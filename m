Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7386C001DF
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 22:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjHBWb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 18:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHBWby (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 18:31:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E26F2
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 15:31:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACADA1A1435;
        Wed,  2 Aug 2023 18:31:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GH/1C8CkGcco3l5MSa2k3wItQg+W5VvtsNaEBr
        IbQdE=; b=gkVsXpBTdGzlvCWx/uRabVNJ9G1D3n//lemp249s6CY97l6w2I4ROY
        644E4yduLmrOk2LckaeUuk1+LCo8D6hjvez33VOn1Xb9bC96o3CHvORvSXczS1j2
        ZtSW5QIO0KUIUURGUpVf8cHkm8bjteNwXj/vZYOplB3/U6Pl/5Hsg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A52F11A1434;
        Wed,  2 Aug 2023 18:31:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18FE61A1433;
        Wed,  2 Aug 2023 18:31:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Yucheng Zhou <zhouyucheng98@outlook.com>, git@vger.kernel.org
Subject: Re: Feature request for shorter relative date format in log
References: <ME3P282MB2274D11DC15DF1FDBBC36C3DBE0BA@ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM>
        <ZMqciat7tdbYGob8@nand.local>
Date:   Wed, 02 Aug 2023 15:31:51 -0700
In-Reply-To: <ZMqciat7tdbYGob8@nand.local> (Taylor Blau's message of "Wed, 2
        Aug 2023 14:12:25 -0400")
Message-ID: <xmqqsf915b54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6099385A-3184-11EE-89FD-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> But we don't have a way for users to provide custom over relative dates.

Are there existing systems to format time durations in a customized
way, just like strftime() is a way way to custom-format a timestamp,
that we can just use, or write our own modelling after them?

The relative-time code decides which points in the time durection
spectrum are good places to switch the granularity (e.g. up to 90
seconds we will give "N seconds", and up to 90 minutes we will give
"N minutes").  You could grep in date.c:show_date_relative() for
Q_() and _(), and place them in an array and allow them to be
replaced by strings in the configuration variable, but that will
cover only one smaller half of the problem (i.e. how the "N seconds"
are shown) and the other half (i.e. what variants there are, and
which variant is used for what time duration---you cannot introduce
a rule that says "up to 500 seconds, show 'N minutes M seconds'").

Even with that solution to the smaller half will also create i18n
headaches.

> Perhaps we should?

It will be an interesting puzzle, if done well.  Even though my
criteria to consider that a solution is done "well" is not that
high, it should at least allow defining your own variants.  Instead
of the rules that are implemented as hardcoded if-statement cascade
in date.c:show_date_relative(), it should allow you to say something
like

    * For a timestamp that is N seconds into the future, format a
      relative timestamp that is N seconds ago, and replace "ago"
      with "in the future".

    * For a timestamp that is less than 1200 seconds ago, show "N
      minutes M seconds ago" (with appropriate pluralization for
      "minute" and "second" when N and/or M is 1).

    * For a timestamp that is less than 5 hours ago, show "N hours M
      minutes ago" (ditto about plural).

and so on.

No, I am not interested in working on such a solution myself.  But
it will be an interesting puzzle.

