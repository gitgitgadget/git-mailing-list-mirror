Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B1CA0FEC
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 18:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbjIAScM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjIAScL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 14:32:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074EC19E
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 11:32:07 -0700 (PDT)
Received: (qmail 30692 invoked by uid 109); 1 Sep 2023 18:32:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Sep 2023 18:32:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21820 invoked by uid 111); 1 Sep 2023 18:32:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Sep 2023 14:32:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Sep 2023 14:32:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
Message-ID: <20230901183206.GA1952051@coredump.intra.peff.net>
References: <20230901142624.12063-1-five231003@gmail.com>
 <xmqqa5u5rgis.fsf@gitster.g>
 <20230901174540.GB1947546@coredump.intra.peff.net>
 <xmqqr0nhpyf3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0nhpyf3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2023 at 10:59:28AM -0700, Junio C Hamano wrote:

> > Yeah, I had the same thought after reading the patch. Unfortunately the
> > "type" is used only for comparison, not formatting. So you are still
> > stuck setting both v->value and v->s in grab_sub_body_contents(). It
> > feels like we could hoist that xstrfmt("%"PRIuMAX) to a higher level as
> > a preparatory refactoring. But it's not that big a deal to work around
> > it if that turns out to be hard.
> 
> Setting of the .value member happens O(N) times for the number of
> refs involved, which does not bother me.  Do you mean "when we know
> we are not sorting with size we should omit parsing the string into
> the .value member"?  If so, I think that would be nice to have.

No, I wasn't worried about code efficiency, but rather programmer
effort. IOW, I expected that the second hunk that I showed could look
like this:

diff --git a/ref-filter.c b/ref-filter.c
index 88b021dd1d..02b02d6813 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1886,7 +1886,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 		} else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
 		else if (atom->u.contents.option == C_LENGTH)
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
+			v->value = strlen(subpos);
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)

rather than setting both "value" and "s", and that some higher level
code would recognize "oh, this is FIELD_ULONG, so I'll format it rather
than looking at v->s". But it seems that such code does not exist. :)
All of the other spots that set v->value (e.g., objectsize), just set
both.

The ref-filter code is a weird mix of almost-object-oriented bits, giant
switch statements, and assumptions about which fields are set when.

> > I think they are covered implicitly by the "else" block of the
> > conditional that checks for FIELD_STR.
> 
> Ah, OK.  That needs to be future-proofed to force future developers
> who want to add different FIELD_FOO type to look at the comparison
> logic.  If we want to do so, it should be done as a separate topic
> for cleaning-up the mess, not as part of this effort.

Yes, agreed.

-Peff
