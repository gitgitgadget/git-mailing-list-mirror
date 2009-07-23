From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 12:05:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <7vtz146mgr.fsf@alter.siamese.dyndns.org> <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 21:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU3cE-0002Ie-Br
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 21:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbZGWTF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 15:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbZGWTF6
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 15:05:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58398 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752434AbZGWTF6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 15:05:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NJ5Pv2023438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Jul 2009 12:05:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6NJ5ONN029473;
	Thu, 23 Jul 2009 12:05:24 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090723165335.GA15598@Pilar.aei.mpg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123888>



On Thu, 23 Jul 2009, Carlos R. Mafra wrote:
>
> Everytime I did the first 'git branch' those 5 seconds really hurt, because
> I wondered why it couldn't be done in 0s like subsequent commands.
> 
> But sure, this was definitely not a pressing issue and your patch made
> it even less. I am happy that it takes 1s now, and I really appreciated
> your patch! 

You could try something like this (on _top_ of the previous patch). 

Not very exhaustively tested, but it's pretty simple.

It will still do _some_ object lookups. In particular, it will do the HEAD 
lookup in 'print_ref_list()', even if it's not strictly necessary. But it 
should cut down the noise further.

		Linus

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
