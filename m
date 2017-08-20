Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BAF7208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 09:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbdHTJGd (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 05:06:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:43926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751549AbdHTJGc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 05:06:32 -0400
Received: (qmail 24982 invoked by uid 109); 20 Aug 2017 09:06:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 09:06:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12796 invoked by uid 111); 20 Aug 2017 09:06:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 05:06:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 05:06:30 -0400
Date:   Sun, 20 Aug 2017 05:06:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] archive: queue directories for all types of pathspecs
Message-ID: <20170820090629.tumvqwzkromcykjf@sigill.intra.peff.net>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
 <0432c7cc-a2a5-12bd-bf65-a16186313d5b@web.de>
 <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33fa4f08-8f06-5a98-e492-3f05cc742555@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 19, 2017 at 06:53:26PM +0200, René Scharfe wrote:

> Am 19.08.2017 um 07:33 schrieb René Scharfe:
> > When read_tree_recursive() encounters a directory excluded by a pathspec
> > then it enters it anyway because it might contain included entries.  It
> > calls the callback function before it is able to decide if the directory
> > is actually needed.
> > 
> > For that reason git archive adds directories to a queue and writes
> > entries for them only when it encounters the first child item -- but
> > only if pathspecs with wildcards are used.  Do the same for literal
> > pathspecs as well, as the reasoning above applies to them, too.  This
> > prevents git archive from writing entries for excluded directories.
> 
> This breaks the test "archive empty subtree with no pathspec" in t5004 by
> omitting the empty directory from the archive.  Sorry for missing that!
> 
> This is kind of a bonus patch, so please discard it for now; the first
> three are OK IMHO.
> 
> A better version of this patch would at least update t5004 as well, but
> there might be a better way.

I actually think it would be reasonable to omit the empty directory in
t5004. The main thing we care about there is that we produce an archive
with no files rather than barfing. Checking that the empty directory is
actually there was mostly "this is what it happens to produce" rather
than any conscious decision, I think.

If the new rule is "we omit empty directories", then it would make sense
for us to follow that, regardless of whether it happened by pathspec
limiting or if the tree was empty in the first place (and such an
empty tree is insane anyway; Git tries hard not to create them).

-Peff
