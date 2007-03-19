From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 23:53:51 -0400
Message-ID: <20070319035351.GI20658@spearce.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org> <20070319024744.GD11371@thunk.org> <20070319025603.GG20658@spearce.org> <20070319032130.GF11371@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:54:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8wa-0000vH-2F
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965360AbXCSDx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965452AbXCSDx4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:53:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49899 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965360AbXCSDxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:53:55 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HT8wH-0000Gu-AI; Sun, 18 Mar 2007 23:53:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C681820FBAE; Sun, 18 Mar 2007 23:53:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070319032130.GF11371@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42580>

Theodore Tso <tytso@mit.edu> wrote:
> So I dug a little more deeply, and the problem is that the reflog for
> master was getting updated, but not the reflog for HEAD, and that's
> what "git reflog" was showing --- hence my confusion.
> 
> What are the rules for when HEAD's reflog should get updated, and is
> this documented anywhere in the man pages?

It is buried down in write_ref_sha1 (in refs.c).  The rule is if the
name of the ref given to us for update does not match the actual
ref we are about to change, we log to both the original ref name
given and the actual ref name.

This handles the case of HEAD being a symref to some actual branch;
we update the HEAD reflog and the actual branch reflog whenever
someone updates HEAD.  Which is what we are usually doing from
tools like git-checkout.

receive-pack isn't updating the HEAD reflog as its updating the
actual branch, not HEAD.  If you pushed instead to HEAD you should
see the HEAD reflog entry too.

Its a little ugly here as I'm not sure we should always update
HEAD's reflog if HEAD points at a branch we are actually updating.
Maybe we should though in receive-pack ?

-- 
Shawn.
