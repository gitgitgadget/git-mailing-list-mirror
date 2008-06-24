Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,
	MSGID_FROM_MTA_HEADER,MSGID_NOFQDN1,PLING_QUERY,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: (qmail 919 invoked by uid 111); 24 Jun 2008 08:08:44 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 04:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306AbYFXIIW (ORCPT <rfc822;peff@peff.net>);
	Tue, 24 Jun 2008 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756940AbYFXIIV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:08:21 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60053 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757247AbYFXIIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:08:17 -0400
Received: (qmail 10103 invoked by uid 90); 24 Jun 2008 08:07:54 -0000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:	"David Jeske" <jeske@google.com>
To:	Jeff King <peff@peff.net>
Cc:	"Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
Subject: Re: why is git destructive by default? (i suggest it not be!)
X-Mailer: Willow v0.02
Date:	Tue, 24 Jun 2008 07:31:31 -0000
Message-ID: <willow-jeske-01l5kbGzFEDjCX3J>
Received: from 67.188.42.104 at Tue, 24 Jun 2008 07:31:31 -0000
References: <20080624072455.GF19224@sigill.intra.peff.net>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5jmMuFEDjChvB>
In-Reply-To: <20080624072455.GF19224@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

-- Jeff King wrote:
> I think you are confusing two aspects of history.
>
> There is the commit DAG, which says "at some time T, the files were at
> some state S, and the commit message by author A was M". And those
> commits form a chain so you can see how the state of the files
> progressed. And anything that is reachable through that history will

okay.

> always be kept by git, and you can always go back to any point.

..are you saying that if I reset --hard, or delete a branch ref, or do a
rebase, and then do a GC beyond the GC timeout, that git will NEVER throw away
any of those DAGs? (the actual source diffs committed)

> And the ref history is what gets garbage collected. Most people are fine
> with that, because they care about the actual commit history, and the
> reflog is just a convenient way of saying "oops, what was happening
> yesterday?" But if you really care, then by all means, set the reflog
> expiration much higher.

My (possibly flawed) understanding was that it drops any DAG sections that are
not referenced by valid refs which are older than the GC timeout.

It came from wording like this in the docs:

"The optional configuration variable gc.reflogExpireUnreachable
can be set to indicate how long historical reflog entries which
are not part of the current branch should remain available in
this repository. These types of entries are generally created
as a result of using git commit --amend or git rebase and are the
commits prior to the amend or rebase occurring. Since
these changes are not part of the current project most users
^^^^^^^^^^^^^
will want to expire them sooner. This option defaults to 30 days."

In the above, I resolve "these changes" to "commits prior to the amend" in the
previous sentence.

"git-gc tries very hard to be safe about the garbage it collects.
In particular, it will keep not only objects referenced by your
current set of branches and tags, but also objects referenced by
the index, remote tracking branches, refs saved by
git-filter-branch(1) in refs/original/, or reflogs (which may
references commits in branches that were later amended or rewound)."

In the above, I resolve "keep .. only objects referenced by your current set of
branches and tags [and some other stuff]" to "commmits in the DAG pointed to by
refs [and other stuff]".
Are you saying this GC process will never collect source diffs in the DAG?
