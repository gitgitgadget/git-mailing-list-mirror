Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03A97207D6
	for <e@80x24.org>; Tue,  2 May 2017 00:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750859AbdEBAFU (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:05:20 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36755 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdEBAFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:05:19 -0400
Received: by mail-pg0-f68.google.com with SMTP id v1so18196689pgv.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=o/yU4caDyB2rOFS2BR0Y+yPVLSCadzLMCa9fyFBi1Nk=;
        b=hBLpCnJ0l5HXRzv8WH/POu8fZDek9l1BLAGJa8y6ZaB0OyqkQtJ0h2pU/zt52CNpMq
         uVyZgJoj4WPzFQTbhvZyM6WohaJe3/NlLeSUoHIsHj0ZPSfYIjYGtcWtLiH0NJpv+M0W
         zMnlgm5zWIqGAaeys9VPSDN2QUTPRdQM3X8iRKLxvnAI6t8xzBksAEi2j2RX4ucAYWcQ
         G1bEI0XZWogNIAB/TLuOvA4kHcP7j3qya2pHGA21kz+AFGLOGlV17mqNlD+BgfDuILrE
         oLbc1D+xKzLaXzUF23zgHEGPL8vGpu2R6xfMcC0XlW6gz2BT11EpsnigmenvQW0rJfvA
         LtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o/yU4caDyB2rOFS2BR0Y+yPVLSCadzLMCa9fyFBi1Nk=;
        b=m65Z2GWOIGFiT+DCvK1yw8PISqHNv90bPfkNbC50smaJKX32worn6HJYT1KBZgfN/P
         yEvzFGvshmAkDClrvMhz9pKYeUWP25Vw1KoFnNMFUUJ4EOD2K7emOPr9xDSnllZEaBs5
         SWiAlFd1RZ8P0K3ij+u+SbhUGj7GkuxB98I7YADlRfwpawAXPXk/oSld+gDxaSb8DgB6
         aYZFabtG9cYZbBAwFs+0kpRSy/SzQ8N1gF5XVCPXwYEem//LEUvA9Md66qupsZoqBBhF
         N+gmacyF79r9qwRtNs+6ziL0Kky480+4e+SsTeTPNPbGiFCVcskYGtoHlP9lLiUldkxu
         njDw==
X-Gm-Message-State: AN3rC/6xpDdi9xbnJV0k554MzTjOTmSxdmfXJ1oZY/ZgAaAnSGezofjv
        hPQTPBrSmGRFcMpqOjE=
X-Received: by 10.98.35.10 with SMTP id j10mr29264576pfj.23.1493683518329;
        Mon, 01 May 2017 17:05:18 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:1193:d4d9:e46d:aae8])
        by smtp.gmail.com with ESMTPSA id 65sm26843804pgc.1.2017.05.01.17.05.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 17:05:17 -0700 (PDT)
Date:   Mon, 1 May 2017 17:05:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] clone: handle empty config values in -c
Message-ID: <20170502000515.GU28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git clone --config" uses the following incantation to add an item to
a config file, instead of replacing an existing value:

	git_config_set_multivar_gently(key, value, "^$", 0)

As long as no existing value matches the regex ^$, that works as
intended and adds to the config.  When a value is empty, though, it
replaces the existing value.

Noticed while trying to set credential.helper during a clone to use a
specific helper without inheriting from ~/.gitconfig and
/etc/gitconfig.  That is, I ran

	git clone -c credential.helper= \
		-c credential.helper=myhelper \
		https://example.com/repo

intending to produce the configuration

	[credential]
		helper =
		helper = myhelper

Without this patch, the 'helper =' line is not included and the
credential helper from /etc/gitconfig gets used.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thoughts?

Thanks,
Jonathan

 builtin/clone.c         | 4 +++-
 t/t5611-clone-config.sh | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index de85b85254..a6ae7d6180 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -773,7 +773,9 @@ static int checkout(int submodule_progress)
 
 static int write_one_config(const char *key, const char *value, void *data)
 {
-	return git_config_set_multivar_gently(key, value ? value : "true", "^$", 0);
+	return git_config_set_multivar_gently(key,
+					      value ? value : "true",
+					      CONFIG_REGEX_NONE, 0);
 }
 
 static void write_config(struct string_list *config)
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index e4850b778c..39329eb7a8 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -19,6 +19,14 @@ test_expect_success 'clone -c can set multi-keys' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone -c can set multi-keys, including some empty' '
+	rm -rf child &&
+	git clone -c credential.helper= -c credential.helper=hi . child &&
+	printf "%s\n" "" hi >expect &&
+	git --git-dir=child/.git config --get-all credential.helper >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'clone -c without a value is boolean true' '
 	rm -rf child &&
 	git clone -c core.foo . child &&
-- 
2.13.0.rc1.294.g07d810a77f

