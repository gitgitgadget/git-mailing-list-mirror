Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A591FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbdLHV2f (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:28:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:52912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750951AbdLHV2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:28:35 -0500
Received: (qmail 30412 invoked by uid 109); 8 Dec 2017 21:28:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 21:28:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6258 invoked by uid 111); 8 Dec 2017 21:28:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 16:28:56 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 16:28:33 -0500
Date:   Fri, 8 Dec 2017 16:28:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
Message-ID: <20171208212832.GC7355@sigill.intra.peff.net>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
 <20171208101455.GC1899@sigill.intra.peff.net>
 <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de>
 <xmqqd13p83sb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd13p83sb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 10:37:08AM -0800, Junio C Hamano wrote:

> > The two modes (dup/nodup) make string_list code tricky.  Not sure
> > how far we'd get with something simpler (e.g. an array of char pointers),
> > but having the caller do all string allocations would make the code
> > easier to analyze.
> 
> Yes.
> 
> It probably would have been more sensible if the API did not have
> two modes (instead, have the caller pass whatever string to be
> stored, *and* make the caller responsible for freeing them *if* it
> passed an allocated string).

I'd actually argue the other way: the simplest interface is one where
the string list owns all of its pointers. That keeps the
ownership/lifetime issues clear, and it's one less step for the caller
to have to remember to do at the end (they do have to clear() the list,
but they must do that anyway to free the array of items).

It does mean that some callers may have to remember to free a temporary
buffer right after adding its contents to the list. But that's a lesser
evil, I think, since the memory ownership issues are all clearly
resolved at the time of add.

The big cost is just extra copies/allocations.

I dunno. I actually do not mind the "nodup" version of append being used
on a "dup" list. It is just a way of letting each call decide on whether
to hand over ownership, and I think most sites are pretty clear.

> For the push_refs_with_push() patch you sent, another possible fix
> would be to make cas_options a nodup kind so that the result of
> strbuf_detach() does not get an extra strdup to be lost when placed
> in cas_options.  With the current string-list API that would not
> quite work, because freeing done in _release() is tied to the
> "dup/nodup" ness of the string list.  I think there even is a
> codepath that initializes a string_list as nodup kind, stuffs string
> in it giving the ownership, and then flips it into dup kind just
> before calling _release() only to have it free the strings, or
> something silly/ugly like that.

Yes, the first grep hit for NODUP is bisect_clean_state(), which does
this. I think it would be more clear if we could do:

diff --git a/bisect.c b/bisect.c
index 0fca17c02b..7c59408a13 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1060,8 +1060,7 @@ static int mark_for_removal(const char *refname, const struct object_id *oid,
 			    int flag, void *cb_data)
 {
 	struct string_list *refs = cb_data;
-	char *ref = xstrfmt("refs/bisect%s", refname);
-	string_list_append(refs, ref);
+	string_list_appendf(refs, "refs/bisect%s", refname);
 	return 0;
 }
 
@@ -1070,11 +1069,10 @@ int bisect_clean_state(void)
 	int result = 0;
 
 	/* There may be some refs packed during bisection */
-	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
+	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
 	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
 	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
 	result = delete_refs("bisect: remove", &refs_for_removal, REF_NO_DEREF);
-	refs_for_removal.strdup_strings = 1;
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_expected_rev());
 	unlink_or_warn(git_path_bisect_ancestors_ok());


Having a "format into a string" wrapper doesn't cover _every_ string you
might want to add to a list, but my experience with argv_array_pushf
leads me to believe that it covers quite a lot of cases.

I dunno. I am not so bothered by the current dual-nature that I think it
is worth going on a crusade to eliminate one side. But I'm OK if
somebody else wants to do so.

-Peff
