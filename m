Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96848C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDLGrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjDLGq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:46:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB061A1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:46:54 -0700 (PDT)
Received: (qmail 18117 invoked by uid 109); 12 Apr 2023 06:46:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 06:46:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17264 invoked by uid 111); 12 Apr 2023 06:46:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 02:46:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 02:46:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/7] v0 protocol: fix infinite loop when parsing
 multi-valued capabilities
Message-ID: <20230412064651.GA1681676@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
 <20230412062924.GA1681312@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412062924.GA1681312@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 02:29:24AM -0400, Jeff King wrote:

> But on the second call, now *offset is set to that larger index, which
> lets us skip past the first "symref" capability. However, we do so by
> incrementing feature_list. That means our pointer difference is now too
> small; it is counting from where we resumed parsing, not from the start
> of the original feature_list pointer. And because we incremented
> feature_list only inside our function, and not the caller, that
> increment is lost next time the function is called.
> 
> The simplest solution is to account for those skipped bytes by
> incrementing *offset, rather than assigning to it. (The other possible
> solution is to add an extra level of pointer indirection to feature_list
> so that the caller knows we moved it forward, but that seems more
> complicated).

Hmph. So after convincing myself that was the end of it, now I'm not so
sure. We also increment feature_list if we find a false positive in the
middle of another entry. I.e., the code even after this patch looks
like:

          while (*feature_list) {
                  const char *found = strstr(feature_list, feature);
                  if (!found)
                          return NULL;
                  if (feature_list == found || isspace(found[-1])) {
                          const char *value = found + len;
                          /* feature with no value (e.g., "thin-pack") */
                          if (!*value || isspace(*value)) {
                                  if (lenp)
                                          *lenp = 0;
                                  if (offset)
                                          *offset += found + len - feature_list;
                                  return value;
                          }
                          /* feature with a value (e.g., "agent=git/1.2.3") */
                          else if (*value == '=') {
                                  size_t end;
  
                                  value++;
                                  end = strcspn(value, " \t\n");
                                  if (lenp)
                                          *lenp = end;
                                  if (offset)
                                          *offset += value + end - feature_list;
                                  return value;
                          }
                          /*
                           * otherwise we matched a substring of another feature;
                           * keep looking
                           */
                  }
                  feature_list = found + 1;
          }
          return NULL;

So if we have something like:

   agent=i-like-symrefs symref=HEAD:refs/heads/foo

then we'd find the "symref" value in the agent line, increment
feature_list, and then find the real one. But our pointer difference
will again be too short! And incrementing "offset" rather than assigning
it won't help, because those skipped bytes are not accounted for in the
existing value of "offset".

So what we probably want is a third possibility I didn't allow for: keep
the original value of feature_list intact, and use a separate pointer to
increment. And then assigning "*offset = value + end - feature_list"
will always be correct, because the offset will always be from the
original, true beginning of the string.

The fix is easy, but let me see if I can come up with a test.

-Peff
