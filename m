Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5EE21F4C0
	for <e@80x24.org>; Thu,  7 Nov 2019 19:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfKGTIK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 14:08:10 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:59921 "EHLO
        smtp1.lauterbach.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfKGTIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:09 -0500
Received: (qmail 2117 invoked by uid 484); 7 Nov 2019 19:08:07 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.10.40 by smtp1.lauterbach.com (envelope-from <ingo.rohloff@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.40):. 
 Processed in 0.08509 secs); 07 Nov 2019 19:08:07 -0000
Received: from unknown (HELO ingpc3.intern.lauterbach.com) (Authenticated_SSL:irohloff@[10.2.10.40])
          (envelope-sender <ingo.rohloff@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <git@vger.kernel.org>; 7 Nov 2019 19:08:06 -0000
From:   Ingo Rohloff <ingo.rohloff@lauterbach.com>
To:     git@vger.kernel.org
Cc:     Ingo Rohloff <ingo.rohloff@lauterbach.com>
Subject: [PATCH v2 3/4] remote: Prevent users from creating remotes named "refs" or "refs/*"
Date:   Thu,  7 Nov 2019 20:07:49 +0100
Message-Id: <20191107190750.26674-4-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107190750.26674-1-ingo.rohloff@lauterbach.com>
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
 <20191107190750.26674-1-ingo.rohloff@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type:   text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To explain the intention, here is an example:

A user executes
   git remote add refs/heads <URL>
   git fetch refs/heads
after this operation
   git log refs/heads/master
will very likely complain that this reference is ambiguous.

The reason is, that you now very likely have the following two
references which both match:

   refs/heads/master
   refs/remotes/refs/heads/master

git cannot decide which of the two references is meant.

By preventing the creation of remotes which are named
  refs  or  refs/*
this issue is circumvented:
  git log refs/*
will never refer to a remote tracking branch located under
  refs/remotes/refs/*
because such remotes should not exist.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
---
 builtin/remote.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5591cef775..2272c16d18 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -189,6 +189,9 @@ static int add(int argc, const char **argv)
 	name = argv[0];
 	url = argv[1];
 
+	if (newname_has_bad_prefix(name))
+		die(_("Invalid new remote name: '%s'"), name);
+
 	remote = remote_get(name);
 	if (remote_is_configured(remote, 1))
 		die(_("remote %s already exists."), name);
-- 
2.24.0

