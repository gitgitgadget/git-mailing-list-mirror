From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 15:11:47 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802141501420.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz>
 <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
 <alpine.LSU.1.00.0802101640570.11591@racer.site>
 <alpine.LFD.1.00.0802101445430.2732@xanadu.home>
 <47B4996B.4000900@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Holesovsky <kendy@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Feb 14 21:12:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPkRk-0006XR-LF
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 21:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567AbYBNUMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 15:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756736AbYBNUME
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 15:12:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10172 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019AbYBNUMC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 15:12:02 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW80089OW3NMGS0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Feb 2008 15:11:47 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <47B4996B.4000900@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73911>

On Thu, 14 Feb 2008, Brandon Casey wrote:

> I have successfully repacked this repo a few times on a 2.1GHz system 
> with 16G.
> 
> The smallest attained pack was about 1.45G (1556569742B).
> 
[...]
> 
> * Multi threaded (250m window)
> [pack]
>         threads = 4
>         windowmemory = 250m
>         compression = 9
> [repack]
>         usedeltabaseoffset = true
> 
> 	pack size: 1767405703
> 	time: 3 hours
> 
> 	First >99% took 50min. Last 10000 objects took 2hours.

Right.  That's because the algorithm to distribute the load between 
threads ends up stealing work from other threads whenever a thread is 
done with its own share.  So the easy objects are quickly done with by a 
few threads until they all converge onto the hard ones.  In the non 
threaded case, the slow down ocurs around 12%.

It looks like those hard objects are huge binary blobs.  If they could 
be removed from the repository entirely and regenerated as needed 
instead of being carried around then I expect the repository size would 
fall below the 500MB mark.


Nicolas
