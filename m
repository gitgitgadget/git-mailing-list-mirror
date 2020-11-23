Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4A6C56201
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 03:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDBF20DD4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 03:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgKWDZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 22:25:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37724 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKWDZK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 22:25:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id h11so4197894qkl.4
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 19:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOJDSCLA4uBi7U/DCo529jaI92ak7Qx/un/kYlewE+U=;
        b=oH6wNYWtwIRUQ8rFFc1hE9uJiG5gfvaTOtb3ShGGAgCpicQRlZyOYWA5q3mfywUYne
         rteJYvCcD3jFgJ9FQZuusNDs5lH39TBMHIZYcNYxgu+PJ8A80ImkNNz2JKJcXhQhiBv0
         cTE2iDrkKG3VUW/f20jA97XrJDuOpSFvYdXHte7aXFI6eTOLrFR55p+8N9SN8vyq1Lfh
         lnXFz9WFrVWeygbLma5rHKCrHtr9JTcS+DshRXyNX4ct43CQhdWFSK5TPf8opQbJVmbZ
         4FeN+H4fD6EMHSmTrQphhgPtUNwnZA1frEi6HM8/dAUBAxi9mGPnd1FVgOv39IyEc0Ek
         VjKQ==
X-Gm-Message-State: AOAM531Q0SdqZQDBYrPRvsw2qLrqXo6/OHyxdF2xLPQuM4KBv02BKJ9r
        x39Z9o9+gmLqf6VyBlvNFH+yjBAqULQJtzpq
X-Google-Smtp-Source: ABdhPJx+NPKNKsb4B1jB4/AJJYMOFfsvPy4BDAqhJud+VCJ9Wm88sa2A+HsF++1HTOtxRjef5o7xjg==
X-Received: by 2002:a37:a484:: with SMTP id n126mr28057588qke.277.1606101909233;
        Sun, 22 Nov 2020 19:25:09 -0800 (PST)
Received: from crimescene.lan (pool-100-16-98-84.bltmmd.fios.verizon.net. [100.16.98.84])
        by smtp.gmail.com with ESMTPSA id c6sm8906341qkg.54.2020.11.22.19.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 19:25:08 -0800 (PST)
From:   nate@roosteregg.cc
To:     git@vger.kernel.org
Cc:     Nate Avers <nate@roosteregg.cc>
Subject: [PATCH 1/2] notes.c: fix a segfault in notes_display_config()
Date:   Sun, 22 Nov 2020 22:23:41 -0500
Message-Id: <20201123032342.24566-2-nate@roosteregg.cc>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201123032342.24566-1-nate@roosteregg.cc>
References: <20201123032342.24566-1-nate@roosteregg.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nate Avers <nate@roosteregg.cc>

If notes.displayRef is configured with no value[1], control should be
returned to the caller when notes.c:notes_display_config() checks if 'v'
is NULL. Otherwise, both git log --notes and git diff-tree --notes will
subsequently segfault when refs.h:has_glob_specials() calls strpbrk()
with a NULL first argument.

[1] Examples:
.git/config:
[notes]
	displayRef
$ git -c notes.displayRef [...]

Signed-off-by: Nate Avers <nate@roosteregg.cc>
---
 notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index 564baac64d..d5ac081e76 100644
--- a/notes.c
+++ b/notes.c
@@ -970,7 +970,7 @@ static int notes_display_config(const char *k, const char *v, void *cb)
 
 	if (*load_refs && !strcmp(k, "notes.displayref")) {
 		if (!v)
-			config_error_nonbool(k);
+			return config_error_nonbool(k);
 		string_list_add_refs_by_glob(&display_notes_refs, v);
 	}
 
-- 
2.27.0

