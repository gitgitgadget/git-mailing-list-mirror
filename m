From: John Keeping <john@keeping.me.uk>
Subject: Re: fast-import bug?
Date: Sat, 22 Jun 2013 11:21:58 +0100
Message-ID: <20130622102157.GE4676@serenity.lan>
References: <m2zjuj2504.fsf@cube.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 12:22:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqKxR-0003h3-Vp
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 12:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab3FVKWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 06:22:09 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34119 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab3FVKWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 06:22:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id F2CE9CDA594;
	Sat, 22 Jun 2013 11:22:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cjrgcLdtuOCv; Sat, 22 Jun 2013 11:22:06 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 347C7CDA57D;
	Sat, 22 Jun 2013 11:22:05 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D2B2D161E18E;
	Sat, 22 Jun 2013 11:22:05 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PbasZrqj2Wx6; Sat, 22 Jun 2013 11:22:05 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7BA09161E2DC;
	Sat, 22 Jun 2013 11:22:00 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <m2zjuj2504.fsf@cube.gateway.2wire.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228695>

On Fri, Jun 21, 2013 at 02:21:47AM -0700, Dave Abrahams wrote:
> The docs for fast-import seem to imply that I can use "ls" to get the
> SHA1 of a commit for which I have a mark:
> 
>        Reading from a named tree
>            The <dataref> can be a mark reference (:<idnum>) or the full 40-byte
>            SHA-1 of a Git tag, commit, or tree object, preexisting or waiting to
>            be written. The path is relative to the top level of the tree named by
>            <dataref>.
> 
>                        'ls' SP <dataref> SP <path> LF
> 
>        See filemodify above for a detailed description of <path>.
> 
>        Output uses the same format as git ls-tree <tree> -- <path>:
> 
>            <mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF
> 
>        The <dataref> represents the blob, tree, or commit object at <path> and
>                                                    ^^^^^^
>        can be used in later cat-blob, filemodify, or ls commands.
> 
> but I can't get it to work.  It's not entirely clear it's supposed to
> work.  What path would I pass?  Passing an empty path simply causes git
> to report "missing ".

Which version of Git are you using?  I just tried this and get the error
"fatal: Empty path component found in input", which seems to be from
commit 178e1de (fast-import: don't allow 'ls' of path with empty
components, 2012-03-09), which is included in Git 1.7.9.5.

It seems to be slightly more complicated than that though, because after
allowing empty trees I get the "missing" message for the root tree.
This seems to be because its mode is 0 and not S_IFDIR.

With the patch below, things are working as I expect but I don't
understand why the mode of the root is not set correctly at this point.
Perhaps someone more familiar with fast-import will have some insight...

-- >8 --
diff --git a/fast-import.c b/fast-import.c
index 23f625f..bcce651 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1626,6 +1626,15 @@ del_entry:
 	return 1;
 }
 
+static void copy_tree_entry(struct tree_entry *dst, struct tree_entry *src)
+{
+	memcpy(dst, src, sizeof(*dst));
+	if (src->tree && is_null_sha1(src->versions[1].sha1))
+		dst->tree = dup_tree_content(src->tree);
+	else
+		dst->tree = NULL;
+}
+
 static int tree_content_get(
 	struct tree_entry *root,
 	const char *p,
@@ -1651,11 +1660,7 @@ static int tree_content_get(
 		e = t->entries[i];
 		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
 			if (!slash1) {
-				memcpy(leaf, e, sizeof(*leaf));
-				if (e->tree && is_null_sha1(e->versions[1].sha1))
-					leaf->tree = dup_tree_content(e->tree);
-				else
-					leaf->tree = NULL;
+				copy_tree_entry(leaf, e);
 				return 1;
 			}
 			if (!S_ISDIR(e->versions[1].mode))
@@ -3065,7 +3070,11 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p = uq.buf;
 	}
-	tree_content_get(root, p, &leaf);
+	if (!*p) {
+		copy_tree_entry(&leaf, root);
+		leaf.versions[1].mode = S_IFDIR;
+	} else
+		tree_content_get(root, p, &leaf);
 	/*
 	 * A directory in preparation would have a sha1 of zero
 	 * until it is saved.  Save, for simplicity.
