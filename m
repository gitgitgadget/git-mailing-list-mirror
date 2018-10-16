Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1760D1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJQCFR (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:05:17 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:35351 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:05:16 -0400
Received: by mail-vs1-f73.google.com with SMTP id x7so10997498vsf.2
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dKkiRNzxRqU0laEc6xb/t6nsn4iaEPm7vic1aGSiMvA=;
        b=DXIa48EPSO7bbzBQf4WudNQW5ctiug9ibPYc6RMiRxqW6jrRghbqbfKjuPOdDhsnf0
         08/K8NQXNLHNMgoM+S+1BeWuXjRTnOqXXq5fNDH9lQRhUukN03gmJgw5nqKLTr4cRElq
         8/j3lW6TnhOLFGPOsf+/OAhinAaojG9ELcJ1GziNMC0qNXHXH/9XSeV7oFNJa4vi1wBi
         LBJdZdtf78auEgaDYjEIFdsb11VhvW0rA34n09akwor74g/CWw3aZT7/JDKnu4ON7KHS
         knl8z6CrDUipJZCz6WxsVZ/juHVmbVaUF1S4g4533Is6OWrde1QgoFN6qBTseZBT/C7d
         y6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dKkiRNzxRqU0laEc6xb/t6nsn4iaEPm7vic1aGSiMvA=;
        b=t61+nkI34IoYg3gjeVmTkq+GrKF7UevRPuVyhzZQCXrv3XnFXzzyfbImXzL5k+LHmf
         5a4Wp+9vzdZfDwcrFBQD1FbAPcf+52jeUoeHSY1gyRYgZBfJP0d7Z+uMQJHEy4tDxdtq
         DeKgXQHfO3oceQnkMaTc94fS4Xe3cNiBdU8vM57p/N8cQmQI2r6ITIwg1tf9rOl07d7Q
         iKesIl5ZWzmUaqx1MuO7lLDJk6uTQyrsrNNUiBhVbEs7V+gGYbKuAo8s+dPjN/tZ9Tfs
         p/sfzLFI+neFNUI4OqOL0u2URlWm4repX8BhqZZXKj3OaxYiicRMYz8A46J6yMN+Chc0
         HtLA==
X-Gm-Message-State: ABuFfogX3VWAMJi9tth3e4i3WQaZqxDqHhTcPpdmd75g1oV2GRg1y3XP
        w114kFsyTTuiyWSUq1eskCynu+5CdxYK
X-Google-Smtp-Source: ACcGV60WyOJitA6ePTZZk31SQbzp3oedHkR5Ll/pYX14cOc0jmHUgTXJocURrXwvO90PMM6jZD67oeOYJY74
X-Received: by 2002:a67:854b:: with SMTP id h72-v6mr22352149vsd.31.1539713617384;
 Tue, 16 Oct 2018 11:13:37 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:21 -0700
In-Reply-To: <20181016181327.107186-1-sbeller@google.com>
Message-Id: <20181016181327.107186-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 3/9] submodule.c: sort changed_submodule_names before
 searching it
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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

