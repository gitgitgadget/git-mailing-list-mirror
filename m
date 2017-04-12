Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36AF41FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 20:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755307AbdDLUAw (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 16:00:52 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:32849 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755150AbdDLUAt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 16:00:49 -0400
Received: by mail-pg0-f51.google.com with SMTP id x125so19679556pgb.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QjhnVpbl1b4jZn6G3k8f9F/VVe8xN1HF6GBEeCkJI70=;
        b=Ea92stpmZFDZkwVXLyS4K2d56VKl9Hv1jGHiTqSQBMKs6Q9U5mcqXPqAk1wD2SypiD
         66mlOXZHjRdWjaEB/oath/okZlku3aLM+AW37FxLyPrFCXfV5vz2VxfMfsi5S4QAsTvc
         Xnwe3rAL6gyjOT8E5AwBiPPRi77ssTv9iXOTd9qQOQO2zZo5QBxKxxIAcH8rvD0knTLg
         Z9GA2N/C6xz2xhf3n+gzPc4Eyw+OBPvkcucEDIkVhN5rfKfNp0WIOdRo1Sdu/oYWrhaH
         ldn42MsRt7iD+I5zgyLuZ6zEiNtZge+3x5UIpuzwFuYMh3nbFUp+4hzHKGDp1Vd0B8WL
         /FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QjhnVpbl1b4jZn6G3k8f9F/VVe8xN1HF6GBEeCkJI70=;
        b=qjn6jHeK3MIZFs6AMaBOoHdlmnavHIkjQ3sqyJylQIu1hwCmU2rdk0/gnBXoQjT9Cx
         sqJU/yyPhojBaSAIwTjBT6/AI0cwwJDXlyBLvYfYespzJuA8gmhiIATsNRxhJLttNlrw
         or3pTBwDjRvWMcHPQNdRh24xptNjXiLm4KvpblU2gGJ7twdiBtdfAsh4XQo0e4lUdoIW
         ycnlaFQgT/yrpDDcbiM2xKeYGM+wp5ZcQgr5pFKh5Cz4ThVtz+W1VYJz/QEnlFUPTRxL
         2BCNZD4sdDypX+0I5+L4gVyLoZh/+4wJCfpkXGyibtTW5/LubRNeIXSqO7a7qIUznzWn
         73cA==
X-Gm-Message-State: AN3rC/6hvpW+uf5KOkaIZZ/TMvQkANVw7sP6iaOhmAeh3Pi6OvpSZn/Hn7FEYXMqIAEqZVy2
X-Received: by 10.98.157.150 with SMTP id a22mr20485645pfk.255.1492027244102;
        Wed, 12 Apr 2017 13:00:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:118b:650f:9c66:86dd])
        by smtp.gmail.com with ESMTPSA id q136sm31938173pfq.80.2017.04.12.13.00.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Apr 2017 13:00:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     mhagger@alum.mit.edu
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.h: rename submodule arguments to submodule_path
Date:   Wed, 12 Apr 2017 13:00:37 -0700
Message-Id: <20170412200037.18752-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.603.g7b28dc31ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In submodule land we carefully need to distinguish between the path of a
submodule and its name.

The path of a submodule is the path that is recorded in the working tree
of the superproject and describes where the submodule is bound to the
superprojects tree.

The name as introduced in 941987a554 (git-submodule: give submodules
proper names, 2007-06-11) exists to track submodules across renames of
submodules. It is also used for the internal path in .git/modules/<name>
to store the git directory of the submodule inside the superproject.

When looking up ref functions to use, I was confused which of the two
submodule properties are meant in the argument of the ref functions.
The context in which the functions were used however revealed it is the
path of the submodules.

Rename the arguments to clearly describe what is expected as an input
argument.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.h b/refs.h
index 3df0d45ebb..451f92958a 100644
--- a/refs.h
+++ b/refs.h
@@ -86,7 +86,7 @@ int peel_ref(const char *refname, unsigned char *sha1);
  * successful, return 0 and set sha1 to the name of the object;
  * otherwise, return a non-zero value.
  */
-int resolve_gitlink_ref(const char *submodule, const char *refname,
+int resolve_gitlink_ref(const char *submodule_path, const char *refname,
 			unsigned char *sha1);
 
 /*
@@ -204,16 +204,16 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
-int for_each_ref_submodule(const char *submodule,
+int head_ref_submodule(const char *submodule_path, each_ref_fn fn, void *cb_data);
+int for_each_ref_submodule(const char *submodule_path,
 			   each_ref_fn fn, void *cb_data);
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+int for_each_ref_in_submodule(const char *submodule_path, const char *prefix,
 		each_ref_fn fn, void *cb_data);
-int for_each_tag_ref_submodule(const char *submodule,
+int for_each_tag_ref_submodule(const char *submodule_path,
 			       each_ref_fn fn, void *cb_data);
-int for_each_branch_ref_submodule(const char *submodule,
+int for_each_branch_ref_submodule(const char *submodule_path,
 				  each_ref_fn fn, void *cb_data);
-int for_each_remote_ref_submodule(const char *submodule,
+int for_each_remote_ref_submodule(const char *submodule_path,
 				  each_ref_fn fn, void *cb_data);
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data);
-- 
2.12.2.603.g7b28dc31ba

