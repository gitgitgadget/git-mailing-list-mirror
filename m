From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git commit generation numbers
Date: 20 Jul 2011 18:16:32 -0400
Message-ID: <20110720221632.14223.qmail@science.horizon.com>
References: <alpine.LFD.2.00.1107201538590.21187@xanadu.home>
Cc: anthonyvdgent@gmail.com, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: linux@horizon.com, nico@fluxnic.net
X-From: git-owner@vger.kernel.org Thu Jul 21 00:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjf4N-0005Ko-J6
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 00:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab1GTWQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 18:16:36 -0400
Received: from science.horizon.com ([71.41.210.146]:10948 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751691Ab1GTWQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 18:16:34 -0400
Received: (qmail 14224 invoked by uid 1000); 20 Jul 2011 18:16:32 -0400
In-Reply-To: <alpine.LFD.2.00.1107201538590.21187@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177552>

> The alternative of having to sometimes use the generation number, 
> sometimes use the possibly broken commit date, makes for much more 
> complicated code that has to be maintained forever.  Having a solution 
> that starts working only after a certain point in history doesn't look 
> eleguant to me at all.  It is not like having different pack formats 
> where back and forth conversions can be made for the _entire_ history.

It seemed like a pretty strong argument to me, too.

> And if you don't care about graft/replace then the cached data is 
> immutable just like the in-commit version would, so there is no 
> consistency issues.  If you do care about graft/replace (or who knows 
> what other dag alteration scheme might be created in 5 years from now) 
> then a separate cache will be required _anyway_, regardless of any 
> in-commit gen number.

A possible workaround would be to keep track of the largest generation
number skew introduced by any graft, and add that safety factor into
the history-walking code, but that would be painful if you replace a
single large commit with an equivalent long development history, such
as adding a historical development tree behind a recently-cut-off one.
or development history You can do a workaround at the expense of ine

> Neither did I think about the actual cache format (I don't think that
> adding it to the pack index is a good idea if grafts are to be honored)
> which certainly has bearing on that fundamental question too.

I was thinking of something very close to the V2 pack format.
http://book.git-scm.com/7_the_packfile.html
A magic number, a 256-entry fanout table, a sorted list of 20-byte hashes,
followed by a matching list of 4-byte generation numbers.

Ending with a 20-byte hash of the replaces and grafts state that this
cache is valid for, and a hash of the cache itself.

A bit of code factoring should make it easy to share much of the code.


It would certainly be possible to share the SHA1 table in an existing
pack index and store the generation numbers of the base (no replacement)
case, but you'd have to store null values for all the non-commit objects.

That takes 4 bytes per object, while a separate list of commits
takes 24 bytes per commit.  A separate list is better if commits
are less than 1/6 of all objects.

Looking at git's own object database, we have:
 66125 blobs   (45.50%)
 49292 trees   (33.92%)
 29554 commits (20.33%)
   362 tags    ( 0.25%)
145333 total

So we're actually a bit over the 16.66% optimum. but it's not far enough
to be a real efficiency problem.
