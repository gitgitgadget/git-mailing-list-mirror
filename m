From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Wed, 8 Feb 2006 08:34:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602080815180.2458@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
 <Pine.LNX.4.63.0602081248270.31700@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 08 17:38:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6sHA-0005cC-A1
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 17:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbWBHQec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 11:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030586AbWBHQec
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 11:34:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030582AbWBHQeb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 11:34:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k18GYNDZ030334
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 08:34:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k18GYMhv032349;
	Wed, 8 Feb 2006 08:34:23 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602081248270.31700@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15741>



On Wed, 8 Feb 2006, Johannes Schindelin wrote:
> 
> I am uncertain if it is possible to extend git to handle large files 
> gracefully, without slowing it down for its main use case.

Indeed. The git architecture simply sucks for big objects. It was 
discussed somewhat durign the early stages, but a lot of it really is 
pretty fundamental. The fact that all the operations work on a full 
object, and the delta's are (on purpose) just a very specific and limited 
kind of size compression is just very ingrained.

> [thinking] A potentially silly idea just hit me: We could virtually cut 
> every file into 256kB chunks. That would not affect source code at all: 
> anybody producing a 256kB C file should be shot anyway.

It probably wouldn't help that much, really. And it would probably impact 
source code users too: I bet we'd have bugs. It would be a very strange 
special case.

It also would only help for things that purely grow at the end. Which 
isn't even true for a mailbox: it may or may not be true for your INBOX, 
but anybody who _uses_ a mailbox format to read his email will be adding 
status flags to the mbox format (or deleting mbox entries etc). 

So every time a small change happened that changed the offset, you'd have 
an explosion of these 256kB chunk objects, and while the delta would work 
(probably slowly - remember how the git deltification algorithm tries to 
compare against the ten "nearest" neighbors), at _commit_ time you'd have 
to write that 1GB (compressed) out anyway.

Realistically, I think the answer is that git just doesn't work for his 
usage case. There's two alternatives:

 - convince him to not have big mailboxes (an answer I don't particularly 
   like: it's a tool limitation, and you shouldn't change your behaviour 
   just because the tool doesn't work for it - you should just try to find 
   the right tool).

   That said: git should actually work beautifully for email if you 
   _don't_ keep it as one big mbox. You could probably very reasonably use 
   git as a database backend, where each email is its own object, and you 
   can have many different ways of indexing them into trees (by content, 
   by date, by author, by thread).

   But that's very different from the suggested "home directory" setup 
   would be.

 - try to work around some of the worst git issues. While I don't think 
   the 256kB blockign thing would help (the git protocol would still 
   always send the base versions), there _are_ probably things that could 
   be done. They'd be very invasive, though, and somebody would seriously 
   have to look at the architectural issues.

   For example, right now the decision to send only "self-contained" packs 
   in the git protocol was a very conscious one: it's much safer, and it 
   makes the unpacking a lot easier (the unpacking doesn't ever have to 
   even read any other objects than the stream it gets). It's also (for 
   packs that we use on-disk) the only sane way to avoid nasty inter-pack 
   dependencies.

   But for the git protocol, the inter-pack dependencies don't matter, 
   if we'd always unpack the thing on reception if it is not a 
   self-contained pack. So we _could_ allow delta's that depend on the 
   receiver already having the objects we delta against.

   However, the deltification itself is likely very slow, exactly because 
   git (again, very much by design) generates the deltas dynamically 
   rather than depending on things already being in delta format.

Personally, I think the answer is "git is good for lots of small files". 
It's very much what git was designed for, and the fact that it doesn't 
work for everything is a trade-off for the things it _does_ work well for.

			Linus
