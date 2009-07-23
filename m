From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] git branch: fix performance problem
Date: Thu, 23 Jul 2009 12:18:15 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907231216550.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 21:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU3oe-0000EQ-TY
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 21:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZGWTSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 15:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbZGWTSr
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 15:18:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51607 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752493AbZGWTSq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 15:18:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NJIFql024573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Jul 2009 12:18:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NJIFCm017297;
	Thu, 23 Jul 2009 12:18:15 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.96 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123890>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Jul 2009 10:17:04 -0700

'git branch' looks at _all_ the refs, and verifies them.  Which means that 
during cold-cache situations with a slow disk (and lots of tags, for 
example) it can take several very annoying seconds (7.5s according to a 
report by Carlos R.  Mafra).

This avoids most of it by simply doing the filtering before looking up
the commits, by using the "raw" version of for_each_ref.

Reported-by: Carlos R. Mafra <crmafra2@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Ok, this is just a resend of the patches I've sent out, as a proper patch 
series, with sign-offs etc.

 builtin-branch.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 5687d60..54a89ff 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -240,6 +240,10 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if (ARRAY_SIZE(ref_kind) <= i)
 		return 0;
 
+	/* Don't add types the caller doesn't want */
+	if ((kind & ref_list->kinds) == 0)
+		return 0;
+
 	commit = lookup_commit_reference_gently(sha1, 1);
 	if (!commit)
 		return error("branch '%s' does not point at a commit", refname);
@@ -248,10 +252,6 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if (!is_descendant_of(commit, ref_list->with_commit))
 		return 0;
 
-	/* Don't add types the caller doesn't want */
-	if ((kind & ref_list->kinds) == 0)
-		return 0;
-
 	if (merge_filter != NO_FILTER)
 		add_pending_object(&ref_list->revs,
 				   (struct object *)commit, refname);
@@ -426,7 +426,7 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	ref_list.with_commit = with_commit;
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
-	for_each_ref(append_ref, &ref_list);
+	for_each_rawref(append_ref, &ref_list);
 	if (merge_filter != NO_FILTER) {
 		struct commit *filter;
 		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
-- 
1.6.4.rc1.2.gdf1f0
