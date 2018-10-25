Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B991F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJZIHX (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:23 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38136 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeJZIHW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:22 -0400
Received: by mail-qt1-f202.google.com with SMTP id b55-v6so11001910qtb.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dKkiRNzxRqU0laEc6xb/t6nsn4iaEPm7vic1aGSiMvA=;
        b=nApvsjj2CIcdu2pjJtV0C/oQod1qenJqzDfKuJWbDZc9+f8RY+47enLb2MzgsRNWno
         dgLzuun4I0MtV7NlzA/CCH414MmUkWjsk7VUtdoW8RPgmy4LYIOU64yqmVGzPw5dqb/w
         tvxZuAShqr7rfHRmImI4dhWC34/ecHHo9sAS4IBa0bK5yOgu3AzGkiaRiWzYZVCsUxOU
         C8QxmIOInKEgrSuJ9Wz0Y+ISewN/qp5+R0xYQslRFj8mBPKaL7aofUVzDAUDdnsFMQdU
         2p9y+yMfTOYKdojnGCVky0A0ja9UXDJLIRzDKjxrZbTL5ADYCR4GD33oT96f7151aThI
         6jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dKkiRNzxRqU0laEc6xb/t6nsn4iaEPm7vic1aGSiMvA=;
        b=uHxCVmhIzLAmNiJqfqjU1N89e8PkqLGA1YTAZdZuxGERbk8ApLTWjDI9P4qTede+v0
         ZykzTOVZRl8OH8QgGQdXzX+NjV5+vhDWE8/FvyV4ROcOpIhIa1mVc2aZiyAD8tg4E2R/
         Eq+1l8jkLPXrpmjbKrMnVpkwbFiNWCpj/IDHZjeAR55wTbTlOHrFqgNLC0jCMF2/zhKt
         4u2NC1MgQGYUaozK1LzXDbrluAhqrXletghVVrMsbRoQtBwqi6MshcFnJxGR6oBU6oF6
         hGlpdQcUEOI1mTHRkd0GxaHflf1fqW7x2SBTqnO++Za1CkA2DqygXatWqCl0OQnVl0vm
         IqBA==
X-Gm-Message-State: AGRZ1gJr40sSbyfn6Fdxu5w5gtIwyv7i3Nc09i20KlRiEsH4pNDF+nWj
        lXzY92TjFp6oko0yIrbc5O9SgaaQFEZk
X-Google-Smtp-Source: AJdET5d3o5Y5bgqxISd64wz8NcW+HeH1nIhFFx+NgdAlV0cHoL35gcJVOjSdVWQAnRZKTpUoc6DRFZJbcGYF
X-Received: by 2002:a37:6082:: with SMTP id u124-v6mr1197501qkb.14.1540510364140;
 Thu, 25 Oct 2018 16:32:44 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:24 -0700
In-Reply-To: <20181025233231.102245-1-sbeller@google.com>
Message-Id: <20181025233231.102245-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 03/10] submodule.c: sort changed_submodule_names before
 searching it
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can string_list_insert() to maintain sorted-ness of the
list as we find new items, or we can string_list_append() to
build an unsorted list and sort it at the end just once.

As we do not rely on the sortedness while building the
list, we pick the "append and sort at the end" as it
has better worst case execution times.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index e145ebbb16..9fbfcfcfe1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1270,7 +1270,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
-			    !unsorted_string_list_lookup(
+			    !string_list_lookup(
 					&changed_submodule_names,
 					submodule->name))
 				continue;
@@ -1364,6 +1364,7 @@ int fetch_populated_submodules(struct repository *r,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths();
+	string_list_sort(&changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
-- 
2.19.0

