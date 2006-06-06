From: Junio C Hamano <junkio@cox.net>
Subject: Re: Horrible re-packing?
Date: Mon, 05 Jun 2006 17:14:51 -0700
Message-ID: <7v1wu32l8k.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606051140530.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
	<7vy7wb4cmy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606051256280.5498@g5.osdl.org>
	<7v8xob2m6j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 02:15:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnPDn-0003Sv-D7
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 02:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWFFAOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 20:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWFFAOy
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 20:14:54 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41430 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751177AbWFFAOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 20:14:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606001452.GDAW18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 20:14:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v8xob2m6j.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 05 Jun 2006 16:54:28 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21357>

Junio C Hamano <junkio@cox.net> writes:

>  - The output from rev-list --objects is fed to the function as
>    its name parameter while path is set to NULL.  When we allow
>    a thin pack to be generated, rev-list --objects output also
>    contains "-<commit-object-name>" lines.  We read trees for
>    these commits that are not going to be sent but can be used
>    as base objects, and pass the pathname discovered from the
>    tree using path and name pair (path is set to the linked list
>    of struct name_path that describes the dirname, and name is
>    set to the basename).  This was done to reduce the need for
>    allocating and copying the pathname in preparation for
>    calling name_hash() function.

but it can trivially fixed by doing something like this.

---

diff --git a/pack-objects.c b/pack-objects.c
index 3590cd5..e0328f8 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -463,17 +463,10 @@ static void rehash_objects(void)
 	}
 }
 
-struct name_path {
-	struct name_path *up;
-	const char *elem;
-	int len;
-};
-
 #define DIRBITS 12
 
-static unsigned name_hash(struct name_path *path, const char *name)
+static unsigned name_hash(const char *name)
 {
-	struct name_path *p = path;
 	const char *n = name + strlen(name);
 	unsigned hash = 0, name_hash = 0, name_done = 0;
 
@@ -492,14 +485,6 @@ static unsigned name_hash(struct name_pa
 		name_hash = hash;
 		hash = 0;
 	}
-	for (p = path; p; p = p->up) {
-		hash = hash * 11 + '/';
-		n = p->elem + p->len;
-		while (p->elem <= --n) {
-			unsigned char c = *n;
-			hash = hash * 11 + c;
-		}
-	}
 	/*
 	 * Make sure "Makefile" and "t/Makefile" are hashed separately
 	 * but close enough.
@@ -686,9 +671,9 @@ static int name_cmp_len(const char *name
 }
 
 static void add_pbase_object(struct tree_desc *tree,
-			     struct name_path *up,
 			     const char *name,
-			     int cmplen)
+			     int cmplen,
+			     const char *fullname)
 {
 	struct name_entry entry;
 
@@ -702,13 +687,12 @@ static void add_pbase_object(struct tree
 		    sha1_object_info(entry.sha1, type, &size))
 			continue;
 		if (name[cmplen] != '/') {
-			unsigned hash = name_hash(up, name);
+			unsigned hash = name_hash(fullname);
 			add_object_entry(entry.sha1, hash, 1);
 			return;
 		}
 		if (!strcmp(type, tree_type)) {
 			struct tree_desc sub;
-			struct name_path me;
 			struct pbase_tree_cache *tree;
 			const char *down = name+cmplen+1;
 			int downlen = name_cmp_len(down);
@@ -719,10 +703,7 @@ static void add_pbase_object(struct tree
 			sub.buf = tree->tree_data;
 			sub.size = tree->tree_size;
 
-			me.up = up;
-			me.elem = entry.path;
-			me.len = entry.pathlen;
-			add_pbase_object(&sub, &me, down, downlen);
+			add_pbase_object(&sub, down, downlen, fullname);
 			pbase_tree_put(tree);
 		}
 	}
@@ -778,14 +759,14 @@ static void add_preferred_base_object(ch
 
 	for (it = pbase_tree; it; it = it->next) {
 		if (cmplen == 0) {
-			hash = name_hash(NULL, "");
+			hash = name_hash("");
 			add_object_entry(it->pcache.sha1, hash, 1);
 		}
 		else {
 			struct tree_desc tree;
 			tree.buf = it->pcache.tree_data;
 			tree.size = it->pcache.tree_size;
-			add_pbase_object(&tree, NULL, name, cmplen);
+			add_pbase_object(&tree, name, cmplen, name);
 		}
 	}
 }
@@ -1328,7 +1309,7 @@ int main(int argc, char **argv)
 		}
 		if (get_sha1_hex(line, sha1))
 			die("expected sha1, got garbage:\n %s", line);
-		hash = name_hash(NULL, line+41);
+		hash = name_hash(line+41);
 		add_preferred_base_object(line+41, hash);
 		add_object_entry(sha1, hash, 0);
 	}
