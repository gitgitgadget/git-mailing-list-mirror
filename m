Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2B4C77B60
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjDAIs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDAIrg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212AC1F7B2
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:06 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bm2so18436520oib.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qMa84DTLjCFOmzY8TX2jiYBtujJG/I7SzbUh5JQTPg=;
        b=ko+/SwbxuwEpUJAAvhepzUiZUanLKMu4AEh8MDdeZM48FAL89Ntky1D+Jfd4W9EcJM
         s45EPPt5nLZzBr/5eyENf4I+pI40aS/F922irK0SEVzvHzdk2vRQjpEq6P9eAHxAAaHu
         nxf/pWXDcWo8+yoyu9XiEh2P3HMdA6mVwpDnyBfBi1eonlh7dpnXc4smeoLxqljli51M
         7x1JPsWbbamP+qRLHH4aYFpZYEyGdx5LZJExbjzDIO4agBHjxBlsjHEFmYd1Zzbs5rsA
         cs16wD9PWBnZ+l4uP2zqX6aQ298bGhvT+xHmK/6Yk3CoxhqrF+E+dGyiVs47UwIoEx2r
         OKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qMa84DTLjCFOmzY8TX2jiYBtujJG/I7SzbUh5JQTPg=;
        b=407GjNEAzAI/4tB879vo5U7fkxkHpvFc3fS1e0Mfau6u6R0YtO19G0q7rugClUllSB
         6OuqV1b/YZ3+CAeEudg4VyDA0dCry4popqKjvr4lKdOGDRQc68H0r94eyCnWmBt+dBwW
         zhE1Dgp8i4A5lz18zvBjjuFB1rqOcwQQNo7NlqG9rZYeYo2Cg0cg4U6cEgv6tfeAAsWd
         IQwCA2z+v2rJMc+G3Etyf4fhXhgaev/ImbQ1sq/JTmNmle25ngL8tm2AmKd2qv0bcj8N
         W7YiuZ50bCuy/hevIAJnmisG+4gvxmQ4wmZggL4tiMGqn2n+0FJw/xcMv8C0+3TjuHeM
         iaSQ==
X-Gm-Message-State: AO0yUKWe8yd6S8EjR9xwkuUglFfio1WuT1B00HawX6QOnxFO4jL2Uzwk
        NFeWOBEelQwxoJJJtQ/gwHSxqSCNTjo=
X-Google-Smtp-Source: AK7set/Dtm28pySAxIIQlryL8zShD3Q8z17OvvWba4X6PPTGKGzqpLwDLQLGr2LMHw9kOrjEuC3t0A==
X-Received: by 2002:a54:4491:0:b0:387:12e5:543a with SMTP id v17-20020a544491000000b0038712e5543amr12573178oiv.29.1680338825254;
        Sat, 01 Apr 2023 01:47:05 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j129-20020acab987000000b00383ece4c29bsm1865317oif.6.2023.04.01.01.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 27/49] completion: factor out check in __gitcomp
Date:   Sat,  1 Apr 2023 02:46:04 -0600
Message-Id: <20230401084626.304356-28-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way we can reorganize the rest of the function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++--
 contrib/completion/git-completion.zsh  | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 98eb7c9604..e07d5054cb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -341,9 +341,11 @@ __gitcomp ()
 {
 	local cur_="${3-$cur}"
 
+	if [[ "$cur_" == *= ]]; then
+		return
+	fi
+
 	case "$cur_" in
-	*=)
-		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
 		for c in $1; do
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 0b6289af0a..202f66a4f7 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -56,9 +56,9 @@ __gitcomp ()
 
 	local cur_="${3-$cur}"
 
+	[[ "$cur_" == *= ]] && return
+
 	case "$cur_" in
-	*=)
-		;;
 	--no-*)
 		local c IFS=$' \t\n'
 		local -a array
-- 
2.33.0

