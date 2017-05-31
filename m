Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04FBF1FD09
	for <e@80x24.org>; Wed, 31 May 2017 23:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdEaXfm (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 19:35:42 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:56022
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751033AbdEaXfj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 May 2017 19:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496273713;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=jfSm3AngEdwmglhNF46B+Qn5H+XeCaf4WtM3ZkLoLew=;
        b=OM3nGoR/vQ6rMHrJ/EA54/SLebQlixZPdG1lDQnKWDckQAPTdbUzQiLTlJJdBPIJ
        TME2ovIqxjjgwZdgDM7DVOkO6M31dgpWKlZCHyv0pqwLx8seBwoAi+o+cRi//yBm3b4
        dm8lgcnnYxKP77OeMf6jbmoEQpJq8TqKf7/E4c64=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c60dcf6be-6001eb0c-c085-4972-a25b-2490a062e3f8-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
References: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
Subject: [PATCH/RFC v2 5/6] config: add copy config section logic
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 May 2017 23:35:12 +0000
X-SES-Outgoing: 2017.05.31-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds implementation for copying the config section while copying a
branch.

While we're parsing the config file, we need to make sure we start
copying the config section once we find the matching block for our
branch1 (for example when running 'git branch -c branch1 branch2').

There is one flag used - 'copying_section' which can take 0/1/2 values.
0 - not copying currently
1 - just started copying section
2 - currently copying
I thought of making this flag binary to keep things easier. However,
since there was distinction in behavior(adding to currently copied
section) depending upon whether it's the first line of config section or
not.

The copied section has first line which contains the new branch name
(branch2 in our example). This is achieved using store_create_section
method.

Once we're done with reading the entire config file, we write our copied
section. Hence, literally copying the config section from branch1 to
branch2.

However, there's one case which is not handled by this yet - when
branch2 already has some configuration and -C command is used, operation
should delete the present configuration for branch2.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 config.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/config.c b/config.c
index 155274f03b2b6..2bf711ca3e0da 100644
--- a/config.c
+++ b/config.c
@@ -2642,13 +2642,14 @@ static int section_name_is_ok(const char *name)
 int git_config_copy_or_rename_section_in_file(const char *config_filename,
 				      const char *old_name, const char *new_name, int copy)
 {
-	int ret = 0, remove = 0;
+	int ret = 0, remove = 0, copying_section = 0, copied_section_length;
 	char *filename_buf = NULL;
 	struct lock_file *lock;
 	int out_fd;
 	char buf[1024];
 	FILE *config_file = NULL;
 	struct stat st;
+	struct strbuf copied_section;
 
 	if (new_name && !section_name_is_ok(new_name)) {
 		ret = error("invalid section name: %s", new_name);
@@ -2689,6 +2690,13 @@ int git_config_copy_or_rename_section_in_file(const char *config_filename,
 			; /* do nothing */
 		if (buf[i] == '[') {
 			/* it's a section */
+			if (copying_section) {
+				/* Mark the end of copying the matching
+				 * section, as this is the beginning
+				 * of the new section
+				 */
+				copying_section = 0;
+			}
 			int offset = section_name_match(&buf[i], old_name);
 			if (offset > 0) {
 				ret++;
@@ -2696,26 +2704,41 @@ int git_config_copy_or_rename_section_in_file(const char *config_filename,
 					remove = 1;
 					continue;
 				}
-				store.baselen = strlen(new_name);
-				if (!store_write_section(out_fd, new_name)) {
-					ret = write_error(get_lock_file_path(lock));
-					goto out;
+				if (!copy) {
+					store.baselen = strlen(new_name);
+					if (!store_write_section(out_fd, new_name)) {
+						ret = write_error(get_lock_file_path(lock));
+						goto out;
+					}
+				} else {
+					/* Mark the beginning of copying the matching section */
+					copying_section = 1;
+
+					/* TODO: Make this work for the
+					 * case when there are multiple
+					 * matching sections
+					 */
+					/* Create a section with new branch name */
+					store.baselen = strlen(new_name);
+					copied_section = store_create_section(new_name);
 				}
 				/*
 				 * We wrote out the new section, with
 				 * a newline, now skip the old
 				 * section's length
 				 */
-				output += offset + i;
-				if (strlen(output) > 0) {
-					/*
-					 * More content means there's
-					 * a declaration to put on the
-					 * next line; indent with a
-					 * tab
-					 */
-					output -= 1;
-					output[0] = '\t';
+				if (!copy) {
+					output += offset + i;
+					if (strlen(output) > 0) {
+						/*
+						 * More content means there's
+						 * a declaration to put on the
+						 * next line; indent with a
+						 * tab
+						 */
+						output -= 1;
+						output[0] = '\t';
+					}
 				}
 			}
 			remove = 0;
@@ -2723,11 +2746,25 @@ int git_config_copy_or_rename_section_in_file(const char *config_filename,
 		if (remove)
 			continue;
 		length = strlen(output);
+
+		if (copying_section > 1) {
+			strbuf_addf(&copied_section, "%s", output);
+		} else if (copying_section == 1) {
+			copying_section = 2;
+		}
 		if (write_in_full(out_fd, output, length) != length) {
 			ret = write_error(get_lock_file_path(lock));
 			goto out;
 		}
 	}
+
+	if (copy && copied_section.len > 0) {
+		copied_section_length = strlen(copied_section.buf);
+		if (write_in_full(out_fd, copied_section.buf, copied_section_length) != copied_section_length) {
+			ret = write_error(get_lock_file_path(lock));
+			goto out;
+		}
+	}
 	fclose(config_file);
 	config_file = NULL;
 commit_and_out:

--
https://github.com/git/git/pull/363
