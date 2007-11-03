From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-reset: do not be confused if there is nothing to reset
Date: Sat, 3 Nov 2007 13:12:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031310350.4362@racer.site>
References: <20071103111743.GA29358@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-373757108-1194095537=:4362"
Cc: git@vger.kernel.org, jasampler@gmail.com, gitster@pobox.com
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 14:13:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoIom-0001Tv-Hs
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbXKCNN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbXKCNN1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:13:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:41952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753849AbXKCNN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:13:26 -0400
Received: (qmail invoked by alias); 03 Nov 2007 13:13:24 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp016) with SMTP; 03 Nov 2007 14:13:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9AJ0/Y1O9PKYFty0gMGf7zM7VEPQTx9lSirzLiI
	LoJYhf3llRe+5E
X-X-Sender: gene099@racer.site
In-Reply-To: <20071103111743.GA29358@atjola.homenet>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63263>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-373757108-1194095537=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


The purpose of the function update_index_from_diff() (which is the
callback function we give do_diff_cache()) is to update those index
entries which differ from the given commit.

Since do_diff_cache() plays games with the in-memory index, this function
discarded the cache and reread it.

Then, back in the function read_from_tree() we wrote the index.

Of course, this broke down when there were no changes and
update_index_from_diff() was not called, and therefore the mangled index
was not discarded.

The solution is to move the index writing into the function
update_index_from_diff().

Noticed by Björn Steinbrink.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-reset.c  |   24 ++++++++++++++++++------
 t/t7102-reset.sh |    7 +++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index e1dc31e..5467e36 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -113,10 +113,17 @@ static int update_index_refresh(void)
 	return run_command_v_opt(argv_update_index, RUN_GIT_CMD);
 }
 
+struct update_cb_data {
+	int index_fd;
+	struct lock_file *lock;
+	int exit_code;
+};
+
 static void update_index_from_diff(struct diff_queue_struct *q,
 		struct diff_options *opt, void *data)
 {
 	int i;
+	struct update_cb_data *cb = data;
 
 	/* do_diff_cache() mangled the index */
 	discard_cache();
@@ -133,29 +140,34 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		} else
 			remove_file_from_cache(one->path);
 	}
+
+	cb->exit_code = write_cache(cb->index_fd, active_cache, active_nr) ||
+		close(cb->index_fd) ||
+		commit_locked_index(cb->lock);
 }
 
 static int read_from_tree(const char *prefix, const char **argv,
 		unsigned char *tree_sha1)
 {
-        struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int index_fd;
 	struct diff_options opt;
+	struct update_cb_data cb;
 
 	memset(&opt, 0, sizeof(opt));
 	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt);
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
+	opt.format_callback_data = &cb;
 
-	index_fd = hold_locked_index(lock, 1);
+	cb.lock = xcalloc(1, sizeof(struct lock_file));
+	cb.index_fd = hold_locked_index(cb.lock, 1);
+	cb.exit_code = 0;
 	read_cache();
 	if (do_diff_cache(tree_sha1, &opt))
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
-	return write_cache(index_fd, active_cache, active_nr) ||
-		close(index_fd) ||
-		commit_locked_index(lock);
+
+	return cb.exit_code;
 }
 
 static void prepend_reflog_action(const char *action, char *buf, size_t size)
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index f64b1cb..cea9afb 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -402,4 +402,11 @@ test_expect_success 'test resetting the index at give paths' '
 
 '
 
+test_expect_success 'resetting an unmodified path is a no-op' '
+	git reset --hard &&
+	git reset -- file1 &&
+	git diff-files --exit-code &&
+	git diff-index --cached --exit-code HEAD
+'
+
 test_done
-- 
1.5.3.5.1505.gd778c

--8323584-373757108-1194095537=:4362--
