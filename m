From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] apply: allow-binary-replacement.
Date: Tue, 15 Nov 2005 15:33:56 -0800
Message-ID: <7vek5hfpuj.fsf@assigned-by-dhcp.cox.net>
References: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 16 00:34:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAJN-0004cf-LN
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVKOXd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVKOXd6
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:33:58 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4774 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932578AbVKOXd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:33:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115233334.RSWC3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 18:33:34 -0500
To: git@vger.kernel.org
In-Reply-To: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 15 Nov 2005 15:32:05 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11968>

A new option, --allow-binary-replacement, is introduced.

When you feed a diff that records full SHA1 name of pre- and
post-image blob on its index line to git-apply with this option,
the post-image blob replaces the path if what you have in the
working tree matches the pre-image _and_ post-image blob is
already available in the object directory.

Later we _might_ want to enhance the diff output to also include
the full binary data of the post-image, to make this more
useful, but this is good enough for local rebasing application.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-apply.txt |   13 +++++++-
 apply.c                     |   72 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 81 insertions(+), 4 deletions(-)

applies-to: 4567363448244862ec2c6c8bd74fc09cd322f153
0d534967c6850288e1a36eae364da700348a77fe
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 6702a18..626e281 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -8,7 +8,7 @@ git-apply - Apply patch on a git index f
 
 SYNOPSIS
 --------
-'git-apply' [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [-z] [<patch>...]
+'git-apply' [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -79,6 +79,17 @@ OPTIONS
 	the result with this option, which would apply the
 	deletion part but not addition part.
 
+--allow-binary-replacement::
+	When applying a patch, which is a git-enhanced patch
+	that was prepared to record the pre- and post-image object
+	name in full, and the path being patched exactly matches
+	the object the patch applies to (i.e. "index" line's
+	pre-image object name is what is in the working tree),
+	and the post-image object is available in the object
+	database, use the post-image object as the patch
+	result.  This allows binary files to be patched in a
+	very limited way.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/apply.c b/apply.c
index 590adc6..cb9a6c0 100644
--- a/apply.c
+++ b/apply.c
@@ -16,6 +16,7 @@
 //  --numstat does numeric diffstat, and doesn't actually apply
 //  --index-info shows the old and new index info for paths if available.
 //
+static int allow_binary_replacement = 0;
 static int check_index = 0;
 static int write_index = 0;
 static int diffstat = 0;
@@ -27,7 +28,7 @@ static int no_add = 0;
 static int show_index_info = 0;
 static int line_termination = '\n';
 static const char apply_usage[] =
-"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [-z] <patch>...";
+"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [-z] <patch>...";
 
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -899,8 +900,12 @@ static int parse_chunk(char *buffer, uns
 			    sizeof(binhdr)-1))
 			patch->is_binary = 1;
 
-		if (patch->is_binary && !apply && !check)
-			;
+		if (patch->is_binary) {
+			if ((!apply && !check) || allow_binary_replacement)
+				;
+			else
+				die("binary patch at line %d; you might want to try --allow-binary-replacement?", linenr);
+		}
 		else
 			die("patch with only garbage at line %d", linenr);
 	}
@@ -1156,6 +1161,63 @@ static int apply_fragments(struct buffer
 {
 	struct fragment *frag = patch->fragments;
 
+	if (patch->is_binary) {
+		unsigned char sha1[20];
+		const char *name = patch->old_name ? patch->old_name : patch->new_name;
+
+		if (!allow_binary_replacement)
+			return error("cannot apply binary patch to '%s' without --allow-binary-replacement", name);
+
+		/* For safety, we require patch index line to contain
+		 * full 40-byte textual SHA1 for old and new, at least for now.
+		 */
+		if (strlen(patch->old_sha1_prefix) != 40 ||
+		    strlen(patch->new_sha1_prefix) != 40 ||
+		    get_sha1_hex(patch->old_sha1_prefix, sha1) ||
+		    get_sha1_hex(patch->new_sha1_prefix, sha1))
+			return error("cannot apply binary patch to '%s' without full index line", name);
+
+		if (patch->old_name) {
+			unsigned char hdr[50];
+			int hdrlen;
+
+			/* See if the old one matches what the patch
+			 * applies to.
+			 */
+			write_sha1_file_prepare(desc->buffer, desc->size,
+						"blob", sha1, hdr, &hdrlen);
+			if (strcmp(sha1_to_hex(sha1), patch->old_sha1_prefix))
+				return error("the patch applies to '%s' (%s), which does not match the current contents.", name, sha1_to_hex(sha1));
+		}
+		else {
+			/* Otherwise, the old one must be empty. */
+			if (desc->size)
+				return error("the patch applies to an empty '%s' but it is not empty", name);
+		}
+
+		/* For now, we do not record post-image data in the patch,
+		 * and require the object already present in the recipient's
+		 * object database.
+		 */
+		if (desc->buffer) {
+			free(desc->buffer);
+			desc->alloc = desc->size = 0;
+		}
+		get_sha1_hex(patch->new_sha1_prefix, sha1);
+
+		if (memcmp(sha1, null_sha1, 20)) {
+			char type[10];
+			unsigned long size;
+
+			desc->buffer = read_sha1_file(sha1, type, &size);
+			if (!desc->buffer)
+				return error("the necessary postimage %s for '%s' does not exist", patch->new_sha1_prefix, name);
+			desc->alloc = desc->size = size;
+		}
+
+		return 0;
+	}
+
 	while (frag) {
 		if (apply_one_fragment(desc, frag) < 0)
 			return error("patch failed: %s:%ld", patch->old_name, frag->oldpos);
@@ -1723,6 +1785,10 @@ int main(int argc, char **argv)
 			diffstat = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--allow-binary-replacement")) {
+			allow_binary_replacement = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--numstat")) {
 			apply = 0;
 			numstat = 1;
---
0.99.9.GIT
