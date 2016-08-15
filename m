Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5551F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbcHOVxk (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:53:40 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36732 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbcHOVxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:53:39 -0400
Received: by mail-pa0-f42.google.com with SMTP id pp5so19415374pac.3
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:53:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gprIfsIxVzx722onBhHE88Xko8+XLYpj+Kr0nLVYvJo=;
        b=LcWEeSWkzrpcM4RhaGaeolYmEeNkGGwYnwmUCoxu+mHKnXkxEfgQuIYQz1tz/pMadI
         SvlrOavYwDh1vHzKnr0wHB/zqSsVtQoTc+I4KB1Lw7ekejmqNK2Pmv7SArjHsDIpLrKZ
         4Qfn3J1oy7Cb7ccjRVSqChkmwCbDOK+ox1GJM/ibeFPoP0SwCjHOyGyA0pqT6RSCz/qx
         ZgIYNjo0etTBtIgAbpsAD8gIOGl//Gm9X9AamMFSL2paFFF44yQ38MHGDULo7gdWM4nI
         gFwvnpUDyhlvMgXlymjokNHHoq3PC1DJoJl4lEMv1FACkkjPSw5dErYBUjgMJovPecQg
         7+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gprIfsIxVzx722onBhHE88Xko8+XLYpj+Kr0nLVYvJo=;
        b=WPCDwjbZxfvrt4oMBeYCfXXzcQdRAeQfCDt/McM8CF1qMBKo9tjSp6z76W+wBVDim2
         FZZyCU1LmTExtzeCTDolYfwewtCu48H+z34UDA7jYblPkQyb22QxQB767yuFo4GWykiX
         /uo/X6meyRVNx2O+CVUja38r3pI58saVwQdGL7fVMeD2JUScGvVABswKJRvB4Rr7WLV8
         Ri6TYgTi9uNXpiDakcRDW4uU8Yr3JUdVhhHgsR8aR3DuUwYiAM19Eep30e2aOzyomAz+
         FgOtQAIOXIFhYtuPBUJgDj9v4uRK/mObYvEYLl+IgriAWwiaxI1yJy/3Wz5ELXZKfsEk
         sP8g==
X-Gm-Message-State: AEkoouuNuOU3AC4RzWBQCe/NVKC5rVhwed/PPLWtC20QzQd9Vt7W2Lc3YRVCsBIs+4HH6b6j
X-Received: by 10.66.52.47 with SMTP id q15mr57689917pao.67.1471298018264;
        Mon, 15 Aug 2016 14:53:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id ps2sm33778231pab.10.2016.08.15.14.53.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 14:53:37 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 0/8] git clone: Marry --recursive and --reference
Date:	Mon, 15 Aug 2016 14:53:19 -0700
Message-Id: <20160815215327.15682-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

v5:

Thanks Junio, Ramsay for comments.

As the comments only address programming work as opposed to design, the 
interdiff is rather small:

diff --git a/builtin/clone.c b/builtin/clone.c
index 0593aee..404c5e8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -285,23 +285,26 @@ static void strip_trailing_slashes(char *dir)
 
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
-	struct strbuf sb = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	int *required = cb_data;
-	char *ref_git = compute_alternate_path(item->string, &sb);
+	char *ref_git = compute_alternate_path(item->string, &err);
 
 	if (!ref_git) {
 		if (*required)
-			die("%s", sb.buf);
+			die("%s", err.buf);
 		else
 			fprintf(stderr,
 				_("info: Could not add alternate for '%s': %s\n"),
-				item->string, sb.buf);
+				item->string, err.buf);
 	} else {
+		struct strbuf sb = STRBUF_INIT;
 		strbuf_addf(&sb, "%s/objects", ref_git);
 		add_to_alternates_file(sb.buf);
+		strbuf_release(&sb);
 	}
 
-	strbuf_release(&sb);
+	strbuf_release(&err);
+	free(ref_git);
 	return 0;
 }
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 472b1d9..681b91d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -484,7 +484,7 @@ struct submodule_alternate_setup {
 #define SUBMODULE_ALTERNATE_SETUP_INIT { NULL, \
 	SUBMODULE_ALTERNATE_ERROR_IGNORE, NULL }
 
