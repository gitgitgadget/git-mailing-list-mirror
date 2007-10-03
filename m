From: Johan Herland <johan@herland.net>
Subject: Re: merging .gitignore
Date: Wed, 03 Oct 2007 11:28:56 +0200
Message-ID: <200710031128.56472.johan@herland.net>
References: <20071001130314.GA5932@lapse.madduck.net>
 <20071002195148.GA14171@lapse.madduck.net>
 <200710030923.22767.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Andy Parkins <andyparkins@gmail.com>,
	martin f krafft <madduck@madduck.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 11:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id0XY-000591-Qw
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 11:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbXJCJ3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 05:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbXJCJ3E
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 05:29:04 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34159 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbXJCJ3C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 05:29:02 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JPB00M03X0CL800@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Oct 2007 11:29:00 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPB00JMQX09VV00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Oct 2007 11:28:57 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPB00G7YX08VHD0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Oct 2007 11:28:56 +0200 (CEST)
In-reply-to: <200710030923.22767.andyparkins@gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59815>

On Wednesday 03 October 2007, Andy Parkins wrote:
> I am still having difficult seeing why you want to hide conflicts 
> in .gitignore.  It's just as possible to get and resolve conflicts in 
> gitignore as in any other file.

Agreed. What about the following:

- No special merge rules for .gitignore

- Teach the .gitignore parser to ignore conflict markers (i.e. regard them 
as comments)


This way, the user will have to merge .gitignore like any other file, but if 
for some reason, the user is not able to do so (say, git needs to 
consult .gitignore before the user has had a chance to resolve the 
conflict), the fallback result will be similar to a union merge, which 
shouldn't be extremely harmful in .gitignore's case.

I do not think we really want to create an auto-merge algorithm 
for .gitignore, and then depend on this auto-merge algorithm to _always_ 
succeed with the _correct_ result and _no_ conflicts. These algorithms tend 
to be extremely tricky to get right, especially for the "always correct" 
requirement.

<rant>
Mercurial had a similar problem some months ago. They have their tag 
definitions stored in a versioned file in the working tree (.hgtags IIRC). 
But the repo tag state (i.e. Mercurial's opinion at any time as to _which_ 
tags are defined and _where_ they point) is not deduced from the copy in 
your current working tree at all. (That would of course limit you to only 
ba able to refer to tags defined earlier on the particular branch you're 
currently on.) Instead the repo tag state was found by consulting 
the "head-most" copy of the .hgtags file (for some definition 
of "head-most" including non-obvious things like which branch has the most 
recent commit, etc). The end result was that you could get some _really_ 
interesting behaviour depending on the order in which you commited totally 
unrelated changes to two different branches which happened to have 
different .hgtags files. (E.g.: Given two branches A, B, and  - in .hgtags 
on branch A - tag Foo is defined to point at rev X, and - in .hgtags on 
branch B - Foo points at rev Y. Now, whether you got rev X or rev Y when 
you checked out Foo, depended on which of branch A or branch B had the most 
recent (totally unrelated, i.e. not even touching .hgtags) commit.)

I (and others) pointed out this bug on their ML, and instead of fixing the 
braindeadness of allowing branched tag definitions in the repo in the first 
place, they set about trying to create an auto-merge algorithm for deducing 
the repo tag state from the various versions/branches of .hgtags found in 
the repo. I didn't stick around for long enough to see how well this 
auto-merge algorithm works (the misdesign of tags in Mercurial was one of 
the reasons I started looking at git), but I would be surprised if 
Mercurial today has a simple and straightforward way of deducing the repo 
tag state that _always_ gives _correct_ (i.e. unsurprising) results, even 
in the corner cases.
</rant>


Have fun! :)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
