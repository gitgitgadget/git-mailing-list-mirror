From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 19:23:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 04:24:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTnys-00071s-F6
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 04:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbZGWCYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 22:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbZGWCYR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 22:24:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51074 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752221AbZGWCYR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 22:24:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N2NeIB031056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 19:23:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N2Nddb009839;
	Wed, 22 Jul 2009 19:23:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123822>



On Wed, 22 Jul 2009, Linus Torvalds wrote:
> 
> Ooh yes. That would do it. It's going to peel and look up every single ref 
> it finds, so it's going to look up _hundreds_ of objects (all the tags, 
> all the commits they point to, etc etc). Even if it then only shows a 
> couple of branches.
> 
> Junio, any ideas?

I had one of my own.

Does this fix it?

It uses the "raw" version of 'for_each_ref()' (which doesn't verify that 
the ref is valid), and then does the "type verification" before it starts 
doing any gentle commit lookup.

That should hopefully mean that it no longer does tons of object lookups 
on refs that it's not actually interested in. 

		Linus

---
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
