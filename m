Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5081FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 18:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbcLES7M (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 13:59:12 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34610 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcLES7J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 13:59:09 -0500
Received: by mail-pg0-f46.google.com with SMTP id x23so139540831pgx.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 10:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=p14L6uWrtTV3PdJp7AlmP2eLIrzJq/5z8vMMXnMQ7pE=;
        b=Q/zPpYjHF+uGPDYGde2AJZAHffFdy9MkfFf+dm6pKLkuAuqgvT9u1WGVGJBMZqjL69
         jKe/0l5RBFZMZYdfNGLMFAYqWzj5SbCbHkZ/orL8K8ESPPCo9Lr8xmy2Agiz4aQjiBgV
         ZNKN6yaI14oZ7aR3blDkhMyB238oUI3+SYC8+gvW8C7L8RatYzhWpNX54p32/5bh6xAg
         SspvhjFKb7t17A0yeXiJjiUgMdBcognAjbqqPUQKDUwIWlSLfrVvTn/ZjFv17ohJCCh2
         hztLFhcArtabgBH7NajCIPsiJlCV2OrdMnfKVS+IgM91pi5UmTLTTKWgx4m8+cTkT2gF
         fdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p14L6uWrtTV3PdJp7AlmP2eLIrzJq/5z8vMMXnMQ7pE=;
        b=g2yyFO4BAHAydc5QvlxOT/2qVcJ6EKwJhMV5cn4AlWSl4Lza7yVKn7duiwpanz0DpR
         BKzEHK4cMckqdFZTcFD3FHIMF+K1LeujTmo5x0YP13Kwvmsar3+samOZGFK0f9Sc8Jtq
         o4od0iqD3uHNSH1hS3+xHUppskh8ImKDdld112byav1HM9qIdu83lIcKxaY8ISzxxKVg
         uB8iulR43UWZUaV/GvfKRuWaudIzbpZnn7F9XHkHWQqxAhjOUuqTuNPuVcmHUA0KVwg+
         ftsn0VLgLEjQ0thtZ+eNilBOABx1WhWBKJzI482WX0kj09R16yW6oUWBv46KrmZrH4zS
         Lwug==
X-Gm-Message-State: AKaTC03E0w2nwFIWBaDabyQyHrEcYSVFb9OSUWLT43jMSn/12+B/GB9l7QT+Tez7BdZwZpkx
X-Received: by 10.84.178.195 with SMTP id z61mr129768757plb.176.1480964327065;
        Mon, 05 Dec 2016 10:58:47 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id t193sm29394125pgb.4.2016.12.05.10.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 10:58:46 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com
Subject: [PATCH] making real_path thread-safe
Date:   Mon,  5 Dec 2016 10:58:35 -0800
Message-Id: <1480964316-99305-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The goal of this patch is to make the function real_path thread-safe.  To do,
the current logic which uses chdir() to do the symlink resolution needed to be
rewritten to perform the symlink resolution by hand.

I wanted to get the bulk of the work out there for review quickly so
technically this patch doesn't make real_path thread safe yet as it still uses
a static buffer to serve up the resultant path.  On a future iteration I plan
on removing this and pushing ownership of the returned string to the callers.

For more information on why this change is desirable you can see the following
threads:

https://public-inbox.org/git/20161129010538.GA121643@google.com/
https://public-inbox.org/git/1480555714-186183-1-git-send-email-bmwill@google.com/

Brandon Williams (1):
  real_path: make real_path thread-safe

 abspath.c | 183 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 122 insertions(+), 61 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

