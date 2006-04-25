From: sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 12:17:00 -0400
Message-ID: <BAYC1-PASMTP086A906CFB378AB229C2D8AEBF0@CEZ.ICE>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org>
	<7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 25 18:21:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYQI1-0002EM-H1
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 18:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWDYQVW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 12:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWDYQVW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 12:21:22 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:4003 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751575AbWDYQVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 12:21:22 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Apr 2006 09:25:33 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 194AA644C28;
	Tue, 25 Apr 2006 12:21:20 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060425121700.2d1a0032.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 Apr 2006 16:25:34.0234 (UTC) FILETIME=[E0C0C7A0:01C66884]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Apr 2006 08:40:25 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 25 Apr 2006, Linus Torvalds wrote:
> > 
> > I want the git objects to have clear and unambiguous semantics. I want 
> > people to be able to explain exactly what the fields _mean_. No "this 
> > random field could be used this random way" crud, please.
> 
> Btw, if the whole point is a "leave random porcelain a field that they can 
> use any way they want", then I say "Hell NO!".
> 
> Random porcelain can already just maintain their own lists of "related" 
> stuff, any way they want: you can keep it in a file in ".git/porcelain", 
> called "list-commit-relationships", or you could use a git blob for it and 
> have a reference to it in .git/refs/porcelain/relationships or whatever. 
> 
> If it has no clear and real semantic meaning for core git, then it 
> shouldn't be in the core git objects.
> 
> The absolute last thing we want is a "random out" that starts to mean 
> different things to different people, groups and porcelains.
> 
> That's just crazy, and it's how you end up with a backwards compatibility 
> mess five years from now that is totally unresolvable, because different 
> projects end up having different meanings or uses for the fields, so 
> converting the database (if we ever find a better format, or somebody 
> notices that SHA1 can be broken by a five-year-old-with-a-crayon).
> 
> There's a reason "minimalist" actually ends up _working_. I'll take a UNIX 
> "system calls have meanings" approach over a Windows "there's fifteen 
> different flavors of 'open()', and we also support magic filenames with 
> specific meaning" kind of thing.
> 

It's a fair point.  But adding a separate database to augment the core 
information has some downsides.  That is, that information isn't pulled, 
cloned, or pushed automatically; it doesn't get to ride for free on top 
of the core.

Accommodating extra git headers (or "note"'s in Junio's example) would allow
a developer to record the fact that he is integrating a patch taken 
from a commit in the devel branch and backporting it to the release 
branch.   Either by adding a note that references the bug tracking #, or 
a commit sha1 from the devel branch that is already associated with the bug.

Of course that information could be embedded in the free text area, but 
you yourself have argued vigorously that it is brain damaged to try and rely
on parsing free form text for these types of situations.  Most of the potential 
uses aren't really meant for a human to read while looking at the log anyway, 
they just get in the way.  Another option that you alluded to, was to 
stuff the information in another git object.   But such an object would have 
to embed a reference to the original commit, thus you haven't really made 
changing the SHA1 algorithm any easier.  And then you also then have to jump 
through hoops to make sure that you pull the proper extra blobs that contain 
information about the real commits you just pulled.

But if the information is in the actual commit header it gets to tag along
for free with never any worry it will be separated from the commit in question.
So when the developer above updates his official repo the bug tracker system 
can notice that the bug referenced in its system has had a patch backported 
and take whatever action is desired.  

Of course there are other ways to do this, but integrating it into git means it
gets a free ride on the core, and it shouldn't really get in the way of core 
any more than email X- headers get in the way of email flowing.

Sean
