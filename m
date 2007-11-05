From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Enhance --early-output format
Date: Mon, 5 Nov 2007 13:35:31 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711051328140.15101@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
 <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
 <7vsl3kphjp.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0711051233270.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711051313350.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9dC-0006wv-8D
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbXKEVgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbXKEVgy
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:36:54 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48354 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754330AbXKEVgx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 16:36:53 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA5LZWPA030361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Nov 2007 13:35:33 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA5LZV8o020799;
	Mon, 5 Nov 2007 13:35:32 -0800
In-Reply-To: <alpine.LFD.0.999.0711051313350.15101@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.238 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63560>



On Mon, 5 Nov 2007, Linus Torvalds wrote:
> 
> Here's a possible cleanup patch. It's on top of the enhanced 
> --early-output format commit, and in fact fixes a stupid bug in that 
> commit ("return -1" vs "return NULL"), but that bug-fix is really an 
> independent thing.

.. and this extends a bit further on the notion.

It basically means that "rev->dense" can now be ignored outside of 
revision.c, because we'll just set TREECHANGE automatically when 
seeing a non-merge regular commit when --sparse is being used.

So it's not just a simplification, it's a performance optimization too! 

Although since nobody sane would ever use --sparse, I guess nobody really 
cares.

		Linus

---
 builtin-log.c |    8 ++------
 revision.c    |    9 +++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 76c84e2..d6845bc 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -88,13 +88,9 @@ static int estimate_commit_count(struct rev_info *rev, struct commit_list *list)
 	while (list) {
 		struct commit *commit = list->item;
 		unsigned int flags = commit->object.flags;
-
 		list = list->next;
-		if (flags & UNINTERESTING)
-			continue;
-		if (!(flags & TREECHANGE) && rev->dense && single_parent(commit))
-			continue;
-		n++;
+		if ((flags & TREECHANGE) && !(flags & UNINTERESTING))
+			n++;
 	}
 	return n;
 }
diff --git a/revision.c b/revision.c
index 7a1ecba..02e9241 100644
--- a/revision.c
+++ b/revision.c
@@ -325,6 +325,15 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		return;
 	}
 
+	/*
+	 * Normal non-merge commit? If we don't want to make the 
+	 * history dense, we consider it always to be a change..
+	 */
+	if (!revs->dense && !commit->parents->next) {
+		commit->object.flags |= TREECHANGE;
+		return;
+	}
+
 	pp = &commit->parents;
 	while ((parent = *pp) != NULL) {
 		struct commit *p = parent->item;
