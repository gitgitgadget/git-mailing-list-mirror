From: Jeff King <peff@peff.net>
Subject: [RFC] diff: support custom callbacks for output
Date: Mon, 7 Aug 2006 03:50:02 -0400
Message-ID: <20060807075002.GA29693@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 07 09:50:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9zsO-0008ED-NG
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 09:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWHGHuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 03:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWHGHuI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 03:50:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11209 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751139AbWHGHuG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 03:50:06 -0400
Received: (qmail 703 invoked from network); 7 Aug 2006 03:49:29 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 7 Aug 2006 03:49:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon,  7 Aug 2006 03:50:02 -0400
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24999>

---
I'm re-writing git-status in C, and that entails using the git library
to replace calls to things like git-diff-index. Fortunately,
run_diff_index does just what I want. Unfortunately, it ends up wanting
to send its output to stdout in one of the pre-defined diff formats, and
what I really want is my own status format.

I could, of course, add diff_flush_status() support to diffcore.
However, I'm not sure that it really belongs there. In the interests of
libification, it seems reasonable for diffcore to provide a callback
mechanism for each filepair.

Below is an attempt to provide such a mechanism. My questions are:
  1. Am I right that there is no other way to accomplish this task? This
     is my first interaction with diffcore, so I might have overlooked
     something.
  2. Is this the way I should go about it, or should I add a status
     output to git-diff? (Note that the callback takes the same
     parameters as the other diff_flush_* functions; it may be that we
     can use this general mechanism to implement other formats).
  3. This seems very similar in spirit to the add_remove and changed
     members of diff_options. However, I'm not clear on when those are
     called (they seem to only be called from diff-tree).

 diff.c |    8 ++++++++
 diff.h |    7 +++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index f5c9a55..a04257f 100644
--- a/diff.c
+++ b/diff.c
@@ -2278,6 +2278,14 @@ void diff_flush(struct diff_options *opt
 		}
 	}
 
+	if (output_format & DIFF_FORMAT_CALLBACK) {
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			if (check_pair_status(p))
+				options->format_callback(p, options);
+		}
+	}
+
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
 free_queue:
diff --git a/diff.h b/diff.h
index 2cced53..5671a53 100644
--- a/diff.h
+++ b/diff.h
@@ -8,6 +8,7 @@ #include "tree-walk.h"
 
 struct rev_info;
 struct diff_options;
+struct diff_filepair;
 
 typedef void (*change_fn_t)(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
@@ -20,6 +21,9 @@ typedef void (*add_remove_fn_t)(struct d
 		    const unsigned char *sha1,
 		    const char *base, const char *path);
 
+typedef void (*diff_format_fn_t)(struct diff_filepair *p,
+		struct diff_options *options);
+
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
 #define DIFF_FORMAT_SUMMARY	0x0004
@@ -35,6 +39,8 @@ #define DIFF_FORMAT_CHECKDIFF	0x0040
  */
 #define DIFF_FORMAT_NO_OUTPUT	0x0080
 
+#define DIFF_FORMAT_CALLBACK	0x0100
+
 struct diff_options {
 	const char *filter;
 	const char *orderfile;
@@ -67,6 +73,7 @@ struct diff_options {
 	int *pathlens;
 	change_fn_t change;
 	add_remove_fn_t add_remove;
+	diff_format_fn_t format_callback;
 };
 
 enum color_diff {
-- 
1.4.2.rc3.g539fa-dirty
