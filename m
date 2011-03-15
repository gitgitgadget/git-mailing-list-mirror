From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] config: drop support for GIT_CONFIG_NOGLOBAL
Date: Tue, 15 Mar 2011 04:04:49 -0500
Message-ID: <20110315090449.GC1576@elie>
References: <20110315064909.GA25738@elie>
 <20110315065643.GB29530@elie>
 <20110315071625.GA11754@sigill.intra.peff.net>
 <20110315090225.GA1576@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 10:05:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzQBY-0003AM-8F
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 10:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab1COJEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 05:04:55 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37989 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab1COJEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 05:04:54 -0400
Received: by gwaa18 with SMTP id a18so143707gwa.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EvyQXk3Cg0mf5zfYTgTzBGbBoDfaQdYSvpMw8ClHAb0=;
        b=WyQOIrPSSLiPO00MeXDoEPV3o2WgIkOd5D29pFxtdWLw38LyWflZBR5xIvv/2aPDfX
         f0pv9lRJ54HUdu9oGb30gyKPu1Zx3c707F9ZSRAjGW0NnSJJuxHtYdtBujA3xggoZQkm
         y1PEbkf99eu1djxEghAYvbrTy/Yz/vmhsqY6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TALO/kbbI0aFnuiHYg5dcDP5nItNYBtyqq0DSZ6gozfi00r1J/3lDvjlX3vhBTFuzf
         Vd7a7+MJmoDnXn2ePfKMII2AGxxZrnL5SYTSHxr91Ng7regKpSJvvpbAdbk9UW5TAzkX
         3XXrlGWdPomyyWJ9MbnIeuzK7U1pn0Gr3EpxM=
Received: by 10.90.9.26 with SMTP id 26mr4390107agi.50.1300179893676;
        Tue, 15 Mar 2011 02:04:53 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id 19sm4933594anx.17.2011.03.15.02.04.51
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 02:04:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315090225.GA1576@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169053>

Now that test-lib sets $HOME to protect against pollution from user
settings, GIT_CONFIG_NOGLOBAL is not needed for use by the test
suite any more.  And as luck would have it, a quick code search
reveals no other users in the wild.

This patch does not affect GIT_CONFIG_NOSYSTEM, which is still
needed.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/config.c                |    2 +-
 cache.h                         |    1 -
 config.c                        |    7 +------
 t/t0001-init.sh                 |    5 +----
 t/t5601-clone.sh                |    1 -
 t/t9130-git-svn-authors-file.sh |    1 -
 t/test-lib.sh                   |    3 +--
 7 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 76be0b7..3e3c528 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -160,7 +160,7 @@ static int get_value(const char *key_, const char *regex_)
 	if (!local) {
 		const char *home = getenv("HOME");
 		local = repo_config = git_pathdup("config");
-		if (git_config_global() && home)
+		if (home)
 			global = xstrdup(mkpath("%s/.gitconfig", home));
 		if (git_config_system())
 			system_wide = git_etc_gitconfig();
diff --git a/cache.h b/cache.h
index d0bbc91..a8ef37a 100644
--- a/cache.h
+++ b/cache.h
@@ -1020,7 +1020,6 @@ extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
-extern int git_config_global(void);
 extern int config_error_nonbool(const char *);
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
diff --git a/config.c b/config.c
index b94de8f..217a77d 100644
--- a/config.c
+++ b/config.c
@@ -826,11 +826,6 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-int git_config_global(void)
-{
-	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
-}
-
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
 	static int loaded_environment;
@@ -862,7 +857,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	}
 
 	home = getenv("HOME");
-	if (git_config_global() && home) {
+	if (home) {
 		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
 		if (!access(user_config, R_OK)) {
 			ret += git_config_from_file(fn, user_config, data);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f684993..ce4ba13 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -47,7 +47,7 @@ test_expect_success 'plain nested in bare' '
 
 test_expect_success 'plain through aliased command, outside any git repo' '
 	(
-		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG_NOGLOBAL &&
+		sane_unset GIT_DIR GIT_WORK_TREE &&
 		HOME=$(pwd)/alias-config &&
 		export HOME &&
 		mkdir alias-config &&
@@ -231,7 +231,6 @@ test_expect_success 'init with init.templatedir set' '
 		git config -f "$test_config"  init.templatedir "${HOME}/templatedir-source" &&
 		mkdir templatedir-set &&
 		cd templatedir-set &&
-		sane_unset GIT_CONFIG_NOGLOBAL &&
 		sane_unset GIT_TEMPLATE_DIR &&
 		NO_SET_GIT_TEMPLATE_DIR=t &&
 		export NO_SET_GIT_TEMPLATE_DIR &&
@@ -243,7 +242,6 @@ test_expect_success 'init with init.templatedir set' '
 test_expect_success 'init --bare/--shared overrides system/global config' '
 	(
 		test_config="$HOME"/.gitconfig &&
-		sane_unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" core.bare false &&
 		git config -f "$test_config" core.sharedRepository 0640 &&
 		mkdir init-bare-shared-override &&
@@ -258,7 +256,6 @@ test_expect_success 'init --bare/--shared overrides system/global config' '
 test_expect_success 'init honors global core.sharedRepository' '
 	(
 		test_config="$HOME"/.gitconfig &&
-		sane_unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" core.sharedRepository 0666 &&
 		mkdir shared-honor-global &&
 		cd shared-honor-global &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 987e0c8..3ca275c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -164,7 +164,6 @@ test_expect_success 'clone a void' '
 test_expect_success 'clone respects global branch.autosetuprebase' '
 	(
 		test_config="$HOME/.gitconfig" &&
-		unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" branch.autosetuprebase remote &&
 		rm -fr dst &&
 		git clone src dst &&
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index ec0a106..b324c49 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -96,7 +96,6 @@ test_expect_success 'fresh clone with svn.authors-file in config' '
 		rm -r "$GIT_DIR" &&
 		test x = x"$(git config svn.authorsfile)" &&
 		test_config="$HOME"/.gitconfig &&
-		unset GIT_CONFIG_NOGLOBAL &&
 		unset GIT_DIR &&
 		unset GIT_CONFIG &&
 		git config --global \
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fdc541..94595e3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -954,8 +954,7 @@ fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
-GIT_CONFIG_NOGLOBAL=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM
 
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 
-- 
1.7.4.1
