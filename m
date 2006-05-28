From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix memory leak in "git rev-list --objects"
Date: Sun, 28 May 2006 11:37:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605281114340.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 28 20:37:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkQ8r-0005LO-09
	for gcvg-git@gmane.org; Sun, 28 May 2006 20:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWE1Sha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWE1Sha
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 14:37:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24785 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750862AbWE1Sha (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 14:37:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4SIbO2g023067
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 May 2006 11:37:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4SIbNUB011382;
	Sun, 28 May 2006 11:37:24 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20888>


Martin Langhoff points out that "git repack -a" ends up using up a lot of 
memory for big archives, and that git cvsimport probably should do only 
incremental repacks in order to avoid having repacking flush all the 
caches.

The big majority of the memory usage of repacking is from git rev-list 
tracking all objects, and this patch should go a long way in avoiding the 
excessive memory usage: the bulk of it was due to the object names being 
leaked from the tree parser.

For the historic Linux kernel archive, this simple patch does:

Before:
	/usr/bin/time git-rev-list --all --objects > /dev/null 

	72.45user 0.82system 1:13.55elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+125376minor)pagefaults 0swaps

After:
	/usr/bin/time git-rev-list --all --objects > /dev/null 

	75.22user 0.48system 1:16.34elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+43921minor)pagefaults 0swaps

where we do end up wasting a bit of time on some extra strdup()s (which 
could be avoided, but that would require tracking where the pathnames came 
from), but we avoid a lot of memory usage.

Minor page faults track maximum RSS very closely (each page fault maps in 
one page into memory), so the reduction from 125376 page faults to 43921 
means a rough reduction of VM footprint from almost half a gigabyte to 
about a third of that. Those numbers were also double-checked by looking 
at "top" while the process was running.

(Side note: at least part of the remaining VM footprint is the mapping of 
the 177MB pack-file, so the remaining memory use is at least partly "well 
behaved" from a project caching perspective).

For the current git archive itself, the memory usage for a "--all 
--objects" rev-list invocation dropped from 7128 pages to 2318 (27MB to 
9MB), so the reduction seems to hold for much smaller projects too.

For regular "git-rev-list" usage (ie without the "--objects" flag) this 
patch has no impact.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index f11dbd6..5277d3c 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -103,6 +103,7 @@ static struct object_list **process_blob
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return p;
 	obj->flags |= SEEN;
+	name = strdup(name);
 	return add_object(obj, p, path, name);
 }
 
@@ -122,6 +123,7 @@ static struct object_list **process_tree
 	if (parse_tree(tree) < 0)
 		die("bad tree object %s", sha1_to_hex(obj->sha1));
 	obj->flags |= SEEN;
+	name = strdup(name);
 	p = add_object(obj, p, path, name);
 	me.up = path;
 	me.elem = name;
@@ -134,6 +136,7 @@ static struct object_list **process_tree
 			p = process_tree(entry->item.tree, p, &me, entry->name);
 		else
 			p = process_blob(entry->item.blob, p, &me, entry->name);
+		free(entry->name);
 		free(entry);
 		entry = next;
 	}
