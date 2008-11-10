From: Daniel Lowe <dlowe@bitmuse.com>
Subject: [PATCH] Fixed non-literal format in printf-style calls
Date: Mon, 10 Nov 2008 14:15:17 -0500
Message-ID: <1226344517-16120-1-git-send-email-dlowe@bitmuse.com>
Cc: Daniel Lowe <dlowe@bitmuse.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 20:27:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzcQ4-00049z-SA
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbYKJT0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbYKJT0G
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:26:06 -0500
Received: from digital.sanctuary.org ([206.41.250.2]:49588 "EHLO
	digital.sanctuary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbYKJT0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:26:05 -0500
X-Greylist: delayed 628 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Nov 2008 14:26:05 EST
Received: from localhost.localdomain (ita4fw1.itasoftware.com [63.107.91.99])
	(authenticated bits=0)
	by digital.sanctuary.org (8.12.11/8.12.11) with ESMTP id mAAJFNLO004881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Nov 2008 13:15:26 -0600
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100548>

These were found using gcc 4.3.2-1ubuntu11 with the warning:

warning: format not a string literal and no format arguments


---
 builtin-check-attr.c |    2 +-
 builtin-remote.c     |    2 +-
 bundle.c             |    4 ++--
 environment.c        |    2 +-
 fsck.c               |    2 +-
 grep.c               |    6 +++---
 hash-object.c        |    2 +-
 path.c               |    4 ++--
 refs.c               |    2 +-
 unpack-trees.c       |    2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 4921341..15a04b7 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -97,7 +97,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	else if (stdin_paths && doubledash < argc)
 		errstr = "Can't specify files with --stdin";
 	if (errstr) {
-		error (errstr);
+		error("%s", errstr);
 		usage_with_options(check_attr_usage, check_attr_options);
 	}

diff --git a/builtin-remote.c b/builtin-remote.c
index e396a3a..47deb0a 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -320,7 +320,7 @@ static int add_branch_for_removal(const char *refname,

 	/* make sure that symrefs are deleted */
 	if (flags & REF_ISSYMREF)
-		return unlink(git_path(refname));
+		return unlink(git_path("%s", refname));

 	item = string_list_append(refname, branches->branches);
 	item->util = xmalloc(20);
diff --git a/bundle.c b/bundle.c
index 7d17a1f..daecd8e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -114,7 +114,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 			continue;
 		}
 		if (++ret == 1)
-			error(message);
+			error("%s", message);
 		error("%s %s", sha1_to_hex(e->sha1), e->name);
 	}
 	if (revs.pending.nr != p->nr)
@@ -139,7 +139,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	for (i = 0; i < req_nr; i++)
 		if (!(refs.objects[i].item->flags & SHOWN)) {
 			if (++ret == 1)
-				error(message);
+				error("%s", message);
 			error("%s %s", sha1_to_hex(refs.objects[i].item->sha1),
 				refs.objects[i].name);
 		}
diff --git a/environment.c b/environment.c
index bf93a59..bb96ac0 100644
--- a/environment.c
+++ b/environment.c
@@ -118,7 +118,7 @@ const char *get_git_work_tree(void)
 			work_tree = git_work_tree_cfg;
 			/* make_absolute_path also normalizes the path */
 			if (work_tree && !is_absolute_path(work_tree))
-				work_tree = xstrdup(make_absolute_path(git_path(work_tree)));
+				work_tree = xstrdup(make_absolute_path(git_path("%s", work_tree)));
 		} else if (work_tree)
 			work_tree = xstrdup(make_absolute_path(work_tree));
 		git_work_tree_initialized = 1;
diff --git a/fsck.c b/fsck.c
index 0cf5f01..97f76c5 100644
--- a/fsck.c
+++ b/fsck.c
@@ -326,7 +326,7 @@ int fsck_error_function(struct object *obj, int type, const char *fmt, ...)
 			die("this should not happen, your snprintf is broken");
 	}

-	error(sb.buf);
+	error("%s", sb.buf);
 	strbuf_release(&sb);
 	return 1;
 }
diff --git a/grep.c b/grep.c
index e2c190a..1db60d9 100644
--- a/grep.c
+++ b/grep.c
@@ -514,7 +514,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 				if (from <= last_shown)
 					from = last_shown + 1;
 				if (last_shown && from != last_shown + 1)
-					printf(hunk_mark);
+					printf("%s", hunk_mark);
 				while (from < lno) {
 					pcl = &prev[lno-from-1];
 					show_line(opt, pcl->bol, pcl->eol,
@@ -524,7 +524,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 				last_shown = lno-1;
 			}
 			if (last_shown && lno != last_shown + 1)
-				printf(hunk_mark);
+				printf("%s", hunk_mark);
 			if (!opt->count)
 				show_line(opt, bol, eol, name, lno, ':');
 			last_shown = last_hit = lno;
@@ -535,7 +535,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 * we need to show this line.
 			 */
 			if (last_shown && lno != last_shown + 1)
-				printf(hunk_mark);
+				printf("%s", hunk_mark);
 			show_line(opt, bol, eol, name, lno, '-');
 			last_shown = lno;
 		}
diff --git a/hash-object.c b/hash-object.c
index 20937ff..846e91a 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -110,7 +110,7 @@ int main(int argc, const char **argv)
 	}

 	if (errstr) {
-		error (errstr);
+		error("%s", errstr);
 		usage_with_options(hash_object_usage, hash_object_options);
 	}

diff --git a/path.c b/path.c
index eb24017..ae2c724 100644
--- a/path.c
+++ b/path.c
@@ -41,7 +41,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	len = vsnprintf(buf, n, fmt, args);
 	va_end(args);
 	if (len >= n) {
-		snprintf(buf, n, bad_path);
+		snprintf(buf, n, "%s", bad_path);
 		return buf;
 	}
 	return cleanup_path(buf);
@@ -63,7 +63,7 @@ static char *git_vsnpath(char *buf, size_t n, const char *fmt, va_list args)
 		goto bad;
 	return cleanup_path(buf);
 bad:
-	snprintf(buf, n, bad_path);
+	snprintf(buf, n, "%s", bad_path);
 	return buf;
 }

diff --git a/refs.c b/refs.c
index 42bde72..33ced65 100644
--- a/refs.c
+++ b/refs.c
@@ -940,7 +940,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 			lock->lk->filename[i] = 0;
 			path = lock->lk->filename;
 		} else {
-			path = git_path(refname);
+			path = git_path("%s", refname);
 		}
 		err = unlink(path);
 		if (err && errno != ENOENT) {
diff --git a/unpack-trees.c b/unpack-trees.c
index e5749ef..54f301d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -352,7 +352,7 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
 	discard_index(&o->result);
 	if (!o->gently) {
 		if (message)
-			return error(message);
+			return error("%s", message);
 		return -1;
 	}
 	return -1;
--
1.6.0.4
