From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Simplify '--prett=xyz' options
Date: Sat, 15 Aug 2009 12:01:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 15 21:02:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McOWC-000627-7q
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 21:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbZHOTBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 15:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbZHOTBq
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 15:01:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32789 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751684AbZHOTBp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 15:01:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FJ1EqE003446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Aug 2009 12:01:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FJ1Dv6028041;
	Sat, 15 Aug 2009 12:01:14 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126019>


I keep on thinking that I can write

	git log --format:'%aN: %s'

instead of using the long-form "--pretty=format:xyz' thing. And each time, 
I curse myself for being stupid for forgetting the proper format.

And I'm tired of being stupid. So this patch makes me smart and 
forward-thinking instead.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Now I just need a patch to make me athletic and handsome.

 commit.h   |    1 +
 pretty.c   |   26 ++++++++++++++++----------
 revision.c |    2 ++
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/commit.h b/commit.h
index ba9f638..cc4229b 100644
--- a/commit.h
+++ b/commit.h
@@ -68,6 +68,7 @@ struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
+extern int try_get_commit_format(const char *arg, struct rev_info *);
 extern void format_commit_message(const struct commit *commit,
 				  const void *format, struct strbuf *sb,
 				  enum date_mode dmode);
diff --git a/pretty.c b/pretty.c
index e5328da..97d36c5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -19,7 +19,7 @@ static void save_user_format(struct rev_info *rev, const char *cp, int is_tforma
 	rev->commit_format = CMIT_FMT_USERFORMAT;
 }
 
-void get_commit_format(const char *arg, struct rev_info *rev)
+int try_get_commit_format(const char *arg, struct rev_info *rev)
 {
 	int i;
 	static struct cmt_fmt_map {
@@ -36,14 +36,9 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		{ "oneline",	1,	CMIT_FMT_ONELINE },
 	};
 
-	rev->use_terminator = 0;
-	if (!arg || !*arg) {
-		rev->commit_format = CMIT_FMT_DEFAULT;
-		return;
-	}
 	if (!prefixcmp(arg, "format:") || !prefixcmp(arg, "tformat:")) {
 		save_user_format(rev, strchr(arg, ':') + 1, arg[0] == 't');
-		return;
+		return 1;
 	}
 	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
 		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len) &&
@@ -51,15 +46,26 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 			if (cmt_fmts[i].v == CMIT_FMT_ONELINE)
 				rev->use_terminator = 1;
 			rev->commit_format = cmt_fmts[i].v;
-			return;
+			return 1;
 		}
 	}
 	if (strchr(arg, '%')) {
 		save_user_format(rev, arg, 1);
-		return;
+		return 1;
 	}
 
-	die("invalid --pretty format: %s", arg);
+	return 0;
+}
+
+void get_commit_format(const char *arg, struct rev_info *rev)
+{
+	rev->use_terminator = 0;
+	if (!arg || !*arg) {
+		rev->commit_format = CMIT_FMT_DEFAULT;
+		return;
+	}
+	if (!try_get_commit_format(arg, rev))
+		die("invalid --pretty format: %s", arg);
 }
 
 /*
diff --git a/revision.c b/revision.c
index 9f5dac5..181593f 100644
--- a/revision.c
+++ b/revision.c
@@ -1192,6 +1192,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--children")) {
 		revs->children.name = "children";
 		revs->limited = 1;
+	} else if (!strncmp(arg, "--", 2) && try_get_commit_format(arg+2, revs)) {
+		revs->verbose_header = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc);
 		if (!opts)
