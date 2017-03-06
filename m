Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E661520133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbdCFVG4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:06:56 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33505 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754130AbdCFVGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:06:53 -0500
Received: by mail-pg0-f44.google.com with SMTP id 25so70455805pgy.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I49cdIY692cNxXXg6mMOhCCWvMr23IYel2AVRIh9eJQ=;
        b=ZO48zjCSE67vBUZqfeV+nc8p1CfWSQ0fHl8N5+pxKMTEsPwS68q+DoV+GwTNUl7EnR
         /ubZiotLYsWv4L5meylpzyQgjTH6dOtFTr5lmOIaiOw2jFjDulr8A8dO0rUIAHmuUKvK
         p70I1SH2EgOOskz6egQlybCXFXGu36gxBWCqrlC7B1z18B781VptOZmBUQeum9IVqlkr
         oQsD+Sceonbt+mUuoiqnLOYh1XW3uHXgJAa4Y6YWjToKKR3NbNK7tWEDIWLhzkkUCiG6
         qNwj1aK0nS4iYCgbRLNdkC0gY4IeoL+u1QobAnFMXuhazI4/c3n+eSj3qCFq/nGd6+Si
         cKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I49cdIY692cNxXXg6mMOhCCWvMr23IYel2AVRIh9eJQ=;
        b=MPYDiwXfsywQKowID0BhVYsj7ikFy+KGStz/o4HRlKG3gzwkB6SOjisagw6P5AgI6S
         IUO/ye1iYeMAAyfdFMPNrEEw38sWHLCrdshEqCgvyfLEcRSUnThWsaAHlCAse4IQaZo9
         EdOxz+oaeieXAFFMoDH82FKJNpc85CvIJ9FvwWqSkg0vRf7F4MK1RWYgRjpSQLpvdHhe
         Wcw9UFOPloIYLdhdDed0eB9NZuu7wO9gWiJlecJZ4LHWfb6gEzRGLq9Rh4HYDbA2c/Sm
         TGTLWw+/8lwYwj9bdcu1N7S9K56zyuF0KCA2Wt3YdWu4oK+DyrmrD+YsLsT63KzNmIux
         ewFg==
X-Gm-Message-State: AMke39kfPPJW34v/PuWyT+aipwAoQIHlxekKV/s0i7IM1mb/f7uyj3ZdEl+tJxzt6RTJ+XMY
X-Received: by 10.98.216.202 with SMTP id e193mr23797302pfg.80.1488833976140;
        Mon, 06 Mar 2017 12:59:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id 23sm17152712pfz.127.2017.03.06.12.59.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 10/18] submodules: introduce check to see whether to touch a submodule
Date:   Mon,  6 Mar 2017 12:59:11 -0800
Message-Id: <20170306205919.9713-11-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
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

