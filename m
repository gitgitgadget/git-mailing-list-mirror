From: Junio C Hamano <junkio@cox.net>
Subject: (rework) [PATCH 1/5] Accept commit in some places when tree is
 needed.
Date: Wed, 20 Apr 2005 17:19:03 -0700
Message-ID: <7vfyxlhthk.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vis2ikmj0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504200826360.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 02:15:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOPLr-0002iJ-Mg
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 02:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVDUATY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 20:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVDUATY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 20:19:24 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39594 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261848AbVDUATJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 20:19:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421001903.YIEZ2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 20:19:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504200826360.6467@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 20 Apr 2005 08:32:13 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

    sorry for bringing up an issue that is already 8 hours old.

LT> I don't think that's a good interface. It changes the sha1 passed into it: 
LT> that may actually be nice, since you may want to know what it changed to, 
LT> but I think you'd want to have that as an (optional) separate 
LT> "sha1_result" parameter. 

Point taken about "_changing_ _is_ _bad_" part.  It was a mistake.

LT> Also, the "type" or "size" things make no sense to have as a parameter 
LT> at all.

Well, the semantics is "I want to read the raw data of a tree
and I do not know nor care if this sha1 I got from my user is
for a commit or a tree."  So type does not matter (if it returns
a non NULL we know it is a tree), but the size matters.

And that semantics is not so hacky thing specific to diff-cache.
Rather, it applies in general if you structure the way those
recursive walkers do things.  The recursive walkers in ls-tree,
diff-cache, and diff-tree all expect the caller to supply the
buffer read by sha1_read_buffer, and when it calls itself it
does the same (read-tree's recursing convention is an oddball
that needs to be addressed, though).

When the recursion is structured this way, the only thing you
need to do to allow commit ID from the user when tree ID is
needed, without breaking the error checking done by the part
that recurses down (i.e. we must error on a commit object ID
when we are expecting a tree object ID stored in objects we read
from the tree downwards), is to change the top-level caller to
use "I want tree with this tree/commit ID" instead of "I want a
buffer with this ID and I'll make sure it is a tree myself".
Instead, you make the recursor "Give me a buffer and its type,
I'll barf if it is does not say a tree."  When the recursor
calls itself, it reads with read_sha1_file and feeds the result
to itself and have the called do the checking.

The commit_to_tree() thing you introduced in diff-tree.c is
simple to use.  IMHO it is however conceptually a wrong thing to
use in these contexts.  When the user supplies a tree ID, you
first read that object only to see if it is not a commit and
throw it away, then immediately read it again for your real
processing.  In these particular cases of four tree- related
files, "I want tree with this tree/commit ID" semantics is a
_far_ _better_ match for the problem.

Having said that, here is a reworked version.  This first one 
introduces read_tree_with_tree_or_commit_sha1() function.

<end-of-cover-letter>

This patch implements read_tree_with_tree_or_commit_sha1(),
which can be used when you are interested in reading an unpacked
raw tree data but you do not know nor care if the SHA1 you
obtained your user is a tree ID or a commit ID.  Before this
function's introduction, you would have called read_sha1_file(),
examined its type, parsed it to call read_sha1_file() again if
it is a commit, and verified that the resulting object is a
tree.  Instead, this function does that for you.  It returns
NULL if the given SHA1 is not either a tree or a commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h     |    4 ++++
 sha1_file.c |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

cache.h: eab355da5d2f6595053f28f0cca61181ac314ee9
--- a/cache.h
+++ b/cache.h
@@ -124,4 +124,8 @@ extern int error(const char *err, ...);
 
 extern int cache_name_compare(const char *name1, int len1, const char *name2, int len2);
 
+extern void *read_tree_with_tree_or_commit_sha1(const unsigned char *sha1,
+						unsigned long *size,
+						unsigned char *tree_sha1_ret);
+
 #endif /* CACHE_H */


sha1_file.c: eee3598bb75e2199045b823f007e7933c0fb9cfe
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -166,6 +166,46 @@ void * read_sha1_file(const unsigned cha
 	return NULL;
 }
 
+void *read_tree_with_tree_or_commit_sha1(const unsigned char *sha1,
+					 unsigned long *size,
+					 unsigned char *tree_sha1_return)
+{
+	char type[20];
+	void *buffer;
+	unsigned long isize;
+	int was_commit = 0;
+	char tree_sha1[20];
+
+	buffer = read_sha1_file(sha1, type, &isize);
+
+	/* 
+	 * We might have read a commit instead of a tree, in which case
+	 * we parse out the tree_sha1 and attempt to read from there.
+	 * (buffer + 5) is because the tree sha1 is always at offset 5
+	 * in a commit record ("tree ").
+	 */
+	if (buffer &&
+	    !strcmp(type, "commit") &&
+	    !get_sha1_hex(buffer + 5, tree_sha1)) {
+		free(buffer);
+		buffer = read_sha1_file(tree_sha1, type, &isize);
+		was_commit = 1;
+	}
+
+	/*
+	 * Now do we have something and if so is it a tree?
+	 */
+	if (!buffer || strcmp(type, "tree")) {
+		free(buffer);
+		return;
+	}
+
+	*size = isize;
+	if (tree_sha1_return)
+		memcpy(tree_sha1_return, was_commit ? tree_sha1 : sha1, 20);
+	return buffer;
+}
+
 int write_sha1_file(char *buf, unsigned len, unsigned char *returnsha1)
 {
 	int size;

