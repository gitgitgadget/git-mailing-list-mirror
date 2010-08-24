From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/1] do not pass "git -c foo=bar" params to transport
 helpers
Date: Tue, 24 Aug 2010 01:41:14 -0500
Message-ID: <20100824064114.GA20724@burratino>
References: <7viq3119yn.fsf@alter.siamese.dyndns.org>
 <20100823183857.GA22386@coredump.intra.peff.net>
 <20100823191600.GA2523@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 24 08:43:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnnE6-0001QJ-2Z
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 08:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953Ab0HXGnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 02:43:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59044 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab0HXGnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 02:43:08 -0400
Received: by iwn5 with SMTP id 5so4261557iwn.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HpvjMaeSznA/t5rtFIvgnzCNB3jhn3LqBfBbUgocqWI=;
        b=OSl8jXQiE5PXOgaRhScXghBE133jaDxV+LBWa1VuvL1gFV86qTwSehQhkOeecsElRW
         y43SuQdCl040ROUSt76eEkOafkoSppfgPN2ZZ6XA+ZAl3NmU1Qz7Ud12+2A3Gs+WBLF2
         fp2eG0xJ0UltiWS7j6lx2OTuUm89vBLumDtx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xQIHfBq7j1czZChvocAm4qxuV7ysjrjYXkDruewlTcFuzYVjTbYveaT3ZOYVbelhTj
         vt4ySjn2g60cJc0QRsSiER9sAPIoyKCi0Zf9fQISnX1TvNx1EFg7jmgftjj+nwmc4rqe
         aLIu9yjMPDjvUR9SVd2m8rkZ3PmsDCUW2826U=
Received: by 10.231.149.80 with SMTP id s16mr8035026ibv.81.1282632188164;
        Mon, 23 Aug 2010 23:43:08 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm7053121ibb.2.2010.08.23.23.43.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 23:43:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100823191600.GA2523@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154296>

Like $GIT_CONFIG, $GIT_CONFIG_PARAMETERS needs to be suppressed by
"git push" and its cousins when running local transport helpers to
imitate remote transport well.

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jeff King wrote:

> Here's a first attempt. No idea if it has any bad side effects. :)

Here's the transport boundary.

 cache.h              |    3 ++-
 config.c             |    8 ++++----
 environment.c        |    1 +
 t/t5400-send-pack.sh |   23 +++++++++++++++++++++++
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 6f50ea8..181a305 100644
--- a/cache.h
+++ b/cache.h
@@ -379,6 +379,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
+#define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
@@ -397,7 +398,7 @@ static inline enum object_type object_type(unsigned int mode)
  * environment creation or simple walk of the list.
  * The number of non-NULL entries is available as a macro.
  */
-#define LOCAL_REPO_ENV_SIZE 8
+#define LOCAL_REPO_ENV_SIZE 9
 extern const char *const local_repo_env[LOCAL_REPO_ENV_SIZE + 1];
 
 extern int is_bare_repository_cfg;
diff --git a/config.c b/config.c
index e08e32b..c2c995f 100644
--- a/config.c
+++ b/config.c
@@ -38,13 +38,13 @@ static void lowercase(char *p)
 void git_config_push_parameter(const char *text)
 {
 	struct strbuf env = STRBUF_INIT;
-	const char *old = getenv("GIT_CONFIG_PARAMETERS");
+	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
 	if (old) {
 		strbuf_addstr(&env, old);
 		strbuf_addch(&env, ' ');
 	}
 	sq_quote_buf(&env, text);
-	setenv("GIT_CONFIG_PARAMETERS", env.buf, 1);
+	setenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
 	strbuf_release(&env);
 }
 
@@ -76,7 +76,7 @@ int git_config_parse_parameter(const char *text)
 }
 
 int git_config_parse_environment(void) {
-	const char *env = getenv("GIT_CONFIG_PARAMETERS");
+	const char *env = getenv(CONFIG_DATA_ENVIRONMENT);
 	char *envw;
 	const char **argv = NULL;
 	int nr = 0, alloc = 0;
@@ -89,7 +89,7 @@ int git_config_parse_environment(void) {
 
 	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
 		free(envw);
-		return error("bogus format in GIT_CONFIG_PARAMETERS");
+		return error("bogus format in " CONFIG_DATA_ENVIRONMENT);
 	}
 
 	for (i = 0; i < nr; i++) {
diff --git a/environment.c b/environment.c
index 83d38d3..a199f63 100644
--- a/environment.c
+++ b/environment.c
@@ -72,6 +72,7 @@ static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
 const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
 	ALTERNATE_DB_ENVIRONMENT,
 	CONFIG_ENVIRONMENT,
+	CONFIG_DATA_ENVIRONMENT,
 	DB_ENVIRONMENT,
 	GIT_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index c718253..5bcf0b8 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -94,6 +94,29 @@ test_expect_success 'refuse deleting push with denyDeletes' '
 	test_must_fail git send-pack ./victim :extra master
 '
 
+test_expect_success 'cannot override denyDeletes with git -c send-pack' '
+	(
+		cd victim &&
+		test_might_fail git branch -D extra &&
+		git config receive.denyDeletes true &&
+		git branch extra master
+	) &&
+	test_must_fail git -c receive.denyDeletes=false \
+					send-pack ./victim :extra master
+'
+
+test_expect_success 'override denyDeletes with git -c receive-pack' '
+	(
+		cd victim &&
+		test_might_fail git branch -D extra &&
+		git config receive.denyDeletes true &&
+		git branch extra master
+	) &&
+	git send-pack \
+		--receive-pack="git -c receive.denyDeletes=false receive-pack" \
+		./victim :extra master
+'
+
 test_expect_success 'denyNonFastforwards trumps --force' '
 	(
 	    cd victim &&
-- 
1.7.2.2
