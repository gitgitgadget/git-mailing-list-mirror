From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] clone: add tests for output directory
Date: Wed, 5 Aug 2015 04:36:46 -0400
Message-ID: <20150805083645.GA28212@sigill.intra.peff.net>
References: <20150805083526.GA22325@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 10:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMuC1-0007KU-BH
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 10:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbbHEIgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 04:36:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:40994 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751073AbbHEIgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 04:36:50 -0400
Received: (qmail 21113 invoked by uid 102); 5 Aug 2015 08:36:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 03:36:50 -0500
Received: (qmail 27246 invoked by uid 107); 5 Aug 2015 08:36:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 04:36:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2015 04:36:46 -0400
Content-Disposition: inline
In-Reply-To: <20150805083526.GA22325@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275354>

When we run "git clone $url", clone guesses from the $url
what to name the local output directory. We don't have any
test coverage of this, so let's add some basic tests.

This reveals a few problems:

  - cloning "foo.git/" does not properly remove the ".git";
    this is a recent regression from 7e837c6 (clone:
    simplify string handling in guess_dir_name(), 2015-07-09)

  - likewise, cloning foo/.git does not seem to handle the
    bare case (we should end up in foo.git, but we try to
    use foo/.git on the local end), which also comes from
    7e837c6.

  - cloning the root is not very smart about URL parsing,
    and usernames and port numbers may end up in the
    directory name

All of these tests are marked as failures.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5603-clone-dirname.sh | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 t/t5603-clone-dirname.sh

diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
new file mode 100755
index 0000000..a0140b9
--- /dev/null
+++ b/t/t5603-clone-dirname.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='check output directory names used by git-clone'
+. ./test-lib.sh
+
+# we use a fake ssh wrapper that ignores the arguments
+# entirely; we really only care that we get _some_ repo,
+# as the real test is what clone does on the local side
+test_expect_success 'setup ssh wrapper' '
+	write_script "$TRASH_DIRECTORY/ssh-wrapper" <<-\EOF &&
+	git upload-pack "$TRASH_DIRECTORY"
+	EOF
+	GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper" &&
+	export GIT_SSH &&
+	export TRASH_DIRECTORY
+'
+
+# make sure that cloning $1 results in local directory $2
+test_clone_dir () {
+	url=$1; shift
+	dir=$1; shift
+	expect=success
+	bare=non-bare
+	clone_opts=
+	for i in "$@"; do
+		case "$i" in
+		fail)
+			expect=failure
+			;;
+		bare)
+			bare=bare
+			clone_opts=--bare
+			;;
+		esac
+	done
+	test_expect_$expect "clone of $url goes to $dir ($bare)" "
+		rm -rf $dir &&
+		git clone $clone_opts $url &&
+		test_path_is_dir $dir
+	"
+}
+
+# basic syntax with bare and non-bare variants
+test_clone_dir host:foo foo
+test_clone_dir host:foo foo.git bare
+test_clone_dir host:foo.git foo
+test_clone_dir host:foo.git foo.git bare
+test_clone_dir host:foo/.git foo
+test_clone_dir host:foo/.git foo.git bare fail
+
+# similar, but using ssh URL rather than host:path syntax
+test_clone_dir ssh://host/foo foo
+test_clone_dir ssh://host/foo foo.git bare
+test_clone_dir ssh://host/foo.git foo
+test_clone_dir ssh://host/foo.git foo.git bare
+test_clone_dir ssh://host/foo/.git foo
+test_clone_dir ssh://host/foo/.git foo.git bare fail
+
+# we should remove trailing slashes
+test_clone_dir ssh://host/foo/ foo
+test_clone_dir ssh://host/foo.git/ foo fail
+test_clone_dir ssh://host/foo/.git/ foo
+
+# omitting the path should default to the hostname
+test_clone_dir ssh://host/ host
+test_clone_dir ssh://host:1234/ host fail
+test_clone_dir ssh://user@host/ host fail
+
+test_done
-- 
2.5.0.148.g63828c1
