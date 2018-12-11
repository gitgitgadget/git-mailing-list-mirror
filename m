Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EBD220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 09:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLKJq6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 04:46:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:37788 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726114AbeLKJq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 04:46:58 -0500
Received: (qmail 12050 invoked by uid 109); 11 Dec 2018 09:46:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 09:46:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3447 invoked by uid 111); 11 Dec 2018 09:46:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 04:46:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 04:46:33 -0500
Date:   Tue, 11 Dec 2018 04:46:33 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     biswaranjan.nitrkl@gmail.com, Bryan Turner <bturner@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Retrieving a file in git that was deleted and committed
Message-ID: <20181211094633.GA31588@sigill.intra.peff.net>
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
 <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
 <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com>
 <20181207072004.GA32603@sigill.intra.peff.net>
 <CABPp-BHjR7Wq-D9tFMyPHZE1ogL5udOt8ri1rN3E1CasfD-2PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHjR7Wq-D9tFMyPHZE1ogL5udOt8ri1rN3E1CasfD-2PQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 01:33:18PM -0800, Elijah Newren wrote:

> Hmm...sure, if the file is deleted on the only relevant branch through
> history...but what if there were another branch where it weren't
> deleted?  What does git blame do then?
> 
> In other words, do NOT restore the file as biswaranjan suggested, but
> instead restore it this way[1]:
> 
> git checkout -b keep-foo $REVISION_BEFORE_FOO_DELETED
> git commit --allow-empty -m "We want to keep foo"
> git checkout A
> git merge --no-commit keep-foo
> git checkout keep-foo -- foo.txt
> git commit
> 
> 
> Now, when you run
>   git blame foo.txt
> 
> blame should notice that foo.txt didn't exist in the first parent
> history on A, so it won't bother walking it to find that at some point
> foo.txt did exist there.  Instead, it'll walk down the second parent
> and follow its history, where it should keep walking back and show all
> the old changes...right?  Or did I mess up my testcase and
> misunderstand something somehow?

Yeah, I think that should work, and is a clever way of representing in
the actual history graph what you're we're trying to express. And it
shouldn't have any real downsides.

-Peff
