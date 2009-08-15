From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Simplify '--prett=xyz' options
Date: Sat, 15 Aug 2009 12:50:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908151236250.3162@localhost.localdomain>
References: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain> <200908152119.56606.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 15 21:51:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McPIA-0004tl-NX
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 21:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZHOTvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 15:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbZHOTvJ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 15:51:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56000 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750743AbZHOTvI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 15:51:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FJooL3006608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Aug 2009 12:50:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FJonGP016187;
	Sat, 15 Aug 2009 12:50:50 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <200908152119.56606.trast@student.ethz.ch>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126021>



On Sat, 15 Aug 2009, Thomas Rast wrote:
> 
> But we already have --format="%aN: %s" since these two commits:

Yeah. Junio pointed that out.

We also have --oneline, which I actually like (but it doesn't work like 
--pretty=oneline - it also enables --abbrev-commit). But then we don't 
have --fuller (which is what I usually want to use when I want to see 
committer info).

And "format" takes ':' when with --pretty=, but '=' when alone. Which is 
what made me not notice that it worked due to silly semantic changes.And 
the confusion with tformat vs format is fundamental.

> Granted, it makes it equivalent to --pretty=tformat:foo, but isn't
> tformat the better choice in many cases?

Not really. Look at what happens with

	git log --stat --pretty=format:%s

and then try tformat instead. 'tformat' is broken, as is our current 
--format=%s.

In other words, all of that crud is totally illogical, and our "short 
versions" (--oneline and --format=) were done entirely incorrectly (well, 
--oneline probably has the _right_ semantics, and --pretty=oneline is just 
wrong, but whatever).

Sadly, we can't fix those things well.

But here's a fixed version of my patch that gets rid of some problems.

And our current --format= thing really _is_ fundamentaly broken, as shown 
by my example above. Making it work like 'tformat' was a bug. With this, 
you can say

	git log --tformat=%s

if you want the stupid tformat semantics.

[ Junio, I fixed that, so this is strictly "version 3" of the patch. Now 
  "--format=x" works like "--pretty=format:x" and if you want tformat 
  semantics, you need to say "--tformat=x")

  That's why the test-cases got modified with this patch - we were 
  actually _testing_ for that idiotic behavior of --pretty=format:x being 
  different from --format=x ]

I would like to also make "--pretty=oneline" have the same abbrev-commit 
semantics as "--oneline" has, but I didn't actually do that change.

		Linus

---
 commit.h       |    1 +
 pretty.c       |   42 +++++++++++++++++++++++++++++-------------
 revision.c     |    9 +++++++--
 t/t4202-log.sh |   14 +++++++-------
 4 files changed, 44 insertions(+), 22 deletions(-)

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
index e5328da..1a76320 100644
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
@@ -36,30 +36,46 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		{ "oneline",	1,	CMIT_FMT_ONELINE },
 	};
 
-	rev->use_terminator = 0;
-	if (!arg || !*arg) {
-		rev->commit_format = CMIT_FMT_DEFAULT;
-		return;
+	if (!prefixcmp(arg, "format")) {
+		if (arg[6] == ':' || arg[6] == '=') {
+			save_user_format(rev, arg+7, 0);
+			return 1;
+		}
 	}
-	if (!prefixcmp(arg, "format:") || !prefixcmp(arg, "tformat:")) {
-		save_user_format(rev, strchr(arg, ':') + 1, arg[0] == 't');
-		return;
+	if (!prefixcmp(arg, "tformat")) {
+		if (arg[7] == ':' || arg[7] == '=') {
+			save_user_format(rev, arg+8, 1);
+			return 1;
+		}
 	}
+
 	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
 		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len) &&
 		    !strncmp(arg, cmt_fmts[i].n, strlen(arg))) {
 			if (cmt_fmts[i].v == CMIT_FMT_ONELINE)
 				rev->use_terminator = 1;
 			rev->commit_format = cmt_fmts[i].v;
-			return;
+			return 1;
 		}
 	}
-	if (strchr(arg, '%')) {
-		save_user_format(rev, arg, 1);
+
+	return 0;
+}
+
+void get_commit_format(const char *arg, struct rev_info *rev)
+{
+	rev->use_terminator = 0;
+	if (!arg || !*arg) {
+		rev->commit_format = CMIT_FMT_DEFAULT;
 		return;
 	}
-
-	die("invalid --pretty format: %s", arg);
+	if (!try_get_commit_format(arg, rev)) {
+		if (strchr(arg, '%')) {
+			save_user_format(rev, arg, 0);
+			return;
+		}
+		die("invalid --pretty format: %s", arg);
+	}
 }
 
 /*
diff --git a/revision.c b/revision.c
index 9f5dac5..bdace8b 100644
--- a/revision.c
+++ b/revision.c
@@ -1123,7 +1123,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--pretty")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+8, revs);
-	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
+	} else if (!prefixcmp(arg, "--pretty=")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+9, revs);
 	} else if (!strcmp(arg, "--oneline")) {
@@ -1194,8 +1194,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc);
-		if (!opts)
+		if (!opts) {
+			if (!strncmp(arg, "--", 2) && try_get_commit_format(arg+2, revs)) {
+				revs->verbose_header = 1;
+				return 1;
+			}
 			unkv[(*unkc)++] = arg;
+		}
 		return opts;
 	}
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 48e0088..2f1a5a5 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -44,13 +44,6 @@ test_expect_success 'pretty' '
 	test_cmp expect actual
 '
 
-printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial\n" > expect
-test_expect_success 'pretty (tformat)' '
-
-	git log --pretty="tformat:%s" > actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'pretty (shortcut)' '
 
 	git log --pretty="%s" > actual &&
@@ -63,6 +56,13 @@ test_expect_success 'format' '
 	test_cmp expect actual
 '
 
+printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial\n" > expect
+test_expect_success 'pretty (tformat)' '
+
+	git log --pretty="tformat:%s" > actual &&
+	test_cmp expect actual
+'
+
 cat > expect << EOF
 804a787 sixth
 394ef78 fifth
