From: Jeff King <peff@peff.net>
Subject: [PATCH] revert: actually check for a dirty index
Date: Sun, 2 Mar 2008 02:22:52 -0500
Message-ID: <20080302072252.GA14214@coredump.intra.peff.net>
References: <20080302064449.GA6334@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:23:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JViXk-0008EP-3w
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbYCBHWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbYCBHWz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:22:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2421 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbYCBHWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:22:54 -0500
Received: (qmail 3890 invoked by uid 111); 2 Mar 2008 07:22:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Mar 2008 02:22:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Mar 2008 02:22:52 -0500
Content-Disposition: inline
In-Reply-To: <20080302064449.GA6334@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75736>

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

Signed-off-by: Jeff King <peff@peff.net>
---
I said:
> I think it should be fixable by something like the patch below, but it
> feels a little hack-ish. Should there perhaps be an equivalent to
> "wt_status_print_updated" that just finds the commitable flag?

This is much nicer, and more efficient to boot.

 builtin-revert.c              |   34 ++++++++++++++++++++++++++++++----
 t/t3501-revert-cherry-pick.sh |    9 +++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index b6dee6a..15ab969 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -9,6 +9,9 @@
 #include "utf8.h"
 #include "parse-options.h"
 #include "cache-tree.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -246,6 +249,30 @@ static char *help_msg(const unsigned char *sha1)
 	return helpbuf;
 }
 
+static void index_is_dirty_cb(struct diff_queue_struct *q,
+		struct diff_options *options,
+		void *data)
+{
+	int *is_dirty = data;
+	if (q->nr > 0)
+		*is_dirty = 1;
+}
+
+static int index_is_dirty(void)
+{
+	struct rev_info rev;
+	int is_dirty = 0;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, "HEAD");
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = index_is_dirty_cb;
+	rev.diffopt.format_callback_data = &is_dirty;
+	run_diff_index(&rev, 1);
+
+	return is_dirty;
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
@@ -274,12 +301,11 @@ static int revert_or_cherry_pick(int argc, const char **argv)
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
1.5.4.3.365.gc1491.dirty
