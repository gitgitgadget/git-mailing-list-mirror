From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Also use unpack_trees() in do_diff_cache()
Date: Sun, 20 Jan 2008 12:32:56 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801201144300.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LSU.1.00.0801201515060.5731@racer.site> <alpine.LSU.1.00.0801201519320.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 21:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGgrb-0005uG-B1
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 21:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbYATUd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 15:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755170AbYATUd1
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 15:33:27 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33686 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755138AbYATUd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 15:33:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KKWvT7025993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Jan 2008 12:32:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KKWuhM001814;
	Sun, 20 Jan 2008 12:32:56 -0800
In-Reply-To: <alpine.LSU.1.00.0801201519320.5731@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.721 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71190>



On Sun, 20 Jan 2008, Johannes Schindelin wrote:
> 
> As in run_diff_index(), we call unpack_trees() with the oneway_diff()
> function in do_diff_cache() now.  This makes the function diff_cache()
> obsolete.

Sadly, this doesn't work yet.

diiff_cache() does magic things with different stages. 

The new unpack_trees() model *should* make it possible to do an even 
better job at this (we should really approximate the diff_files() 
behaviour), but oneway_diff() currently doesn't do it right.

Try

	git diff-index [-p] [--cached] -m HEAD

in a tree with unmerged entries (or just "git diff HEAD", which does the 
same thing).

The following patch gets us closer, but really only for the "--cached" 
case (for the non-cached case, it should use the working tree entry ratehr 
than generate a unmerged entry), and I also suspect there's a case it gets 
wrong for the case of the unmerged path not existign in the tree at all 
(the "if (tree)" entry basically ends up being a stand-in for the "is this 
the first index entry for this path we see" case).

The really nice thing would be to do what "diff_files()" does for this 
all, something that the old model couldn't do at all (that's why it 
currently prints out that "* Unmerged path xyzzy" thing - the *correct* 
thing to do would be to generate the same combined diff that diff_files() 
does).

So some more work is needed - either to get back the old (arguably 
quite broken) behaviour, or to go the whole way and do it right.

Anyway, my point with this all is that even without any of this set of 
fixes, git doesn't do this optimally. Try this with the current stable git 
master:

	git diff --cached HEAD

with a unmerged file, and compare it to the much more useful "git diff" 
output. But right now, this patch series makes this case behave even 
worse, I think.

		Linus

---
 diff-lib.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 23d0fa6..3ac4d1f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -685,6 +685,12 @@ static int oneway_diff(struct cache_entry **src,
 	if (tree == o->df_conflict_entry)
 		tree = NULL;
 
+	if (ce_stage(idx)) {
+		if (tree)
+			diff_unmerge(&revs->diffopt, idx->name, idx->ce_mode, idx->sha1);
+		return 1;
+	}
+
 	/*
 	 * Something added to the tree?
 	 */
