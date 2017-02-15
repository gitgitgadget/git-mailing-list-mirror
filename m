Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3D22013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbdBOAfY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:24 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:36773 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdBOAfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:20 -0500
Received: by mail-io0-f177.google.com with SMTP id j13so79855527iod.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NdaaqjQWOPw3CDy7xXP6YIvt3o5JVsgBSNLdH8ypRc0=;
        b=jVZILH2GdON32L/drdspWp9aj0wSvUxnik1pPUMBprpvi5yuRgWKWU6BS1ki3AOXt4
         T9ouiKEyrP5F8ST9EAHLS4i35qnken9LAk6GPsHlPgV0IJlJXvX0zu9++7ydGp/9qjSx
         1+li6i5Cs5Jxe2g3b09zpJ+2PyFc5RP3a4c2ql2F9iGoAb2kRTDktQdQ8/9fw9r7g9sw
         d/Yo1dqhoNCqTiydonKVMfgDEvtCR4nAXuk+x3pUMyf3zT9hURkg/w3fx0eMVLRGeUih
         PUhgMSpILN5a4mRL5Nw+Qre534hS54E2zb70cd0H3WWUmTcReN1aFXts91iMK/t8Zg9U
         mCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NdaaqjQWOPw3CDy7xXP6YIvt3o5JVsgBSNLdH8ypRc0=;
        b=Q4R32HZS/m29hDeJrPoY+bI/3x/V4yIsGjWQhJQTAgUZsQgq4OBHoD3IBOIbu1OTd/
         +5EEi8UanNYYdrASnhW9kbCeDbXcgs2YUa/bTXirDj7bjZMKE0oDzFHPz4r3XyMHENDt
         X7an6/NWuPRWJbOJtzBBWYSw9bjkqRhFX+Tgwti3YQ3ibj2XA6kxxbVuC8XDZlOhZzuK
         p5+7uE96tBc0NGxuUhCUyl7/ruQd+JVjAipWGUFuHELGQLe9nBI6O7SsT9NYhJpWrGck
         8oZvIIdz/8OGnY0DU+HlC9cL4g+yhbDqzGjAi36a+n54sZyN/8+CcIwNDDEGvgPHrmxy
         pjAA==
X-Gm-Message-State: AMke39ljytUhaAEWmH7+XVIQErgCSNumjee/Dcg/3AeHd2CoGDxmjv+SUBOaTnNNSt5EY/ZK
X-Received: by 10.98.91.131 with SMTP id p125mr34421431pfb.165.1487118909029;
        Tue, 14 Feb 2017 16:35:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id t6sm3387089pgt.8.2017.02.14.16.35.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/14] connect_work_tree_and_git_dir: safely create leading directories
Date:   Tue, 14 Feb 2017 16:34:13 -0800
Message-Id: <20170215003423.20245-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we'll use connect_work_tree_and_git_dir when the
directory for the gitlink file doesn't exist yet. Safely create
the directory first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dir.c b/dir.c
index 4541f9e146..69ca3d1411 100644
--- a/dir.c
+++ b/dir.c
@@ -2735,6 +2735,8 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
+	if (safe_create_leading_directories_const(file_name.buf))
+		fprintf(stderr, "could not create directories for %s\n", file_name.buf);
 	write_file(file_name.buf, "gitdir: %s",
 		   relative_path(git_dir, work_tree, &rel_path));
 
-- 
2.12.0.rc0.16.gd1691994b4.dirty

