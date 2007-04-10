From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/6] Initial subproject support (RFC?)
Date: Mon, 9 Apr 2007 21:12:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:00:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb7jJ-0006Oa-Sm
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 06:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbXDJEM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 00:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933030AbXDJEMz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 00:12:55 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42912 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933020AbXDJEMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 00:12:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3A4CpPD025536
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Apr 2007 21:12:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3A4CosQ030987;
	Mon, 9 Apr 2007 21:12:51 -0700
X-Spam-Status: No, hits=-0.953 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44106>


Ok, the following is a series of six patches that implement some very 
low-level plumbing for what I consider sane subproject support.

NOTE! I want to make it very clear that this series of patches does not 
make subprojects "usable". They are very core plumbing that allows people 
to think about the issues, and shows how the low-level code could (and in 
my opinion, should) be done.

Some of the early patches are just cleanups and very basic stuff required 
to actually get to the meat of it all. I actually think that they are all 
in a state where they could be applied, if only because they don't 
actually really *do* anything unless you start generating index files 
entries (and trees) that have the "gitlink" entries in them.

I've actually done some testing with a repository that has these kinds of 
subproject pointers in them, and no, it's really not fully fleshed out 
yet, but yes, I can actually do a commit in one of the subprojects, and 
when I do that, the "raw" diff literally looks like this:

	[torvalds@woody superproject]$ git diff --raw
	:160000 160000 5813084832d3c680a3436b0253639c94ed55445d 0000000... M    sub-B

and I can do a "git commit -a" in the superproject to commit the new 
state.

NOTE! This series of six patches does not actually contain everything you 
need to do that - in particular, this series will not actually connect up 
the magic to make "git add" (and thus "git commit") actually create the 
gitlink entries for subprojects. That's another (quite small) patch, but I 
haven't cleaned it up enough to be submittable yet.

I split my original larger patch up into more manageable pieces, so that 
you should be able to actually just read the patches themselves and get a 
reasonable idea about what it's doing, even *without* actually testing it. 
And obviously, "make test" still completes happily, if only because none 
of the tests actually trigger any of the new code.

The patches are all fairly small, and the two first ones are really just 
totally independent cleanups/fixes:

 - diff-lib: use ce_mode_from_stat() rather than messing with modes manually:

	 diff-lib.c |   15 +++------------
	 1 files changed, 3 insertions(+), 12 deletions(-)

 - Avoid overflowing name buffer in deep directory structures:

	 dir.c |    3 +++
	 1 files changed, 3 insertions(+), 0 deletions(-)

 - Add 'resolve_gitlink_ref()' helper function:

	 refs.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	 refs.h |    3 ++
	 2 files changed, 82 insertions(+), 0 deletions(-)

 - Add "S_IFDIRLNK" file mode infrastructure for git links:

	 cache.h |   20 +++++++++++++++++++-
	 1 files changed, 19 insertions(+), 1 deletions(-)

 - Teach "fsck" not to follow subproject links:

	 builtin-fsck.c |    9 ++++++++-
	 tree.c         |   15 ++++++++++++++-
	 2 files changed, 22 insertions(+), 2 deletions(-)

 - Teach core object handling functions about gitlinks:

	 builtin-ls-tree.c |   20 +++++++++++++++++++-
	 cache-tree.c      |    2 +-
	 read-cache.c      |   35 +++++++++++++++++++++++++++++++----
	 sha1_file.c       |    3 +++
	 4 files changed, 54 insertions(+), 6 deletions(-)

and will follow in the next few emails..

			Linus
