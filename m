Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BBEC678D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 02:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjASCEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 21:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjASCEF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 21:04:05 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239945F68
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 18:03:45 -0800 (PST)
Received: (qmail 5625 invoked by uid 109); 19 Jan 2023 02:03:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jan 2023 02:03:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27989 invoked by uid 111); 19 Jan 2023 02:03:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 21:03:47 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 21:03:43 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/6] hash-object: use fsck to check objects
Message-ID: <Y8ik/3gPJHaAm8Jw@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <xmqqmt6f4l03.fsf@gitster.g>
 <Y8hm4KKVwguGGrdn@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hm4KKVwguGGrdn@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 04:38:40PM -0500, Taylor Blau wrote:

> On Wed, Jan 18, 2023 at 12:59:24PM -0800, Junio C Hamano wrote:
> > The --literally option was invented initially primarily to allow a
> > bogus type of object (e.g. "hash-object -t xyzzy --literally") but I
> > am happy to see that we are finding different uses.  I wonder if
> > these objects of known types but with syntactically bad contents can
> > be "repack"ed from loose into packed?
> >
> > >   [5/6]: fsck: provide a function to fsck buffer without object struct
> 
> It is indeed possible:
> 
> --- >8 ---
> Initialized empty Git repository in /home/ttaylorr/src/git/t/trash directory.t9999-test/.git/
> expecting success of 9999.1 'repacking corrupt loose object into packed':
> 	name=$(echo $ZERO_OID | sed -e "s/00/Q/g") &&
> 	printf "100644 fooQ$name" | q_to_nul |
> 		git hash-object -w --stdin -t tree >in &&
> 
> 	git pack-objects .git/objects/pack/pack <in
> 
> Enumerating objects: 1, done.
> Counting objects: 100% (1/1), done.
> 06146c77fd19c096858d6459d602be0fdf10891b
> Writing objects: 100% (1/1), done.
> Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> ok 1 - repacking corrupt loose object into packed
> --- 8< ---

Right, we don't do any fsck-ing when packing objects. Nor should we, I
think. We should be checking objects when they come into the repository
(via index-pack/unpack-objects) or when they're created (hash-object),
but there's little need to do so when they migrate between storage
formats.

The fact that "--literally" manually writes a loose object is mostly an
implementation detail. I think if we are not writing an object with an
esoteric type, that it could even just hit the regular index_fd() code
path (and drop the HASH_FORMAT_CHECK flag).

If you do write one with "-t xyzzy", I think pack-objects would barf,
but not because of fsck checks. It just couldn't represent that type
(which really makes such objects pretty pointless; you cannot ever fetch
or push them!).

-Peff
