From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] ls-files: fix broken --no-empty-directory
Date: Sat, 7 Mar 2009 20:27:22 -0500
Message-ID: <20090308012722.GB18714@coredump.intra.peff.net>
References: <20090308012049.GA18616@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 02:29:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg7p9-0002XG-BR
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 02:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZCHB1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 20:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbZCHB1f
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 20:27:35 -0500
Received: from peff.net ([208.65.91.99]:34412 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbZCHB1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 20:27:35 -0500
Received: (qmail 18532 invoked by uid 107); 8 Mar 2009 01:27:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 20:27:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 20:27:22 -0500
Content-Disposition: inline
In-Reply-To: <20090308012049.GA18616@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112607>

Commit ce8e880 converted ls-files to use parseopt; the
--no-empty-directory option was converted as an
OPT_BIT for "empty-directory" to set the
DIR_HIDE_EMPTY_DIRECTORY flag. However, that makes it do the
opposite of what it should: --empty-directory would hide,
but --no-empty-directory would turn off hiding.

Signed-off-by: Jeff King <peff@peff.net>
---
Two comments on this patch:

  1. The original conversion gave us --empty-directory and
     --no-empty-directory. This one gives us --no-empty-directory and
     --no-no-empty-directory. If we really want to expose a negatable
     flag, then either:

       - the bit needs to change to DIR_SHOW_EMPTY_DIRECTORY; however,
         that changes the behavior for callers who zero the flag field

       - we need a custom option which implements the negation with
         respect to the bit, instead of a vanilla OPT_BIT

  2. I tried to follow the existing style of the t3000 test script
     rather than overhauling it. However, I think the result is a little
     hard to read. We set up expectations for many cases at the
     beginning, and then do all the tests. I think it might read better
     as "set up a case, create expectat, run test".

 builtin-ls-files.c         |    4 ++--
 t/t3000-ls-files-others.sh |   14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 1742c0f..437c366 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -454,8 +454,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "directory", &dir.flags,
 			"show 'other' directories' name only",
 			DIR_SHOW_OTHER_DIRECTORIES),
-		OPT_BIT(0, "empty-directory", &dir.flags,
-			"list empty directories",
+		OPT_BIT(0, "no-empty-directory", &dir.flags,
+			"don't show empty directories",
 			DIR_HIDE_EMPTY_DIRECTORIES),
 		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
 			"show unmerged files in the output"),
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 36eee0f..379d963 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -13,12 +13,13 @@ filesystem.
     path2/file2 - a file in a directory
     path3-junk  - a file to confuse things
     path3/file3 - a file in a directory
+    path4       - an empty directory
 '
 . ./test-lib.sh
 
 date >path0
 ln -s xyzzy path1
-mkdir path2 path3
+mkdir path2 path3 path4
 date >path2/file2
 date >path2-junk
 date >path3/file3
@@ -28,6 +29,7 @@ git update-index --add path3-junk path3/file3
 cat >expected1 <<EOF
 expected1
 expected2
+expected3
 output
 path0
 path1
@@ -35,6 +37,8 @@ path2-junk
 path2/file2
 EOF
 sed -e 's|path2/file2|path2/|' <expected1 >expected2
+cat <expected2 >expected3
+echo path4/ >>expected2
 
 test_expect_success \
     'git ls-files --others to show output.' \
@@ -53,4 +57,12 @@ test_expect_success \
     'git ls-files --others --directory should not get confused.' \
     'test_cmp expected2 output'
 
+test_expect_success \
+    'git ls-files --others --directory --no-empty-directory to show output.' \
+    'git ls-files --others --directory --no-empty-directory >output'
+
+test_expect_success \
+    '--no-empty-directory hides empty directory' \
+    'test_cmp expected3 output'
+
 test_done
-- 
1.6.2.198.ge2a58
