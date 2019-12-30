Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7D9C2D0D3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A4420718
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfL3QdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 11:33:24 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35874 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfL3QdW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 11:33:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id q20so29953278qtp.3
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 08:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pS3NsAOYybYW05APlZQhhtSxyaOh952yiOgmg9IxII=;
        b=g8v1KxU8ejqeYVBc9T7U/3PCB2bPMPYGPtde8B1B1EyfBSVW2UJnkCuJv7xRf0IY5v
         Up30/m7BGSOrXlF9mWwdTOizT0ECOlH7FXc4bbS7JDZTBQPq/TaSXSvCSfDQYIwTKOi4
         bb8JGFCNIecP0sSKODqn3jesxJYx125fcfMs0ZUX9xr2M7ZUzxKwW+TWJ4EHkm25rOWB
         6yEzWECQzLOWDSTKf1/QKL3y52/DFjJdfJXzNGBl/ZMlJpz5OI9+kmEl5ip56OCV0+Jp
         6fmkmUd+B2qhea3iXOBn+GaUddUwT780l/N6IrYW5uaGDKYFY2YfIN16hIrDEcGD9a3Y
         XjVA==
X-Gm-Message-State: APjAAAVUyME1fjMI9qUlRwduJ3R0AHx9A2fz9rMNKTBBEIpZTPzgTM3K
        Fh56zZGYXBZ4Zklz9KANyNk=
X-Google-Smtp-Source: APXvYqzBC7sQXPcZ1Wt/taCI/zlcH91fyxwg+s+Lehcy021badfwRKfFX1IcTl/Dv4E08NqWJWOKLg==
X-Received: by 2002:ac8:1496:: with SMTP id l22mr45270690qtj.38.1577723601954;
        Mon, 30 Dec 2019 08:33:21 -0800 (PST)
Received: from vmi286618.contaboserver.net (vmi286618.contaboserver.net. [164.68.111.199])
        by smtp.gmail.com with ESMTPSA id h28sm12509004qkk.48.2019.12.30.08.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 08:33:21 -0800 (PST)
From:   Arnaud Bertrand <xda@abalgo.com>
To:     arnaud.bertrand@abalgo.com
Cc:     git@vger.kernel.org, gitster@pobox.com, xda@abalgo.com
Subject: [RFC PATCH 2/2 v2] Add the configuration parameter core.branchnameincommit
Date:   Mon, 30 Dec 2019 17:32:56 +0100
Message-Id: <20191230163256.14749-3-xda@abalgo.com>
X-Mailer: git-send-email 2.25.0.rc0.7.g17b02bf28a
In-Reply-To: <20191230163256.14749-1-xda@abalgo.com>
References: <20191229222633.23815-1-arnaud.bertrand@abalgo.com>
 <20191230163256.14749-1-xda@abalgo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this parameter, which is 0 by default (no change compare
to the normal behaviour) you have the possibility to activate
this feature to have the branchname in the header commit
When it exists, the branchname is accesible in the git log
with the pretty format placehoder "%Xb".
---
 cache.h       |  1 +
 commit.c      | 24 +++++++++++++++++-------
 config.c      |  5 +++++
 environment.c |  1 +
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 1554488d66..dd7188a4e4 100644
--- a/cache.h
+++ b/cache.h
@@ -949,6 +949,7 @@ void reset_shared_repository(void);
  * commands that do not want replace references to be active.
  */
 extern int read_replace_refs;
+extern int branchname_in_commit;
 extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
diff --git a/commit.c b/commit.c
index f64a0698be..e63d97d308 100644
--- a/commit.c
+++ b/commit.c
@@ -1428,6 +1428,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	const char *branch = "Unknown";
 	int flags;
 	const char *lbranch =resolve_ref_unsafe("HEAD",0,NULL,&flags);
+	int flbranchinextra = 0;
 
 	assert_oid_type(tree, OBJ_TREE);
 
@@ -1456,21 +1457,30 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		author = git_author_info(IDENT_STRICT);
 	strbuf_addf(&buffer, "author %s\n", author);
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
-	if (lbranch) {
-	   skip_prefix(lbranch,"refs/heads/",&branch);
-	   strbuf_addf(&buffer, "branch %s\n", branch);
-	}
-	else {
-	   strbuf_addf(&buffer, "branch Unknown\n");
-	}
 
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
 
 	while (extra) {
+		/* when commit is reworked - e.g. amend, the banch is already
+		 * in extra-header and must not be modified
+		*/
+		if (!strcmp(extra->key,"branch"))
+			flbranchinextra=1;
 		add_extra_header(&buffer, extra);
 		extra = extra->next;
 	}
+
+	if (branchname_in_commit && !flbranchinextra) {
+		if (lbranch) {
+			skip_prefix(lbranch,"refs/heads/",&branch);
+			strbuf_addf(&buffer, "branch %s\n", branch);
+		}
+		else {
+			strbuf_addf(&buffer, "branch Unknown\n");
+		}
+	}
+
 	strbuf_addch(&buffer, '\n');
 
 	/* And add the comment */
diff --git a/config.c b/config.c
index d75f88ca0c..bec1b5c3af 100644
--- a/config.c
+++ b/config.c
@@ -1389,6 +1389,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.branchnameincommit")) {
+		branchname_in_commit = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return platform_core_config(var, value, cb);
 }
diff --git a/environment.c b/environment.c
index e72a02d0d5..1d266a91cf 100644
--- a/environment.c
+++ b/environment.c
@@ -52,6 +52,7 @@ const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int read_replace_refs = 1;
+int branchname_in_commit = 0;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
-- 
2.25.0.rc0.7.g17b02bf28a

