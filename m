Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0045DC77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbjEKSbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjEKSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:31:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4009512E
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:31:44 -0700 (PDT)
Received: (qmail 27447 invoked by uid 109); 11 May 2023 18:31:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 May 2023 18:31:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11659 invoked by uid 111); 11 May 2023 18:31:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 May 2023 14:31:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 May 2023 14:31:43 -0400
From:   Jeff King <peff@peff.net>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 23/24] hash-ll, hashmap: move oidhash() to hash-ll
Message-ID: <20230511183143.GA1978320@coredump.intra.peff.net>
References: <44a4027b240289605f4c40b9121ee6615e9759f7.1683431153.git.gitgitgadget@gmail.com>
 <20230511172401.934633-1-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230511172401.934633-1-calvinwan@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 05:24:01PM +0000, Calvin Wan wrote:

> > Note that there's a small but
> > important change to khash.h in this patch as well to allow this move,
> > which is easy to overlook.
> 
> Can you go into a bit more detail as to how this change allows the move?
> (An example of the concatenation would probably be sufficient)

Even after finding the hunk, I have to admit I scratched my head at what
was going on.

The answer is that object-store-ll.h now uses "struct kh_odb_path_map"
instead of a typedef'd kh_odb_path_map. Using the typedef is the way
that the khash library intends to work (and the only way it provides),
but does not match our usual Git style. In other users of the khash
library, we just bend to their will and use the typedef typedef (which
we have to, because it does not even name the struct type directly!).

But we can't do that here, because object-store-ll.h does not include
khash.h, so must forward declare the struct (actually, we do not even do
that, but it is legal to just refer to it as a pointer). But the
compiler only understands what we are doing if the "struct" keyword is
present.

So I think the solution here is reasonable, but I actually think it
would make sense to pull it out into its own patch, with a rationale
like:

  khash.h lets you instantiate custom hash types that map between two
  types. These are defined as a struct, as you might expect, and khash
  typedef's that to kh_foo_t. But it declares the struct anonymously,
  which doesn't give a name to the struct type itself; there is no
  "struct kh_foo". This has two small downsides:

    - when using khash, we declare "kh_foo_t *the_foo".  This is
      unlike our usual naming style, which is "struct kh_foo *the_foo".

    - you can't forward-declare a typedef of an unnamed struct type in
      C. So we might do something like this in a header file:

         struct kh_foo;
         struct bar {
                 struct kh_foo *the_foo;
	 };

      to avoid having to include the header that defines the real
      kh_foo. But that doesn't work with the typedef'd name. Without the
      "struct" keyword, the compiler doesn't know we mean that kh_foo is
      a type.

   So let's always give khash structs the name that matches our
   conventions ("struct kh_foo" to match "kh_foo_t"). We'll keep doing
   the typedef to retain compatibility with existing callers.

The "you can't do this in C" is all off the top of my head. I think it's
correct, but there may be a clever way to do it that I don't know of.
Though even there is, I think "make khash more like our usual
conventions" is a good thing by itself.

-Peff
