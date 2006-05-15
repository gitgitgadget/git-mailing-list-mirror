From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Simplify "git reset --hard"
Date: Mon, 15 May 2006 08:09:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605150807030.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605141040210.3866@g5.osdl.org>
 <Pine.LNX.4.64.0605141110150.3866@g5.osdl.org> <7v1wuvwzdv.fsf@assigned-by-dhcp.cox.net>
 <7vwtcnvk76.fsf@assigned-by-dhcp.cox.net> <7vr72vvigy.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605150752490.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:09:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfehX-0001mn-BN
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWEOPJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWEOPJh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:09:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964821AbWEOPJg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 11:09:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4FF9WtH008752
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 08:09:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4FF9VSD005702;
	Mon, 15 May 2006 08:09:31 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0605150752490.3866@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20053>



On Mon, 15 May 2006, Linus Torvalds wrote:
> 
> Ack. On the other hand, I wonder if it might not make sense to have this 
> part potentially depend on the "--reset" flag.
> 
> That way you wouldn't even have to apologize for it.

Ie, something like this..

This should allow a two-way or three-way merge to akso ignore any dirty 
state when you use "--reset", because they use "verify_uptodate()", which 
now would set the CD_UPDATE flag on the ce rather than complain about it 
being different (if it survives the merge, of course - often it won't, but 
then we won't care).

This is all totally untested, of course.

		Linus

----
diff --git a/read-tree.c b/read-tree.c
index 7c83031..f2d674c 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -13,6 +13,7 @@ #include "cache-tree.h"
 #include <sys/time.h>
 #include <signal.h>
 
+static int reset = 0;
 static int merge = 0;
 static int update = 0;
 static int index_only = 0;
@@ -419,6 +420,10 @@ static void verify_uptodate(struct cache
 			return;
 		errno = 0;
 	}
+	if (reset) {
+		ce->ce_flags |= htons(CE_UPDATE);
+		return;
+	}
 	if (errno == ENOENT)
 		return;
 	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
@@ -723,6 +728,11 @@ static int oneway_merge(struct cache_ent
 		return deleted_entry(old, NULL);
 	}
 	if (old && same(old, a)) {
+		if (reset) {
+			struct stat st;
+			if (lstat(old->name, &st) || ce_match_stat(old, &st, 1))
+				old->ce_flags |= htons(CE_UPDATE);
+		}
 		return keep_entry(old);
 	}
 	return merged_entry(a, NULL);
@@ -790,7 +800,7 @@ static struct cache_file cache_file;
 
 int main(int argc, char **argv)
 {
-	int i, newfd, reset, stage = 0;
+	int i, newfd, stage = 0;
 	unsigned char sha1[20];
 	merge_fn_t fn = NULL;
 
