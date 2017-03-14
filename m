Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C0220951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbdCNVrt (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:49 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33027 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbdCNVrG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:47:06 -0400
Received: by mail-pg0-f50.google.com with SMTP id n190so7623457pga.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E88GWhqiN4aUzKRWzQKQy5f237l2BFwosCTG989X6N8=;
        b=F5/5WYbc75MmzupkkePSVVvQuRz597VCpBq/gMMI7KZvG7Rr2q0sbgfoPqeu2DfkLM
         9Bb1plRuoJ1lL94XY5W2Hw7rqnGlyWLRzjH+VqoMX0I6MO+b19wR0ljeA2M9nEa8He7L
         uJBJVfSeNqGx9oQYSRExZVzSFp6IeTTsP2V5WocfmGsB++GYcD7OmAcPuK/4pNpnZQgy
         WAZoA2/7UGE71v4LWwGzTiumVi7tOUvM1lvsF44Fl/dWZdRHMgRu53zJWOrpXGfo2ipk
         hn1g61nRqWGsKi60a9P5jlK6FyVvrXOIUG94Mp8FnnJKpfWDan5rTgc8+B7EusBHc3bB
         bssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E88GWhqiN4aUzKRWzQKQy5f237l2BFwosCTG989X6N8=;
        b=FLoLWG284SfE89WakrNwr34ta8FMuT7CeX3cncU9x4YDZHzQmDofUuaCkwfJiwaVx/
         S5JbK5iifwiev6sFAn7YIKl8b3sNi4zILvitkYIMJXVXrtLAPV0t9sUYxF714O88MwH3
         lazLvZ4uhkT0/KQYkVFl8WGaEFE1duEU/0H/oNIEI/D359PWNyiCeC8BswsrXtbsabb1
         3sbeaoxeI/bRy1Qlw4ZIHoE2eHNcLj0r1BED5dfoFx566osbKoFJhsmetSbm+AVCuhwL
         KsGMvA/SqVnspkl5e34jvl/24VDmbaYNGS7vHIiq46j6B1ZuwElXwIFJjzpuEVdEaBr0
         tdwg==
X-Gm-Message-State: AMke39nuJC7vpS3l+3CbTI+zKzBHJLuJhpdifOL2neEooD9CE0lYszOrC02tsTId5rPJo05b
X-Received: by 10.99.224.69 with SMTP id n5mr45672449pgj.113.1489528025324;
        Tue, 14 Mar 2017 14:47:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id n8sm40648586pgd.5.2017.03.14.14.47.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:47:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 13/19] submodule.c: get_super_prefix_or_empty
Date:   Tue, 14 Mar 2017 14:46:36 -0700
Message-Id: <20170314214642.7701-14-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we need to use the super_prefix, and
in case it is NULL we can just assume it is empty.
Create a helper function for this.

We already have some use cases for this helper function,
convert them, too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0b2596e88a..3501497a78 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1239,6 +1239,14 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
+static const char *get_super_prefix_or_empty()
+{
+	const char *s = get_super_prefix();
+	if (!s)
+		s = "";
+	return s;
+}
+
 static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
@@ -1438,11 +1446,8 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
 		die(_("could not create directory '%s'"), new_git_dir);
 	real_new_git_dir = real_pathdup(new_git_dir);
 
-	if (!prefix)
-		prefix = get_super_prefix();
-
 	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
-		prefix ? prefix : "", path,
+		get_super_prefix_or_empty(), path,
 		real_old_git_dir, real_new_git_dir);
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
@@ -1513,8 +1518,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
 			die("BUG: we don't know how to pass the flags down?");
 
-		if (get_super_prefix())
-			strbuf_addstr(&sb, get_super_prefix());
+		strbuf_addstr(&sb, get_super_prefix_or_empty());
 		strbuf_addstr(&sb, path);
 		strbuf_addch(&sb, '/');
 
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty

