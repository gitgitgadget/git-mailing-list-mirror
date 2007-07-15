From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Questions about git-fast-import for cvs2svn
Date: Sun, 15 Jul 2007 11:43:40 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707151119120.20061@woody.linux-foundation.org>
References: <469A2B1D.2040107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 15 20:44:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA94z-0004Ds-6M
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 20:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbXGOSoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 14:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbXGOSoJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 14:44:09 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42495 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751772AbXGOSoI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 14:44:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6FIhkj3004240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Jul 2007 11:43:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6FIheLw006908;
	Sun, 15 Jul 2007 11:43:40 -0700
In-Reply-To: <469A2B1D.2040107@alum.mit.edu>
X-Spam-Status: No, hits=-2.615 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52575>



On Sun, 15 Jul 2007, Michael Haggerty wrote:
> 
> 1. Is it a problem to create blobs that are never referenced?  The
> easiest point to create blobs is when the RCS files are originally
> parsed, but later we discard some CVS revisions, meaning that the
> corresponding blobs would never be needed.  Would this be a problem?

No, don't worry about it. The resulting intermediate pack-file may be 
unnecessarily big, but you'd want to do a "git gc" to re-pack everything 
afterwards *anyway*, since the pack-files git-fast-import generates are 
generally not all that optimall, and that will also prune any unreferenced 
blobs.

> 2. It appears that author/committer require an email address.  How
> important is a valid email address here?

Git itself doesn't really care, and many CVS conversions have just 
converted the username into "user <user>", but from a QoI standpoint it's 
much nicer if you at least were to allow the kind of conversion that 
allows user-name to be associated with an email.

Maybe git-fast-import could be taught to do the kind of user name 
conversion that we already do for CVS imports.. Shawn?

>    a. CVS commits include a username but not an email address.  If an
> email address is really required, then I suppose the person doing the
> conversion would have to supply a lookup table mapping username -> email
> address.

That would be optimal. Note that it's not just user names: it's much nicer 
if you can regenerate a readable full name too, so instead of having 
something like "torvalds <torvalds>", you could map "torvalds" into "Linus 
Torvalds <torvalds@linux-foundation.org>", which is a lot more readable.

But as far as git is concerned, this is all about being _pretty_, it 
doesn't really have any semantic meaning!

Anyway, git-cvsimport knows about a magic file ("CVSROOT/users") that can 
map user names into full names and emails. Having soemthing equvalent 
for a SVN import would be nice (git-svnimport does the same thing, and 
uses ".git/svn-authors" as the default source of author name conversion 
data).

>    b. CVS tag/branch creation events do not even include a username.
> Any suggestions for what to use here?

Git tags and branch creation doesn't do that either (unless you use signed 
tags): only when you create the first commit on a branch does the user 
matter.

But if there really is data that doesn't have any user information at all 
(for real *changes*), then I'd just make one up. Again, the user 
information really doesn't have any *semantics* in git, it's just meant to 
be informational for showing the logs. It's nothing more than a structured 
part of the commit (or tag) message.

> 3. I expect we should set 'committer' to the value determined from CVS
> and leave 'author' unused.  But I suppose another possibility would be
> to set the 'committer' to 'cvs2svn' and the 'author' to the original CVS
> author.  Which one makes sense?

Just make them be the same. Git-fast-import will default to that, if you 
only give a committer date/name.

That's what git itself does if you just do a "git commit": the committer 
will the the same as the author.

> 4. It appears that a commit can only have a single 'from'

No, commits can have an arbitrary number of parents, and if you create a 
tag where the data comes from several sources, you could literally do that 
ass a really strange merge, and that would probably be the most "correct" 
thing to do, even if it might end up looking *really* odd.

[ To be strictly technically correct, I have to admit that I think we 
  limit the number of parents to 16, but that's not a fundamental limit, 
  that's just because nobody has ever been so crazy as to need more than 
  that.

  However, there is no "data structure limit" in that number, it's just aa 
  arbitrary "you'd be crazy to generate a merge of that many parents" kind 
  of thing, and we could lift the limit if you actually think it's worth 
  it.

  I think the most we have ever seen in practice is a merge of 12 parents, 
  and the people who did that were told to please not do it again, because 
  it really does make the graph look extremely "cool". ]

> What would be the most git-like way to handle this situation?  Should 
> the branch be created in one commit, then have files from other sources 
> added to it in other commits?  Or should (is this even possible?) all 
> files be added to the branch in a single commit, using multiple "merge" 
> sources?

Using multiple parents and just generating a single commit (it will be 
called a "merge", but really, in git terms a commit is just a commit, and 
the difference in number of parents is really not a _technical_ 
difference, it's just a difference for how these things get visualized).

It would be extremely interesting to see how this works in practice, but I 
_think_ it would work really well. The possible downsides might be:

 - it *may* just end up looking so confusing that people would prefer some 
   alternate model.

 - we might have some performance issues with lots and lots of parents, 
   and maybe we'd need to fix something. In particular, I can well imagine 
   that showing the diff for the end result would be "interesting" (read: 
   "totally useless")

> 5. Is there any significance at all to the order that commits are output
> to git-fast-import?  Obviously, blobs have to be defined before they are
> used, and '<committish>'s have to be defined before they are referenced.
>  But is there any other significance to the order of commits?

Not afaik. Git internally very fundamentally simply doesn't care (there 
simply _is_ no object ordering, there is just objects that point to other 
objects), and I don't think git-fast-import could possibly care either. 
You do need to be "topologically" sorted (since you cannot even point to 
commits without having their SHA1's), but that should be it.

		Linus
