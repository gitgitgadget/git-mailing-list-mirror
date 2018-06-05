Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B2A21F403
	for <e@80x24.org>; Tue,  5 Jun 2018 09:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeFEJN6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 05:13:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41400 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeFEJN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 05:13:57 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so1540307wrq.8
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e3N9AEvP40xduSR36/UNmXrXgLOU9J1tLKowr4Bf508=;
        b=eWqVpObXeSCgKP6wIH6wg5UQS8FAMLypaUmRd2YHvRFrfwbwc3wCrtzT7qE4Y8iioi
         o68IymocYoaLpm0Ex5UbcW8mAKLl3jsQFrqDSxDyYUKabUvJohg8h3iQAIugl3w0SiVU
         c1p5roUHSYlEV9KdFVuxqE/8DE647brdWU+mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e3N9AEvP40xduSR36/UNmXrXgLOU9J1tLKowr4Bf508=;
        b=t6J71qbT1RG/4EVeAVjLUqr5G1AQ6vvc/ngLhtuz7cD6kh9+Z0SZNoJoQwN1IhYrUM
         0bLfgtJNpyP1BJ9aPYf64pfMBorWRvY+ZFQmBnbx0bOGay4BkS2Q1P5UyZ+zXrxTgcnn
         FO8BOrEa5XLPX2CNHkdScdaSzO2WZogeLW4DLOKGnFx54OCT62kSkxHnPqfAYxPX9YTl
         3RrDuU04megtV7RlGAdA4zSapT/Es7xjz+ziCReSTdACoCKwG8FCDCpQkaL1reD0oSF0
         jSzrOTCDGlVkhvrMXVggQD1xSO+rdJeWrwI2AHjM/EBSnxJ+EIhSnPutdH8QbB3D/Y0a
         lOKw==
X-Gm-Message-State: ALKqPwf7ma3YLKaO9YoL+zGedjhFBUSjFyuuKZk/f/RbytmFAOsQKZwr
        2HyBynoAwNnXYa7sfK3MEvGYtxAtAMY=
X-Google-Smtp-Source: ADUXVKJ6sFw9neUSmiJf6QsJEftagh8A9GE6fmIeDrOq+j9810iT5TMl6aLX/9nfNYDa/VTBMDIvrw==
X-Received: by 2002:adf:e152:: with SMTP id f18-v6mr17592065wri.42.1528190036477;
        Tue, 05 Jun 2018 02:13:56 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id i46-v6sm42018545wra.36.2018.06.05.02.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 02:13:55 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/3] git-p4: improvements to p4 "blocking"
Date:   Tue,  5 Jun 2018 10:13:47 +0100
Message-Id: <20180605091350.14476-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset improves the way that git-p4 sends requests in "blocks".

The problem comes about because the Perforce server limits the maximum
number of results it will send back (there are actually two different
limits).

This causes git-p4 failures if you ask for too much data.

In commit 96b2d54aee ("git-p4: use -m when running p4 changes",
2015-04-20), git-p4 learned to make requests in blocks, by default 512
in size.

The problem with this, however, is that it can be very slow on large
repositories - you might have millions of commits, although only a
handful actually relate to the code you are trying to clone. Each 512
block request takes a sizeable fraction of a second to complete.

There's a command-line option to increase the block size, but unless you
know about it, it won't be at all obvious that you could use this to
speed things up.

This change
~~~~~~~~~~~

The function p4CmdList() has been taught to raise an exception when it
gets an error, and in particular, to notice and report the two "too many
results" errors.

The code that does the blocking can now start out with a nice large
block size, and then reduce it if it sees an error.

Luke Diamand (3):
  git-p4: raise exceptions from p4CmdList based on error from p4 server
  git-p4: narrow the scope of exceptions caught when parsing an int
  git-p4: auto-size the block

 git-p4.py               | 72 +++++++++++++++++++++++++++++++++++------
 t/t9818-git-p4-block.sh | 11 +++++++
 2 files changed, 73 insertions(+), 10 deletions(-)

-- 
2.17.0.392.gdeb1a6e9b7

