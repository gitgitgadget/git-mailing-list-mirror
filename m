From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 19:29:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 04:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFL0g-0001ZA-Cb
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 04:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965715AbXG3C3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 22:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936482AbXG3C3W
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 22:29:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44056 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936456AbXG3C3W (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 22:29:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6U2TJlZ032165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jul 2007 19:29:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6U2TEm7021175;
	Sun, 29 Jul 2007 19:29:14 -0700
In-Reply-To: <241612.78983.qm@web51007.mail.re2.yahoo.com>
X-Spam-Status: No, hits=-2.727 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54169>



On Sun, 29 Jul 2007, Matthew L Foster wrote:
> 
> Is it possible for git and/or gitweb to know that commits X and Y are descendents of merge C and
> use the time merge C happened locally for both instead of using the time commits X and Y were
> created?

The data exists, but there is nothing to make "C" special. Or rather, the 
two "sides" of C that got merged are 100% equivalent.

You'd probably have to read a lot of old emails (from very early in the 
git process) to see the whole picture. But the fact is, in a distributed 
environment, the parents to a merge C are totally equivalent.

So thus when you talk about merge new code into an old repository (and 
giving those new commits the same date as the merge), that is actually 
technically 100% equivalent to merging the other way around, and thus 
you'd have to give all the *old* commits that new merge date too!

And yes, this does happen. It's not at all the case that I always merge 
other peoples tree: quite often other people merge _my_ tree, and the end 
result really is that they pulled in the changes _I_ had done.

[ Side note: we do actually try to avoid that, just because it makes the 
  history harder to read, and the resulting criss-cross merges, while 
  technically not a problem at all, can confuse people. But when I say 
  "try to avoid that", I mean just that: it's not a hard rule, and the 
  reverse merging _does_ happen, and there are good reasons for why it 
  happens.

  So *most* of the time, the history looks like it's me merging other 
  peoples code, but then every once in a while, the merge is done by the 
  other side. And from a pure technical standpoint, the two cases are 
  totally equivalent, and git is very fundamentally designed to *not* 
  care. ]

So there is never really any way to say that one side of a merge is 
special. The closest you can get is saying

 - the first parent is special.

   This is "see merges from the viewpoint of the merger", but as 
   mentioned, the person who actually did the merge isn't necessarily me, 
   so while this is a totally self-consistent view, it's not really the 
   view you are looking for.

   You can get some of this view by using "git log --first-parent", which 
   basically follows commits preferentially using the first parent, and 
   thus "prefers" history as seen by whoever did the merge.

or

 - the *local* repository is special (but this is a purely repository- 
   local viewpoint).

   This is what "reflogs" give you, and what "git log -g" shows. It shows 
   the history not as it pertains to parenthood, but as the tip-of-tree 
   has changed in *that* repository.

but neither of those are really "sensible" (the first one will give 
*wildly* different results if the repository is ever "switched around" 
because it's not merged by a single person, and the second one is a purely 
local thing and has no meaning for anybody else.

The fact is, distributed history isn't one-dimensional. You *cannot* 
linearize it as some one-dimensional time. Impossible. Any system that 
tries is broken. Fundamentally.

		Linus
