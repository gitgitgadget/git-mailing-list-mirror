From: Jeff King <peff@peff.net>
Subject: Re: Git shouldn't allow to push a new branch called HEAD
Date: Mon, 14 Nov 2011 06:16:59 -0500
Message-ID: <20111114111659.GC10847@sigill.intra.peff.net>
References: <1318591877.2938.20.camel@mastroc3.mobc3.local>
 <1318592153.2938.21.camel@mastroc3.mobc3.local>
 <1321261662.2941.13.camel@mastroc3.mobc3.local>
 <4EC0F15A.9010502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 14 12:17:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPuXE-00069H-SO
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 12:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab1KNLRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 06:17:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40996
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201Ab1KNLRD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 06:17:03 -0500
Received: (qmail 28158 invoked by uid 107); 14 Nov 2011 11:17:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 06:17:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 06:16:59 -0500
Content-Disposition: inline
In-Reply-To: <4EC0F15A.9010502@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185377>

On Mon, Nov 14, 2011 at 11:45:46AM +0100, Michael Haggerty wrote:

> The whole time, victim's .git/HEAD contains "ref: refs/heads/master",
> .git/refs/remotes/origin/HEAD contains "ref:
> refs/remotes/origin/master", and its packed-refs file contains
> 
> # pack-refs with: peeled
> 4c9ebba3c0618bd6238a810013da4a8cd4f2213b refs/remotes/origin/master
> 
> In "remote.git", refs/heads/HEAD contains not a symbolic reference but
> the explicit SHA1 "4c9ebba...".  This is of course not affected by
> running "git fetch" in the "victim" tree.  Deleting this file makes the
> problem go away.
> 
> 
> Given that this problem seems to be in the remote protocol rather than
> in the refs API, I think I'll stop working on this.  I hope that my
> observations are helpful to somebody.

I didn't recreate the test situation and look closely, but my impression
is that this isn't a code bug at all, but rather a design problem in the
way we store remote namespaces. That is, we make "refs/remotes/foo/HEAD"
a symbolic ref with special meaning, but then fetch into it from the
remote's refs/heads namespace, writing remote's HEAD branch into
whatever our HEAD symref points to.

So one solution is to block fetching of remote branches called HEAD
(which I would be OK with). But another is to use a more sensible layout
for representing the remote refs, like:

   refs/remotes/origin/HEAD            (a symbolic ref)
   refs/remotes/origin/heads/master
   refs/remotes/origin/tags/v1.0

etc. Then the namespaces are properly separated, and the magic remote
"HEAD" symref is not in the way.

Obviously there's a lot more to it than just tweaking the default fetch
refspecs. The ref lookup rules need to be changed to take this into
account. There was some discussion about this over the summer (under the
subject of possible "1.8.0" changes), but I don't think any work has
been done.

-Peff
