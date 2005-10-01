From: Linus Torvalds <torvalds@osdl.org>
Subject: Re-instate index file write optimization
Date: Sat, 1 Oct 2005 13:39:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510011331570.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Sat Oct 01 22:40:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELo9a-0007H4-Do
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 22:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVJAUjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 16:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVJAUjz
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 16:39:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750839AbVJAUjz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 16:39:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j91Kdm4s009132
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Oct 2005 13:39:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j91Kdlcb029163;
	Sat, 1 Oct 2005 13:39:47 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9604>


This makes "git-update-index" avoid the new index file write if it didn't 
make any changes to the index.

It still doesn't make things like "git status" be read-only operations in 
general, but if the index file doesn't need refreshing, it now will at 
least avoid making unnecessary changes.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This only makes sense after applying my previous patch, since otherwise a 
"--refresh" will always end up marking the index dirty anyway.

Also, while I tried to verify that we always mark the index dirty when we 
change it, I can't guarantee it. In particular, since we now map the index 
file with PROT_READ | PROT_WRITE, somebody can modify the index entries in 
place without getting a SIGSEGV.

Originally you couldn't do the modify-in-place, and used to be that you 
could depend on the active_cache[] being unmodified only by actually 
assigning to the pointer array itself.

I don't think git-update-index writes to the entries directly, though 
(git-read-tree does, but it doesn't do the optimization).

diff --git a/update-index.c b/update-index.c
--- a/update-index.c
+++ b/update-index.c
@@ -391,9 +391,11 @@ int main(int argc, const char **argv)
 			update_one(buf.buf, prefix, prefix_length);
 		}
 	}
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_index_file(&cache_file))
-		die("Unable to write new cachefile");
+	if (active_cache_changed) {
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    commit_index_file(&cache_file))
+			die("Unable to write new cachefile");
+	}
 
 	return has_errors ? 1 : 0;
 }
