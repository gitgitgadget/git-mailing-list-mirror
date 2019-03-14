Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B2120248
	for <e@80x24.org>; Thu, 14 Mar 2019 02:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfCNCYD (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 22:24:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:50204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726530AbfCNCYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 22:24:03 -0400
Received: (qmail 2741 invoked by uid 109); 14 Mar 2019 02:24:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 02:24:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18369 invoked by uid 111); 14 Mar 2019 02:23:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 22:23:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 22:22:46 -0400
Date:   Wed, 13 Mar 2019 22:22:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] get_oid(): when an object was not found, try harder
Message-ID: <20190314022245.GA1414@sigill.intra.peff.net>
References: <pull.161.git.gitgitgadget@gmail.com>
 <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com>
 <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 10:29:49AM +0900, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > @@ -442,6 +442,18 @@ static enum get_oid_result get_short_oid(const char *name, int len,
> >  	find_short_packed_object(&ds);
> >  	status = finish_object_disambiguation(&ds, oid);
> >  
> > +	/*
> > +	 * If we didn't find it, do the usual reprepare() slow-path,
> > +	 * since the object may have recently been added to the repository
> > +	 * or migrated from loose to packed.
> > +	 */
> > +	if (status == MISSING_OBJECT) {
> > +		reprepare_packed_git(the_repository);
> > +		find_short_object_filename(&ds);
> > +		find_short_packed_object(&ds);
> > +		status = finish_object_disambiguation(&ds, oid);
> > +	}
> > +
> 
> This looks obviously correct, but two things that made me wonder
> briefly were:
> 
>  1. is reprepare_packed_git() a bit too heavy-weight, if the only
>     thing we are addressing is the loose-object cache going stale?

It's not the only thing we are addressing. :)

Try this:

-- >8 --
mkfifo in
(git cat-file --batch-check <in) &
exec 9>in

git commit --allow-empty -m one
git commit --allow-empty -m two

git rev-parse --short HEAD^ >&9
git repack -adk
git rev-parse --short HEAD >&9
-- >8 --

The second object will (usually) be reported as "missing", even though
by calling reprepare_packed_git(), we would then find it in the
packfile.

I say "usually" because if the two commits have the same first-byte to
their sha1, then we'd load both into the loose cache during the first
request, and use that during the second request.

After this patch, it works consistently (we flush both the loose cache
and the cached set of packs, and find the packed version).

>  2. is there a way to cleanly avoid the three-line duplicate?

Yeah, as you noted, I think the boilerplate is worse than the
duplication. The most readable alternative to me is a separate function,
like:

diff --git a/sha1-name.c b/sha1-name.c
index cfe5c874b6..441666993b 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -411,6 +411,14 @@ static int sort_ambiguous(const void *a, const void *b)
 	return a_type_sort > b_type_sort ? 1 : -1;
 }
 
+static enum get_oid_result(struct disambiguate_state *ds,
+			   struct object_id *oid)
+{
+	find_short_object_filename(&ds);
+	find_short_packed_object(&ds);
+	return finish_object_disambiguation(&ds, oid);
+}
+
 static enum get_oid_result get_short_oid(const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
@@ -438,20 +446,16 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	else
 		ds.fn = default_disambiguate_hint;
 
-	find_short_object_filename(&ds);
-	find_short_packed_object(&ds);
-	status = finish_object_disambiguation(&ds, oid);
+	status = do_get_short_oid(&ds, oid);
 
 	/*
 	 * If we didn't find it, do the usual reprepare() slow-path,
 	 * since the object may have recently been added to the repository
 	 * or migrated from loose to packed.
 	 */
 	if (status == MISSING_OBJECT) {
 		reprepare_packed_git(the_repository);
-		find_short_object_filename(&ds);
-		find_short_packed_object(&ds);
-		status = finish_object_disambiguation(&ds, oid);
+		status = do_get_short_oid(&ds, oid);
 	}
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {

But what I find particularly ugly is not just that it's more lines, but
that the assumptions and outputs of do_get_short_oid() aren't
particularly clear.

-Peff
