From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] fix attribute handling in bare repositories
Date: Sun, 08 Jun 2008 17:16:11 +0200
Message-ID: <484BF7BB.1090802@lsrfire.ath.cx>
References: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 17:17:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Mdu-0007YX-MR
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 17:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbYFHPQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbYFHPQV
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 11:16:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:42317 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbYFHPQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 11:16:20 -0400
Received: from [10.0.1.200] (p57B7EC0B.dip.t-dialin.net [87.183.236.11])
	by india601.server4you.de (Postfix) with ESMTPSA id 829D72F8068;
	Sun,  8 Jun 2008 17:16:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84279>

Nguyen Thai Ngoc Duy schrieb:
> Hi,
> 
> Currently attr.c will read .gitattributes on disk no matter there is a
> real worktree or not. This can lead to strange behavior.

Yes, it probably shouldn't do that.  What about this patch?

-- snip! --
Attributes can be specified at three different places: the internal table
of default values, the file $GIT_DIR/info/attributes and files named
.gitattributes in the work tree.  Since bare repositories don't have a
work tree, git should ignore any .gitattributes files there.

This patch makes git do that, so the only way left for a user to specify
attributes in a bare repository is the file info/attributes (in addition
to changing the defaults and recompiling).

In addition, git-check-attr is allowed to run without a work tree.  Like
any user of the code in attr.c, it simply ignores the .gitattributes
files when run in a bare repository.  And we need the command to work
there, because it's used in the tests that this patch adds.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 attr.c                |   46 +++++++++++++++++++++++++---------------------
 git.c                 |    2 +-
 t/t0003-attributes.sh |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/attr.c b/attr.c
index 1a15fad..0fb47d3 100644
--- a/attr.c
+++ b/attr.c
@@ -438,11 +438,13 @@ static void bootstrap_attr_stack(void)
 		elem->prev = attr_stack;
 		attr_stack = elem;
 
-		elem = read_attr(GITATTRIBUTES_FILE, 1);
-		elem->origin = strdup("");
-		elem->prev = attr_stack;
-		attr_stack = elem;
-		debug_push(elem);
+		if (!is_bare_repository()) {
+			elem = read_attr(GITATTRIBUTES_FILE, 1);
+			elem->origin = strdup("");
+			elem->prev = attr_stack;
+			attr_stack = elem;
+			debug_push(elem);
+		}
 
 		elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
 		if (!elem)
@@ -501,22 +503,24 @@ static void prepare_attr_stack(const char *path, int dirlen)
 	/*
 	 * Read from parent directories and push them down
 	 */
-	while (1) {
-		char *cp;
-
-		len = strlen(attr_stack->origin);
-		if (dirlen <= len)
-			break;
-		memcpy(pathbuf, path, dirlen);
-		memcpy(pathbuf + dirlen, "/", 2);
-		cp = strchr(pathbuf + len + 1, '/');
-		strcpy(cp + 1, GITATTRIBUTES_FILE);
-		elem = read_attr(pathbuf, 0);
-		*cp = '\0';
-		elem->origin = strdup(pathbuf);
-		elem->prev = attr_stack;
-		attr_stack = elem;
-		debug_push(elem);
+	if (!is_bare_repository()) {
+		while (1) {
+			char *cp;
+
+			len = strlen(attr_stack->origin);
+			if (dirlen <= len)
+				break;
+			memcpy(pathbuf, path, dirlen);
+			memcpy(pathbuf + dirlen, "/", 2);
+			cp = strchr(pathbuf + len + 1, '/');
+			strcpy(cp + 1, GITATTRIBUTES_FILE);
+			elem = read_attr(pathbuf, 0);
+			*cp = '\0';
+			elem->origin = strdup(pathbuf);
+			elem->prev = attr_stack;
+			attr_stack = elem;
+			debug_push(elem);
+		}
 	}
 
 	/*
diff --git a/git.c b/git.c
index 15a0e71..59f0fcc 100644
--- a/git.c
+++ b/git.c
@@ -286,7 +286,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "checkout-index", cmd_checkout_index,
 			RUN_SETUP | NEED_WORK_TREE},
 		{ "check-ref-format", cmd_check_ref_format },
-		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
+		{ "check-attr", cmd_check_attr, RUN_SETUP },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 		{ "clone", cmd_clone },
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index c56d2fb..3d8e06a 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -54,4 +54,39 @@ test_expect_success 'root subdir attribute test' '
 
 '
 
+test_expect_success 'setup bare' '
+
+	git clone --bare . bare.git &&
+	cd bare.git
+
+'
+
+test_expect_success 'bare repository: check that .gitattribute is ignored' '
+
+	(
+		echo "f	test=f"
+		echo "a/i test=a/i"
+	) >.gitattributes &&
+	attr_check f unspecified &&
+	attr_check a/f unspecified &&
+	attr_check a/c/f unspecified &&
+	attr_check a/i unspecified &&
+	attr_check subdir/a/i unspecified
+
+'
+
+test_expect_success 'bare repository: test info/attributes' '
+
+	(
+		echo "f	test=f"
+		echo "a/i test=a/i"
+	) >info/attributes &&
+	attr_check f f &&
+	attr_check a/f f &&
+	attr_check a/c/f f &&
+	attr_check a/i a/i &&
+	attr_check subdir/a/i unspecified
+
+'
+
 test_done
