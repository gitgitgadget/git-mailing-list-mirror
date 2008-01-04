From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-clean: make "Would remove ..." path relative to cwd again
Date: Thu, 03 Jan 2008 20:47:50 -0800
Message-ID: <7vmyrmmc21.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 05:48:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAeTy-0003ns-MX
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 05:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbYADEsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 23:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbYADEsG
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 23:48:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbYADEsF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 23:48:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ED47471D;
	Thu,  3 Jan 2008 23:48:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 702A1471C;
	Thu,  3 Jan 2008 23:47:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69548>

The rewrite changed the output to use the path relative to the
top of the work tree without a good reason.  This fixes it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-clean.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index ae30d4e..6cad8ea 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -34,6 +34,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	const char *path, *base;
 	static const char **pathspec;
+	int prefix_offset = 0;
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet),
@@ -71,6 +72,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
+	if (prefix)
+		prefix_offset = strlen(prefix);
 	pathspec = get_pathspec(prefix, argv);
 	read_cache();
 
@@ -132,26 +135,32 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
 			if (show_only && (remove_directories || matches)) {
-				printf("Would remove %s\n", directory.buf);
+				printf("Would remove %s\n",
+				       directory.buf + prefix_offset);
 			} else if (quiet && (remove_directories || matches)) {
 				remove_dir_recursively(&directory, 0);
 			} else if (remove_directories || matches) {
-				printf("Removing %s\n", directory.buf);
+				printf("Removing %s\n",
+				       directory.buf + prefix_offset);
 				remove_dir_recursively(&directory, 0);
 			} else if (show_only) {
-				printf("Would not remove %s\n", directory.buf);
+				printf("Would not remove %s\n",
+				       directory.buf + prefix_offset);
 			} else {
-				printf("Not removing %s\n", directory.buf);
+				printf("Not removing %s\n",
+				       directory.buf + prefix_offset);
 			}
 			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
 			if (show_only) {
-				printf("Would remove %s\n", ent->name);
+				printf("Would remove %s\n",
+				       ent->name + prefix_offset);
 				continue;
 			} else if (!quiet) {
-				printf("Removing %s\n", ent->name);
+				printf("Removing %s\n",
+				       ent->name + prefix_offset);
 			}
 			unlink(ent->name);
 		}
-- 
1.5.4.rc2.17.g257f
