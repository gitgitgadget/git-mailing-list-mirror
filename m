Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742BAC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjALQUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbjALQTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:19:11 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F51C63CC
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:16:13 -0800 (PST)
Received: (qmail 5329 invoked by uid 109); 12 Jan 2023 16:16:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Jan 2023 16:16:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16711 invoked by uid 111); 12 Jan 2023 16:16:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Jan 2023 11:16:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Jan 2023 11:16:12 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/5] cleaning up read_object() family of functions
Message-ID: <Y8AyTE3OS7HCAzKH@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <f1028cba-5fc6-3584-3f21-545550012e9d@github.com>
 <Y77/T8dktee3wOA5@coredump.intra.peff.net>
 <230112.86fscg2jbm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230112.86fscg2jbm.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 10:21:46AM +0100, Ævar Arnfjörð Bjarmason wrote:

> I agree that it's probably not worth it here, but I think you're just
> tying yourself in knots in trying to define these macros in terms of
> each other. This sort of thing will work if you just do:
> 	
> 	diff --git a/object-store.h b/object-store.h
> 	index e894cee61ba..bfcd2482dc5 100644
> 	--- a/object-store.h
> 	+++ b/object-store.h
> 	@@ -418,8 +418,8 @@ struct object_info {
> 	  * Initializer for a "struct object_info" that wants no items. You may
> 	  * also memset() the memory to all-zeroes.
> 	  */
> 	-#define OBJECT_INFO(...) { 0, __VA_ARGS__ }
> 	-#define OBJECT_INFO_INIT OBJECT_INFO()
> 	+#define OBJECT_INFO_INIT { 0 }
> 	+#define OBJECT_INFO(...) { __VA_ARGS__ }

Right, that works because the initializer is just "0", which the
compiler can do for us implicitly. I agree it works here to omit, but as
a general solution, it doesn't.

> Which is just a twist on René's suggestion from [1], i.e.:
> 
> 	#define CHILD_PROCESS_INIT_EX(...) { .args = STRVEC_INIT, __VA_ARGS__ }
>
> In that case we always need to rely on the "args" being init'd, and the
> GCC warning you note is a feature, its initialization is "private", and
> you should never override it.

Right, and it works here because you'd never want to init .args to
anything else (which I think is what you mean by "private"). But in the
general case the defaults can't set something that the caller might want
to override, because the compiler's warning doesn't know the difference
between "override" and "oops, you specified this twice".

It's mostly a non-issue because we tend to prefer 0-initialization when
possible, but I think as a general technique this is probably opening a
can of worms for little benefit.

-Peff
