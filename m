Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFFEC05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBNWbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBNWa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:30:58 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8CC26CCB
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:30:57 -0800 (PST)
Received: (qmail 3381 invoked by uid 109); 14 Feb 2023 22:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 22:30:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6842 invoked by uid 111); 14 Feb 2023 22:30:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 17:30:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 17:30:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
Message-ID: <Y+wLoFKXhlugxrh1@coredump.intra.peff.net>
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
 <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
 <xmqqmt5f535i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt5f535i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 01:48:57PM -0800, Junio C Hamano wrote:

> > +	do {
> > +		if (!*rule)
> > +			BUG("rev-parse rule did not have percent");
> > +		if (*rule == '%')
> > +			break;
> > +	} while (*refname++ == *rule++);
> 
> So, if we have refname="refs/heads/frotz" and rule="refs/%.*s", then
> we'll scan refname and rule to skip over their "refs/" prefix, and
> the next iteration, where post-increment moved the pointers to point
> at 'h' (at the beginning of "heads/frotz") on the refname side and
> '%' on the rule side, we iterate once more, notice *rule is '%', and
> break out of the loop.  We have refname="heads/frotz" and rule="%.*s"
> 
> If we have refname="refsXheads/frotz" and rule="refs/%.*s", after
> skipping over "refs", refname points at 'X' while rule points at '/'
> and the loop needs to break.  Both pointers are post-incremented,
> and now we have refname="heads/frotz" and rule="%.*s".

Thanks for being careful. I had originally detected a match by setting a
flag in the loop when we see the "%", but then thought it wasn't needed.
And it's not for the matching case, but it is for the non-match.

This would fix it:

diff --git a/refs.c b/refs.c
index d8ce7e9ee1..2c26cf02d3 100644
--- a/refs.c
+++ b/refs.c
@@ -1318,6 +1318,8 @@ int update_ref(const char *msg, const char *refname,
 static const char *match_parse_rule(const char *refname, const char *rule,
 				    size_t *len)
 {
+	int matched = 0;
+
 	/*
 	 * Check that rule matches refname up to the first percent
 	 * in the rule. This is basically skip_prefix(), but
@@ -1326,10 +1328,15 @@ static const char *match_parse_rule(const char *refname, const char *rule,
 	do {
 		if (!*rule)
 			BUG("rev-parse rule did not have percent");
-		if (*rule == '%')
+		if (*rule == '%') {
+			matched = 1;
 			break;
+		}
 	} while (*refname++ == *rule++);
 
+	if (!matched)
+		return 0;
+
 	/*
 	 * Check that we matched all the way to the "%" placeholder,
 	 * and skip past it within the rule string. If so, "refname" at

but I have a feeling that it gets more readable if we flip the break
conditional and the loop condition.

I had also imagined this as a skip_prefix_to_percent() helper, which
makes the logic nicer, but we actually need to advance in both the
refname and the prefix, which makes for a weird interface.

-Peff
