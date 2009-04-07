From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 07 Apr 2009 13:59:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904071348420.6741@xanadu.home>
References: <20090404220743.GA869@curie-int>
 <m3tz5023rq.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <200904071537.04225.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 20:01:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrFc3-0003pw-Qy
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 20:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758913AbZDGR76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 13:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758632AbZDGR75
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 13:59:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51266 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758195AbZDGR75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 13:59:57 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHQ004V9SM1CDS0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 07 Apr 2009 13:58:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200904071537.04225.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115972>

On Tue, 7 Apr 2009, Jakub Narebski wrote:

> On Tue, 7 Apr 2009, Nicolas Pitre wrote:
> > Having git-rev-list consume about 2G RSS for the enumeration of 4M 
> > objects is simply inacceptable, period.  This is the equivalent of 500 
> > bytes per object pinned in memory on average, just for listing object, 
> > which is completely silly. We ought to do better than that.
> 
> I have thought that the large amount of memory consumed by git-rev-list
> was caused by not-so-sequential access to very large packfile (1.5GB+ if
> I remember correctly), which I thought causes the whole packfile to be
> mmapped and not only window, plus large amount of objects in 300MB+ mem
> range or something; those both would account for around 2GB.

The pack has not to be mapped all at once.  At least on 32-bit machines 
the total pack mappings cannot exceed 256MB total by default.  On 64-bit 
machines the default is 8GB which might not work very well if total 
amount of RAM is lower than that.

Another consideration is the object layout in a pack.  Currently we have 
tree and blob objects mixed together so to have sequential pack access 
when performing a checkout.  Maybe having trees packed together would 
help a lot with object enumeration as the blobs have not to be mapped at 
all.  Remains to see how that might impact other operations though.

> Besides even if git-rev-list wouldn't take so much memory, object
> enumeration caching would still help with CPU load... admittedly less.

Yes, but let's not lose sight of all the inconvenients associated with 
extra caching.  If we can get away without it then all the better.


Nicolas
