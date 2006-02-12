From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix object re-hashing
Date: Sun, 12 Feb 2006 10:04:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Feb 12 19:04:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8LaP-0008AS-7k
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 19:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWBLSEe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 13:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWBLSEe
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 13:04:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750814AbWBLSEd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 13:04:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1CI4RDZ015039
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 10:04:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1CI4QGk014305;
	Sun, 12 Feb 2006 10:04:27 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16003>


The hashed object lookup had a subtle bug in re-hashing: it did

	for (i = 0; i < count; i++)
		if (objs[i]) {
			.. rehash ..

where "count" was the old hash couny. Oon the face of it is obvious, since 
it clearly re-hashes all the old objects.

However, it's wrong.

If the last old hash entry before re-hashing was in use (or became in use 
by the re-hashing), then when re-hashing could have inserted an object 
into the hash entries with idx >= count due to overflow. When we then 
rehash the last old entry, that old entry might become empty, which means 
that the overflow entries should be re-hashed again.

In other words, the loop has to be fixed to either traverse the whole 
array, rather than just the old count.

(There's room for a slight optimization: instead of counting all the way 
up, we can break when we see the first empty slot that is above the old 
"count". At that point we know we don't have any collissions that we might 
have to fix up any more. This patch only does the trivial fix)

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

I actually didn't see any of this trigger in real life, so maybe my 
analysis is wrong. Junio? Johannes?

diff --git a/object.c b/object.c
index 59e5e36..aeda228 100644
--- a/object.c
+++ b/object.c
@@ -65,7 +65,7 @@ void created_object(const unsigned char 
 		objs = xrealloc(objs, obj_allocs * sizeof(struct object *));
 		memset(objs + count, 0, (obj_allocs - count)
 				* sizeof(struct object *));
-		for (i = 0; i < count; i++)
+		for (i = 0; obj_allocs ; i++)
 			if (objs[i]) {
 				int j = find_object(objs[i]->sha1);
 				if (j != i) {
