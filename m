Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AF4C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7724B207FF
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="d9aYmoDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgA2LMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:12:55 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:55530 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgA2LMy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 06:12:54 -0500
Received: by mail-wm1-f44.google.com with SMTP id q9so5729405wmj.5
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 03:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3rJXkQcvBkC7QElQ/CrQky97opFGu5PmDRq10iWpU8=;
        b=d9aYmoDP9cTTIgSqRh05kpjuKnNCVRPBxnBqhu+g2/y+6A1LIZC9VeQWaBXhRqzoAl
         2cU8krytj9oGFXFKVnuTl8PpcmZGOqTvF9EXiJVXwUYTVpoKAdnbL8F0t0P3zhwLzG6b
         XNMXcvH2dldtWSR1aB+9tGHWovfe7aOEaOxsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3rJXkQcvBkC7QElQ/CrQky97opFGu5PmDRq10iWpU8=;
        b=rNrjX2f3PglOcJI1aqPp+yvf4uJ0KK1ocIGhvF4n13hMDMNQu/tF8Eg18lKjfthYjA
         jhuUu7aDk3h6k9KFiWLnOYG2gwln1Pkx7G7hGl2gl+mPHfPUxuTymFJcRMgXhYzQhAqc
         qsaV9W8gJTXgfJtIB9BrOZGgdhN9y+cPVd4UmaBVI9OXKfTPhhOoIS7qTylnX3CqfBqI
         1a0IZ7mn4OR6fn+yK7Lzfi/dWknQoNX73eQpsE5FSSfGoICYo+O1PM8sMVRHGnAKVRtx
         b4XgWxz/SPjRdPyLwUrCE18JdIcYeASzVxQKB+YqIemNaOd16Dbai4TdKvwzMeR+OJPO
         a8Kg==
X-Gm-Message-State: APjAAAVkOalROE7CYuxpnIDV4QWIxx+kFH31e5jpDN6LA8hmDn3isWo2
        yE0fmnZvOLIDops6iOVWv/S8C1sIeiU=
X-Google-Smtp-Source: APXvYqzCgmW7ddpzl4A0YPvWVzH0Jxz3efR0f3zvrs7t+fG4i7od7FpEXnFXBGdVy3anPvsQzpMh6A==
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr10942241wme.161.1580296372393;
        Wed, 29 Jan 2020 03:12:52 -0800 (PST)
Received: from ethel.corp.roku ([85.118.3.105])
        by smtp.gmail.com with ESMTPSA id z6sm2226241wrw.36.2020.01.29.03.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:12:51 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/6] git-p4: add P4CommandException to report errors talking to Perforce
Date:   Wed, 29 Jan 2020 11:12:42 +0000
Message-Id: <20200129111246.12196-3-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20200129111246.12196-2-luke@diamand.org>
References: <20200129111246.12196-1-luke@diamand.org>
 <20200129111246.12196-2-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when there is a P4 error, git-p4 calls die() which just exits.

This then leaves the git-fast-import process still running, and can even
leave p4 itself still running.

As a result, git-p4 fails to exit cleanly. This is a particular problem
for people running the unit tests in regression.

Use this exception to report errors upwards, cleaning up as the error
propagates.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 23724defe8..df2a956622 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -618,6 +618,14 @@ def __init__(self, exit_code, p4_result, limit):
         super(P4RequestSizeException, self).__init__(exit_code, p4_result)
         self.limit = limit
 
+class P4CommandException(P4Exception):
+    """ Something went wrong calling p4 which means we have to give up """
+    def __init__(self, msg):
+        self.msg = msg
+
+    def __str__(self):
+        return self.msg
+
 def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
-- 
2.20.1.390.gb5101f9297

