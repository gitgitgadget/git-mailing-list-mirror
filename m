From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 00/20] PackWriter, first usable attempt
Date: Mon, 16 Jun 2008 01:19:27 -0400
Message-ID: <20080616051927.GV11793@spearce.org>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 07:20:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K878k-0006fa-OX
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 07:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbYFPFTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 01:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYFPFTc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 01:19:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49128 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYFPFTb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 01:19:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K877o-0005wF-QE; Mon, 16 Jun 2008 01:19:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8269A20FBAE; Mon, 16 Jun 2008 01:19:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85164>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> At first, some stuff was still missing to produce packs, mostly
> raw-data access related and ObjectWalk related.

I'm glad it turned out to be so little missing actually.  Reusing
ObjectWalk saved a lot of code in the pack writer, and for the most
part our existing data access structures were already well organized.

It is too early to say how the performance is going to work, but
object packing with delta reuse can be difficult and I'm happy to
see that our abstractions more-or-less supported it.  Tuning can
come later, once we better understand the code, and have something
for end-users to complain (or praise) about.
 
> Finally, we've got some support for pack writing! It's not that
> power that C git version offers, but something usable. Delta
> generation is not supported. Although we can reuse deltas and objects,
> and support all other (I hope) options of git-pack-objects directly or
> indirectly, most importantly --thin.
> 
> Pack writing and some other features are tested, seem to work.
> 
> This implementation of packing is not a very valuable thing directly
> (achieving efficient storage), however it's a base for enhancements
> and can be used for sending packs over net (with some assumptions).
> It's more a "repacking" than "packing" tool.

Yup.  The critical part here is jgit can now format a pack file,
which means we can now actually implement native push over the
local pipe (to fork+exec'd git-receive-pack) or over SSH.  That
is one of the major missing features in the Eclipse plugin, so
this is a huge milestone for us.  Thank you Marek.

> So... I'm switching now to push implementation. If time allows,
> delta-algorithms will be added later.

Yay.

Native push protocol support at this point is much more important
than delta generation.  Although delta generation is one of the
key features that makes git so damn efficient it is pointless if we
cannot actually communicate with a remote repository to send them
our changes.  Early adopters of the push support coming from this
plugin can at least use it on local area networks, where bandwidth
is not (usually) a limiting factor.

>  28 files changed, 2258 insertions(+), 73 deletions(-)

Nice to see it didn't take that much code either.

-- 
Shawn.
