From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH] Re: Empty directories...
Date: Wed, 18 Jul 2007 16:16:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 01:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBIlN-0004h0-KV
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 01:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbXGRXQq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 19:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbXGRXQq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 19:16:46 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45751 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759419AbXGRXQo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 19:16:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6INGWa5012645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 16:16:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6INGQ82001761;
	Wed, 18 Jul 2007 16:16:27 -0700
In-Reply-To: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.174 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52908>


Gaah.

I'm a damn softie (and soft in the head too, for writing the code).

Ok, here's a trivial patch to start the ball rolling. I'm really not 
interested in taking this patch any further personally, but I'm hoping 
that maybe it can make somebody else who is actually _interested_ in 
trackign empty directories (hint hint) decide that it's a good enough 
start that they can fill in the details.

This really updates three different areas, which are nicely separated into 
three different files, so while it's one single patch, you can actually 
follow along the changes by just looking at the differences in each file, 
which directly translate to separate conceptual changes:

 - builtin-update-index.c

   This simply contains the changes to update the index file. As usual, 
   there are multiple different cases, and they boil down to:

	(a) No index entry existed at all previously. If so, a directory 
	    will first go through the "index_path()" logic, which tries to 
	    create a GITLINK entry for it, if the subdirectory is a git 
	    directory. However, the new thing is that if that fails, it 
	    will instead just create a fake empty tree entry for it, and 
	    set the index mode to S_IFDIR.

	(b) It was a gitlink entry before. It stays as a gitlink entry, 
	    even if it cannot be indexed, and a file/symlink entry in 
	    the working tree is a conflict error.

	(c) It was a empty directory entry before. A directory stays as an 
	    empty directory entry, and a file/symlink entry in the working 
	    tree is a conflict error.

   Somebody should check that we properly delete the directory entry if we 
   add a file under it, I honestly didn't bother to go through all the 
   logic. I *think* we do it correctly just thanks to all the previous 
   code for gitlinks. Whatever.

   What I'm trying to say is that the changes are fairly straightforward, 
   but if somebody decides to push this, they need to think about it a lot 
   more than I'm ready to right now.

 - read-cache.c: match the new index type with the filesystem.

   This is pretty damn obvious. A S_ISDIR() always matches, and nothing 
   else matches at all. 

 - unpack-trees.c: unpack empty directories not by unpacking them 
   recursively into the index, but by adding them directly to the index as 
   a S_IFDIR entry instead.

   This one almost certainly needs more work, in particular when merging 
   trees where one has an empty directory, and the other has files _in_ 
   that directory! But the trivial approach makes a simple "git read-tree"
   with an empty directory unpack it into the index as a S_IFDIR entry, so 
   now doing git-write-tree + git-read-tree should result in the original 
   index contents.

I think the patch itself is pretty simple, but the subtle interactions 
that flow out of this all are anything but. It may "just work" almost 
as-is, but quite frankly, I think people need to think about all the 
issues that can happen a lot!

So see this as a basis for further work. The "further work" may be pretty 
simple, or it may not be. I'm personally not that interested, but like my 
original "subprojects" series, hopefully somebody else ends up running 
with this (or alternatively just proving that trying to track empty 
directories is a total nightmare).

			Linus

---
 builtin-update-index.c |   33 +++++++++++++++++++++++----------
 read-cache.c           |    4 ++++
 unpack-trees.c         |   12 +++++++++---
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 509369e..2eb2a46 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -94,8 +94,16 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
-	if (index_path(ce->sha1, path, st, !info_only))
-		return -1;
+	if (index_path(ce->sha1, path, st, !info_only)) {
+		/*
+		 * If we weren't able to index the directory as a GITLINK,
+		 * see if we can just add it as a plain directory instead.
+		 */
+		if (!S_ISDIR(st->st_mode))
+			return -1;
+		ce->ce_mode = htonl(S_IFDIR);
+		pretend_sha1_file(NULL, 0, OBJ_TREE, ce->sha1);
+	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
@@ -134,6 +142,11 @@ static int process_directory(const char *path, int len, struct stat *st)
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
 		struct cache_entry *ce = active_cache[pos];
+
+		/* Was it a directory before? */
+		if (S_ISDIR(ntohl(ce->ce_mode)))
+			return 0;
+
 		if (S_ISGITLINK(ntohl(ce->ce_mode))) {
 
 			/* Do nothing to the index if there is no HEAD! */
@@ -162,12 +175,8 @@ static int process_directory(const char *path, int len, struct stat *st)
 		return error("%s: is a directory - add individual files instead", path);
 	}
 
-	/* No match - should we add it as a gitlink? */
-	if (!resolve_gitlink_ref(path, "HEAD", sha1))
-		return add_one_path(NULL, path, len, st);
-
-	/* Error out. */
-	return error("%s: is a directory - add files inside instead", path);
+	/* No match - try to just add it as-is */
+	return add_one_path(NULL, path, len, st);
 }
 
 /*
@@ -178,8 +187,12 @@ static int process_file(const char *path, int len, struct stat *st)
 	int pos = cache_name_pos(path, len);
 	struct cache_entry *ce = pos < 0 ? NULL : active_cache[pos];
 
-	if (ce && S_ISGITLINK(ntohl(ce->ce_mode)))
-		return error("%s is already a gitlink, not replacing", path);
+	if (ce) {
+		if (S_ISGITLINK(ntohl(ce->ce_mode)))
+			return error("%s is already a gitlink, not replacing", path);
+		if (S_ISDIR(ntohl(ce->ce_mode)))
+			return error("%s is already a directory entry, not replacing", path);
+	}
 
 	return add_one_path(ce, path, len, st);
 }
diff --git a/read-cache.c b/read-cache.c
index a363f31..d3d2cc0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -142,6 +142,10 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 		    (has_symlinks || !S_ISREG(st->st_mode)))
 			changed |= TYPE_CHANGED;
 		break;
+	case S_IFDIR:
+		if (!S_ISDIR(st->st_mode))
+			changed |= TYPE_CHANGED;
+		return changed;
 	case S_IFGITLINK:
 		if (!S_ISDIR(st->st_mode))
 			changed |= TYPE_CHANGED;
diff --git a/unpack-trees.c b/unpack-trees.c
index 89dd279..22e452b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -181,9 +181,13 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 				any_dirs = 1;
 				parse_tree(tree);
 				subposns[i] = create_tree_entry_list(tree);
-				posns[i] = posns[i]->next;
-				src[i + o->merge] = o->df_conflict_entry;
-				continue;
+
+				/* If it wasn't empty, recurse into it */
+				if (subposns[i]) {
+					posns[i] = posns[i]->next;
+					src[i + o->merge] = o->df_conflict_entry;
+					continue;
+				}
 			}
 
 			if (!o->merge)
@@ -197,6 +201,8 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 
 			ce = xcalloc(1, ce_size);
 			ce->ce_mode = create_ce_mode(posns[i]->mode);
+			if (posns[i]->directory)
+				ce->ce_mode = htonl(S_IFDIR);
 			ce->ce_flags = create_ce_flags(baselen + pathlen,
 						       ce_stage);
 			memcpy(ce->name, base, baselen);
