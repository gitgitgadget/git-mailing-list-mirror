Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FFFC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969E061053
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhJHChU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 22:37:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:35514 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJHChT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 22:37:19 -0400
Received: (qmail 31572 invoked by uid 109); 8 Oct 2021 02:35:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Oct 2021 02:35:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29828 invoked by uid 111); 8 Oct 2021 02:35:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Oct 2021 22:35:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Oct 2021 22:35:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] cat-file: use packed_object_info() for
 --batch-all-objects
Message-ID: <YV+ua3FlGzeflEPi@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy3rPuUal0+9iJs@coredump.intra.peff.net>
 <xmqqily8pn9h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqily8pn9h.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 07, 2021 at 01:56:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index b533935d5c..219ff5628d 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -358,15 +358,26 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
> 
> The two new parameters might deserve a comment in front of the
> function as to the calling convention (namely, offset can be any
> garbage when the caller signals "unknown" with pack==NULL).

Yes, though I'd hope everyone would just pass NULL/0. :)

I wasn't too worried about it as this is a static-local function, but
perhaps it's worth squashing the patch below into the final patch.

The "we may also look at the oid" thing is perhaps a bit subtle. It
happens because we may still print %(objectname), of course, but also
the current code will use read_object_file(oid) when printing the actual
contents.

-Peff

---
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 219ff5628d..86fc03242b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -355,6 +355,11 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 }
 
+/*
+ * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
+ * which the object may be accessed (though note that we may also rely on
+ * data->oid, too). If "pack" is NULL, then offset is ignored.
+ */
 static void batch_object_write(const char *obj_name,
 			       struct strbuf *scratch,
 			       struct batch_options *opt,
