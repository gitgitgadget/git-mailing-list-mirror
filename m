Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D659AC001DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 19:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGUTCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjGUTCo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 15:02:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDAC30DB
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 12:02:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CCE12F804;
        Fri, 21 Jul 2023 15:02:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iuzDFIVAjMriKtvKGe+tTmg+cYmPZ6xzbMxgCv
        Y0GO0=; b=yWI1zcNRnFTX7dkpoNVTHWCRn+xcZQjDqQqDuwsRkvbtGcMkfkODKy
        V/9dt6pUH6lB6Vg6G80h3zMoW9Cr6NAFyl6VOhJr9NhX3yeObE4oCeYEvLlasWox
        cesQg9yYg/6xFnhNRJriUD7bBZoNdX7nZ8A+TaMcsKCt6+jzsF9WA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 655442F803;
        Fri, 21 Jul 2023 15:02:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E024F2F802;
        Fri, 21 Jul 2023 15:02:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/5] t/lib-commit-graph.sh: avoid directory change in
 `graph_git_behavior()`
References: <cover.1689960606.git.me@ttaylorr.com>
        <715a160903be6dc8873a7215c55f90894e62f589.1689960606.git.me@ttaylorr.com>
        <CAPig+cTse-bgpApQR3jVGir0Tur22NEgAoTKpmLek+pTRovxwg@mail.gmail.com>
        <ZLrQyZAoRIaga1mT@nand.local>
Date:   Fri, 21 Jul 2023 12:02:37 -0700
In-Reply-To: <ZLrQyZAoRIaga1mT@nand.local> (Taylor Blau's message of "Fri, 21
        Jul 2023 14:39:05 -0400")
Message-ID: <xmqqfs5hulyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 295C267A-27F9-11EE-8A24-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>>     graph_git_two_modes "${DIR:+-C \"$DIR\"} log ..." &&
>>
>> Unfortunately, however, some older broken shells incorrectly expand
>> this to a single argument ("-C <dir>") rather than the expected two
>> arguments (-C and "<dir>")[1,2,3,4]. The workaround is unsightly but
>> doable:
>>
>>     graph_git_two_modes "${DIR:+-C} ${DIR:+\"$DIR\"} log ..." &&
>
> Hmm. I get what you're saying, but I think in this case we're OK, since
> this all goes to `graph_git_two_modes`, whose implementation looks like:
>
>     graph_git_two_modes() {
>         git -c core.commitGraph=true $1 >output
>     }
>
> So I think we really do want everything smashed together into a single
> argument.

This is not a scripted Porcelain that must cope with any funnies the
end users may throw at us, after all.

How about adding a new prominent note at the beginning of
graph_git_behavior helper to declare that it is a bug if DIR
contains any characters (e.g. $IFS) that may make the shell
misbehave, and then stop worrying about quoting of this one?

That would keep the end result slightly more readable ;-)
