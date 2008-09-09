From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 15:59:31 -0400
Message-ID: <20080909195930.GA2785@coredump.intra.peff.net>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:00:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd9OF-0004MK-7T
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbYIIT7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 15:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756831AbYIIT7e
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 15:59:34 -0400
Received: from peff.net ([208.65.91.99]:1908 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756407AbYIIT7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 15:59:33 -0400
Received: (qmail 18100 invoked by uid 111); 9 Sep 2008 19:59:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Sep 2008 15:59:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2008 15:59:31 -0400
Content-Disposition: inline
In-Reply-To: <20080909194354.GA13634@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95420>

On Tue, Sep 09, 2008 at 09:43:54PM +0200, Stephen R. van den Berg wrote:

> >Besides I very much prefer using 'origin <sha1> <sha2>' (as proposed
> 
> The simplicity sounds inviting.  I'd like to hear from others who have
> more experience (than I have) with the git vs. changeset paradigms about
> this.  This allows a bit more flexibility in specifying the origin, the
> question is if it's needed.

One thing to keep in mind is that you are not just proposing some new
behavior for a command, but rather a new header for the data structure
that we will live with from now until eternity. So I think it makes
sense to allow the general case even if nobody is generating it yet, if
there is some chance that it may be useful for somebody to generate in
the future.

And yes, you can get _too_ general to the point where your semantics
become meaningless. But I don't think that is the case here. You are
defining the origin field as "by the way, the difference between state X
and state Y was used to make this commit". cherry-pick just happens to
make Y=X^, but something like rebase could use a series.

As for "git vs changeset": this is git. So you have a sequence of tree
states whether that is what you want or not. Thus you are specifying
the difference between _some_ pair of commits. I don't see any benefit
to restricting it to a commit and one of its parents.

> On the contrary, my current proposal only needs to verify the validity
> of a single commit, changing it like this will require the system to
> verify the validity of two commits.  Given the rareness of the origin
> links this will hardly present a problem, but it *does* increase
> the overhead in checking a bit.

Actually, it could decrease it. If I tell you that you must have "X" and
"X^2", then you could get away with just checking if you have "X". But
you might also want to check whether "X" even _has_ a second parent. And
that means not just looking up the object, but accessing it (resolving
deltas if need be, uncompressing, parsing the object).  With "X" and
"Y", it is just two object lookups.

Now obviously you don't have to be quite so careful in the "hash plus
parent" case. And if you are going to _do_ anything with the origin
field, you will end up accessing those objects anyway. But in that case,
you end up with the same number of lookups and accesses anyway: 2 of
each.

> >On the other hand this leads to the following question: what happens
> >if you cherry-pick or revert a commit which has its own 'origin'
> >links?
> 
> Nothing special.  cherry-pick/revert behave as if the existing origin links
> were not present in the first place.

I think that is smart; if somebody wants to drill down into the history
of origin links, they can do so at lookup time.

-Peff
