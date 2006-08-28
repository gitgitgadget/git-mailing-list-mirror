From: Nicolas Pitre <nico@cam.org>
Subject: Re: Packfile can't be mapped
Date: Mon, 28 Aug 2006 00:27:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608280014190.3683@localhost.localdomain>
References: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
 <20060828024720.GD24204@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 06:27:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHYiT-0002GD-86
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 06:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWH1E1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 00:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWH1E1E
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 00:27:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11500 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750785AbWH1E1D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 00:27:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4O004CWXP2PA80@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 28 Aug 2006 00:27:02 -0400 (EDT)
In-reply-to: <20060828024720.GD24204@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26137>

On Sun, 27 Aug 2006, Shawn Pearce wrote:

> I'm going to try to get tree deltas written to the pack sometime this
> week. That should compact this intermediate pack down to something
> that git-pack-objects would be able to successfully mmap into a
> 32 bit address space.  A complete repack with no delta reuse will
> hopefully generate a pack closer to 400 MB in size.  But I know
> Jon would like to get that pack even smaller.  :)

One thing to consider in your code (if you didn't implement that 
already) is to _not_ attempt any delta on any object whose size is 
smaller than 50 bytes, and then limit the maximum delta size to 
object_size/2 - 20 (use that for the last argument to diff-delta() and 
store the undeltified object when diff-delta returns NULL).  This way 
you'll avoid creating delta objects that are most likely to end up being 
_larger_ than the undeltified object.

> I should point out that the input stream to fast-import was 20 GB
> (completely decompressed revisions from RCS) plus all commit data.
> The original CVS ,v files are around 3 GB.  An archive .tar.gz'ing
> the ,v files is around 550 MB.  Going to only 1.7 GB without tree
> or commit deltas is certainly pretty good.  :)

Good job indeed.  Oh and you probably should not bother trying to 
deltify commit objects at all since that would be a waste of time.


Nicolas
