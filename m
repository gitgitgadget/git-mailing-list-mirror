From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [RFC/PATCH] apply: parse and act on --irreversible-delete output
Date: Thu,  2 Aug 2012 16:35:48 -0400
Message-ID: <1343939748-12256-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 22:36:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx27t-0004Wq-Mv
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 22:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab2HBUgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 16:36:04 -0400
Received: from mail.windriver.com ([147.11.1.11]:44002 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab2HBUgB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 16:36:01 -0400
Received: from yow-pgortmak-d1.corp.ad.wrs.com (yow-pgortmak-d1.wrs.com [128.224.146.65])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q72Ka0nV002404;
	Thu, 2 Aug 2012 13:36:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202789>

The '-D' or '--irreversible-delete' option of format-patch is
great for sending out patches to mailing lists, where there
is little value in seeing thousands of lines of deleted code.
Attention can then be focused on the changes relating to
the binding of the deleted code (Makefiles, etc).

However the original intent of commit 467ddc14f ("git diff -D: omit
the preimage of deletes") was as follows:

    To prevent such a patch from being applied by mistake, the
    output is designed not to be usable by "git apply" (or GNU "patch");
    it is strictly for human consumption.

The downside of this, is that patches to mailing lists which are
then either managed with patchworks, or dealt with directly by
maintainers, will need manual intervention if they are to be used.

But with the index lines, there is no reason why we can't act
intelligently and automatically on these with "git apply".
If we can unambiguously map what was recorded as the deleted
SHA prefix to the SHA of the matching blob filename in our tree,
then we set the image len to zero which facilitates the delete.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

For a recent use case example, see:
	http://www.spinics.net/lists/netdev/msg206519.html

Could be wrapped in an "am.applyirreversible" if for some reason
global deployment was considered unwise?

 Documentation/diff-options.txt |  5 +++--
 builtin/apply.c                | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index cf4b216..efaaf1c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -328,8 +328,9 @@ endif::git-log[]
 --irreversible-delete::
 	Omit the preimage for deletes, i.e. print only the header but not
 	the diff between the preimage and `/dev/null`. The resulting patch
-	is not meant to be applied with `patch` nor `git apply`; this is
-	solely for people who want to just concentrate on reviewing the
+	is not meant to be applied with `patch` (but can be with `git apply`).
+	This is for people who want to avoid seeing/mailing all the deleted
+	file content, and instead just concentrate on reviewing the
 	text after the change. In addition, the output obviously lack
 	enough information to apply such a patch in reverse, even manually,
 	hence the name of the option.
diff --git a/builtin/apply.c b/builtin/apply.c
index d453c83..363da63 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2933,6 +2933,36 @@ static int apply_fragments(struct image *img, struct patch *patch)
 	if (patch->is_binary)
 		return apply_binary(img, patch);
 
+	/* output from --irreversible-delete (looks like empty file delete) */
+	if (patch->is_delete > 0 && !frag && img->len > 0) {
+		unsigned char file_sha1[20], patch_sha1[20];
+		struct object_context oc;
+
+		if (apply_in_reverse) {
+			error(_("can not reverse an irreversible-delete patch"
+			      "on file '%s'."), name);
+			return -1;
+		}
+
+		strcpy(oc.path, name);
+		if (get_sha1_with_context(patch->old_sha1_prefix,
+		    GET_SHA1_BLOB | GET_SHA1_QUIETLY, patch_sha1, &oc)) {
+			error(_("the deleted SHA prefix of file '%s' (%s), does"
+			      " not seem to exist in this repository."), name,
+			      patch->old_sha1_prefix);
+			return -1;
+		}
+
+		hash_sha1_file(img->buf, img->len, blob_type, file_sha1);
+		if (memcmp(file_sha1, patch_sha1, 20)) {
+			error(_("the delete requested of '%s' (%s), does not"
+			      " match the current file contents."), name,
+			      sha1_to_hex(patch_sha1));
+			return -1;
+		}
+		img->len = 0;
+	}
+
 	while (frag) {
 		nth++;
 		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule, nth)) {
-- 
1.7.12.rc1.dirty
