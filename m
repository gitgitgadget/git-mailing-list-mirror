From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff: resurrect the traditional empty "diff --git" behaviour
Date: Fri, 31 Aug 2007 13:13:42 -0700
Message-ID: <7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>
	<20070831152120.GC17637@mellanox.co.il>
	<7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
	<20070831160335.GA17761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 22:14:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRCsl-00011U-FW
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 22:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbXHaUNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 16:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbXHaUNu
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 16:13:50 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbXHaUNs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 16:13:48 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D668F12BDAC;
	Fri, 31 Aug 2007 16:14:05 -0400 (EDT)
In-Reply-To: <20070831160335.GA17761@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 Aug 2007 12:03:35 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57201>

The "Consier running git-status" warning message we experimented
during the 1.5.3 cycle turns out to be a bad idea.  It robbed
cache-dirty information from people who valued it, while still
asking users to run "update-index --refresh".  It was hoped that
the new behaviour would at least have some educational value,
but not showing the cache-dirty paths like before means the user
would not even know easily which paths are cache-dirty.

This commit reinstates the traditional behaviour as the default,
but with a twist.

If you set diff.autorefreshindex configuration variable, it
squelches the empty "diff --git" output, and at the end of the
command, it automatically runs "update-index --refresh" without
even bothering the user.  In other words, with the configuration
variable set, people who do not care about the cache-dirtyness
do not even have to see the warning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Jeff King <peff@peff.net> writes:

 > FWIW, I find the new message terribly ugly compared to the old behavior.
 > There have been many output changes that I didn't like at first, but for
 > which I held my tongue and eventually grew to like when they became more
 > familiar (e.g., the 'subject' line after git-commit).
 >
 > But I just can't seem to find this one anything but ugly; everytime I
 > see it, I involuntarily cringe. Perhaps because it really looks like an
 > error message that accidentally got stuck in the diff output through
 > incompetent redirection of stdout/stderr.
 >
 > I say this not to start a flame war (which is perhaps inevitable), but I
 > just wonder if others feel the same, now that they have had a chance to
 > get used to it.

 Same here.  This patch saw only very light testing, but I
 personally think is a sane thing to do before 1.5.3 final.

 builtin-diff.c |   31 ++++++++++++++++++++++++++-----
 cache.h        |    3 +++
 diff.c         |    5 +++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 6ed7b68..4ffbbad 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -188,6 +188,30 @@ void add_head(struct rev_info *revs)
 	add_pending_object(revs, obj, "HEAD");
 }
 
+static void refresh_index_quietly(void)
+{
+	struct lock_file *lock_file;
+	int fd;
+
+	lock_file = xcalloc(1, sizeof(struct lock_file));
+	fd = hold_locked_index(lock_file, 0);
+	if (fd < 0)
+		return;
+	discard_cache();
+	read_cache();
+	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
+	if (active_cache_changed) {
+		if (write_cache(fd, active_cache, active_nr) ||
+		    close(fd) ||
+		    commit_locked_index(lock_file))
+			; /*
+			   * silently ignore it -- we haven't mucked
+			   * with the real index.
+			   */
+	}
+	rollback_lock_file(lock_file);
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -222,7 +246,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	prefix = setup_git_directory_gently(&nongit);
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
-	rev.diffopt.skip_stat_unmatch = 1;
+	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
 
 	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
 		argc = 0;
@@ -348,9 +372,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	if ((rev.diffopt.output_format & DIFF_FORMAT_PATCH)
 	    && (1 < rev.diffopt.skip_stat_unmatch))
-		printf("Warning: %d path%s touched but unmodified. "
-		       "Consider running git-status.\n",
-		       rev.diffopt.skip_stat_unmatch - 1,
-		       rev.diffopt.skip_stat_unmatch == 2 ? "" : "s");
+		refresh_index_quietly();
 	return result;
 }
diff --git a/cache.h b/cache.h
index c7e00e7..70abbd5 100644
--- a/cache.h
+++ b/cache.h
@@ -594,6 +594,9 @@ extern char *convert_to_git(const char *path, const char *src, unsigned long *si
 extern char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep);
 extern void *convert_sha1_file(const char *path, const unsigned char *sha1, unsigned int mode, enum object_type *type, unsigned long *size);
 
+/* diff.c */
+extern int diff_auto_refresh_index;
+
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
 
diff --git a/diff.c b/diff.c
index a7e7671..75d95da 100644
--- a/diff.c
+++ b/diff.c
@@ -19,6 +19,7 @@
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = -1;
 static int diff_use_color_default;
+int diff_auto_refresh_index;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
@@ -166,6 +167,10 @@ int git_diff_ui_config(const char *var, const char *value)
 			diff_detect_rename_default = DIFF_DETECT_RENAME;
 		return 0;
 	}
+	if (!strcmp(var, "diff.autorefreshindex")) {
+		diff_auto_refresh_index = git_config_bool(var, value);
+		return 0;
+	}
 	if (!prefixcmp(var, "diff.")) {
 		const char *ep = strrchr(var, '.');
 
