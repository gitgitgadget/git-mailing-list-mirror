From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Log message printout cleanups
Date: Mon, 17 Apr 2006 17:43:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604171727050.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
 <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
 <7vodyzkehq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
 <7vejzvka09.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 18 02:43:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVeJr-00046A-Cx
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 02:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWDRAns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 20:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWDRAns
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 20:43:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932084AbWDRAnr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 20:43:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3I0hftH012189
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Apr 2006 17:43:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3I0heAB029178;
	Mon, 17 Apr 2006 17:43:40 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejzvka09.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18845>



On Mon, 17 Apr 2006, Junio C Hamano wrote:
> 
> Showing stat from the first parent makes --stat inconsistent
> from what the "fake diff" shows, but I think it is a sensible
> thing to do.

It might actually be even more than sensible: it's a huge hint especially 
for users of "--cc" (or even --combined) that the diff we show really 
isn't all there is to the merge. So having the "full" diffstat is not just 
usually what you want to see, it's probably also a really good hint for 
people who otherwise might not realize that our combined diffs have 
skipped all the common parts.

Btw, I just noticed that I broke "--pretty=oneline" AGAIN. That thing is 
very special, since pretty_print_commit() will _remove_ the newline at the 
end of it, so we want to have an extra separator between the things.

I added a honking big comment this time, so that (a) I don't forget this 
_again_ (I broke "oneline" several times during this printout cleanup), 
and so that people can understand _why_ the code does what it does.

Now, arguably the alternate fix is to always have the '\n' at the end in 
pretty-print-commit, but git-rev-list depends on the current behaviour 
(but we could have git-rev-list remove it, whatever).

With the big comment, the code hopefully doesn't get broken again. And now 
things like

	git log --pretty=oneline --cc --patch-with-stat

works (even if that is admittedly a totally insane combination: if you 
want the patch, having the "oneline" log format is just crazy, but hey, 
it _works_. Even insane people are people).

		Linus
---
diff --git a/log-tree.c b/log-tree.c
index c0a4432..9634c46 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -10,6 +9,7 @@ void show_log(struct rev_info *opt, stru
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev = opt->diffopt.abbrev;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
+	const char *extra;
 	int len;
 
 	opt->loginfo = NULL;
@@ -19,8 +19,17 @@ void show_log(struct rev_info *opt, stru
 	}
 
 	/*
-	 * Whitespace between commit messages, unless we are oneline
+	 * The "oneline" format has several special cases:
+	 *  - The pretty-printed commit lacks a newline at the end
+	 *    of the buffer, but we do want to make sure that we
+	 *    have a newline there. If the separator isn't already
+	 *    a newline, add an extra one.
+	 *  - unlike other log messages, the one-line format does
+	 *    not have an empty line between entries.
 	 */
+	extra = "";
+	if (*sep != '\n' && opt->commit_format == CMIT_FMT_ONELINE)
+		extra = "\n";
 	if (opt->shown_one && opt->commit_format != CMIT_FMT_ONELINE)
 		putchar('\n');
 	opt->shown_one = 1;
@@ -39,7 +48,7 @@ void show_log(struct rev_info *opt, stru
 	 * And then the pretty-printed message itself
 	 */
 	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev);
-	printf("%s%s", this_header, sep);
+	printf("%s%s%s", this_header, extra, sep);
 }
 
 int log_tree_diff_flush(struct rev_info *opt)
