Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E859211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 07:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeLFHXZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 02:23:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:60716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728758AbeLFHXY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 02:23:24 -0500
Received: (qmail 4714 invoked by uid 109); 6 Dec 2018 07:23:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Dec 2018 07:23:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7011 invoked by uid 111); 6 Dec 2018 07:22:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Dec 2018 02:22:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2018 02:23:00 -0500
Date:   Thu, 6 Dec 2018 02:23:00 -0500
From:   Jeff King <peff@peff.net>
To:     "Coiner, John" <John.Coiner@amd.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
Message-ID: <20181206072300.GB29787@sigill.intra.peff.net>
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
 <878t13zp8y.fsf@evledraar.gmail.com>
 <a5a3009e-346e-2b63-5b7c-3e9daf0c7de2@gmail.com>
 <CACsJy8AzMvG3U5GnVkn0Ax3XP3NnPCwwc1AzdVV9JkePfMjwWg@mail.gmail.com>
 <877egnznhh.fsf@evledraar.gmail.com>
 <cdeb9dc9-ac25-23c8-f3b9-9a7987be7df0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdeb9dc9-ac25-23c8-f3b9-9a7987be7df0@amd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 11:42:09PM +0000, Coiner, John wrote:

> > For instance, Git is very eager to try to find delta-compression
> > opportunities between objects, even if they don't have any relationship
> > within the tree structure. So imagine I want to know the contents of
> > tree X. I push up a tree Y similar to X, then fetch it back, falsely
> > claiming to have X but not Y. If the server generates a delta, that may
> > reveal information about X (which you can then iterate to send Y', and
> > so on, treating the server as an oracle until you've guessed the content
> > of X).
> Another good point. I wouldn't have thought of either of these attacks. 
> You're scaring me (appropriately) about the risks of adding security to 
> a previously-unsecured interface. Let me push on the smudge/clean 
> approach and maybe that will bear fruit.

If you do look into that approach, check out how git-lfs works. In fact,
you might even be able to build around lfs itself. It's already putting
placeholder objects into the repository, and then faulting them in from
external storage. All you would need to do is lock down access to that
external storage, which is typically accessed via http.

(That all assumes you're OK with sharing the actual filenames with
everybody, and just restricting access to the blob contents. There's no
way to clean/smudge a whole subtree. For that you'd have to use
submodules).

-Peff
