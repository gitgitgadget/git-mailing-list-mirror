From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] builtin-push: also ask config for remote information
Date: Sun, 30 Apr 2006 15:23:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604301520460.2646@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 30 15:24:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaBuG-0002iW-JF
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 15:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWD3NXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 09:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWD3NXu
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 09:23:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54480 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751115AbWD3NXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 09:23:49 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 8CB1AC1D
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 15:23:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 80D31C24
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 15:23:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 63955BD9
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 15:23:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19335>


Now you can store your remote information in the config file like this:

[remote.upstream]
	url = me@company.com:the-project
	push = master:iceballs

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Obviously, this is on top of the patch to parse Pull: lines, too.

 builtin-push.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

e55eb69f6332087c45082e16ccbf4e510d721e29
diff --git a/builtin-push.c b/builtin-push.c
index 4e659f0..e3131ed 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -72,6 +72,36 @@ #define MAX_REFSPECS 10
 static int current_refspec = 0;
 static char *refspecs_[MAX_REFSPECS];
 
+static int repo_len = 0;
+static const char *repo_ = NULL;
+static int current_uri = 0;
+static const char **uri_;
+
+static int get_value(const char* key, const char* value)
+{
+	if (!strncmp(key, "remote.", 7) && !strncmp(key + 7, repo_, repo_len)) {
+		if (!strcmp(key + 7 + repo_len, ".url"))
+			uri_[current_uri++] = strdup(value);
+		else if (!strcmp(key + 7 + repo_len, ".push")
+				&& current_refspec < MAX_REFSPECS)
+			refspecs_[current_refspec++] = strdup(value);
+	}
+
+	return 0;
+}
+
+static int get_config_remotes_uri(const char *repo, const char *uri[MAX_URI])
+{
+	repo_len = strlen(repo);
+	repo_ = repo;
+	current_uri = 0;
+	uri_ = uri;
+
+	git_config(get_value);
+
+	return current_uri;
+}
+
 static int get_remotes_uri(const char *repo, const char *uri[MAX_URI])
 {
 	int n = 0;
@@ -153,6 +183,9 @@ static int get_uri(const char *repo, con
 	if (*repo != '/') {
 		current_refspec = 0;
 
+		n = get_config_remotes_uri(repo, uri);
+		if (n > 0)
+			return n;
 		n = get_remotes_uri(repo, uri);
 		if (n > 0)
 			return n;
-- 
1.3.1.g38c00-dirty
