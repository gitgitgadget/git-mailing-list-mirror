From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long &quot;resolving deltas&quot; phase
Date: Wed, 07 Apr 2010 10:40:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004071022140.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
 <4BBB53F5.9010106@op5.se> <alpine.LFD.2.00.1004061702340.7232@xanadu.home>
 <loom.20100407T112028-388@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:40:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWQk-000766-H3
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626Ab0DGOk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 10:40:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13809 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553Ab0DGOk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 10:40:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0I000VYGRGP2L0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Apr 2010 10:40:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <loom.20100407T112028-388@post.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144227>

On Wed, 7 Apr 2010, Marat Radchenko wrote:

> Nicolas Pitre <nico <at> fluxnic.net> writes:
> > The "Resolving deltas" is performed locally, when Git is actually 
> > expanding all the deltas in the received pack to find the actual SHA1 of 
> > the resulting object in order to create the pack index.
> Is there any technical limitation why it cannot be done simultaniously with
> fetch (piped or whatever), instead of a separate step after fetch?

The non delta compressed objects are indexed simultaneously as they're 
received on the wire.  However this is way suboptimal to do that for 
delta objects because

1) The base object needed to resolve a given delta object might not have 
   been received yet.  This means in this case that the delta will have 
   to be resolved later anyway, and finding out if a just received 
   object might be a base object for previously received objects is 
   rather costly, and even impossible if that potential base object is 
   itself a delta.  So it is best to figure out the delta dependencies 
   only once at the end of the transfer.

2) When resolving deep delta chains, it is best to start from the root 
   i.e. create the result from a delta object and resolve all deltas 
   with this result for base recursively, not to expand deltas 
   repeatedly which would turn this process into exponential CPU usage.  
   Again this can be done only when all delta objects have been 
   received.


Nicolas
