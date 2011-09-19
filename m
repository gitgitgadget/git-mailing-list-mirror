From: Jeff King <peff@peff.net>
Subject: Re: how to remove unreachable objects?
Date: Mon, 19 Sep 2011 16:18:04 -0400
Message-ID: <20110919201804.GB31930@sigill.intra.peff.net>
References: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
 <20110919195335.GA31930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: dieter@schoen.or.at
X-From: git-owner@vger.kernel.org Mon Sep 19 22:18:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5kI8-0002Yd-P4
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 22:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608Ab1ISUSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 16:18:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37593
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792Ab1ISUSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 16:18:06 -0400
Received: (qmail 8490 invoked by uid 107); 19 Sep 2011 20:23:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 16:23:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 16:18:04 -0400
Content-Disposition: inline
In-Reply-To: <20110919195335.GA31930@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181701>

On Mon, Sep 19, 2011 at 03:53:36PM -0400, Jeff King wrote:

> > git fsck --unreachable HEAD \
> >                     $(git for-each-ref --format="%(objectname)" refs/heads)
> 
> And this shows it as unreachable, because you are asking git to only
> look at the branch tips and HEAD (by default, it looks at all refs and
> reflogs).
> 
> I suspect you copied this straight from the git-fsck manpage. That
> advice is a bit outdated, I think. It blames (in some form) all the way
> back to the original documentation added in c64b9b8 (2005-05-05, only a
> few weeks after git was born). A few weeks later, fsck learned to
> default to looking at all refs (1024932, 2005-05-18). And then other
> sane defaults like reflogs got tacked on later (reflogs came around the
> 1.4.x era, in 2006).

So we should probably do something like this:

-- >8 --
Subject: [PATCH] docs: brush up obsolete bits of git-fsck manpage

After the description and options, the fsck manpage contains
some discussion about what it does. Over time, this
discussion has become somewhat obsolete, both in content and
formatting. In particular:

  1. There are many options now, so starting the discussion
     with "It tests..." makes it unclear whether we are
     talking about the last option, or about the tool in
     general. Let's start a new "discussion" section and
     make our antecedent more clear.

  2. It gave an example for --unreachable using for-each-ref
     to mention all of the heads, saying that it will do "a
     _lot_ of verification". This is hopelessly out-of-date,
     as giving no arguments will check much more (reflogs,
     the index, non-head refs).

  3. It goes on to mention tests "to be added" (like tree
     object sorting). We now have these tests.

Signed-off-by: Jeff King <peff@peff.net>
---
I was tempted to just drop this section entirely. It's mostly redundant
with the DESCRIPTION section, and any extra details could be folded in
there. The most useful bit is the "what do you do when there is
corruption". But that should perhaps get its own section, if somebody
feels like writing something more detailed (I thought we had a guide
somewhere, but I couldn't find it).

 Documentation/git-fsck.txt |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index a2a508d..55b33d7 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -72,30 +72,20 @@ index file, all SHA1 references in .git/refs/*, and all reflogs (unless
 	a blob, the contents are written into the file, rather than
 	its object name.
 
-It tests SHA1 and general object sanity, and it does full tracking of
-the resulting reachability and everything else. It prints out any
-corruption it finds (missing or bad objects), and if you use the
-'--unreachable' flag it will also print out objects that exist but
-that aren't reachable from any of the specified head nodes.
-
-So for example
-
-	git fsck --unreachable HEAD \
-		$(git for-each-ref --format="%(objectname)" refs/heads)
+DISCUSSION
+----------
 
-will do quite a _lot_ of verification on the tree. There are a few
-extra validity tests to be added (make sure that tree objects are
-sorted properly etc), but on the whole if 'git fsck' is happy, you
-do have a valid tree.
+git-fsck tests SHA1 and general object sanity, and it does full tracking
+of the resulting reachability and everything else. It prints out any
+corruption it finds (missing or bad objects), and if you use the
+'--unreachable' flag it will also print out objects that exist but that
+aren't reachable from any of the specified head nodes (or the default
+set, as mentioned above).
 
 Any corrupt objects you will have to find in backups or other archives
 (i.e., you can just remove them and do an 'rsync' with some other site in
 the hopes that somebody else has the object you have corrupted).
 
-Of course, "valid tree" doesn't mean that it wasn't generated by some
-evil person, and the end result might be crap. git is a revision
-tracking system, not a quality assurance system ;)
-
 Extracted Diagnostics
 ---------------------
 
-- 
1.7.7.rc1.3.gb95be
