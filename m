Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE0F20248
	for <e@80x24.org>; Thu, 21 Mar 2019 15:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfCUPnN (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 11:43:13 -0400
Received: from mail-yw1-f43.google.com ([209.85.161.43]:37987 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUPnN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 11:43:13 -0400
Received: by mail-yw1-f43.google.com with SMTP id m207so5101506ywd.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+jnRkxQRIEv2dAWFXumXh5qmeBRkKcIz68BzGmHnnHY=;
        b=HTWNzhAZFKZi8nY1MuGSS81t9JsjtOup1P+CCvh4PvRpD4xIUQ2Id+oidbqVzHtJoS
         jCk6K0daQUX016GCjMVO1wq6PnOOdedik/SbXuZOZJJ9xFKVuAc5t8jwX7NRSZJ9OWjt
         uKYIau008fmjkHpaNKPgTAdX6I7usDTj3icyNvCuvx6oOdnfai4VrleqhMLvKHXz/KSa
         HY7a+amL/3XgJGS+g79iZcpLJWyWJz6Gz0jE4CXO3WvIVmqMpx9FkvH46BeiTm8qGBvp
         ETUN7by7h1ozu/zE8KqLYaa9xyG+z/A5+d2lpfQezWEVMRd2U0YnUJLLranweG/qZd7R
         aiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+jnRkxQRIEv2dAWFXumXh5qmeBRkKcIz68BzGmHnnHY=;
        b=h4kMS+VgyppJz2cosu5VukipvQs0yex1TIqTSiplOtHHAQe4d2HxAj1FUvsD6rZbcy
         mO0o93Qc/G0x2Isfn2ezerUaIBkBYQA4ytf2lZDA4g7b58Q12rMxuUznQ71tvsTuI19a
         pD76y3zgzql/Dfm0ar4LGkM8oUAtMwiGATtCUV/VCcpgOK8l7ORekblhTWBjOCGb8F1a
         DRF1nDM8GEJ9ZBoZ6YSLa+9UEeI8OIOLiOwrmo48NI3RlUFqSMvI9536gP/cecm3ZkSF
         /7HuI5SlEy5wU/Kb98rwCmW8PGG0IhbZZPVbf5/9zPBEpB530ROMP29PwlnvwfrYEaq4
         7BAA==
X-Gm-Message-State: APjAAAVr7P+8IEIYxKzgX8AhKKBTytFlXkwCxn4a1vbOh/856IuPJozJ
        ykkURBv1iIEoa3MF5ekCl2vFnx2G7UjvitAP2CsMWKjtvn4=
X-Google-Smtp-Source: APXvYqw6h+UHZxQtf9LuaYSo2P1Q/ETLACvhJ5BKOAFYT6Lg4WCfFDymdx9jg9yZ2M9obf/hTHkess5zsEm3qbhjGGE=
X-Received: by 2002:a81:514f:: with SMTP id f76mr3706275ywb.485.1553182991968;
 Thu, 21 Mar 2019 08:43:11 -0700 (PDT)
MIME-Version: 1.0
From:   Leszek Swirski <leszeks@google.com>
Date:   Thu, 21 Mar 2019 16:43:01 +0100
Message-ID: <CAGRskv__Qe-F-grBtq5v-uhHE+BQAcAcOQtX-GKB+MNOrxs0hQ@mail.gmail.com>
Subject: Bug: git checkout @{u} breaks git branch if the upstream isn't a
 local branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Consider a repository with branch master, with upstream origin/master.
If one is on master, and runs "git checkout @{u}" to get the upstream,
then git branch stops working. The reason is that we end up on a
detached HEAD, and git branch searches recent reflog entries to figure
out where the HEAD was detached from (wt-status.c:
wt_status_get_detached_from). Since @{u} is not a local branch, the
checkout is inserted into the reflog as "moving from master to @{u}"
rather than "moving from master to origin/master". This is because
setup_branch_path (checkout.c) only updates the branch name for local
branches, keeping the input name (here, "@{u}") otherwise. So, git
branch sees "@{u}", decides that we are detached from "@{u}", tries to
lookup "HEAD@{u}" and fails with "fatal: HEAD does not point to a
branch"

I assume that either the reflog entry should be amended to print
something more informative (moving from master to origin/master, or at
least master@{u}, or the SHA...), or the reflog search in
wt_status_get_detached_from should do something cleverer with relative
refs.

- Leszek
