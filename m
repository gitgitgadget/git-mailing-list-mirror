Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55FF11F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeIRDFW (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:22 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:44893 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeIRDFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:21 -0400
Received: by mail-ua1-f73.google.com with SMTP id d22-v6so5757698uaq.11
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aePnPx2YqOtLYlyVK5CDLEc/HmVD9vFEee9X8pOHmKg=;
        b=N49N58/fPUa0Q1zFZuOt9Ve8QEWfOhI1c3hU9urAwHH2LVBW4sXc0k2MqMCkr3cBt1
         z7AVb2SuePehDhJQqbH9nbZHfKJkTYV3v5etIAQPXJUEHD9IE+VX//SdfKY+dVP+kjB0
         te+8RK35/kfwF0kqCEM4TDpWoMuJd7vFLvdVnVKlVele57WRkAnM9k9bRr7hy4KfvlTr
         c+KfpJyhdMGnVfve0qIEqkVy4U8nOJvKB2SfUbsNqfTE3R7Bl2snfBGG9cMLDJoW8Ffc
         FUzWnwvMOdK+RpQrVVfoNBhp4Hr6QfgHDcIGeHPxQl/u5VrOSzdG49C+3v1kWSeF8Nj/
         xdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aePnPx2YqOtLYlyVK5CDLEc/HmVD9vFEee9X8pOHmKg=;
        b=lMc8uwze+uCR+4AlFtMQ4aAv/8dJVPChO4zMLsyuTCKG5CpoVXd7mSQ6VsbZ79Rl7l
         YixY8QCi4DN1rQI0sTEhELIDzMdfv1xbiFMgJj85Fd88b7s53jtJRdDZEFYqu/TGIFHl
         Ec0PCXaDRnBP82ZHc5L+DQls0jZFcvS/azMauq0t1f0Mp8f7jl+m6sgtJsVK3ZAj4iJy
         e45YxF4UJoRTimj2rgw8ImeUNZKOxyQ5sbZv43oMtBOXwPjqsiQFLuWUO0upZ6BGY0LE
         TV5b1PWaiguWLsy0T30sYvDPyjNDSHayIIidErEdLKnJZhrmgJgV1p+ZXm589eBGSVGZ
         gomA==
X-Gm-Message-State: APzg51BuwoBfa+T0TlRY4xqyMnCaqMIokVEHdt85PSrRULBw3Jwe39x9
        UsjcwoD6LGZ8ngUd1z6ezoMxPModzVRS
X-Google-Smtp-Source: ANB0VdZW3oTrBv9haNtgzpEZtwNIfB6eOAru7jVK1K1XjySNJ739zL3s96VXaInntE/aQPecQ5BDO/ZRuUke
X-Received: by 2002:a67:a8ce:: with SMTP id h75-v6mr5607253vsi.48.1537220172406;
 Mon, 17 Sep 2018 14:36:12 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:54 -0700
In-Reply-To: <20180917213559.126404-1-sbeller@google.com>
Message-Id: <20180917213559.126404-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 4/9] submodule.c: sort changed_submodule_names before
 searching it
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can string_list_insert() to maintain sorted-ness of the
list as we find new items, or we can string_list_append() to
build an unsorted list and sort it at the end just once.

To pick which one is more appropriate, we notice the fact
that we discover new items more or less in the already
sorted order.  That makes "append then sort" more
appropriate.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index d29dfa3d1f5..c6eff7699f3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1256,7 +1256,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
-			    !unsorted_string_list_lookup(
+			    !string_list_lookup(
 					&changed_submodule_names,
 					submodule->name))
 				continue;
@@ -1350,6 +1350,7 @@ int fetch_populated_submodules(struct repository *r,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths();
+	string_list_sort(&changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
-- 
2.19.0.397.gdd90340f6a-goog

