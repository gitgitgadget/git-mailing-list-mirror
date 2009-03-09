From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Use a common function to get the pretty name of refs
Date: Sun, 8 Mar 2009 21:06:05 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903082104410.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:07:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgTxw-0001Qc-F1
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbZCIBGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbZCIBGK
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:06:10 -0400
Received: from iabervon.org ([66.92.72.58]:43451 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbZCIBGH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:06:07 -0400
Received: (qmail 4832 invoked by uid 1000); 9 Mar 2009 01:06:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2009 01:06:05 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112658>

The result should be consistent between fetch and push, so we ought to
use the same code in both cases, even though it's short.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch.c     |    6 +-----
 builtin-send-pack.c |   10 ----------
 refs.c              |   10 ++++++++++
 refs.h              |    2 ++
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 1e4a3d9..f3bdeda 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -197,11 +197,7 @@ static int update_local_ref(struct ref *ref,
 	struct commit *current = NULL, *updated;
 	enum object_type type;
 	struct branch *current_branch = branch_get(NULL);
-	const char *pretty_ref = ref->name + (
-		!prefixcmp(ref->name, "refs/heads/") ? 11 :
-		!prefixcmp(ref->name, "refs/tags/") ? 10 :
-		!prefixcmp(ref->name, "refs/remotes/") ? 13 :
-		0);
+	const char *pretty_ref = prettify_ref(ref);
 
 	*display = 0;
 	type = sha1_object_info(ref->new_sha1, NULL);
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 9072905..43b89ec 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -172,16 +172,6 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 	}
 }
 
-static const char *prettify_ref(const struct ref *ref)
-{
-	const char *name = ref->name;
-	return name + (
-		!prefixcmp(name, "refs/heads/") ? 11 :
-		!prefixcmp(name, "refs/tags/") ? 10 :
-		!prefixcmp(name, "refs/remotes/") ? 13 :
-		0);
-}
-
 #define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
 static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)
diff --git a/refs.c b/refs.c
index b2a37e1..8f968b5 100644
--- a/refs.c
+++ b/refs.c
@@ -736,6 +736,16 @@ int check_ref_format(const char *ref)
 	}
 }
 
+const char *prettify_ref(const struct ref *ref)
+{
+	const char *name = ref->name;
+	return name + (
+		!prefixcmp(name, "refs/heads/") ? 11 :
+		!prefixcmp(name, "refs/tags/") ? 10 :
+		!prefixcmp(name, "refs/remotes/") ? 13 :
+		0);
+}
+
 const char *ref_rev_parse_rules[] = {
 	"%.*s",
 	"refs/%.*s",
diff --git a/refs.h b/refs.h
index 29bdcec..68c2d16 100644
--- a/refs.h
+++ b/refs.h
@@ -79,6 +79,8 @@ extern int for_each_reflog(each_ref_fn, void *);
 #define CHECK_REF_FORMAT_WILDCARD (-3)
 extern int check_ref_format(const char *target);
 
+extern const char *prettify_ref(const struct ref *ref);
+
 /** rename ref, return 0 on success **/
 extern int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
-- 
1.6.1.286.gd33a4.dirty
