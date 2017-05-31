Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DA71FD09
	for <e@80x24.org>; Wed, 31 May 2017 23:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdEaXfU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 19:35:20 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:34852
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750977AbdEaXfT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 May 2017 19:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496273713;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=CK3mEs0hba+QmT3wZGonNqooYGCNFiS0BFehaZVcHQc=;
        b=Bo5WWCuSKiQJkHdRuyuEnK88u2WKNy5xYZvKtiN9z9pG2xej2n46nY525TJEv9QU
        STfkleU7Pi0R2R4rSlju9oNcnXrTsJ34ie8tBwuP3WR2ptwb09qB4lfxwDQTcl+1ZDf
        +KPy9nZEx7LHvC+c5hKWJt+FKmGmWL2CkaT+wvdw=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c60dcf6cf-6e8c5038-3dee-4e5c-b344-d013e96d233f-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
References: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
Subject: [PATCH/RFC v2 4/6] config: modify function signature to include
 copy argument
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 May 2017 23:35:12 +0000
X-SES-Outgoing: 2017.05.31-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changed git_config_rename_section to git_config_copy_or_rename_section
which will now accept another argument flag "copy" which will determine
if the function will copy the config section or just rename it.

Again, this includes changes at a lot of unrelated other places wherever
the renamed and updated functions were being used. Default value of
copy=0 is passed at all those places in order to make sure the behavior
of the functions doesn't change for those cases.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 builtin/branch.c | 4 ++--
 builtin/config.c | 4 ++--
 builtin/remote.c | 4 ++--
 cache.h          | 4 ++--
 config.c         | 6 +++---
 submodule.c      | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 16d01a100cbb9..f3cd180e8d4cb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -176,7 +176,7 @@ static void delete_branch_config(const char *branchname)
 {
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "branch.%s", branchname);
-	if (git_config_copy_or_rename_section(buf.buf, NULL) < 0)
+	if (git_config_copy_or_rename_section(buf.buf, NULL, 0) < 0)
 		warning(_("Update of config-file failed"));
 	strbuf_release(&buf);
 }
@@ -502,7 +502,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	strbuf_release(&oldref);
 	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
 	strbuf_release(&newref);
-	if (git_config_copy_or_rename_section(oldsection.buf, newsection.buf) < 0)
+	if (git_config_copy_or_rename_section(oldsection.buf, newsection.buf, copy) < 0)
 		die(_("Branch is %s, but update of config-file failed"),
 			 (copy ? "copied" : "renamed"));
 	strbuf_release(&oldsection);
diff --git a/builtin/config.c b/builtin/config.c
index c72972d731bd1..4f0b3d1595709 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -694,7 +694,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 2, 2);
 		ret = git_config_copy_or_rename_section_in_file(given_config_source.file,
-							argv[0], argv[1]);
+							argv[0], argv[1], 0);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
@@ -705,7 +705,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_write();
 		check_argc(argc, 1, 1);
 		ret = git_config_copy_or_rename_section_in_file(given_config_source.file,
-							argv[0], NULL);
+							argv[0], NULL, 0);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
diff --git a/builtin/remote.c b/builtin/remote.c
index ade748044b5ab..2abcdfa441599 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -635,7 +635,7 @@ static int mv(int argc, const char **argv)
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s", rename.old);
 	strbuf_addf(&buf2, "remote.%s", rename.new);
-	if (git_config_copy_or_rename_section(buf.buf, buf2.buf) < 1)
+	if (git_config_copy_or_rename_section(buf.buf, buf2.buf, 0) < 1)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
@@ -804,7 +804,7 @@ static int rm(int argc, const char **argv)
 
 	if (!result) {
 		strbuf_addf(&buf, "remote.%s", remote->name);
-		if (git_config_copy_or_rename_section(buf.buf, NULL) < 1)
+		if (git_config_copy_or_rename_section(buf.buf, NULL, 0) < 1)
 			return error(_("Could not remove config section '%s'"), buf.buf);
 	}
 
diff --git a/cache.h b/cache.h
index b2b043d3505ba..54a7f272bac87 100644
--- a/cache.h
+++ b/cache.h
@@ -1933,8 +1933,8 @@ extern int git_config_set_multivar_gently(const char *, const char *, const char
 extern void git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
 extern void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
-extern int git_config_copy_or_rename_section(const char *, const char *);
-extern int git_config_copy_or_rename_section_in_file(const char *, const char *, const char *);
+extern int git_config_copy_or_rename_section(const char *, const char *, int);
+extern int git_config_copy_or_rename_section_in_file(const char *, const char *, const char *, int);
 extern const char *git_etc_gitconfig(void);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
diff --git a/config.c b/config.c
index d3d48bfae3b96..155274f03b2b6 100644
--- a/config.c
+++ b/config.c
@@ -2640,7 +2640,7 @@ static int section_name_is_ok(const char *name)
 
 /* if new_name == NULL, the section is removed instead */
 int git_config_copy_or_rename_section_in_file(const char *config_filename,
-				      const char *old_name, const char *new_name)
+				      const char *old_name, const char *new_name, int copy)
 {
 	int ret = 0, remove = 0;
 	char *filename_buf = NULL;
@@ -2743,9 +2743,9 @@ int git_config_copy_or_rename_section_in_file(const char *config_filename,
 	return ret;
 }
 
-int git_config_copy_or_rename_section(const char *old_name, const char *new_name)
+int git_config_copy_or_rename_section(const char *old_name, const char *new_name, int copy)
 {
-	return git_config_copy_or_rename_section_in_file(NULL, old_name, new_name);
+	return git_config_copy_or_rename_section_in_file(NULL, old_name, new_name, copy);
 }
 
 /*
diff --git a/submodule.c b/submodule.c
index d93f366be31c6..347ff4ca668aa 100644
--- a/submodule.c
+++ b/submodule.c
@@ -107,7 +107,7 @@ int remove_path_from_gitmodules(const char *path)
 	}
 	strbuf_addstr(&sect, "submodule.");
 	strbuf_addstr(&sect, submodule->name);
-	if (git_config_copy_or_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
+	if (git_config_copy_or_rename_section_in_file(".gitmodules", sect.buf, NULL, 0) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
 		strbuf_release(&sect);

--
https://github.com/git/git/pull/363
