From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Teach gitlinks to combine-diff
Date: Wed, 29 Apr 2009 11:53:35 -0700
Message-ID: <7v8wljcmvk.fsf_-_@gitster.siamese.dyndns.org>
References: <gt7err$3m4$1@ger.gmane.org>
 <7v4ow8my1u.fsf@gitster.siamese.dyndns.org> <20090428211257.GA31191@pvv.org>
 <20090429084209.GA24064@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:53:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEuo-0002Jn-3m
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbZD2Sxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbZD2Sxq
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:53:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZD2Sxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:53:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1CD67AEF2D;
	Wed, 29 Apr 2009 14:53:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 34633AEF2C; Wed,
 29 Apr 2009 14:53:36 -0400 (EDT)
In-Reply-To: <20090429084209.GA24064@localhost> (Clemens Buchacher's message
 of "Wed, 29 Apr 2009 10:42:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 102D6D6A-34EF-11DE-A4F8-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117912>

The combine diff logic knew only about blobs (and their checked-out form
in the work tree, either regular files or symlinks), and barfed when fed
submodules.  This "externalizes" gitlinks in the same way as the normal
patch generation codepath does (i.e. "Subproject commit Xxx\n") to fix the
issue.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 I think we should share the implementation betweeen grab_blob() and
 diff.c::diff_populate_gitlink() to keep their submodule representation
 the same, but I am doing this as a "fix" patch and I am lazy...

 combine-diff.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 066ce84..0f192e1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "log-tree.h"
+#include "refs.h"
 
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
@@ -90,7 +91,7 @@ struct sline {
 	unsigned long *p_lno;
 };
 
-static char *grab_blob(const unsigned char *sha1, unsigned long *size)
+static char *grab_blob(const unsigned char *sha1, unsigned int mode, unsigned long *size)
 {
 	char *blob;
 	enum object_type type;
@@ -98,10 +99,15 @@ static char *grab_blob(const unsigned char *sha1, unsigned long *size)
 		/* deleted blob */
 		*size = 0;
 		return xcalloc(1, 1);
+	} else if (S_ISGITLINK(mode)) {
+		blob = xmalloc(100);
+		*size = snprintf(blob, 100,
+				 "Subproject commit %s\n", sha1_to_hex(sha1));
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
 
@@ -195,7 +201,8 @@ static void consume_line(void *state_, char *line, unsigned long len)
 	}
 }
 
-static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
+static void combine_diff(const unsigned char *parent, unsigned int mode,
+			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent)
 {
@@ -211,7 +218,7 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	if (!cnt)
 		return; /* result deleted */
 
-	parent_file.ptr = grab_blob(parent, &sz);
+	parent_file.ptr = grab_blob(parent, mode, &sz);
 	parent_file.size = sz;
 	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = XDF_NEED_MINIMAL;
@@ -692,7 +699,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 	/* Read the result of merge first */
 	if (!working_tree_file)
-		result = grab_blob(elem->sha1, &result_size);
+		result = grab_blob(elem->sha1, elem->mode, &result_size);
 	else {
 		/* Used by diff-tree to read from the working tree */
 		struct stat st;
@@ -712,6 +719,12 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			result_size = buf.len;
 			result = strbuf_detach(&buf, NULL);
 			elem->mode = canon_mode(st.st_mode);
+		} else if (S_ISDIR(st.st_mode)) {
+			unsigned char sha1[20];
+			if (resolve_gitlink_ref(elem->path, "HEAD", sha1) < 0)
+				result = grab_blob(elem->sha1, elem->mode, &result_size);
+			else
+				result = grab_blob(sha1, elem->mode, &result_size);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
 			size_t len = xsize_t(st.st_size);
 			ssize_t done;
@@ -804,7 +817,9 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
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
