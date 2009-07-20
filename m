From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH RFC 5/8] clone: refactoring of building the fetch refspec
Date: Mon, 20 Jul 2009 19:49:52 +0200
Message-ID: <1248112195-3761-6-git-send-email-bonzini@gnu.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:51:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSx0y-0005yL-15
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbZGTRuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbZGTRuP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:50:15 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56554 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbZGTRuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:50:13 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSx09-00033H-4f
	for git@vger.kernel.org; Mon, 20 Jul 2009 13:50:13 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123626>

In builtin-clone.c, two variables (src_ref_prefix and branch_top.buf)
were used to represent basically two parts of a refspec.  Since a
refspec is built anyway later, we can drop these variables and
use refspec->dst when we need it.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 builtin-clone.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 552ddf6..345101a 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -349,9 +349,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int dest_exists;
 	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
 	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
-	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
+	struct strbuf reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
-	char *src_ref_prefix = "refs/heads/";
 	int err = 0;
 
 	struct refspec *refspec;
@@ -452,20 +451,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (option_bare) {
 		if (option_mirror)
-			src_ref_prefix = "refs/";
-		strbuf_addstr(&branch_top, src_ref_prefix);
+			fetch_pattern = "+refs/*:refs/*";
+		else
+			fetch_pattern = "+refs/heads/*:refs/heads/*";
 
 		git_config_set("core.bare", "true");
 	} else {
-		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
+		strbuf_addf(&value, "+refs/heads/*:refs/remotes/%s/*:*",
+			    option_origin);
+		fetch_pattern = value.buf;
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
-
 	if (option_mirror || !option_bare) {
 		/* Configure the remote */
 		strbuf_addf(&key, "remote.%s.fetch", option_origin);
-		git_config_set_multivar(key.buf, value.buf, "^$", 0);
+		git_config_set_multivar(key.buf, fetch_pattern, "^$", 0);
 		strbuf_reset(&key);
 
 		if (option_mirror) {
@@ -479,7 +479,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&key);
 	}
 
-	fetch_pattern = value.buf;
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
 
 	strbuf_reset(&value);
@@ -549,7 +548,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				   head_points_at->old_sha1,
 				   NULL, 0, DIE_ON_ERR);
 
-			strbuf_addstr(&head_ref, branch_top.buf);
+			strbuf_addstr(&head_ref, refspec->dst);
+			strbuf_setlen(&head_ref, head_ref.len - 1);
 			strbuf_addstr(&head_ref, "HEAD");
 
 			/* Remote branch link */
@@ -611,7 +611,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	strbuf_release(&reflog_msg);
-	strbuf_release(&branch_top);
 	strbuf_release(&key);
 	strbuf_release(&value);
 	junk_pid = 0;
-- 
1.6.2.5
