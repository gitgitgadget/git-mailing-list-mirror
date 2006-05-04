From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] binary patch.
Date: Thu, 04 May 2006 16:52:48 -0700
Message-ID: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 05 01:52:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbncv-0002M3-BM
	for gcvg-git@gmane.org; Fri, 05 May 2006 01:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWEDXwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 19:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWEDXwx
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 19:52:53 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36067 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030286AbWEDXww (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 19:52:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504235250.BZTU25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 19:52:50 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19585>

This adds "binary patch" to the diff output and teaches apply
what to do with them.

On the diff generation side, traditionally, we said "Binary
files differ\n" without giving anything other than the preimage
and postimage object name on the index line.  This was good
enough for applying a patch generated from your own repository
(very useful while rebasing), because the postimage would be
available in such a case.  However, this was not useful when the
recipient of such a patch via e-mail were to apply it, even if
the preimage was available.

This patch allows the diff to generate "binary" patch when
operating under --full-index option.  The binary patch follows
the usual extended git diff headers, and looks like this:

	"GIT binary patch\n"
	<length byte><data>"\n"
	...
	"\n"

Each line is prefixed with a "length-byte", whose value is upper
or lowercase alphabet that encodes number of bytes that the data
on the line decodes to (1..52 -- 'A' means 1, 'B' means 2, ...,
'Z' means 26, 'a' means 27, ...).  <data> is 1 or more groups of
5-byte sequence, each of which encodes up to 4 bytes in base85
encoding.  Because 52 / 4 * 5 = 65 and we have the length byte,
an output line is capped to 66 characters.  The payload is the
same diff-delta as we use in the packfiles.

On the consumption side, git-apply now can decode and apply the
binary patch when --allow-binary-replacement is given, the diff
was generated with --full-index, and the receiving repository
has the preimage blob, which is the same condition as it always
required when accepting an "Binary files differ\n" patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile |    2 -
 apply.c  |  232 ++++++++++++++++++++++++++++++++++++++++++++++----------------
 cache.h  |    3 +
 diff.c   |  106 ++++++++++++++++++++++++++--
 4 files changed, 275 insertions(+), 68 deletions(-)

diff --git a/Makefile b/Makefile
index a3f7e92..b6be520 100644
--- a/Makefile
+++ b/Makefile
@@ -205,7 +205,7 @@ DIFF_OBJS = \
 	diffcore-delta.o log-tree.o
 
 LIB_OBJS = \
-	blob.o commit.o connect.o csum-file.o \
+	blob.o commit.o connect.o csum-file.o base85.o \
 	date.o diff-delta.o entry.o exec_cmd.o ident.o index.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
diff --git a/apply.c b/apply.c
index 269210a..e37c4eb 100644
--- a/apply.c
+++ b/apply.c
@@ -10,6 +10,7 @@ #include <fnmatch.h>
 #include "cache.h"
 #include "quote.h"
 #include "blob.h"
+#include "delta.h"
 
 //  --check turns on checking that the working tree matches the
 //    files that are being modified, but doesn't apply the patch
@@ -966,6 +967,70 @@ static inline int metadata_changes(struc
 		 patch->old_mode != patch->new_mode);
 }
 
