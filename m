From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 18:18:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141811050.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org> <43F249F7.5060008@vilain.net>
 <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org> <7vy80dpo9g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602141741210.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 03:19:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9CFu-0007Ux-K1
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 03:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbWBOCS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 21:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030593AbWBOCS1
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 21:18:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030592AbWBOCS0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 21:18:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1F2IMDZ018575
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 18:18:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1F2ILfu007650;
	Tue, 14 Feb 2006 18:18:22 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602141741210.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16205>



On Tue, 14 Feb 2006, Linus Torvalds wrote:
> 
> Finally (a more serious caveat):
>  - doing things through stdout may end up being so expensive that we'd 
>    need to do something else. In particular, it's likely that I should 
>    not actually output the "merge results", but instead output a "merge 
>    results as they _differ_ from branch1"
> 
> In many ways, the really _interesting_ part of a merge is not the result, 
> but how it _changes_ the branch we're merging into. That's particularly 
> important as it should hopefully also mean that the output size for any 
> reasonable case is minimal (and tracks what we actually need to do to the 
> current state to create the final result).

Here, btw, is the trivial diff to turn my previous "tree-resolve" into a 
"resolve tree relative to the current branch".

In particular, it makes the example merge perhaps even more interesting, 
and makes the "merging directories and merging files should use different 
heuristics more obvious". It's quite instructive, I think.

So if you want to test this, the merge I have been testing with is the 
last infiniband merge in the kernel:

	git-merge-tree 3c3b809 4cbf876 7d2babc

and you'll need to spend a few moments on thinking about what the 
"directory merge" thing there means: in particular, we should probably 
make the

	if (entry[2].sha1) {

test be

	if (entry[2].sha && !S_ISDIR(entry[2].mode)) {

(and same for "resolve to entry[1]" case for that matter) so that we never 
create a "resolve()" that picks a whole subdirectory from one of the 
branches.

The current logic is "logical", just probably not what we want.

		Linus

----
diff --git a/merge-tree.c b/merge-tree.c
index 0d6d434..0bf871c 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -55,9 +55,19 @@ static int same_entry(struct name_entry 
 		a->mode == b->mode;
 }
 
-static void resolve(const char *base, struct name_entry *result)
+static void resolve(const char *base, struct name_entry *branch1, struct name_entry *result)
 {
-	printf("0 %06o %s %s%s\n", result->mode, sha1_to_hex(result->sha1), base, result->path);
+	char branch1_sha1[50];
+
+	/* If it's already branch1, don't bother showing it */
+	if (!branch1)
+		return;
+	memcpy(branch1_sha1, sha1_to_hex(branch1->sha1), 41);
+
+	printf("0 %06o->%06o %s->%s %s%s\n",
+		branch1->mode, result->mode,
+		branch1_sha1, sha1_to_hex(result->sha1),
+		base, result->path);
 }
 
 static int unresolved_directory(const char *base, struct name_entry n[3])
@@ -183,21 +193,21 @@ static void merge_trees(struct tree_desc
 		/* Same in both? */
 		if (same_entry(entry+1, entry+2)) {
 			if (entry[0].sha1) {
-				resolve(base, entry+1);
+				resolve(base, NULL, entry+1);
 				continue;
 			}
 		}
 
 		if (same_entry(entry+0, entry+1)) {
 			if (entry[2].sha1) {
-				resolve(base, entry+2);
+				resolve(base, entry+1, entry+2);
 				continue;
 			}
 		}
 
 		if (same_entry(entry+0, entry+2)) {
 			if (entry[1].sha1) {
-				resolve(base, entry+1);
+				resolve(base, NULL, entry+1);
 				continue;
 			}
 		}
