Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C84D201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbdBUXS3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:18:29 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33191 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdBUXS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 18:18:28 -0500
Received: by mail-pg0-f41.google.com with SMTP id z128so5245845pgb.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 15:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tZ1cBdj1UVlU3HuAweRc1lfQbNCKH1FsvAY1s5AazHg=;
        b=td9KttQAivrC2pQdDJWabI0UDxTKyWKQ6/i+8gbC5uD6aF5//xA4D7D9tg/kPREc5p
         bNbgMH2u7Wckqb3/T3bQaelA8qMhdWuOBhkDAlSZHIfc9kA0k0tMAxcxzk1r1LpMaKCm
         UyobKiEnhZZL8vGv0KAbzDe4iPeiOzv+sFt9vxrFwoAnxMdVHXapmSXBNitTPHJ1/lZ+
         qcanRb5aVvRDzcjSRc6Y48c7JE5rSSt4HREnvNfvQ13zQ7hjGEt6j34HD+EtPKZcxQt/
         AjygnwNR7j9CS1YW3WS2ID2Ixw4akvd9Pif3n0Aj7yEvTD7c4KRj57M1MpsOaymmGTSM
         hFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tZ1cBdj1UVlU3HuAweRc1lfQbNCKH1FsvAY1s5AazHg=;
        b=AcnnXWU9tp3T6CFlhX0idsMpTWeCBOCWnUq+COV5MB/ciM5FxPCFc9fk8uJzyifrXw
         OlmfQfQmwIqccOSNZ02g/zocyIl+B0ukq8mt8bWdOI8g+LtA27BJe/Esy3HcHL6YyVY9
         W3yfdPijt+AiG/mFOMvvcJSDbqZvSFaP7yQNrFnBiTy7fLRbnbSadyRL70E4DZB2r/j3
         zG21OB1JbY13dtSMTL5fSkSNQZA0k3zv1/LVXfH9GCylvVRwON3nLoYZwHXEFzM6ctiO
         TEJGQqiH1XBCoeuOZNCu2r9qJJ+BYvcUm2Nv7L4DZeRAqKaZQIoKd70TSV/25GEzeZgU
         bM9w==
X-Gm-Message-State: AMke39k8u/dwmB5pyfJDv8bmT3rRdnyOVPEMqr8ntVsTOnp+sSQ1BE/VAUYyLHLS8GFaOAPd
X-Received: by 10.98.28.72 with SMTP id c69mr16500662pfc.8.1487719107264;
        Tue, 21 Feb 2017 15:18:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:a01f:a5d9:ef24:b7b1])
        by smtp.gmail.com with ESMTPSA id b83sm42951218pfe.12.2017.02.21.15.18.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 15:18:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sop@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule init: warn about falling back to a local path
Date:   Tue, 21 Feb 2017 15:18:15 -0800
Message-Id: <20170221231815.4123-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is initialized, the config variable 'submodule.<name>.url'
is set depending on the value of the same variable in the .gitmodules
file. When the URL indicates to be relative, then the url is computed
relative to its default remote. The default remote cannot be determined
accurately in all cases, such that it falls back to 'origin'.

The 'origin' remote may not exist, though. In that case we give up looking
for a suitable remote and we'll just assume it to be a local relative path.

This can be confusing to users as there is a lot of guessing involved,
which is not obvious to the user.

So in the corner case of assuming a local autoritative truth, warn the
user to lessen the confusion.

This behavior was introduced in 4d6893200 (submodule add: allow relative
repository path even when no url is set, 2011-06-06), which shared the
code with submodule-init and then ported to C in 3604242f080a (submodule:
port init from shell to C, 2016-04-15).

In case of submodule-add, this behavior makes sense in some use cases[1],
however for submodule-init there does not seem to be an immediate obvious
use case to fall back to a local submodule. However there might be, so
warn instead of die here.

[1] e.g. http://stackoverflow.com/questions/8721984/git-ignore-files-for-public-repository-but-not-for-private
"store a secret locally in a submodule, with no intention to publish it"

Reported-by: Shawn Pearce <spearce@spearce.org>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 899dc334e3..44c11dd91e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -356,12 +356,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 			strbuf_addf(&remotesb, "remote.%s.url", remote);
 			free(remote);
 
-			if (git_config_get_string(remotesb.buf, &remoteurl))
-				/*
-				 * The repository is its own
-				 * authoritative upstream
-				 */
+			if (git_config_get_string(remotesb.buf, &remoteurl)) {
 				remoteurl = xgetcwd();
+				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
+			}
 			relurl = relative_url(remoteurl, url, NULL);
 			strbuf_release(&remotesb);
 			free(remoteurl);
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

