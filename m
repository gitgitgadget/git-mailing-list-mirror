From: Mike Hommey <mh@glandium.org>
Subject: Re: Bug: Branch Deletion Doesn't Clean Up
Date: Thu, 4 Feb 2016 17:26:13 +0900
Message-ID: <20160204082613.GA14076@glandium.org>
References: <4AC354E1-9E78-42A8-9828-BF1C084A6CBB@me.com>
 <20160204075500.GA21161@sigill.intra.peff.net>
 <20160204081220.GA11434@glandium.org>
 <20160204081759.GA23259@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl Moskowski <kmoskowski@me.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 09:26:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFFY-0002dJ-MF
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 09:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbcBDI0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 03:26:40 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38792 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbcBDI0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 03:26:39 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aRFEz-0003gB-Hu; Thu, 04 Feb 2016 17:26:13 +0900
Content-Disposition: inline
In-Reply-To: <20160204081759.GA23259@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285411>

On Thu, Feb 04, 2016 at 03:17:59AM -0500, Jeff King wrote:
> On Thu, Feb 04, 2016 at 05:12:20PM +0900, Mike Hommey wrote:
> 
> > > > It seems like git branch -d ascend the hierarchy (up to
> > > > .git/refs/heads/), deleting any empty directories.
> > > 
> > > Yes, though it needs to be coupled with making the branch-creation
> > > process more robust to races (since we might create "refs/heads/foo" in
> > > order to make "refs/heads/foo/bar" while somebody else is deleting it to
> > > get rid of "refs/heads/foo/baz").
> > 
> > Can't we come up with a system that would update packed-refs directly
> > instead of creating files?
> 
> There are a few reasons not to:
> 
>   - it breaks backwards compatibility (unless we continue to create the
>     directory in order to put the dot-lock in it, but then I don't think
>     we've gained anything)

Is that the kind of backwards compatibility that matters, though? I
mean, I won't claim to know all the internals of how refs are used, but
you sound like the theoretical incompatibility would be two different
versions of git racing for update-ref on the same local repository.

Not that it would change anything about the other reasons below.

>   - the usual update method for packed-refs is to take a dot-lock, do a
>     whole-file update, and then atomically rename into place.  That
>     makes writing a ref O(# of refs) instead of O(1), and increases lock
>     contention on the packed-refs file.
> 
>   - if we abandon atomic renames as the update mechanism and just update
>     in place via lseek/write, then we need read-locking, or we need to
>     hope that a reader will never see a sheared write
> 
> But if we're willing to break compatibility, we should ditch packed-refs
> entirely and move to a _real_ concurrent database. And there is work
> underway already to do that (see David Turner's ref-backend-lmdb
> series).

Mike
