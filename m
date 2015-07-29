From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/6] clone: fix hostname parsing when guessing dir
Date: Wed, 29 Jul 2015 17:51:15 +0200
Message-ID: <1438185076-28870-6-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
Cc: peff@peff.net, pclouds@gmail.com, gitster@pobox.com,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTdl-0000rQ-5y
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbbG2Pv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:51:29 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51146 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753107AbbG2Pv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 11:51:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id CF25B20EA8
	for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:51:27 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 29 Jul 2015 11:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=OnFv
	vsAYFHNUpD7Ri79LNVtkBdI=; b=ffBuRb9ZJmKdLWVxa0vN/s5bJBsu2Wg0hx7R
	Nr2ZOgQq9aNG5axzBy63KqUmQsESXdkCiBuNJjMpriwpjSGK9t3pg31iFe7r1fxS
	F4hDAsjq0C2v5eB7tFu/OeutreXqVbkkBjj4vLXjG1eO57wOcusnCZ2qRenyZTku
	7/ldu88=
X-Sasl-enc: ltUV1jq2m+v0IWsh6b0uQJ81IQqHLaEBs4FYm+YlBHYn 1438185087
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 66F366800BE;
	Wed, 29 Jul 2015 11:51:27 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438185076-28870-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274901>

We fail to guess a sensible directory name for a newly cloned
repository when the path component of the URL is empty. E.g.
cloning a repository 'ssh://user:password@example.com/' we create
a directory 'password@example.com' for the clone.

Fix this by using parse_connect_url to split host and path
components and explicitly checking whether we need to fall back
to the hostname for guessing a directory name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 73 +++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a72ff7e..4547729 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -9,6 +9,7 @@
  */
 
 #include "builtin.h"
+#include "connect.h"
 #include "lockfile.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
@@ -147,34 +148,62 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
 	const char *end = repo + strlen(repo), *start;
+	char *host, *path;
 	size_t len;
 	char *dir;
 
+	parse_connect_url(repo, &host, &path);
 	/*
-	 * Strip trailing spaces, slashes and /.git
+	 * If the path component of the URL is empty (e.g. it is
+	 * empty or only contains a '/') we fall back to the host
+	 * name.
 	 */
-	while (repo < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
-		end--;
-	if (end - repo > 5 && is_dir_sep(end[-5]) &&
-	    !strncmp(end - 4, ".git", 4)) {
-		end -= 5;
-		while (repo < end && is_dir_sep(end[-1]))
+	if (!path || !*path || !strcmp(path, "/")) {
+		if (*host == '\0')
+			die("No directory name could be guessed.\n"
+				"Please specify a directory on the command line");
+		/*
+		 * Strip authentication information if it exists.
+		 */
+		start = strchr(host, '@');
+		if (start)
+			start++;
+		else
+			start = host;
+		/*
+		 * Strip port if it exitsts.
+		 */
+		end = strchr(start, ':');
+		if (!end)
+			end = start + strlen(start);
+		len = end - start;
+	} else {
+		/*
+		 * Strip trailing spaces, slashes and /.git
+		 */
+		while (repo < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
 			end--;
-	}
+		if (end - repo > 5 && is_dir_sep(end[-5]) &&
+			!strncmp(end - 4, ".git", 4)) {
+			end -= 5;
+			while (repo < end && is_dir_sep(end[-1]))
+				end--;
+		}
 
-	/*
-	 * Find last component, but be prepared that repo could have
-	 * the form  "remote.example.com:foo.git", i.e. no slash
-	 * in the directory part.
-	 */
-	start = end;
-	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
-		start--;
+		/*
+		 * Find last component, but be prepared that repo could have
+		 * the form  "remote.example.com:foo.git", i.e. no slash
+		 * in the directory part.
+		 */
+		start = end;
+		while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
+			start--;
 
-	/*
-	 * Strip .{bundle,git}.
-	 */
-	strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);
+		/*
+		 * Strip .{bundle,git}.
+		 */
+		strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);
+	}
 
 	if (is_bare)
 		dir = xstrfmt("%.*s.git", (int)len, start);
@@ -203,6 +232,10 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 		if (out > dir && prev_space)
 			out[-1] = '\0';
 	}
+
+	free(host);
+	free(path);
+
 	return dir;
 }
 
-- 
2.5.0
