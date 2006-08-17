From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 13:22:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608171233370.11359@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <20060817040719.GC18500@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 19:22:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDlZJ-00088N-5v
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 19:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWHQRWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 13:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWHQRWE
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 13:22:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64981 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030184AbWHQRWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 13:22:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4500MGMK8Q9XE0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Aug 2006 13:22:02 -0400 (EDT)
In-reply-to: <20060817040719.GC18500@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25594>

On Thu, 17 Aug 2006, Shawn Pearce wrote:

> I'm going to try to integrate this into core GIT this weekend.
> My current idea is to make use of the OBJ_EXT type flag to add
> an extended header field behind the length which describes the
> "chunk" as being a delta chain compressed in one zlib stream.
> I'm not overly concerned about saving lots of space in the header
> here as it looks like we're winning a huge amount of pack space,
> so the extended header will probably itself be a couple of bytes.
> This keeps the shorter reserved types free for other great ideas.  :)

We're streaving for optimal data storage here so don't be afraid to use 
one of the available types for an "object stream" object.  Because when 
you think of it, the deflating of multiple objects into a single zlib 
stream can be applied to all object types not only deltas.  If ever 
deflating many blobs into one zlib stream is dimmed worth it then the 
encoding will already be ready for it.  Also you can leverage existing 
code to write headers, etc.

I'd suggest you use OBJ_GROUP = 0 as a new primary object type.  Then 
the "size" field in the header could then become the number of objects 
that are included in the group.  Most of the time that will fit in the 
low 4 bits of the first header byte, but if there is more than 15 
grouped objects then more bits can be used on the following byte.  
Anyway so far all the code to generate and parse that is already there.  
If ever there is a need for more extensions that could be prefixed with 
a pure zero byte (an object group with a zero object count which is 
distinguishable from a real group).

Then, having the number of grouped objects, you just have to list the 
usual headers for those objects, which are their type and inflated size 
just like regular object headers, including the base sha1 for deltas.  
Again you already have code to produce and parse those.

And finally just append the objects payload in a single deflated stream.

This way the reading of an object from a group can be optimized if the 
object data is located at the beginning of the stream such that you only 
need to inflate the amount of bytes leading to the desired data 
(possibly caching those for further delta replaying), inflate 
the needed data for the desired object and then ignoring the remaining 
of the stream.


Nicolas
