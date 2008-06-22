From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] rerere.autoupdate
Date: Sun, 22 Jun 2008 02:48:10 -0700
Message-ID: <7v1w2pol5x.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu>
 <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu>
 <7vskvd9kai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Jun 22 11:49:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAMCC-0006KK-3m
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 11:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbYFVJsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 05:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYFVJsR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 05:48:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbYFVJsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 05:48:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 42E5FA424;
	Sun, 22 Jun 2008 05:48:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 49686A423; Sun, 22 Jun 2008 05:48:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 56665E94-4040-11DD-86A1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85761>

When this configuration is set, paths that are autoresolved by git-rerere
are updated in the index as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    5 +++++
 builtin-rerere.c         |   37 +++++++++++++++++++++++++++++++++++++
 t/t4200-rerere.sh        |   10 ++++++++++
 3 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5331b45..0c7cf61 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -650,6 +650,11 @@ gc.rerereunresolved::
 	kept for this many days when `git rerere gc` is run.
 	The default is 15 days.  See linkgit:git-rerere[1].
 
+rerere.autoupdate::
+	When set to true, `git-rerere` updates the index with the
+	resulting contents after it cleanly resolves conflicts using
+	previously recorded resolution.  Defaults to false.
+
 rerere.enabled::
 	Activate recording of resolved conflicts, so that identical
 	conflict hunks can be resolved automatically, should they
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 0eec1f9..839b26e 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -16,6 +16,9 @@ static int cutoff_resolve = 60;
 /* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
 static int rerere_enabled = -1;
 
+/* automatically update cleanly resolved paths to the index */
+static int rerere_autoupdate;
+
 static char *merge_rr_path;
 
 static const char *rr_path(const char *name, const char *file)
@@ -276,9 +279,36 @@ static int diff_two(const char *file1, const char *label1,
 	return 0;
 }
 
+static struct lock_file index_lock;
+
+static int update_paths(struct path_list *update)
+{
+	int i;
+	int fd = hold_locked_index(&index_lock, 0);
+	int status = 0;
+
+	if (fd < 0)
+		return -1;
+
+	for (i = 0; i < update->nr; i++) {
+		struct path_list_item *item = &update->items[i];
+		if (add_file_to_cache(item->path, ADD_CACHE_IGNORE_ERRORS))
+			status = -1;
+	}
+
+	if (!status && active_cache_changed) {
+		if (write_cache(fd, active_cache, active_nr) ||
+		    commit_locked_index(&index_lock))
+			die("Unable to write new index file");
+	} else if (fd >= 0)
+		rollback_lock_file(&index_lock);
+	return status;
+}
+
 static int do_plain_rerere(struct path_list *rr, int fd)
 {
 	struct path_list conflict = { NULL, 0, 0, 1 };
+	struct path_list update = { NULL, 0, 0, 1 };
 	int i;
 
 	find_conflict(&conflict);
@@ -323,6 +353,8 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 			if (!merge(name, path)) {
 				fprintf(stderr, "Resolved '%s' using "
 						"previous resolution.\n", path);
+				if (rerere_autoupdate)
+					path_list_insert(path, &update);
 				goto mark_resolved;
 			}
 		}
@@ -338,6 +370,9 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 		rr->items[i].util = NULL;
 	}
 
+	if (update.nr)
+		update_paths(&update);
+
 	return write_rr(rr, fd);
 }
 
@@ -349,6 +384,8 @@ static int git_rerere_config(const char *var, const char *value, void *cb)
 		cutoff_noresolve = git_config_int(var, value);
 	else if (!strcmp(var, "rerere.enabled"))
 		rerere_enabled = git_config_bool(var, value);
+	else if (!strcmp(var, "rerere.autoupdate"))
+		rerere_autoupdate = git_config_bool(var, value);
 	else
 		return git_default_config(var, value, cb);
 	return 0;
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index afb3e3d..a64727d 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -193,9 +193,19 @@ test_expect_success 'resolution was recorded properly' '
 	echo Bello > file3 &&
 	git add file3 &&
 	git commit -m version2 &&
+	git tag version2 &&
 	test_must_fail git merge fifth &&
 	test Cello = "$(cat file3)" &&
 	test 0 != $(git ls-files -u | wc -l)
 '
 
+test_expect_success 'rerere.autoupdate' '
+	git config rerere.autoupdate true
+	git reset --hard &&
+	git checkout version2 &&
+	test_must_fail git merge fifth &&
+	test 0 = $(git ls-files -u | wc -l)
+
+'
+
 test_done
-- 
1.5.6.12.g73f03
