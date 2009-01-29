From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] symbolic ref: refuse non-ref targets in HEAD
Date: Thu, 29 Jan 2009 03:33:02 -0500
Message-ID: <20090129083302.GB6273@coredump.intra.peff.net>
References: <20090129080145.GA777@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 09:34:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSSMN-00030J-H5
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 09:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbZA2IdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 03:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbZA2IdH
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 03:33:07 -0500
Received: from peff.net ([208.65.91.99]:39373 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023AbZA2IdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 03:33:06 -0500
Received: (qmail 29934 invoked by uid 107); 29 Jan 2009 08:33:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 03:33:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 03:33:02 -0500
Content-Disposition: inline
In-Reply-To: <20090129080145.GA777@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107647>

When calling "git symbolic-ref" it is easy to forget that
the target must be a fully qualified ref. E.g., you might
accidentally do:

  $ git symbolic-ref HEAD master

Unfortunately, this is very difficult to recover from,
because the bogus contents of HEAD make git believe we are
no longer in a git repository (as is_git_dir explicitly
checks for "^refs/heads/" in the HEAD target). So
immediately trying to fix the situation doesn't work:

  $ git symbolic-ref HEAD refs/heads/master
  fatal: Not a git repository

and one is left editing the .git/HEAD file manually.

Furthermore, one might be tempted to use symbolic-ref to set
up a detached HEAD:

  $ git symbolic-ref HEAD `git rev-parse HEAD`

which sets up an even more bogus HEAD:

  $ cat .git/HEAD
  ref: 1a9ace4f2ad4176148e61b5a85cd63d5604aac6d

This patch introduces a small safety valve to prevent the
specific case of anything not starting with refs/heads/ to
go into HEAD. The scope of the safety valve is intentionally
very limited, to make sure that we are not preventing any
behavior that would otherwise be valid (like pointing a
different symref than HEAD outside of refs/heads/).

Signed-off-by: Jeff King <peff@peff.net>
---
Changes from the original are:

  - s,refs/,refs/heads/, in the code and commit message

  - test non-ref and non-branch separately; under the current
    implementation it is obvious the former will work if the latter
    does, but I think by testing intent and not the implementation, the
    tests are more future-proof

  - tests make sure to restore validity of trash directory immediately
    after running

 builtin-symbolic-ref.c  |    3 +++
 t/t1401-symbolic-ref.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100755 t/t1401-symbolic-ref.sh

diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index bfc78bb..cafc4eb 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -44,6 +44,9 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		check_symref(argv[0], quiet);
 		break;
 	case 2:
+		if (!strcmp(argv[0], "HEAD") &&
+		    prefixcmp(argv[1], "refs/heads/"))
+			die("Refusing to point HEAD outside of refs/heads/");
 		create_symref(argv[0], argv[1], msg);
 		break;
 	default:
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
new file mode 100755
index 0000000..569f341
--- /dev/null
+++ b/t/t1401-symbolic-ref.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='basic symbolic-ref tests'
+. ./test-lib.sh
+
+# If the tests munging HEAD fail, they can break detection of
+# the git repo, meaning that further tests will operate on
+# the surrounding git repo instead of the trash directory.
+reset_to_sane() {
+	echo ref: refs/heads/foo >.git/HEAD
+}
+
+test_expect_success 'symbolic-ref writes HEAD' '
+	git symbolic-ref HEAD refs/heads/foo &&
+	echo ref: refs/heads/foo >expect &&
+	test_cmp expect .git/HEAD
+'
+
+test_expect_success 'symbolic-ref reads HEAD' '
+	echo refs/heads/foo >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
+	test_must_fail git symbolic-ref HEAD foo
+'
+reset_to_sane
+
+test_expect_success 'symbolic-ref refuses non-branch for HEAD' '
+	test_must_fail git symbolic-ref HEAD refs/foo
+'
+reset_to_sane
+
+test_expect_success 'symbolic-ref refuses bare sha1' '
+	echo content >file && git add file && git commit -m one
+	test_must_fail git symbolic-ref HEAD `git rev-parse HEAD`
+'
+reset_to_sane
+
+test_done
-- 
1.6.1.1.425.gdbb13
