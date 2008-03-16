From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Don't update unchanged merge entries
Date: Sun, 16 Mar 2008 11:42:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803161136060.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 19:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jaxqy-0000AH-W8
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 19:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbYCPSo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 14:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbYCPSoI
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 14:44:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45424 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752652AbYCPSoA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2008 14:44:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GIhtQA000728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Mar 2008 11:43:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GIgo0j008626;
	Sun, 16 Mar 2008 11:42:50 -0700
In-Reply-To: <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.294 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77372>


In commit 34110cd4e394e3f92c01a4709689b384c34645d8 ("Make 'unpack_trees()' 
have a separate source and destination index") I introduced a really 
stupid bug in that it would always add merged entries with the CE_UPDATE 
flag set. That caused us to always re-write the file, even when it was 
already up-to-date in the source index.

Not only is that really stupid from a performance angle, but more 
importantly it's actively wrong: if we have dirty state in the tree when 
we merge, overwriting it with the result of the merge will incorrectly 
overwrite that dirty state.

This trivially fixes the problem - simply don't set the CE_UPDATE flag 
when the merge result matches the old state.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Ok, that was a really stupid one. 

On Sun, 16 Mar 2008, Linus Torvalds wrote:
> 
> Nope, I bisected it down to
> 
> 	34110cd4e394e3f92c01a4709689b384c34645d8 is first bad commit
> 
> 	Make 'unpack_trees()' have a separate source and destination index
> 
> and I'm trying to figure out what part of that triggered this bug.

 unpack-trees.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 0cdf198..46d4f6c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -593,6 +593,8 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		struct unpack_trees_options *o)
 {
+	int update = CE_UPDATE;
+
 	if (old) {
 		/*
 		 * See if we can re-use the old CE directly?
@@ -603,6 +605,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		 */
 		if (same(old, merge)) {
 			copy_cache_entry(merge, old);
+			update = 0;
 		} else {
 			if (verify_uptodate(old, o))
 				return -1;
@@ -615,7 +618,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		invalidate_ce_path(merge, o);
 	}
 
-	add_entry(o, merge, CE_UPDATE, CE_STAGEMASK);
+	add_entry(o, merge, update, CE_STAGEMASK);
 	return 1;
 }
 
