Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9AE71FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 19:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932187AbdBGTud (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 14:50:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:50720 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932330AbdBGTuO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 14:50:14 -0500
Received: (qmail 23312 invoked by uid 109); 7 Feb 2017 19:50:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Feb 2017 19:50:14 +0000
Received: (qmail 27994 invoked by uid 111); 7 Feb 2017 19:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Feb 2017 14:50:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2017 14:50:12 -0500
Date:   Tue, 7 Feb 2017 14:50:12 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] grep: use '/' delimiter for paths
Message-ID: <20170207195011.2yvq6hutssl4htol@sigill.intra.peff.net>
References: <20170120171126.16269-1-stefanha@redhat.com>
 <20170120171126.16269-3-stefanha@redhat.com>
 <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
 <20170120235133.GA146274@google.com>
 <20170207150414.GD8583@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170207150414.GD8583@stefanha-x1.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2017 at 03:04:14PM +0000, Stefan Hajnoczi wrote:

> > I assume Stefan just grabbed my naive suggestion hence why it checks
> > equality with a commit.  So that's my fault :)  Either of these may
> > not be enough though, since if you do 'git grep malloc v2.9.3^{tree}'
> > with this change the output prefix is 'v2.9.3^{tree}/' instead of the
> > correct prefix 'v2.9.3^{tree}:'
> 
> I revisited this series again today and am coming to the conclusion that
> forming output based on the user's rev is really hard to get right in
> all cases.  I don't have a good solution to the v2.9.3^{tree} problem.

I think the rule you need is not "are we at a tree", but rather "did we
traverse a path while resolving the name?". Only the get_sha1() parser
can tell you that. I think:

  char delim = ':';
  struct object_context oc;
  if (get_sha1_with_context(name, 0, sha1, &oc))
          die("...");
  if (oc.path[0])
          delim = '/'; /* name had a partial path */

would work. Root trees via "v2.9.3^{tree}" or "v2.9.3:" would have no
path, but "v2.9.3:Documentation" would. I think you'd still need to
avoid duplicating a trailing delimiter, but I can't think of a case
where it is wrong to do that based purely on the name.

-Peff
