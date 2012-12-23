From: Jeff King <peff@peff.net>
Subject: Re: Missing Refs after Garbage Collection
Date: Sat, 22 Dec 2012 20:04:27 -0500
Message-ID: <20121223010427.GA2878@sigill.intra.peff.net>
References: <C0A16EC8-D05A-41D0-BF2A-34BF3B1B839E@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Earl Gresh <egresh@codeaurora.org>
X-From: git-owner@vger.kernel.org Sun Dec 23 02:14:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tma92-0000AZ-TA
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 02:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab2LWBEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 20:04:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34081 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344Ab2LWBEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 20:04:31 -0500
Received: (qmail 7221 invoked by uid 107); 23 Dec 2012 01:05:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Dec 2012 20:05:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Dec 2012 20:04:27 -0500
Content-Disposition: inline
In-Reply-To: <C0A16EC8-D05A-41D0-BF2A-34BF3B1B839E@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212074>

On Fri, Dec 21, 2012 at 05:41:43PM -0800, Earl Gresh wrote:

> I have observed that after running GC, one particular git repository
> ended up with some missing refs in the refs/changes/* namespace the
> Gerrit uses for storing patch sets. The refs were valid and should not
> have been pruned. Concerned about loosing data, GC is still enabled
> but ref packing is turned off. Now the number of refs has grown to the
> point that it's causing performance problems when cloning the project.
> 
> Is anyone familiar with git gc deleting valid references? I'm running
> git version 1.7.8. Have there been any patches in later git releases
> that might address this issue ( if it is a git problem )?

I have never seen deletion, but I did recently find a race condition
with ref packing that caused rewinds, where:

  1. Two processes simultaneously repack the refs.

  2. At least one process is using an "old" version of the pack-refs
     file. That is, it cached the packed refs list earlier in the
     process and is now rewriting it based on that cached notion.

  3. The first process takes the lock, packs refs, drops the
     lock, and then deletes the loose versions. The simultaneous packer
     then takes the lock, overwrites the packed-refs file with a stale
     copy from its memory, and then releases the lock. We're left with
     the stale copy in pack-refs, and deleted loose refs.

In my case, it looked like a rewind, because the stale, memory-cached
refs had the old version. But if you have a ref which was not previously
packed, it would appear to have been deleted.

The tricky thing about triggering this race is that step (2) needs a
process which has previously read and cached the packed-refs, and then
decided to pack the refs. The "git pack-refs" command does not do this,
because it starts, packs the ref, and exists. But processes which delete
a ref need to rewrite the packed-refs file (omitting the deleted ref),
and depending on the process, may have previously read and cached the
packed refs file. The obvious candidate is "receive-pack".

So this may be your culprit if:

  1. This is a repo people are pushing into via C git.

  2. You simultaneously run "git pack-refs" (or "git gc") while people
     may be pushing.

You mentioned Gerrit, so I wonder if people are actually pushing via C
git (I thought it used JGit entirely). Or perhaps JGit has the same bug.
My fix (which is not yet released in any git version) is here:

  http://article.gmane.org/gmane.comp.version-control.git/211956

-Peff
