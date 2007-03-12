From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git-diff -p :/anything" always segfaults
Date: Mon, 12 Mar 2007 09:14:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703120900300.9690@woody.linux-foundation.org>
References: <87d53fsjiz.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0703111322180.9690@woody.linux-foundation.org>
 <7vslcbv6ol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQnAV-0002BO-Sv
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 17:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbXCLQOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 12:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbXCLQOP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 12:14:15 -0400
Received: from smtp.osdl.org ([65.172.181.24]:59301 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030510AbXCLQOL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 12:14:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2CGE4o4013488
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Mar 2007 09:14:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2CGE34g007273;
	Mon, 12 Mar 2007 08:14:03 -0800
In-Reply-To: <7vslcbv6ol.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.488 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42035>



On Sun, 11 Mar 2007, Junio C Hamano wrote:
> >
> > "pop_most_recent_commit()" simply doesn't work that way. It *never* 
> > returns NULL. So having it as part of a while-loop was buggy to begin 
> > with, and you fixed the test, but the thing is, it should just look like
> >
> > 	while (list) {
> > 		struct commit *commit;
> >
> > 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
> > 		..
> >
> > and the "pop_most_recent_commit()" simply shouldn't be part of the 
> > conditional at all.
> 
> That's what I did in my tentative commit based on Jim's patch
> (except "commit" is also used to determine the return value from
> the function).

Your version is *also* buggy.

And the bug is exactly that return value.

You simply cannot do it that way. You do

	...
	commit = pop_most_recent_commit(&list, ONELINE_SEEN);
	if (!commit)
		break;
	...

which is totally broken and pointless, and more importantly, *exactly* 
because you use "commit" outside the loop, it's broken.

It will now return the last commit it ever saw, whether that commit 
matches the buffer or not. Because "commit" will *never* be set to NULL 
ever again after the initial assignment!

The fact is, if you don't do it the way I described:

	while (list) {
		struct commit *commit;

		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
		...

you will almost certainly have a bug. Why? Because the return value of 
"pop_most_recent_commit()" simply *makes*no*sense* outside the loop. It's 
that simple. 

Outside the loop, you have to have a *different* return value, namely the 
one that matches. Which may be NULL. Something that 
pop_most_recent_commit() simply never returns!

So I repeat my suggestion:

 - either use the sequence above
 - or change the semantics of "pop_most_recent_commit()" to return NULL if 
   the list is empty.

Considering that there's now been two totally broken versions of this 
loop, with the exact same bug, I'm inclined to say that you should just 
change "pop_most_recent_commit()" instead, and then change the loop back 
to its original form of "while ((commit = pop_..) != NULL) {"

Otherwise, please apply something like this, which also fixes the return 
value. We should return -1 on error!

We should add a test with

	git log :/hjashjs

or similar. It's supposed to return an error ("fatal: ambiguous argument 
':/hjashjs': unknown revision or path not in the working tree.")

		Linus

 [ Same return value rules as for the kernel and for system calls, either:

    - 0/1 for "false/true", where _1_ is success, and 0 is "false".

    - negative/0 for "error/no-error", where _0_ is success, and negative 
      is a failure.

   but not some mixture with 1 being failure! ]
---
diff --git a/sha1_name.c b/sha1_name.c
index 6b8b67b..40dd2d1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -602,10 +602,10 @@ static int handle_one_ref(const char *path,
  */
 
 #define ONELINE_SEEN (1u<<20)
-int get_sha1_oneline(const char *prefix, unsigned char *sha1)
+static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 {
 	struct commit_list *list = NULL, *backup = NULL, *l;
-	struct commit *commit = NULL;
+	int retval = -1;
 
 	if (prefix[0] == '!') {
 		if (prefix[1] != '!')
@@ -619,6 +619,7 @@ int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 		commit_list_insert(l->item, &backup);
 	while (list) {
 		char *p;
+		struct commit *commit;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
 		if (!commit)
@@ -628,13 +629,14 @@ int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 			continue;
 		if (!prefixcmp(p + 2, prefix)) {
 			hashcpy(sha1, commit->object.sha1);
+			retval = 0;
 			break;
 		}
 	}
 	free_commit_list(list);
 	for (l = backup; l; l = l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
-	return commit == NULL;
+	return retval;
 }
 
 /*
