From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 18:33:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141829080.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org> <43F249F7.5060008@vilain.net>
 <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602141741210.3691@g5.osdl.org> <Pine.LNX.4.64.0602141811050.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 03:33:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9CU1-0001sq-NI
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 03:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030598AbWBOCdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 21:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030600AbWBOCdL
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 21:33:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030598AbWBOCdK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 21:33:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1F2X5DZ019245
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 18:33:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1F2X2kZ008115;
	Tue, 14 Feb 2006 18:33:04 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602141811050.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16206>



On Tue, 14 Feb 2006, Linus Torvalds wrote:
> 
> Here, btw, is the trivial diff to turn my previous "tree-resolve" into a 
> "resolve tree relative to the current branch".

Gaah. It was trivial, and it happened to work fine for my test-case, but 
when I started looking at not doing that extremely aggressive subdirectory 
merging, that showed a few other issues...

So in case people want to try, here's a third patch. Oh, and it's against 
my _original_ path, not incremental to the middle one (ie both patches two 
and three are against patch #1, it's not a nice series).

Now I'm really done, and won't be sending out any more patches today. 
Sorry for the noise.

		Linus
----
diff --git a/merge-tree.c b/merge-tree.c
index 0d6d434..6381118 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -55,9 +55,26 @@ static int same_entry(struct name_entry 
 		a->mode == b->mode;
 }
 
-static void resolve(const char *base, struct name_entry *result)
+static const char *sha1_to_hex_zero(const unsigned char *sha1)
 {
-	printf("0 %06o %s %s%s\n", result->mode, sha1_to_hex(result->sha1), base, result->path);
+	if (sha1)
+		return sha1_to_hex(sha1);
+	return "0000000000000000000000000000000000000000";
+}
+
+static void resolve(const char *base, struct name_entry *branch1, struct name_entry *result)
+{
+	char branch1_sha1[50];
+
+	/* If it's already branch1, don't bother showing it */
+	if (!branch1)
+		return;
+	memcpy(branch1_sha1, sha1_to_hex_zero(branch1->sha1), 41);
+
+	printf("0 %06o->%06o %s->%s %s%s\n",
+		branch1->mode, result->mode,
+		branch1_sha1, sha1_to_hex_zero(result->sha1),
+		base, result->path);
 }
 
 static int unresolved_directory(const char *base, struct name_entry n[3])
@@ -100,9 +117,12 @@ static void unresolved(const char *base,
 {
 	if (unresolved_directory(base, n))
 		return;
-	printf("1 %06o %s %s%s\n", n[0].mode, sha1_to_hex(n[0].sha1), base, n[0].path);
-	printf("2 %06o %s %s%s\n", n[1].mode, sha1_to_hex(n[1].sha1), base, n[1].path);
-	printf("3 %06o %s %s%s\n", n[2].mode, sha1_to_hex(n[2].sha1), base, n[2].path);
+	if (n[0].sha1)
+		printf("1 %06o %s %s%s\n", n[0].mode, sha1_to_hex(n[0].sha1), base, n[0].path);
+	if (n[1].sha1)
+		printf("2 %06o %s %s%s\n", n[1].mode, sha1_to_hex(n[1].sha1), base, n[1].path);
+	if (n[2].sha1)
+		printf("3 %06o %s %s%s\n", n[2].mode, sha1_to_hex(n[2].sha1), base, n[2].path);
 }
 
 /*
@@ -183,21 +203,21 @@ static void merge_trees(struct tree_desc
 		/* Same in both? */
 		if (same_entry(entry+1, entry+2)) {
 			if (entry[0].sha1) {
-				resolve(base, entry+1);
+				resolve(base, NULL, entry+1);
 				continue;
 			}
 		}
 
 		if (same_entry(entry+0, entry+1)) {
-			if (entry[2].sha1) {
-				resolve(base, entry+2);
+			if (entry[2].sha1 && !S_ISDIR(entry[2].mode)) {
+				resolve(base, entry+1, entry+2);
 				continue;
 			}
 		}
 
 		if (same_entry(entry+0, entry+2)) {
-			if (entry[1].sha1) {
-				resolve(base, entry+1);
+			if (entry[1].sha1 && !S_ISDIR(entry[1].mode)) {
+				resolve(base, NULL, entry+1);
 				continue;
 			}
 		}
