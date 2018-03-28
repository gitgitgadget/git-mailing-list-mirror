Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77DDE1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbeC1WVM (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:21:12 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:51969 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeC1WVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1294; q=dns/txt; s=iport;
  t=1522275671; x=1523485271;
  h=from:to:cc:subject:date:message-id;
  bh=GUL5bm9xtCYLeE3n3271NaGmzR0rKejaH7zNo7/9h6M=;
  b=nASHUwjeU3rEzquhzJGPlB7X6O0NF6chFdxTX+/Cyg3p90OzasPSwY29
   Dx1whrSx24baznvYGQSDtI228FvSxOgsQYOO5m/zP+JIBYpf1UgR0cSvz
   lPcsJI5CaVBYsT2yFWPxX4s2GTidhfbBNl3ZgfYYaFyRbuxAkhMT2Tzle
   g=;
X-IronPort-AV: E=Sophos;i="5.48,373,1517875200"; 
   d="scan'208";a="373603263"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2018 22:21:10 +0000
Received: from sjc-acme-v04.cisco.com (sjc-acme-v04.cisco.com [10.22.27.234])
        by alln-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id w2SMLAta009073
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 28 Mar 2018 22:21:10 GMT
Received: from sjc-acme-v04.cisco.com (localhost.localdomain [127.0.0.1])
        by sjc-acme-v04.cisco.com (8.13.8/8.13.8) with ESMTP id w2SML9eg027841;
        Wed, 28 Mar 2018 15:21:09 -0700
Received: (from brady@localhost)
        by sjc-acme-v04.cisco.com (8.13.8/8.13.8/Submit) id w2SML9oF027837;
        Wed, 28 Mar 2018 15:21:09 -0700
From:   Erik E Brady <brady@cisco.com>
To:     git@vger.kernel.org
Cc:     Erik E Brady <brady@cisco.com>
Subject: [PATCH] credential: cred helper fast exit can cause SIGPIPE, crash
Date:   Wed, 28 Mar 2018 15:20:51 -0700
Message-Id: <20180328222051.23684-1-brady@cisco.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

credential.c, run_credential_helper(): now ignores SIGPIPE
when writing to credential helper.  Avoids problem with race
where cred helper exits very quickly and, after, git tries
to write to it, generating SIGPIPE and crashing git.  To
reproduce this the cred helper must not read from STDIN.

This was seen with a custom credential helper, written in
Go, which ignored the store command (STDIN not read) and
then did a quick exit.  Even with this fast helper the race
was pretty rare, ie: was only seen on some of our older VM's
running 2.6.18-416.el5 #1 SMP linux for whatever reason.  On
these VM's it occurred only once every few hundred git cmds.
---
 credential.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/credential.c b/credential.c
index 9747f47b1..62be651b0 100644
--- a/credential.c
+++ b/credential.c
@@ -5,6 +5,7 @@
 #include "run-command.h"
 #include "url.h"
 #include "prompt.h"
+#include "sigchain.h"
 
 void credential_init(struct credential *c)
 {
@@ -227,8 +228,10 @@ static int run_credential_helper(struct credential *c,
 		return -1;
 
 	fp = xfdopen(helper.in, "w");
+	sigchain_push(SIGPIPE, SIG_IGN);
 	credential_write(c, fp);
 	fclose(fp);
+	sigchain_pop(SIGPIPE);
 
 	if (want_output) {
 		int r;
-- 
2.16.3.dirty

