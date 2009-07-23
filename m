From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] git repack: keep commits hidden by a graft
Date: Thu, 23 Jul 2009 17:33:49 +0200 (CEST)
Message-ID: <34dfd22bb99c7c466b6131876e8b52ac46f388aa.1248362827u.git.johannes.schindelin@gmx.de>
References: <cover.1248362827u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 23 17:34:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU0Ix-0004qv-M8
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 17:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbZGWPdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 11:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbZGWPdv
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 11:33:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:58974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753642AbZGWPdu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 11:33:50 -0400
Received: (qmail invoked by alias); 23 Jul 2009 15:33:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 23 Jul 2009 17:33:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rMNUkIPrraAcTG2l6zLHlVdqrZIR6fYT9Bjjc5K
	NqBbh/9gYwKYNs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1248362827u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123874>

When you have grafts that pretend that a given commit has different
parents than the ones recorded in the commit object, it is dangerous
to let 'git repack' remove those hidden parents, as you can easily
remove the graft and end up with a broken repository.

So let's play it safe and keep those parent objects and everything
that is reachable by them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Maybe we should not even bother documenting this option?

 Documentation/git-pack-objects.txt |    7 ++++++-
 builtin-pack-objects.c             |    4 ++++
 cache.h                            |    2 ++
 commit.c                           |    2 +-
 environment.c                      |    1 +
 git-repack.sh                      |    2 +-
 t/t7700-repack.sh                  |    2 +-
 7 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 7d4c1a7..06390e3 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 [verse]
 'git pack-objects' [-q] [--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=N] [--depth=N] [--all-progress]
-	[--revs [--unpacked | --all]*] [--stdout | base-name] < object-list
+	[--revs [--unpacked | --all]*] [--stdout | base-name]
+	[--grafts-replace-parents=no] < object-list
 
 
 DESCRIPTION
@@ -197,6 +198,10 @@ base-name::
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
 
+--grafts-replace-parents=no::
+	With this option, parents that are hidden by grafts are packed
+	nevertheless.
+
 
 Author
 ------
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 1689bd1..77bff85 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2257,6 +2257,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 				die("bad %s", arg);
 			continue;
 		}
+		if (!strcmp(arg, "--grafts-replace-parents=no")) {
+			grafts_replace_parents = 0;
+			continue;
+		}
 		usage(pack_usage);
 	}
 
diff --git a/cache.h b/cache.h
index dbe460c..1a2a3c9 100644
--- a/cache.h
+++ b/cache.h
@@ -566,6 +566,8 @@ enum object_creation_mode {
 
 extern enum object_creation_mode object_creation_mode;
 
+extern int grafts_replace_parents;
+
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
 extern int check_repository_format(void);
diff --git a/commit.c b/commit.c
index a47fb4d..ef8e911 100644
--- a/commit.c
+++ b/commit.c
@@ -262,7 +262,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 		    bufptr[47] != '\n')
 			return error("bad parents in commit %s", sha1_to_hex(item->object.sha1));
 		bufptr += 48;
-		if (graft)
+		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
 			continue;
 		new_parent = lookup_commit(parent);
 		if (new_parent)
diff --git a/environment.c b/environment.c
index 95aa8a6..d478125 100644
--- a/environment.c
+++ b/environment.c
@@ -51,6 +51,7 @@ enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
+int grafts_replace_parents = 1;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/git-repack.sh b/git-repack.sh
index 1bf2394..1bafba8 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -81,7 +81,7 @@ case ",$all_into_one," in
 esac
 
 args="$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
-names=$(git pack-objects --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
+names=$(git pack-objects --grafts-replace-parents=no --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
 if [ -z "$names" ]; then
 	say Nothing new to pack.
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index a4dddb7..f4aa054 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -149,7 +149,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	test_must_fail git show $csha1
 '
 
-test_expect_failure 'objects made unreachable by grafts only are kept' '
+test_expect_success 'objects made unreachable by grafts only are kept' '
 	test_tick &&
 	git commit --allow-empty -m "commit 4" &&
 	H0=$(git rev-parse HEAD) &&
-- 
1.6.4.rc1.289.gf87df
