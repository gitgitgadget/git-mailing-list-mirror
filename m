Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBB38211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 22:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbeLCW5p (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 17:57:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:57820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725909AbeLCW5p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 17:57:45 -0500
Received: (qmail 7255 invoked by uid 109); 3 Dec 2018 22:57:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Dec 2018 22:57:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14850 invoked by uid 111); 3 Dec 2018 22:57:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 17:57:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 17:57:43 -0500
Date:   Mon, 3 Dec 2018 17:57:43 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: easy way to demonstrate length of colliding SHA-1 prefixes?
Message-ID: <20181203225743.GA12254@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1812020647440.32023@localhost.localdomain>
 <87y398uknn.fsf@evledraar.gmail.com>
 <5d63905a-4a52-0724-90f6-a2b0a7ab0f62@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d63905a-4a52-0724-90f6-a2b0a7ab0f62@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 02:30:44PM -0800, Matthew DeVore wrote:

> Here is a one-liner to do it. It is Perl line noise, so it's not very cute,
> thought that is subjective. The output shown below is for the Git project
> (not Linux) repository as I've currently synced it:
> 
> $ git rev-list --objects HEAD | sort | perl -anE 'BEGIN { $prev = ""; $long
> = "" } $n = $F[0]; for my $i (reverse 1..40) {last if $i < length($long); if
> (substr($prev, 0, $i) eq substr($n, 0, $i)) {$long = substr($prev, 0, $i);
> last} } $prev = $n; END {say $long}'

Ooh, object-collision golf.

Try:

  git cat-file --batch-all-objects --batch-check='%(objectname)'

instead of "rev-list | sort". It's _much_ faster, because it doesn't
have to actually open the objects and walk the graph.

Some versions of uniq have "-w" (including GNU, but it's definitely not
in POSIX), which lets you do:

  git cat-file --batch-all-objects --batch-check='%(objectname)' |
  uniq -cdw 7

to list all collisions of length 7 (it will show just the first item
from each group, but you can use -D to see them all).

> > You'll always need to list them all. It's inherently an operation where
> > for each SHA-1 you need to search for other ones with that prefix up to
> > a given length.
> > 
> > Perhaps you've missed that you can use --abbrev=N for this, and just
> > grep for things that are loger than that N, e.g. for linux.git:
> > 
> >      git log --oneline --abbrev=10 --pretty=format:%h |
> >      grep -E -v '^.{10}$' |
> >      perl -pe 's/^(.{10}).*/$1/'
> 
> I think the goal was to search all object hashes, not just commits. And git
> rev-list --objects will do that.

You can add "-t --raw" to see the abbreviated tree and blob names,
though it gets tricky around handling merges.

-Peff
