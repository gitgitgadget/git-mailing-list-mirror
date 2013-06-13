From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] use logical OR (||) instead of binary OR (|) in logical context
Date: Thu, 13 Jun 2013 20:19:44 +0200
Message-ID: <1371147584-31386-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 20:19:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnC7m-00016k-EN
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758918Ab3FMSTu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 14:19:50 -0400
Received: from india601.server4you.de ([85.25.151.105]:59379 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab3FMSTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:19:49 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDA26B.dip0.t-ipconnect.de [79.253.162.107])
	by india601.server4you.de (Postfix) with ESMTPSA id 632B71DA;
	Thu, 13 Jun 2013 20:19:48 +0200 (CEST)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227769>

The compiler can short-circuit the evaluation of conditions strung
together with logical OR operators instead of computing the resulting
bitmask with binary ORs.  More importantly, this patch makes the
intent of the changed code clearer, because the logical context (as
opposed to binary context) becomes immediately obvious.

While we're at it, simplify the check for patch->is_rename in
builtin/apply.c a bit; it can only be 0 or 1, so we don't need a
comparison operator.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/apply.c      | 2 +-
 builtin/ls-files.c   | 8 ++++----
 builtin/merge-base.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 30eefc3..faf8e30 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3525,7 +3525,7 @@ static int check_patch(struct patch *patch)
 		ok_if_exists =3D 0;
=20
 	if (new_name &&
-	    ((0 < patch->is_new) | (0 < patch->is_rename) | patch->is_copy)) =
{
+	    ((0 < patch->is_new) || patch->is_rename || patch->is_copy)) {
 		int err =3D check_to_create(new_name, ok_if_exists);
=20
 		if (err && threeway) {
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2202072..87f3b33 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -219,7 +219,7 @@ static void show_files(struct dir_struct *dir)
 		if (show_killed)
 			show_killed_files(dir);
 	}
-	if (show_cached | show_stage) {
+	if (show_cached || show_stage) {
 		for (i =3D 0; i < active_nr; i++) {
 			struct cache_entry *ce =3D active_cache[i];
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
@@ -233,7 +233,7 @@ static void show_files(struct dir_struct *dir)
 				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
 		}
 	}
-	if (show_deleted | show_modified) {
+	if (show_deleted || show_modified) {
 		for (i =3D 0; i < active_nr; i++) {
 			struct cache_entry *ce =3D active_cache[i];
 			struct stat st;
@@ -571,8 +571,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		die("ls-files --ignored needs some exclude pattern");
=20
 	/* With no flags, we default to showing the cached files */
-	if (!(show_stage | show_deleted | show_others | show_unmerged |
-	      show_killed | show_modified | show_resolve_undo))
+	if (!(show_stage || show_deleted || show_others || show_unmerged ||
+	      show_killed || show_modified || show_resolve_undo))
 		show_cached =3D 1;
=20
 	if (max_prefix)
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 1bc7991..0c4cd2f 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -107,7 +107,7 @@ int cmd_merge_base(int argc, const char **argv, con=
st char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, merge_base_usage,=
 0);
 	if (!octopus && !reduce && argc < 2)
 		usage_with_options(merge_base_usage, options);
-	if (is_ancestor && (show_all | octopus | reduce))
+	if (is_ancestor && (show_all || octopus || reduce))
 		die("--is-ancestor cannot be used with other options");
 	if (is_ancestor)
 		return handle_is_ancestor(argc, argv);
--=20
1.8.3
