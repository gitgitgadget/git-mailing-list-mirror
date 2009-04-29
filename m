From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] diff -c -p: do not die on submodules
Date: Wed, 29 Apr 2009 13:26:52 -0700
Message-ID: <7vy6tj8aur.fsf_-_@gitster.siamese.dyndns.org>
References: <gt7err$3m4$1@ger.gmane.org>
 <7v4ow8my1u.fsf@gitster.siamese.dyndns.org> <20090428211257.GA31191@pvv.org>
 <20090429084209.GA24064@localhost>
 <7v8wljcmvk.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:27:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzGN4-0002Ls-MI
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958AbZD2U1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbZD2U1B
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:27:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbZD2U1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:27:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 74C1313E20;
	Wed, 29 Apr 2009 16:26:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2A42113E1B; Wed,
 29 Apr 2009 16:26:53 -0400 (EDT)
In-Reply-To: <7v8wljcmvk.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Wed, 29 Apr 2009 11:53:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1747D1E6-34FC-11DE-9C43-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117942>

The combine diff logic knew only about blobs (and their checked-out form
in the work tree, either regular files or symlinks), and barfed when fed
submodules.  This "externalizes" gitlinks in the same way as the normal
patch generation codepath does (i.e. "Subproject commit Xxx\n") to fix the
issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 This is a re-roll of the earlier "[PATCH] Teach gitlinks to combine-diff",
 meant to apply to maint-1.6.0 and later.

 combine-diff.c            |   38 ++++++++++++++++++++++++++------------
 t/t4027-diff-submodule.sh |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index aa9d79e..f617e9d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "log-tree.h"
+#include "refs.h"
 
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
@@ -90,18 +91,24 @@ struct sline {
 	unsigned long *p_lno;
 };
 
-static char *grab_blob(const unsigned char *sha1, unsigned long *size)
+static char *grab_blob(const unsigned char *sha1, unsigned int mode, unsigned long *size)
 {
 	char *blob;
 	enum object_type type;
-	if (is_null_sha1(sha1)) {
+
+	if (S_ISGITLINK(mode)) {
+		blob = xmalloc(100);
+		*size = snprintf(blob, 100,
+				 "Subproject commit %s\n", sha1_to_hex(sha1));
+	} else if (is_null_sha1(sha1)) {
 		/* deleted blob */
 		*size = 0;
 		return xcalloc(1, 1);
+	} else {
+		blob = read_sha1_file(sha1, &type, size);
+		if (type != OBJ_BLOB)
+			die("object '%s' is not a blob!", sha1_to_hex(sha1));
 	}
-	blob = read_sha1_file(sha1, &type, size);
-	if (type != OBJ_BLOB)
-		die("object '%s' is not a blob!", sha1_to_hex(sha1));
 	return blob;
 }
 
@@ -197,7 +204,8 @@ static void consume_line(void *state_, char *line, unsigned long len)
 	}
 }
 
-static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
+static void combine_diff(const unsigned char *parent, unsigned int mode,
+			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent)
 {
@@ -213,7 +221,7 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	if (!cnt)
 		return; /* result deleted */
 
-	parent_file.ptr = grab_blob(parent, &sz);
+	parent_file.ptr = grab_blob(parent, mode, &sz);
 	parent_file.size = sz;
 	xpp.flags = XDF_NEED_MINIMAL;
 	memset(&xecfg, 0, sizeof(xecfg));
@@ -692,7 +700,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	context = opt->context;
 	/* Read the result of merge first */
 	if (!working_tree_file)
-		result = grab_blob(elem->sha1, &result_size);
+		result = grab_blob(elem->sha1, elem->mode, &result_size);
 	else {
 		/* Used by diff-tree to read from the working tree */
 		struct stat st;
@@ -712,9 +720,13 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			}
 			result[len] = 0;
 			elem->mode = canon_mode(st.st_mode);
-		}
-		else if (0 <= (fd = open(elem->path, O_RDONLY)) &&
-			 !fstat(fd, &st)) {
+		} else if (S_ISDIR(st.st_mode)) {
+			unsigned char sha1[20];
+			if (resolve_gitlink_ref(elem->path, "HEAD", sha1) < 0)
+				result = grab_blob(elem->sha1, elem->mode, &result_size);
+			else
+				result = grab_blob(sha1, elem->mode, &result_size);
+		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
 			size_t len = xsize_t(st.st_size);
 			ssize_t done;
 			int is_file, i;
@@ -807,7 +819,9 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			}
 		}
 		if (i <= j)
-			combine_diff(elem->parent[i].sha1, &result_file, sline,
+			combine_diff(elem->parent[i].sha1,
+				     elem->parent[i].mode,
+				     &result_file, sline,
 				     cnt, i, num_parent);
 		if (elem->parent[i].mode != elem->mode)
 			mode_differs = 1;
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index ba6679c..718efe8 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -57,4 +57,43 @@ test_expect_success 'git diff (empty submodule dir)' '
 	test_cmp empty actual.empty
 '
 
+test_expect_success 'conflicted submodule setup' '
+
+	# 39 efs
+	c=fffffffffffffffffffffffffffffffffffffff
+	(
+		echo "000000 $_z40 0	sub"
+		echo "160000 1$c 1	sub"
+		echo "160000 2$c 2	sub"
+		echo "160000 3$c 3	sub"
+	) | git update-index --index-info &&
+	echo >expect.nosub '\''diff --cc sub
+index 2ffffff,3ffffff..0000000
+--- a/sub
++++ b/sub
+@@@ -1,1 -1,1 +1,1 @@@
+- Subproject commit 2fffffffffffffffffffffffffffffffffffffff
+ -Subproject commit 3fffffffffffffffffffffffffffffffffffffff
+++Subproject commit 0000000000000000000000000000000000000000'\'' &&
+
+	hh=$(git rev-parse HEAD) &&
+	sed -e "s/$_z40/$hh/" expect.nosub >expect.withsub
+
+'
+
+test_expect_success 'combined (empty submodule)' '
+	rm -fr sub && mkdir sub &&
+	git diff >actual &&
+	test_cmp expect.nosub actual
+'
+
+test_expect_success 'combined (with submodule)' '
+	rm -fr sub &&
+	git clone --no-checkout . sub &&
+	git diff >actual &&
+	test_cmp expect.withsub actual
+'
+
+
+
 test_done
-- 
1.6.3.rc3.16.gb37759
