Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213992018E
	for <e@80x24.org>; Sun, 10 Jul 2016 14:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414AbcGJO01 (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 10:26:27 -0400
Received: from imap.thunk.org ([74.207.234.97]:53670 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932169AbcGJO00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 10:26:26 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=NZ427kM6Yj4Yh3/gc7QEQc2oSmU0s9yvqhxpidowJfo=;
	b=ORsmvIMrsDtuSPanF4hICHqWMc9TGYYiC/N6tO7j5Vf5ERfkv5wrOxHunShtXYkYA6h3WA2iB6Lx261qg8e2TFLAZFMKfvXOzTSk8laiB6yjJoSrFjRuvufuMOSYjOiz0GORug5PCXVA4mMwSyGRjT7BVdy3/7wwTkFEk6WOgKA=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bMFgd-0000Y9-Af; Sun, 10 Jul 2016 14:26:23 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 252DD82E07A; Sun, 10 Jul 2016 10:26:22 -0400 (EDT)
Date:	Sun, 10 Jul 2016 10:26:22 -0400
From:	Theodore Ts'o <tytso@mit.edu>
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: add format specifiers: %gr, %gt, %gI, gi
Message-ID: <20160710142622.GE26097@thunk.org>
References: <20160710055402.32684-1-tytso@mit.edu>
 <20160710061644.GA19640@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160710061644.GA19640@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 02:16:45AM -0400, Jeff King wrote:
> I wonder if a better approach would be:
> 
>   1. In the short term, add specific designators for the fields you'd
>      want. One for HEAD@{n} that is unaffected by date, as %gd is (or
>      even one for the branch-name and one for "n"). And one for the
>      reflog date, by itself, in whatever format --date= asked for.
> 
>      That would let you do your format above, though it does not let you
>      show the reflog date in multiple formats.

Hrm, maybe.  I didn't realize that %gd and %gD displayed something
very different if --date is specified.  Is this documented?  I looked
everywhere, and the closest I could find is a mention in the
description of -g that if you specify commit@{now}, the output will
use commit@{timestamp} notation --- but that's different from
--date=xxx, and it doesn't actually specify which pretty-printer
format string this affects, although I suppose that's not that hard to
infer.

One other thing I'll note in passing is that the --date notation
doesn't support Unix timestamps.  So you can't actually do the
equivalent of %gt as proposed in this patch.

I'm not sure what designators we'd use for a HEAD@{n} that is
uneffected by date, and as far as which arbitrary two-letter code for
"reflog date in the default date format", we can't use %gd (ala %ad or
%cd), since it's already spoken for.  %gr, %gt, etc., at least have
the advantage that they are somewhat orthogonal to %ar/%at, %cr/%ct,
etc.

So I definitely understand the concern about the PP format string
being somewhat creaky, and obscure.  It's not entirely clearly to me
that adding the new designators actually doesn't add more bloat or
non-orthogonality.  I suppose we could add %gb for branch name, and
%gU for the HEAD@{n} nUm --- since %gn and %gN are already spoken for
--- and then use %gt for the reflog date in the default date format.
So that only adds three new two-letter formats, instead of the four in
my patch.

(BTW, I really only care about %gt and %gr --- so if the concern is
bloat, we could just add those two specifiers.  I just added %gi and
%gI because it wasn't hard, and I thought orthoganlity was better
where it was possible.)

>   2. In the long term, teach log's pretty formatter to handle less
>      obscure syntax, that can include arguments. The pretty-printer in
>      for-each-ref can already do "%(authordate:relative)", and accepts
>      any date-format that git knows about. We should do the same here.

See the above comment about our currently not supporting Unix time as
one of the date-formats.  So if the goal was to make the proposed new
pretty formatter be a superset of the percent expansion rules, there
isn't really a clean way of doing %at.

One possibility is %{authordate:format:%s} --- but it suffers from two
drawbacks:

(a) It's kind of ugly/obscure, since it gets us back to using
not-so-human-friendly percent expansions.

(b) It's not portable, since apparently %s isn't one of the strftime
formats which is guaranteed by the Single Unix Specification or the
C99 standard.  (Maybe it is implemented in all of the platforms we
care about (e.g., Windows, MacOS, etc.), though.)


One other long-term thought.  Maybe past a certain point, we should
just make it easy to get the data from git-log into a perl or pythons
script, where it becomes possible to do conditionals, more flexible
padding rules, etc.  So some kind of --format=yaml or --format=json
sort of thing.  Some interesting ideas of how we could do this can be
found here:

	https://cloud.google.com/sdk/gcloud/reference/topic/formats

... although I doubt whether git would ever want to do the equivalent of:

gcloud compute images list  --format='table[box,title=Images](name:sort=1,family)'

which will print something like this:

+------------------------------------------------------------+
|                           Images                           |
+------------------------------------------+-----------------+
|                   NAME                   |      FAMILY     |
+------------------------------------------+-----------------+
| centos-6-v20160629                       | centos-6        |
| centos-7-v20160629                       | centos-7        |
| coreos-alpha-1097-0-0-v20160702          | coreos-alpha    |
| coreos-beta-1068-3-0-v20160627           | coreos-beta     |
| coreos-stable-1010-6-0-v20160628         | coreos-stable   |
| debian-8-jessie-v20160629                | debian-8        |
| freebsd-101-release-amd64-20150101032704 |                 |
| opensuse-13-2-v20160222                  |                 |
| opensuse-leap-42-1-v20160302             |                 |
| rhel-6-v20160629                         | rhel-6          |
| rhel-7-v20160629                         | rhel-7          |
| sles-11-sp4-v20160301                    |                 |
| sles-12-sp1-v20160301                    |                 |
| ubuntu-1204-precise-v20160627            | ubuntu-1204-lts |
| ubuntu-1404-trusty-v20160627             | ubuntu-1404-lts |
| ubuntu-1510-wily-v20160627               | ubuntu-1510     |
| ubuntu-1604-xenial-v20160627             | ubuntu-1604-lts |
| windows-server-2008-r2-dc-v20160623      | windows-2008-r2 |
| windows-server-2012-r2-dc-v20160623      | windows-2012-r2 |
| xfstests-201607030209                    | xfstests        |
+------------------------------------------+-----------------+

and will even use fancy graphics characters if you're using a terminal
which supports them.  :-)

						- Ted

