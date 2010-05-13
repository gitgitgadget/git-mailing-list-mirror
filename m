From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH] Make :/ accept a regex rather than a fixed pattern
Date: Thu, 13 May 2010 15:08:42 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005131457350.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 14 00:12:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCgdb-0004Dq-Oi
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 00:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758643Ab0EMWLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 18:11:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43210 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757797Ab0EMWLv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 18:11:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4DMAlTK024750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 May 2010 15:10:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o4DMAlNK023426;
	Thu, 13 May 2010 15:10:47 -0700
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147035>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Apr 2010 08:20:20 -0700
Subject: [PATCH] Make :/ accept a regex rather than a fixed pattern

This also makes it trigger anywhere in the commit message, rather than
just at the beginning. Which tends to be a lot more useful.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I'm re-sending, because after having this in my tree for several weeks 
now, I actually end up still using it. 

I agree that it's still not a wonderful thing, and it's entirely possible 
that we should strive to use just HEAD in :/ commit finding rather than 
all refs we can find, but for at least the kernel, I don't care (since my 
tree tends to have just one main branch anyway, apart from some random 
testing stuff I keep around).

But even if we want to limit it to HEAD, that would be a separate patch.

I've personally used it for things like

	git show :/mqueue	# did I apply that 'mqueue' patch?
	git show :/akpm		# what was the last patch I got from Andrew?

and while in all cases I could admittedly have done exactly the same thing 
with something like "git log -p -1 --grep=mqueue" instead, I've used it as 
a nice shortcut.

Of course, I'm still not convinced that :/ was a good feature to begin 
with. If we had a short form of "--grep" ("-/"?), I would probably happily 
have written "git log -/akpm" instead. 

So take this patch with a large pinch of salt. It's just not very 
important.

 sha1_name.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index bf92417..8cf635a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -679,8 +679,8 @@ static int handle_one_ref(const char *path,
 
 /*
  * This interprets names like ':/Initial revision of "git"' by searching
- * through history and returning the first commit whose message starts
- * with the given string.
+ * through history and returning the first commit whose message matches
+ * the given regular expression.
  *
  * For future extension, ':/!' is reserved. If you want to match a message
  * beginning with a '!', you have to repeat the exclamation mark.
@@ -692,12 +692,17 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	struct commit_list *list = NULL, *backup = NULL, *l;
 	int retval = -1;
 	char *temp_commit_buffer = NULL;
+	regex_t regex;
 
 	if (prefix[0] == '!') {
 		if (prefix[1] != '!')
 			die ("Invalid search pattern: %s", prefix);
 		prefix++;
 	}
+
+	if (regcomp(&regex, prefix, REG_EXTENDED))
+		die("Invalid search pattern: %s", prefix);
+
 	for_each_ref(handle_one_ref, &list);
 	for (l = list; l; l = l->next)
 		commit_list_insert(l->item, &backup);
@@ -721,12 +726,13 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 		}
 		if (!(p = strstr(p, "\n\n")))
 			continue;
-		if (!prefixcmp(p + 2, prefix)) {
+		if (!regexec(&regex, p + 2, 0, NULL, 0)) {
 			hashcpy(sha1, commit->object.sha1);
 			retval = 0;
 			break;
 		}
 	}
+	regfree(&regex);
 	free(temp_commit_buffer);
 	free_commit_list(list);
 	for (l = backup; l; l = l->next)
-- 
1.7.1.83.g9d02
