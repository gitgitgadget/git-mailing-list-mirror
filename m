From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] avoid possible overflow in delta size filtering computation
Date: Wed, 25 Mar 2009 12:18:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903250936100.26337@xanadu.home>
References: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
 <86hc1hdcj1.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:20:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVpv-0006Q2-4f
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762618AbZCYQSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 12:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763256AbZCYQSO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:18:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12949 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763041AbZCYQSN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 12:18:13 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KH2005W9LA1LZU0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Mar 2009 12:18:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <86hc1hdcj1.fsf@broadpark.no>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114614>

On Wed, 25 Mar 2009, Kjetil Barvik wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On a 32-bit system, the maximum possible size for an object is less than 
> > 4GB, while 64-bit systems may cope with larger objects.  Due to this 
> > limitation, variables holding object sizes are using an unsigned long 
> > type (32 bits on 32-bit systems, or 64 bits on 64-bit systems).
> >
> > When large objects are encountered, and/or people play with large delta 
> > depth values, it is possible for the maximum allowed delta size 
> > computation to overflow, especially on a 32-bit system.  When this 
> > occurs, surviving result bits may represent a value much smaller than 
> > what it is supposed to be, or even zero.  This prevents some objects 
> > from being deltified although they do get deltified when a smaller depth 
> > limit is used.  Fix this by always performing a 64-bit multiplication.
> >
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> 
>   I added this patch and rerun the 2 test cases form the table where
>   --depth is 20000 and 95000, and got the following result:
> 
>     --depth=20000 => file size: 19126077  delta: 73814
>     --depth=95000 => file size: 19126087  delta: 73814
> 
>   So, it seems that this patch almost fixed the issue.  But notice that
>   the pack file was 10 bytes larger for the --depth=95000 case.
> 
>   I made a small perl script to compare the output from 'git verify-pack
>   -v' of the 2 idx/pack files, and found the following difference(1)
>   (first line from --depth=20000 case, second from --depth=95000):
> 
>   fe0a6f3e971373590714dbafd087b235ea60ac00  tree   9  19  18921247  731  96a3ec5789504e6d0f90c99fb1937af1ebd58e2d
>   fe0a6f3e971373590714dbafd087b235ea60ac00  tree  20  29  18921247  730  12e560f7fb28558b15e3a2008fba860f9a4b2222

OK.  Apparently, a different base object for that one delta was chosen 
between those two runs.

Is your machine SMP?


Nicolas
