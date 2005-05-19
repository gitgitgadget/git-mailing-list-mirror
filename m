From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 10:13:01 -0700
Message-ID: <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 19:13:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYoZb-0004cf-Ss
	for gcvg-git@gmane.org; Thu, 19 May 2005 19:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVESRNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 13:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVESRNY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 13:13:24 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35508 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261173AbVESRNE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 13:13:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519171303.KKZE20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 13:13:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 19 May 2005 09:19:28 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I notice that you left some debugging output in there ("**score **" 
LT> stuff), and I'll remove it, but it's merged and pushed out and passed my 
LT> trivial tests. 

Oops,... thanks.  I still had some doubts about it and that's
why I said it was beta, but that is fine.  My doubts are minor:

 - the command line interface "-M" to read "-M" or "-M[0-9]"
   (one digit); -M defaults to -M5 and give the cut-off point at
   similarity score 5000, -M9 at 9000, etc.

 - I was debating myself if adding something like this was a
   good idea (using scale between 0 and 9 corresponding the
   -M[0-9] option):

	diff --git a/arch/um/kernel/sys_call_table.c b/arch/um/sys-x86_64/sys_call_table.c
   ***  rename similarity index 8
	rename old arch/um/kernel/sys_call_table.c
	rename new arch/um/sys-x86_64/sys_call_table.c
	--- a/arch/um/kernel/sys_call_table.c
	+++ b/arch/um/sys-x86_64/sys_call_table.c

 - I have been assuming that diff_delta uses its two input
   read-only but have not verified that myself yet.

 - I did not check for leaks and knew I had outdated comments in
   some while doing the diff core interface cleanups.

A bit of clean-up patch, which may not apply exactly if you
removed the **score** stuff is attached.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
# - HEAD: Detect renames in diff family.
# + 11: Cleanup and leak fix after rename in diff family patch.
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -85,12 +85,10 @@ struct diff_spec {
 	unsigned char blob_sha1[20];
 	unsigned short mode;	 /* file mode */
 	unsigned sha1_valid : 1; /* if true, use blob_sha1 and trust mode;
-				  * however with a NULL SHA1, read them
-				  * from the file system.
-				  * if false, use the name and read mode from
+				  * if false, use the name and read from
 				  * the filesystem.
 				  */
-	unsigned file_valid : 1; /* if false the file does not even exist */
+	unsigned file_valid : 1; /* if false the file does not exist */
 };
 
 static void builtin_diff(const char *name_a,
@@ -506,6 +504,7 @@ static void free_data(struct diff_spec_h
 	else if (s->flags & SHOULD_MUNMAP)
 		munmap(s->data, s->size);
 	s->flags &= ~(SHOULD_FREE|SHOULD_MUNMAP);
+	s->data = 0;
 }
 
 static void flush_remaining_diff(struct diff_spec_hold *elem,
@@ -625,9 +624,17 @@ void diff_flush(void)
 
 	/* We really want to cull the candidates list early
 	 * with cheap tests in order to avoid doing deltas.
+	 *
+	 * With the current callers, we should not have already
+	 * matched entries at this point, but it is nonetheless
+	 * checked for sanity.
 	 */
 	for (dst = createdfile; dst; dst = dst->next) {
+		if (dst->flags & MATCHED)
+			continue;
 		for (src = deletedfile; src; src = src->next) {
+			if (src->flags & MATCHED)
+				continue;
 			if (! is_exact_match(src, dst))
 				continue;
 			flush_rename_pair(src, dst);
@@ -665,6 +672,7 @@ void diff_flush(void)
 	}
 	qsort(mx, num_create*num_delete, sizeof(*mx), score_compare); 
 
+#if 0
  	for (c = 0; c < num_create * num_delete; c++) {
 		src = mx[c].src;
 		dst = mx[c].dst;
@@ -674,6 +682,7 @@ void diff_flush(void)
 			"**score ** %d %s %s\n",
 			mx[c].score, src->path, dst->path);
 	}
+#endif
 
  	for (c = 0; c < num_create * num_delete; c++) {
 		src = mx[c].src;
@@ -684,6 +693,7 @@ void diff_flush(void)
 			break;
 		flush_rename_pair(src, dst);
 	}
+	free(mx);
 
  exit_path:
 	flush_remaining_diff(createdfile, 1);

