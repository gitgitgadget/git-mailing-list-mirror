From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Share add_files_to_cache() with builtin-add.c
Date: Fri, 21 Sep 2007 15:01:18 -0400
Message-ID: <1190401278-2869-2-git-send-email-krh@redhat.com>
References: <1190401278-2869-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 21:01:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYnl6-0007GR-Uk
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 21:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761545AbXIUTBn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Sep 2007 15:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761665AbXIUTBm
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 15:01:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41004 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761545AbXIUTBj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 15:01:39 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8LJ1WNA008226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 21 Sep 2007 15:01:33 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8LJ1RZi003024;
	Fri, 21 Sep 2007 15:01:27 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8LJ1NJK030677;
	Fri, 21 Sep 2007 15:01:26 -0400
X-Mailer: git-send-email 1.5.3.2.1057.gbde3-dirty
In-Reply-To: <1190401278-2869-1-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58869>

This removes the extra copy in builtin-commit.c and uses
the update() function from builtin-add.c.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-add.c    |    8 +++---
 builtin-commit.c |   65 +++++++++++-----------------------------------=
-------
 commit.h         |    2 +
 3 files changed, 20 insertions(+), 55 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 5e30380..966e145 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -107,7 +107,7 @@ static void update_callback(struct diff_queue_struc=
t *q,
 	}
 }
=20
-static void update(int verbose, const char *prefix, const char **files=
)
+void add_files_to_cache(int verbose, const char *prefix, const char **=
files)
 {
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
@@ -116,8 +116,6 @@ static void update(int verbose, const char *prefix,=
 const char **files)
 	rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D update_callback;
 	rev.diffopt.format_callback_data =3D &verbose;
-	if (read_cache() < 0)
-		die("index file corrupt");
 	run_diff_files(&rev, 0);
 }
=20
@@ -218,7 +216,9 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	}
=20
 	if (take_worktree_changes) {
-		update(verbose, prefix, argv + i);
+		if (read_cache() < 0)
+			die("index file corrupt");
+		add_files_to_cache(verbose, prefix, argv + i);
 		goto finish;
 	}
=20
diff --git a/builtin-commit.c b/builtin-commit.c
index 90f23de..3768b53 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -56,53 +56,6 @@ static struct option commit_options[] =3D {
 	{ OPTION_STRING, "template", 't', &template_file },
 };
=20
-/* FIXME: Taken from builtin-add, should be shared. */
-
-static void update_callback(struct diff_queue_struct *q,
-			    struct diff_options *opt, void *cbdata)
-{
-	int i, verbose;
-
-	verbose =3D *((int *)cbdata);
-	for (i =3D 0; i < q->nr; i++) {
-		struct diff_filepair *p =3D q->queue[i];
-		const char *path =3D p->one->path;
-		switch (p->status) {
-		default:
-			die("unexpacted diff status %c", p->status);
-		case DIFF_STATUS_UNMERGED:
-		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
-			add_file_to_cache(path, verbose);
-			break;
-		case DIFF_STATUS_DELETED:
-			remove_file_from_cache(path);
-			if (verbose)
-				printf("remove '%s'\n", path);
-			break;
-		}
-	}
-}
-
-static void
-add_files_to_cache(int fd, const char **files, const char *prefix)
-{
-	struct rev_info rev;
-
-	init_revisions(&rev, "");
-	setup_revisions(0, NULL, &rev, NULL);
-	rev.prune_data =3D get_pathspec(prefix, files);
-	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback =3D update_callback;
-	rev.diffopt.format_callback_data =3D &verbose;
-
-	run_diff_files(&rev, 0);
-	refresh_cache(REFRESH_QUIET);
-
-	if (write_cache(fd, active_cache, active_nr) || close(fd))
-		die("unable to write new index file");
-}
-
 static char *
 prepare_index(const char **files, const char *prefix)
 {
@@ -115,10 +68,16 @@ prepare_index(const char **files, const char *pref=
ix)
 		die("index file corrupt");
=20
 	if (all) {
-		add_files_to_cache(fd, files, NULL);
+		add_files_to_cache(0, prefix, files);
+		if (write_cache(fd, active_cache, active_nr) || close(fd))
+			die("unable to write new index file");
+
 		return lock_file.filename;
 	} else if (also) {
-		add_files_to_cache(fd, files, prefix);
+		add_files_to_cache(0, prefix, files);
+		if (write_cache(fd, active_cache, active_nr) || close(fd))
+			die("unable to write new index file");
+
 		return lock_file.filename;
 	}
=20
@@ -146,7 +105,9 @@ prepare_index(const char **files, const char *prefi=
x)
 	 */
=20
 	/* update the user index file */
-	add_files_to_cache(fd, files, prefix);
+	add_files_to_cache(0, prefix, files);
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+		die("unable to write new index file");
=20
 	if (!initial_commit) {
 		tree =3D parse_tree_indirect(head_sha1);
@@ -160,7 +121,9 @@ prepare_index(const char **files, const char *prefi=
x)
 	next_index_lock =3D xmalloc(sizeof(*next_index_lock));
 	fd =3D hold_lock_file_for_update(next_index_lock,
 				       git_path("next-index-%d", getpid()), 1);
-	add_files_to_cache(fd, files, prefix);
+	add_files_to_cache(0, prefix, files);
+	if (write_cache(fd, active_cache, active_nr) || close(fd))
+		die("unable to write new index file");
=20
 	return next_index_lock->filename;
 }
diff --git a/commit.h b/commit.h
index cc8d890..89caa12 100644
--- a/commit.h
+++ b/commit.h
@@ -130,6 +130,8 @@ extern struct commit_list *get_shallow_commits(stru=
ct object_array *heads,
 int in_merge_bases(struct commit *, struct commit **, int);
=20
 extern int interactive_add(void);
+extern void add_files_to_cache(int verbose,
+			       const char *prefix, const char **files);
 extern int rerere(void);
=20
 #endif /* COMMIT_H */
--=20
1.5.2.5
