From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 12:58:34 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806101236120.19665@iabervon.org>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ben Lynn <benlynn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 18:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K67C4-0001ry-OR
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 18:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbYFJQ6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 12:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbYFJQ6h
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 12:58:37 -0400
Received: from iabervon.org ([66.92.72.58]:44902 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbYFJQ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 12:58:36 -0400
Received: (qmail 3119 invoked by uid 1000); 10 Jun 2008 16:58:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jun 2008 16:58:34 -0000
In-Reply-To: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84524>

On Tue, 10 Jun 2008, Ben Lynn wrote:

> 2. Kudos to everyone who figured out the nasty race condition and its
> complex solution as described in Documentation/technical/racy-git.txt
> and the comments of read-cache.c. It took me a while to get my head
> around it.
> 
> Unfortunately, the solution isn't perfect. Try this:
> 
> $ echo xyzzy > file
> $ git update-index --add file   # don't zero size since contents match
> $ echo frotz > file             # all stats still match, contents don't
> $ echo nitfol > other  # can be done much earlier
> $ git update-index --add other  # now the cached size is zeroed
> $ : > file                      # zero the file size muahahaha
> $ # Type fast! The above must take place within the same second! ;-)
> $ sleep 2
> $ echo filfre > other
> $ git update-index --add other  # stats of "file" match, hash is wrong
> 
> Essentially, we trigger two index writes that avoid operations on
> "file": one immediately after "file" is first committed and identified
> as racily clean, and the second some time later, after we have
> sneakily zeroed the file behind git's back (after previously editing
> its contents in place). We defeat the safeguards and end up with a bad
> hash in the index that appears valid.
> 
> The"other" file merely causes index writes without reading the "file"
> entry. It is also racily clean in the above, but this is irrelevant.
> 
> It's unlikely this sequence of operations would occur in real usage,
> but I'd sleep better if this index corruption bug were eliminated. One
> practical but unsatisfactory easy "fix" is to mark racily clean
> entries with SIZE_MAX instead of 0.

We could distinguish a "racily clean" entry from a 0-length file entry 
based on the hash. That is, say that a file isn't clean even though the 
size matches, if the size is 0 and the entry's hash isn't the same as the 
file's hash, which is e69de29bb2d1d6434b8b29ae775ad8c2e48c5391. Nice thing 
about 0-length files is that you can compute their hashes without reading 
them.

	-Daniel
*This .sig left intentionally blank*
