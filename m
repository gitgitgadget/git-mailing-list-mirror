Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1AD820A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 01:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeLMB1J (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 20:27:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:40138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726516AbeLMB1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 20:27:09 -0500
Received: (qmail 8841 invoked by uid 109); 13 Dec 2018 01:27:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Dec 2018 01:27:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21132 invoked by uid 111); 13 Dec 2018 01:26:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Dec 2018 20:26:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2018 20:27:07 -0500
Date:   Wed, 12 Dec 2018 20:27:07 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH on master v2] revision: use commit graph in
 get_reference()
Message-ID: <20181213012707.GC26210@sigill.intra.peff.net>
References: <20181211105439.GA8452@sigill.intra.peff.net>
 <20181212195812.232726-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212195812.232726-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 11:58:12AM -0800, Jonathan Tan wrote:

> > Yeah, this was the part that took me a bit to figure out, as well. The
> > optimization here is really just avoiding a call to lookup_commit(),
> > which will do a single hash-table lookup. I wonder if that's actually
> > worth this more complex interface (as opposed to just always taking an
> > oid and then always returning a "struct commit", which could be old or
> > new).
> 
> Avoidance of lookup_commit() is more important than an optimization, I
> think. Here, we call lookup_commit() only when we know that that object
> is a commit (by its presence in a commit graph). If we just called it
> blindly, we might mistakenly create a commit for that hash when it is
> actually an object of another type. (We could inline lookup_commit() in
> parse_commit_in_graph_one(), removing the object creation part, but that
> adds complexity as well.)

I was thinking we would only do so in the happy path when we find a
commit. I.e., something like:

  obj = lookup_object(oid); /* does not auto-vivify */
  if (obj && obj->parsed)
	return obj;

  if (we_have_it_in_commit_graph) {
	commit = obj || lookup_commit(oid);
	fill_in_details_from_commit_graph(commit);
	return &commit->obj;
  } else {
	return parse_object(oid);
  }

which is more along the lines of that parse_probably_commit() that
Stolee mentioned.

-Peff
