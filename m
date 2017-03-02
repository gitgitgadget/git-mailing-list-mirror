Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEECB2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753737AbdCBAy6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:54:58 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34732 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753506AbdCBAy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:54:57 -0500
Received: by mail-pg0-f42.google.com with SMTP id p5so25794022pga.1
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I49cdIY692cNxXXg6mMOhCCWvMr23IYel2AVRIh9eJQ=;
        b=Jo8/InAJQHHcgzfmXptSWyUhxYvb0FOLpdlL5Qd4LSH3pFIPEZjnNKds0I7CW+c4u6
         OZddAlQT+NLiY+8Ta/NXKhkOzHOug0xl/WeBk8otSytZRcLN2oZX58fI8gcg2slvuAAB
         qOD+rPDWfIyuyeOev46brhQXYGhQxSMLx7vz06BLRqlg8aiPe9jTr/7w9hOg4zkRgAO8
         9jguMLoWPYpr6Wm6ppS+xXFHWQ/8/77AyoDXVPVPdXyxU9M7ASh/Ze/2y8VHD7eGSJ48
         5AJc5TnNN/17yxMaQ1Xw7DB2AKPZCazBJUeBN8fvsOvS7aJdN0V+fk3fD43lWj2FisRt
         5HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I49cdIY692cNxXXg6mMOhCCWvMr23IYel2AVRIh9eJQ=;
        b=doBAh27rbU6aklCNiRmn0A7wC9+I3+khf7xHPB50Mb6M3UV6ro2tCkcFd9eLFg8L/i
         cT9x6cr1swMzbufjKneb3l3fb0lGCx03ihC975JWGCI3iUZJFqN3blF1Q0oA1Pa/ZNOz
         w6gtokfka5+9zFIUoiKYEvNxeJcbZfDToIa/JHjAWW+Fh4LatbafyPxjnFMKOH4iS2Yn
         1jGVgDEI/eJY8eJakQkIf6WLFleDX4Vd0R5arAX5ke8T0Be7IWf11e8Z6ixmVvYV7Nb0
         rzKAO6ilHFxW1F01Trv5feeQT6Xd4XXGB1vQmWyEOnYSFJQ/v5dR6V5SLjpB6Cutbybp
         7XQA==
X-Gm-Message-State: AMke39lbLcNI1NKwJlHUeMd6xzwCbX9m9ZprQPCjrSKE4SHODkcBWnuTBHo6eDxU7EF5hsOH
X-Received: by 10.98.16.14 with SMTP id y14mr12177107pfi.63.1488415696753;
        Wed, 01 Mar 2017 16:48:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id d68sm12750256pfj.92.2017.03.01.16.48.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 10/18] submodules: introduce check to see whether to touch a submodule
Date:   Wed,  1 Mar 2017 16:47:51 -0800
Message-Id: <20170302004759.27852-11-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we introduce the --recurse-submodule flag for commands
that modify the working directory, e.g. git-checkout.

It is potentially expensive to check if a submodule needs an update,
because a common theme to interact with submodules is to spawn a child
process for each interaction.

So let's introduce a function that checks if a submodule needs
to be checked for an update before attempting the update.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 16 ++++++++++++++++
 submodule.h |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/submodule.c b/submodule.c
index 591f4a694e..8b2c0212be 100644
--- a/submodule.c
+++ b/submodule.c
@@ -548,6 +548,22 @@ void set_config_update_recurse_submodules(int value)
 	config_update_recurse_submodules = value;
 }
 
+int should_update_submodules(void)
+{
+	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
+}
+
+const struct submodule *submodule_from_ce(const struct cache_entry *ce)
+{
+	if (!S_ISGITLINK(ce->ce_mode))
+		return NULL;
+
+	if (!should_update_submodules())
+		return NULL;
+
+	return submodule_from_path(null_sha1, ce->name);
+}
+
 static int has_remote(const char *refname, const struct object_id *oid,
 		      int flags, void *cb_data)
 {
diff --git a/submodule.h b/submodule.h
index b4e60c08d2..6f3fe85c7c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -65,6 +65,13 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
+/* Check if we want to update any submodule.*/
+extern int should_update_submodules(void);
+/*
+ * Returns the submodule struct if the given ce entry is a submodule
+ * and it should be updated. Returns NULL otherwise.
+ */
+extern const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
2.12.0.rc1.52.ge239d7e709.dirty

