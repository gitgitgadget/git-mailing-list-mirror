Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F001F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJQCGG (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:06:06 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:42526 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeJQCGG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:06:06 -0400
Received: by mail-it1-f202.google.com with SMTP id v125-v6so26843640ita.7
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nfr1jpOQmzwQFPfOqjexMqzJUD/hwxx48KXiGXgBQ3s=;
        b=ZUq2OTYcUEW9NT/yB3Ka2Mo2EZ0sA7Vjhaz+9b+eYZ2C7m5m9Yyo/tX0vX1q0BFtDI
         4Q1tBBnQRCKGi5aOzFoRGyNEERxkiudutcXfPeEnRWS/wABtpFcQuF+9x7ZxYLdTeisM
         5QPi9iSGJmIgokyKYRAXPWHbJ3CGhcij9k52kG/zB0UDzp20VJHfqnbnvoaDqSqVSfuW
         N5sfPmST37pPc5q3Ds7DyPUzKilueWXwtUXJUuVgks8rbp8DARyYHuCU7Q1KPOTe6fhe
         VSXN4KSTDtq5tj2O8oNBnv3QN7D1nFiK2rpf9uAMi13fmYo00rL6FF2M9o0dfhzWE/AT
         D6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nfr1jpOQmzwQFPfOqjexMqzJUD/hwxx48KXiGXgBQ3s=;
        b=dipPLVITuJAu6tM70Zo+eSYUJJCrVGXlX9ZRttzQ77s/bDXpPRZXdsk1ZvzGvb3cHX
         2f95u2f+W8uO0ZOJMIoHil4we2jqrY8gXSCN8letleFa7B8rUvUGXjQPubA4TcSv9n+C
         CPmqg1MO+maWvnz2JLetuva3mRALTtPFmQH9HmXG6zF/ZaTE2wPmQDs4kGuD2qCeGiuk
         LCunxx5artFtmLag8hep1p1Na592AJF8UpWwwWtSYJBq1/uX31Cxiu5BJ8HhFS54kGWy
         GpreWHGcjnKg5jALKWd7LNgiAxjV+RqRqNlMxeNjp50/RWYesAp9BRJG58BNZgY5kSDS
         0iUg==
X-Gm-Message-State: ABuFfohSshP3T2t0/RaeYikccSa5/hh0Uy28R2zps/TlR8dsSNsHMceG
        +Ck+W5iJJeNf9y7N1IDRqvla/3xpAbkr
X-Google-Smtp-Source: ACcGV6145UWlF8+qnjZm8F6CuXM40BIqxP9+Ubvb5sI/UKFoh8Ia0MRmJGcQZrfykDHi5iCuCmdS+1HDVj9m
X-Received: by 2002:a24:5517:: with SMTP id e23-v6mr20995909itb.1.1539713666437;
 Tue, 16 Oct 2018 11:14:26 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:27 -0700
In-Reply-To: <20181016181327.107186-1-sbeller@google.com>
Message-Id: <20181016181327.107186-10-sbeller@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 9/9] builtin/fetch: check for submodule updates for non branch fetches
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c             | 5 ++++-
 t/t5526-fetch-submodules.sh | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95c44bf6ff..ea6ecd123e 100644
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
index af12c50e7d..a509eabb04 100755
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
2.19.0