+static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
+{
+	/* We have read "GIT binary patch\n"; what follows is a
+	 * sequence of 'length-byte' followed by base-85 encoded
+	 * delta data.
+	 *
+	 * Each 5-byte sequence of base-85 encodes up to 4 bytes,
+	 * and we would limit the patch line to 66 characters,
+	 * so one line can fit up to 13 groups that would decode
+	 * to 52 bytes max.  The length byte 'A'-'Z' corresponds
+	 * to 1-26 bytes, and 'a'-'z' corresponds to 27-52 bytes.
+	 * The end of binary is signalled with an empty line.
+	 */
+	int llen, used;
+	struct fragment *fragment;
+	char *delta = NULL;
+
+	patch->is_binary = 1;
+	patch->fragments = fragment = xcalloc(1, sizeof(*fragment));
+	used = 0;
+	while (1) {
+		int byte_length, max_byte_length, newsize;
+		llen = linelen(buffer, size);
+		used += llen;
+		linenr++;
+		if (llen == 1)
+			break;
+		/* Minimum line is "A00000\n" which is 7-byte long,
+		 * and the line length must be multiple of 5 plus 2.
+		 */
+		if ((llen < 7) || (llen-2) % 5)
+			goto corrupt;
+		max_byte_length = (llen - 2) / 5 * 4;
+		byte_length = *buffer;
+		if ('A' <= byte_length && byte_length <= 'Z')
+			byte_length = byte_length - 'A' + 1;
+		else if ('a' <= byte_length && byte_length <= 'z')
+			byte_length = byte_length - 'a' + 27;
+		else
+			goto corrupt;
+		/* if the input length was not multiple of 4, we would
+		 * have filler at the end but the filler should never
+		 * exceed 3 bytes
+		 */
+		if (max_byte_length < byte_length ||
+		    byte_length <= max_byte_length - 4)
+			goto corrupt;
+		newsize = fragment->size + byte_length;
+		delta = xrealloc(delta, newsize);
+		if (decode_85(delta + fragment->size,
+			      buffer + 1,
+			      byte_length))
+			goto corrupt;
+		fragment->size = newsize;
+		buffer += llen;
+		size -= llen;
+	}
+	fragment->patch = delta;
+	return used;
+ corrupt:
+	return error("corrupt binary patch at line %d: %.*s",
+		     linenr-1, llen-1, buffer);
+}
+
 static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 {
 	int hdrsize, patchsize;
@@ -982,19 +1047,34 @@ static int parse_chunk(char *buffer, uns
 			"Files ",
 			NULL,
 		};
+		static const char git_binary[] = "GIT binary patch\n";
 		int i;
 		int hd = hdrsize + offset;
 		unsigned long llen = linelen(buffer + hd, size - hd);
 
-		if (!memcmp(" differ\n", buffer + hd + llen - 8, 8))
+		if (llen == sizeof(git_binary) - 1 &&
+		    !memcmp(git_binary, buffer + hd, llen)) {
+			int used;
+			linenr++;
+			used = parse_binary(buffer + hd + llen,
+					    size - hd - llen, patch);
+			if (used)
+				patchsize = used + llen;
+			else
+				patchsize = 0;
+		}
+		else if (!memcmp(" differ\n", buffer + hd + llen - 8, 8)) {
 			for (i = 0; binhdr[i]; i++) {
 				int len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
+					linenr++;
 					patch->is_binary = 1;
+					patchsize = llen;
 					break;
 				}
 			}
+		}
 
 		/* Empty patch cannot be applied if:
 		 * - it is a binary patch and we do not do binary_replace, or
@@ -1345,76 +1425,108 @@ #endif
 	return offset;
 }
 
-static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
+static int apply_binary(struct buffer_desc *desc, struct patch *patch)
 {
-	struct fragment *frag = patch->fragments;
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
+	unsigned char sha1[20];
+	unsigned char hdr[50];
+	int hdrlen;
 
-	if (patch->is_binary) {
-		unsigned char sha1[20];
+	if (!allow_binary_replacement)
+		return error("cannot apply binary patch to '%s' "
+			     "without --allow-binary-replacement",
+			     name);
 
-		if (!allow_binary_replacement)
-			return error("cannot apply binary patch to '%s' "
-				     "without --allow-binary-replacement",
-				     name);
+	/* For safety, we require patch index line to contain
+	 * full 40-byte textual SHA1 for old and new, at least for now.
+	 */
+	if (strlen(patch->old_sha1_prefix) != 40 ||
+	    strlen(patch->new_sha1_prefix) != 40 ||
+	    get_sha1_hex(patch->old_sha1_prefix, sha1) ||
+	    get_sha1_hex(patch->new_sha1_prefix, sha1))
+		return error("cannot apply binary patch to '%s' "
+			     "without full index line", name);
 
-		/* For safety, we require patch index line to contain
-		 * full 40-byte textual SHA1 for old and new, at least for now.
+	if (patch->old_name) {
+		/* See if the old one matches what the patch
+		 * applies to.
 		 */
