From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sat, 26 May 2007 22:43:36 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705262223540.3366@xanadu.home>
References: <20070526052419.GA11957@spearce.org>
 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 04:43:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs8jY-0008I2-Ri
	for gcvg-git@gmane.org; Sun, 27 May 2007 04:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbXE0Cnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 22:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbXE0Cno
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 22:43:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43919 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbXE0Cno (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 22:43:44 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIO00BSSI8ONH30@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 26 May 2007 22:43:36 -0400 (EDT)
In-reply-to: <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48511>

On Sat, 26 May 2007, Dana How wrote:

> I think there are two interesting strategies compatible
> with maximally-informative timestamps:
> 
> (1) git-repack -a -d repacks everything on each call.  You would need:
> (1a) Rewrite builtin-pack-objects.c so only the object_ix hash
>       accesses the "objects" array directly, everything else
>       goes through a pointer table.
> (1b) Sort the new pointer table by object type,  in order
>       tag -> commit -> tree -> nice blob -> naughty blob.
>      The sort is stable so the order within each group is unchanged.

This is not a good idea in general for runtime access to the pack.  If 
you consider a checkout, the commit object 
is looked up, then the root tree object, then each tree entry is 
recursively looked up.  Right now the way the objects are laid out, the 
most recent commit will have all its objects contiguously found in the 
pack and in the right order (that means tree and blobs mixed up).  This 
gets less and less true as you go back into history, but at least the 
recent stuff has a really nice access pattern.

Because commit objects are so fundamental to many graph operations they 
are already all packed together.  But tree and blob objects are 
intermixed for the reason stated above.

The naughty blob is a really special category and I think they should be 
treated as such. Therefore I don't think the common/normal case should 
be impacted with a generic change for something that is still a special 
case.

In other words, I think the naughty blob could simply be recognized as 
such and be referenced in a special list instead of being written out 
initially.  Then when everything is believed to be written, the special 
list can be walked to force write those naughty blob at last.  No need 
to modify the current object order.


Nicolas
