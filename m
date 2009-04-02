From: Ali Gholami Rudi <ali@rudi.ir>
Subject: [PATCH] builtin-clone.c: allow multiple cmd_clone() calls
Date: Thu, 2 Apr 2009 18:52:08 +0430
Message-ID: <20090402142208.GA3886@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 16:24:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpNpl-0001hi-HB
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 16:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbZDBOWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 10:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbZDBOWV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 10:22:21 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:53435 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbZDBOWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 10:22:20 -0400
Received: by bwz17 with SMTP id 17so537736bwz.37
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=IvThJCDtwowpohct95bGuuBTuoTehi/2xyU1aHsRSA8=;
        b=mVdeL7JZFEIQ4cpgoZU4ELXWIyABV/WVjFUmttH16TtID7BkuuwP5to2bswLxikYSJ
         2rInEAs8No+uaQtL8hB8LP8TgPEtJ1jnhAlTXbVDQPSR20K+CG4MEYeRTLhOPJ7cBhJa
         Nz+hSMuFp0KahScL7wWNj9/He00TZ2XH493S0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=eUkD8mhrnogn09HKz8oMW1SsRFwg4vJUBtj0UCuKnSlzIHU1VCLoVfNEPmPUkMrV0B
         fX8E6sO6yGaqY07Y7Vx77tlV0LM16VUcpfkM813yVEHpxLBizVgzj2vhJNiYqbG4Zmxq
         wUy+/WRtdGRuDarQij2D3igZek8I2NJYt0sug=
Received: by 10.223.107.199 with SMTP id c7mr73289fap.31.1238682136758;
        Thu, 02 Apr 2009 07:22:16 -0700 (PDT)
Received: from localhost ([92.50.16.62])
        by mx.google.com with ESMTPS id 28sm469101fkx.17.2009.04.02.07.22.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 07:22:16 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115469>

With this patch, cmd_clone() safely frees its xstrdup()-allocated
memory.  Also cmd_clone() registers remove_junk() (for getting called in
a signal handler or atexit()) at most once.

junk_work_tree and junk_git_dir (used in remove_junk()) were changed to
use static arrays rather than sharing the memory allocated in
cmd_clone().  The junk_* global variables are overwritten in each
cmd_clone() call.  But if concurrent cmd_clone() calls are disallowed
that won't be an issue since we only care about the currently executing
cmd_clone() in remove_junk().

Signed-off-by: Ali Gholami Rudi <ali@rudi.ir>
---
 builtin-clone.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 880373f..6ef31cd 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -268,8 +268,9 @@ static const struct ref *clone_local(const char *src_repo,
 	return ret;
 }
 
-static const char *junk_work_tree;
-static const char *junk_git_dir;
+static int junk_registered;
+static char junk_work_tree[PATH_MAX];
+static char junk_git_dir[PATH_MAX];
 static pid_t junk_pid;
 
 static void remove_junk(void)
@@ -277,12 +278,12 @@ static void remove_junk(void)
 	struct strbuf sb = STRBUF_INIT;
 	if (getpid() != junk_pid)
 		return;
-	if (junk_git_dir) {
+	if (*junk_git_dir) {
 		strbuf_addstr(&sb, junk_git_dir);
 		remove_dir_recursively(&sb, 0);
 		strbuf_reset(&sb);
 	}
-	if (junk_work_tree) {
+	if (*junk_work_tree) {
 		strbuf_addstr(&sb, junk_work_tree);
 		remove_dir_recursively(&sb, 0);
 		strbuf_reset(&sb);
@@ -320,8 +321,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0;
 	struct stat buf;
-	const char *repo_name, *repo, *work_tree, *git_dir;
-	char *path, *dir;
+	const char *repo_name, *work_tree;
+	char *path, *dir, *repo, *git_dir;
 	int dest_exists;
 	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
 	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
@@ -362,7 +363,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	else if (!strchr(repo_name, ':'))
 		repo = xstrdup(make_absolute_path(repo_name));
 	else
-		repo = repo_name;
+		repo = xstrdup(repo_name);
 
 	if (argc == 2)
 		dir = xstrdup(argv[1]);
@@ -393,7 +394,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!option_bare) {
-		junk_work_tree = work_tree;
+		strcpy(junk_work_tree, work_tree);
 		if (safe_create_leading_directories_const(work_tree) < 0)
 			die("could not create leading directories of '%s': %s",
 					work_tree, strerror(errno));
@@ -402,9 +403,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					work_tree, strerror(errno));
 		set_git_work_tree(work_tree);
 	}
-	junk_git_dir = git_dir;
-	atexit(remove_junk);
-	sigchain_push_common(remove_junk_on_signal);
+	strcpy(junk_git_dir, git_dir);
+	if (!junk_registered) {
+		junk_registered = 1;
+		atexit(remove_junk);
+		sigchain_push_common(remove_junk_on_signal);
+	}
 
 	setenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
 
@@ -590,6 +594,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
 	strbuf_release(&value);
+	free(path);
+	free(repo);
+	free(dir);
+	free(git_dir);
 	junk_pid = 0;
 	return err;
 }
