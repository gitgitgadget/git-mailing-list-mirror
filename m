From: Nicolas Pitre <nico@cam.org>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 12:21:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604051155090.2550@localhost.localdomain>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
 <7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <e10mn9$cjs$1@sea.gmane.org>
 <Pine.LNX.4.64.0604051131010.2550@localhost.localdomain>
 <86wte4rq3d.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 18:22:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRAlV-0003H1-JS
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 18:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWDEQVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 12:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWDEQVv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 12:21:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43558 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751230AbWDEQVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 12:21:50 -0400
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IX900N6DC4D32I0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Apr 2006 12:21:49 -0400 (EDT)
In-reply-to: <86wte4rq3d.fsf@blue.stonehenge.com>
X-X-Sender: nico@localhost.localdomain
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18442>

On Wed, 5 Apr 2006, Randal L. Schwartz wrote:

> >>>>> "Nicolas" == Nicolas Pitre <nico@cam.org> writes:
> 
> >> IIRC bsdiff is used by Firefox to distribute binary software updates.
> >> Xdelta is generic (not optimized for binaries like bsdiff and edelta), but
> >> supposedly offers worse compression (bigger diffs).
> 
> Nicolas> We already have our own delta code for pack storage.
> 
> I think the issue is related to being able to cherry-pick and merge
> when binaries are involved.  I've been worried about that myself.
> How well are binaries supported these days for all the operations
> we're taking for granted?  When is a "diff" expected to be a real
> "diff" and not just "binary files differ"?

First of all, does cherry-picking binary patches is a sensible thing to 
do?

Do you expect, say, a Word document, a JPEG image, or an MP3 file to 
still be valid and error free if two binary patches modifying a 
different part of the same file (same revision) are successively 
applied?  I seriously doubt it.

And what do you do with conflicts?  Using diff3 might be sensible for 
text data, but for binaries you really need a tool that understands the 
type of data your binary contains, which means one tool for each 
possible type of binary data which is outside the scope of GIT.

For example, if you patch a .wav file adding some data, then you end up 
with the additional samples and a new length in the file header.  If 
another patch to that .wav is applied, then it is easy to find the 
"surrounding context" where the second patch is adding/removing some 
other samples, but then you really needs knowledge about the .wav format 
to handle the conflict that will occur on the .wav header modification.

And so on for all possible binary types.

So IMHO a binary patch format is only useful for easy _transport_ along 
with other text patches.  And the binary patch must either apply 
perfectly against the same source file or it must not apply at all.  
That's the only sensible accommodation we can do with a generic binary 
patch format.

When the patch doesn't apply to your tree, then nothing prevents you 
from hooking a dedicated tool that will pick up the original file, the 
reconstructed remote version according to the binary patch you received 
and your own modified version so that tool can process them and do the 
necessary changes with proper knowledge of the data format.


Nicolas
