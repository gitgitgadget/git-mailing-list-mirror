From: Jeff King <peff@peff.net>
Subject: Re: Why is "git fetch --prune" so much slower than "git remote
 prune"?
Date: Thu, 19 Mar 2015 17:26:40 -0400
Message-ID: <20150319212640.GB8363@peff.net>
References: <CACBZZX5n5tTCSa-_A5gQzbzboF_v8a3_oVUjdjyFtKHHe8h-NA@mail.gmail.com>
 <20150306225917.GA1589@peff.net>
 <550AE1E4.7020407@alum.mit.edu>
 <xmqqpp84iye2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:27:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYhxn-00055y-FV
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbbCSV0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:26:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:35472 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750731AbbCSV0m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 17:26:42 -0400
Received: (qmail 5681 invoked by uid 102); 19 Mar 2015 21:26:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:26:42 -0500
Received: (qmail 17687 invoked by uid 107); 19 Mar 2015 21:26:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 17:26:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 17:26:40 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp84iye2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265837>

On Thu, Mar 19, 2015 at 12:24:21PM -0700, Junio C Hamano wrote:

> > For pruning, we can't use a ref_transaction as it is currently
> > implemented because it would fail if any of the reference deletions
> > failed. But in this case I think if any deletions fail, we would prefer
> > to emit a warning but keep going.
> 
> I am not quite sure what you mean here.  I agree with you if you
> meant "we shouldn't fail the fetch only because 'fetch --prune'
> failed to remove only one of the remote-tracking refs that are no
> longer there" but that can easily be solved by the pruning phase
> into a separate transaction.  If you meant "we would rather remove
> origin/{a,b} non-atomically when we noticed that origin/{a,b,c} are
> all gone than leaving all three intact only because we failed to
> remove origin/c for whatever reason", my knee-jerk reaction is "does
> it make practical difference to the end user between these two?"
> 
> What are the plausible cause of failing to prune unused
> remote-tracking refs?

I had assumed earlier that Michael meant to use a single ref_transaction
for all updates. Thinking on it more, that is probably a bad idea, as it
makes fetch atomic in a user-visible way, whereas currently the updates
are always per-ref (i.e., some may fail, but we let others succeed). I
don't know if people actually care or not (certainly the exit code of
fetch represents all of the refs, so it is not like you could say "eh,
git-fetch return 1, but it probably got the ref I wanted" without
parsing the human-readable output).

If it is just a single atomic commit for all of the deletions, I agree
it is less of a big deal. They are unlikely to fail, and when they do,
you are not blocking the new refs from coming in.

I think the ref_transaction does have some smarts to handle a case where
we are updating "refs/foo/bar" while "refs/foo" exists but is deleted in
the transaction. We switched to pruning before updating in
10a6cc8 (fetch --prune: Run prune before fetching, 2014-01-02), so it is
a non-issue, but what is there now is technically racy[1], and it would
have been nice to let the ref-storage code handle it. I guess we still
can if we introduce a "git fetch --atomic" option.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/239519
