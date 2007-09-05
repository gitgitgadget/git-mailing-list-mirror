From: Nicolas Pitre <nico@cam.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 16:35:19 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709051634190.21186@xanadu.home>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
 <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 22:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT1ay-0000Vc-LQ
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 22:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbXIEUfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 16:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755757AbXIEUfW
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 16:35:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58489 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbXIEUfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 16:35:21 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNW00DAIX6VQ5K0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Sep 2007 16:35:20 -0400 (EDT)
In-reply-to: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57759>

On Wed, 5 Sep 2007, Junio C Hamano wrote:

> Implement git gc --auto
> 
> This implements a new option "git gc --auto".  When gc.auto is
> set to a positive value, and the object database has accumulated
> roughly that many number of loose objects, this runs a
> lightweight version of "git gc".  The primary difference from
> the full "git gc" is that it does not pass "-a" option to "git
> repack", which means we do not try to repack _everything_, but
> only repack incrementally.  We still do "git prune-packed".  

A big part of the repack cost is the counting of objects. I don't know 
if --unpacked to git-pack-objects skips walking trees of a packed commit 
object.  If no then it probably should to gain a significant speed up, 
or maybe a separate option should be created to actually imply this 
loosened semantic.

> This patch does not add invocation of the "auto repacking".  It
> is left to key Porcelain commands that could produce tons of
> loose objects to add a call to "git gc --auto" after they are
> done their work.  Obvious candidates are:
> 
> 	git add

Nope!  'git add' creates loose objects which are not yet reachable from 
anywhere.  They won't get repacked until a commit is made.

> 	git fetch

I think that would be a much better idea to simply decrease the 
fetch.unpackLimit default value.

>         git merge
>         git rebase        

and git commit.  Which resumes it to commit creating operation.


Nicolas
