From: Nicolas Pitre <nico@cam.org>
Subject: Re: Problem with large files on different OSes
Date: Thu, 28 May 2009 16:54:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905281608060.3906@xanadu.home>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
 <m3y6siboij.fsf@localhost.localdomain>
 <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>
 <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
 <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
 <20090527215314.GA10362@coredump.intra.peff.net>
 <alpine.LFD.2.00.0905271834280.3906@xanadu.home>
 <20090528200039.GI13499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_z4lfvbToK1raKapDO+eBbA)"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 22:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9mce-0007ge-MK
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 22:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899AbZE1Uyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 16:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757194AbZE1Uye
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 16:54:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20405 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189AbZE1Uyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 16:54:33 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKD0058MGQS1N60@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 May 2009 16:54:28 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090528200039.GI13499@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120228>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_z4lfvbToK1raKapDO+eBbA)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Thu, 28 May 2009, Jeff King wrote:

> On Wed, May 27, 2009 at 07:29:02PM -0400, Nicolas Pitre wrote:
> 
> > > What about large files that have a short metadata section that may
> > > change? Versions with only the metadata changed delta well, and with a
> > > custom diff driver, can produce useful diffs. And I don't think that is
> > > an impractical or unlikely example; large files can often be tagged
> > > media.
> > 
> > Sure... but what is the actual data pattern currently used out there?
> 
> I'm not sure what you mean by "out there", but I just exactly described
> the data pattern of a repo I have (a few thousand 5 megapixel JPEGs and
> short (a few dozens of megabytes) AVIs, frequent additions, infrequently
> changing photo contents, and moderately changing metadata). I don't know
> how that matches other peoples' needs.

How do diffing à la 'git diff' JPEGs or AVIs make sense?

Also, you certainly have little to delta against as you add new photos 
more often than modifying existing ones?

> Game designers have been mentioned before in large media checkins, and I
> think they focus less on metadata changes. Media is either there to
> stay, or it is replaced as a whole.

Right.  And my proposal fits that scenario pretty well.

> > What does P4 or CVS or SVN do with multiple versions of almost identical 
> > 2GB+ files?
> 
> I only ever tried this with CVS, which just stored the entire binary
> version as a whole. And of course running "diff" was useless, but then
> it was also useless on text files. ;) I suspect CVS would simply choke
> on a 2G file.
> 
> But I don't want to do as well as those other tools. I want to be able
> to do all of the useful things git can do but with large files.

Right now git simply do much worse.  So doing as well is still a worthy 
goal.

> Right. I think in some ways we are perhaps talking about two different
> problems. I am really interested in moderately large files (a few
> megabytes up to a few dozens or even a hundred megabytes), but I want
> git to be _fast_ at dealing with them, and doing useful operations on
> them (like rename detection, diffing, etc).

I still can't see how diffing big files is useful.  Certainly you'll 
need a specialized external diff tool, in which case it is not git's 
problem anymore except for writing content to temporary files.

Rename detection: either you deal with the big files each time, or you 
(re)create a cache with that information so no analysis is needed the 
second time around.  This is something that even small files might 
possibly benefit from.  But in any case, there is no other ways but to 
bite the bullet at least initially, and big files will be slower to 
process no matter what.

> A smart splitter would probably want to mark part of the split as "this
> section is large and uninteresting for compression, deltas, diffing, and
> renames".  And that half may be stored in the way that you are proposing
> (in a separate single-object pack, no compression, no delta, etc). So in
> a sense I think what I am talking about would built on top of what you
> want to do.

Looks to me like you wish for git to do what a specialized database 
would be much more suited for the task.  Isn't there tools to gather 
picture metadata info, just like itunes does with MP3s already?

> But I do think we can get some of the benefits by maintaining a split
> cache for viewers.

Sure.

But being able to deal with large (1GB and more) files remains a totally 
different problem.


Nicolas

--Boundary_(ID_z4lfvbToK1raKapDO+eBbA)--
