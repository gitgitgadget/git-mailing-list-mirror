Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57665C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AF623A55
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbhANUV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:21:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:56478 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbhANUV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:21:56 -0500
Received: (qmail 18168 invoked by uid 109); 14 Jan 2021 20:21:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jan 2021 20:21:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17911 invoked by uid 111); 14 Jan 2021 20:21:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jan 2021 15:21:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jan 2021 15:21:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Haller <thaller@redhat.com>, git@vger.kernel.org
Subject: Re: [bug] git-ls-files sometimes does not list files with pathspec
 magic ":(exclude)"
Message-ID: <YACnuuQ9ezo6Bb9H@coredump.intra.peff.net>
References: <e2dbe996f6a7285fe0487e34d65eccf712867547.camel@redhat.com>
 <xmqqa6tc1dab.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6tc1dab.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 06:07:56PM -0800, Junio C Hamano wrote:

> The rule IIUC is that a path must match one of the positive pathspec
> and none of the negative pathspec, but it looks as if there is some
> bogus optimization based on string length.

I dug a little on this earlier this morning, but didn't get far enough
to have any confidence that I wasn't barking totally up the wrong tree.
But I found the way the "prefix" is passed match_pathspec to be
confusing. This seems to make the problem go away:

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c8eae899b8..93796404bd 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -232,7 +232,7 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 	    is_submodule_active(repo, ce->name)) {
 		show_submodule(repo, dir, ce->name);
 	} else if (match_pathspec(repo->index, &pathspec, fullname, strlen(fullname),
-				  max_prefix_len, ps_matched,
+				  0, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
 		tag = get_tag(ce, tag);

which I guess is likewise disabling the same optimization you're talking
about. But that probably means the bug is in match_pathspec().

(I probably won't look further at this for a while, so please continue
your prodding; I just wanted to drop what little knowledge I came up
with).

-Peff
