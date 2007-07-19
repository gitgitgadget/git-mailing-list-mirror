From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Wed, 18 Jul 2007 17:22:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 02:23:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBJni-0004Hu-Nh
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 02:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761650AbXGSAXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 20:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760972AbXGSAXX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 20:23:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58597 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760932AbXGSAXW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 20:23:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6J0N2f6015935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 17:23:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6J0MvQf004704;
	Wed, 18 Jul 2007 17:22:57 -0700
In-Reply-To: <85abttwa7m.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.173 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52917>



On Thu, 19 Jul 2007, David Kastrup wrote:
> 
> Well, kudos.  Together with the analysis from Junio, this seems like a
> good start.  Would you have any recommendations about what stuff one
> should really read in order to get up to scratch about git internals?

Well, you do need to understand the index. That's where all the new 
subtlety happens.

The data structures themselves are trivial, and we've supported empty 
trees (at the top level) from the beginning, so that part is not anything 
new.

However, now having a new entry type in the index (S_IFDIR) means that 
anything that interacts with the index needs to think twice. But a lot of 
that is just testing what happens, and so the first thing to do is to have 
a test-suite.

There's also the question about how to show an empty tree in a diff. We've 
never had that: the only time we had empty trees was when we compared a 
totally empty "root" tree against another tree, and then it was obvious. 
But what if the empty tree is a subdirectory of another tree - how do you 
express that in a diff? Do you care? Right now, since we always recurse 
into the tree (and then not find anything), empty trees will simply not 
show up _at_all_ in any diffs.

And what about usability issues elsewhere? With my patch, doing something 
like a

	git add directory/

still won't do anything, because the behaviour of "git add" has always 
been to recurse into directories. So to add a new empty directory, you'd 
have to do

	git update-index --add directory

and that's not exactly user-friendly.

So do you add a "-n" flag to "git add" to tell it to not recurse? Or do 
you always recurse, but then if you notice that the end result is empty, 
you add it as a directory?

All the logic for that whole directory lookup is in git/dir.c, and that 
code takes various flags because different programs want different things 
(show "ignored" files, or ignore them? Show empty directories or ignore 
them? etc).

So primarily, I think the job is:

 - thinking about the index, and the interactions when adding a directory 
   or adding files under a directory that already exists.

   I *think* we get all the corner cases right, because they should be 
   exactly the same as with subprojects, but hey, maybe there's some piece 
   that tests S_ISGITLINK() and now needs a S_ISDIR() test too..

 - adding test cases

 - thinking about the user interfaces for this, and adding code to handle 
   directories where needed (eg the above "git add" issue).

 - thinking about merges (which is largely about the index too, but is a 
   whole 'nother set of issues, with multiple stages in the same index at 
   the same time)

It might all be trivial. The directory traversal already knows that empty 
directories are special, so getting the right behaviour to "git add" may 
be really really easy. Or maybe it's not. I think a lot of it is just 
finding what needs to be done, seeign if we already do it, and if not, 
seeign how to do it. Boring test-cases, in other words.

		Linus
