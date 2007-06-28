From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug: segfault during git-prune
Date: Thu, 28 Jun 2007 08:59:35 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706280844460.8675@woody.linux-foundation.org>
References: <200706281134.58453.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 17:59:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3wPJ-0001hs-W3
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 17:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759332AbXF1P7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 11:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757055AbXF1P7o
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 11:59:44 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38225 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756832AbXF1P7n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jun 2007 11:59:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SFxfcg021055
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Jun 2007 08:59:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5SFxZ7M028674;
	Thu, 28 Jun 2007 08:59:35 -0700
In-Reply-To: <200706281134.58453.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.627 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51116>



On Thu, 28 Jun 2007, Andy Parkins wrote:
> 
> I ran git-prune on a repository and got this:
> 
> $ git-prune
> error: Object 228f8065b930120e35fc0c154c237487ab02d64a is a blob, not a commit
> Segmentation fault (core dumped)

Do you have subprojects in that git repo?

What happens is that all git object handling *refuses* (correctly) to 
touch an object of the wrong type. If it's been marked as a commit at some 
point, it had better be looked up as a commit the *next* time we see that 
same object too.

And every normal git object traversal will specify in advance what kind of 
object it expects (except for the initial refs lookups, that don't know, 
and use a totally different interface for "give me any kind of object, and 
figure it out").

So the error in this case is that we decided it was a commit once, and a 
blob once, and git is very unhappy.

And the only case I know of that does that is using an old git binary, or 
a unconverted git code-path program, on a repository with subprojects when 
the code-path doesn't understand that a tree can contain pointers to 
commits.

So what happens is that something traverses a tree object, looks at each 
entry, sees that it's not a tree, and tries to look it up as a blob. But 
subprojects are commits, not blobs, and then when you look at the object 
more closely, you get the above kind of object type confusion.

And I did that very early on, and wanted to make sure that git objects 
were "strongly typed", and you get a big fat error if you try to use the 
wrong type.

> $ git-cat-file -t 228f8065b930120e35fc0c154c237487ab02d64a
> commit
> 
> git-show of the object shows it looks okay.  git-fsck just shows a load
> of dangling objects - which isn't a surprise, that's why I was running
> git-prune.

Yeah, git-fsck knows about subprojects. I bet git-prune just doesn't. 

And indeed.. Here's a patch for it, but the fact is, you really should 
*not* prune that repository, because you'll prune away all the subproject 
data, which you seem to have in the same repo!

(General rule: never *ever* prune a shared object repository!)

		Linus

---
 reachable.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/reachable.c b/reachable.c
index ff3dd34..17ff929 100644
--- a/reachable.c
+++ b/reachable.c
@@ -21,6 +21,15 @@ static void process_blob(struct blob *blob,
 	/* Nothing to do, really .. The blob lookup was the important part */
 }
 
+static void process_gitlink(const unsigned char *sha1,
+			    struct object_array *p,
+			    struct name_path *path,
+			    const char *name)
+{
+	/* I don't think we want to recurse into this, really. */
+}
+
+
 static void process_tree(struct tree *tree,
 			 struct object_array *p,
 			 struct name_path *path,
@@ -47,6 +56,8 @@ static void process_tree(struct tree *tree,
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
 			process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
+		else if (S_ISGITLINK(entry.mode))
+			process_gitlink(entry.sha1, p, &me, entry.path);
 		else
 			process_blob(lookup_blob(entry.sha1), p, &me, entry.path);
 	}
