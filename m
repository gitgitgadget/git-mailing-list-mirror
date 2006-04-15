From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Recent unresolved issues
Date: Fri, 14 Apr 2006 17:19:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604141717280.3701@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 15 02:19:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUYVh-0001ri-1I
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 02:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWDOATa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 20:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWDOATa
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 20:19:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751444AbWDOAT3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Apr 2006 20:19:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3F0JPtH009111
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Apr 2006 17:19:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3F0JOGd017327;
	Fri, 14 Apr 2006 17:19:24 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18712>



On Fri, 14 Apr 2006, Linus Torvalds wrote:
> 
> It's nice to note how simple and straightforward this makes the built-in 
> "git log" command, even though it continues to support all the diff flags 
> too. It doesn't get much simpler that this.

Gaah. Missed this important part, which causes the thing to ignore the 
"--pretty=xyzzy" argument, since it would always use its own default 
format that is no longer ever changed.

I even tested that it works for git-diff-tree, just not for git log. Duh.

(Found the hard way - after I had already used the broken git version for 
doing several merges, and the "--pretty=oneline" format didn't work and 
screwed up the merge message ;)

		Linus

----
diff --git a/git.c b/git.c
index e8d1fcc..d5a4a24 100644
--- a/git.c
+++ b/git.c
@@ -283,9 +283,6 @@ static int cmd_log(int argc, const char 
 	struct rev_info rev;
 	struct commit *commit;
 	char *buf = xmalloc(LOGSIZE);
-	static enum cmit_fmt commit_format = CMIT_FMT_DEFAULT;
-	int abbrev = DEFAULT_ABBREV;
-	int abbrev_commit = 0;
 	const char *commit_prefix = "commit ";
 	int shown = 0;
 
@@ -298,11 +295,11 @@ static int cmd_log(int argc, const char 
 	prepare_revision_walk(&rev);
 	setup_pager();
 	while ((commit = get_revision(&rev)) != NULL) {
-		if (shown && rev.diff && commit_format != CMIT_FMT_ONELINE)
+		if (shown && rev.diff && rev.commit_format != CMIT_FMT_ONELINE)
 			putchar('\n');
 		fputs(commit_prefix, stdout);
-		if (abbrev_commit && abbrev)
-			fputs(find_unique_abbrev(commit->object.sha1, abbrev),
+		if (rev.abbrev_commit && rev.abbrev)
+			fputs(find_unique_abbrev(commit->object.sha1, rev.abbrev),
 			      stdout);
 		else
 			fputs(sha1_to_hex(commit->object.sha1), stdout);
@@ -325,12 +322,12 @@ static int cmd_log(int argc, const char 
 			     parents = parents->next)
 				parents->item->object.flags &= ~TMP_MARK;
 		}
-		if (commit_format == CMIT_FMT_ONELINE)
+		if (rev.commit_format == CMIT_FMT_ONELINE)
 			putchar(' ');
 		else
 			putchar('\n');
-		pretty_print_commit(commit_format, commit, ~0, buf,
-				    LOGSIZE, abbrev);
+		pretty_print_commit(rev.commit_format, commit, ~0, buf,
+				    LOGSIZE, rev.abbrev);
 		printf("%s\n", buf);
 		if (rev.diff)
 			log_tree_commit(&rev, commit);
