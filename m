From: Linus Torvalds <torvalds@osdl.org>
Subject: Better error messages for corrupt databases
Date: Thu, 11 Jan 2007 14:09:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111400031.3594@woody.osdl.org>
References: <20070111125726.GJ1759@mellanox.co.il>
 <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
 <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org> <45A6A97F.5080008@shadowen.org>
 <7vodp52qzz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Whitcroft <apw@shadowen.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 23:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5892-00024b-Ik
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbXAKWLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 17:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXAKWLe
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:11:34 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38531 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbXAKWLd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 17:11:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BM9WWi007460
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 14:09:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BM9WXk004450;
	Thu, 11 Jan 2007 14:09:32 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodp52qzz.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.663 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36623>



This fixes another problem that Andy's case showed: git-fsck-objects 
reports nonsensical results for corrupt objects.

There were actually two independent and confusing problems:

 - when we had a zero-sized file and used map_sha1_file, mmap() would 
   return EINVAL, and git-fsck-objects would report that as an insane and 
   confusing error. I don't know when this was introduced, it might have 
   been there forever.

 - when "parse_object()" returned NULL, fsck would say "object not found", 
   which can be very confusing, since obviously the object might "exist", 
   it's just unparseable because it's totally corrupt.

So this just makes "xmmap()" return NULL for a zero-sized object (which is 
a valid thing pointer, exactly the same way "malloc()" can return NULL for 
a zero-sized allocation). That fixes the first problem (but we could have 
fixed it in the caller too - I don't personally much care whichever way it 
goes, but maybe somebody should check that the NO_MMAP case does 
something sane in this case too?).

And the second problem is solved by just making the error message slightly 
clearer - the failure to parse an object may be because it's missing or 
corrupt, not necessarily because it's not "found".

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This would hopefully have made the error case Andy had a bit more readable 
and understandable.

diff --git a/fsck-objects.c b/fsck-objects.c
index 0d8a8eb..81f00db 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -290,7 +290,7 @@ static int fsck_sha1(unsigned char *sha1)
 {
 	struct object *obj = parse_object(sha1);
 	if (!obj)
-		return error("%s: object not found", sha1_to_hex(sha1));
+		return error("%s: object corrupt or missing", sha1_to_hex(sha1));
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |= SEEN;
diff --git a/git-compat-util.h b/git-compat-util.h
index f8d46d5..8781e8e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -202,6 +202,8 @@ static inline void *xmmap(void *start, size_t length,
 {
 	void *ret = mmap(start, length, prot, flags, fd, offset);
 	if (ret == MAP_FAILED) {
+		if (!length)
+			return NULL;
 		release_pack_memory(length);
 		ret = mmap(start, length, prot, flags, fd, offset);
 		if (ret == MAP_FAILED)
