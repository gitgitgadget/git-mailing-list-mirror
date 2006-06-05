From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Horrible re-packing?
Date: Mon, 5 Jun 2006 11:44:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 20:45:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnK4g-00047m-J9
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 20:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWFESou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 14:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWFESou
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 14:44:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751282AbWFESot (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 14:44:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k55Iib2g002323
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jun 2006 11:44:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k55IiaKa020583;
	Mon, 5 Jun 2006 11:44:36 -0700
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21328>



On Mon, 5 Jun 2006, Linus Torvalds wrote:
> 
> Whaah! That nice 6.33MB pack-file exploded to 14.5MB!
> 
> And it's possibly broken by the fact that we've been renaming things 
> lately (ie the "rev-list.c" -> "builtin-rev-list.c" thing ends up not 
> finding things)

No, it's even simpler.

The breakage is entirely mine, and due to the tree-walking conversion of 
the "process_tree()" function.

In that function, we used to have a local "const char *name" that 
_shadowed_ the incoming _argument_ with the same type, and the 
tree-walking conversion did not notice that the inner "name" should have 
been converted to "entry.path" - so it used the outer-level "name".

Gaah. We should probably use -Wshadow or something, which would hopefully 
have warned about the re-use of the same variable name in two different 
scopes.

Regardless, this fixes it.

		Linus
---
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 17c04b9..e885624 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -135,9 +135,9 @@ static struct object_list **process_tree
 
 	while (tree_entry(&desc, &entry)) {
 		if (S_ISDIR(entry.mode))
-			p = process_tree(lookup_tree(entry.sha1), p, &me, name);
+			p = process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
 		else
-			p = process_blob(lookup_blob(entry.sha1), p, &me, name);
+			p = process_blob(lookup_blob(entry.sha1), p, &me, entry.path);
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
