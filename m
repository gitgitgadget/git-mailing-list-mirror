From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
 dscms and a "whole product" approach)
Date: Thu, 30 Apr 2009 14:56:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904301401120.6741@xanadu.home>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
 <m3ocugod96.fsf@localhost.localdomain>
 <m3fxfqnxn5.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:57:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzbRb-0002IW-Li
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 20:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764265AbZD3S4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 14:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764140AbZD3S4j
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 14:56:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21908 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248AbZD3S4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 14:56:37 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIX00EHNGK5RX52@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 30 Apr 2009 14:55:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m3fxfqnxn5.fsf_-_@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118036>

On Thu, 30 Apr 2009, Jakub Narebski wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> es> Two:  Maybe Git is fast because Linus Torvalds is so smart.
> 
> [non answer; the details are important]

I think Linus is certainly responsible for a big part of Git's speed.  
He came with the basic data structure used by git which has lots to do 
with that.  Also, he designed Git specifically to fulfill a need for 
which none of the alternatives were fast enough.  Hence Git was designed 
from the ground up with speed as one of the primary design goals, such 
as being able to create multiple commits per second instead of the other 
way around (several seconds per commit). And yes, Linus is usually smart 
enough with the proper mindset to achieve such goals.

> es> Three: Maybe Git is fast because it's written in C instead of one
> es> of those newfangled higher-level languages.
> es>
> es> Nah, probably not.  Lots of people have written fast software in
> es> C#, Java or Python.
> es>
> es> And lots of people have written really slow software in
> es> traditional native languages like C/C++. [...]
> 
> Well, I guess that access to low-level optimization techniques like
> mmap are important for performance.  But here I am guessing and
> speculating like Eric did; well, I am asking on a proper forum ;-)
> 
> We have some anegdotical evidence supporting this possibility (which
> Eric dismisses), namely the fact that pure-Python Bazaar is slowest of
> three most common open source DVCS (Git, Mercurial, bazaar) and the
> fact that parts of Mercurial were written in C for better performance.
> 
> We can also compare implementations of Git in other, higher level
> languages, with reference implementation in C (and shell scripts, and
> Perl ;-)).  For example most complete I think but still not fully
> complete Java implementation: JGit.  I hope that JGit developers can
> tell us whether using higher level language affects performance, how
> much, and what features of higher-level language are causing decrease
> in performance.  Of course we have to take into account the
> possibility that JGit isn't simply as well optimized because of less
> manpower.

One of the main JGit developers is Shawn Pearce.  If you look at Shawn's 
contribution to C git, they mostly are all related to performance 
issues.  Amongst other things, he is the author of git-fast-import, he 
contributed the pack access windowing code, and he was also involved in 
the initial design of pack v4.  Hence Shawn is a smart guy who certainly 
knows one or two things about performance optimizations.  Yet he 
reported on this list that his efforts to make JGit faster were not much 
successful anymore, most probably due to the language overhead.

> es> Four: Maybe Git is fast because being fast is the primary goal for
> es> Git.
> 
> [non answer; the details are important]

Still, this is actually true (see about Linus above).  Without such a 
goal, you quickly lose sight of performance regressions.

> es> Maybe Git is fast because every time they faced one of these "buy
> es> vs. build" choices, they decided to just write it themselves.
> 
> I don't think so.  Rather the opposite is true.  Git uses libcurl for
> HTTP transport.  Git uses zlib for compression.  Git uses SHA-1 from
> OpenSSL or from Mozilla.  Git uses (modified, internal) LibXDiff for
> (binary) deltaifying, for diffs and for merges.

Well, I think he's right on this point as well.  libcurl is not so 
relevant since it is rarely the bottleneck (the network bandwidth itself 
usually is).  zlib is already as fast as it can be as multiple attempts 
to make it faster didn't succeed.  Git already carries its own version 
of SHA-1 code for ARM and PPC because the alternatives were slower.  
The fact that libxdiff was made internal is indeed to have a better 
impedance matching with the core code, otherwise it could have remained 
fully external just like zlib.  And the binary delta code is not 
libxdiff anymore but a much smaller, straight forward, and optimized to 
death version to achieve speed over versatility (no need to be versatile 
when strictly dealing with Git's needs only).

> es> Seven:  Maybe Git isn't really that fast.
> es>
> es> If there is one thing I've learned about version control it's that
> es> everybody's situation is different.  It is quite likely that Git
> es> is a lot faster for some scenarios than it is for others.
> es>
> es> How does Git handle really large trees?  Git was designed primary
> es> to support the efforts of the Linux kernel developers.  A lot of
> es> people think the Linux kernel is a large tree, but it's really
> es> not.  Many enterprise configuration management repositories are
> es> FAR bigger than the Linux kernel.
> 
> c.f. "Why Perforce is more scalable than Git" by Steve Hanov
>      http://gandolf.homelinux.org/blog/index.php?id=50
> 
> I don't really know about this.

Git certainly sucks big time with large files.

Git also sucks to a lesser extent (but still) with very large 
repositories.

But large trees?  I don't think Git is worse than anything out there 
with a large tree of average size files.

Yet, this point is misleading because when people gives to Git the 
reputation of being faster, this is certainly from comparison of 
operations performed on the same source tree.  Who cares about scenarios 
for which the tool was not designed?  Those "enterprise configuration 
management repositories" are not what Git was designed for indeed, but 
neither was Mercurial nor Bazaar, or any other contender to which Git is 
usually compared.


Nicolas
