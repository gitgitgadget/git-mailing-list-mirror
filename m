Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416E1C04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 17:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJVRsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 13:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJVRsj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 13:48:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADC2186788
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 10:48:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E103161BAC;
        Sat, 22 Oct 2022 13:48:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=03IiN+CZtPGxn/DYp6oj7mYCcVaoTOyYpU83MO
        ohuWs=; b=aYCgyMKQXEHfCcH4IC0CyHK46VmwYSPZ2cn4jbhBb1HYdfzP33RDuJ
        r4+wD//Wr8yPZ6J6ndaRXIVKUidC4Hb+61auiI3URq3L9yNEIN8FHGzCzCrx6mbS
        fa3DWKPrteGCnVwNsnf/UjXy9pIJ5eKoQbWp1I7jfY5tS+bdshm0A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 959FE161BAB;
        Sat, 22 Oct 2022 13:48:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06160161BAA;
        Sat, 22 Oct 2022 13:48:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey <sryze@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Adding --force-if-newer flag to git push
References: <491oWe6HDMJXQK2Ru2VbzFrlUajNlVhnIErZZ1dxUaPpCElsgpASAEQFc2Zi1R4G53hAIMHopETEJn7E_TzeeC6uOzGBffQDRK2AWYPIxKQ=@protonmail.com>
Date:   Sat, 22 Oct 2022 10:48:33 -0700
In-Reply-To: <491oWe6HDMJXQK2Ru2VbzFrlUajNlVhnIErZZ1dxUaPpCElsgpASAEQFc2Zi1R4G53hAIMHopETEJn7E_TzeeC6uOzGBffQDRK2AWYPIxKQ=@protonmail.com>
        (Sergey's message of "Sat, 22 Oct 2022 16:58:55 +0000")
Message-ID: <xmqqmt9nhhqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C03C7DC2-5231-11ED-8C52-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey <sryze@protonmail.com> writes:

> Would it be a good idea to add a new flag --force-if-newer to the
> "git push" command, so that force-pushing would succeed only if
> the last local commit's date is newer than that on the remote
> branch?

Probably not.  I do not see how we can force the clock on the
machine that created the commit (which may not be even yours)
sitting at the tip on the branch you are trying to overwrite to be
in sync with the clock on the local machine on which you created the
commit you are trying to use to replace it with.

> Sometimes I find that a feature like this would be useful when I
> work on multiple different computers and I want to just push all
> local branches to the repo at once to sync it with whatever is the
> latest version. I know that using --force is kind of frowned upon
> in the Git community, so this is probably not the best idea ...

In such a workflow, not forcing is the more reasonable option.

After seeing your push fail because you forgot that you have pushed
other changes from another machine, you first fetch and consolidate
what was done on the local machine into what you have pushed before
to the remote, and push again.  If you rebased your local work on
top of what you pushed there but forgot that you have pushed, this
time around the push will fast-forward.  If you merged your local
work, it will also fast-forward.  Either way, not forcing would have
caught you from losing some work you did on another machine, and
pushing the result can be done without forcing.

