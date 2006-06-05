From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Horrible re-packing?
Date: Mon, 5 Jun 2006 12:03:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 21:04:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnKMf-0007gQ-OM
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 21:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWFETDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 15:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWFETDq
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 15:03:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751303AbWFETDp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 15:03:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k55J3X2g003784
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jun 2006 12:03:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k55J3VMT021270;
	Mon, 5 Jun 2006 12:03:32 -0700
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21329>



On this same thread..

This trivial patch not only simplifies the name hashing, it actually 
improves packing for both git and the kernel.

The git archive pack shrinks from 6824090->6622627 bytes (a 3% 
improvement), and the kernel pack shrinks from 108756213 to 108219021 (a 
mere 0.5% improvement, but still, it's an improvement from making the 
hashing much simpler!)

I think the hash function with its comment is self-explanatory:

        /*
         * This effectively just creates a sortable number from the
         * last sixteen non-whitespace characters. Last characters
         * count "most", so things that end in ".c" sort together.
         */
        while ((c = *name++) != 0) {
                if (isspace(c))
                        continue;
                hash = (hash >> 2) + (c << 24);
        }
        return hash;

ie we just create a 32-bit hash, where we "age" previous characters by two 
bits, so the last characters in a filename count most. So when we then 
compare the hashes in the sort routine, filenames that end the same way 
sort the same way.

It takes the subdirectory into account (unless the filename is > 16 
characters), but files with the same name within the same subdirectory 
will obviously sort closer than files in different subdirectories.

And, incidentally (which is why I tried the hash change in the first 
place, of course) builtin-rev-list.c will sort fairly close to rev-list.c.

And no, it's not a "good hash" in the sense of being secure or unique, but 
that's not what we're looking for. The whole "hash" thing is misnamed 
here. It's not so much a hash as a "sorting number".

Comments?

		Linus

----
 pack-objects.c |   41 +++++++++++------------------------------
 1 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/pack-objects.c b/pack-objects.c
index 3590cd5..ae49fba 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -473,38 +473,19 @@ #define DIRBITS 12
 
 static unsigned name_hash(struct name_path *path, const char *name)
 {
-	struct name_path *p = path;
-	const char *n = name + strlen(name);
-	unsigned hash = 0, name_hash = 0, name_done = 0;
-
-	if (n != name && n[-1] == '\n')
-		n--;
-	while (name <= --n) {
-		unsigned char c = *n;
-		if (c == '/' && !name_done) {
-			name_hash = hash;
-			name_done = 1;
-			hash = 0;
-		}
-		hash = hash * 11 + c;
-	}
-	if (!name_done) {
-		name_hash = hash;
-		hash = 0;
-	}
-	for (p = path; p; p = p->up) {
-		hash = hash * 11 + '/';
-		n = p->elem + p->len;
-		while (p->elem <= --n) {
-			unsigned char c = *n;
-			hash = hash * 11 + c;
-		}
-	}
+	unsigned char c;
+	unsigned hash = 0;
+
 	/*
-	 * Make sure "Makefile" and "t/Makefile" are hashed separately
-	 * but close enough.
+	 * This effectively just creates a sortable number from the
+	 * last sixteen non-whitespace characters. Last characters
+	 * count "most", so things that end in ".c" sort together.
 	 */
-	hash = (name_hash<<DIRBITS) | (hash & ((1U<<DIRBITS )-1));
+	while ((c = *name++) != 0) {
+		if (isspace(c))
+			continue;
+		hash = (hash >> 2) + (c << 24);
+	}
 	return hash;
 }
 
