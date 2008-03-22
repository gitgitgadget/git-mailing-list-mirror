From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 7/7] Make unpack-tree update removed files before any updated
 files
Date: Sat, 22 Mar 2008 10:45:05 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803221038320.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221021220.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221022480.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221025410.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803221028170.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221030380.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank <streamlake@tiscali.it>, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:46:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7nC-0000fa-TF
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbYCVRpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753719AbYCVRpX
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:45:23 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36314 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753675AbYCVRpX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Mar 2008 13:45:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHj7T2003373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Mar 2008 10:45:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2MHj5Rr020082;
	Sat, 22 Mar 2008 10:45:06 -0700
In-Reply-To: <alpine.LFD.1.00.0803221033430.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.755 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77835>


From: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date: Sat, 22 Mar 2008 09:48:41 -0700

This is immaterial on sane filesystems, but if you have a broken (aka
case-insensitive) filesystem, and the objective is to remove the file
'abc' and replace it with the file 'Abc', then we must make sure to do
the removal first.

Otherwise, you'd first update the file 'Abc' - which would just
overwrite the file 'abc' due to the broken case-insensitive filesystem -
and then remove file 'abc' - which would now brokenly remove the just
updated file 'Abc' on that broken filesystem.

By doing removals first, this won't happen.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Ok, this one looks - and is, really - trivial, but it's actually the only 
one in the whole series that I'm even remotely nervous about. First off, 
it actually does what it does regardless of that "core.ignorecase" 
variable, but that wouldn't worry me if it wasn't for the fact that I 
don't remember/understand what the heck that "last_symlink" logic was 
there for.

I *think* the logic is only for removal, and that splitting up the single 
loop to be two loops is totally safe and actually cleans things up, but I 
really want somebody to take a look at this. 

This patch is important, because without it you can't reliably switch 
between branches with case-aliases on a case-insensitive filesystem, and 
strictly speaking I should have put it before the previous patch, but I 
put it last because of this worry of mine. Patches 1-6 I think are totally 
obvious and ready to go at any point. This one I really want Junio to 
double-check.

The patch itself is really really trivial. We used to do both removal and 
file updates in one phase, we just split it into two. So I don't worry 
about the code, I only worry about that "last_symlink" thing.

Anyway, this concludes the series. It's not _complete_ - the 
case-independent compare function is a joke and only gets US-ASCII 
correct, and there are other cases we will want to fix up. But in the end, 
I think this series of seven trivial patches really does make git somewhat 
aware of broken filesystems at a very core level.

 unpack-trees.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 95d3413..feae846 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -79,16 +79,21 @@ static int check_updates(struct unpack_trees_options *o)
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
-		if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
-			display_progress(progress, ++cnt);
 		if (ce->ce_flags & CE_REMOVE) {
+			display_progress(progress, ++cnt);
 			if (o->update)
 				unlink_entry(ce->name, last_symlink);
 			remove_index_entry_at(&o->result, i);
 			i--;
 			continue;
 		}
+	}
+
+	for (i = 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce = index->cache[i];
+
 		if (ce->ce_flags & CE_UPDATE) {
+			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update) {
 				errs |= checkout_entry(ce, &state, NULL);
-- 
1.5.5.rc0.28.g61a0.dirty
