From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH 4/6] Add check_repo_format check for all major operations.
Date: Tue, 22 Nov 2005 03:28:13 +0300
Message-ID: <113261929333-git-send-email-matlads@dsmagic.com>
References: <11326192921291-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 01:29:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeM1T-0006BT-Bs
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVKVA2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVKVA2b
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:28:31 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:2052 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S964793AbVKVA2b
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:28:31 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 925485284; Tue, 22 Nov 2005 03:30:09 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1EeM17-0006Fm-39; Tue, 22 Nov 2005 03:28:13 +0300
In-Reply-To: <11326192921291-git-send-email-matlads@dsmagic.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12506>

The git-* command set uses 3 entry points in order to prepare
to work with a git repo: enter_repo, get_git_dir, and obviously
setup_git_directory.

This patch adds a check for the repo format version to each of these
entry points. This will automatically enable repo format version
checking for all the git-* programs.

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 environment.c |    3 +++
 path.c        |    1 +
 setup.c       |    3 +++
 3 files changed, 7 insertions(+), 0 deletions(-)

applies-to: 8084b72bfb91efc08a9fa83e0893f21c5f60ad92
5d902692ef7eef2763cadfa646eb9245422579af
diff --git a/environment.c b/environment.c
index 6a961ca..458eff8 100644
--- a/environment.c
+++ b/environment.c
@@ -37,6 +37,9 @@ static void setup_git_env(void)
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file = strdup(git_path("info/grafts"));
+
+	/* check the repo */
+	check_repo_format();
 }
 
 char *get_git_dir(int recheck_env)
diff --git a/path.c b/path.c
index e322dc0..84cb1c5 100644
--- a/path.c
+++ b/path.c
@@ -199,6 +199,7 @@ char *enter_repo(char *path, int strict)
 	if(access("objects", X_OK) == 0 && access("refs", X_OK) == 0 &&
 	   validate_symref("HEAD") == 0) {
 		putenv("GIT_DIR=.");
+		get_git_dir(1); /* re-read the env variables */
 		return current_dir();
 	}
 
diff --git a/setup.c b/setup.c
index 8597424..934f9a3 100644
--- a/setup.c
+++ b/setup.c
@@ -97,6 +97,9 @@ const char *setup_git_directory(void)
 	static char cwd[PATH_MAX+1];
 	int len, offset;
 
+	get_git_dir(1);
+	check_repo_format();
+
 	/*
 	 * If GIT_DIR is set explicitly, we're not going
 	 * to do any discovery
---
0.99.9.GIT
