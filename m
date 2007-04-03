From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 12:33:46 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031220470.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 18:33:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYlxA-0004zE-P0
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 18:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933786AbXDCQds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 12:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933875AbXDCQds
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 12:33:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40952 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933786AbXDCQdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 12:33:47 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX00IA7KOAUUL0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 12:33:46 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43628>

On Tue, 3 Apr 2007, Linus Torvalds wrote:

> 
> Junio, Nico,
>  I think we need to do something about it.

Sure.  Mea culpa.

> CLee was complaining about git-index-pack on #irc with the partial KDE 
> repo, and while I don't have the KDE repo, I decided to investigate a bit.
> 
> Even with just the kernel repo (with a single 170MB pack-file), I can do
> 
> 	git index-pack --stdin --fix-thin new.pack < .git/objects/pack/pack-*.pack
> 
> and it uses 52s of CPU-time, and on my 4GB machine it actually started 
> doing IO and swapping, because git-index-pack grew to 4.8GB in size.

Right.

> Two suggestion for other ways:
> 
>  - simple one: don't keep unexploded objects around, just keep the deltas, 
>    and spend tons of CPU-time just re-expanding them if required.
> 
>    We *should* be able to do it with just keeping the original 170MB 
>    pack-file in memory, not expanding it to 3.8GB! 
> 
>    Still, even this will be painful once you have a big pack-file, and the 
>    CPU waste is nasty (although a delta-base cache like we do in 
>    sha1_file.c would probably fix it 99% - at that point it's getting 
>    less simple, and the "best" solution below looks more palatable)
> 
>  - best one: when writing out the pack-file, we incrementally keep a 
>    "struct packed_git" around, and update the index for it dynamically, 
>    and totally get rid of all objects that we've written out, because we 
>    can re-create them.
> 
>    This means that we should have _zero_ memory footprint except for the 
>    one object that we're working on right then and there, and any 
>    unresolved deltas where we've not seen the base at all (and the latter 
>    generally shouldn't happen any more with most pack-files)

Even better:

  - Fix my own stupid mistake with a _single_ line of code:

diff --git a/index-pack.c b/index-pack.c
index 6284fe3..3c768fb 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -358,6 +358,7 @@ static void sha1_object(const void *data, unsigned long size,
 		if (size != has_size || type != has_type ||
 		    memcmp(data, has_data, size) != 0)
 			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
+		free(has_data);
 	}
 }

The thing is, that code path is executed _only_ when index-pack is 
encountering an object already in the repository in order to protect 
against possible SHA1 collision attacks.  See commit 8685da42561d log 
for the full story.

Normally this should not happen in normal usage scenarios because the 
objects you fetch are those that you don't already have.  But if you 
manually run index-pack inside an existing repository then you'll 
already have _all_ those objects already explaining the high CPU usage.

But this is no excuse for not freeing the data though.


Nicolas
