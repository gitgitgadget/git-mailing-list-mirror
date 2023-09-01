Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD05CA0FEC
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 17:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350455AbjIARpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbjIARpo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 13:45:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69605E5C
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 10:45:41 -0700 (PDT)
Received: (qmail 30602 invoked by uid 109); 1 Sep 2023 17:45:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Sep 2023 17:45:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21365 invoked by uid 111); 1 Sep 2023 17:45:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Sep 2023 13:45:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Sep 2023 13:45:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
Message-ID: <20230901174540.GB1947546@coredump.intra.peff.net>
References: <20230901142624.12063-1-five231003@gmail.com>
 <xmqqa5u5rgis.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5u5rgis.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2023 at 09:43:07AM -0700, Junio C Hamano wrote:

> IOW, when you notice that you need to set, say, u.contents.option of
> an atom to C_LENGTH, shouldn't you set cmp_type of the atom to
> FIELD_ULONG, somewhere in contents_atom_parser() and friends, and
> everything should naturally follow, no?

Yeah, I had the same thought after reading the patch. Unfortunately the
"type" is used only for comparison, not formatting. So you are still
stuck setting both v->value and v->s in grab_sub_body_contents(). It
feels like we could hoist that xstrfmt("%"PRIuMAX) to a higher level as
a preparatory refactoring. But it's not that big a deal to work around
it if that turns out to be hard.

> It seems that support for other cmp_types are incomplete in the
> current code.  There are FIELD_ULONG and FIELD_TIME defined, but
> they do not appear to be used in any way, so the cmp_ref_sorting()
> would need to be updated to make it actually pay attention to the
> cmp_type and perform numeric comparison.

I think they are covered implicitly by the "else" block of the
conditional that checks for FIELD_STR.

So just this is sufficient to make contents:size work:

diff --git a/ref-filter.c b/ref-filter.c
index 88b021dd1d..02e3b6ba82 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -583,9 +583,10 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 		atom->u.contents.option = C_BARE;
 	else if (!strcmp(arg, "body"))
 		atom->u.contents.option = C_BODY;
-	else if (!strcmp(arg, "size"))
+	else if (!strcmp(arg, "size")) {
+		atom->type = FIELD_ULONG;
 		atom->u.contents.option = C_LENGTH;
-	else if (!strcmp(arg, "signature"))
+	} else if (!strcmp(arg, "signature"))
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
@@ -1885,9 +1886,10 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
 			v->s = strbuf_detach(&sb, NULL);
 		} else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
-		else if (atom->u.contents.option == C_LENGTH)
-			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
-		else if (atom->u.contents.option == C_BODY)
+		else if (atom->u.contents.option == C_LENGTH) {
+			v->value = strlen(subpos);
+			v->s = xstrfmt("%"PRIuMAX, v->value);
+		} else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
 			v->s = xmemdupz(sigpos, siglen);

-Peff
