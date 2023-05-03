Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DFAC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 09:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjECJDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECJDx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 05:03:53 -0400
Received: from mail.zombino.com (c2.zombino.com [65.108.93.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E30E4F
        for <git@vger.kernel.org>; Wed,  3 May 2023 02:03:49 -0700 (PDT)
Received: from [10.168.4.122] (unknown [81.95.8.244])
        by mail.zombino.com (Postfix) with ESMTPS id BDF303E9D5;
        Wed,  3 May 2023 09:03:47 +0000 (UTC)
Message-ID: <70103746-6980-baed-13d9-afeae6cee464@zombino.com>
Date:   Wed, 3 May 2023 11:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Is GIT_DEFAULT_HASH flawed?
Content-Language: en-US
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
 <20230427054343.GE982277@coredump.intra.peff.net>
 <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
From:   Adam Majer <adamm@zombino.com>
In-Reply-To: <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/23 01:46, Felipe Contreras wrote:
> To be honest this whole approach seems to be completely flawed to me and
> against the whole design of git in the first place.

The discussion above is mostly moot now since this has been fixed in 
later patches in this thread, AFAIK. It's also moot for other reasons, 
like the hash function transition plan is not really implemented, yet.

Also, this was about corner-case, like it often is.


> In a recent email Linus Torvalds explained why object ids were
> calculated based {type, size, data} [1], and he explained very clearly
> that two objects with exactly the same data are not supposed to have the
> same id if the type is different.

This is different. But aside, type + size + data are not really much 
different from just having data in a hash function. There are plenty of 
hash collisions where

     HASH(type + size + data) == HASH(type + size + data')

by definition of how these functions work. The problem is always in 
finding these collisions. But anyway...

> In my view one repository should be able to have part SHA-1 history,
> part SHA3-256 history, and part BLAKE2b history.

Yes, that would be great. Please provide patch series for this :-)

> I have not been following the SHA-1 -> OID discussions, but I
> distinctively recall Linus Torvalds mentioning that the choice of using
> SHA-1 wasn't even for security purposes, it was to ensure integrity.

These are different sides of the same coin. Hashes are used to provide 
integrity. Hashes like MD4, MD5, SHA1, SHA256 are there for integrity. 
Some of these are no longer recommended and some are completely broken.

> Better the SHA-1 you know, than the SHA-256 you don't.

Wrong conclusion ;) Also, we know SHA-256

The problem in git-core and virtually all clients and other 
implementations is/was that SHA1 was hardcoded and assumed to be THE ONE 
and ONLY hash. It will take quite a bit of work outside of git-core to 
remove this one assumption (remember two digit year and 2000? - yes I'm 
old). Once this hash assumption is removed, you can start talking about 
adding other hashes and interop.

Keep in mind -- hashes are there for object reference. They are the glue 
in git. But there is really nothing stopping us from recalculating them 
"on the fly". If you have SHA1 repo, you can calculate a SHA256 or 
whatever hash for any type object. That's not the problem, conceptually 
speaking.

Finally, let not have a "bike shed" discussion about this. The 
GIT_DEFAULT_HASH is meant to be used by `git init` in-lieu of 
--object-format parameter, so it's not flawed. When used in other 
applications, it probably indicates a bug. But we can't fix all the bugs 
at once :-)

Cheers,
- Adam
