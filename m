From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] commit: show interesting ident information in
 summary
Date: Wed, 13 Jan 2010 12:39:51 -0500
Message-ID: <20100113173951.GC16786@coredump.intra.peff.net>
References: <20100113173408.GA16652@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:40:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV7CT-0005zu-TF
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186Ab0AMRkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756216Ab0AMRkD
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:40:03 -0500
Received: from peff.net ([208.65.91.99]:56283 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756041Ab0AMRkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:40:00 -0500
Received: (qmail 25381 invoked by uid 107); 13 Jan 2010 17:44:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 12:44:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 12:39:51 -0500
Content-Disposition: inline
In-Reply-To: <20100113173408.GA16652@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136851>

There are a few cases of user identity information that we
consider interesting:

  1. When the author and committer identities do not match.

  2. When the committer identity was picked automatically
     from the username, hostname and GECOS information.

In these cases, we already show the information in the
commit message template. However, users do not always see
that template because they might use "-m" or "-F". With this
patch, we show these interesting cases after the commit,
along with the subject and change summary. The new output
looks like:

  $ git commit \
      -m "federalist papers" \
      --author='Publius <alexander@hamilton.com>'
  [master 3d226a7] federalist papers
   Author: Publius <alexander@hamilton.com>
   1 files changed, 1 insertions(+), 0 deletions(-)

for case (1), and:

  $ git config --global --unset user.name
  $ git config --global --unset user.email
  $ git commit -m foo
  [master 7c2a927] foo
   Committer: Jeff King <peff@c-71-185-130-222.hsd1.va.comcast.net>
  Your name and email address were configured automatically based
  on your username and hostname. Please check that they are accurate.
  You can suppress this message by setting them explicitly:

      git config --global user.name Your Name
      git config --global user.email you@example.com

  If the identity used for this commit is wrong, you can fix it with:

      git commit --amend --author='Your Name <you@example.com>'

   1 files changed, 1 insertions(+), 0 deletions(-)

for case (2).

Signed-off-by: Jeff King <peff@coredump.intra.peff.net>
---
Changes since v1:
 - rebase on v2 2/3 for function name change
 - gigantic warning message

I have mixed feelings on the warning message, as I mentioned elsewhere
in the thread.

Also, if you run the "commit --amend" advice immediately (without fixing
your config), you will still have a bogus committer field. Alternate
advice could be:

  If the identity used for this commit is wrong, you can fix it (after
  having set your identity as above) with:

    git commit --amend --reset-author

I dunno which is better. I went with what I did because it is something
the user can immediately do to fix this commit before they forget (of
course, they probably would just run the "git config" commands,
immediately, too...).

 builtin-commit.c  |   39 ++++++++++++++++++++++++++++++++++++---
 t/t7501-commit.sh |    6 +++++-
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 073fe90..3fa9b39 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -36,6 +36,18 @@ static const char * const builtin_status_usage[] = {
 	NULL
 };
 
+static const char implicit_ident_advice[] =
+"Your name and email address were configured automatically based\n"
+"on your username and hostname. Please check that they are accurate.\n"
+"You can suppress this message by setting them explicitly:\n"
+"\n"
+"    git config --global user.name Your Name\n"
+"    git config --global user.email you@example.com\n"
+"\n"
+"If the identity used for this commit is wrong, you can fix it with:\n"
+"\n"
+"    git commit --amend --author='Your Name <you@example.com>'\n";
+
 static unsigned char head_sha1[20];
 static char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
@@ -1046,9 +1058,12 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	static const char *format = "format:%h] %s";
+	struct strbuf format = STRBUF_INIT;
 	unsigned char junk_sha1[20];
 	const char *head = resolve_ref("HEAD", junk_sha1, 0, NULL);
+	struct pretty_print_context pctx = {0};
+	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf committer_ident = STRBUF_INIT;
 
 	commit = lookup_commit(sha1);
 	if (!commit)
@@ -1056,6 +1071,23 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	if (!commit || parse_commit(commit))
 		die("could not parse newly created commit");
 
+	strbuf_addstr(&format, "format:%h] %s");
+
+	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
+	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
+	if (strbuf_cmp(&author_ident, &committer_ident)) {
+		strbuf_addstr(&format, "\n Author: ");
+		strbuf_addbuf_percentquote(&format, &author_ident);
+	}
+	if (!user_ident_explicitly_given) {
+		strbuf_addstr(&format, "\n Committer: ");
+		strbuf_addbuf_percentquote(&format, &committer_ident);
+		strbuf_addch(&format, '\n');
+		strbuf_addstr(&format, implicit_ident_advice);
+	}
+	strbuf_release(&author_ident);
+	strbuf_release(&committer_ident);
+
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
@@ -1066,7 +1098,8 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
-	get_commit_format(format, &rev);
+	get_commit_format(format.buf, &rev);
+	strbuf_release(&format);
 	rev.always_show_header = 0;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
@@ -1085,7 +1118,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		struct pretty_print_context ctx = {0};
 		struct strbuf buf = STRBUF_INIT;
 		ctx.date_mode = DATE_NORMAL;
-		format_commit_message(commit, format + 7, &buf, &ctx);
+		format_commit_message(commit, format.buf + 7, &buf, &ctx);
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index a529701..7940901 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -117,7 +117,11 @@ test_expect_success \
 test_expect_success \
 	"overriding author from command line" \
 	"echo 'gak' >file && \
-	 git commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a"
+	 git commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a >output 2>&1"
+
+test_expect_success \
+	"commit --author output mentions author" \
+	"grep Rubber.Duck output"
 
 test_expect_success PERL \
 	"interactive add" \
-- 
1.6.6.140.g92e4d.dirty
