From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Mon, 09 Apr 2007 14:30:49 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091404530.28181@xanadu.home>
References: <46197950.3080804@gmail.com>
 <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704082012220.28181@xanadu.home>
 <20070409173858.GT5436@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 22:07:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Haydi-00056s-HX
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXDISav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbXDISav
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:30:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11434 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbXDISau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:30:50 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG8002L2U3D56R0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 14:30:50 -0400 (EDT)
In-reply-to: <20070409173858.GT5436@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44064>

On Mon, 9 Apr 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > I think another file with common pack writing functions could be 
> > created.  Pack index writing is another item that is currently 
> > duplicated in pack-objects and index-pack for example.
> 
> I agree entirely.  And I'd like to see that refactoring occur
> before this series, or as part of it.  At least for the nr_objects
> correction routine.

That's easy enough for the nr_objects correction case.

The next obvious candidate would be index generation, but I'd wait a bit 
for all features in progress to be merged and stabilize first.

> For example, writing objects to a packfile: we have 3
> implementations.  fast-import.c doesn't use sha1write_compressed
> because that was a waste of time to compute the SHA_CTX when we
> know we have to go back and fixup nr_objects.  It also doesn't use
> it because fast-import.c's pack-splitting logic is based on the
> final object size, not the starting offset.  It does the deflate
> itself, decides if the end of the object will overflow, and if so,
> jumps to a new packfile.

I'd be really tempted to create a pack v4 which only change is to still 
have the pack header at the beginning of the pack like we do today, but 
include the header in the pack SHA1 computation at the end of the stream 
only.  This way the pack SHA1 could be computed as the pack is 
generated, and the header fixed up without having to read the entire 
pack back.  I think it was Geert Bosch who proposed this and it makes 
tons of sense IMHO.


Nicolas
