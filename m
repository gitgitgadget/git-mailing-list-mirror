From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-reset: avoid forking "update-index --refresh"
Date: Sat, 3 Nov 2007 15:21:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031437220.4362@racer.site>
References: <46E60946.4000803@gmail.com> <7v3axlodw9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 16:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoKpp-0007DA-T8
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 16:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbXKCPWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 11:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754200AbXKCPWk
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 11:22:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:53479 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754008AbXKCPWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 11:22:39 -0400
Received: (qmail invoked by alias); 03 Nov 2007 15:22:37 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp051) with SMTP; 03 Nov 2007 16:22:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+12HYrAFm1nF2qCpa8iXB9gzPOkMBBUTmzenN+ay
	yUhyt8NdmGckaU
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3axlodw9.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63282>


Instead of forking update-index, call refresh_cache() directly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 11 Sep 2007, Junio C Hamano wrote:

	> Carlos Rica <jasampler@gmail.com> writes:
	> 
	> > +static int update_index_refresh(void)
	> > +{
	> > +	const char *argv_update_index[] = {"update-index", "--refresh", NULL};
	> > +	return run_command_v_opt(argv_update_index, RUN_GIT_CMD);
	> > +}
	> 
	> Instead of making a call to this one after read_from_tree()
	> returns, immediately before writing the index out at the end of
	> read_from_tree(), you have the index in core.  I think you can
	> call read-cache.c::refresh_index() at that point and then do the
	> write_cache(), no?

	A little more complicated now, since this is (obviously) on top of 
	the bug fix I sent out earlier.

	I just realised that it partially undoes the changes of that 
	commit.  If you want to, I will redo this mini-series, changing 
	the first commit to something more similar to this patch.

 builtin-reset.c  |   53 +++++++++++++++++++++++++++++------------------------
 t/t7102-reset.sh |   10 ++++++++++
 2 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 79792ee..44582f2 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -95,26 +95,34 @@ static void print_new_head_line(struct commit *commit)
 		printf("\n");
 }
 
-static int update_index_refresh(void)
+static int update_index_refresh(int fd, struct lock_file *index_lock)
 {
-	const char *argv_update_index[] = {"update-index", "--refresh", NULL};
-	return run_command_v_opt(argv_update_index, RUN_GIT_CMD);
-}
+	int result;
+
+	if (!index_lock) {
+		index_lock = xcalloc(1, sizeof(struct lock_file));
+		fd = hold_locked_index(index_lock, 1);
+	}
 
-struct update_cb_data {
-	int index_fd;
-	struct lock_file *lock;
-	int exit_code;
-};
+	if (read_cache() < 0)
+		return error("Could not read index");
+	result = refresh_cache(0) ? 1 : 0;
+	if (write_cache(fd, active_cache, active_nr) ||
+			close(fd) ||
+			commit_locked_index(index_lock))
+		return error ("Could not refresh index");
+	return result;
+}
 
 static void update_index_from_diff(struct diff_queue_struct *q,
 		struct diff_options *opt, void *data)
 {
 	int i;
-	struct update_cb_data *cb = data;
+	int *discard_flag = data;
 
 	/* do_diff_cache() mangled the index */
 	discard_cache();
+	*discard_flag = 1;
 	read_cache();
 
 	for (i = 0; i < q->nr; i++) {
@@ -128,34 +136,33 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		} else
 			remove_file_from_cache(one->path);
 	}
-
-	cb->exit_code = write_cache(cb->index_fd, active_cache, active_nr) ||
-		close(cb->index_fd) ||
-		commit_locked_index(cb->lock);
 }
 
 static int read_from_tree(const char *prefix, const char **argv,
 		unsigned char *tree_sha1)
 {
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	int index_fd, index_was_discarded = 0;
 	struct diff_options opt;
-	struct update_cb_data cb;
 
 	memset(&opt, 0, sizeof(opt));
 	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt);
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
-	opt.format_callback_data = &cb;
+	opt.format_callback_data = &index_was_discarded;
 
-	cb.lock = xcalloc(1, sizeof(struct lock_file));
-	cb.index_fd = hold_locked_index(cb.lock, 1);
-	cb.exit_code = 0;
+	index_fd = hold_locked_index(lock, 1);
+	index_was_discarded = 0;
 	read_cache();
 	if (do_diff_cache(tree_sha1, &opt))
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
 
-	return cb.exit_code;
+	if (!index_was_discarded)
+		/* The index is still clobbered from do_diff_cache() */
+		discard_cache();
+	return update_index_refresh(index_fd, lock);
 }
 
 static void prepend_reflog_action(const char *action, char *buf, size_t size)
@@ -225,9 +232,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		else if (reset_type != NONE)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
-		if (read_from_tree(prefix, argv + i, sha1))
-			return 1;
-		return update_index_refresh() ? 1 : 0;
+		return read_from_tree(prefix, argv + i, sha1);
 	}
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
@@ -264,7 +269,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	case SOFT: /* Nothing else to do. */
 		break;
 	case MIXED: /* Report what has not been updated. */
-		update_index_refresh();
+		update_index_refresh(0, NULL);
 		break;
 	}
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 506767d..e5c9f30 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -418,4 +418,14 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 	git diff-index --cached --exit-code HEAD
 '
 
+cat > expect << EOF
+file2: needs update
+EOF
+
+test_expect_success '--mixed refreshes the index' '
+	echo 123 >> file2 &&
+	git reset --mixed HEAD > output &&
+	git diff --exit-code expect output
+'
+
 test_done
-- 
1.5.3.5.1506.g83995
