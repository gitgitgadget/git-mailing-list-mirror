From: Adam Megacz <adam@megacz.com>
Subject: [PATCH] Display author and committer after "git commit"
Date: Mon, 11 Jan 2010 04:37:44 +0000
Organization: Myself
Message-ID: <xuu2fx6d9rzb.fsf_-_@nowhere.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com> <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com> <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com> <7v4omz17xz.fsf@alter.siamese.dyndns.org> <xuu28wc9xd42.fsf@nowhere.com> <7vskagh9fg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 05:38:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUC2m-0007XX-6P
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 05:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab0AKEiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 23:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409Ab0AKEiP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 23:38:15 -0500
Received: from lo.gmane.org ([80.91.229.12]:37173 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab0AKEiO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 23:38:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NUC2b-0007V9-S8
	for git@vger.kernel.org; Mon, 11 Jan 2010 05:38:09 +0100
Received: from gentzen.megacz.com ([65.23.129.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 05:38:09 +0100
Received: from adam by gentzen.megacz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 05:38:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gentzen.megacz.com
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:UlBkBwdViZZvK5rs1IAS3jhj88o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136602>


Display author (name, email, date) and committer (name, email, date)
after creating a new commit to ensure that the user is alerted in the
event that they are set in an undesirable manner.

This patch seeks to accomplish the following goal: all data included
in the commit which are sha1-protected (and therefore immutable) are
either taken from the working tree or else displayed to the user for
sanity checking purposes.  Since the author/committer information is
immutable and not taken from the working tree, achieving the goal
above requires printing out the author/committer.  The short window of
time after committing a patch and before propagating it is the last
opportunity to modify the data (by deleting and recreating the commit).

This patch is not necessarily meant for inclusion verbatim; it's more
of a starting point for discussion.
---
 commit.h   |    2 ++
 log-tree.c |   15 +++++++++++++++
 pretty.c   |   23 ++++++++++++++++++-----
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/commit.h b/commit.h
index e5332ef..e4222b0 100644
--- a/commit.h
+++ b/commit.h
@@ -59,6 +59,8 @@ enum cmit_fmt {
 	CMIT_FMT_ONELINE,
 	CMIT_FMT_EMAIL,
 	CMIT_FMT_USERFORMAT,
+        CMIT_FMT_COMMITTER_AND_DATE,
+        CMIT_FMT_AUTHOR_AND_DATE,
 
 	CMIT_FMT_UNSPECIFIED,
 };
diff --git a/log-tree.c b/log-tree.c
index 0fdf159..7b399b8 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -160,6 +160,20 @@ static void append_signoff(struct strbuf *sb, const char *signoff)
 	strbuf_addch(sb, '\n');
 }
 
+static void append_metadata(struct strbuf *sb,
+                            struct commit *commit,
+                            const struct pretty_print_context *ctx)
+{
+
+	strbuf_addch(sb, '\n');
+	strbuf_addstr(sb, " Author:     ");
+        pretty_print_commit(CMIT_FMT_AUTHOR_AND_DATE, commit, sb, ctx);
+
+	strbuf_addch(sb, '\n');
+	strbuf_addstr(sb, " Committer:  ");
+        pretty_print_commit(CMIT_FMT_COMMITTER_AND_DATE, commit, sb, ctx);
+}
+
 static unsigned int digits_in_number(unsigned int number)
 {
 	unsigned int i = 10, result = 1;
@@ -414,6 +428,7 @@ void show_log(struct rev_info *opt)
 	ctx.reflog_info = opt->reflog_info;
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
 
+        append_metadata(&msgbuf, commit, &ctx);
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
 	if (opt->show_log_size) {
diff --git a/pretty.c b/pretty.c
index 8f5bd1a..2458509 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1028,16 +1028,26 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	int need_8bit_cte = context->need_8bit_cte;
 
 	if (fmt == CMIT_FMT_USERFORMAT) {
-		format_commit_message(commit, user_format, sb, context);
+                format_commit_message(commit, user_format, sb, context);
 		return;
 	}
+        if (fmt == CMIT_FMT_COMMITTER_AND_DATE) {
+                format_commit_message(commit, "%cn <%ce> %cd", sb, context);
+                return;
+        }
+        if (fmt == CMIT_FMT_AUTHOR_AND_DATE) {
+                format_commit_message(commit, "%an <%ae> %ad", sb, context);
+                return;
+        }
 
 	reencoded = reencode_commit_message(commit, &encoding);
 	if (reencoded) {
 		msg = reencoded;
 	}
 
-	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
+
+	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL ||
+            fmt == CMIT_FMT_COMMITTER_AND_DATE || CMIT_FMT_AUTHOR_AND_DATE)
 		indent = 0;
 
 	/*
@@ -1078,12 +1088,14 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 			      context->after_subject, encoding, need_8bit_cte);
 
 	beginning_of_body = sb->len;
-	if (fmt != CMIT_FMT_ONELINE)
+	if (fmt != CMIT_FMT_ONELINE &&
+            fmt != CMIT_FMT_COMMITTER_AND_DATE && fmt != CMIT_FMT_AUTHOR_AND_DATE)
 		pp_remainder(fmt, &msg, sb, indent);
 	strbuf_rtrim(sb);
 
 	/* Make sure there is an EOLN for the non-oneline case */
-	if (fmt != CMIT_FMT_ONELINE)
+	if (fmt != CMIT_FMT_ONELINE &&
+            fmt != CMIT_FMT_COMMITTER_AND_DATE && fmt != CMIT_FMT_AUTHOR_AND_DATE)
 		strbuf_addch(sb, '\n');
 
 	/*
@@ -1094,7 +1106,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (fmt != CMIT_FMT_ONELINE)
+	if (fmt != CMIT_FMT_ONELINE &&
+            fmt != CMIT_FMT_COMMITTER_AND_DATE && fmt != CMIT_FMT_AUTHOR_AND_DATE)
 		get_commit_notes(commit, sb, encoding,
 				 NOTES_SHOW_HEADER | NOTES_INDENT);
 
-- 
1.6.4.4
