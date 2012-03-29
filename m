From: William Strecker-Kellogg <willsk@bnl.gov>
Subject: [PATCH] Make http-backend REMOTE_USER configurable
Date: Thu, 29 Mar 2012 15:58:59 -0400
Message-ID: <1333051139-14262-1-git-send-email-willsk@bnl.gov>
Cc: William Strecker-Kellogg <willsk@bnl.gov>, spearce@spearce.org
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 22:11:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDLhA-0002ws-W7
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 22:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759662Ab2C2ULj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 16:11:39 -0400
Received: from smtpgw.bnl.gov ([130.199.3.132]:62307 "EHLO smtpgw.bnl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311Ab2C2ULh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 16:11:37 -0400
X-Greylist: delayed 734 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Mar 2012 16:11:37 EDT
X-BNL-policy-q: 
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvwEAOG+dE+CxzYH/2dsb2JhbABEuRSBB4I3UoE+E4gKu1CRDQSfMYZegwM
X-IronPort-AV: E=Sophos;i="4.75,669,1330923600"; 
   d="scan'208";a="175094254"
Received: from rcf.rhic.bnl.gov ([130.199.54.7])
  by smtpgw.sec.bnl.local with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Mar 2012 15:59:02 -0400
Received: from hobbes.racf.bnl.gov (hobbes.racf.bnl.gov [130.199.80.88])
	by rcf.rhic.bnl.gov (8.13.8/8.13.8) with ESMTP id q2TJx2uY027188;
	Thu, 29 Mar 2012 15:59:02 -0400
X-Mailer: git-send-email 1.7.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194290>

The http-backend looks at $REMOTE_USER and sets $GIT_COMMITTER_NAME to
that for use in the hooks. At our site we have a third party
authentication module for our proxy (Shibboleth) which sets an alternative
environment variable that our backend sees instead of REMOTE USER.

This patch adds the config option http.remoteuser which changes what
environment variable is inspected by the http-backend code (it defaults
to REMOTE_USER).

Reported-by: Jason Smith <smithj4@bnl.gov>
Tested-by: William Strecker-Kellogg <willsk@bnl.gov>
Signed-off-by: William Strecker-Kellogg <willsk@bnl.gov>
---

I do not know if anyone else may find this useful, but FWIW, this works
for us. It may even be a good idea to add the ability to overwrite other
default CGI environment variables, although I can't think of any other
ones at the moment.


 Documentation/git-http-backend.txt |   14 ++++++++++----
 http-backend.c                     |   13 +++++++++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index f4e0741..b320a45 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -42,6 +42,10 @@ http.getanyfile::
 	It is enabled by default, but a repository can disable it
 	by setting this configuration item to `false`.
 
+http.remoteuser::
+	This setting, if present, changes what environment variable is inspected
+	to determine the remote user (the default is "REMOTE_USER").
+
 http.uploadpack::
 	This serves 'git fetch-pack' and 'git ls-remote' clients.
 	It is enabled by default, but a repository can disable it
@@ -175,10 +179,12 @@ The GIT_HTTP_EXPORT_ALL environmental variable may be passed to
 'git-http-backend' to bypass the check for the "git-daemon-export-ok"
 file in each repository before allowing export of that repository.
 
-The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
-GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
-ensuring that any reflogs created by 'git-receive-pack' contain some
-identifying information of the remote user who performed the push.
+The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' (or
+if http.remoteuser is present it sets it to $\{http.remoteuser\})
+and GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
+ensuring that any reflogs created by 'git-receive-pack' contain
+some identifying information of the remote user who performed the
+push.
 
 All CGI environment variables are available to each of the hooks
 invoked by the 'git-receive-pack'.
diff --git a/http-backend.c b/http-backend.c
index 869d515..69756f0 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -11,6 +11,7 @@
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
 static const char last_modified[] = "Last-Modified";
+static char *remoteuser = "REMOTE_USER";
 static int getanyfile = 1;
 
 static struct string_list *query_params;
@@ -225,6 +226,14 @@ static int http_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if(!strcmp(var, "http.remoteuser")) {
+		char *tmp;
+		if(git_config_string(&tmp, var, value) == 0) {
+			remoteuser = tmp;
+		}
+		return 0;
+	}
+
 	if (!prefixcmp(var, "http.")) {
 		int i;
 
@@ -261,7 +270,7 @@ static struct rpc_service *select_service(const char *name)
 		forbidden("Unsupported service: '%s'", name);
 
 	if (svc->enabled < 0) {
-		const char *user = getenv("REMOTE_USER");
+		const char *user = getenv(remoteuser);
 		svc->enabled = (user && *user) ? 1 : 0;
 	}
 	if (!svc->enabled)
@@ -315,7 +324,7 @@ done:
 static void run_service(const char **argv)
 {
 	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
-	const char *user = getenv("REMOTE_USER");
+	const char *user = getenv(remoteuser);
 	const char *host = getenv("REMOTE_ADDR");
 	char *env[3];
 	struct strbuf buf = STRBUF_INIT;
-- 
1.7.7.6
