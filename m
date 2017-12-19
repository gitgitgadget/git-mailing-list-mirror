Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900AC1F424
	for <e@80x24.org>; Tue, 19 Dec 2017 00:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935647AbdLSA3f (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 19:29:35 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:33984 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934385AbdLSA3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 19:29:34 -0500
Received: by mail-pl0-f43.google.com with SMTP id d21so5874842pll.1
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 16:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id;
        bh=NAxA90hOHr2H06xEkm0s7cij8Er2BK6PZUQ3gpGkxcY=;
        b=uQltvPoVsvX8CztVNnt7Dlcv+CSY0+i6rkhuVDbrzleZrioTEfm/NOSsVku6u4XO0R
         kYHh6jErq3k+pgc0MwmRi78zaPBcoPsZNSyUp699Pl7/w516ssToAifiytML8o9x21Fp
         nWKJqj2VzVIzGNMLGYYpS7ESwVZUf2R5lOTPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NAxA90hOHr2H06xEkm0s7cij8Er2BK6PZUQ3gpGkxcY=;
        b=GAdY1Lf8EXC/fYMFfyY9B4xICHYNXa2mwzdMn95kJ43dCu4ClpgCjQYVgJNMOZfOdm
         mKWQR728mydUwgzkLlELgx+IgCWhoWW+1mp2YNuj2saQfh4xut8E16J0rFUjl5lTcpgN
         vxbU9N4M8MQetfQkJ9RKB0n/xCLUdM72e/vF4QynN/B/XTZCPc4D8dyz/5JBWF+ZWVMb
         ozoovCYpJgqeeLttBAE/ROAD0OgWih/vcN5NxJanjouS03f8xcJuX3NBN1qVanZQCDTo
         3PtjY4IrFZs3mD23U/O6xF3BFjRH9LakCPReilmNGJagE2rKnGlez1e4uERRHe1U9v23
         L4+A==
X-Gm-Message-State: AKGB3mIW2OgCsxfgaU4/BE8z43AfX44lepKvOImOGT4Wd88uW/ni4mDy
        rDv60JBZzfEE7hCn29x2ZJHT89+cN5g=
X-Google-Smtp-Source: ACJfBouaa87RaP8tQny6Owjael0bMmbtI5aY4oO20/u91se2fIV0+uUoP1bWBSXu3wRKWIOnrAz0nA==
X-Received: by 10.159.197.5 with SMTP id bj5mr1417019plb.219.1513643374122;
        Mon, 18 Dec 2017 16:29:34 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id b10sm26056581pfj.20.2017.12.18.16.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 16:29:33 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 0/6] Minor fsmonitor bugfixes, use with `git diff`
Date:   Mon, 18 Dec 2017 16:28:52 -0800
Message-Id: <20171219002858.22214-1-alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.626.gc4617b774
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cleans up some mistakes I introduced in my previous series, and
switches `git diff` to use the fsmonitor data.

I've noticed that `git checkout HEAD` drops the fsmonitor data, which
surprises me -- the following patch "fixes" that but broke tests, so
there's something I clearly don't understand yet going on here:

--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1262,6 +1262,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
        o->result.timestamp.nsec = o->src_index->timestamp.nsec;
        o->result.version = o->src_index->version;
        o->result.split_index = o->src_index->split_index;
+       o->result.fsmonitor_last_update = o->src_index->fsmonitor_last_update;
        if (o->result.split_index)
                o->result.split_index->refcount++;
        hashcpy(o->result.sha1, o->src_index->sha1);


 - Alex

