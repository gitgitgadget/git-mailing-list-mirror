From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] commit: only strip diff from message in verbose mode
Date: Wed, 12 Nov 2008 03:25:52 -0500
Message-ID: <20081112082552.GE3751@coredump.intra.peff.net>
References: <20081112081609.GA3720@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:27:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0B49-0000wW-VJ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbYKLIZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbYKLIZz
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:25:55 -0500
Received: from peff.net ([208.65.91.99]:2363 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbYKLIZz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:25:55 -0500
Received: (qmail 17721 invoked by uid 111); 12 Nov 2008 08:25:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:25:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:25:52 -0500
Content-Disposition: inline
In-Reply-To: <20081112081609.GA3720@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100726>

When the "-v" option is given, we put diff of what is to be
committed into the commit template, and then strip it back
out again after the user has edited it.

We guess at the location of the diff by searching for the
"diff --git" header. This means that if the user puts their
own diff in the message (e.g., as a sample output), then we
will accidentally trigger the pattern, removing part of
their output.

We can avoid doing this stripping altogether if the user
didn't use "-v" in the first place, so we know that any
match we find will be a false positive.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously this doesn't solve the problem entirely, but it at least makes
a reasonable rule: if we accidentally eat your sample diff output with
"-v", then try without it. :)

But more importantly, I suspect "-v" is used infrequently, so in
practice this should fix most cases.

 builtin-commit.c          |    8 +++++---
 t/t7507-commit-verbose.sh |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index a721990..591d16b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1015,9 +1015,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Truncate the message just before the diff, if any. */
-	p = strstr(sb.buf, "\ndiff --git ");
-	if (p != NULL)
-		strbuf_setlen(&sb, p - sb.buf + 1);
+	if (verbose) {
+		p = strstr(sb.buf, "\ndiff --git ");
+		if (p != NULL)
+			strbuf_setlen(&sb, p - sb.buf + 1);
+	}
 
 	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index be70166..2a3ea7a 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -42,4 +42,25 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
 	check_message message
 '
 
+cat >diff <<'EOF'
+This is an example commit message that contains a diff.
+
+diff --git c/file i/file
+new file mode 100644
+index 0000000..f95c11d
+--- /dev/null
++++ i/file
+@@ -0,0 +1 @@
++this is some content
+EOF
+
+test_expect_success 'diff in message is retained without -v' '
+	git commit --amend -F diff &&
+	check_message diff
+'
+
+test_expect_failure 'diff in message is retained with -v' '
+	git commit --amend -F diff -v &&
+	check_message diff
+'
 test_done
-- 
1.6.0.4.883.g4593ee.dirty
