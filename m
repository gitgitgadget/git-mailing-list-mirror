From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Refactoring the tag object; Introducing soft references (softrefs);
 Git 'notes' (take 2)
Date: Sat, 09 Jun 2007 15:57:30 -0700
Message-ID: <466B305A.5080802@midwinter.com>
References: <200706040251.05286.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 00:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx9sH-0002wB-2G
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 00:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbXFIW5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 18:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbXFIW5f
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 18:57:35 -0400
Received: from tater.midwinter.com ([216.32.86.90]:38132 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753063AbXFIW5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 18:57:35 -0400
Received: (qmail 23963 invoked from network); 9 Jun 2007 22:57:34 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=u8X6JUumdo8vyBEw4cInG/zFuP2SMefxHRmKh+AJfWEqltsbJca0uz0WVzG7DsW9  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 9 Jun 2007 22:57:34 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <200706040251.05286.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49637>

(Resending this in plaintext; sorry to those who got it twice.)

Being able to specify relationships between commits after the fact seems 
like a very useful facility.

Does it make sense to have type information to record what the 
relationship between two objects means? Without that, it seems like 
it'll be hard to build much of a tool set on top of this feature, since 
no two tools that made use of it could unambiguously query just their 
own softrefs.

A few use cases for relationships-after-the-fact come to mind in 
addition to the one the patch itself mentions:

A facility like this could replace the info/grafts file, or at least 
provide another way to turn a regular commit into a merge commit. Just 
put a "manually specified merge parent" ref between the target revision 
and the one you want git to think you've merged from. That would scale a 
lot better than info/grafts does, I suspect, if only by virtue of being 
O(log n) searchable thanks to the sorting.

One could easily imagine recording a "cherry picked" softref, which 
could, e.g., be the rebase machinery to skip over an already-applied 
revision. IMO the lack of any tool-readable history about cherry picking 
-- which is, after all, a sort of merge, at least conceptually -- is a 
shortcoming in present-day git. (Not a huge one, but if nothing else 
it'd be great to see cherry picking represented in, e.g., the gitk 
history display.)

It might be possible to annotate rebases to make pulling from rebased 
branches less troublesome. If you have

A--B--C--D
    \
     -E--F--G

and you rebase E onto D, a "rebased from" softref could be recorded 
between E and E':

A--B--C--D
    \     \
     -E....E'--F'--G'

Then a pulling client could potentially use that information to cleanly 
replay the rebase operation to keep its history straight. Perhaps if you 
could record historical rebases like that, you could do away with the 
current gotchas involving rebasing shared repositories. One negative 
side effect would be that you'd end up needing to keep E around where 
before you'd have been able to throw it away, but it should delta 
compress well, and you can, I think, still prune revisions F and G in 
the above picture. Or maybe it's enough to just keep E's SHA1 around 
without actually retaining its contents.

But in any event, this seems like the start of a useful new set of 
capabilities for git.

-Steve
