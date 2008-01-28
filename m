From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Mon, 28 Jan 2008 03:12:58 -0500
Message-ID: <20080128081258.GE24004@spearce.org>
References: <479D5611.4010205@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 09:13:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJP7Z-0004ZZ-S4
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 09:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbYA1INF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 03:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbYA1INE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 03:13:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43957 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbYA1IND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 03:13:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJP6x-0005mw-3m; Mon, 28 Jan 2008 03:12:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CAD7420FBAE; Mon, 28 Jan 2008 03:12:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <479D5611.4010205@vilain.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71861>

Sam Vilain <sam@vilain.net> wrote:
...
> The key idea is to reject pushes if the PGP signature cannot be verified.
...
> When heads are pushed, the signed tags that are moved from refs/heads/
> foo can be saved in an "archive" tag space, such as under refs/audit/
> KEYID/ - this will allow, in the case of a network of git servers, for
> servers to synchronise from each other, even when they
> don't trust each other.

This is certainly interesting.  It would benefit from the recursive
locking scheme we were talking about for the update hook, which
someone (Steven Grimm?) wanted so they could execute git-svn
transparently during push and have the update hook change the ref
instead of receive-pack.

The downside to this is you have to tag everything before you push
it, so you need some sort of wrapper around git-push.  That isn't
as hard as it sounds for the command line case, but it does make
things more difficult for a usage from say git-gui.  :)

I was also thinking about using GPG to sign the command packets
being sent between send-pack and receive-pack.  If the GPG signature
for that set of packets is good and a known key then the update is
allowed to continue.  This avoids the mess of needing to run git-tag
locally before push, and of needing to "unwrap" the temporary tag
in the receiving repository, but it adds yet another extension to
the send-pack/receive-pack protocol.
 
> This does force potential contributors to get PGP keys, and get them
> signed - but that seems to me to be a reasonable barrier of entry and
> may even help drive some PGP adoption.

In many cases today such contributers would have been forced to get
an SSH account on the server they want to push to.  Getting an SSH
account configured and a key installed may be more difficult than
generating a PGP key pair and emailing in the public key.

Of course the PGP based system is nicer in that the administrator
might get a public key that has been signed by others he trusts,
and thus is more readily able to verify that the contributor is
who they think it is.


To be perfectly honest, in a wide open source community I think
the truely distributed nature of development like the linux kernel
or git itself uses works very well.  Development schedules aren't
organized into "next 30 minutes", "next 4 hours", and "next week".

Peer review and community acceptance of changes is a very important
concept.  Blindly accepting changes into a tree because of a PGP
signature/SSL certificate/SSH key isn't really the norm, and is
far from the best solution.  We've all posted cr**p^Wless-than-
the-best-code to this list before, and yet many of us would have
"committer access" to the git tree under a centralized model.

I'm happy my changes aren't accepted just because I signed them.
Its better that Linus/Nico/Dscho/Junio/you/et.al. have looked at
them and also felt they were worthwhile.


But in a smaller business type setting, where there's under 100
employees working, odds are you've already created the user account
on systems, and physically passed the initial password via a sticky
note after checking the person's government issued IDs.  In such a
setting having yet another authentication system (PGP keys) is just
yet more work for the already over worked/under appreciated IT staff.

-- 
Shawn.
