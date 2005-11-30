From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 19:12:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
References: <20051130001503.28498.qmail@science.horizon.com>
 <Pine.LNX.4.64.0511291742000.3135@g5.osdl.org> <7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 04:15:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhIPY-00067v-Iu
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 04:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVK3DNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 22:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVK3DNL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 22:13:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750794AbVK3DNK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 22:13:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAU3CnnO016395
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 29 Nov 2005 19:12:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAU3CjO7001795;
	Tue, 29 Nov 2005 19:12:47 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12982>



On Tue, 29 Nov 2005, Junio C Hamano wrote:
> 
> I have actually resolved one conflicting merge with this and it
> was OK, except that it was a bit unpleasant when I first did
> "git-diff-index HEAD" without giving any path ;-),

What does "git-diff-files" do? Just output a lot of nasty "unmerged" 
messages?

The _nice_ thing to do would be to output one "unmerged" message, but 
then diff against stage2 if it exists (and it basically always should, 
since otherwise we wouldn't have gotten a merge error).

If it did that, then you'd have the best of both world: the old nice "git 
diff" behaviour _and_ being safe (and saying that it's unmerged).

Something like this (untested, of course).

It _should_ write out

	* Unmerged path <filename>

followed by a regular diff, exactly like you'd want.

[ This all assumes that merge-one-file leaves the stages right. I think my 
  patch to do that was just broken. Yours was probably not. ]

		Linus

---
diff --git a/diff-files.c b/diff-files.c
index 38599b5..8a78326 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -95,11 +95,23 @@ int main(int argc, const char **argv)
 
 		if (ce_stage(ce)) {
 			show_unmerge(ce->name);
-			while (i < entries &&
-			       !strcmp(ce->name, active_cache[i]->name))
+			while (i < entries) {
+				struct cache_entry *nce = active_cache[i];
+
+				if (strcmp(ce->name, nce->name))
+					break;
+				/* Prefer to diff against stage 2 (original branch) */
+				if (ce_stage(nce) == 2)
+					ce = nce;
 				i++;
-			i--; /* compensate for loop control increments */
-			continue;
+			}
+			/*
+			 * Compensate for loop update
+			 */
+			i--;
+			/*
+			 * Show the diff for the 'ce' we chose
+			 */
 		}
 
 		if (lstat(ce->name, &st) < 0) {
