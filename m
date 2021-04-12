Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B95DC43617
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 09:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B5D61025
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 09:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbhDLJSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241793AbhDLJRS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 05:17:18 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4EBC06138E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ldzCA+lusTlpgxkPhH5lmNebFDcHe94M9aVkpYdG5Cw=; b=tkvOPIx0FtSaCUwm4jhOoPIG0i
        +pxyRVmJ1OQLeDo8FeIDrLK3TsNOrZYpeM0gkU/3bkbceg1K0yIbPREZUhQr2g5alkm4HLycQdOJb
        4h0fYmLvim5PQfauXu5Gqz1n0+AvTrQt32WrUPE8s7wp2J09K3xL/b8XXfgSVN0Djxjo=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1lVsJX-0000qB-Pl; Mon, 12 Apr 2021 08:52:59 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>, Feiyang Xue <me@feiyangxue.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 2/2] git-p4: do not decode data from perforce by default
Date:   Mon, 12 Apr 2021 09:52:51 +0100
Message-Id: <20210412085251.51475-3-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412085251.51475-1-andrew@adoakley.name>
References: <20210412085251.51475-1-andrew@adoakley.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit is not intended to change behaviour, any we still attempt to
decode values that might not be valid unicode.  It's not clear that all
of these values are safe to decode, but it's now more obvious which data
is decoded.
---
 git-p4.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8407ec5c7a..8a97ff3dd2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -764,15 +764,19 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         while True:
             entry = marshal.load(p4.stdout)
             if bytes is not str:
-                # Decode unmarshalled dict to use str keys and values, except
-                # for cases where the values may not be valid UTF-8.
-                binary_keys = ('data', 'path', 'clientFile', 'Description',
-                               'desc', 'Email', 'FullName', 'Owner', 'time',
-                               'user', 'User')
+                # Decode unmarshalled dict to use str keys and values where it
+                # is expected that the data is always valid UTF-8.
+                text_keys = ('action', 'change', 'Change', 'Client', 'code',
+                             'fileSize', 'headAction', 'headRev', 'headType',
+                             'Jobs', 'label', 'options', 'perm', 'rev', 'Root',
+                             'Status', 'type', 'Update')
+                text_key_prefixes = ('action', 'File', 'job', 'rev', 'type',
+                                     'View')
                 decoded_entry = {}
                 for key, value in entry.items():
                     key = key.decode()
-                    if isinstance(value, bytes) and not (key in binary_keys or key.startswith('depotFile')):
+                    if isinstance(value, bytes) and (key in text_keys or
+                            any(filter(key.startswith, text_key_prefixes))):
                         value = value.decode()
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
-- 
2.26.3

