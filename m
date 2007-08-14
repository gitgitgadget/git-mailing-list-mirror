From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 09:14:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708140853500.30176@woody.linux-foundation.org>
References: <1187080681.12828.174.camel@chaos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 18:17:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKz50-0004uv-Gu
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 18:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757846AbXHNQRH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 12:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758132AbXHNQRF
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 12:17:05 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40684 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757604AbXHNQRD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2007 12:17:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7EGEZI4001762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Aug 2007 09:14:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7EGEUDl024396;
	Tue, 14 Aug 2007 09:14:30 -0700
In-Reply-To: <1187080681.12828.174.camel@chaos>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55839>



On Tue, 14 Aug 2007, Thomas Gleixner wrote:
>
> is there a built in way to handle the following situation:
> 
> file A is renamed to B
> file A is created again and new content is added.

That "should just work".

[ However, there does seem to be a bug in the "-B" logic, so it doesn't 
  actually work as well as it should! See below ]

BUT! By default, rename detection isn't on at all, mostly because it 
results in patches that non-git "patch" cannot apply, but partly also 
because it can slow certain things down.

So to get nice diffs, use

	git show -B -C

where the magic is:

 - "-B" means "break file associations when a file is *too* dissimilar" 

   Normally, git will assume that if a filename stays around, it's the 
   same file. However, with "-B", it does similarity analysis even for 
   files that are the same, and if they are very different, git will 
   decide that maybe they weren't the same file after all!

 - "-C" is "find code movement and copying".

However, nobody ever actually uses "-B" (it's so rare as to effectively 
not exist, and it does slow things down a bit), so it seems to have 
bit-rotted (or maybe it had this bug even originally: as I said, I don't 
think anybody has ever really _used_ this functionality).

Junio, look at this:

	# create a repo in "testing"
	cd
	mkdir testing
	cd testing/
	git init

	# copy a file from the git repo
	cp ~/git/revision.c .
	git add revision.c
	git commit -a -m "Add file 'A'"

	# move it around, copy another file in its stead
	git mv revision.c old-revision.c
	cp ~/git/Makefile revision.c
	git add revision.c
	git commit -a -m "Move file 'A' to 'B', create new 'A'"
	git show -B -C

and notice how "-B" *did* actually work, and we get a nice:

	diff --git a/revision.c b/old-revision.c
	similarity index 100%
	rename from revision.c
	rename to old-revision.c

but then it breaks: instead of creating the new "revision.c", we get:

	diff --git a/revision.c b/revision.c
	dissimilarity index 98%
	index 038693c..4eb4637 100644
	--- a/revision.c
	+++ b/revision.c
	@@ -1,1572 +1,1117 @@
	-#include "cache.h"
	...

which uses "reivision.c" as the base, even though it was already broken 
up! I think it *should* have looked like

	diff --git a/old-revision.c b/old-revision.c
	new file mode 100644
	index 0000000..4eb4637
	--- /dev/null
	+++ b/revision.c
	+# The default target of this Makefile is...
	...

so I think there is a bug there where the "-B" thing doesn't really 
"stick", and some part still uses the old file content even though it was 
dis-associated with the new content!

Hmm?

			Linus
