Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF9B1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeIRDFd (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:33 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:52160 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeIRDFd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:33 -0400
Received: by mail-it0-f74.google.com with SMTP id q5-v6so368319ith.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WuOjcVomLEraU5DuyDhDDDKiuQEUBzcIXg3M6UrkuCU=;
        b=OWHnkdDv8LmE7ZYXLHsACl+2jUCXgsY/gSHlK9xqwSyeaRAdXZ4FS+nyS2Ag57yucN
         Nik56xgpqcMl5K8bAXfDr+7937rauUJoWg+lo8T4Ln4vmmPiolXTZb8Ug6Lv+JwtcDGu
         UWMQ9IBeDNaYTy+CQGQXu4jFIHov22HAJ1c5xP79hv43tsgDdRsYMXPpEY2QzM6eqNxF
         JFfzHJleo8s4VN23fq9xIBacXommutjx3MKwdl7ff59EgFOUC1DM3ITbWBLUVUR8Icno
         8lLHfLIDLZ+bTh0U0uMbnjZ+4ZjPosAkar9QjJNR5q6wYr9dYAG+7NbMZD3tJrL462kP
         sSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WuOjcVomLEraU5DuyDhDDDKiuQEUBzcIXg3M6UrkuCU=;
        b=k/m+37bINO1B8YWKjDMBvQkaZFriND9RJIagGfO9zV62YsndrNpRoEDs1ZdBrNFVwG
         gOssH2h33LWhCVqUlnQedxgI6Gbv850VURNagJWSBCKabtDXlvmv2JCHSdHwFwhV341F
         vZ0c38pCyYz2jEwoqCxHjVByo22dF1a9OqXmk+GFhdL9tKeumh9Le7+9lhJG0DlwHcU3
         pZf8yk8XMUyFi+rm+sOoSezCQqVzqePTiovclDd8aEOuRk2KcLn8vTHY6SYAdDLlgvEB
         kJxDHC2z1B5X3UqyCgUZqGaEL0H6R84ifsZP5ovUlVyoIbvgBZ/3lgMCfdkanj5Tvmeh
         8xJA==
X-Gm-Message-State: APzg51DHryaXtn5xeNkSXK4MMQ4gshPAqXNzKd8jKOphjnd4Md3dlN/M
        5RCNIEQt22SUwFiuxk88xkUcG88+xNHp
X-Google-Smtp-Source: ANB0VdZScbn/xBW1dMBkgDxrEi7IyCduuvn4Zxp1KzeXD4gLoqiXX8SuyhPrBKrKvetoVKZc3Wzmtlk/XaRJ
X-Received: by 2002:a24:5953:: with SMTP id p80-v6mr13211081itb.1.1537220183494;
 Mon, 17 Sep 2018 14:36:23 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:59 -0700
In-Reply-To: <20180917213559.126404-1-sbeller@google.com>
Message-Id: <20180917213559.126404-10-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 9/9] builtin/fetch: check for submodule updates for non branch fetches
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gerrit, the code review tool, has a different workflow than our mailing
list based approach. Usually users upload changes to a Gerrit server and
continuous integration and testing happens by bots. Sometimes however a
user wants to checkout a change locally and look at it locally. For this
use case, Gerrit offers a command line snippet to copy and paste to your
terminal, which looks like

  git fetch https://<host>/gerrit refs/changes/<id> &&
  git checkout FETCH_HEAD

For Gerrit changes that contain changing submodule gitlinks, it would be
easy to extend both the fetch and checkout with the '--recurse-submodules'
flag, such that this command line snippet would produce the state of a
change locally.

However the functionality added in the previous patch, which would
ensure that we fetch the objects in the submodule that the gitlink pointed
at, only works for remote tracking branches so far, not for FETCH_HEAD.

Make sure that fetching a superproject to its FETCH_HEAD, also respects
the existence checks for objects in the submodule recursion.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             | 5 ++++-
 t/t5526-fetch-submodules.sh | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95c44bf6ffa..ea6ecd123e7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -887,11 +887,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				rc |= update_local_ref(ref, what, rm, &note,
 						       summary_width);
 				free(ref);
-			} else
+			} else {
+				check_for_new_submodule_commits(&rm->old_oid);
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
+			}
+
 			if (note.len) {
 				if (verbosity >= 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index af12c50e7dd..a509eabb044 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -615,7 +615,7 @@ test_expect_success "fetch new commits on-demand when they are not reachable" '
 	git update-ref refs/changes/2 $D &&
 	(
 		cd downstream &&
-		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
+		git fetch --recurse-submodules origin refs/changes/2 &&
 		git -C submodule cat-file -t $C &&
 		git checkout --recurse-submodules FETCH_HEAD
 	)
-- 
2.19.0.397.gdd90340f6a-goog

