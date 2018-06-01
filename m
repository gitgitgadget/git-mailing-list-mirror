Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5211F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 20:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeFAUBw (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 16:01:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33179 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbeFAUBv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 16:01:51 -0400
Received: by mail-pl0-f67.google.com with SMTP id n10-v6so15900233plp.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a2aKZ0+ZFCgNUTP+NiDJVSeqGgzkrPLUZIMBjkpiCVI=;
        b=AoD3zRRVPWqpE2654YhXMdGcbIo6Gb3/BaYpGd/26KcbK9QShg54mHBITGPezcr/Bk
         zv8c53GlhXlJKGKUB9MSatClekk2XtvC8c8U/UwgxlmMiOL3MJEq4BN5GKEWSb3X7uFt
         gdzn5sg2V5CZAMEpIpTNxlM8+hRAU+Um6D4ztrir3m10kze7wsY++QhoPuOM70Ul9QEY
         BtRXzvLg7cuYyMbA/nYaDXwQfsg5LhvhFeeOnHR36PjTXhng58F85Xe4PDm/RYqsuQWm
         +UJwP93cY5XazDzFJuhYB+BRMP+YiETFSiF5vCKFJR4E0Q3xlfYU5t8xHqKO1Do795bO
         0Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a2aKZ0+ZFCgNUTP+NiDJVSeqGgzkrPLUZIMBjkpiCVI=;
        b=sVKxMZZWsjgOhUY2Ww2D5BcH8/yomDG3u6WSQzlFFouzOggfO3BcE5YURjx8OfQmXG
         +5oJEmPlWCU9UboepDjigFUcIvqvECi79PO+5I5xQIJ1yPbN2HSZzToQaqoBkOX3abX+
         C+Jhj9ha2jRubMBca4k4eq8mC65XuKPKmfBQUBwSU8LlS1nuH+x8TV1l/aIsc+fuf+d3
         vl3ePHUv9F18wc+qnflAMYFtL+mb+uqKT5Si9qBPGReViBMTBuln9nwvuuNSPOCLZsxR
         x9ODpUPR5GNRKsV88LQ4f9P8JZDqTivqSsPX7XUYKxOU2R2OVpURx95puAa3q6vxkPwS
         s5cQ==
X-Gm-Message-State: ALKqPwcMLc6XuX8sNjY0GcTyyypWyGoWwYcFuUnT2LS9rZI8s/6G3vBE
        d2P7CxOEZjA/FdOuEIpViaY+Qw==
X-Google-Smtp-Source: ADUXVKLJHQ2xm7tUjUY9X+kqePKIjMqjehVg3t5w25/r+ImrQB6bKs1/bqWJmf2ajqnN41062E4gTQ==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2-v6mr12245311plb.295.1527883311002;
        Fri, 01 Jun 2018 13:01:51 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x19-v6sm29041360pfi.5.2018.06.01.13.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 13:01:50 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] sequencer.c: plug leaks in do_pick_commit
Date:   Fri,  1 Jun 2018 13:01:45 -0700
Message-Id: <20180601200146.114919-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Going to leave, we additionally free the author and commit message
and make sure to call update_abort_safety_file().

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This patch can apply on master.

This is a follow up from 
https://public-inbox.org/git/nycvar.QRO.7.76.6.1805311402210.82@tvgsbejvaqbjf.bet/



 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index cca968043ea..b98690ecd41 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1773,7 +1773,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 &head, &msgbuf, opts);
 		if (res < 0)
-			return res;
+			goto leave;
+
 		res |= write_message(msgbuf.buf, msgbuf.len,
 				     git_path_merge_msg(), 0);
 	} else {
-- 
2.17.0.582.gccdcbd54c44.dirty

