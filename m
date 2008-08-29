From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/3] don't let disk corruptions escape pack SHA1
	checksum
Date: Thu, 28 Aug 2008 21:55:35 -0700
Message-ID: <20080829045535.GB28492@spearce.org>
References: <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org> <20080825221321.GL2213@fieldses.org> <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org> <48B46B04.70102@gmail.com> <48B46F46.9090302@gmail.com> <alpine.LFD.1.10.0808270937340.3363@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808271458320.1624@xanadu.home> <alpine.LFD.1.10.0808271222250.3363@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808271627540.1624@xanadu.home> <alpine.LFD.1.10.0808282142490.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 06:56:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYw2N-0000JC-8G
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 06:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbYH2Ezh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 00:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbYH2Ezh
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 00:55:37 -0400
Received: from george.spearce.org ([209.20.77.23]:48969 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYH2Ezg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 00:55:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EAFCF38375; Fri, 29 Aug 2008 04:55:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808282142490.1624@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94250>

Nicolas Pitre <nico@cam.org> wrote:
> 
> So here is 3 patches for this in C git (Shawn already did it for jgit).
> 
> There are 3 spots where this needs to be plugged: in pack-objects, 
> index-pack and fast-import.  I did the first two.
> 
> I don't think this is that pertinent in fast-import because:
> 
>  - we want fast-import to be fast
> 
>  - after fast-import is done, a full repack is typically done which 
>    would revalidate everything (maybe fast-import should use index v2 
>    with its per object CRC32 though)
> 
> But maybe I'm wrong about that. In any case, I am leaving the 
> fast-import to someone more knowledgeable about its code than I do.

fast-import is the backend to a number of incremental import tools.
They stream data in from foreign VCS systems (notably Perforce)
and write into a live repository.  That repository may not get
repacked for days/weeks.  We should treat it just like index-pack.

So I think we should plug it.  The cost to keep a running SHA-1
for what we have written is pretty low.  I'd rather trade off a
minute or so on an hour long import for data safety than have a
chance for data corruption going unnoticed by the end user.

And now that index v2 is available, yea, fast-import should write
its index in that format so that a later repack can safely delta
reuse if it (by rare chance) decides the current packed form is the
best representation.  This is especially true with "git gc --auto"
triggering a repack every so often due to the incremental import
packs I just metioned above.

I've just been too busy with other things to add index v2 support.

-- 
Shawn.
