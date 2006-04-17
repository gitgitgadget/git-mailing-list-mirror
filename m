From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Log message printout cleanups
Date: Mon, 17 Apr 2006 16:59:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
 <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
 <7vodyzkehq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 18 02:00:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVddP-0002M4-VV
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 02:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWDQX75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 19:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWDQX75
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 19:59:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932073AbWDQX74 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 19:59:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3HNxhtH010787
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Apr 2006 16:59:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3HNxgRZ028183;
	Mon, 17 Apr 2006 16:59:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodyzkehq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18841>



On Mon, 17 Apr 2006, Junio C Hamano wrote:
> 
> I like the new cmd_log_wc() loop very much; I was planning to do
> this myself, but I was too slow ;-).
> 
> Thanks.

Here's a further patch on top of the previous one with cosmetic 
improvements (no "real" code changes, just trivial updates):

 - it gets the "---" before a diffstat right, including for the combined 
   merge case. Righ now the logic is that we always use "---" when we have 
   a diffstat, and an empty line otherwise. That's how I visually prefer 
   it, but hey, it can be tweaked later.

 - I made "diff --cc/combined" add the "---/+++" header lines too. The 
   thing won't be mistaken for a valid diff, since the "@@" lines have too 
   many "@" characters (three or more), but it just makes it visually 
   match a real diff, which at least to me makes a big difference in 
   readability. Without them, it just looks very "wrong".

   I guess I should have taken the filename from each individual entry 
   (and had one "---" file per parent), but I didn't even bother to try to 
   see how that works, so this was the simple thing. 

With this, doing a

	git log --cc --patch-with-stat

looks quite readable, I think. The only nagging issue - as far as I'm 
concerned - is that diffstats for merges are pretty questionable the way 
they are done now. I suspect it would be better to just have the _first_ 
diffstat, and always make the merge diffstat be the one for "result 
against first parent".

I realize that Dscho has been looking at some much "fancier" merge 
diffstats, but I really do believe that the "what got merged" difference 
to the original branch (ie parent 1) is what you want in practice.

Anyway, that's a totally separate issue, I'll let you guys fight that out.

		Linus

---
diff --git a/combine-diff.c b/combine-diff.c
index b4fa9c9..aef9006 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -585,6 +585,16 @@ static void reuse_combine_diff(struct sl
 	sline->p_lno[i] = sline->p_lno[j];
 }
 
+static void dump_quoted_path(const char *prefix, const char *path)
+{
+	fputs(prefix, stdout);
+	if (quote_c_style(path, NULL, NULL, 0))
+		quote_c_style(path, NULL, stdout, 0);
+	else
+		printf("%s", path);
+	putchar('\n');
+}
+
 static int show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			   int dense, struct rev_info *rev)
 {
@@ -692,12 +702,7 @@ static int show_patch_diff(struct combin
 
 		if (rev->loginfo)
 			show_log(rev, rev->loginfo, "\n");
-		printf("diff --%s ", dense ? "cc" : "combined");
-		if (quote_c_style(elem->path, NULL, NULL, 0))
-			quote_c_style(elem->path, NULL, stdout, 0);
-		else
-			printf("%s", elem->path);
-		putchar('\n');
+		dump_quoted_path(dense ? "diff --cc " : "diff --combined ", elem->path);
 		printf("index ");
 		for (i = 0; i < num_parent; i++) {
 			abb = find_unique_abbrev(elem->parent[i].sha1,
@@ -728,6 +733,8 @@ static int show_patch_diff(struct combin
 			}
 			putchar('\n');
 		}
+		dump_quoted_path("--- a/", elem->path);
+		dump_quoted_path("+++ b/", elem->path);
 		dump_sline(sline, cnt, num_parent);
 	}
 	free(result);
@@ -861,6 +868,9 @@ void diff_tree_combined_merge(const unsi
 			       &diffopts);
 		diffcore_std(&diffopts);
 		paths = intersect_paths(paths, i, num_parent);
+
+		if (diffopts.with_stat && rev->loginfo)
+			show_log(rev, rev->loginfo, "---\n");
 		diff_flush(&diffopts);
 	}
 
diff --git a/log-tree.c b/log-tree.c
index c0a4432..9e54164 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,4 +1,3 @@
-
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
@@ -55,7 +54,7 @@ int log_tree_diff_flush(struct rev_info 
 	}
 
 	if (opt->loginfo && !opt->no_commit_id)
-		show_log(opt, opt->loginfo, "\n");
+		show_log(opt, opt->loginfo, opt->diffopt.with_stat ? "---\n" : "\n");
 	diff_flush(&opt->diffopt);
 	return 1;
 }
