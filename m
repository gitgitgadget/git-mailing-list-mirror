Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93352C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F56A6115C
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBVTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:19:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59394 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBVTN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:19:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CC6E12F9A7;
        Fri,  2 Apr 2021 17:19:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NbYykjzGihxrx3JQMhLTbQwNpTE=; b=NG/lCB
        y9vtu9T5kM0AzdaNID4/61kG8COokBRPTiqEDnfoDx3VoLdHi0DgqlUP2yAHlnOh
        nvcTaHPTTly+1YTo6N4+3Dtp8JGnIlZtt6Tb3hsbsROG4VpXYUfPKCTS9aeq4zSU
        fxMCw8g7DQ8aOKCktBiF/xsr+r2QXPTBlOUgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qz34PY6Lf3Dc9qEBgcdGv6mY+bPfpJvO
        a4Wsp1Zl3lmMJwzs/GTbJ3rhAfjsTz52fy0voQWXtr+1apsAYC91qoomexertXXy
        TWnXaHbMrXlZAVCfTqiGZV01yQlEaRfDiMvBgx9fx8Mhq+fJ+8OL85km6NHGvIAK
        RXu8Xi0b55c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67E9312F9A6;
        Fri,  2 Apr 2021 17:19:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8BE4F12F9A3;
        Fri,  2 Apr 2021 17:19:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Tom Saeger <tom.saeger@oracle.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
        <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
        <xmqq8s613gqa.fsf@gitster.g>
        <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
        <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
        <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
Date:   Fri, 02 Apr 2021 14:19:06 -0700
In-Reply-To: <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com> (Derrick
        Stolee's message of "Fri, 2 Apr 2021 16:43:16 -0400")
Message-ID: <xmqq1rbs4c6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FC8DE4C-93F9-11EB-BCA3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The other issue is that exact matches (no "*") have an exact
> string in the destination, too, so replacing the _entire_
> destination with "refs/prefetch/<remote>/*" breaks the refspec.
> I think the substring approach will still work here.

I wonder if that matters.  If the exact format says

	[remote "origin"]
	        url = git://git.kernel.org/pub/scm/git/git.git/
		fetch = +refs/heads/todo:refs/x/y/z

you can just add refs/prefetch/<remote>/ to the entire RHS to ensure
that (1) the prefetch would not affect anything outside the 'prefetch'
to break @{upstream} and friends, and (2) the prefetch from this remote
would not affect anything used for other remotes.

IOW, the RHS, as long as it is hidden from normal operations and
does not conflict with interaction with other repositories, where
exactly in the refs hierarchy these objects are "parked" does not
matter, I would think.

I do not recommend unparsed refspec and textually munging, by the
way.  Doesn't

	git fetch master:remotes/origin/master

first parse to normalize the src/dst sides to turn it into

	git fetch refs/heads/master:refs/remotes/origin/master

which is what you want to further redirect to the prefetch hierarchy

	git fetch +refs/heads/master:refs/prefetch/origin/refs/remotes/origin/master

or whatever munging scheme is used?

Also, I wonder if there should be a mechanism to prune the
prefetched refs, but that is totally outside the scope of the
problem we have been discussing in this thread.
