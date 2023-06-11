Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19135C7EE2E
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjFKSul (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFKSuk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:50:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B3E64
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f739ec88b2so25329135e9.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509438; x=1689101438;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ymGwbn81ZsgJbneBe2lCC5oLGT5ZgBzN1yZS84ornI=;
        b=nucnYwCA396x+MyaT6p5ghygfYD1GhHx4dQOID9ZZ0miGwr2kohu12MFmzGcFB6d7O
         RjHkXq4C94v+nu+W1hmPwuMyPETOWPyon05EFxPLmUKbMv7wR8MioP2Ad1Qp+LFqUYdF
         Qw8UdDTXygMirUO+HQc8sQQnxeDFXn+4O4GZCnIwHRQOgzzFIMXWaWoChiHR/LHqahJO
         njm9lKAXGyx1FKmaA/saML+C3Ugpt5ODiuiRLFMTgK5H4R08s4VLS86R0iN71lM/lcJC
         9DbAQMV4ITiI++TvfVeYUPKf86kXRz0aT/OjpV8iFK3n3qDh+CvMl7eHTbj3etoGrW0d
         tepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509438; x=1689101438;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ymGwbn81ZsgJbneBe2lCC5oLGT5ZgBzN1yZS84ornI=;
        b=Z68A+Oqs69LKCqWBw63FpihZCms7wIzAVSOSOYvYXqAEGgeWLqn23JziismgamOS7s
         jKqLtnZh5MNoiFmRXck8TGrHxL93jYju+MwGV+mKsgqpYqu08KEetS6RieAp+lL9IXlj
         MtycWBY25Xf0TpHFYEQ304SvCDNw8mcKFdE6CynzsMJCub57+pa+g1o4H8YTDxhmQ8t0
         S3YpUfsNvJRiZg95X4eRzOYLhx+dbpJGvRcfzRtSjUuRGw3PJyZvNXqB2yLoSJq5baWq
         IfSxFazvqhmc3NHdkVnRNTNpeHZHSaLo4ceNJ/h9ryb0x+Qm0lNrwe6Fk6gwFfunuQ5i
         PoJg==
X-Gm-Message-State: AC+VfDwBLaAT2943UP6v/W4UkaCcH/fjxvCTT7e6oy7DgZXifxsFjwaG
        +tyvQqFB48dDFUcjsxCRP5+GahlTWJU=
X-Google-Smtp-Source: ACHHUZ7S1JJScWde3hZYvq1GOb/70SG9NoqQ6yVMD8qUUAx/rJ1lWsHMfCdi9nXMXkMDEFsxyxbuPQ==
X-Received: by 2002:a1c:ed06:0:b0:3f4:2266:8cf0 with SMTP id l6-20020a1ced06000000b003f422668cf0mr4307875wmh.10.1686509437528;
        Sun, 11 Jun 2023 11:50:37 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id v13-20020adfebcd000000b00309382eb047sm10371279wrn.112.2023.06.11.11.50.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:50:37 -0700 (PDT)
Subject: [PATCH 09/11] branch: fix a leak in setup_tracking
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <471dcc04-d60c-b745-15f0-05fe4e93ff11@gmail.com>
Date:   Sun, 11 Jun 2023 20:50:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit d3115660b4 (branch: add flags and config to inherit tracking,
2021-12-20) replaced in "struct tracking", the member "char *src" by a
new "struct string_list *srcs".

This caused a modification in find_tracked_branch().  The string
returned by remote_find_tracking(), previously assigned to "src", is now
added to the string_list "srcs".

That string_list is initialized with STRING_LIST_INIT_DUP, which means
that what is added is not the given string, but a duplicate.  Therefore,
the string returned by remote_find_tracking() is leaked.

The leak can be reviewed with:

   $ git branch foo
   $ git remote add local .
   $ git fetch local
   $ git branch --track bar local/foo

   Direct leak of 24 byte(s) in 1 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in strbuf_grow strbuf.c
       ... in strbuf_add strbuf.c
       ... in match_name_with_pattern remote.c
       ... in query_refspecs remote.c
       ... in remote_find_tracking remote.c
       ... in find_tracked_branch branch.c
       ... in for_each_remote remote.c
       ... in setup_tracking branch.c
       ... in create_branch branch.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

Let's fix the leak, using the "_nodup" API to add to the string_list.
This way, the string itself will be added instead of being strdup()'d.
And when the string_list is cleared, the string will be freed.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 09b9563ae7..d88f50a48a 100644
--- a/branch.c
+++ b/branch.c
@@ -37,7 +37,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 	if (!remote_find_tracking(remote, &tracking->spec)) {
 		switch (++tracking->matches) {
 		case 1:
-			string_list_append(tracking->srcs, tracking->spec.src);
+			string_list_append_nodup(tracking->srcs, tracking->spec.src);
 			tracking->remote = remote->name;
 			break;
 		case 2:
-- 
2.40.1
