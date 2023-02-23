Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E72BC64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 07:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjBWHaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 02:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjBWH35 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 02:29:57 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B8B3251F
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 23:29:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id ky4so12955092plb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 23:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeIMhcbJ2DVoI7uyk5qxWZf5i6kxq56B6BUvacGWnC4=;
        b=FVkTnFTwtRvchGLDn7e/xaAEnb6CgXEhASgw+zJrhV//h7SJpk3K/gwGUqcVSHbWVa
         HbwdgvtKBrUyYjrxoop5q0M4Co8VEORIUSElFP/LdychyeYTpZ/HQ9Ol6tXC64O27etz
         z8RWIXShLqlxpggtyppJlKpTRGbnjyYNEf1U2M8hgwrJamDdhQJuMJXltS1lMLgndPIF
         ZeT4JcohLuHzSP8HmcsMApPe2MaVEhg0U122zb29On/PUNSIn3TxIwW2LOhFc9FODNdZ
         xfjt2h9VBYyDyI1qH5hGjPQZX4yYIjlutMr0PIXT9WH0zXlsxdEv656e2OpLn9dWr4++
         SiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeIMhcbJ2DVoI7uyk5qxWZf5i6kxq56B6BUvacGWnC4=;
        b=n8pO/P4UNJKopWAyyq2hO2of7xz8AqnfMGF8mDxkKHfkWYUpt0yL21VadIYOIgz1Kn
         hXywGhJ++ZXyQLmIJasGTmStPOHVVMu4a8wImtVhpsH3pQZnZemmuoI31cl8EeuTZb2A
         wfpr1in1owLJyycXImdvp4y57HevsaOAFRglVVSLV0WKi3dYv1v8fJ70IKcuFyDSDtuK
         BfJ6zpeZVDTa10elV1wjpdfjWucyB10ZibCLfvXMer9A/S6eF5lFje6qyalQcJe+9bJH
         WZIq7DSWf44Jr7c5pRQQqqb3TyseB4GGlcGftYVzT76CxVtMZEmEwU9HVjbOOjWA6cgA
         vGfg==
X-Gm-Message-State: AO0yUKVG0O9Jkhcc6g003qNzzsx0ZvCgxhUDv+9H/w81m2kGcdJYq1Xd
        5mdqfrBsBdoLUHGt4gVLwBU=
X-Google-Smtp-Source: AK7set9w7XEyIJAyN1pWgr6Jy96Q8qmuqyojzAjDSSMJl1U4nGl5hMelLZ+khfGnkkmy2LVC3F8ojw==
X-Received: by 2002:a05:6a20:7f9c:b0:cc:24de:6a72 with SMTP id d28-20020a056a207f9c00b000cc24de6a72mr1227716pzj.61.1677137396294;
        Wed, 22 Feb 2023 23:29:56 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id u20-20020a62ed14000000b0059085684b54sm5570364pfh.140.2023.02.22.23.29.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2023 23:29:55 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v6 1/3] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Thu, 23 Feb 2023 15:29:45 +0800
Message-Id: <b029ee0b51151b054c6f2c76968f88fb2ceec1af.1677136319.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.39.2.459.gd5a6c747
In-Reply-To: <cover.1677136319.git.dyroneteng@gmail.com>
References: <cover.1677136319.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Let's cleanup the unnecessary 'strbuf_grow' call in 'append_edit'. This
"strbuf_grow(&d.buf, size + 1);" is prepared for insert a blank line if
needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
"\n");" will do the "grow" for us.

348f199b (builtin-notes: Refactor handling of -F option to allow
combining -m and -F, 2010-02-13) added these to mimic the code
introduced by 2347fae5 (builtin-notes: Add "append" subcommand for
appending to note objects, 2010-02-13) that reads in previous note
before the message.  And the resulting code with explicit sizing is
carried to this day.

In the context of reading an existing note in, exact sizing may have
made sense, but because the resulting note needs cleansing with
stripspace() when appending with this option, such an exact sizing
does not buy us all that much in practice.

It may help avoiding overallocation due to ALLOC_GROW() slop, but
nobody can feed so many long messages for it to matter from the
command line.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 80d9dfd2..23cb6f0d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -215,7 +215,6 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 
 	BUG_ON_OPT_NEG(unset);
 
-	strbuf_grow(&d->buf, strlen(arg) + 2);
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 	strbuf_addstr(&d->buf, arg);
@@ -618,7 +617,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		enum object_type type;
 		char *prev_buf = read_object_file(note, &type, &size);
 
-		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
 			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
-- 
2.39.2.459.gd5a6c747

