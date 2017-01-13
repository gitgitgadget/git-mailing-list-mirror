Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55D720756
	for <e@80x24.org>; Fri, 13 Jan 2017 23:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdAMXyj (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 18:54:39 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36520 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdAMXyg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 18:54:36 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so38204369pfu.3
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 15:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3z7ibhDuZlFLAIBy/wHz8xRYfbt+be8XthoPKA+gEpQ=;
        b=F2qZmZxwx6bQOgBzgG8qfgevlPoYwaUdXzH8NnltM+5zPUjOU2W5EPq2qSR2vUjRHW
         PqVYSfAR9UFmSxpKWX2+BFZh5xXP4L9nPelprJxNvqfBxuPVp3ymB1I3w1slf0cPBONA
         CH1a/8G0tt8N5uapJKUWOCFIjGe/eUstU2Xa+qF6q7WKoHsSa+iggCDfB/ttfwvblB44
         nKvLbpv1PVkFDh9lOfQHQu8O+mg3eYnE85KORUHpF11grS8FROZdTSUiUHVLgtdoU36H
         sdT838MfA7VartwBxdJ/f+eu9XRBX3QHJFWDq8/PPaqSvPJUmW3l02G5SAzt/SQ7ZHTq
         OaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3z7ibhDuZlFLAIBy/wHz8xRYfbt+be8XthoPKA+gEpQ=;
        b=mepMa1vjKr6BUMlqJ/W8eHOl08l2SflJ7DvSwXwKbLiBsFsof2V34YrcRxRpyde68s
         iG8V6DNO1WP/Kf3njVIJ/R5urIysaFbpreiRN82TFtAky7efec/3b7CeThsf9tYzPV9c
         Ha2s4QWO7n2fqFkZ0J3H25D30FoLtplLDikpP4FS3CK2otjR21iM5EUsMSoqKF8RQLtu
         JINouIr19PnPQxtung7SBnLQPuXG4Aqwm2NtcKTjYWkwv0rFxprFsHwz67s1hAS23M6W
         C2fEXP2RkSlwaZtfV4iziyQnGKU6cX9paqlzXysrWtNHs4Z3UdfxCQfqsTGWzH2XkRin
         XUzA==
X-Gm-Message-State: AIkVDXIGRo5sjv9GD6DZnAXNBc1bnJQ4S2Pe72sDRgGt815pX9rajOmEJ7p/vW3bmv5rbJfQ
X-Received: by 10.84.210.107 with SMTP id z98mr33358738plh.171.1484351676226;
        Fri, 13 Jan 2017 15:54:36 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:a042:7b80:d5ae:3f4a])
        by smtp.gmail.com with ESMTPSA id x81sm31624291pff.69.2017.01.13.15.54.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 15:54:35 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, dborowitz@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] transport submodules: correct error message
Date:   Fri, 13 Jan 2017 15:54:27 -0800
Message-Id: <20170113235427.5768-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.297.g298debce27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When push.recurseSubmodules is set to "check" or "on-demand", the transport
layer tries to determine if a submodule needs pushing. This check is done
by walking all remote refs that are known.

For remotes we only store the refs/heads/* (and tags), which doesn't
include all commits. In e.g. Gerrit commits often end up at refs/changes/*
(that we do not store) when pushing to refs/for/master (which we also do
not store). So a workflow such as the following still fails:

    $ git -C <submodule> push origin HEAD:refs/for/master
    $ git push origin HEAD:refs/for/master
    The following submodule paths contain changes that can
    not be found on any remote:
      submodule

    Please try

        git push --recurse-submodules=on-demand

    or cd to the path and use

        git push

    to push them to a remote.

Trying to push with --recurse-submodules=on-demand would run into
the same problem. To fix this issue
    1) specifically mention that we looked for branches on the remote.
    2) advertise pushing without recursing into submodules. ("Use this
       command to make the error message go away")

While at it, remove some empty lines, as they blow up the error message.

Reported-by: Dave Borowitz <dborowitz@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 transport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/transport.c b/transport.c
index 3e8799a611..2445bf0dca 100644
--- a/transport.c
+++ b/transport.c
@@ -883,14 +883,14 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 	int i;
 
 	fprintf(stderr, _("The following submodule paths contain changes that can\n"
-			"not be found on any remote:\n"));
+			"not be found on any remote branch:\n"));
 	for (i = 0; i < needs_pushing->nr; i++)
 		fprintf(stderr, "  %s\n", needs_pushing->items[i].string);
-	fprintf(stderr, _("\nPlease try\n\n"
-			  "	git push --recurse-submodules=on-demand\n\n"
-			  "or cd to the path and use\n\n"
-			  "	git push\n\n"
-			  "to push them to a remote.\n\n"));
+	fprintf(stderr, _("\nSuppress submodule checks via\n"
+			  "	git push --no-recurse-submodules\n"
+			  "or cd to the path and use\n"
+			  "	git push\n"
+			  "to push them to a remote.\n"));
 
 	string_list_clear(needs_pushing, 0);
 
-- 
2.11.0.297.g298debce27

