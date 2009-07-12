From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 5/6] move deletion of merge configuration to branch.c
Date: Sun, 12 Jul 2009 14:17:32 +0200
Message-ID: <1247401053-20429-6-git-send-email-bonzini@gnu.org>
References: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 14:18:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPy0b-0001PY-HX
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 14:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbZGLMRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 08:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbZGLMRv
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 08:17:51 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60355 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZGLMRs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 08:17:48 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MPy03-0003Ua-Up
	for git@vger.kernel.org; Sun, 12 Jul 2009 08:17:48 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123146>

In the next step, deletion of merge configuration will become more
complex, so we move it into a separate function.  Since the
configuration is installed with a function in branch.c, I'm placing
deletion there as well.

At the same time, the interface is changed to get the full ref name
including refs/heads/.  This makes no big difference for the caller.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 branch.c         |   11 +++++++++++
 branch.h         |    2 ++
 builtin-branch.c |    6 +-----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/branch.c b/branch.c
index e427721..8d3e8d8 100644
--- a/branch.c
+++ b/branch.c
@@ -85,6 +85,17 @@ void install_branch_config(int flag, const char *local, struct remote *remote,
 	strbuf_release(&key);
 }
 
+void delete_branch_config (const char *name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	if (prefixcmp(name, "refs/heads/"))
+		return;
+	strbuf_addf(&buf, "branch.%s", name + 11);
+	if (git_config_rename_section(buf.buf, NULL) < 0)
+		warning("Update of config-file failed");
+	strbuf_release(&buf);
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
diff --git a/branch.h b/branch.h
index f7c02c9..efa4506 100644
--- a/branch.h
+++ b/branch.h
@@ -21,6 +21,8 @@ void create_branch(const char *head, const char *name, const char *start_name,
  */
 void remove_branch_state(void);
 
+void delete_branch_config(const char *name);
+
 /*
  * Configure local branch "local" to merge remote branch "remote"
  * taken from origin "origin".
diff --git a/builtin-branch.c b/builtin-branch.c
index f045e16..4469ea9 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -166,14 +166,10 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			      bname.buf);
 			ret = 1;
 		} else {
-			struct strbuf buf = STRBUF_INIT;
 			printf("Deleted %sbranch %s (was %s).\n", remote,
 			       bname.buf,
 			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
-			strbuf_addf(&buf, "branch.%s", bname.buf);
-			if (git_config_rename_section(buf.buf, NULL) < 0)
-				warning("Update of config-file failed");
-			strbuf_release(&buf);
+			delete_branch_config (name);
 		}
 	}
 
-- 
1.6.2.5
