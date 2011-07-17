From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git commit generation numbers
Date: 17 Jul 2011 14:27:43 -0400
Message-ID: <20110717182743.14423.qmail@science.horizon.com>
Cc: linux@horizon.com, torvalds@linux-foundation.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 20:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiW6e-0002Fr-9X
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 20:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab1GQS1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 14:27:45 -0400
Received: from science.horizon.com ([71.41.210.146]:50488 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754577Ab1GQS1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 14:27:45 -0400
Received: (qmail 14424 invoked by uid 1000); 17 Jul 2011 14:27:43 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177308>

> The thing I hate about it is very fundamental: I think it's a hack around a basic git
> design mistake. And it's a mistake we have known about for a long time.
> 
> Now, I don't think it's a *fatal* mistake, but I do find it very broken to basically
> say "we made a mistake in the original commit design, and instead of fixing it we
> create a separate workaround for it".
> 
> THAT I find distasteful. My reaction is that if we're going to add generation
> numbers, then were should just do it the way we should have done them originally,
> rather than as some separate hack.

There are a few design mistakes in git.  The way the object type
and size are prefixed to the data for hasing purposes, which prevents
aligned fetching from memory-mapped data in the hashing code, isn't too
pretty either.

But git has generally preferred to avoid storing information that can
be recomputed.  File renames are the big example.  given this, why the
heck store generation numbers?

They *can* be computed on demand, so arguably they *should*.  Cacheing is
then an optimization, just like packs, pack indexes, the hashed object
storage directories, and all that.


I'm in the "make it a cache" camp, honestly.  


For example, here's a different possible generation number scheme.
By making the generation number a cache, it becomes a valid alternative
to experiment with.

Simply store a topologically sorted list of commits.  Each commit's
position can serve as a generation number, and is greater than the
positions of all ancestors.  But by using the offset within the list,
the number is stored implicitly.

Generation numbers don't have to be consecutive as long as they're
correctly ordered, so you could, e.g. choose to make them unique.

I don't think this is actually worth it; I'm just using it as a
not-completely-insane example of a different design that nonetheless
achieves the same goal.

Why freeze this in the object format?
