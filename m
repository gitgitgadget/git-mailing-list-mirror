From: Jeff King <peff@peff.net>
Subject: [PATCH] symbolic ref: refuse non-ref targets in HEAD
Date: Wed, 28 Jan 2009 23:52:05 -0500
Message-ID: <20090129045205.GA31183@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 05:53:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSOuH-0000hN-G2
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 05:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbZA2EwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 23:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZA2EwK
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 23:52:10 -0500
Received: from peff.net ([208.65.91.99]:58707 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbZA2EwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 23:52:09 -0500
Received: (qmail 28851 invoked by uid 107); 29 Jan 2009 04:52:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 23:52:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 23:52:05 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107631>

When calling "git symbolic-ref" it is easy to forget that
the target must be a fully qualified ref. E.g., you might
accidentally do:

  $ git symbolic-ref HEAD master

Unfortunately, this is very difficult to recover from,
because the bogus contents of HEAD make git believe we are
no longer in a git repository (as is_git_dir explicitly
checks for "^refs/" in the HEAD target). So immediately
trying to fix the situation doesn't work:

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
specific case of anything not starting with refs/ to go into
HEAD. The scope of the safety valve is intentionally very
limited, to make sure that we are not preventing any
behavior that would otherwise be valid (like pointing a
different symref than HEAD outside of refs/).

Signed-off-by: Jeff King <peff@peff.net>
---
This is a follow-up to a patch that I posted during the last release
freeze:

  http://article.gmane.org/gmane.comp.version-control.git/103445

I know that using symbolic-ref manually is rare, but both I and the
original poster have been bitten by this (and figuring out what is going
on and fixing it is quite painful). But most importantly, I don't think
this can possibly hurt anyone trying to use this legitimately, since the
exact thing it is protecting against corrupts your repo. :)

Please beware that running the test script on the current "master" will
actually hose your git repo (test 3 kills the trash directory's
.git/HEAD, which means test 4 thinks your parent .git/ is its current
repo). Maybe it makes sense to do a precautionary reset in between.

 builtin-symbolic-ref.c  |    2 ++
 t/t1401-symbolic-ref.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100755 t/t1401-symbolic-ref.sh

diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index bfc78bb..46ea4b2 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -44,6 +44,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		check_symref(argv[0], quiet);
 		break;
 	case 2:
+		if (!strcmp(argv[0], "HEAD") && prefixcmp(argv[1], "refs/"))
+			die("Refusing to point HEAD outside of refs/");
 		create_symref(argv[0], argv[1], msg);
 		break;
 	default:
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
new file mode 100755
index 0000000..1f22009
--- /dev/null
+++ b/t/t1401-symbolic-ref.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='basic symbolic-ref tests'
+. ./test-lib.sh
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
+test_expect_success 'symbolic-ref refuses non-ref branch for HEAD' '
+	test_must_fail git symbolic-ref HEAD foo
+'
+
+test_expect_success 'symbolic-ref refuses bare sha1' '
+	echo content >file && git add file && git commit -m one
+	test_must_fail git symbolic-ref HEAD `git rev-parse HEAD`
+'
+
+test_done
-- 
1.6.1.1.424.gac728
