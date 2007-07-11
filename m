From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support wholesale directory renames in fast-import
Date: Wed, 11 Jul 2007 03:57:44 -0400
Message-ID: <20070711075744.GO4436@spearce.org>
References: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com> <20070710031036.GA9045@spearce.org> <7154c5c60707092116p70aaeb8l90cda9265311b999@mail.gmail.com> <20070710140338.GA18450@informatik.uni-freiburg.de> <20070710141442.GM4436@spearce.org> <7154c5c60707101255k7fcd207fg62f1c59518ba5039@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: David Frech <david@nimblemachines.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 09:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8X5D-0005t7-FW
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 09:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbXGKH54 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 03:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbXGKH54
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 03:57:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41928 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbXGKH5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 03:57:55 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I8X4z-0002sM-OT; Wed, 11 Jul 2007 03:57:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F2A0320FBAE; Wed, 11 Jul 2007 03:57:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7154c5c60707101255k7fcd207fg62f1c59518ba5039@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52140>

David Frech <david@nimblemachines.com> wrote:
> Hmm. I think Uwe is right. Copy is probably the "right" primitive, and
> rename can always be synthesized from copy+delete.
> 
> Since Subversion is built around the idea of "cheap copies" there is
> no incentive for them to represent renames other than as "copy, then
> delete".
> 
> But isn't the same true in a way of git? If I copy a directory (a
> tree), then the new tree is the same tree - it has the same SHA-1
> hash, so I can simply refer to the existing object. Same for file
> blobs.
> 
> Subversion dump files have *lots* of copies. Might be nice to be able
> to feed these directly into fast-import and have it DTRT, esp if it
> was smart about sharing identical data structures.

Yes.  All of that is true.  ;-)

I'm tired.  I just worked an 18 hour day.  I need to go do it all
over again in about 4 hours.  So I'm going to head off to bed.  But
I did manage to implement this (I think).  Its totally untested.
But feel free to poke at it:

  git://repo.or.cz/git/fastimport.git copy-wip

I'll write documentation and unit tests tomorrow.  And fix any bugs,
if any get identified.

The implementation should copy as little memory as possible to do the
actual copy.  This should make a C/D pair about as efficient as an
R command if the directory being copied has not yet been modified
as part of the current commit (this is probably typical for an
SVN dump file).  The only difference should be a slight increase
in running time for the C/D pair, as directory entry lookup in
fast-import is O(n).

Oh, and as always, C works with both files and directories...

Hmm.  Quickly reading this diff I can actually do it shorter with
a bit of refactoring.  I'll clean that up tomorrow night.  I blame
it on the lack of sleep that I'm suffering from right now.  ;-)


-->8--
WIP Teach fast import how to copy

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 120 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index a1cb13f..41c0352 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -26,10 +26,16 @@ Format of STDIN stream:
     lf;
   commit_msg ::= data;
 
-  file_change ::= file_clr | file_del | file_rnm | file_obm | file_inm;
+  file_change ::= file_clr
+    | file_del
+    | file_rnm
+    | file_cpy
+    | file_obm
+    | file_inm;
   file_clr ::= 'deleteall' lf;
   file_del ::= 'D' sp path_str lf;
   file_rnm ::= 'R' sp path_str sp path_str lf;
+  file_cpy ::= 'C' sp path_str sp path_str lf;
   file_obm ::= 'M' sp mode sp (hexsha1 | idnum) sp path_str lf;
   file_inm ::= 'M' sp mode sp 'inline' sp path_str lf
     data;
@@ -623,6 +629,33 @@ static void release_tree_entry(struct tree_entry *e)
 	avail_tree_entry = e;
 }
 
