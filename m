Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4D9207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757692AbdDRXSP (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:18:15 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33112 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbdDRXSL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:18:11 -0400
Received: by mail-pf0-f179.google.com with SMTP id a188so3419818pfa.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UXFWruP544C6TifRH9B39eb0wT/pLFdsZbVC/GdaTQ4=;
        b=KYHPUoFImiidf+9OaAPfsxCl6ZTUKuxw1XUaH7mQvgRWVX6Qy72TM8EF9J++dY3qnh
         EP6m6uG3NOTPYVbq8yofwTCQC5vCPN9HyoxX8Sbve71iEp+cMIAxIDoshrZS5iX/yKkh
         G5hzzmJQoNEik3NDvbvgshl2XTh9M1SGFMCZ+X9LFUjKk4JndXax/qxomSTMRpkRJrts
         mruxUf+ZZXH5WAkmeoth8HAyeltfdsOmFoC3OcnXmFn+Ae5u/ZoDoCIwIHZ7wi1IP0dF
         lhLtZDdIo/fm2iNumMLztUXOJ6RLLcDiu/h2MEEmnJlVdqoDXy+7Q4I+CDhYK5Fl0JMW
         CKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UXFWruP544C6TifRH9B39eb0wT/pLFdsZbVC/GdaTQ4=;
        b=bKH6bvEASCVwlloiP3jYRKEB41jymeWqraF6j+MPXDrtyKFDZbqy4jnfWOuGsDmE/U
         p4cd/FA2x3TRMnzg7PQ9hRyR+MInPv/eh5fiYZSxVCHxiJSspZ3bT/e56rCfo1RseYm9
         jr5WZxhvU4tncitlsM6/fMaMpchlAWFJJN/qHYw5O8IaLVQrRo32nN+5mB9/K/1aGhBh
         HCuoHAGgGOpFG/i0hIwr94AANN2kXfjgKZeJO8jtyb+xVUws8bC0MADt1nJ71wK8Sefo
         sNNmYms7T6vaSqXkCaiKU/zP+1gCZiOAuTGlUpzBM07m049nzwQsIeK5H/wJwsPvlJr4
         vPQA==
X-Gm-Message-State: AN3rC/7ptT08ShJpeIhrGZ6MkzavuqwXc/W4nrIm252Qb2FwP9SJQhug
        zzfP30rA++EQv9PA
X-Received: by 10.84.229.3 with SMTP id b3mr26705479plk.190.1492557491173;
        Tue, 18 Apr 2017 16:18:11 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id z21sm492764pfk.95.2017.04.18.16.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:18:10 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, e@80x24.org,
        jrnieder@gmail.com
Subject: [PATCH v5 00/11] forking and threading
Date:   Tue, 18 Apr 2017 16:17:54 -0700
Message-Id: <20170418231805.61835-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 addresses the issues with creating the child's environment.  Instead of
doing vanilla C string manipulation, I used a struct string_list and struct
strbuf.  The code should be much easier to read and understand now.  I also
needed to add a function to remove a string_list_item from a string_list to the
string_list API.

Brandon Williams (10):
  t5550: use write_script to generate post-update hook
  t0061: run_command executes scripts without a #! line
  run-command: prepare command before forking
  run-command: use the async-signal-safe execv instead of execvp
  string-list: add string_list_remove function
  run-command: prepare child environment before forking
  run-command: don't die in child when duping /dev/null
  run-command: eliminate calls to error handling functions in child
  run-command: handle dup2 and close errors in child
  run-command: add note about forking and threading

Eric Wong (1):
  run-command: block signals between fork and execve

 run-command.c              | 404 +++++++++++++++++++++++++++++++++++----------
 string-list.c              |  18 ++
 string-list.h              |   5 +
 t/t0061-run-command.sh     |  11 ++
 t/t5550-http-fetch-dumb.sh |   5 +-
 5 files changed, 358 insertions(+), 85 deletions(-)

-- 
2.12.2.816.g2cccc81164-goog

