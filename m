From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: push fails with unexpected 'matches more than one'
Date: Fri, 12 Oct 2007 23:21:00 -0400
Message-ID: <20071013032100.GK27899@spearce.org>
References: <11921723791817-git-send-email-prohaska@zib.de> <91A04390-89B2-47B8-9B61-7C7E652670AE@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Oct 13 05:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgXdl-0007kp-7U
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 05:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbXJMDVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 23:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbXJMDVF
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 23:21:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48181 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbXJMDVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 23:21:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IgXYX-0007ol-2n; Fri, 12 Oct 2007 23:20:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4877420FBAE; Fri, 12 Oct 2007 23:21:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <91A04390-89B2-47B8-9B61-7C7E652670AE@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60716>

Steffen Prohaska <prohaska@zib.de> wrote:
> I read carefully through the documentation of git-send-pack and
> git-rev-parse. The current implementation of git-send-pack is in line
> with the documented behaviour, as is the implementation of git-rev- 
> parse.
> 
> So formally everything is correct.
> 
> But it is completely against my expectation that git-push <remote>  
> <head>
> can successfully resolve a <head> that git-rev-parse fails to parse. I
> understand that refs are not revs ;). But nonetheless, I'd expect that a
> local ref that cannot be parsed by git-rev-parse should also fail to be
> pushed by git-send-pack. I didn't expect that git-send-pack would locate
> <head> as someprefix/<head>.
> 
> Why is my expectation wrong?
> Or is the current specification of git-send-pack's ref parsing wrong?

I think its a bug.  But I didn't write the original code.

Meaning I think what happened here was someone wanted to enable
git-send-pack to match "master" here with "refs/heads/master" on
the remote side.  One easy way to do that was to see if any ref
ended with "/master", as that was what the ref here was called.

Way back when that code was written most Git repositories probably
only ever had that one branch anyway, or maybe two (refs/heads/master
and refs/heads/origin) so matching the trailing suffix never came
up as a bug.  Nobody ever had two refs that could possibly match.

Then the documentation got expanded to actually document the behavior
that git-send-pack implemented.  Unfortunately that codified the
bug as documented behavior.


So I agree with you Steffen, this is a bug in send-pack, and I run
up against it every once in a while.  I've specifically told my
coworkers "NEVER, EVER, EVER, create a branch called 'master' that
isn't exactly refs/heads/master OR ELSE I WILL COME BEAT YOU WITH A
CLUE STICK".  They still create "refs/heads/experiments/master".
*sigh*.

I think we should fix it.  Anyone that is relying on "git push
$url master" to resolve to "refs/heads/experimental/master" on the
remote side is already playing with fire.  But Junio is (rightfully
so) very conservative and doesn't like to break a user's scripts.
We may not be able to fix this until Git 1.6.

-- 
Shawn.
