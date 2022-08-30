Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6E0ECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiH3Jdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiH3Jcu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:50 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1226FA925E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:31 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11edd61a9edso9323404fac.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GfeEVP6EZqBYQmVSPhhlu6DeEjAa/HvoKDOCbz7UDOk=;
        b=ksRmT2RRzAe5OMZb9dfgFCWkFkp6ceqWy7fah0I/Vq0W4S7QCWfhMXCF6imLxzjjv+
         KZnC8buCOiafZOpnf6M8O/i5pdU5oVWNaxPQ68VZMTDJdXogaZBACPNPvnm/L5Txawcv
         ZYMfIh1TpP0FhZMhEmvOxO/0sCON+e4r8RpcstcsDW51R+8xaCte4EXxA/6WmuU96pE6
         mtDFk5xDGFi7/Aarvi5fA+OCax59ipgaB0IUpO/mJN3xk0of+8kfdkctDe+jo3lwc3KR
         jsy6oKIhx0xzQT6kS9phMwNXh3sSH6amEI4MZlYEO1CNnrolQ4HDIA6ivjhCNTdSGGEy
         mJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GfeEVP6EZqBYQmVSPhhlu6DeEjAa/HvoKDOCbz7UDOk=;
        b=u0ILd3hIk8pbWLf/IqhvrZp+5kPrJuWR1bXrTAvskr6GmvssVtsrJ04f3+hF7NCOQK
         uUPuqd2mhTEYiQQSB1xlXLlvmJxHFAlYItLJa2LrA2M+Wlv4GNMvwknNQ02wZmis7SLy
         xkHjK/oYoy3nHzM8MecIXvutkU040Hp4f3jpK3uEYpJN1sjVNTH6yTA1Fo71wELFhb4u
         nd8iQKg1N1nQieSAimn4iF6mQFq9+LCzQElmhh6S0mCd/JnI0goRae1RCvr8sQpWA2eJ
         lSbmKLmAnFhOlGu2X5GNIej0x0DvRfbdIReu9wpTAPkBMCsBdkueO+BShkR+k4Ir4y0g
         QBHw==
X-Gm-Message-State: ACgBeo2TEt0TCwyCCatAULjb8Z6y4s9GpfckjzN4Rta59iCFh3YlxZk/
        /0MTVrrSf6zB4PEnjkuAP+MZoFBSR0Y=
X-Google-Smtp-Source: AA6agR5qQUKOi5W+a6x5sItqvGBR03eRERZIa8gJ1WZ8JSwcaNtEKYTiM1dRdmlpfQEJeaI6JDZfuw==
X-Received: by 2002:a05:6808:1486:b0:344:dc19:d7de with SMTP id e6-20020a056808148600b00344dc19d7demr8854259oiw.238.1661851951321;
        Tue, 30 Aug 2022 02:32:31 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id x11-20020a056830114b00b00636d0984f5asm6943048otq.11.2022.08.30.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 30/51] completion: simplify __gitcomp
Date:   Tue, 30 Aug 2022 04:31:17 -0500
Message-Id: <20220830093138.1581538-31-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not possible for $cur_ to have anything more than --no- at this
point, so there's no need to add a suffix, nor check anything else.

All we are doing is checking that $cur_ matches --no, and adding a
completion if so.

This way the code reflects what we are doing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++---
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 54b2c4e589..c9315d4f9a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -346,9 +346,8 @@ __gitcomp ()
 				continue
 			fi
 
-			c="--no-...${4-}"
-			if [[ $c == "$cur_"* ]]; then
-				COMPREPLY[i++]="${2-}$c "
+			if [[ --no == "$cur_"* ]]; then
+				COMPREPLY[i++]="--no-... "
 			fi
 			break
 		fi
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 7616f87fa2..d5f4270ee5 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -63,7 +63,7 @@ __gitcomp ()
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			array+=("--no-...${4-} ")
+			array+=("--no-... ")
 			break
 		fi
 		c="$c${4-}"
-- 
2.37.2.351.g9bf691b78c.dirty

