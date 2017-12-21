Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FBF1F406
	for <e@80x24.org>; Thu, 21 Dec 2017 11:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdLULLw (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 06:11:52 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37512 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbdLULLu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 06:11:50 -0500
Received: by mail-pf0-f194.google.com with SMTP id n6so13827142pfa.4
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 03:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PyILdMmJ0BSWaP+2H4WOvMhi1Wvj/+wBZQYkI513lSs=;
        b=BuAVMZrmTpb1inZYjgEfk65Kb4xGjaKy1Y/cXrbx+QfesC/ysC5rQtuNyh4+DDa/gU
         bxk/t+84D0OnuFH1vRPEjB2TEhkMW0jrn3ZoE6vSrlCLbmFYVUIYnIrIl0CNqJ8sSZAU
         nEXTHt3Pzm67/zgVJ0h8WPpVTRxVfO0C87ZHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PyILdMmJ0BSWaP+2H4WOvMhi1Wvj/+wBZQYkI513lSs=;
        b=akZrvxEk2ggtOC0JBQagcJuN4xT67qJ/ljUMLtwCkFutoyDZNkU0VpJCYAm26T/7ks
         xMuaTbaHf5a0qG8Ug7OEE/kl6SbRc7CdNNzUnvIV7GdryFupMNPxXkc5Wx+TWv5v2Q0A
         kaG5/h3U58+rVJdb/t/n5os/+N/Y8MELVKgVItInwRdaDLReqC1g/v/jfCi09tDz7j/8
         Ye/iDUGY29yYKEPULsKpLgNl/XxhghabM16N7tq/iFQokMxgJM4h/JaSQpAHX6OIawIK
         FZb6/tEeNA1z8ftZI9GOgjyRWKvxTkqIJSMOVgR766aSCSUuj51LXg7k+9x2NbD2FEqc
         7tHA==
X-Gm-Message-State: AKGB3mJZf1kYBOy+VWIkuLIYhJ+MyamO1+tCOzXx9T5syTOncBdbmRYo
        0vMFILvFf0DPDBJFchAAVQ9wmRdG
X-Google-Smtp-Source: ACJfBoszpKB0mKi9eY/Xj90Gbhjjb9WWEZ4e63eIPv+6FIQznhN9Hs4w9KfwaRSuxRVzrGntndHxvA==
X-Received: by 10.101.72.76 with SMTP id i12mr9209575pgs.436.1513854709794;
        Thu, 21 Dec 2017 03:11:49 -0800 (PST)
Received: from ldiamand-t3610.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id n3sm33705912pgq.30.2017.12.21.03.11.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Dec 2017 03:11:48 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     viniciusalexandre@gmail.com, miguel.torroja@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        gvanburgh@bloomberg.net, Luke Diamand <luke@diamand.org>
Subject: [PATCH 0/1] git-p4: update multiple shelved change lists
Date:   Thu, 21 Dec 2017 11:06:13 +0000
Message-Id: <20171221110614.29300-1-luke@diamand.org>
X-Mailer: git-send-email 2.15.0.276.g89ea799.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change lets you update several P4 changelists in sequence. Say
you have several git commits which are all somehow related. You would
start by shelving them (e.g. for a review), something like this:

 git p4 submit --origin HEAD^2 --shelve

You then make changes to these commits (in git) and now need to re-shelve
them. Before this change you would need to cherry-pick each change onto
a clean branch and do "git p4 --update-shelve", then remove the tip and
repeat.

With this change, you can just do:

 git p4 submit --origin HEAD^2 --update-shelve $CL1 --update-shelve $CL2

If the shelved changelists overlap (one changelist touches the same line
as another) then this won't work, but that problem already exists with
the --shelve option. Solving that is pretty hard to do as P4 really
only understands files, not changes. Despite this shortcoming, it's
very useful to be able to do update shelved changelists like this.

Luke Diamand (1):
  git-p4: update multiple shelved change lists

 Documentation/git-p4.txt |  8 +++++++-
 git-p4.py                | 41 ++++++++++++++++++++++++++---------------
 t/t9807-git-p4-submit.sh | 24 ++++++++++++++----------
 3 files changed, 47 insertions(+), 26 deletions(-)

-- 
2.15.0.276.g89ea799.dirty