-int add_possible_reference_from_superproject(
+static int add_possible_reference_from_superproject(
 		struct alternate_object_database *alt, void *sas_cb)
 {
 	struct submodule_alternate_setup *sas = sas_cb;
diff --git a/sha1_file.c b/sha1_file.c
index 2489653..0fe5aa3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -435,11 +435,12 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 {
 	char *ref_git = NULL;
 	const char *repo, *ref_git_s;
-	struct strbuf err_buf = STRBUF_INIT;
+	int seen_error = 0;
 
 	ref_git_s = real_path_if_valid(path);
 	if (!ref_git_s) {
-		strbuf_addf(&err_buf, _("path '%s' does not exist"), path);
+		seen_error = 1;
+		strbuf_addf(err, _("path '%s' does not exist"), path);
 		goto out;
 	} else
 		/*
@@ -462,40 +463,41 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 		ref_git = ref_git_git;
 	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
 		struct strbuf sb = STRBUF_INIT;
+		seen_error = 1;
 		if (get_common_dir(&sb, ref_git)) {
-			strbuf_addf(&err_buf,
+			strbuf_addf(err,
 				    _("reference repository '%s' as a linked "
 				      "checkout is not supported yet."),
 				    path);
 			goto out;
 		}
 
-		strbuf_addf(&err_buf, _("reference repository '%s' is not a "
+		strbuf_addf(err, _("reference repository '%s' is not a "
 					"local repository."), path);
 		goto out;
 	}
 
 	if (!access(mkpath("%s/shallow", ref_git), F_OK)) {
-		strbuf_addf(&err_buf, _("reference repository '%s' is shallow"),
+		strbuf_addf(err, _("reference repository '%s' is shallow"),
 			    path);
+		seen_error = 1;
 		goto out;
 	}
 
 	if (!access(mkpath("%s/info/grafts", ref_git), F_OK)) {
-		strbuf_addf(&err_buf,
+		strbuf_addf(err,
 			    _("reference repository '%s' is grafted"),
 			    path);
+		seen_error = 1;
 		goto out;
 	}
 
 out:
-	if (err_buf.len) {
-		strbuf_addbuf(err, &err_buf);
+	if (seen_error) {
 		free(ref_git);
 		ref_git = NULL;
 	}
 
-	strbuf_release(&err_buf);
 	return ref_git;
 }
 
Thanks,
Stefan


v4:
Thanks to Junios critial questions regarding the design, I took a step back
to look at the bigger picture, again.

new patches:
  clone: factor out checking for an alternate path
  clone: recursive and reference option triggers submodule alternates
  
The last patch redesigns completely how we approach the problem.
Now there are no new command line options (that relate to the problem
of marrying --recursive and --reference), but instead we communicate
everything via configuration options to have a lasting effect (i.e.
submodule update remembers the decision of the initial setup)

Thanks,
Stefan

v3:

Thanks to Junios critial questions regarding the design, I took a step back
to look at the bigger picture. 

--super-reference sounds confusing. (what is the super referring to?)
So drop that approach.

Instead we'll compute where the reference might be in the superproject scope
and ask the submodule clone operation to consider an optional reference.
If the referenced alternate is not there, we'll just warn about it and
carry on.


* fixed the style in patch 2.

* fixed another bug in the last patch, that is unrelated, but would have helped
  me a lot.

Thanks,
Stefan

 Documentation/git-clone.txt    |   9 ++++++++-
 builtin/clone.c                |  36 ++++++++++++++++++++++++++++--------
 builtin/submodule--helper.c    | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 git-submodule.sh               |   2 +-
 t/t7408-submodule-reference.sh | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------
 5 files changed, 217 insertions(+), 97 deletions(-)

v2:
 * fixed the p1,2 cleanups
 * added documentation to patches 5,6
 * improved commit message in v4
 
 Thanks,
 Stefan
 
v1:
 
 Currently when cloning a superproject with --recursive and --reference
 only the superproject learns about its alternates. The submodules are
 cloned independently, which may incur lots of network costs.
 
 Assume that the reference repository has the submodules at the same
 paths as the to-be-cloned submodule and try to setup alternates from
 there.
 
 Some submodules in the referenced superproject may not be there, 
 (they are just not initialized/cloned/checked out), which yields
 an error for now. In future work we may want to soften the alternate
 check and not die in the clone when one of the given alternates doesn't
 exist.
 
 patch 1,2 are modernizing style of t7408, 
 patches 3,4 are not strictly necessary, but I think it is a good thing
 to not leave the submodule related C code in a crippled state (i.e.
 allowing only one reference). The shell code would also need this update,
 but it looked ugly to me, so I postpone it until more of the submodule code
 is written in C. 
 
 Thanks,
 Stefan 

Stefan Beller (6):
  t7408: modernize style
  t7408: merge short tests, factor out testing method
  submodule--helper module-clone: allow multiple references
  submodule--helper update-clone: allow multiple references
  submodule update: add super-reference flag
  clone: reference flag is used for submodules as well

 builtin/clone.c                |  22 ++++--
 builtin/submodule--helper.c    |  45 ++++++++----
 git-submodule.sh               |  12 +++-
 t/t7408-submodule-reference.sh | 153 +++++++++++++++++++++++------------------
 4 files changed, 147 insertions(+), 85 deletions(-)

-- 
2.9.2.572.g9d9644e.dirty

