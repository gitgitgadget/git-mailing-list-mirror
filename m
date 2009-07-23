From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 12:13:41 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <7vtz146mgr.fsf@alter.siamese.dyndns.org> <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 21:16:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU3m5-00078n-3Z
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 21:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZGWTQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 15:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbZGWTQG
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 15:16:06 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58506 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752977AbZGWTQF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 15:16:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NJDfdS024178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Jul 2009 12:13:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NJDfoM010051;
	Thu, 23 Jul 2009 12:13:41 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123889>



On Thu, 23 Jul 2009, Linus Torvalds wrote:
> 
> You could try something like this (on _top_ of the previous patch). 
> 
> Not very exhaustively tested, but it's pretty simple.
> 
> It will still do _some_ object lookups. In particular, it will do the HEAD 
> lookup in 'print_ref_list()', even if it's not strictly necessary. But it 
> should cut down the noise further.

And this (on top of them all) will basically avoid even that one.

In fact, I think this is a cleanup. I think I'll resubmit the whole series 
with proper commit messages etc.

		Linus

---
 builtin-branch.c |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 82c2cf0..1a03d5f 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -191,7 +191,7 @@ struct ref_item {
 
 struct ref_list {
 	struct rev_info revs;
-	int index, alloc, maxwidth, verbose;
+	int index, alloc, maxwidth, verbose, abbrev;
 	struct ref_item *list;
 	struct commit_list *with_commit;
 	int kinds;
@@ -418,15 +418,34 @@ static int calc_maxwidth(struct ref_list *refs)
 	return w;
 }
 
+
+static void show_detached(struct ref_list *ref_list)
+{
+	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
+
+	if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
+		struct ref_item item;
+		item.name = xstrdup("(no branch)");
+		item.len = strlen(item.name);
+		item.kind = REF_LOCAL_BRANCH;
+		item.dest = NULL;
+		item.commit = head_commit;
+		if (item.len > ref_list->maxwidth)
+			ref_list->maxwidth = item.len;
+		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
+		free(item.name);
+	}
+}
+
 static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
 {
 	int i;
 	struct ref_list ref_list;
-	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
 	ref_list.verbose = verbose;
+	ref_list.abbrev = abbrev;
 	ref_list.with_commit = with_commit;
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
@@ -446,19 +465,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && head_commit &&
-	    is_descendant_of(head_commit, with_commit)) {
-		struct ref_item item;
-		item.name = xstrdup("(no branch)");
-		item.len = strlen(item.name);
-		item.kind = REF_LOCAL_BRANCH;
-		item.dest = NULL;
-		item.commit = head_commit;
-		if (item.len > ref_list.maxwidth)
-			ref_list.maxwidth = item.len;
-		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1, "");
-		free(item.name);
-	}
+	if (detached)
+		show_detached(&ref_list);
 
 	for (i = 0; i < ref_list.index; i++) {
 		int current = !detached &&
