From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 1/5] clone: add tests for output directory
Date: Mon, 10 Aug 2015 17:48:21 +0200
Message-ID: <1439221705-20336-2-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1439221705-20336-1-git-send-email-ps@pks.im>
Cc: sunshine@sunshineco.com, ps@pks.im, peff@peff.net,
	pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOpJm-0002XR-9N
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 17:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbbHJPsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 11:48:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50128 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754489AbbHJPsc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 11:48:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 3373C20ED1
	for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:48:32 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 10 Aug 2015 11:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=oA8n
	yNa3THyOGCOL7KgqAsCW6V8=; b=HppJwxSHuxkjUx869XBD9QQ11JN291bJhZ+f
	R/ed3xl+48am42TV1qI85onaH+SS4NYVI0C9PEGxkywYFiwQnrOSbrrTKpYh/f4Z
	8HxrmI3GlHkUiheyaRPK1aGWi05fDzqIze0kH61zGWEwKWn1MFC3WrBZOoQ4igo4
	7kEm/Sc=
X-Sasl-enc: 2V3dSh+7fR/NA59zrDil53JPqwLgUfbVP7hK8wl7L7gj 1439221711
Received: from localhost (x5ce1243b.dyn.telefonica.de [92.225.36.59])
	by mail.messagingengine.com (Postfix) with ESMTPA id AF21EC00023;
	Mon, 10 Aug 2015 11:48:31 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439221705-20336-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275630>

From: Jeff King <peff@peff.net>

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
 t/t5603-clone-dirname.sh | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 t/t5603-clone-dirname.sh

diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
new file mode 100755
index 0000000..b009a87
--- /dev/null
+++ b/t/t5603-clone-dirname.sh
@@ -0,0 +1,103 @@
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
+# we should remove trailing slashes and .git suffixes
+test_clone_dir ssh://host/foo/ foo
+test_clone_dir ssh://host/foo/// foo
+test_clone_dir ssh://host/foo.git/ foo fail
+test_clone_dir ssh://host/foo.git/// foo fail
+test_clone_dir ssh://host/foo///.git/ foo
+test_clone_dir ssh://host/foo/.git/// foo
+
+test_clone_dir host:foo/ foo
+test_clone_dir host:foo/// foo
+test_clone_dir host:foo.git/ foo fail
+test_clone_dir host:foo.git/// foo fail
+test_clone_dir host:foo///.git/ foo
+test_clone_dir host:foo/.git/// foo
+
+# omitting the path should default to the hostname
+test_clone_dir ssh://host/ host
+test_clone_dir ssh://host:1234/ host fail
+test_clone_dir ssh://user@host/ host fail
+test_clone_dir host:/ host fail
+
+# auth materials should be redacted
+test_clone_dir ssh://user:password@host/ host fail
+test_clone_dir ssh://user:password@host:1234/ host fail
+test_clone_dir ssh://user:passw@rd@host:1234/ host fail
+test_clone_dir user@host:/ host fail
+test_clone_dir user:password@host:/ host fail
+test_clone_dir user:pass@wrd@host:/ host fail
+
+# auth-like material should not be dropped
+test_clone_dir ssh://host/foo@bar foo@bar
+test_clone_dir ssh://host/foo@bar.git foo@bar
+test_clone_dir ssh://user:password@host/foo@bar foo@bar
+test_clone_dir ssh://user:passw@rd@host/foo@bar.git foo@bar
+
+test_clone_dir host:/foo@bar foo@bar
+test_clone_dir host:/foo@bar.git foo@bar
+test_clone_dir user:password@host:/foo@bar foo@bar
+test_clone_dir user:passw@rd@host:/foo@bar.git foo@bar
+
+# trailing port-like numbers should not be stripped for paths
+test_clone_dir ssh://user:password@host/test:1234 1234
+test_clone_dir ssh://user:password@host/test:1234.git 1234
+
+test_done
-- 
2.5.0
