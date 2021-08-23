Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3DAC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D2961374
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhHWNk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWNk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 09:40:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B8C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wLYsh3viXTxanvYuETI5ZqV9E9ZIUQVDLhvgiy1hx5c=;
        t=1629726015; x=1630935615; b=GBI/7eQ+Lbnw7iU0dTaT9W3J/XSCHfJd0jE5zpvWErIv+xp
        a9d3xmyerFzpWaeR6B/ZYwzCD97zVIhgo+Yu/gqbVh25EmELwNzVJqvj4IMgSBaf0iH0jJj3znZzn
        C68sciTHZ/OkTqAGFJLpx7LG975mT8nAkKWeO0oT7dBBB0rOhzT1FHDae2UUpq6w5wi2S+nH5ZUkc
        heWKmEHeZhS7rg1xFv63emcOp5lENSAn8CqsIXN3nsvgg4fjXWrcASgWtXYM/zCY+f5eGjJOXWV2h
        QyOz4rZrcxLWHr37BX5fJ1Rs0qruMDxyrWR23ZVK4ShQrwtylXv+HDG+UZIGB91g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mIABO-00ErUt-US; Mon, 23 Aug 2021 15:40:11 +0200
Message-ID: <746f574d20c54b5f7d1eaae74f54a624573ad6bc.camel@sipsolutions.net>
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Date:   Mon, 23 Aug 2021 15:40:10 +0200
In-Reply-To: <414ed641-2bd3-1316-8189-ad542988d091@gmail.com>
References: <20210820193504.37044-1-johannes@sipsolutions.net>
         <04ed58aa-94fa-010e-f4db-f41cd51876a5@gmail.com>
         <4d65ef5b0a9e4104d763facc42d10a20557d054d.camel@sipsolutions.net>
         <xmqqo89osi0b.fsf@gitster.g>
         <caafaf945ec43ba606b054bf4c4faa42e35a8db1.camel@sipsolutions.net>
         <414ed641-2bd3-1316-8189-ad542988d091@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2021-08-23 at 09:19 -0400, Derrick Stolee wrote:
> 
> We just add subshells this way:
> 
> test_expect_success 'test name' '
> 	prep_step &&
> 	(
> 		# now in a subshell
> 		cd wherever &&
> 		do things
> 		# don't need to cd again
> 	) &&
> 	continue test
> '

Sure. I know how to do subshells :)

My point was that inside the subshell you cannot do test_path_is_file
and similar, because the subshell didn't import the libs.

> > More importantly, how do you feel about the "cd /"?
> > 
> > The tests are always run in a place where there's a parent git folder
> > (even if it's git itself), so you cannot reproduce the segfault in a
> > test without the "cd /", though I guess "cd /tmp" would also work or
> > something, but "cd /" felt pretty safe, hopefully not many people have
> > "/.git" on their system.
> 
> Don't leave the directory your test is set up to run in.

I was specifically asking Junio ;-)

But realistically, if this is the requirement you want to impose, then
you _cannot_ test for the segfault within git's test suite. Your loss.

johannes


