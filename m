Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE04C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DEC2070A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhA0Fmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:42:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:40266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234630AbhA0E0O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 23:26:14 -0500
Received: (qmail 30522 invoked by uid 109); 27 Jan 2021 04:25:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Jan 2021 04:25:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8213 invoked by uid 111); 27 Jan 2021 04:25:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 23:25:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 23:25:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Cloning with remote unborn HEAD
Message-ID: <YBDrOrUIAcbTQ8cu@coredump.intra.peff.net>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <cover.1611686656.git.jonathantanmy@google.com>
 <xmqqeei7yyi9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeei7yyi9.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 05:11:42PM -0800, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Thanks, Peff, for your review. I have addressed your comments (through
> > replies to your emails and here in this v5 patch set).
> >
> > Jonathan Tan (3):
> >   ls-refs: report unborn targets of symrefs
> >   connect, transport: encapsulate arg in struct
> >   clone: respect remote unborn HEAD
> 
> Applying this alone to 'master' seems to pass all tests, but
> the topic seems to have funny interactions with another topic
> in flight, jk/peel-iterated-oid

I was worried at first I really screwed up something subtle, but it is
indeed just a funny local interaction.

Here's a fix which can be applied on top of jt/clone-unborn-head. It
could equally well be applied as part of the merge (with a minor
adjustment in the context), but I think it ought to be squashed into
Jonathan's patch 1 anyway.

The conflict you had to resolve was a red herring (it wasn't part of
jk/peel-iterated-oid at all, but rather other commits that got pulled in
because my topic is based on a more recent master).

-- >8 --
Subject: [PATCH] ls-refs: don't peel NULL oid

When the "unborn" feature is enabled, upload-pack serving an ls-refs
command will pass a NULL oid into send_ref(). In this case, there is no
point trying to peel the ref, since we know it points to nothing.

For now this is a harmless waste of cycles (we re-resolve HEAD and find
out that indeed, it points to nothing). But after merging with another
topic that contains 36a317929b (refs: switch peel_ref() to
peel_iterated_oid(), 2021-01-20), we'd actually end up passing NULL to
peel_object(), which segfaults!

Signed-off-by: Jeff King <peff@peff.net>
---
 ls-refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ls-refs.c b/ls-refs.c
index 4077adeb6a..bc91f03653 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -66,7 +66,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			    strip_namespace(symref_target));
 	}
 
-	if (data->peel) {
+	if (data->peel && oid) {
 		struct object_id peeled;
 		if (!peel_ref(refname, &peeled))
 			strbuf_addf(&refline, " peeled:%s", oid_to_hex(&peeled));
-- 
2.30.0.724.gc858251c49

