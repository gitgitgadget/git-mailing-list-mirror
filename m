From: Jeff King <peff@peff.net>
Subject: Re: Bug Report ( including test script ): Non-Fastforward merges
 misses directory deletion
Date: Fri, 19 Feb 2010 00:57:21 -0500
Message-ID: <20100219055721.GC22645@coredump.intra.peff.net>
References: <loom.20100218T104300-858@post.gmane.org>
 <loom.20100218T113103-602@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Sebastian Thiel <byronimo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 06:57:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiLrt-0008Lv-4R
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 06:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483Ab0BSF5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 00:57:24 -0500
Received: from peff.net ([208.65.91.99]:55718 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab0BSF5X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 00:57:23 -0500
Received: (qmail 11383 invoked by uid 107); 19 Feb 2010 05:57:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 19 Feb 2010 00:57:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2010 00:57:21 -0500
Content-Disposition: inline
In-Reply-To: <loom.20100218T113103-602@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140411>

On Thu, Feb 18, 2010 at 11:43:23AM +0000, Sebastian Thiel wrote:

> To me it appears as if merge, once it detects a file deletion,
> internally uses git-rm to delete the affected files from the working
> tree.  Git-rm will only delete the file's immediate parent directory,
> but does not consider other empty parent directories.

Hmm. It seems to be a bug.

-- >8 --
Subject: [PATCH] rm: fix bug in recursive subdirectory removal

If we remove a path in a/deep/subdirectory, we should try to
remove as many trailing components as possible (i.e.,
subdirectory, then deep, then a). However, the test for the
return value of rmdir was reversed, so we only ever deleted
at most one level.

The fix is in remove_path, so "apply" and "merge-recursive"
also are fixed.

Signed-off-by: Jeff King <peff@peff.net>
---
This was introduced by Alex's 4a92d1b (Add remove_path: a function to
remove as much as possible of a path, 2008-09-27), which ironically
complained about bugs in the code it was replacing. :)

As an added bonus, we used to see a failed rmdir as success and keep
walking backwards. So now we are avoiding some useless rmdir calls on
the parent directories (think of the microseconds we must be saving!).

 dir.c         |    2 +-
 t/t3600-rm.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 67c3af6..133c333 100644
--- a/dir.c
+++ b/dir.c
@@ -1044,7 +1044,7 @@ int remove_path(const char *name)
 		slash = dirs + (slash - name);
 		do {
 			*slash = '\0';
-		} while (rmdir(dirs) && (slash = strrchr(dirs, '/')));
+		} while (rmdir(dirs) == 0 && (slash = strrchr(dirs, '/')));
 		free(dirs);
 	}
 	return 0;
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 76b1bb4..0aaf0ad 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -271,4 +271,12 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 	test "$status" != 0
 '
 
+test_expect_success 'rm removes subdirectories recursively' '
+	mkdir -p dir/subdir/subsubdir &&
+	echo content >dir/subdir/subsubdir/file &&
+	git add dir/subdir/subsubdir/file &&
+	git rm -f dir/subdir/subsubdir/file &&
+	! test -d dir
+'
+
 test_done
-- 
1.7.0.77.gb5742
