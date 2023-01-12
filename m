Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB1C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbjALQao (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjALQaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:30:01 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D7DC7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:29:04 -0800 (PST)
Received: (qmail 5584 invoked by uid 109); 12 Jan 2023 16:29:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Jan 2023 16:29:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16803 invoked by uid 111); 12 Jan 2023 16:29:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Jan 2023 11:29:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Jan 2023 11:29:03 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 5/5] packfile: inline custom read_object()
Message-ID: <Y8A1T5kzgqXV5vKr@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <Y7l4vQwRZzGtxlBB@coredump.intra.peff.net>
 <230112.86o7r42k13.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230112.86o7r42k13.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 10:01:28AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > -				base = read_object(r, &base_oid, &type, &base_size);
> > +
> > +				oi.typep = &type;
> > +				oi.sizep = &base_size;
> > +				oi.contentp = &base;
> > +				if (oid_object_info_extended(r, &base_oid, &oi, 0) < 0)
> > +					base = NULL;
> > +
> >  				external_base = base;
> >  			}
> >  		}
> 
> This isn't introducing a behavior difference, in fact it's diligently
> bending over backwards to preserve existing behavior, but I don't think
> we need to do so, and shouldn't have this "base = NULL" line.
> 
> Here we're within an "if" block where we tested that "base == NULL"
> (which is why we're trying to populate it)
> 
> Before when we had read_object() re-assigning to "base" here was the
> obvious thing to do, but now this seems like undue an incomplete
> paranoia.

I think it's the same paranoia that was in read_object(). There it
catches the error and returns NULL, rather than the probably-NULL
"content" (though to be fair, it simply did not initialize the pointer,
so it would have had to do that to depend on it).

I agree it's probably being overly defensive. But I don't think
oid_object_info_extended() makes any promises, and it's not completely
clear to me if packed_object_info() could return a non-NULL entry here
on an error (e.g., if packed_to_object_type() fails even after we pulled
out the content).

So probably yes, we could depend on that (and if not, arguably we should
be fixing oid_object_info_extended(), because we are probably leaking a
buffer in that case). But we definitely shouldn't be doing it in the
middle of another patch.

> If oid_object_info_extended() why can't we trust that it didn't touch
> our "base"? And if we can't trust that, why are we trusting that it left
> "type" and "base_size" untouched?

My assumption is that "base" gated access to "type" and "base_size". So
as long as "!base", we do not look at the other two.

> I think squashing this in would be much better:
> 	
> 	diff --git a/packfile.c b/packfile.c
> 	index 79e21ab18e7..f45017422a1 100644
> 	--- a/packfile.c
> 	+++ b/packfile.c
> 	@@ -1795,10 +1795,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
> 	 				oi.typep = &type;
> 	 				oi.sizep = &base_size;
> 	 				oi.contentp = &base;
> 	-				if (oid_object_info_extended(r, &base_oid, &oi, 0) < 0)
> 	-					base = NULL;
> 	-
> 	-				external_base = base;
> 	+				if (!oid_object_info_extended(r, &base_oid, &oi, 0))
> 	+					external_base = base;
> 	 			}
> 	 		}
> 
> Not only aren't we second-guessing that our "base" was left alone, we're
> using the return value of oid_object_info_extended() to guard that
> assignment to "external_base" instead (it's NULL at this point too).

I don't think we need to guard the assignment (we know it will be NULL
if we saw an error). But sure, I don't mind if you want to do that
simplification, but it should be on top if at all.

-Peff
