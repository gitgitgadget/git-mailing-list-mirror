From: Nicolas Pitre <nico@cam.org>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Mon, 11 Feb 2008 11:39:16 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802111112420.2732@xanadu.home>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
 <200802102353.40230.jnareb@gmail.com>
 <alpine.LFD.1.00.0802101507100.2896@woody.linux-foundation.org>
 <200802110224.48790.jnareb@gmail.com>
 <alpine.LFD.1.00.0802110748370.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:40:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JObhF-0001KV-Sv
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 17:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbYBKQjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 11:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756108AbYBKQjW
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 11:39:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23413 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbYBKQjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 11:39:21 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW3006JR29G1S90@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Feb 2008 11:39:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.00.0802110748370.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73552>

On Mon, 11 Feb 2008, Linus Torvalds wrote:

> On Mon, 11 Feb 2008, Jakub Narebski wrote:
> > 
> > Errr... index is per workarea (per checkout), and this information
> > is per repository, so IMHO storing this info in an index (dircache)
> > is a layering violation. Unless you were talking about pack-file-index.
> 
> I did mean the pack-file index, not the "cache" index.

I think this has nothing to do with pack index either.  Your repo may 
have one pack, or multiple packs, or even no pack at all.  They may or 
may not contain commit objects, etc.

The generation indexing is OTOH a repo wide issue, completely orthogonal 
to object packing. It has to be centralized in a single global file, or 
possibly one file per branch, and updated whenever new commits are added 
to the repository.  I think the best format is to have a list of 
(generation_nr, commit_sha1) tuples in assending order, so whenever a 
fetch or a commit is performed then updating this file is only a matter 
of appending to it.

And optimizing it even further, only merge commits (or rather merge 
direct parents as well as branch heads) should have their generation 
number cached in a file since the linear commits are trivially deduced 
from there.

And regenerating this generation cache should not take longer than a 
full history walk.


Nicolas
