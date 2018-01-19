Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1611FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 04:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750931AbeASETL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 23:19:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58112 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750757AbeASETJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jan 2018 23:19:09 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3CC1A6052F;
        Fri, 19 Jan 2018 04:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516335548;
        bh=OavYY+Q0lC90q/gdxewNckMWOoUcrYR7SgRR8P4Ma+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Hwg3rY0PKx66FTMEny3DR/JPGAgj5//9ueXBhE6Rq0xTbg+qd6CRg5ojcml/o/IWE
         nOm0yVlg13VNlNZEPhOcjDXYSDuRIoCapbX/Zw2nJQ/B1Rv29pMXqmkctctiIIDw0V
         u22cHUZUb4Uvnj1lFqjWmbx2+iGXo234ThR/QmHtK3nyrHpA+Kgzkr8/0VxN7yI3A0
         LmCLcHRiJ8AvWg/N4yQ4KqMlpgO4fsqEiXBVmz0cZgVxjv612q0QvydsgbsFyY4K8X
         RjsIGm8VgWJaX0OB9CzL32VSeIQ9L36JQLmr0YsDAqtBtoch5xD6plVwtqC2ND8nFA
         84W5+1zEv8DR4QcV8pqB90kXNCGE4d8SCUU9Hom5U4MsKzxhXJcBQFfG/2e4Eo0AtT
         52VCYyUP61MwnJMEClnCHMAoQnozDGEFh4BaIrptL09jcOmGc+LPmUYKyXXOFp596E
         Nws29UmS9zYuc4VpeUR3Kg4bJ+gwI3SNfTt4Wea+N2lAJUnOMrt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80=20=D0=91=D1=83=D0=BB=D0=B0=D0=B5=D0=B2?= 
        <aleks.bulaev@gmail.com>
Subject: [PATCH] repository: pre-initialize hash algo pointer
Date:   Fri, 19 Jan 2018 04:18:25 +0000
Message-Id: <20180119041825.727904-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.0.rc2.280.g09355b536d
In-Reply-To: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
References: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are various git subcommands (among them, clone) which don't set up
the repository (that is, they lack RUN_SETUP or RUN_SETUP_GENTLY) but
end up needing to have information about the hash algorithm in use.
Because the hash algorithm is part of struct repository and it's only
initialized in repository setup, we can end up dereferencing a NULL
pointer in some cases if we call one of these subcommands and look up
the empty blob or empty tree values.

In the future, we can add a command line option for this or read it from
the configuration, but until we're ready to expose that functionality to
the user, simply initialize the repository structure to use the current
hash algorithm, SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 repository.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I'm still quite mystified as to why this is working on Linux and not
macOS, but I can only guess that compilers are just very advanced and
have somehow concluded that we would clearly never dereference a NULL
pointer, so they picked the only non-NULL value.

I haven't included a test because I have no way to reproduce the issue.
This patch is the first from a series I'm working on where I do expand
the use of the hash struct and therefore caused a segfault on clone, so
I can imagine what's going on without having a way to prove it affects
this particular case.

If someone with access to macOS can provide a test, I'd be very
grateful.

My apologies for the error and inconvenience.

diff --git a/repository.c b/repository.c
index 998413b8bb..f66fcb1342 100644
--- a/repository.c
+++ b/repository.c
@@ -5,7 +5,7 @@
 
 /* The main repository */
 static struct repository the_repo = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, NULL, 0, 0
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
 };
 struct repository *the_repository = &the_repo;
 
