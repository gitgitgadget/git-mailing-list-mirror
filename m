Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084AC202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 19:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934980AbdIYTzk (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 15:55:40 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:44737 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbdIYTzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 15:55:39 -0400
Received: by mail-pf0-f174.google.com with SMTP id e1so4343367pfk.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OVsJM/wUFdkuV6d25rLUxrLbP8354OJ8WwvNSc2IRr4=;
        b=c5HK8KLBzZzqw9FnptMxtyhFMmz3eVC1OeAFd2k86bQyYPbLEtliy+OOI1D/FZmKeo
         AuRJQW8lH5T7NNXmr2AOEZ+Si+KClAkIsjoLj6idmUroAJbvltNt0i9Xjdi0V+o4hfwR
         bcNGZXNtcgR/z1jtPc0Gsm/EANcGrYhZJlQWussU/XCEeXGRUG3yzq2bn1OSe0DOOKb3
         NP85q9bxThSSOikP10l0DA+QkQWMz8+R95WGXFtUI6wq8fmX+UEgtUQ9A2TiNYa9/lGc
         8Q5oVt08lHipyFlWqE+EOmot52tAd+3q2/TWVr7aiEFy0pW4DuUAjC9d4zbGz3rL/Nk8
         5HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OVsJM/wUFdkuV6d25rLUxrLbP8354OJ8WwvNSc2IRr4=;
        b=WDE+JmFx6MpE0NugP2f0kDLkWzcGLXwjEgW0ARRifhml74fOyT9/iJ5AtNZ7zn6uWc
         usDt+XveA1SgYRsKSJ6NLaaZ9ea++Hu+527J5PTW/crAx9KhtN37ybEaLcXwVLcyeGFC
         Av6uPpNE396q06hH/McOy9xIShEQR/7AYEKVOhVEZwkDdSRpuUtDZEyx3msTsP3Ud6Oz
         4cU6wJOxAwmEEVQgMjc0ZtB6BUJftjiCyLHxAOQErSHxTceQ4jl/lHhr5kqOKJAbU4F4
         tzMk3Sa+bKD3DtrCEhFF77tpAe1pbaiSeVIIMtJMB5asnsi9TfMYbXeDwikY0vkuryCb
         X5ow==
X-Gm-Message-State: AHPjjUja2/IGQkM6hD4wv/FTuhoK2/YqsMZjsoMoSVJ12uugGpHcgAQl
        430QuiWE9+UWjSqgfID22scbhLol5nc=
X-Google-Smtp-Source: AOwi7QDS6LbSJp1huRuew18FtLPpdqMDozmVCSR8P/+asm0MF/sDs0m8M6ow0G7ztFL61e3csytPBQ==
X-Received: by 10.99.37.66 with SMTP id l63mr8898901pgl.348.1506369338298;
        Mon, 25 Sep 2017 12:55:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6810:20db:ec03:dc8a])
        by smtp.gmail.com with ESMTPSA id c2sm12845631pgq.61.2017.09.25.12.55.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 12:55:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] t7406: submodule.<name>.update command must not be run from .gitmodules
Date:   Mon, 25 Sep 2017 12:55:33 -0700
Message-Id: <20170925195533.15172-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

submodule.<name>.update can be assigned an arbitrary command via setting
it to "!command". When this command is found in the regular config, Git
ought to just run that command instead of other update mechanisms.

However if that command is just found in the .gitmodules file, it is
potentially untrusted, which is why we do not run it.  Add a test
confirming the behavior.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7406-submodule-update.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 034914a14f..780af4e6f5 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -406,6 +406,16 @@ test_expect_success 'submodule update - command in .git/config' '
 	)
 '
 
+test_expect_success 'submodule update - command in .gitmodules is ignored' '
+	test_when_finished "git -C super reset --hard HEAD^" &&
+
+	git -C super config -f .gitmodules submodule.submodule.update "!false || echo >bad" &&
+	git -C super commit -a -m "add command to .gitmodules file" &&
+	git -C super/submodule reset --hard $submodulesha1^ &&
+	git -C super submodule update submodule 2>../actual &&
+	test_path_is_missing super/bad
+'
+
 cat << EOF >expect
 Execution of 'false $submodulesha1' failed in submodule path 'submodule'
 EOF
-- 
2.14.0.rc0.3.g6c2e499285

