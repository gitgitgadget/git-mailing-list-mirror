From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] git branch: avoid unnecessary object lookups
Date: Thu, 23 Jul 2009 12:18:56 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907231218250.21520@localhost.localdomain>
References: <alpine.LFD.2.01.0907231216550.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 21:19:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU3pI-0000Uq-0l
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 21:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbZGWTT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 15:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbZGWTT1
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 15:19:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42405 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752977AbZGWTT1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 15:19:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NJIu53024620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Jul 2009 12:18:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NJIuHZ018337;
	Thu, 23 Jul 2009 12:18:56 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907231216550.21520@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.96 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123891>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Jul 2009 12:05:34 -0700

They can be expensive in the cold-cache case, so don't bother looking up
the commits for all branches unless we really need them for some reason.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-branch.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 54a89ff..82c2cf0 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -191,7 +191,7 @@ struct ref_item {
 
 struct ref_list {
 	struct rev_info revs;
-	int index, alloc, maxwidth;
+	int index, alloc, maxwidth, verbose;
 	struct ref_item *list;
 	struct commit_list *with_commit;
 	int kinds;
@@ -244,17 +244,20 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
-	commit = lookup_commit_reference_gently(sha1, 1);
-	if (!commit)
-		return error("branch '%s' does not point at a commit", refname);
+	commit = NULL;
+	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
+		commit = lookup_commit_reference_gently(sha1, 1);
+		if (!commit)
+			return error("branch '%s' does not point at a commit", refname);
 
-	/* Filter with with_commit if specified */
-	if (!is_descendant_of(commit, ref_list->with_commit))
-		return 0;
+		/* Filter with with_commit if specified */
+		if (!is_descendant_of(commit, ref_list->with_commit))
+			return 0;
 
-	if (merge_filter != NO_FILTER)
-		add_pending_object(&ref_list->revs,
-				   (struct object *)commit, refname);
+		if (merge_filter != NO_FILTER)
+			add_pending_object(&ref_list->revs,
+					   (struct object *)commit, refname);
+	}
 
 	/* Resize buffer */
 	if (ref_list->index >= ref_list->alloc) {
@@ -423,6 +426,7 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
+	ref_list.verbose = verbose;
 	ref_list.with_commit = with_commit;
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
-- 
1.6.4.rc1.2.gdf1f0
