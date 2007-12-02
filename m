From: Jeff King <peff@peff.net>
Subject: [PATCH resend] git-commit: clean up die messages
Date: Sun, 2 Dec 2007 01:07:03 -0500
Message-ID: <20071202060703.GA25371@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 07:07:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyhzG-0006Di-Ow
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 07:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbXLBGHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 01:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbXLBGHG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 01:07:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1349 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbXLBGHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 01:07:05 -0500
Received: (qmail 18822 invoked by uid 111); 2 Dec 2007 06:07:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 01:07:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 01:07:03 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66762>

These are three types of cleanups here:

  1. remove newline from die message (die/report adds it
     already)
  2. typo: s/merger/merge/
  3. the old "* no commit message?  aborting commit." is now
     prepended with "fatal: ", making the asterisk look a
     little funny. Let's just remove it.

Signed-off-by: Jeff King <peff@peff.net>
---
[sorry for the resend, I totally munged Kristian's address in the first
one].

I actually noticed number 3, and while fixing it, saw the others. The
wording in number 3 is a bit awkward, IMHO. I wonder if it might be
better as something like:

  fatal: aborting commit with empty message

 builtin-commit.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 0f1ae17..f6e8e44 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -336,7 +336,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
 	fp = fopen(git_path(commit_editmsg), "w");
 	if (fp == NULL)
-		die("could not open %s\n", git_path(commit_editmsg));
+		die("could not open %s", git_path(commit_editmsg));
 
 	stripspace(&sb, 0);
 
@@ -362,8 +362,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	}
 
 	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
-		die("could not write commit template: %s\n",
-		    strerror(errno));
+		die("could not write commit template: %s", strerror(errno));
 
 	strbuf_release(&sb);
 
@@ -470,13 +469,13 @@ static void determine_author_info(struct strbuf *sb)
 
 		a = strstr(use_message_buffer, "\nauthor ");
 		if (!a)
-			die("invalid commit: %s\n", use_message);
+			die("invalid commit: %s", use_message);
 
 		lb = strstr(a + 8, " <");
 		rb = strstr(a + 8, "> ");
 		eol = strchr(a + 8, '\n');
 		if (!lb || !rb || !eol)
-			die("invalid commit: %s\n", use_message);
+			die("invalid commit: %s", use_message);
 
 		name = xstrndup(a + 8, lb - (a + 8));
 		email = xstrndup(lb + 2, rb - (lb + 2));
@@ -488,7 +487,7 @@ static void determine_author_info(struct strbuf *sb)
 		const char *rb = strchr(force_author, '>');
 
 		if (!lb || !rb)
-			die("malformed --author parameter\n");
+			die("malformed --author parameter");
 		name = xstrndup(force_author, lb - force_author);
 		email = xstrndup(lb + 2, rb - (lb + 2));
 	}
@@ -518,7 +517,7 @@ static int parse_and_validate_options(int argc, const char *argv[])
 	if (amend && initial_commit)
 		die("You have nothing to amend.");
 	if (amend && in_merge)
-		die("You are in the middle of a merger -- cannot amend.");
+		die("You are in the middle of a merge -- cannot amend.");
 
 	if (use_message)
 		f++;
@@ -641,7 +640,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	commit = lookup_commit(sha1);
 	if (!commit)
-		die("couldn't look up newly created commit\n");
+		die("couldn't look up newly created commit");
 	if (!commit || parse_commit(commit))
 		die("could not parse newly created commit");
 
@@ -777,7 +776,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		launch_editor(git_path(commit_editmsg), &sb, env);
 	} else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		rollback_index_files();
-		die("could not read commit message\n");
+		die("could not read commit message");
 	}
 	if (run_hook(index_file, "commit-msg", git_path(commit_editmsg))) {
 		rollback_index_files();
@@ -792,7 +791,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	stripspace(&sb, 1);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
-		die("* no commit message?  aborting commit.");
+		die("no commit message?  aborting commit.");
 	}
 	strbuf_addch(&sb, '\0');
 	if (is_encoding_utf8(git_commit_encoding) && !is_utf8(sb.buf))
-- 
1.5.3.6.2092.gf4c21-dirty
