From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Segmentation fault in git read-tree
Date: Thu, 13 Mar 2008 21:37:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803132136080.3557@woody.linux-foundation.org>
References: <200803132359.06745.lenb@kernel.org> <alpine.LFD.1.00.0803132125280.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Len Brown <lenb@kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:39:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1hC-00077U-JP
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYCNEi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbYCNEi1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:38:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50552 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078AbYCNEi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 00:38:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2E4cZLv010062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Mar 2008 21:38:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2E4be7P017031;
	Thu, 13 Mar 2008 21:37:41 -0700
In-Reply-To: <alpine.LFD.1.00.0803132125280.3557@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.342 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77169>



On Thu, 13 Mar 2008, Linus Torvalds wrote:
> 
> Ok, I can reproduce this, I'm on it like a maggot on a two-week-dead baby 
> donkey.

Ok, that was embarrassing.

This should fix it. Spot the stupid stack corruption..

		Linus

---
 unpack-trees.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index be89d52..b62b054 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,8 @@
 #include "progress.h"
 #include "refs.h"
 
+#define MAX_UNPACK_TREES 4
+
 static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 	unsigned int set, unsigned int clear)
 {
@@ -123,7 +125,7 @@ static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_option
 int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long df_conflicts, struct name_entry *names, struct traverse_info *info)
 {
 	int i;
-	struct tree_desc t[3];
+	struct tree_desc t[MAX_UNPACK_TREES];
 	struct traverse_info newinfo;
 	struct name_entry *p;
 
@@ -327,7 +329,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 {
 	static struct cache_entry *dfc;
 
-	if (len > 4)
+	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most four trees");
 	memset(&state, 0, sizeof(state));
 	state.base_dir = "";
