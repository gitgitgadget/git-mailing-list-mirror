From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 11:34:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704181114040.4504@xanadu.home>
References: <200704171041.46176.andyparkins@gmail.com>
 <"200704171803.58940.a n  dyparkins"@gmail.com>
 <200704172012.31280.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
 <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
 <4625B99D.9090409@dawes.za.net>
 <alpine.LFD.0.98.0704180748460.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Rogan Dawes <lists@dawes.za.net>,
	David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 17:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCB1-0007Gl-TW
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 17:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992773AbXDRPe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 11:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbXDRPe1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 11:34:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39425 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925AbXDRPe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 11:34:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGP00J0R9XD5R60@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Apr 2007 11:34:26 -0400 (EDT)
In-reply-to: <alpine.LFD.0.98.0704180748460.2828@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44898>

On Wed, 18 Apr 2007, Linus Torvalds wrote:

> 
> 
> On Wed, 18 Apr 2007, Rogan Dawes wrote:
> > 
> > Or similarly, when checking an "ODF" file in, the attribute would lead to an
> > appropriate script creating the "tree" of individual files.
> > 
> > Does this sound workable?
> 
> I think it sounds very interesting, and I'd much rather do _those_ kinds 
> of rewrites than keyword unexpansion. And yes, some kind of generic 
> support for rewriting might give people effectively the keywords they want 
> (I think the CVS semantics are not likely to be logical, but people can 
> probably do something that works for them), and at that point maybe the 
> keyword discussion goes away too.

Exactly my point.

> However, I don't know if it is "workable".
> 
> The thing is, it's easy enough (although potentially _very_ expensive) to 
> run some per-file script at each commit and at each checkout. But there 
> are some fundamental operations that are even more common:
> 
>  - checking for "file changed", aka the "git status" kind of thing
> 
>    Anything we do would have to follow the same "stat" rules, at a 
>    minimum. You can *not* afford to have to check the file manually.
> 
>    So especially if you combine several pieces into one, or split one file 
>    into several pieces, your index would have to contain the entry 
>    that matches the _filesystem_ (because that's what the index is all 
>    about), but then the *tree* would contain the pieces (or the single 
>    entry that matches several filesystem entries).

For that the external script would need the ability to alter the index 
itself.  That becomes a bit yucky.  Or maybe something could be made 
with a mechanism like dnotify/inotify to "touch" the single placeholder 
entry referenced by the index whenever one of the split component 
changes.

>  - what about diffs (once the stat information says something has 
>    potentially changed)? You'd have to script those too, and it really 
>    sounds like some very basic operations get a _lot_ more expensive and 
>    complex.

Of course an attribute for external diff script is certainly something 
that could be useful independently of this case, as some particular 
binary formats might have a way of their own to display their 
differences.

The whole idea of having the ability to call external tools is exactly 
to delegate complex/bizarre/unusual tasks to separate and independent 
agents.  The whole checkout operation becomes much more expensive but 
everyone using such facility might expect it.  It just cannot be as bad 
as a straight checkout with CVS from a remote server though (OK I know 
it can but you know what I mean).

>    This is also related to the above: one of the most fundamental diffs is 
>    the diff of the index and a tree - so if the index matches the 
>    "filesystem state" and the trees contain some "combined entry" or 
>    "split entry", you'd have to teach some very core diff functionality 
>    about that kind of mapping.

Well, if the split components are represented by a single placeholder in 
the index and the filesystem, and the filesystem placeholder is 
"touched" whenever a split component is modified, then the mapping can 
as well be limited to the external scripts for checkin/checkout/diff 
only without the Git core having the slightest idea about it.

Sure it might be slow and unusual, but at least not impossible.  And 
again, with an attribute providing a facility for external tools it is 
then not our problem anymore.


Nicolas
