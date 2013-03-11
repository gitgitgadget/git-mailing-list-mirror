From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] archive: handle commits with an empty tree
Date: Sun, 10 Mar 2013 21:32:32 -0400
Message-ID: <20130311013231.GB11778@sigill.intra.peff.net>
References: <20130311013123.GA11692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 02:33:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UErbq-0000NY-DH
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 02:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab3CKBcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 21:32:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45566 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753609Ab3CKBcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 21:32:35 -0400
Received: (qmail 9611 invoked by uid 107); 11 Mar 2013 01:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Mar 2013 21:34:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Mar 2013 21:32:32 -0400
Content-Disposition: inline
In-Reply-To: <20130311013123.GA11692@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217847>

git-archive relies on get_pathspec to convert its argv into
a list of pathspecs. When get_pathspec is given an empty
argv list, it returns a single pathspec, the empty string,
to indicate that everything matches. When we feed this to
our path_exists function, we typically see that the pathspec
turns up at least one item in the tree, and we are happy.

But when our tree is empty, we erroneously think it is
because the pathspec is too limited, when in fact it is
simply that there is nothing to be found in the tree. This
is a weird corner case, but the correct behavior is almost
certainly to produce an empty archive, not to exit with an
error.

This patch teaches git-archive to create empty archives when
there is no pathspec given (we continue to complain if a
pathspec is given, since it obviously is not matched). It
also confirms that the tar and zip writers produce sane
output in this instance.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c                       |   2 +-
 t/t5004-archive-corner-cases.sh |  83 ++++++++++++++++++++++++++++++++++++++++
 t/t5004/empty.zip               | Bin 0 -> 62 bytes
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100755 t/t5004-archive-corner-cases.sh
 create mode 100644 t/t5004/empty.zip

diff --git a/archive.c b/archive.c
index 93e00bb..d254fa5 100644
--- a/archive.c
+++ b/archive.c
@@ -234,7 +234,7 @@ static void parse_pathspec_arg(const char **pathspec,
 	ar_args->pathspec = pathspec = get_pathspec("", pathspec);
 	if (pathspec) {
 		while (*pathspec) {
-			if (!path_exists(ar_args->tree, *pathspec))
+			if (**pathspec && !path_exists(ar_args->tree, *pathspec))
 				die("path not found: %s", *pathspec);
 			pathspec++;
 		}
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
new file mode 100755
index 0000000..395dd58
--- /dev/null
+++ b/t/t5004-archive-corner-cases.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='test corner cases of git-archive'
+. ./test-lib.sh
+
+test_expect_success 'create commit with empty tree' '
+	git commit --allow-empty -m foo
+'
+
+# Make a dir and clean it up afterwards
+make_dir() {
+	mkdir "$1" &&
+	test_when_finished "rm -rf '$1'"
+}
+
+# Check that the dir given in "$1" contains exactly the
+# set of paths given as arguments.
+check_dir() {
+	dir=$1; shift
+	{
+		echo "$dir" &&
+		for i in "$@"; do
+			echo "$dir/$i"
+		done
+	} | sort >expect &&
+	find "$dir" -print | sort >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'tar archive of empty tree is empty' '
+	git archive --format=tar HEAD >empty.tar &&
+	make_dir extract &&
+	"$TAR" xf empty.tar -C extract &&
+	check_dir extract
+'
+
+test_expect_success 'tar archive of empty tree with prefix' '
+	git archive --format=tar --prefix=foo/ HEAD >prefix.tar &&
+	make_dir extract &&
+	"$TAR" xf prefix.tar -C extract &&
+	check_dir extract foo
+'
+
+test_expect_success UNZIP 'zip archive of empty tree is empty' '
+	# Detect the exit code produced when our particular flavor of unzip
+	# sees an empty archive. Infozip will generate a warning and exit with
+	# code 1. But in the name of sanity, we do not expect other unzip
+	# implementations to do the same thing (it would be perfectly
+	# reasonable to exit 0, for example).
+	#
+	# This makes our test less rigorous on some platforms (unzip may not
+	# handle the empty repo at all, making our later check of its exit code
+	# a no-op). But we cannot do anything reasonable except skip the test
+	# on such platforms anyway, and this is the moral equivalent.
+	"$GIT_UNZIP" "$TEST_DIRECTORY"/t5004/empty.zip
+	expect_code=$?
+
+	git archive --format=zip HEAD >empty.zip &&
+	make_dir extract &&
+	(
+		cd extract &&
+		test_expect_code $expect_code "$GIT_UNZIP" ../empty.zip
+	) &&
+	check_dir extract
+'
+
+test_expect_success UNZIP 'zip archive of empty tree with prefix' '
+	# We do not have to play exit-code tricks here, because our
+	# result should not be empty; it has a directory in it.
+	git archive --format=zip --prefix=foo/ HEAD >prefix.zip &&
+	make_dir extract &&
+	(
+		cd extract &&
+		"$GIT_UNZIP" ../prefix.zip
+	) &&
+	check_dir extract foo
+'
+
+test_expect_success 'archive complains about pathspec on empty tree' '
+	test_must_fail git archive --format=tar HEAD -- foo >/dev/null
+'
+
+test_done
diff --git a/t/t5004/empty.zip b/t/t5004/empty.zip
new file mode 100644
index 0000000000000000000000000000000000000000..1a76bb600558dc94913a80076fe8dbdef13c1b15
GIT binary patch
literal 62
zcmWIWW@TeQ0~!oz$rh;wDW;amhRMmM$%ZCLW|oGQX-P%~24+b{=4q+M#^$N!DF&$k
D8w?B~

literal 0
HcmV?d00001

-- 
1.8.2.rc3.4.gc6ed371
