From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v5 3/4] git-cherry-pick: Add test to validate new options
Date: Tue, 17 Apr 2012 06:56:04 -0400
Message-ID: <20120417105604.GB11462@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
 <20120415093933.GB6263@ecki>
 <20120416161431.GD13366@hmsreliant.think-freely.org>
 <7vvckzws73.fsf@alter.siamese.dyndns.org>
 <20120416165024.GF13366@hmsreliant.think-freely.org>
 <20120416214247.GA5606@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Apr 17 12:56:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK658-0007hY-H3
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 12:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab2DQK4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 06:56:17 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:48152 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab2DQK4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 06:56:16 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SK64r-0006BU-PZ; Tue, 17 Apr 2012 06:56:12 -0400
Content-Disposition: inline
In-Reply-To: <20120416214247.GA5606@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195754>

On Mon, Apr 16, 2012 at 11:42:49PM +0200, Clemens Buchacher wrote:
> On Mon, Apr 16, 2012 at 12:50:24PM -0400, Neil Horman wrote:
> > On Mon, Apr 16, 2012 at 09:35:12AM -0700, Junio C Hamano wrote:
> > > Neil Horman <nhorman@tuxdriver.com> writes:
> > > 
> > > > On Sun, Apr 15, 2012 at 11:39:35AM +0200, Clemens Buchacher wrote:
> > > > ...
> > > >> > +test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
> > > >> > +	git checkout master && {
> > > >> > +		git cherry-pick --allow-empty empty-branch2
> > > >> > +	}
> > > >> > +'
> > > >> > +
> > > >> > +test_expect_success 'cherry pick with --keep-redundant-commits' '
> > > >> > +	git checkout master && {
> > > >> > +		git cherry-pick --keep-redundant-commits HEAD^
> > > >> > +	}
> > > >> > +'
> > > >> 
> > > >> And the expected result is that the HEAD commit is not removed, right?
> > > >> You should check for that as well.
> > > >> 
> > > >> Also, please checkout empty-branch2^0 first, in order to make the test
> > > >> independent of its predecessor.
> > > >
> > > > Not sure I follow what your saying here.  The expected result with both of these
> > > > tests is that a new commit is created, referencing the current HEAD as the new
> > > > HEAD's parent.
> > > 
> > > If the request were "checkout master^0 first" I would understand.  The
> > > precondition for the second test will be different depending on the first
> > > one succeeds or not.  Perhaps that is what Clemens meant?
> > > 
> > Perhaps, but if so, I'm still not sure how a checkout of empty-branch2^0 affects
> > these tests at all, nor do I grok the relevance to ensuring that the HEAD commit
> > wasn't removed (as AIUI, cherry pick never does that anyway).  Clement, can you
> > clarify your thoughts here please?
> 
> It seems that I was implying a lot more than I realized. What I meant
> was that master and empty-branch2 are equivalent for the purposes of
> that test (empty-branch2^ also is a non-empty commit [*1*]), but while
> master is a moving target, empty-branch2 is untouched. 
> 
for the purposes of the --keep-redundant-commits however, the target is
irrelevant.  The only requirement is that we cherry-pick a commit that is
guaranteed to become empty when applied.  We certainly could do that on empty
branch2, but theres no advantage to doing so, and given that every other test
attempts to cherry-pick to master, I rather like the consistency.

> However, I just notice that empty-branch2 is also the root commit, so
> maybe this will not work after all. But that should be easy to fix.
It is easy to fix, given your clarified description above, its just that IMO,
its not broken.

> 
> And now I am also wondering why we have two tests for cherry picking an
> empty commit without --allow-empty (the one that you added and the one
> that was there before). Is the non-ff part significant and if so, how?
> And why don't we need to test fast-forward cherry-pick with
> --allow-empty?
the difference is that the initial empty-branch doesn't just hold an empty
commit, but also contains no commit log entry on that empty commit, which
git-cherry-pick errors out on in the 'cherry-pick a commit with an empty
message' test, and the 'cherry-pick an empty commit' test.
I could modify the --allow-empty switch to include commits with
no log message, but I didn't want to open that can of worms.

The test separation beyond that is the difference between a failing and a
successful test with an empty commit that still has a changelog entry.

As far as the ff logic goes.  If a cherry pick qualifies for fast forwarding,
then empty commits are automatically are allowed already.  Its only if a cherry
pick cannot be fast forwarded that its empty status is considered, hence the
creation of the 'fourth' commit in the new tests to ensure that the cherry pick
doesn't qualify as a fast forward.

Neil
 
> 
