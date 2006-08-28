From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb filter for patches by a specific person in a specific
 timeframe
Date: Mon, 28 Aug 2006 12:04:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608281147420.27779@g5.osdl.org>
References: <200608281459.26643.kai.blin@gmail.com>
 <20060828181626.GB2950@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kai Blin <kai.blin@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 21:05:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHmPq-0000sM-GF
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 21:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWH1TEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 15:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWH1TEd
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 15:04:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751191AbWH1TEc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 15:04:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7SJ4TnW020577
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Aug 2006 12:04:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7SJ4SrN010093;
	Mon, 28 Aug 2006 12:04:28 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060828181626.GB2950@coredump.intra.peff.net>
X-Spam-Status: No, hits=-0.436 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26176>



On Mon, 28 Aug 2006, Jeff King wrote:
> 
> You can create an mbox of all of the changes you made. Unfortunately
> git-rev-list doesn't do author/committer matching, so you'll need a
> short perl script:

The author/committer matching is something that people have talked about 
for a long time, so maybe we should just add it? 

It shouldn't be that hard at all. Just add logic to revision.c: 
get_revision(), something like the appended (fleshed out and fixed, of 
course, with all the command line flags added to actually allow setting of 
"revs->author_pattern" etc..)

A good thing for some beginning git hacker to try doing. Hint, hint.

(The only subtle thing might be to make sure that "save_commit_buffer" is 
set if author/committer matching is on, so that the "commit->buffer" thing 
is actually saved after parsing, so that you can match it)

This trivial approach doesn't allow "gitk" to show the results sanely, 
though (to do that, you'd need to make the commit matching be part of the 
parent simplification instead - that would be extra bonus points for the 
intrpid git hacker-wannabe)

		Linus
---

diff --git a/revision.c b/revision.c
index 1d89d72..88cc1e3 100644
--- a/revision.c
+++ b/revision.c
@@ -1011,6 +1011,13 @@ static void mark_boundary_to_show(struct
 	}
 }
 
+static int commit_match(struct commit *commit, const char *field, const char *pattern)
+{
+	if (!pattern)
+		return 1;
+	.. match it here ..
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -1070,6 +1077,10 @@ struct commit *get_revision(struct rev_i
 		if (revs->no_merges &&
 		    commit->parents && commit->parents->next)
 			continue;
+		if (!commit_match(commit, "author", revs->author_pattern))
+			continue;
+		if (!commit_match(commit, "committer", revs->committer_pattern))
+			continue;
 		if (revs->prune_fn && revs->dense) {
 			/* Commit without changes? */
 			if (!(commit->object.flags & TREECHANGE)) {
