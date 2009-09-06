From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 6 Sep 2009 11:18:59 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain>
References: <4AA17874.7090905@debian.org> <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com> <7vab191dz1.fsf@alter.siamese.dyndns.org> <7vzl98vrmt.fsf@alter.siamese.dyndns.org> <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 20:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkMKz-0005H6-EM
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 20:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758112AbZIFSTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 14:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758107AbZIFSTc
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 14:19:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49939 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758103AbZIFSTb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Sep 2009 14:19:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86IJ0p2006763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Sep 2009 11:19:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n86IIxQe002749;
	Sun, 6 Sep 2009 11:18:59 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127863>


Sorry, I was off for the week with very limited computer time (my main 
computer was a Suunto Gekko that I wore underwater), and spent yesterday 
doing the last kernel -rc.

Anyway, this is a problem I knew about, and it comes directly from the 
insane historical behavior of unpack_trees(), where it would mix up blobs 
and trees. The problem was _very_ obvious when I rewrote the tree-walking 
to be readable.

See commit 91e4f03604bd089e09154e95294d5d08c805ea49, and in particular the 
change from using base_name_compare() to using the idiotic df_name_compare().

It's called 'df_name_compare()' for a reason. That 'df' is because of the 
insane directory/file semantics that are simply not a compete ordering. 
And because it's not a complete ordering, it's impossible to handle 
certain cases, exactly because of the following situation:

	a < a-b < a/

but at the same time

	a == a/

ie you have a unsatisfiable situation.

And no, changing the ordering to "pure blob order" is _not_ the solution. 
Because then you'll no longer traverse the trees in the same order as you 
traverse the index, and you'll get into _much_ deeper trouble.

So the real solution was always to never use 'df_name_compare()': any user 
of that function is broken by design. It's sadly just the case that the 
original unpack_trees() always had those insane semantics, and when I 
rewrote it, I was very careful to keep the old semantics. Trust me, I very 
much wanted to change them.

So the solution is to change the 'df_name_compare()' (that fundamentally 
has that impossible constraint of 'a' == 'a/') to 'base_name_compare()'. 
That way name comparisons are always meaningful, and always follow the 
rules. The df_name_compare() thing was always a broken hack - just one 
that got the semantics we wanted for all the truly simple cases.

And then fix the fallout from that: callers never get mixed-up tree and 
blob entries, and have to do their DF checking themselves.

IOW, the starting point is the following. And let me try to see what we 
need to do in the callers (this really is just a starting point: we'll 
need to clean up all the insane DF conflict marker code that is now 
pointless)

		Linus
---
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 6 Sep 2009 11:15:04 -0700
Subject: [PATCH] Get rid of the broken 'df_name_compare()'

This _will_ break the test-suite, but anything that depends on
df_name_compare() is fundamentally flawed.  Because it is designed to
compare directory and blob names as equal, you have 'a' == 'a/', but at
the same time you also have 'a' < 'a-b' < 'a/'.

Out old unpack_trees() semantics depend on that impossible situation,
and we've kept this hack around for a long time.  But now somebody has
finally hit the impossible case, and we need to bite the bullet and get
rid of the hack, and fix D/F conflict handling properly.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 cache.h        |    1 -
 read-cache.c   |   35 -----------------------------------
 tree-walk.c    |    2 +-
 unpack-trees.c |    2 +-
 4 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/cache.h b/cache.h
index 5fad24c..fda9a49 100644
--- a/cache.h
+++ b/cache.h
@@ -709,7 +709,6 @@ extern int create_symref(const char *ref, const char *refs_heads_master, const c
 extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
-extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
 
 extern void *read_object_with_reference(const unsigned char *sha1,
diff --git a/read-cache.c b/read-cache.c
index 1bbaf1c..f3143d8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -362,41 +362,6 @@ int base_name_compare(const char *name1, int len1, int mode1,
 	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
 }
 
-/*
- * df_name_compare() is identical to base_name_compare(), except it
- * compares conflicting directory/file entries as equal. Note that
- * while a directory name compares as equal to a regular file, they
- * then individually compare _differently_ to a filename that has
- * a dot after the basename (because '\0' < '.' < '/').
- *
- * This is used by routines that want to traverse the git namespace
- * but then handle conflicting entries together when possible.
- */
-int df_name_compare(const char *name1, int len1, int mode1,
-		    const char *name2, int len2, int mode2)
-{
-	int len = len1 < len2 ? len1 : len2, cmp;
-	unsigned char c1, c2;
-
-	cmp = memcmp(name1, name2, len);
-	if (cmp)
-		return cmp;
-	/* Directories and files compare equal (same length, same name) */
-	if (len1 == len2)
-		return 0;
-	c1 = name1[len];
-	if (!c1 && S_ISDIR(mode1))
-		c1 = '/';
-	c2 = name2[len];
-	if (!c2 && S_ISDIR(mode2))
-		c2 = '/';
-	if (c1 == '/' && !c2)
-		return 0;
-	if (c2 == '/' && !c1)
-		return 0;
-	return c1 - c2;
-}
-
 int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
 {
 	int len1 = flags1 & CE_NAMEMASK;
diff --git a/tree-walk.c b/tree-walk.c
index 02e2aed..8fc0ddc 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -62,7 +62,7 @@ void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 
 static int entry_compare(struct name_entry *a, struct name_entry *b)
 {
-	return df_name_compare(
+	return base_name_compare(
 			a->path, tree_entry_len(a->path, a->sha1), a->mode,
 			b->path, tree_entry_len(b->path, b->sha1), b->mode);
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..548fef4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -196,7 +196,7 @@ static int do_compare_entry(const struct cache_entry *ce, const struct traverse_
 	ce_name = ce->name + pathlen;
 
 	len = tree_entry_len(n->path, n->sha1);
-	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
+	return base_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
 }
 
 static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
