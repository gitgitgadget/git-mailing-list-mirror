Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84644C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 09:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5752E6196E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 09:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhC1J1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 05:27:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:34626 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhC1J1R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 05:27:17 -0400
Received: (qmail 2454 invoked by uid 109); 28 Mar 2021 09:26:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Mar 2021 09:26:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2492 invoked by uid 111); 28 Mar 2021 09:27:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Mar 2021 05:27:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 28 Mar 2021 05:27:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] improve reporting of unexpected objects
Message-ID: <YGBL88lYheyFmwCg@coredump.intra.peff.net>
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 28, 2021 at 04:13:30AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Ævar Arnfjörð Bjarmason (10):
>   object.c: stop supporting len == -1 in type_from_string_gently()
>   object.c: refactor type_from_string_gently()
>   object.c: make type_from_string() return "enum object_type"
>   object-file.c: make oid_object_info() return "enum object_type"
>   object-name.c: make dependency on object_type order more obvious
>   tree.c: fix misindentation in parse_tree_gently()
>   object.c: add a utility function for "expected type X, got Y"
>   object.c: add and use oid_is_type_or_die_msg() function
>   object tests: add test for unexpected objects in tags
>   tag: don't misreport type of tagged objects in errors

I'm somewhat skeptical of the final patch, given my comments (just now)
in:

  https://lore.kernel.org/git/YGBHH7sAVsPpVKWd@coredump.intra.peff.net/

I'll quote them here:

> Because when we call, say, lookup_blob() and find that the object is
> already in memory as a non-blob, we don't know who the culprit is.
> Perhaps an earlier part of the code called parse_object(), found that it
> really is a blob on disk, and used that type. But it may equally have
> been the case that we saw a reference to the object as a commit, called
> lookup_commit() on it, and now our lookup_blob() call is unhappy,
> thinking it is really a commit. In that case, one of those references is
> wrong, but we don't know which.
>
> I think a robust solution would be one of:
>
>   - make the message more precise: "saw object X as a commit, but
>     previously it was referred to as a blob". Or vice versa.
>
>   - when we see such a mismatch, go to the object database to say "aha,
>     on disk it is really a blob". That's expensive, but this is an error
>     case, so we can afford to be slow. But it does produce unsatisfying
>     results when it was the earlier lookup_commit() call that was wrong.
>     Because we have to say "object X is really a blob, but some object
>     earlier referred to it as a commit. No idea who did that, though!".

Looking at the final patch, I think you side-step the issue to some
degree because it is only touching the parse_object() code paths, where
we really have looked at the bytes in the object database. So it
basically is doing the second thing above (which is "free" because we
were accessing the odb anyway).

But I think it still has the "oops, somebody made a wrong reference much
earlier" problem. The actual bug is in some other object entirely, whose
identity is long forgotten. I think we would be much better off to say
something like "somebody expected X to be a commit, but now somebody
else expects it to be a blob", which is all that we can reliably say.
And the next step really ought to be running "git fsck" to figure out
what is going on (and we should perhaps even say so via advise()).

-Peff
