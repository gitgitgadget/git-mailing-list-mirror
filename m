From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 19:12:24 -0700
Message-ID: <20090825021223.GE1033@spearce.org>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home> <alpine.LFD.2.00.0908232320410.6044@xanadu.home> <7vocq5q0j7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0908240144530.28290@iabervon.org> <alpine.LNX.2.00.0908242212260.26869@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0908242001250.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 04:12:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MflWO-00056a-RE
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 04:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZHYCMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 22:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbZHYCMW
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 22:12:22 -0400
Received: from george.spearce.org ([209.20.77.23]:44450 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbZHYCMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 22:12:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 15D76381FD; Tue, 25 Aug 2009 02:12:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908242001250.6044@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126989>

Nicolas Pitre <nico@cam.org> wrote:
> Well... Johan Herland says he has to deal with repositories containing 
> around 50000 refs.  So in that case it is certainly a good idea not to 
> send the whole 50000 refs back if only one or two (or a hundred) need to 
> be updated.  And quickfetch() won't help in that case since its purpose 
> is only to determine if there is anything at all to update.
...
> 50000 refs * 45 bytes each = 2.25 MB.  That's all wasted bandwidth if 
> only one ref needs updating.

Not just Johan Herland.  Gerrit Code Review creates a new ref
for every patch proposed for review.  Imagine taking every email
message on git ML that has "[PATCH]" in the subject, and creating
a new ref for that in a git.git clone.

We aren't quite at the 50k ref stage yet, but we're starting to
consider that some of our repositories have a ton of refs, and
that the initial advertisement for either fetch or push is horrid.

Since the refs are immutable I could actually teach the JGit
daemon to hide them from JGit's receive-pack, thus cutting down the
advertisement on push, but the refs exist so you can literally say:

  git fetch URL refs/changes/88/4488/2
  git show FETCH_HEAD

to inspect the "v2" version of whatever 4488 is, and if 4488 was
the last commit in a patch series, you'd also be able to do:

  git log -p --reverse ..FETCH_HEAD

to see the complete series.

Given how infrequent it is to grab a given change is though, I'm
starting to consider either a protocol extension that allows the
client to probe for a ref which wasn't in the initial advertisement,
or take it on a command line flag, e.g.:

  git fetch --uploadpack='git upload-pack --ref refs/changes/88/4488/2' URL refs/changes/88/4488/2

Personally I'd prefer extending the protocol, because making the
end user supply information twice is stupid.

I don't know enough about Johan's case though to know whether or
not he can get away with hiding the bulk of the refs in the initial
advertisement.  In the case of Gerrit Code Review, the bulk of the
refs is under refs/changes/, only a handful of things are under the
refs/heads/ and ref/tags/ namespace, and most fetches actually are
for only refs/heads/ and refs/tags/.  So hiding the refs/changes/
namespace would make large improvement in the advertisement cost.

-- 
Shawn.
