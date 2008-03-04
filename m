From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 1/3] git-pack-objects: Automatically pack annotated tags if object was packed
Date: Mon, 3 Mar 2008 22:27:20 -0500
Message-ID: <20080304032720.GA16462@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 04:28:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNoz-000185-6b
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbYCDD10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756364AbYCDD1Z
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:27:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42970 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbYCDD1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:27:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWNo5-0007hG-IF; Mon, 03 Mar 2008 22:27:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3C27E20FBAE; Mon,  3 Mar 2008 22:27:20 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76026>

The new option "--auto-include-tag" allows the caller to request that
any annotated tag be included into the packfile if the object the tag
references was also included as part of the packfile.

This option can be useful on the server side of a native git transport,
where the server knows what commits it is including into a packfile to
update the client.  If new annotated tags have been introduced then we
can also include them in the packfile, saving the client from needing
to request them through a second connection.

This change only introduces the backend option and provides a test.
Protocol extensions to make this useful in fetch-pack/upload-pack
are still necessary to activate the logic during transport.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Updated with Nico's suggested option name.

 Documentation/git-pack-objects.txt |    5 ++
 builtin-pack-objects.c             |   24 +++++++++-
 t/t5305-auto-include-tag.sh        |   84 ++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100755 t/t5305-auto-include-tag.sh

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 5c1bd3b..53a4513 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -73,6 +73,11 @@ base-name::
 	as if all refs under `$GIT_DIR/refs` are specified to be
 	included.
 
+--auto-include-tag::
+	Automatically include annotated tags if the object they
+	reference was included in the resulting packfile.  This
+	can be useful to send new tags to native git clients.
+
 --window=[N], --depth=[N]::
 	These two options affect how the objects contained in
 	the pack are stored using delta compression.  The
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2799e68..544eb05 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -15,6 +15,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "progress.h"
+#include "refs.h"
 
 #ifdef THREADED_DELTA_SEARCH
 #include "thread-utils.h"
@@ -27,7 +28,8 @@ git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--window=N] [--window-memory=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
-	[--stdout | base-name] [--keep-unreachable] [<ref-list | <object-list]";
+	[--stdout | base-name] [--auto-include-tag] [--keep-unreachable] \n\
+	[<ref-list | <object-list]";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -63,7 +65,7 @@ static struct pack_idx_entry **written_list;
 static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
 static int non_empty;
-static int no_reuse_delta, no_reuse_object, keep_unreachable;
+static int no_reuse_delta, no_reuse_object, keep_unreachable, include_tag;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
@@ -1630,6 +1632,18 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 #define ll_find_deltas(l, s, w, d, p)	find_deltas(l, &s, w, d, p)
 #endif
 
+static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	unsigned char peeled[20];
+
+	if (!prefixcmp(path, "refs/tags/") && /* is a tag? */
+	    !peel_ref(path, peeled)        && /* peelable? */
+	    !is_null_sha1(peeled)          && /* annotated tag? */
+	    locate_object_entry(peeled))      /* object packed? */
+		add_object_entry(sha1, OBJ_TAG, NULL, 0);
+	return 0;
+}
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
@@ -2033,6 +2047,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			keep_unreachable = 1;
 			continue;
 		}
+		if (!strcmp("--auto-include-tag", arg)) {
+			include_tag = 1;
+			continue;
+		}
 		if (!strcmp("--unpacked", arg) ||
 		    !prefixcmp(arg, "--unpacked=") ||
 		    !strcmp("--reflog", arg) ||
@@ -2109,6 +2127,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		rp_av[rp_ac] = NULL;
 		get_object_list(rp_ac, rp_av);
 	}
+	if (include_tag && nr_result)
+		for_each_ref(add_ref_tag, NULL);
 	stop_progress(&progress_state);
 
 	if (non_empty && !nr_result)
diff --git a/t/t5305-auto-include-tag.sh b/t/t5305-auto-include-tag.sh
new file mode 100755
index 0000000..2c92c25
--- /dev/null
+++ b/t/t5305-auto-include-tag.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='git-pack-object --auto-include-tag'
+. ./test-lib.sh
+
+TRASH=`pwd`
+
+test_expect_success setup '
+	echo c >d &&
+	git update-index --add d &&
+	tree=`git write-tree` &&
+	commit=`git commit-tree $tree </dev/null` &&
+	echo "object $commit" >sig &&
+	echo "type commit" >>sig &&
+	echo "tag mytag" >>sig &&
+	echo "tagger $(git var GIT_COMMITTER_IDENT)" >>sig &&
+	echo >>sig &&
+	echo "our test tag" >>sig &&
+	tag=`git mktag <sig` &&
+	rm d sig &&
+	git update-ref refs/tags/mytag $tag && {
+		echo $tree &&
+		echo $commit &&
+		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+	} >obj-list
+'
+
+rm -rf clone.git
+test_expect_success 'pack without --auto-include-tag' '
+	packname_1=$(git pack-objects \
+		--window=0 \
+		test-1 <obj-list)
+'
+
+test_expect_success 'unpack objects' '
+	(
+		GIT_DIR=clone.git &&
+		export GIT_DIR &&
+		git init &&
+		git unpack-objects -n <test-1-${packname_1}.pack &&
+		git unpack-objects <test-1-${packname_1}.pack
+	)
+'
+
+test_expect_success 'check unpacked result (have commit, no tag)' '
+	git rev-list --objects $commit >list.expect &&
+	(
+		GIT_DIR=clone.git &&
+		export GIT_DIR &&
+		test_must_fail git cat-file -e $tag &&
+		git rev-list --objects $commit
+	) >list.actual &&
+	git diff list.expect list.actual
+'
+
+rm -rf clone.git
+test_expect_success 'pack with --auto-include-tag' '
+	packname_1=$(git pack-objects \
+		--window=0 \
+		--auto-include-tag \
+		test-2 <obj-list)
+'
+
+test_expect_success 'unpack objects' '
+	(
+		GIT_DIR=clone.git &&
+		export GIT_DIR &&
+		git init &&
+		git unpack-objects -n <test-2-${packname_1}.pack &&
+		git unpack-objects <test-2-${packname_1}.pack
+	)
+'
+
+test_expect_success 'check unpacked result (have commit, have tag)' '
+	git rev-list --objects mytag >list.expect &&
+	(
+		GIT_DIR=clone.git &&
+		export GIT_DIR &&
+		git rev-list --objects $tag
+	) >list.actual &&
+	git diff list.expect list.actual
+'
+
+test_done
-- 
1.5.4.3.529.gb25fb

