From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: warning: no common commits - slow pull
Date: Wed, 27 Feb 2008 19:43:13 -0500
Message-ID: <20080228004313.GQ8410@spearce.org>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <200802261438.17014.lenb@kernel.org> <7vir0byoc2.fsf@gitster.siamese.dyndns.org> <7voda2yksf.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271411280.19665@iabervon.org> <7vskzeruit.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271605540.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Len Brown <lenb@kernel.org>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWt3-0007CV-JO
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759107AbYB1Anw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 19:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758999AbYB1Anw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:43:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36237 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758926AbYB1Anv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 19:43:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JUWrY-0006wL-RQ; Wed, 27 Feb 2008 19:43:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F1FE920FBAE; Wed, 27 Feb 2008 19:43:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0802271605540.19665@iabervon.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75334>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Wed, 27 Feb 2008, Junio C Hamano wrote:
> > 
> > I think we can teach the upload-pack side to be more helpful and
> > with a protocol extension to send tag objects that are pointing
> > at commits that will be included in the result, or something
> > like that, though.  But that is outside the scope of 1.5.5; it
> > would be a moderate to large protocol surgery, and I suspect it
> > might even have to affect pack-objects.
> 
> Using a single connection, either by just telling the remote that you want 
> to autofollow tags, and it should therefore include any tags that point to 
> any objects it includes,

I agree its outside of 1.5.5, as we'd all like to see 1.5.5 happen
soon, but it could be 1.5.6 material, especially if someone starts
working on it sooner rather than later.

Its actually probably not that difficult to implement.  We'd just
want to include a size threshold, to prevent the client from
suddenly receiving a 1M tag (with say a build log embedded in it)
on an otherwise 100K transfer.  Autofollowing by having the remote
include the tags in the pack and send to the client would be more
efficient for both sides then autofollowing with a second set of
ref requests, even if we are keeping the current connection open.

I'll try to work up a prototype of this soon, say in the next week.
Obviously not for 1.5.5 but no reason to wait for the 1.5.6/1.6.0
window to open before developing it.  I think its a better approach
then supporting a second set of ref requests on the same connection.

_IF_ we are going to support a second set of ref requests on the
same connection then we should also support being able to switch
to another repository.  I have 40 some odd repositories at day-job
that a shell script loops over and does fetches in, over SSH.
Setting up and tearing down 40+ SSH connections (especially with tag
following!) sucks[*1*].  I think the X.org folks are in a similar
position as me[*2*].
 
> If the situation is:
> 
>       T - tag     master
>      /           /
> O - A - O - O - B
> 
> the first fetch will see:
> 
> tag: T
> tag^{}: A
> master: B
> 
> The issue is that our starting set for our side of the negotiation is our 
> current refs, which doesn't include A. I'm suggesting that, for the 
> purposes of autofollow, A should be included.

I agree.  This is probably easier than coding the protocol extension above.
:-)


*1* I know all about the SSH connection sharing feature, it is
    unsupported on Cygwin.  I'm on Cygwin at day-job.  So that is
    a no-go.

*2* X.org users are more likely to be on a UNIX platform where the
    OpenSSH connection share code works correctly.

-- 
Shawn.
