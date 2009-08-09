From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Sun, 9 Aug 2009 15:42:12 +0200
Message-ID: <c77435a80908090642g6d473c02o2e36a5a035e03b87@mail.gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private>
	 <4A7AEFA8.5010001@drmicha.warpmail.net>
	 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
	 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
	 <4A7B95A8.2010000@vilain.net>
	 <alpine.LFD.2.00.0908070031160.16073@xanadu.home>
	 <alpine.DEB.1.00.0908070806350.8306@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0908071010580.16073@xanadu.home>
	 <alpine.DEB.1.00.0908081709380.8306@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0908082147480.32635@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 15:42:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma8fF-0007iu-Cl
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 15:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbZHINmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 09:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbZHINmN
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 09:42:13 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:37193 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbZHINmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 09:42:12 -0400
Received: by ey-out-2122.google.com with SMTP id 9so752152eyd.37
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vFZLW9Pxe6OCysgSVEPXHfLOnp/bEVl3UIPNXZyXC3Y=;
        b=Qvn4QuzQOEJ+bW9S1m2UC3dRt3LI6U/lWRSd3xG4QK7PtS2kcBTORBuAkYzm+K6vdM
         FwFCTAB9IszIcV+E3pbJ/yUG10idpWPMOeIzrStkVEqpNRIkUOVGKVNrDT/EEFMS2b+F
         cm4rKauOMO1LVou90Xcs/99rFo+ovFTbIbNtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v0rOWJsLvAmCFzpvZE7HKnqSLADYxfs4O0pcRHZkkirgIchjlWuLdn36A8GvS31kYQ
         /jnooCd+zh5wQ7Yqa+AbMG9F0coJp6HJ54X+um8hf3sMmds/XQO7qwuphoy/gwrPCvWs
         QBw1yZoLiN6JwFSNtHR/GmF+/uzR3YN92afeI=
Received: by 10.216.8.65 with SMTP id 43mr683064weq.168.1249825332378; Sun, 09 
	Aug 2009 06:42:12 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908082147480.32635@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125344>

I can see the logic behind Johannes's ideas, but I'm still not sure
it'd be a great modification.  If you wanted to associate revision
caching much more strongly with packs, then packs and slices could be
merged reasonably well.  Say you just attached the actual slice data
at the end of the pack, then stored offsets of the slice payload in
the pack index.  Since you'd (presumably) have to search the index for
the object anyway, you wouldn't have to deal with searching a
rev-cache index on top of that (although it's not exactly unoptimized
now).

However, that would sorta be preemptively limiting rev-cache to
pack-related optimizations.  I mean at the moment that's the main
target, but it could be improved in the future to be more relavant to
other operations as well.  Leaving the rev-cache as a seperate system
would keep both it and packing much more flexible, and open to
longer-term developments.

>I haven't read the side of the patch that _uses_ the information stored in
>the rev-cache to figure out what it optimizes and what its limitations are
>(e.g. how it interacts with pathspecs).  Perhaps the rev-cache may turn
>out to be _only_ useful for pack-objects and nothing else, in which case
>we may not care about standalone version of rev-cache generator after all.

rev-cache's cache slice traversal basically emulates git's revision
walker, on a smaller scale.  At the moment it only really handles date
limiting (and obviously slop stuff) so it's not used for any pruning.
That's not to say it couldn't be updated in the future though.
