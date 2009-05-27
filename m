From: Nicolas Pitre <nico@cam.org>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 13:37:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
 <m3y6siboij.fsf@localhost.localdomain>
 <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>
 <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 27 19:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9N4f-0003PR-Mr
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 19:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759780AbZE0Rhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 13:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759378AbZE0Rhc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 13:37:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36637 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758671AbZE0Rhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 13:37:31 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKB00H3TCYEN8I0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 May 2009 13:37:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120082>

On Wed, 27 May 2009, Linus Torvalds wrote:

> Hmm. No. Looking at it some more, we could add some nasty code to do 
> _some_ things chunked (like adding a new file as a single object), but it 
> doesn't really help. For any kind of useful thing, we'd need to handle the 
> "read from pack" case in multiple chunks too, and that gets really nasty 
> really quickly.
> 
> The whole "each object as one allocation" design is pretty core, and it 
> looks pointless to have a few special cases, when any actual relevant use 
> would need a whole lot more than the few simple ones.
> 
> Git really doesn't like big individual objects.
> 
> I've occasionally thought about handling big files as multiple big 
> objects: we'd split them into a "pseudo-directory" (it would have some new 
> object ID), and then treat them as a magical special kind of directory 
> that just happens to be represented as one large file on the filesystem.
> 
> That would mean that if you have a huge file, git internally would never 
> think of it as one big file, but as a collection of many smaller objects. 
> By just making the point where you break up files be a consistent rule 
> ("always break into 256MB pieces"), it would be a well-behaved design (ie 
> things like behaviour convergence wrt the same big file being created 
> different ways).
> 
> HOWEVER.
> 
> While that would fit in the git design (ie it would be just a fairly 
> straightforward extension - another level of indirection, kind of the way 
> we added subprojects), it would still be a rewrite of some core stuff. The 
> actual number of lines might not be too horrid, but quite frankly, I 
> wouldn't want to do it personally. It would be a lot of work with lots of 
> careful special case handling - and no real upside for normal use.

My idea for handling big files is simply to:

 1) Define a new parameter to determine what is considered a big file.

 2) Store any file larger than the treshold defined in (1) directly into 
    a pack of their own at "git add" time.

 3) Never attempt to diff nor delta large objects, again according to 
    (1) above.  It is typical for large files not to be deltifiable, and 
    a diff for files in the thousands of megabytes cannot possibly be 
    sane.

The idea is to avoid ever needing to load such object's content entirely 
in memory. So with the data already in a pack, the pack data reuse logic 
(which already does its copy in chunks) could be triggered during a 
repack/fetch/push.

This is also quite trivial to implement with very few special cases, and 
then git would handle huge repositories with lots of huge files just as 
well as any other SCMs.  The usual git repository compactness won't be 
there of course, but I doubt people dealing with repositories in the 
hundreds of gigabytes really care.


Nicolas
