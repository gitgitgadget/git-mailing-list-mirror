From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fixes for option parsing
Date: Sun, 16 Apr 2006 20:03:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604161952500.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
 <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604161938070.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 05:04:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVK27-0005hd-2I
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 05:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWDQDEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 23:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWDQDEA
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 23:04:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750966AbWDQDEA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 23:04:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3H33ttH024150
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 16 Apr 2006 20:03:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3H33sax024648;
	Sun, 16 Apr 2006 20:03:55 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604161938070.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18814>



On Sun, 16 Apr 2006, Linus Torvalds wrote:
> 
> Maybe. I'm not convinced, though. The reason? cmd_log_wc needs to generate 
> it regardless, for the "always" case.

Of course, you could just have the "diff" logic unconditionally do the 
call-back. That would be clean enough.

> Also, I think the "---" printing should be removed, and moved into the 
> "diffstat" flushing code. Right now it does the wrong thing entirely if 
> no diff exists, but we have always_show_header: it will print the "---" 
> for no good reason.

The alternative is to do something like this, but because the "diffstat" 
doesn't flush the header priperly, it doesn't add the "---" for merges 
(and it used to not show the log at all, even for "git log", before I 
fixed it).

Try it with

	git log --cc --patch-with-stat

to see what I mean.

I do agree that this would be much cleaner with a "print header" callback 
in the diffopt structure. This patch is the really hacky "continue to do 
things the ugly way" approach to fix some of the uglier output.

Only meant as a RFC and to illustrate what I think the output should look 
like (modulo the lack of "---" before a diffstat with no patch - for 
merges). Not meant to actually be applied, I think this can be done much 
more cleanly with the callback.

		Linus

---
diff --git a/git.c b/git.c
index fc4e429..dc577fa 100644
--- a/git.c
+++ b/git.c
@@ -284,7 +284,7 @@ static int cmd_log_wc(int argc, const ch
 	struct commit *commit;
 	char *buf = xmalloc(LOGSIZE);
 	const char *commit_prefix = "commit ";
-	int shown = 0;
+	int shown = 0, always_show_header;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -295,13 +295,19 @@ static int cmd_log_wc(int argc, const ch
 	if (rev->commit_format == CMIT_FMT_ONELINE)
 		commit_prefix = "";
 
+	/*
+	 * We handle always_show_header outselves, and leave the
+	 * "---" handling to log_tree_commit
+	 */
+	always_show_header = rev->always_show_header;
+	rev->always_show_header = 0;
+
 	prepare_revision_walk(rev);
 	setup_pager();
 	while ((commit = get_revision(rev)) != NULL) {
 		unsigned long ofs = 0;
 
-		if (shown && rev->diff &&
-		    rev->commit_format != CMIT_FMT_ONELINE)
+		if (shown && rev->commit_format != CMIT_FMT_ONELINE)
 			putchar('\n');
 
 		ofs = sprintf(buf, "%s", commit_prefix);
@@ -338,14 +344,16 @@ static int cmd_log_wc(int argc, const ch
 					   buf + ofs,
 					   LOGSIZE - ofs - 20,
 					   rev->abbrev);
+		if (always_show_header || !rev->diff) {
+			fputs(buf, stdout);
+			ofs = 0;
+		}
 
 		if (rev->diff) {
+			strcpy(buf + ofs, rev->diffopt.with_stat ? "---" : "\n");
 			rev->use_precomputed_header = buf;
-			strcpy(buf + ofs, "\n---\n");
 			log_tree_commit(rev, commit);
 		}
-		else
-			printf("%s\n", buf);
 		shown = 1;
 		free(commit->buffer);
 		commit->buffer = NULL;
