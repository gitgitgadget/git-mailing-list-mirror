Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8C3C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 00:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1927C613C2
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 00:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbhDGAT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 20:19:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52114 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbhDGAT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 20:19:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BAAC12E172;
        Tue,  6 Apr 2021 20:19:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lsuxIKMYEfLdpvje356wddeldlk=; b=DTg116
        ww7BHJkMbBrzdc4wXsIw8994gmK6hh88D0JRBJxjPATaVT3Vmi3GH6YlbAEZC6ua
        fZOY8ZX9NcybWIWe0shMx+Ezo8K2du1lg8c58qoM6pF6GF9Ov7f2aBV2hvvNECxd
        novGWQOUiknJxiMN1oUdOLKRkdQlkNsSUWNc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yn7pNsfmifrdnUfyV0wCNcEQgA/QXdE3
        nJYJI7s4jYrsdnn4biiQHdZG+gsuDrUR580sPPCJp17l58OvgpkFrrmEaD1E2TEc
        mxD2Y+oVoX54R+rFowsG56lynfhD9VSzu/uaz84q1BGTZenvcEay4CXkf0mB0WCU
        rtd8FeeZNqU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 92BEC12E171;
        Tue,  6 Apr 2021 20:19:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D914812E16E;
        Tue,  6 Apr 2021 20:19:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, newren@gmail.com, ross@skydio.com,
        abe@skydio.com
Subject: Re: [PATCH] git-apply: try threeway first when "--3way" is used
References: <20210406025551.25213-1-jerry@skydio.com>
        <20210406232532.3543-1-jerry@skydio.com>
Date:   Tue, 06 Apr 2021 17:19:13 -0700
In-Reply-To: <20210406232532.3543-1-jerry@skydio.com> (Jerry Zhang's message
        of "Tue, 6 Apr 2021 16:25:32 -0700")
Message-ID: <xmqqczv70wvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3195B06-9736-11EB-8699-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Subject: Re: [PATCH] git-apply: try threeway first when "--3way" is used

Just for future reference, it is customery to start with [PATCH v2],
[PATCH v3], etc. when sending an updated patch to make sure it is
obvious to readers of the list which one is the latest.

> The apply_fragments() method of "git apply" can silently apply
> patches incorrectly if a file has repeating contents. In these
> cases a three-way merge is capable of applying it correctly in
> more situations, and will show a conflict rather than applying it
> incorrectly. However, because the patches apply "successfully"
> using apply_fragments(), git will never fall back to the merge,
> even if the "--3way" flag is used, and the user has no way to
> ensure correctness by forcing the three-way merge method.

I think this version addresses all issues I noticed in the previous
version.  Unless somebody else finds some more issues in a coming
few days, let's declare victory and merge it down to 'next'.

By the way, as my last response bounced for the address
brian.kubisiak@skydio.com you had on the CC list, I'm excluding it
from the Cc list of this message.

Thanks.
