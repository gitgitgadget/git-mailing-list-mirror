From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revert: actually check for a dirty index
Date: Mon, 3 Mar 2008 01:30:56 -0500
Message-ID: <20080303063055.GA24866@coredump.intra.peff.net>
References: <20080302064449.GA6334@coredump.intra.peff.net> <20080302072252.GA14214@coredump.intra.peff.net> <20080302103753.GB2973@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 07:31:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4DL-0000ik-Eq
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 07:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbYCCGa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 01:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYCCGa7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 01:30:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1252 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbYCCGa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 01:30:58 -0500
Received: (qmail 6377 invoked by uid 111); 3 Mar 2008 06:30:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Mar 2008 01:30:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Mar 2008 01:30:56 -0500
Content-Disposition: inline
In-Reply-To: <20080302103753.GB2973@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75887>

On Sun, Mar 02, 2008 at 11:37:53AM +0100, Alex Riesen wrote:

> Wouldn't something like what built-commit does more effective?

I assumed git-commit used wt_status_print, and it does, but only for
some code paths. When possible, it uses the more efficient version you
mentioned.

So here is my patch respun with the same method. I considered making a
globally available "is_index_dirty" function, but I think there are a
lot of assumptions that make such a function more trouble than the 6
lines it saves. E.g., "dirty versus what?", "which index?", "has the
index been loaded already?"

Thanks Alex.

-Peff

-- >8 --
revert: actually check for a dirty index

The previous code mistakenly used wt_status_prepare to check
whether the index had anything commitable in it; however,
that function is just an init function, and will never
report a dirty index.

The correct way with wt_status_* would be to call
wt_status_print with the output pointing to /dev/null or
similar. However, that does extra work by both examining the
working tree and spewing status information to nowhere.

Instead, let's just implement the useful subset of
wt_status_print as an "is_index_dirty" function.
---
 builtin-revert.c              |   20 ++++++++++++++++----
 t/t3501-revert-cherry-pick.sh |    9 +++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index b6dee6a..1989f96 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -9,6 +9,8 @@
 #include "utf8.h"
 #include "parse-options.h"
 #include "cache-tree.h"
+#include "diff.h"
+#include "revision.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -246,6 +248,17 @@ static char *help_msg(const unsigned char *sha1)
 	return helpbuf;
 }
 
+static int index_is_dirty(void)
+{
+	struct rev_info rev;
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, "HEAD");
+	DIFF_OPT_SET(&rev.diffopt, QUIET);
+	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+	run_diff_index(&rev, 1);
+	return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
@@ -274,12 +287,11 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		if (write_cache_as_tree(head, 0, NULL))
 			die ("Your index file is unmerged.");
 	} else {
-		struct wt_status s;
-
 		if (get_sha1("HEAD", head))
 			die ("You do not have a valid HEAD");
-		wt_status_prepare(&s);
-		if (s.commitable)
+		if(read_cache() < 0)
+			die("could not read the index");
+		if (index_is_dirty())
 			die ("Dirty index: cannot %s", me);
 		discard_cache();
 	}
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 2dbe04f..6da2128 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -59,4 +59,13 @@ test_expect_success 'revert after renaming branch' '
 
 '
 
+test_expect_success 'revert forbidden on dirty working tree' '
+
+	echo content >extra_file &&
+	git add extra_file &&
+	test_must_fail git revert HEAD 2>errors &&
+	grep "Dirty index" errors
+
+'
+
 test_done
-- 
1.5.4.3.366.gb96b1.dirty

