From: Nicolas Pitre <nico@cam.org>
Subject: Re: .git grows after git-gc?
Date: Tue, 24 Apr 2007 10:00:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704240939360.12375@xanadu.home>
References: <200704241431.33624.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 16:01:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgLa1-0003hO-3g
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 16:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbXDXOBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 10:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161383AbXDXOBA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 10:01:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42613 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161260AbXDXOBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 10:01:00 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH0009A49LNPC40@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Apr 2007 10:00:59 -0400 (EDT)
In-reply-to: <200704241431.33624.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45450>

On Tue, 24 Apr 2007, Andy Parkins wrote:

> Hello,
> 
> Not important at all, but I was surprised to see this:
> 
> $ git fetch \
>    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git \
>    refs/heads/master:refs/remotes/vendor
> remote: Generating pack...
[...]
> $ du -h .git
> 95M     .git
> 
> $ git-gc --prune
> Generating pack...
[...]
> $ du -h .git
> 97M     .git
> 
> That's a bit odd isn't it?

Two possible explanations:

1) I recently fixed pack-objects which didn't respect the delta depth
   limit when fetching. See commit  898b14cedc for details. This could 
   potentially cause some repacks to create slightly larger packs.

2) When fetching a pack, the client sends its capabilities to the server 
   who can alter some packing parameters accordingly.  One such 
   parameter is --delta-base-offset which your client most certainly 
   supports.  This means that the packs you receive and keep as is in 
   your local repo were encoded with --delta-base-offset for maximum 
   network efficiency.

   Now when you repack, this parameter won't be used by default unless 
   you have repack.usedeltabaseoffset set to true in your config, which 
   will cause a small increase in pack size.

I think that (2) is the most probable cause of repack growth in your 
case.  Just try:

	git config --global repack.usedeltabaseoffset true
	git gc

and you should get that 2MB back, possibly a bit more.


Nicolas
