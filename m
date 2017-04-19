Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7E0207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 02:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759294AbdDSC4M (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 22:56:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:35741 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759284AbdDSC4L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 22:56:11 -0400
Received: (qmail 29800 invoked by uid 109); 19 Apr 2017 02:56:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 02:56:10 +0000
Received: (qmail 18439 invoked by uid 111); 19 Apr 2017 02:56:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 22:56:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 22:56:08 -0400
Date:   Tue, 18 Apr 2017 22:56:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] diffcore-rename: speed up register_rename_src
Message-ID: <20170419025608.xy5nvso6k6lb5z7g@sigill.intra.peff.net>
References: <20170418194421.22453-1-git@jeffhostetler.com>
 <20170418194421.22453-2-git@jeffhostetler.com>
 <20170419013214.q35jarvmk5jhqdyi@sigill.intra.peff.net>
 <xmqqd1c9cdzi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1c9cdzi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 07:45:05PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Apr 18, 2017 at 07:44:21PM +0000, git@jeffhostetler.com wrote:
> >
> >> From: Jeff Hostetler <jeffhost@microsoft.com>
> >> 
> >> Teach register_rename_src() to see if new file pair
> >> can simply be appended to the rename_src[] array before
> >> performing the binary search to find the proper insertion
> >> point.
> >
> > I guess your perf results show some minor improvement. But I suspect
> > this is because your synthetic repo does not resemble the real world
> > very much. You're saving a few strcmps, but for each of those files
> > you're potentially going to have actually zlib inflate the object
> > contents and do similarity analysis.
> >
> > So "absurd number of files doing 100% exact renames" is the absolute
> > best case, and it saves a few percent.
> >
> > I dunno. It is not that much code _here_, but I'm not excited about the
> > prospect of sprinkling this same "check the last one" optimization all
> > over the code base. I wonder if there's some way to generalize it.
> 
> When adding many things, we often just append and then sort at the
> end after we finished adding.  I wonder if recent "check the last
> one and append" optimization beats that strategy.

The big question is whether we need to detect duplicates while we're
appending to the list, which is hard on an unsorted list.  In this
function, at least, we do detect when the path already exists and return
the existing entry. I'm not sure under what circumstances we would see
such a duplicate, though, as each filename should appear only once in
the tree diff. I would think.

Doing:

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7444c86b..56a493d97 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -86,7 +86,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
 		struct diff_rename_src *src = &(rename_src[next]);
 		int cmp = strcmp(one->path, src->p->one->path);
 		if (!cmp)
-			return src;
+			die("BUG: duplicate rename src: %s", one->path);
 		if (cmp < 0) {
 			last = next;
 			continue;

passes the test suite, at least. :)

-Peff