-		if (strlen(patch->old_sha1_prefix) != 40 ||
-		    strlen(patch->new_sha1_prefix) != 40 ||
-		    get_sha1_hex(patch->old_sha1_prefix, sha1) ||
-		    get_sha1_hex(patch->new_sha1_prefix, sha1))
-			return error("cannot apply binary patch to '%s' "
-				     "without full index line", name);
-
-		if (patch->old_name) {
-			unsigned char hdr[50];
-			int hdrlen;
-
-			/* See if the old one matches what the patch
-			 * applies to.
-			 */
-			write_sha1_file_prepare(desc->buffer, desc->size,
-						blob_type, sha1, hdr, &hdrlen);
-			if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
-				return error("the patch applies to '%s' (%s), "
-					     "which does not match the "
-					     "current contents.",
-					     name, sha1_to_hex(sha1));
-		}
-		else {
-			/* Otherwise, the old one must be empty. */
-			if (desc->size)
-				return error("the patch applies to an empty "
-					     "'%s' but it is not empty", name);
-		}
+		write_sha1_file_prepare(desc->buffer, desc->size,
+					blob_type, sha1, hdr, &hdrlen);
+		if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
+			return error("the patch applies to '%s' (%s), "
+				     "which does not match the "
+				     "current contents.",
+				     name, sha1_to_hex(sha1));
+	}
+	else {
+		/* Otherwise, the old one must be empty. */
+		if (desc->size)
+			return error("the patch applies to an empty "
+				     "'%s' but it is not empty", name);
+	}
+
+	if (desc->buffer) {
+		free(desc->buffer);
+		desc->alloc = desc->size = 0;
+	}
+	get_sha1_hex(patch->new_sha1_prefix, sha1);
+	if (!memcmp(sha1, null_sha1, 20))
+		return 0; /* deletion patch */
+
+	if (has_sha1_file(sha1)) {
+		char type[10];
+		unsigned long size;
 
-		/* For now, we do not record post-image data in the patch,
-		 * and require the object already present in the recipient's
-		 * object database.
+		desc->buffer = read_sha1_file(sha1, type, &size);
+		if (!desc->buffer)
+			return error("the necessary postimage %s for "
+				     "'%s' cannot be read",
+				     patch->new_sha1_prefix, name);
+		desc->alloc = desc->size = size;
+	}
+	else {
+		char type[10];
+		unsigned long src_size, dst_size;
+		void *src;
+
+		get_sha1_hex(patch->old_sha1_prefix, sha1);
+		src = read_sha1_file(sha1, type, &src_size);
+		if (!src)
+			return error("the necessary preimage %s for "
+				     "'%s' cannot be read",
+				     patch->old_sha1_prefix, name);
+
+		/* patch->fragment->patch has the delta data and
+		 * we should apply it to the preimage.
 		 */
-		if (desc->buffer) {
-			free(desc->buffer);
-			desc->alloc = desc->size = 0;
-		}
-		get_sha1_hex(patch->new_sha1_prefix, sha1);
-
-		if (memcmp(sha1, null_sha1, 20)) {
-			char type[10];
-			unsigned long size;
-
-			desc->buffer = read_sha1_file(sha1, type, &size);
-			if (!desc->buffer)
-				return error("the necessary postimage %s for "
-					     "'%s' does not exist",
-					     patch->new_sha1_prefix, name);
-			desc->alloc = desc->size = size;
-		}
+		desc->buffer = patch_delta(src, src_size,
+					   (void*) patch->fragments->patch,
+					   patch->fragments->size,
+					   &dst_size);
+		if (!desc->buffer)
+			return error("binary patch does not apply to '%s'",
+				     name);
+		desc->size = desc->alloc = dst_size;
 
-		return 0;
+		/* verify that the result matches */
+		write_sha1_file_prepare(desc->buffer, desc->size, blob_type,
+					sha1, hdr, &hdrlen);
+		if (strcmp(sha1_to_hex(sha1), patch->new_sha1_prefix))
+			return error("binary patch to '%s' creates incorrect result", name);
 	}
 
