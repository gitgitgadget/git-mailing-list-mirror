Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAF7C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8CB64E42
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 17:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhBQRyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhBQRyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 12:54:16 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F5C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 09:53:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a132so2828609wmc.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 09:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=3CvxqFGSi62DxdPeGygvXgLr+VLx/pAlJ6uxTjsXfh0=;
        b=b9l64cJAWC+EkdZRl9ke8dFVaMKNnokq96yDdYFSiX99YduD/SeZUBxk+gTiMUVR9d
         +9WtsWwPubaW1fzDAVYBfUVZT7jnQRAk+p2b3N7gfvlTEPDrXHFUf0qIqbRP3nDSCFsV
         ig/JHhaMkCXmcGrZN8NrEDtP8uYF66E4Y9GJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=3CvxqFGSi62DxdPeGygvXgLr+VLx/pAlJ6uxTjsXfh0=;
        b=NKkAtaGvK4OGFB7le1JM8aQXsgIgyPECAyFUN9eCK7jvFc6ywzQh2YHGjb5d0esmyn
         KHYC0awWbZdWB5HLG/K2FOKNwCmX7WotySn7K+DJvlPRbkUkbKCZtrURwiwmyJuVzyWT
         DQzZeNtBythxXWParuB7R1K1aIkSjZOhMLRAGx9HGnxUrq0gKo6MO91orgBPG5pt2plx
         Vb1FJdAWTpEorFcimSqhmvJk2gPUeHFV5MZFAaFZSXb2ig+4XV0kNfzqeWFfK6O23NjU
         1K9E4ErTdQFp/wHqayVWZTTrnvzRXVSQyQ1VczzR0/CboFDhy3Cmqw5VUnBdXlLLI3Kf
         Qv4g==
X-Gm-Message-State: AOAM5313ojZ5d0w+cu6BpYhm60mfuYFNeYds1ILtBnHBAyC9Dexqc1gH
        Ml9GTDBfxx/RwLrAgAYxHOML9Vum1LUTlQ==
X-Google-Smtp-Source: ABdhPJxgDRi/7X5rDjKyNyjpI1q7siyIERXGs+zi4xfWkiayb3XocdKBS4dexrhyCK3Rc3+CndlhlQ==
X-Received: by 2002:a1c:1bcc:: with SMTP id b195mr96320wmb.64.1613584411522;
        Wed, 17 Feb 2021 09:53:31 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:19d:cb66:14ba:c267? ([2001:8b0:aba:5f3c:19d:cb66:14ba:c267])
        by smtp.gmail.com with ESMTPSA id c128sm3411931wma.37.2021.02.17.09.53.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 09:53:31 -0800 (PST)
Message-ID: <f029a942dd3d50d85e60bd37d8e454524987842f.camel@linuxfoundation.org>
Subject: [PATCH] generate-configlist.sh: Fix determinism issue
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     git@vger.kernel.org
Date:   Wed, 17 Feb 2021 17:53:26 +0000
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently git binaries are not entirely reproducible, at least partly 
due to config-list.h differing in order depending on the system's
locale settings. Under different locales, the entries:

​"sendemail.​identity",​	 
"sendemail.​<identity>.​*",​

would differ in order for example and this leads to differences in 
the debug symbols for the binaries.

This can be fixed by specifying the C locale for the sort in the
shell script generating the header.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Index: git-2.30.0/generate-configlist.sh
===================================================================
--- git-2.30.0.orig/generate-configlist.sh
+++ git-2.30.0/generate-configlist.sh
@@ -9,7 +9,7 @@ static const char *config_name_list[] =
 EOF
 	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
 	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
-	sort |
+	LC_ALL=C sort |
 	sed 's/^.*$/	"&",/'
 	cat <<EOF
 	NULL,

