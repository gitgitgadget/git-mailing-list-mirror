From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: resumable git-clone?
Date: Tue, 7 Aug 2007 23:59:46 -0400
Message-ID: <20070808035946.GP9527@spearce.org>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 05:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIciB-0007yU-LX
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 05:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934939AbXHHD7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 23:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934674AbXHHD7v
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 23:59:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49217 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934330AbXHHD7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 23:59:50 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IIchr-00040Q-JZ; Tue, 07 Aug 2007 23:59:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AB3AE20FBAE; Tue,  7 Aug 2007 23:59:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55298>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I was on a crappy connection and it was frustrated seeing git-clone
> reached 80% then failed, then started over again. Can we support
> resumable git-clone at some level? I think we could split into several
> small packs, keep fetched ones, just get missing packs until we have
> all.

This is uh, difficult over the native git protocol.  The problem
is the native protocol negotiates what the client already has and
what it needs by comparing sets of commits.  If the client says
"I have commit X" then the server assumes it has not only commit
X _but also every object reachable from it_.

Now packfiles are organized to place commits at the front of the
packfile.  So a truncated download will give the client a whole
host of commits, like maybe all of them, but none of the trees
or blobs associated with them as those come behind the commits.
Worse, the commits are sorted most recent to least recent.  So if
the client claims he has the very first commit he received, that
is currently an assertion that he has the entire repository.

I have been thinking about this resumable fetch idea for the native
protocol for a few days now, like since the last time it came up
on #git.

One possiblity is to have the client store locally in a temporary
file the list of wants and the list of haves it sent to the server
during the last fetch.

During a resume of a packfile download we actually just replay this
list of wants/haves, even if the server has newer data.  We also tell
the server which object we last successfully downloaded (its SHA-1).

The server would only accept the resumed want list if all of the
wants are reachable from its current refs.  If one or more aren't
then they are just culled from the want list; this way you can still
successfully resume a download of say git.git where pu rebases often.
You just might not get pu without going back for it.

If the server always performs a very stable (meaning we don't ever
change the sorting order!) and deterministic sorting of the objects
in the packfile then given the same list of wants/haves and a
"prior" point it can pickup from where it left off.

At worst we are retransmitting one whole object again, e.g. the
client had all but the last byte of the object, so it was no good.
I'm willing to say we do the full object retransmission in case the
object was recompressed on the server between the first fetch and
the second.  It just simplifies the restart.

Probably not that difficult.  The hardest part is committing to the
object sorting order so that when we ask for a restart we *know*
we didn't miss an object.

> I didn't clone via http so I don't know if http supports resumable.

This would have a better chance at doing a resume.  Looking at the
code it looks like we do in fact resume a packfile download if it
was truncated.

-- 
Shawn.
