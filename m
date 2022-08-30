Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FA0C0502C
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiH3JeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiH3Jct (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:49 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825F7DEA5A
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:31 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11ee4649dfcso8939688fac.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xOOQy0bHkm0uCW1U9teSHCZpjTZp+M+JSRfr2K08IMw=;
        b=eftkLHklRCQqte16NOvfGjGXYhwHx5Bo3P4v82q0YhgDUJnctgR4E+kkBNPgJC+SMp
         uVcVPITXoucDnt3yozt4sRvTKK9k49LzFAAL5oaItxMJWbbo7npRXv/vUqS77fhXHUnI
         dxyaDSZZ4ojoFMRg97n8U0FVphTbDZ1cZ+U8RpQY+GDdTqEyhnShyepTp4zzCMNwE9og
         S/OwGBYF3EfibCExkkVpoOUgpH0R8jnjHwgOGvQMZfjc97VOrO2aG1nAXKrearwdq4nc
         etDo1V2hRSyq4YEQL0wV/jf38NjWecNgLHLq90DdAVHr2CQtG2KZoXt1XPkLzNbjM8tO
         xeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xOOQy0bHkm0uCW1U9teSHCZpjTZp+M+JSRfr2K08IMw=;
        b=qjvglKwq6ig31bXA5S4TzjmpfhUaNmTk7aQsRxUolDNuOUdJqcTKceBM1ncQM6Yss0
         bOrg03m95QlO6s2wfeoYjy9ow6ndNtUyz9qHTovGI0E1hBNB7saCGK+O0EnbYBeXZ16q
         zPJewZsmulNbikTLhFiztVKyZ84RcKlSTEwDtrhd+aBFVOeMwXGfU5/tkvgsvsGqgdRd
         b2SICS7vkHQ6p2FUiO4hWhsfiJ0wAe7gbZItMCsLSwOzqFWAFlNLn8AIxL3J8WAxLxcH
         lISYnr2JON4A2yfGoTqtMEkAFSk03ctHWnlcZXmuIvgWq38XSlUifLzF/k/8LqwWnSZA
         L0NA==
X-Gm-Message-State: ACgBeo1LbUWXg0D3awTZzPyB1LoNzxjq5mV9LKD5DoIv2le3Tf/KgOd6
        lb63MEB37rYP+yzCpxvrHvS8WVqThXQ=
X-Google-Smtp-Source: AA6agR6y6/Wh6zDshVIoztHwUIY5YaPk42hR6lHf+fdG4eDU7y8dM345GLyLRVOnwnWcCFxqZIsrUg==
X-Received: by 2002:a05:6870:89a1:b0:10e:4357:45b3 with SMTP id f33-20020a05687089a100b0010e435745b3mr9437782oaq.127.1661851945945;
        Tue, 30 Aug 2022 02:32:25 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id c38-20020a9d27a9000000b0061c80e20c7dsm6911003otb.81.2022.08.30.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:25 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 27/51] completion: factor out check in __gitcomp
Date:   Tue, 30 Aug 2022 04:31:14 -0500
Message-Id: <20220830093138.1581538-28-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
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
index ed126bbec4..86c335cfce 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -335,9 +335,11 @@ __gitcomp ()
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
index 41272b00e3..808cf87f84 100644
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
2.37.2.351.g9bf691b78c.dirty

