Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C784F20193
	for <e@80x24.org>; Wed,  2 Nov 2016 22:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933126AbcKBWVO (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 18:21:14 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32789 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932782AbcKBWVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 18:21:13 -0400
Received: by mail-pf0-f173.google.com with SMTP id d2so18964632pfd.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 15:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kejSqh6vhLcuhA+niF7K06e/vcdnbHbZYzDB8+86R1s=;
        b=KsPlpTzZ3Q1vv7Te9Z5XVo14v8U5wHyl9QBHu0s8i2TFA0DT8asz92UvfrB0ysUWfS
         5x/LaZQk+/2YrGbdsPwCgYU2woiMyPzHzYkIDzJ8ETXqSQUJBsgUEr+zsqufAko4CI8Z
         RLFrU21xd85y8DL11zXF8GuiSPx55+ll6lt8nYWCkYwQRQ/jed6dF9hJNf6NR6UkW952
         SaaylQxgBwCtR3BXJdB4m7o980gOban7aETOsMD1cGvk8AynyoNv+a+cp9XQhG0yxowO
         yA4ZoURFuHA/aUawEj69Qoz58VmYFrlhD6RGDDbTnbrf2HAyOimQm9sbPG/uzDbC2xvZ
         44QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kejSqh6vhLcuhA+niF7K06e/vcdnbHbZYzDB8+86R1s=;
        b=QXvW22W1Yj28TJ68K1DHH5cGr3ujAPoppRuKDF32/6R8q2V149W14gi1te6ERqmYT5
         L/Dd06BJNuJ1l7DKuATSRsDo90ZKJjJkhxYES9N0YxPXlrRGXJyMNpyXYiYOJgu2sX67
         NxclpraXBqAan2npSARZLMf4nSfNAGVucztyP1+asVSDpl+WhwH1Vp3IOFKiQEPrfe73
         Hacxa44D6pBG6ef6rY8r/Dg1FGOLFngq0syHyZJUS1VS3U1NAFzRSgTkz0SxercPlXY+
         Lh0XyGId70kaqboemlE4aujp2r0dl0CRUPrfwgZvbaBnIxgziNAoBLITYSJGX/2HJLn3
         OvQQ==
X-Gm-Message-State: ABUngve+e0xbOX3oJA+jyY3gN70sOIpWlG28yfKnI+WcIdZCz/1orWcXNNnMyQ10Em2eLbFY
X-Received: by 10.99.110.14 with SMTP id j14mr9068234pgc.135.1478125272413;
        Wed, 02 Nov 2016 15:21:12 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id cp2sm7144542pad.3.2016.11.02.15.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 15:21:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH] transport: add core.allowProtocol config option
Date:   Wed,  2 Nov 2016 15:20:47 -0700
Message-Id: <1478125247-62372-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add configuration option 'core.allowProtocol' to allow users to create a
whitelist of allowed protocols for fetch/push/clone in their gitconfig.

For git-submodule.sh, fallback to default whitelist only if the user
hasn't explicitly set `GIT_ALLOW_PROTOCOL` or doesn't have a whitelist
in their gitconfig.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt | 9 +++++++++
 git-submodule.sh         | 3 ++-
 transport.c              | 2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 27069ac..7f83e40 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -455,6 +455,15 @@ core.sshCommand::
 	the `GIT_SSH_COMMAND` environment variable and is overridden
 	when the environment variable is set.
 
+core.allowProtocol::
+	Provide a colon-separated list of protocols which are allowed to be
+	used with fetch/push/clone. This is useful to restrict recursive
+	submodule initialization from an untrusted repository. Any protocol not
+	mentioned will be disallowed (i.e., this is a whitelist, not a
+	blacklist). If the variable is not set at all, all protocols are
+	enabled. If the `GIT_ALLOW_PROTOCOL` enviornment variable is set, it is
+	used as the protocol whitelist instead of this config option.
+
 core.ignoreStat::
 	If true, Git will avoid using lstat() calls to detect if files have
 	changed by setting the "assume-unchanged" bit for those tracked files
diff --git a/git-submodule.sh b/git-submodule.sh
index a024a13..ad94c75 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -27,7 +27,8 @@ cd_to_toplevel
 #
 # If the user has already specified a set of allowed protocols,
 # we assume they know what they're doing and use that instead.
-: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
+config_whitelist=$(git config core.allowProtocol)
+: ${GIT_ALLOW_PROTOCOL=${config_whitelist:-file:git:http:https:ssh}}
 export GIT_ALLOW_PROTOCOL
 
 command=
diff --git a/transport.c b/transport.c
index d57e8de..b1098cd 100644
--- a/transport.c
+++ b/transport.c
@@ -652,7 +652,7 @@ static const struct string_list *protocol_whitelist(void)
 
 	if (enabled < 0) {
 		const char *v = getenv("GIT_ALLOW_PROTOCOL");
-		if (v) {
+		if (v || !git_config_get_value("core.allowProtocol", &v)) {
 			string_list_split(&allowed, v, ':', -1);
 			string_list_sort(&allowed);
 			enabled = 1;
-- 
2.8.0.rc3.226.g39d4020

