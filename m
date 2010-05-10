From: Jeff King <peff@peff.net>
Subject: [PATCH] handle "git --bare init <dir>" properly
Date: Mon, 10 May 2010 05:42:06 -0400
Message-ID: <20100510094206.GA30869@coredump.intra.peff.net>
References: <201005081238.14156.oliverhoffmann32@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Oliver Hoffmann <oliverhoffmann32@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 10 11:42:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPVh-00078N-2L
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797Ab0EJJmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 05:42:11 -0400
Received: from peff.net ([208.65.91.99]:36352 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127Ab0EJJmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:42:08 -0400
Received: (qmail 2924 invoked by uid 107); 10 May 2010 09:42:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 May 2010 05:42:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 May 2010 05:42:06 -0400
Content-Disposition: inline
In-Reply-To: <201005081238.14156.oliverhoffmann32@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146779>

If we know we are creating a bare repository, we use setenv
to set the GIT_DIR directory to the current directory
(either where we already were, or one we created and chdir'd
into with "git init --bare <dir>").

However, with "git --bare init <dir>" (note the --bare as a
git wrapper option), the setup code actually sets GIT_DIR
for us, but it uses the wrong, original cwd when a directory
is given. Because our setenv does not use the overwrite
flag, it is ignored.

We need to set the overwrite flag, but only when we are
given a directory on the command line. That still allows:

  GIT_DIR=foo.git git init --bare

to work. The behavior is changed for:

  GIT_DIR=foo.git git init --bare bar.git

which used to create the repository in foo.git, but now will
use bar.git. This is more sane, as command line options
should generally override the environment.

Noticed by Oliver Hoffmann.

Signed-off-by: Jeff King <peff@peff.net>
---
Thanks for the bug report, Oliver.

 builtin/init-db.c |    2 +-
 t/t0001-init.sh   |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index edc40ff..0271285 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -463,7 +463,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		static char git_dir[PATH_MAX+1];
 
 		setenv(GIT_DIR_ENVIRONMENT,
-			getcwd(git_dir, sizeof(git_dir)), 0);
+			getcwd(git_dir, sizeof(git_dir)), argc > 0);
 	}
 
 	if (init_shared_repository != -1)
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6757734..7c0a698 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -310,4 +310,18 @@ test_expect_success POSIXPERM 'init notices EPERM' '
 	)
 '
 
+test_expect_success 'init creates a new bare directory with global --bare' '
+	rm -rf newdir &&
+	git --bare init newdir &&
+	test -d newdir/refs
+'
+
+test_expect_success 'init prefers command line to GIT_DIR' '
+	rm -rf newdir &&
+	mkdir otherdir &&
+	GIT_DIR=otherdir git --bare init newdir &&
+	test -d newdir/refs &&
+	! test -d otherdir/refs
+'
+
 test_done
-- 
1.7.1.248.gf52fc.dirty
