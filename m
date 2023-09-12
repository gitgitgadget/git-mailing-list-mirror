Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B7CA0ECA
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 08:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjILI50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjILI5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 04:57:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F89BAA
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 01:57:21 -0700 (PDT)
Received: (qmail 14624 invoked by uid 109); 12 Sep 2023 08:57:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Sep 2023 08:57:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16924 invoked by uid 111); 12 Sep 2023 08:57:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Sep 2023 04:57:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Sep 2023 04:57:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Roger Light <roger@atchoo.org>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: Commit dates on conflict markers
Message-ID: <20230912085720.GE1630538@coredump.intra.peff.net>
References: <CAH7zdydYgSf+21GB70=gRhEcupv4e1ix==7LWCeQYgpD-1Rcmw@mail.gmail.com>
 <xmqq8r9cs2x1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8r9cs2x1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 04:31:06PM -0700, Junio C Hamano wrote:

> A change that only shows the commit date without allowing end user
> configuration will *not* be worth doing, but allowing them to use
> placeholders like '%h %s' in "git log --format='%h %s'" (check
> pretty.c for the catalog) would be a good exercise; it should not
> take somebody with an ultra-deep knowledge of how the code works.

FWIW, I had the same thought. But I wasn't quite sure where we even set
these strings, so here are a few thoughts for anybody who wants to work
on it:

  - the relevant strings are passed in to ll_merge(); you can grep for
    callers and see that there are a number of strings which end up here
    (based on what info we actually have).

    The most interesting one to start with is probably the call in
    merge_3way() of merge-ort.c.

  - there we have three object_ids, "o", "a", and "b" representing the
    three sides. But these are just blobs. We have strings "ancestor",
    "branch1", and "branch2" in merge_options, but we would probably not
    want to re-resolve those names. So probably some extra fields need
    to go into merge_options.

  - I'm not sure if each of those endpoints is always a commit. For a
    regular merge, they would be. But in a recursive merge, we'd
    sometimes create an intermediate virtual tree. So we'd need to
    handle the case that there is no commit (and either fall back to a
    more vanilla string, or make a fake commit with reasonable details).

  - The current labels are based on the "original" ref names (which I
    think are really "what was handed to merge"; so it might be
    "master~13" etc) along with the blob path (if it is not the same for
    both endpoints). So you'd want more than just passing the format
    string to format_commit_message(). You would want an extra
    placeholder to represent those values (either ref and pathname
    individually, or possibly a single placeholder for "ref and maybe
    pathname if it's interesting").

    The least-bad way to do that is perhaps to expand the format twice:
    once for the special placeholder (quoting any "%" found in the
    filename, etc), and then feeding the whole result to the
    pretty-print formatter.

I was hoping this might be only a few-line change, but I actually think
it's a bit more complicated than that. But still maybe not _too_ bad.

-Peff
