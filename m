From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] commit: show interesting ident information in summary
Date: Tue, 12 Jan 2010 10:46:32 -0500
Message-ID: <20100112154631.GC24957@coredump.intra.peff.net>
References: <20100112153656.GA24840@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUixC-00088H-DV
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 16:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0ALPqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 10:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753156Ab0ALPqm
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 10:46:42 -0500
Received: from peff.net ([208.65.91.99]:59970 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745Ab0ALPql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 10:46:41 -0500
Received: (qmail 8070 invoked by uid 107); 12 Jan 2010 15:51:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 10:51:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 10:46:32 -0500
Content-Disposition: inline
In-Reply-To: <20100112153656.GA24840@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136731>

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
   1 files changed, 1 insertions(+), 0 deletions(-)

for case (2).

Signed-off-by: Jeff King <peff@peff.net>
---
Note that this has a slight semantic conflict with the jc/ident topic in
next. The user_ident_explicitly_given flag needs to be compared to
IDENT_ALL.

I hope the example output in the commit message is not too verbose. I
was recently reviewing somebody's series that made output changes, and
they didn't include sample output anywhere, which made reviewing a lot
more annoying.

Personally I don't care much about case (2) one way or the other, but it
is the one that triggered this thread. I think case (1) is very useful,
though.

I tested case (2) manually, but I didn't include anything in the test
suite; I feel funny testing output created from the hostname and GECOS
(can't it even barf if the user's system isn't set up very well? That
would produce a false negative for the test).

 builtin-commit.c  |   25 ++++++++++++++++++++++---
 t/t7501-commit.sh |    6 +++++-
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 073fe90..279145d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1046,9 +1046,12 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
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
@@ -1056,6 +1059,21 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	if (!commit || parse_commit(commit))
 		die("could not parse newly created commit");
 
+	strbuf_addstr(&format, "format:%h] %s");
+
+	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
+	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
+	if (strbuf_cmp(&author_ident, &committer_ident)) {
+		strbuf_addstr(&format, "\n Author: ");
+		strbuf_percentquote_buf(&format, &author_ident);
+	}
+	if (!user_ident_explicitly_given) {
+		strbuf_addstr(&format, "\n Committer: ");
+		strbuf_percentquote_buf(&format, &committer_ident);
+	}
+	strbuf_release(&author_ident);
+	strbuf_release(&committer_ident);
+
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 
@@ -1066,7 +1084,8 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 
 	rev.verbose_header = 1;
 	rev.show_root_diff = 1;
-	get_commit_format(format, &rev);
+	get_commit_format(format.buf, &rev);
+	strbuf_release(&format);
 	rev.always_show_header = 0;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
@@ -1085,7 +1104,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
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
1.6.6.138.g309fc.dirty
