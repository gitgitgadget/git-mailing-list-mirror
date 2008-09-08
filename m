From: Nicolas Pitre <nico@cam.org>
Subject: Re: Storing Large Flat Namespaces
Date: Mon, 08 Sep 2008 09:58:43 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809080923250.23787@xanadu.home>
References: <21d738060809071858p703149ccmbec0276ad4ad8f88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jaap Suter <git@jaapsuter.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 15:59:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KchHa-0003Ix-24
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 15:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbYIHN6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 09:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbYIHN6u
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 09:58:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17591 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbYIHN6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 09:58:50 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6V009TQQTV4IJ0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 08 Sep 2008 09:58:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <21d738060809071858p703149ccmbec0276ad4ad8f88@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95249>

On Sun, 7 Sep 2008, Jaap Suter wrote:

> Hello,
> 
> I'm investigating the possibility of using Git to store a large flat
> namespace. As an example, imagine a single directory containing
> thousands or millions of files, each named using a 16-byte guid,
> evenly distributed.
> 
> I'm aware that the Git object model makes various trade-offs,
> typically in favor of managing source-tree layouts - which it does
> extremely well. However, perhaps it is possible to carry some of Git's
> features as a content revision tracker over to other storage
> applications?
> 
> Currently, tree objects for large flat directories are quite large.
> Doing a git-init, git-add, git-push on a flat directory with 10,000
> files creates a tree object that is 24 kilobytes compressed. Any
> change to a single file would create a whole new tree object, 24
> kilobytes every time.

Sure.  But as soon as you repack that repository, there will be only one 
24-kilobyte tree object for the latest revision and older revisions will 
have their tree object stored as a delta against the latest one, which 
should be merely the size of the changed entry only.

As to the idea of splitting a large flat directory namespace into 
sub-trees... that would only help in the commit case which isn't that 
interesting since commits are done much less frequent than, say, 
directory walking.  In the later case, you might end up inflating less 
object data for files at the beginning of the directory but more for 
files towards the end, which on average won't be a gain.  And in all 
cases you're looking up more objects.  And, to benefit from any 
advantage left if any, you'd need to do significant surgery in the tree 
walking code, otherwise simply reconstructing the current object format 
from subtree objects won't bring any advantage over the current packed 
format using deltas.

The pack V4 should in theory be much better with large directories since 
the design of its tree object representation would allow walking partial 
tree by recursively following deltas making a complete tree walk almost 
linear in terms of processing and data touched.  But that too requires a 
major surgery of the tree walking code (the main reason holding me back 
from rushing into any pack v4 work at the moment).  But pack v4 won't 
change anything in the commit case -- you would still have to repack in 
order to benefit from it.


Nicolas
