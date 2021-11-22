Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C07EC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhKVWcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhKVWcP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:32:15 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB52C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:29:08 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 132so19816002qkj.11
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YqsSYh4+Ma1liN/cSCx+y8hGOYIOJEzZqDpzyxjtLbU=;
        b=olGgoWtH8Y+AXUJkLalOjPcXQEACrXbxkm0R9SM4JcHf5IoGGdCtlqMJi/kXoyzSu6
         8guUE9ViYKP3yCqOMLBdAHcTxBE10X47/HNFb5zhfGEaZO4/CySFc+b1116Pkrw1u5KP
         TH5h5ZLnXQR5ndSr578fU8LPZYo9bvNEzpk8pL2DYNxcTaxw7SQgJaDW9ldUnoA7396/
         /Bfk913BHwJsBBYyuZJyvvn2C7HdHdox/pRtAEPnWUvgd+dynHgsBSoPtN/JtymzO8Hp
         U4+PiYZx57TfZllJjnx49B92HPj4QeODXEQ8HwWWp2Hk7HL/PhIV4W8LqPJxSlLoY/l9
         LW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YqsSYh4+Ma1liN/cSCx+y8hGOYIOJEzZqDpzyxjtLbU=;
        b=Iscr9w+P5pWRgABck4drqgLKGUF+5myvmVMs2heWxYT0kMnb5q6hRXIS3vasBkflX8
         8ifwYte8ZoH7oajCGKNgbeL/jrgqPmYeo4bChLyIwmYAzCGP/sSHwigw2ndZA+w+yt2r
         8XBygsIARxPtQrdNncRvnE2k2t5pouYMLax/ClqL5rNuXJSD6rEEvP14/HdFsJ+vPlqX
         U9+RdXb3B+sZIWefknPTY7y5SAeGdvMsDlZhOT05urmStjKGV0a+a/XWGKzRepCtUpRT
         p+NphqP9VWczTMhS3FjzKQPE0zQJNv9SrpAsSCBPK+WGWnoc0/5sk4GvNkTYkDOQCEE3
         JDxQ==
X-Gm-Message-State: AOAM531feoCWuMUATm0bDvR1Qxvt0FCxpYN3nIw2f36Xoqvj9ohrdw1u
        b+y49BNa3NEdOtUAnP1KPty2H8LOEN0=
X-Google-Smtp-Source: ABdhPJx2B4uiVoxJ7FbjfSz5NT+vvn4LMW9C+BFwqdstkWulWnXuel8AFF35copLDh6iPxL2q99CRg==
X-Received: by 2002:a37:98d:: with SMTP id 135mr270742qkj.166.1637620147741;
        Mon, 22 Nov 2021 14:29:07 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id m9sm4833071qtn.73.2021.11.22.14.29.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 14:29:07 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, thomas.wolf@paranor.ch,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Alexander Veit <alexander.veit@gmx.net>
Subject: [PATCH] editor: only save (and restore) the terminal if using a tty
Date:   Mon, 22 Nov 2021 14:28:50 -0800
Message-Id: <20211122222850.674-1-carenas@gmail.com>
X-Mailer: git-send-email 2.34.0.352.g07dee3c5e1
In-Reply-To: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the editor is invoked without a controlling terminal, then
saving the state and restoring it later is not very useful and
could generate signals that the invoking process wouldn't know
how to handle.

if git's standard output is not connected to a terminal, then
presume there is no need to worry if the invoking terminal could
garble it.

Reported-by: Alexander Veit <alexander.veit@gmx.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 editor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/editor.c b/editor.c
index 674309eed8..214e3834cb 100644
--- a/editor.c
+++ b/editor.c
@@ -86,7 +86,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
-		term_fail = save_term(1);
+		term_fail = isatty(1) ? save_term(1) : 1;
 		if (start_command(&p) < 0) {
 			if (!term_fail)
 				restore_term();
-- 
2.34.0.352.g07dee3c5e1