+	return 0;
+}
+
+static int apply_fragments(struct buffer_desc *desc, struct patch *patch)
+{
+	struct fragment *frag = patch->fragments;
+	const char *name = patch->old_name ? patch->old_name : patch->new_name;
+
+	if (patch->is_binary)
+		return apply_binary(desc, patch);
+
 	while (frag) {
 		if (apply_one_fragment(desc, frag) < 0)
 			return error("patch failed: %s:%ld",
diff --git a/cache.h b/cache.h
index 9d0ddcf..2f32f3d 100644
--- a/cache.h
+++ b/cache.h
@@ -363,4 +363,7 @@ extern int receive_keep_pack(int fd[2], 
 /* pager.c */
 extern void setup_pager(void);
 
+/* base85 */
+int decode_85(char *dst, char *line, int linelen);
+
 #endif /* CACHE_H */
diff --git a/diff.c b/diff.c
index c845c87..b14d897 100644
--- a/diff.c
+++ b/diff.c
@@ -8,6 +8,7 @@ #include "cache.h"
 #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "delta.h"
 #include "xdiff-interface.h"
 
 static int use_size_cache;
@@ -391,6 +392,90 @@ static void show_stats(struct diffstat_t
 			total_files, adds, dels);
 }
 
+static void *encode_delta_size(void *data, unsigned long size)
+{
+	unsigned char *cp = data;
+	*cp++ = size;
+	size >>= 7;
+	while (size) {
+		cp[-1] |= 0x80;
+		*cp++ = size;
+		size >>= 7;
+	}
+	return cp;
+}
+
+static void *safe_diff_delta(const unsigned char *src, unsigned long src_size,
+			     const unsigned char *dst, unsigned long dst_size,
+			     unsigned long *delta_size)
+{
+	unsigned long bufsize;
+	unsigned char *data;
+	unsigned char *cp;
+
+	if (src_size && dst_size)
+		return diff_delta(src, src_size, dst, dst_size, delta_size, 0);
+
+	/* diff-delta does not like to do delta with empty, so
+	 * we do that by hand here.  Sigh...
+	 */
+
+	if (!src_size)
+		/* literal copy can be done only 127-byte at a time.
+		 */
+		bufsize = dst_size + (dst_size / 127) + 40;
+	else
+		bufsize = 40;
+	data = xmalloc(bufsize);
+	cp = encode_delta_size(data, src_size);
+	cp = encode_delta_size(cp, dst_size);
+
+	if (dst_size) {
+		/* copy out literally */
+		while (dst_size) {
+			int sz = (127 < dst_size) ? 127 : dst_size;
+			*cp++ = sz;
+			dst_size -= sz;
+			while (sz) {
+				*cp++ = *dst++;
+				sz--;
+			}
+		}
+	}
+	*delta_size = (cp - data);
+	return data;
+}
+
+static void emit_binary_diff(mmfile_t *one, mmfile_t *two)
+{
+	void *delta, *cp;
+	unsigned long delta_size;
+
+	printf("GIT binary patch\n");
+	delta = safe_diff_delta(one->ptr, one->size,
+				two->ptr, two->size,
+				&delta_size);
+	if (!delta)
+		die("unable to generate binary diff");
+
+	/* emit delta encoded in base85 */
+	cp = delta;
+	while (delta_size) {
+		int bytes = (52 < delta_size) ? 52 : delta_size;
+		char line[70];
+		delta_size -= bytes;
+		if (bytes <= 26)
+			line[0] = bytes + 'A' - 1;
+		else
+			line[0] = bytes - 26 + 'a' - 1;
+		encode_85(line + 1, cp, bytes);
+		cp += bytes;
+		puts(line);
+	}
+	printf("\n");
+	free(delta);
+}
+
 #define FIRST_FEW_BYTES 8000
 static int mmfile_is_binary(mmfile_t *mf)
 {
@@ -407,6 +492,7 @@ static void builtin_diff(const char *nam
 			 struct diff_filespec *one,
 			 struct diff_filespec *two,
 			 const char *xfrm_msg,
+			 struct diff_options *o,
 			 int complete_rewrite)
 {
 	mmfile_t mf1, mf2;
@@ -451,8 +537,13 @@ static void builtin_diff(const char *nam
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2))
-		printf("Binary files %s and %s differ\n", lbl[0], lbl[1]);
+	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2)) {
+		if (o->full_index)
+			emit_binary_diff(&mf1, &mf2);
+		else
+			printf("Binary files %s and %s differ\n",
+			       lbl[0], lbl[1]);
+	}
 	else {
 		/* Crazy xdl interfaces.. */
 		const char *diffopts = getenv("GIT_DIFF_OPTS");
@@ -928,6 +1019,7 @@ static void run_diff_cmd(const char *pgm
 			 struct diff_filespec *one,
 			 struct diff_filespec *two,
 			 const char *xfrm_msg,
+			 struct diff_options *o,
 			 int complete_rewrite)
 {
 	if (pgm) {
@@ -937,7 +1029,7 @@ static void run_diff_cmd(const char *pgm
 	}
 	if (one && two)
 		builtin_diff(name, other ? other : name,
-			     one, two, xfrm_msg, complete_rewrite);
+			     one, two, xfrm_msg, o, complete_rewrite);
 	else
 		printf("* Unmerged path %s\n", name);
 }
@@ -971,7 +1063,7 @@ static void run_diff(struct diff_filepai
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
-		run_diff_cmd(pgm, p->one->path, NULL, NULL, NULL, NULL, 0);
+		run_diff_cmd(pgm, p->one->path, NULL, NULL, NULL, NULL, o, 0);
 		return;
 	}
 
@@ -1041,14 +1133,14 @@ static void run_diff(struct diff_filepai
 		 * needs to be split into deletion and creation.
 		 */
 		struct diff_filespec *null = alloc_filespec(two->path);
-		run_diff_cmd(NULL, name, other, one, null, xfrm_msg, 0);
+		run_diff_cmd(NULL, name, other, one, null, xfrm_msg, o, 0);
 		free(null);
 		null = alloc_filespec(one->path);
-		run_diff_cmd(NULL, name, other, null, two, xfrm_msg, 0);
+		run_diff_cmd(NULL, name, other, null, two, xfrm_msg, o, 0);
 		free(null);
 	}
 	else
-		run_diff_cmd(pgm, name, other, one, two, xfrm_msg,
+		run_diff_cmd(pgm, name, other, one, two, xfrm_msg, o,
 			     complete_rewrite);
 
 	free(name_munged);
-- 
1.3.1.g25a9
