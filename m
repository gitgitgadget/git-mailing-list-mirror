Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82AB720756
	for <e@80x24.org>; Wed,  4 Jan 2017 22:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761568AbdADWBm (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 17:01:42 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33700 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968462AbdADWBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 17:01:41 -0500
Received: by mail-pf0-f170.google.com with SMTP id d2so84083066pfd.0
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 14:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27oBlMatSduaLDwir0r22HgVB+3v61K8YzCLvf46EmM=;
        b=Cq3XJinx9doDa7G19TXMa8fpNk+guHVUWfVRCDtA37gCE8yFrwEXT0DoHcvwVhMbs7
         1qLfmTlQD9rAAYAHijfcG4nFnZDtcaW6fdmM/SljZ7CwLDbAAXHkLsmUt4yWaTfBbpZb
         I3AYCyT8nUpUXf8KI1+CGl4Fhob9E8gCs7gIsDCaGzUd4H2F2G7PsAL+l5VOZdE7Q2l1
         xxfS0/NjydTPDIpFeKU3XI3U5/hnzd0Y25wUBT+Z9wK4N2JH4Xb5C1YqS8o4HH7fDJiy
         RNSzHh/VfL9OerI+nOGl2delwFvbCThKUoiQ2QhlsohOuEwxk361xg84kO5RrFFkAZ+Z
         yTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27oBlMatSduaLDwir0r22HgVB+3v61K8YzCLvf46EmM=;
        b=hAPmEHAjpj8ClyH2Dgl4ahAoZ9JF1DspN8lJtKvxW9TSfXIri+FcuZlGZ54bTXRNvb
         o8PZMGJEAez0AQdue9hCiLpqKY545dSpYIB1H2BltXrzxr+LtT8ChqjIuA/CN8uYwR/j
         C7b8AuVt1+wjDOrSIVm8tdV8kLIsLOo+fpAsRyuG0ai09VzOGUffuez0G4mru1wvC7iv
         ydbD95OCB8o9bcHc/VdGJ2Ubo/aWOTVpBjsAgSclkd3+XX65+28d25RYBp2igK7x+uoH
         /c4o4Xu0gBW9K4tcjguC/0ZI4Zd2gGAEgHO1Oj5PqERRWeIzXr2uZ2t/oEJlayx27ntz
         PcPg==
X-Gm-Message-State: AIkVDXLvDQxbmBz043ICFOslY1qWAHmB8AnS5qgHUjPwLWsBSnen+rZjPtzeH4NSYTsMkDiq
X-Received: by 10.84.234.9 with SMTP id m9mr119299235plk.49.1483567292038;
        Wed, 04 Jan 2017 14:01:32 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id n29sm550351pfg.80.2017.01.04.14.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 14:01:30 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 0/5] road to reentrant real_path
Date:   Wed,  4 Jan 2017 14:01:19 -0800
Message-Id: <20170104220124.145808-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103190923.11882-1-bmwill@google.com>
References: <20170103190923.11882-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

changes in v5:
* set errno to ELOOP when MAXSYMLINKS is exceded.
* revert to use MAXSYMLINKS instead of MAXDEPTH.
* If the OS hasn't defined MAXSYMLINKS, use a fallback value of 32.

Brandon Williams (4):
  real_path: resolve symlinks by hand
  real_path: convert real_path_internal to strbuf_realpath
  real_path: create real_pathdup
  real_path: have callers use real_pathdup and strbuf_realpath

Johannes Sixt (1):
  real_path: canonicalize directory separators in root parts

 abspath.c         | 231 +++++++++++++++++++++++++++++++++++++-----------------
 builtin/init-db.c |   6 +-
 cache.h           |   3 +
 environment.c     |   2 +-
 setup.c           |  13 +--
 sha1_file.c       |   2 +-
 submodule.c       |   2 +-
 transport.c       |   2 +-
 worktree.c        |   2 +-
 9 files changed, 178 insertions(+), 85 deletions(-)

--- interdiff with v4

diff --git a/abspath.c b/abspath.c
index 3562d17bf..fce40fddc 100644
--- a/abspath.c
+++ b/abspath.c
@@ -62,7 +62,9 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
 }
 
 /* We allow "recursive" symbolic links. Only within reason, though. */
-#define MAXDEPTH 5
+#ifndef MAXSYMLINKS
+#define MAXSYMLINKS 32
+#endif
 
 /*
  * Return the real path (i.e., absolute path, with symlinks resolved
@@ -138,10 +140,12 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			ssize_t len;
 			strbuf_reset(&symlink);
 
-			if (num_symlinks++ > MAXDEPTH) {
+			if (num_symlinks++ > MAXSYMLINKS) {
+				errno = ELOOP;
+
 				if (die_on_error)
 					die("More than %d nested symlinks "
-					    "on path '%s'", MAXDEPTH, path);
+					    "on path '%s'", MAXSYMLINKS, path);
 				else
 					goto error_out;
 			}

-- 
2.11.0.390.gc69c2f50cf-goog

