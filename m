From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC PATCH 1/2] Replace memset(0) with static initialization where
 possible
Date: Thu, 09 Oct 2008 15:47:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810091534430.26244@xanadu.home>
References: <NveF6_7LIvvEmRZEvLeTO5lw7EzzmOQkz1WGEMYGSFKDWqSwAeLwBw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:49:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko1Vn-0008Ol-DB
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 21:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756577AbYJITsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 15:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755683AbYJITsO
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 15:48:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10901 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbYJITsN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 15:48:13 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K8H00JHJLNS4PI1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Oct 2008 15:47:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <NveF6_7LIvvEmRZEvLeTO5lw7EzzmOQkz1WGEMYGSFKDWqSwAeLwBw@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97878>

On Thu, 9 Oct 2008, Brandon Casey wrote:

> "Possible" benefits:
> 
>   1) more concise, so it improves readability in most cases
>   2) gives compiler more flexibility when optimizing

Beware beware.  At some point this wasn't a gain at all with some gcc 
versions as it was stupid enough to construct a temporary object on the 
stack corresponding to "{ 0, }" and afterward do the assignment by 
*copying* this object to a different stack slot corresponding to the 
actual variable instead of constructing the initial value in place.

Also note that, on the other hand, gcc is smart enough to optimize a 
memset() using a constant size and value already by doing appropriate 
code replacement inline.  I've also seen cases where gcc did the 
opposite and replaced an explicit assignment like your patch does with 
an actual call to memset() when optimizing for size.

So when claiming flexibility for the compiler to better optimize things, 
please make sure this is really what is happening through assembly dump 
inspection.


Nicolas
