From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFC: [PATCH] Support incremental pack files
Date: Fri, 23 Feb 2007 11:04:38 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702231040510.27932@xanadu.home>
References: <20070223071344.GA21107@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Feb 23 17:04:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKcuX-0005EJ-Ua
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 17:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbXBWQEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 11:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933113AbXBWQEk
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 11:04:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20035 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651AbXBWQEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 11:04:39 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDX00BT4BBQ9RK0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 23 Feb 2007 11:04:39 -0500 (EST)
In-reply-to: <20070223071344.GA21107@auto.tuwien.ac.at>
X-X-Sender: nico@xanadu.home
Content-id: <alpine.LRH.0.82.0702231044481.27932@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40446>

On Fri, 23 Feb 2007, Martin Koegler wrote:

> With CVS (or RCS), commiting a version, increases the required storage
> only by the size of the diff.
> 
> Commiting a new version in GIT increases the storage by the compressed
> size of each changed blob. Packing all unpacked objects decreases the
> required storage, but does not generate deltas against objects in
> packs. You need to repack all objects to get around this.
> 
> For normal source code, this is not a problem.  But if you want to use
> git for big files, you waste storage (or CPU time for everything
> repacking).

Did you try repack -a -d (without -f) ?

When -f is not used, already deltified objects are simply copied as is 
into the new pack without further processing.

> The follwing patch (again git-1.5.0-rc3) is a prototyp for supporting
> incremental pack files in git. The file structures are not changed.
> It only permits, that the base commit of a delta is located in a
> different pack or as unpacked object.

We always refused to have packs in the repository that are not self 
contained because that would pave the way for all sort of nasty issues.  
It is otherwise much harder to prevent circular delta chains, harder to 
ensure full reachability when pruning disconnected objects at the 
hierarchical level, etc.  And those are real issues that would bite you 
as soon as you perform a single fetch or push with something else than 
the native protocol.

In other words I think this is a bad idea for repository storage.  We do 
it a part of the native GIT protocol because it is obvious that there is 
no possibility for delta loops (ommitted base objects in the transmitted 
pack are known to exists in the peer repository) and those packs are 
fixed up with missing objects on the receive side when not exploded into 
loose objects.

Again a repack without -f should not be that expensive.  If it is then 
something is wrong and that should be fixed.

One thing that is too expensive in GIT is rev-list --objects --all (or 
equivalent) used to list objects to pack.  But Shawn and I have a plan 
to fix that at some point... (if only I can find some spare time to 
write more code for it).


Nicolas
