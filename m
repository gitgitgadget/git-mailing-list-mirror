From: Nicolas Pitre <nico@cam.org>
Subject: Re: upload-pack packfile caching
Date: Tue, 16 Sep 2008 16:59:31 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809161549240.6279@xanadu.home>
References: <d411cc4a0809161052h43b1be7dh9b322c8ec7d49add@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 23:00:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfhfD-00035K-Cz
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 23:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbYIPU7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 16:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbYIPU7j
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 16:59:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41371 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbYIPU7i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 16:59:38 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K7B00AZO3N7XP80@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Sep 2008 16:59:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <d411cc4a0809161052h43b1be7dh9b322c8ec7d49add@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96033>

On Tue, 16 Sep 2008, Scott Chacon wrote:

> I was wondering if it would be of general interest to have upload-pack
> take an option to cache packfiles.  Unless I am mistaken, every clone
> on a git server will recreate the same packfile until something new is
> pushed into it, correct?  I thought it might be a good idea to pass an
> option to have it cache the packfile that is created if
> create_full_pack is set and re-use it until the repository is updated.
>  If I patched upload-pack to do this, would there be any interest in
> it?

Well, if you do that there are a few things to be careful about.

First, having a server process able to write files is a security hazard.  
If you want to create a pack cache then it is best if created manually 
by the repository owner.  You don't want someone cloning a repository 
actually messing with such cache.

Secondly, the dynamic creation of a pack currently take into account the 
capabilities of the client so not to produce a pack with features that 
the client does not support.  So in order not to have to cache pack with 
many feature combinations, this cache should probably only take effect 
if pack capabilities of the server are also supported by the client.

Now, the _only_ advantage of a cached pack file is in avoiding execution 
of rev-list.  Otherwise creation of a pack for streaming is almost 
identical to straight copying of data from disk due to pack data reuse.  
The rev-list can be made faster by having the pack-objects process do 
the object listing itself instead of piping the output from rev-list 
into it ('git repack' does that but 'git-upload-pack' doesn't).  And I 
believe that rev-list could be made much much faster with pack v4.

That been said...

What you could have is a simple file with 2 SHA1s: the first 
corresponding to the output of 'git for-each-ref' and the second one 
corresponding to the list of all objects reachable from those refs.

For example:

1) git for-each-ref --format="%(objectname)" --sort=objectname | sha1sum

2) git for-each-ref --format="%(objectname)" | \
   xargs git rev-list --objects | cut -c -40 | sort | sha1sum

So, if you do the above in a freshly cloned repository, you'll find that 
the SHA1 in 2) corresponds to this:

3) git show-index < .git/objects/pack/pack-*.idx | cut -f2 -d' ' | sha1sum

which means that all objects reachable from all refs are found in the 
only pack you have.

Now, if the SHA1 in 2) is computed over the binary representation of all 
those object names, you'll find out that it corresponds to the actual 
pack name in the .git/objects/pack/ directory.

So what upload-pack could do is look for a special file with those 2 
SHA1s, and if it exists then see if the first SHA1 matches the list of 
values for all refs, if so then the name of the pack to send out 
corresponds to the second SHA1.  If that pack is found in the repository 
then you just have to stream it out.

Creating that file is then just a matter of doing the equivalent of the 
above commands and repacking your repository 
into a single pack.


Nicolas
