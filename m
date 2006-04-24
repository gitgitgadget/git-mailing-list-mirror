From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/4] git-repo-config --list support
Date: Tue, 25 Apr 2006 00:59:25 +0200
Message-ID: <20060424225925.14086.97825.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 25 00:59:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYA1O-0005Ay-6j
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 00:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWDXW7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 18:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWDXW7D
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 18:59:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48555 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932089AbWDXW7C (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 18:59:02 -0400
Received: (qmail 14118 invoked from network); 25 Apr 2006 00:59:26 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Apr 2006 00:59:26 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19113>

This adds git-repo-config --list (or git-repo-config -l) support,
similar to what git-var -l does now (to be phased out so that we
have a single sane interface to the config file instead of fragmented
and confused API).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-repo-config.txt |    4 ++++
 repo-config.c                     |   16 ++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index 26759a8..c08ab77 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git-repo-config' [type] --get-all name [value_regex]
 'git-repo-config' [type] --unset name [value_regex]
 'git-repo-config' [type] --unset-all name [value_regex]
+'git-repo-config' -l | --list
 
 DESCRIPTION
 -----------
@@ -64,6 +65,9 @@ OPTIONS
 --unset-all::
 	Remove all matching lines from .git/config.
 
+-l, --list::
+	List all variables set in .git/config.
+
 
 EXAMPLE
 -------
diff --git a/repo-config.c b/repo-config.c
index c5ebb76..fa8aba7 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -2,7 +2,7 @@ #include "cache.h"
 #include <regex.h>
 
 static const char git_config_set_usage[] =
-"git-repo-config [ --bool | --int ] [--get | --get-all | --replace-all | --unset | --unset-all] name [value [value_regex]]";
+"git-repo-config [ --bool | --int ] [--get | --get-all | --replace-all | --unset | --unset-all] name [value [value_regex]] | --list";
 
 static char* key = NULL;
 static char* value = NULL;
@@ -12,6 +12,15 @@ static int do_not_match = 0;
 static int seen = 0;
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
+static int show_all_config(const char *key_, const char *value_)
+{
+	if (value_)
+		printf("%s=%s\n", key_, value_);
+	else
+		printf("%s\n", key_);
+	return 0;
+}
+
 static int show_config(const char* key_, const char* value_)
 {
 	if (value_ == NULL)
@@ -67,7 +76,7 @@ static int get_value(const char* key_, c
 		}
 	}
 
-	i = git_config(show_config);
+	git_config(show_config);
 	if (value) {
 		printf("%s\n", value);
 		free(value);
@@ -99,6 +108,9 @@ int main(int argc, const char **argv)
 		argv++;
 	}
 
+	if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
+		return git_config(show_all_config);
+
 	switch (argc) {
 	case 2:
 		return get_value(argv[1], NULL);
