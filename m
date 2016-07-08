Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B94220705
	for <e@80x24.org>; Fri,  8 Jul 2016 03:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbcGHC76 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 22:59:58 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52897 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbcGHC75 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 22:59:57 -0400
Received: from mfilter34-d.gandi.net (mfilter34-d.gandi.net [217.70.178.165])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 26EAEA80CD
	for <git@vger.kernel.org>; Fri,  8 Jul 2016 04:59:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter34-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter34-d.gandi.net (mfilter34-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id qFDQHCeIZBHU for <git@vger.kernel.org>;
	Fri,  8 Jul 2016 04:59:52 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2FAE2A80C4
	for <git@vger.kernel.org>; Fri,  8 Jul 2016 04:59:51 +0200 (CEST)
Date:	Thu, 7 Jul 2016 19:59:49 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	git@vger.kernel.org
Subject: gc and repack ignore .git/*HEAD when checking reachability
Message-ID: <20160708025948.GA3226@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The manpage for git gc says:
> git gc tries very hard to be safe about the garbage it collects. In
> particular, it will keep not only objects referenced by your current
> set of branches and tags, but also objects referenced by the index,
> remote-tracking branches, refs saved by git filter-branch in
> refs/original/, or reflogs (which may reference commits in branches
> that were later amended or rewound).

gc, repack, and anything else that uses the machinery in reachable.c
will also check HEAD, to include objects only reachable from a detached
HEAD (which the manpage should document).

However, unreachable.c does not check any other ref that sits directly
in the .git directory, such as MERGE_HEAD, FETCH_HEAD, or
CHERRY_PICK_HEAD.  To test this, try creating a new empty repository
with "git init repo ; cd repo", then use "git fetch URL" to fetch a
repository into FETCH_HEAD, then run "git repack -a -d -f", and then
"git show FETCH_HEAD".  This similarly affects "git gc", which will
unpack all the objects from the pack and leave them loose.

This could result in data loss, if a user expected that having an object
referenced from those places would protect it from pruning.

I think the right fix for this would involve having
mark_reachable_objects in reachable.c add all refs that match
.git/*HEAD, not just .git/HEAD itself.  (I'd suggest matching .git/*HEAD
rather than hardcoding the list of "special" refs, to provide
compatibility with any other tool or future version of git that
introduces another such ref.)  This seems fairly easily done with a new
variant of do_head_ref that includes all such refs, along with a
one-line change to mark_reachable_objects to use it.

Does this seem like a reasonable approach?

- Josh Triplett
