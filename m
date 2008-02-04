From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fix misuse of prefix_path()
Date: Sun, 03 Feb 2008 23:03:28 -0800
Message-ID: <7v3as9mce7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 08:04:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLvNH-000285-52
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 08:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbYBDHDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 02:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYBDHDl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 02:03:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbYBDHDk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 02:03:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 84D93111E;
	Mon,  4 Feb 2008 02:03:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E0FA3111D;
	Mon,  4 Feb 2008 02:03:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72465>

When DEFAULT_GIT_TEMPLATE_DIR is specified as a relative path,
init-db made it relative to exec_path using prefix_path(), which
is wrong.  prefix_path() is about a file inside the work tree.
There was a similar misuse in config.c that takes relative
ETC_GITCONFIG path.

A convenience function prefix_filename() can concatenate two paths
to form a path that points at somewhere outside the work tree.
Use it in these codepaths instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is probably an oversight in commits leading to
   7f0e39fa and I think if this patch breaks, MinGW port would
   be affected, hence I CC'ed j6t.

   There are similar misuse in builtin-mv.c that needs to be
   fixed.  But git-mv is more broken, independent from this
   prefix_path() issue.  For example, it does not check if src
   and dst are inside work tree, so (do not try this in a
   repository you care about) "git mv compat /tmp/outer-space"
   would throw tracked files in a work tree to outer space and
   then fail without touching the index.  It needs a serious
   overhaul, but because I do not use it myself, the level of
   motivation to fix it myself is very low.  A low hanging
   fruit, that is, for any git hacker wannabes...

 builtin-init-db.c |    3 +--
 config.c          |    5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index e1393b8..e51d447 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -142,8 +142,7 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 		template_dir = DEFAULT_GIT_TEMPLATE_DIR;
 		if (!is_absolute_path(template_dir)) {
 			const char *exec_path = git_exec_path();
-			template_dir = prefix_path(exec_path, strlen(exec_path),
-						   template_dir);
+			template_dir = prefix_filename(exec_path, strlen(exec_path), template_dir);
 		}
 	}
 	strcpy(template_path, template_dir);
diff --git a/config.c b/config.c
index 526a3f4..0b0c9bd 100644
--- a/config.c
+++ b/config.c
@@ -485,8 +485,9 @@ const char *git_etc_gitconfig(void)
 		if (!is_absolute_path(system_wide)) {
 			/* interpret path relative to exec-dir */
 			const char *exec_path = git_exec_path();
-			system_wide = prefix_path(exec_path, strlen(exec_path),
-						system_wide);
+			system_wide = strdup(prefix_filename(exec_path,
+							     strlen(exec_path),
+							     system_wide));
 		}
 	}
 	return system_wide;
-- 
1.5.4.18.gd0b8
