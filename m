Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E7C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0D820718
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 16:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfL3QdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 11:33:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35062 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfL3QdV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 11:33:21 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so26966365qka.2
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 08:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xv+iv3xYz/rmAiU/SgixPt6iU5d3SfEFKaUF9pBaleU=;
        b=lewst5sp7O/Xws4dS3HL05o2I1CwZLAxxXbKUzoMvQU6PNkPYp+ZYOXLGaOdsWmjKP
         4coFZmai3iXclGMLD9F0Jj1dxTc1zxC55A4kqoMKVMDOBkr+k8OBXQkEOXk7cPyQwlRa
         ntk12L7Umg356mbzC6rZ9qiEs90aHkDVH+awxo9HHyWK7hCuJ/du2zxSuanU2Eyn8VNd
         ds56A0IBOSlwoDnJ0+sPYWWHDxUuoF2TtDdEYdec9eJSy/AwiVPkyjxOjFPKBPFJvs4i
         fArWO2DTjn71YnN6FAMHETfYEhHyr27PI+k7dX3cfKN3Q9XRyyASZO1L5Vppb3h/8Pe3
         Wh2Q==
X-Gm-Message-State: APjAAAXhYhMk9KqcGZ23MjiPPrj77gxvNJ6PA5g2Xn1A328mbIT8QK1v
        Z7S7la5EY5aSLPwxRwtdaas=
X-Google-Smtp-Source: APXvYqz2KzmD4EA5PZqsmo+LCxv+bFwWudM9i6Fs7uLVLoYk31o2PpWk1BXdLlirdrSR80gc5PFePg==
X-Received: by 2002:a37:8684:: with SMTP id i126mr53863439qkd.132.1577723600732;
        Mon, 30 Dec 2019 08:33:20 -0800 (PST)
Received: from vmi286618.contaboserver.net (vmi286618.contaboserver.net. [164.68.111.199])
        by smtp.gmail.com with ESMTPSA id h28sm12509004qkk.48.2019.12.30.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 08:33:20 -0800 (PST)
From:   Arnaud Bertrand <xda@abalgo.com>
To:     arnaud.bertrand@abalgo.com
Cc:     git@vger.kernel.org, gitster@pobox.com, xda@abalgo.com
Subject: [RFC PATCH 1/2 v2] Add branchname in commit header
Date:   Mon, 30 Dec 2019 17:32:55 +0100
Message-Id: <20191230163256.14749-2-xda@abalgo.com>
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

Add the branchname in the commit header before the commit message
the following line is added:

branch <branchname>

where <branchname> comes from the function resolve_ref_unsafe("HEAD",...)
without the prefix refs/heads/
A placeholder is added to the pretty format "%Xb" to print the branch information,
X if for "extra-header" and can be use in the future for new features
b is of course for "branch"

the %Xb returns an empty string when branchname information is not found
---
 Documentation/pretty-formats.txt |  1 +
 commit.c                         | 11 +++++++++++
 pretty.c                         | 15 +++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1a7212ce5a..bd52908f53 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -241,6 +241,7 @@ endif::git-rev-list[]
 '%gE':: reflog identity email (respecting .mailmap, see
 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
 '%gs':: reflog subject
+'%Xb':: branchname in which commit was done
 '%(trailers[:options])':: display the trailers of the body as
 			  interpreted by
 			  linkgit:git-interpret-trailers[1]. The
diff --git a/commit.c b/commit.c
index 434ec030d6..f64a0698be 100644
--- a/commit.c
+++ b/commit.c
@@ -1425,6 +1425,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
+	const char *branch = "Unknown";
+	int flags;
+	const char *lbranch =resolve_ref_unsafe("HEAD",0,NULL,&flags);
 
 	assert_oid_type(tree, OBJ_TREE);
 
@@ -1453,6 +1456,14 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		author = git_author_info(IDENT_STRICT);
 	strbuf_addf(&buffer, "author %s\n", author);
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
+	if (lbranch) {
+	   skip_prefix(lbranch,"refs/heads/",&branch);
+	   strbuf_addf(&buffer, "branch %s\n", branch);
+	}
+	else {
+	   strbuf_addf(&buffer, "branch Unknown\n");
+	}
+
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
 
diff --git a/pretty.c b/pretty.c
index 305e903192..5961c39398 100644
--- a/pretty.c
+++ b/pretty.c
@@ -804,6 +804,7 @@ struct format_commit_context {
 
 	/* The following ones are relative to the result struct strbuf. */
 	size_t wrap_start;
+	char *branch;
 };
 
 static void parse_commit_header(struct format_commit_context *context)
@@ -1367,6 +1368,20 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 1;
 	}
 
+
+	/* Now add extra header info */
+	if (placeholder[0] == 'X') {
+		switch (placeholder[1]) {
+		case 'b': /* branch ... */
+			c->branch = get_header(msg,"branch");
+			if (c->branch)
+				strbuf_addstr(sb, c->branch);
+			free(c->branch);
+			return 2;
+		}
+	}
+
+
 	/* Now we need to parse the commit message. */
 	if (!c->commit_message_parsed)
 		parse_commit_message(c);
-- 
2.25.0.rc0.7.g17b02bf28a