+static struct tree_content *dup_tree_content(struct tree_content *s)
+{
+	struct tree_content *d;
+	struct tree_entry *a, *b;
+	unsigned int i, j;
+
+	if (!s)
+		return NULL;
+	d = new_tree_content(s->entry_count);
+	for (i = 0, j = 0; i < s->entry_count; i++) {
+		a = s->entries[i];
+		if (a->versions[1].mode) {
+			b = new_tree_entry();
+			memcpy(b, a, sizeof(*a));
+			if (is_null_sha1(b->versions[1].sha1))
+				b->tree = dup_tree_content(b->tree);
+			else
+				b->tree = NULL;
+			d->entries[j++] = a;
+		}
+	}
+	d->entry_count = j;
+	d->delta_depth = s->delta_depth;
+
+	return d;
+}
+
 static void start_packfile(void)
 {
 	static char tmpfile[PATH_MAX];
@@ -1273,6 +1306,43 @@ del_entry:
 	return 1;
 }
 
+static int tree_content_get(
+	struct tree_entry *root,
+	const char *p,
+	struct tree_entry *leaf)
+{
+	struct tree_content *t = root->tree;
+	const char *slash1;
+	unsigned int i, n;
+	struct tree_entry *e;
+
+	slash1 = strchr(p, '/');
+	if (slash1)
+		n = slash1 - p;
+	else
+		n = strlen(p);
+
+	for (i = 0; i < t->entry_count; i++) {
+		e = t->entries[i];
+		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+			if (!slash1) {
+				memcpy(leaf, e, sizeof(*leaf));
+				if (is_null_sha1(e->versions[1].sha1))
+					leaf->tree = dup_tree_content(leaf->tree);
+				else
+					leaf->tree = NULL;
+				return 1;
+			}
+			if (!S_ISDIR(e->versions[1].mode))
+				return 0;
+			if (!e->tree)
+				load_tree(e);
+			return tree_content_get(e, slash1 + 1, leaf);
+		}
+	}
+	return 0;
+}
+
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
@@ -1706,6 +1776,53 @@ static void file_change_r(struct branch *b)
 	free(d_uq);
 }
 
+static void file_change_c(struct branch *b)
+{
+	const char *s, *d;
+	char *s_uq, *d_uq;
+	const char *endp;
+	struct tree_entry leaf;
+
+	s = command_buf.buf + 2;
+	s_uq = unquote_c_style(s, &endp);
+	if (s_uq) {
+		if (*endp != ' ')
+			die("Missing space after source: %s", command_buf.buf);
+	}
+	else {
+		endp = strchr(s, ' ');
+		if (!endp)
+			die("Missing space after source: %s", command_buf.buf);
+		s_uq = xmalloc(endp - s + 1);
+		memcpy(s_uq, s, endp - s);
+		s_uq[endp - s] = 0;
+	}
+	s = s_uq;
+
+	endp++;
+	if (!*endp)
+		die("Missing dest: %s", command_buf.buf);
+
+	d = endp;
+	d_uq = unquote_c_style(d, &endp);
+	if (d_uq) {
+		if (*endp)
+			die("Garbage after dest in: %s", command_buf.buf);
+		d = d_uq;
+	}
+
+	memset(&leaf, 0, sizeof(leaf));
+	if (!tree_content_get(&b->branch_tree, s, &leaf))
+		die("Path %s not in branch", s);
+	tree_content_set(&b->branch_tree, d,
+		leaf.versions[1].sha1,
+		leaf.versions[1].mode,
+		leaf.tree);
+
+	free(s_uq);
+	free(d_uq);
+}
+
 static void file_change_deleteall(struct branch *b)
 {
 	release_tree_content_recursive(b->branch_tree.tree);
@@ -1875,6 +1992,8 @@ static void cmd_new_commit(void)
 			file_change_d(b);
 		else if (!prefixcmp(command_buf.buf, "R "))
 			file_change_r(b);
+		else if (!prefixcmp(command_buf.buf, "C "))
+			file_change_c(b);
 		else if (!strcmp("deleteall", command_buf.buf))
 			file_change_deleteall(b);
 		else
-- 
1.5.3.rc0.879.g64b8


-- 
Shawn.
