Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB480C7EE23
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 10:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbjDZKxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 06:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbjDZKxE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 06:53:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CB259E5
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 03:52:36 -0700 (PDT)
Received: (qmail 6552 invoked by uid 109); 26 Apr 2023 10:51:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Apr 2023 10:51:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13403 invoked by uid 111); 26 Apr 2023 10:51:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Apr 2023 06:51:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Apr 2023 06:51:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <20230426105134.GA130148@coredump.intra.peff.net>
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
 <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
 <xmqqcz3ry2sw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz3ry2sw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 04:12:15PM -0700, Junio C Hamano wrote:

> And I think even with "--no-local" to make it about v0/v1 protocol,
> the outcome is still pretty much expected.  If we make the above
> command line to
> 
> 	GIT_TRACE_PACKET=1 \
> 	git clone --no-local src256 dst256 &&
> 
> to clone over the on-the-wire protocol, then we see
> 
>     Cloning into 'dst256'...
>     packet:  upload-pack> 0000
>     packet:        clone< 0000
>     warning: You appear to have cloned an empty repository.
>     packet:        clone> 0000
>     packet:  upload-pack< 0000
>     --- expect      2023-04-25 22:55:39.771850195 +0000
>     ...
> 
> in the output of "sh t5700-*.sh -i -v".  Without any ref, v0/v1 can
> not carry any capabilities, because there is no ref information to
> tuck the capabilities on.
> 
> I unfortunately doubt that any solution would exist that does not
> break compatibility with the deployed clients that expect the
> current v0/v1.

We could send a capabilities^{} line, which Git has supported on the
client side since eb398797cd (connect: advertized capability is not a
ref, 2016-09-09). So sending it should not break even old clients
(though we would have to check what alternate implementations like
libgit2 or dulwich do; we know JGit supports it).

However, the object-format support here was broken until the very recent
13e67aa39b (v0 protocol: fix sha1/sha256 confusion for capabilities^{},
2023-04-14), so it would only be useful going forward (before then we'd
die(), but maybe that is preferable to having the wrong object format?).

I'm not sure it's worth the effort, though. If you want to use sha256
everywhere and tell the other side about it, you need a modern client
anyway, and that means the ability to speak v2. So this would only
matter if for some reason the v2 probe was being ignored (e.g., proxies
eating it, ssh refusing environment variable, etc), which itself are
things that ideally would be fixed (and can maybe one day even go away
if we optimistically default to v2).

-Peff
