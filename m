From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/5] Split-up "unpack_trees()" cleanup series
Date: Thu, 6 Mar 2008 18:04:17 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803061759430.12253@woody.linux-foundation.org>
References: <cover.1204777699.git.torvalds@linux-foundation.org> <alpine.LNX.1.00.0803061901480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 03:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXRxu-0004xQ-Mk
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 03:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbYCGCEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 21:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbYCGCEY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 21:04:24 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37694 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751979AbYCGCEX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 21:04:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2724fAW009547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Mar 2008 18:04:42 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2724HdK032063;
	Thu, 6 Mar 2008 18:04:18 -0800
In-Reply-To: <alpine.LNX.1.00.0803061901480.19665@iabervon.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.038 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76450>



On Thu, 6 Mar 2008, Daniel Barkalow wrote:
>
> On Wed, 5 Mar 2008, Linus Torvalds wrote:
> > 
> > It's a series of five patches:
> >  -  Add 'df_name_compare()' helper function
> >  - Make 'traverse_tree()' use linked structure rather than 'const char *base'
> >  - Add return value to 'traverse_tree()' callback
> >  - Make 'traverse_trees()' traverse conflicting DF entries in parallel
> >  - Move 'unpack_trees()' over to 'traverse_trees()' interface
> 
> This all looks good to me.

There's a really stupid bug in function that compares filenames using 
the the linked list structure which makes it not compare the first path 
component when using "--prefix".

So it can only hit in the case of us having a "prefix" entry that makes 
the name of the "root" info structure non-empty, and I suspect that 
because of all the other horrid crud we do for --prefix=xyzzy handling in 
builtin-read-tree.c you can't actually trigger this bug, but my other 
cleanups (which I'll send out once I've tested them a bit more) will make 
this bug trigger.

This fairly obvious patch fixes it by just making sure that we always end 
up having a ->prev entry if we have a pathname component.

			Linus

---
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu Mar 6 15:44:48 2008 -0800

Fix tree-walking compare_entry() in the presense of --prefix

When we make the "root" tree-walk info entry have a pathname in it, we
need to have a ->prev pointer so that compare_entry will actually notice
and traverse into the root.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 tree-walk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 842cb6a..02e2aed 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -107,6 +107,7 @@ int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 void setup_traverse_info(struct traverse_info *info, const char *base)
 {
 	int pathlen = strlen(base);
+	static struct traverse_info dummy;
 
 	memset(info, 0, sizeof(*info));
 	if (pathlen && base[pathlen-1] == '/')
@@ -114,6 +115,8 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
 	info->pathlen = pathlen ? pathlen + 1 : 0;
 	info->name.path = base;
 	info->name.sha1 = (void *)(base + pathlen + 1);
+	if (pathlen)
+		info->prev = &dummy;
 }
 
 char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n)
