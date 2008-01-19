From: =?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
Subject: [PATCH] http-push and http-fetch: handle URLs without leading /
Date: Sat, 19 Jan 2008 16:22:50 +0100
Message-ID: <1200756171-11696-4-git-send-email-gb@gbarbier.org>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
 <1200756171-11696-2-git-send-email-gb@gbarbier.org>
 <1200756171-11696-3-git-send-email-gb@gbarbier.org>
Cc: gitster@pobox.com,
	=?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 16:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFXc-0007U3-Ue
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760033AbYASPXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 10:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759844AbYASPW7
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:22:59 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48549 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759386AbYASPWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:22:55 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ACFE61AB327;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
Received: from localhost.localdomain (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8C8FF1AB319;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc3.54.g4b665-dirty
In-Reply-To: <1200756171-11696-3-git-send-email-gb@gbarbier.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71112>

Since HTTP/302 is not handled in the git code calling curl, URLs without
leading / used to lead to frozen git-fetch or git-push with no error message.

Furthermore, http-push freeze forces the user to interrupt it (^C) and
therefore to leave a dandling webdav lock that makes the remote repository
un-pushable for 10 minutes.

The patch does not make curl calls handle HTTP/302 but instead adds a / at
the end of URLs that does not have it yet.
---
 builtin-http-fetch.c |   10 ++++++++++
 http-push.c          |   11 +++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/builtin-http-fetch.c b/builtin-http-fetch.c
index 4a50dbd..3c1ed08 100644
--- a/builtin-http-fetch.c
+++ b/builtin-http-fetch.c
@@ -9,6 +9,7 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 	const char **write_ref = NULL;
 	char **commit_id;
 	const char *url;
+	char *rewritten_url = NULL;
 	int arg = 1;
 	int rc = 0;
 	int get_tree = 0;
@@ -51,6 +52,12 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 		commits = 1;
 	}
 	url = argv[arg];
+        if (url && url[strlen(url)-1] != '/') {
+                rewritten_url = malloc(strlen(url)+2);
+                strcpy(rewritten_url, url);
+                strcat(rewritten_url, "/");
+                url = rewritten_url;
+        }
 
 	walker = get_http_walker(url);
 	walker->get_tree = get_tree;
@@ -73,5 +80,8 @@ int cmd_http_fetch(int argc, const char **argv, const char *prefix)
 
 	walker_free(walker);
 
+	if (rewritten_url)
+		free(rewritten_url);
+
 	return rc;
 }
diff --git a/http-push.c b/http-push.c
index c984d84..2c27105 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2161,6 +2161,7 @@ int main(int argc, char **argv)
 	int i;
 	int new_refs;
 	struct ref *ref;
+	char *rewritten_url = NULL;
 
 	setup_git_directory();
 
@@ -2228,6 +2229,14 @@ int main(int argc, char **argv)
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
+	if (remote->url && remote->url[strlen(remote->url)-1] != '/') {
+		rewritten_url = malloc(strlen(remote->url)+2);
+		strcpy(rewritten_url, remote->url);
+		strcat(rewritten_url, "/");
+		remote->url = rewritten_url;
+		++remote->path_len;
+	}
+
 	if (!http_test_connection(remote->url)) {
 		fprintf(stderr, "Error: cannot access to remote URL (maybe malformed URL, network error or bad credentials)\n");
 		rc = 1;
@@ -2415,6 +2424,8 @@ int main(int argc, char **argv)
 	}
 
  cleanup:
+	if (rewritten_url)
+		free(rewritten_url);
 	if (info_ref_lock)
 		unlock_remote(info_ref_lock);
 	free(remote);
-- 
1.5.4.rc3.52.g9a5bd-dirty
