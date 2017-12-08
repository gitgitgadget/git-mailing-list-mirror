Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9EE20C32
	for <e@80x24.org>; Fri,  8 Dec 2017 10:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbdLHKPG (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 05:15:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:51942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753106AbdLHKPD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 05:15:03 -0500
Received: (qmail 32763 invoked by uid 109); 8 Dec 2017 10:14:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 10:14:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30800 invoked by uid 111); 8 Dec 2017 10:15:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 05:15:19 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 05:14:56 -0500
Date:   Fri, 8 Dec 2017 05:14:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
Message-ID: <20171208101455.GC1899@sigill.intra.peff.net>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 01:47:14PM -0800, Junio C Hamano wrote:

> > diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
> > index 22034f87e7..8e8a15ea4a 100644
> > --- a/builtin/fmt-merge-msg.c
> > +++ b/builtin/fmt-merge-msg.c
> > @@ -377,7 +377,8 @@ static void shortlog(const char *name,
> >  			string_list_append(&subjects,
> >  					   oid_to_hex(&commit->object.oid));
> >  		else
> > -			string_list_append(&subjects, strbuf_detach(&sb, NULL));
> > +			string_list_append_nodup(&subjects,
> > +						 strbuf_detach(&sb, NULL));
> >  	}
> >  
> >  	if (opts->credit_people)
> 
> What is leaked comes from strbuf, so the title is not a lie, but I
> tend to think that this leak is caused by a somewhat strange
> string_list API.  The subjects string-list is initialized as a "dup"
> kind, but a caller that wants to avoid leaking can (and should) use
> _nodup() call to add a string without duping.  It all feels a bit
> too convoluted.

I'm not sure it's string-list's fault. Many callers (including this one)
have _some_ entries whose strings must be duplicated and others which do
not.

So either:

  1. The list gets marked as "nodup", and we add an extra xstrdup() to the
     oid_to_hex call above. And also need to remember to free() the
     strings later, since the list does not own them.

or

  2. We mark it as "dup" and incur an extra allocation and copy, like:

       string_list_append(&subjects, sb.buf);
       strbuf_release(&buf);

So I'd really blame the caller, which doesn't want to do (2) out of a
sense of optimization. It could also perhaps write it as:

  while (commit = get_revision(rev)) {
	strbuf_reset(&sb);
	... maybe put some stuff in sb ...
	if (!sb.len)
		string_list_append(&subjects, oid_to_hex(obj));
	else
		string_list_append(&subjects, sb.buf);
  }
  strbuf_release(&sb);

which at least avoids the extra allocations.

By the way, I think there's another quite subtle leak in this function.
We do this:

  format_commit_message(commit, "%s", &sb, &ctx);
  strbuf_ltrim(&sb);

and then only use "sb" if sb.len is non-zero. But we may have actually
allocated to create our zero-length string (e.g., if we had a strbuf
full of spaces and trimmed them all off). Since we reuse "sb" over and
over as we loop, this will actually only leak once for the whole loop,
not once per iteration. So it's probably not a big deal, but writing it
with the explicit reset/release pattern fixes that (and is more
idiomatic for our code base, I think).

-Peff
