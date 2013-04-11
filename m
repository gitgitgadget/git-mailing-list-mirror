From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 4/5] check-ignore: allow incremental streaming of queries via --stdin
Date: Thu, 11 Apr 2013 13:05:12 +0100
Message-ID: <1365681913-7059-4-git-send-email-git@adamspiers.org>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 14:05:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGFz-0002ks-CE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935227Ab3DKMFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:05:21 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:59034 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935032Ab3DKMFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:05:18 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 584C1593B5
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 13:05:17 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.342.gfa7285d
In-Reply-To: <1365681913-7059-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220851>

Some callers, such as the git-annex web assistant, find it useful to
invoke git check-ignore as a persistent background process, which can
then have queries fed to its STDIN at any point, and the corresponding
response consumed from its STDOUT.  For this we need to invoke
check_ignore() once per line of standard input, and flush standard
output after each result.

The above use case suggests that empty STDIN is actually a reasonable
scenario (e.g. when the caller doesn't know in advance whether any
queries need to be fed to the background process until after it's
already started), so we make the minor behavioural change that "no
pathspec given." is no longer emitted in when STDIN is empty.

Even though check_ignore() could now be changed to operate on a single
pathspec, we keep it operating on an array of pathspecs since that is
a more convenient way of consuming the existing pathspec API.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/check-ignore.c | 15 +++++----------
 t/t0008-ignores.sh     | 28 +++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index e2d3006..c00a7d6 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -107,10 +107,9 @@ static int check_ignore(struct path_exclude_check *check,
 static int check_ignore_stdin_paths(struct path_exclude_check *check, const char *prefix)
 {
 	struct strbuf buf, nbuf;
-	char **pathspec = NULL;
-	size_t nr = 0, alloc = 0;
+	char *pathspec[2] = { NULL, NULL };
 	int line_termination = null_term_line ? 0 : '\n';
-	int num_ignored;
+	int num_ignored = 0;
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
@@ -121,14 +120,10 @@ static int check_ignore_stdin_paths(struct path_exclude_check *check, const char
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		ALLOC_GROW(pathspec, nr + 1, alloc);
-		pathspec[nr] = xcalloc(strlen(buf.buf) + 1, sizeof(*buf.buf));
-		strcpy(pathspec[nr++], buf.buf);
+		pathspec[0] = buf.buf;
+		num_ignored += check_ignore(check, prefix, (const char **)pathspec);
+		maybe_flush_or_die(stdout, "check-ignore to stdout");
 	}
-	ALLOC_GROW(pathspec, nr + 1, alloc);
-	pathspec[nr] = NULL;
-	num_ignored = check_ignore(check, prefix, (const char **)pathspec);
-	maybe_flush_or_die(stdout, "attribute to stdout");
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
 	return num_ignored;
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 7af93ba..fbf12ae 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -216,11 +216,7 @@ test_expect_success_multi 'empty command line' '' '
 
 test_expect_success_multi '--stdin with empty STDIN' '' '
 	test_check_ignore "--stdin" 1 </dev/null &&
-	if test -n "$quiet_opt"; then
-		test_stderr ""
-	else
-		test_stderr "no pathspec given."
-	fi
+	test_stderr ""
 '
 
 test_expect_success '-q with multiple args' '
@@ -692,5 +688,27 @@ do
 	'
 done
 
+test_expect_success 'setup: have stdbuf?' '
+	if which stdbuf >/dev/null 2>&1
+	then
+		test_set_prereq STDBUF
+	fi
+'
+
+test_expect_success STDBUF 'streaming support for --stdin' '
+	(
+		echo one
+		sleep 2
+		echo two
+	) | stdbuf -oL git check-ignore -v -n --stdin >out &
+	pid=$! &&
+	sleep 1 &&
+	grep "^\.gitignore:1:one	one" out &&
+	test $( wc -l <out ) = 1 &&
+	sleep 2 &&
+	grep "^::	two" out &&
+	test $( wc -l <out ) = 2 &&
+	( wait $pid || kill $pid || : ) 2>/dev/null
+'
 
 test_done
-- 
1.8.2.1.342.gfa7285d
