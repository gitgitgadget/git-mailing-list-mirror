From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Thu, 29 Sep 2005 08:16:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509290801230.3308@g5.osdl.org>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
 <Pine.LNX.4.58.0509251153090.3308@g5.osdl.org> <7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509280819000.3308@g5.osdl.org> <7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0509281007200.3308@g5.osdl.org> <7vk6h1rr9l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 17:20:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL09m-0006av-3W
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 17:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVI2PQU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 11:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVI2PQU
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 11:16:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932193AbVI2PQT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 11:16:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8TFGD4s010030
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Sep 2005 08:16:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8TFGCjR021618;
	Thu, 29 Sep 2005 08:16:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6h1rr9l.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9486>



On Wed, 28 Sep 2005, Junio C Hamano wrote:
> 
> Hmph.  That sort of makes sense but to make the unconditional
> simple case really fast it should use read-tree -m -u which
> _would_ smudge if things do not go well, which implies you need
> savestate before that which would make it slower -- wouldn't it?

Yeah, we'd have to do something like this.. (untested, surprise, surprise)

NOTE! Even if you don't take this, I noticed what looks like a missing 
"continue" in the "--head" case. That just can't work without it, afaik. 

Not that I know what "--head" is supposed to do.. 

		Linus
---
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -13,6 +13,8 @@
 static int merge = 0;
 static int update = 0;
 static int index_only = 0;
+static int nontrivial_merge = 0;
+static int trivial_merges_only = 0;
 
 static int head_idx = -1;
 static int merge_size = 0;
@@ -275,6 +277,9 @@ static int unpack_trees(merge_fn_t fn)
 	if (unpack_trees_rec(posns, len, "", fn, &indpos))
 		return -1;
 
+	if (trivial_merges_only && nontrivial_merge)
+		die("Merge requires file-level merging");
+
 	check_updates(active_cache, active_nr);
 	return 0;
 }
@@ -460,6 +465,8 @@ static int threeway_merge(struct cache_e
 		verify_uptodate(index);
 	}
 
+	nontrivial_merge = 1;
+
 	/* #2, #3, #4, #6, #7, #9, #11. */
 	count = 0;
 	if (!head_match || !remote_match) {
@@ -629,9 +636,15 @@ int main(int argc, char **argv)
 			continue;
 		}
 
+		if (!strcmp(arg, "--trivial")) {
+			trivial_merges_only = 1;
+			continue;
+		}
+
 		if (!strcmp(arg, "--head")) {
 			head_idx = stage - 1;
 			fn = threeway_merge;
+			continue;
 		}
 
 		/* "-m" stands for "merge", meaning we start in stage 1 */
