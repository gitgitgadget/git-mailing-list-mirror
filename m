Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01491F597
	for <e@80x24.org>; Tue, 24 Jul 2018 21:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbeGXXBF (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:01:05 -0400
Received: from s019.cyon.net ([149.126.4.28]:43832 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbeGXXBE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3Lui2DwoWBh8rk4nj4s08CtZ/vA1bezdty+4muM4KzU=; b=IH5l9qsyIQByz2tv0ItxhA1IJB
        TSzKwXtPWcC9YHWA9ufrn5nShwwEQF6G2JCUmVfhgmGu3VZ235cYST5iZiu4pzKlqFUUYkrAFdeuN
        uOnvKKp2PYEVeJNPYNIMAq/NDoK5KJnG1BO1PQXamJ4OYBK57JRfNtgAY+Br0EMsPU8MLDsvl85NX
        2lwhxwooD7qKv5ZVLp9iPNCBweYT2FGLkXfccqhMxoNXz3c3gX86FdsZHVBd400nv+FSMUJJKGXaS
        Or/8tB3I7GPgcX8fA8aOf0RwgA1T0+9Sg2xSibMipSnHW0Nk/qLAZsbI9sksS8wDxJxbTeE1CNe2T
        KWW0P3QQ==;
Received: from [10.20.10.232] (port=37754 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fi5EN-00B54L-FO; Tue, 24 Jul 2018 23:52:33 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 1C89020FC1; Tue, 24 Jul 2018 23:52:31 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 2/2] remote-odb: un-inline function remote_odb_reinit
Date:   Tue, 24 Jul 2018 23:52:23 +0200
Message-Id: <20180724215223.27516-3-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180724215223.27516-1-dev+git@drbeat.li>
References: <20180724215223.27516-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When compiling under Apple LLVM version 9.1.0 (clang-902.0.39.2) with
"make DEVELOPER=1 DEVOPTS=pedantic", the compiler says

    remote-odb.c:87:2: error: static function 'remote_odb_do_init' is
    used in an inline function with external linkage
    [-Werror,-Wstatic-in-inline]

Remove the inline specifier that would only make sense if
remote_odb_reinit were defined in the header file. Moving it into the
header is not possible because the called function remote_odb_do_init is
static and thus not visible from the includers of the header.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 remote-odb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-odb.c b/remote-odb.c
index 847a86505778..49cf8e30aa92 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -82,7 +82,7 @@ static inline void remote_odb_init(void)
 	remote_odb_do_init(0);
 }
 
-inline void remote_odb_reinit(void)
+void remote_odb_reinit(void)
 {
 	remote_odb_do_init(1);
 }
-- 
2.18.0

