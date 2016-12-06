Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E171FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbcLFVxP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:15 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33979 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbcLFVxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:12 -0500
Received: by mail-pg0-f43.google.com with SMTP id x23so153558415pgx.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=E5c6GibXPMmu0OEh82SQJ3kQ2mpeo7L7b9XnfOv0XwQ=;
        b=nQD8CcIVJpIxBeuWC4qjuY1XMp8Y+cG7yNQFwpsabqw8RD7ulFm4ROI5kX8eTyqX4R
         fpJqHCATzGTjgc4AobxRHTP6fP6bvxBNk3KFg7wf1C/MMi1N3ZPzOWvfgP6vOJIzwlYn
         8ISd3YvwuyLq57vqzvmOmVuUjsfxA0K5O1vRKtcgkWJdXNvxUszqfSOJWe4X8Teu0rl1
         rh9BknnEuePAZZfpfGTa0rMrh4Lxnt35lkTKP8B+MzncCbFERdGWxV2phWWV9tFcqE1l
         20inx66vCib1QHfyeToF+BcLsHDmgPld80DMUoJkHFJV2aQVLV0Z/eCGslFlXlZlEF2S
         paVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E5c6GibXPMmu0OEh82SQJ3kQ2mpeo7L7b9XnfOv0XwQ=;
        b=d/UbVlIKjzcrHAJyixJQqSyy1UgNIceSuZvDoljGDXd+E24E7BM0IZLvnPgPzouY2S
         8KeR23ORwgdpxzelP2Y023U6kx6mAO6kn0T/oAinNWaUTx+kC2Sxng08psF8vqU4msIS
         4CrcTU6+uoEsiGQwbIlx7KkcSsOZ3kBPi69UnPnh3aBEEF1XyMcyN7qePq/jmHtFs91u
         xybWUrHAndhu1hiOCjw084vi4b8WwnrkcEiu1wS0Dak53IjrPcDa68xpcJZ1SJXB+X5d
         5O6ukF7WciCMLZn5Tr/m5D3uPRetz1taSmdZhK1zdOHRUJHC8CYh4SLi6QXkavUcSaDp
         r/4Q==
X-Gm-Message-State: AKaTC02kpDV1eRiOhbevMdY9h4n/7C20A2OZOpXslk20K9+7f89YiVrZFS5mEzVAkc0+pcUv
X-Received: by 10.98.141.153 with SMTP id p25mr64352490pfk.148.1481061137401;
        Tue, 06 Dec 2016 13:52:17 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:16 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 00/17] pathspec cleanup
Date:   Tue,  6 Dec 2016 13:51:29 -0800
Message-Id: <1481061106-117775-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The intent of this series is to cleanup some of the pathspec initialization
code as well as finally migrating the remaining users of the _raw field or
get_pathspec() to the pathspec struct interface.  This way both the _raw field
and get_pathspec() can be removed from the codebase.  This also removes the
functionality where parse_pathspec() modified the const char * argv array that
was passed in (which felt kind of odd to me as I wouldn't have expected the
passed in array to be modified).

I also noticed that there are memory leaks associated with the 'original' and
'match' strings.  To fix this the pathspec struct needed to take ownership of
the memory for these fields so that they can be cleaned up when clearing the
pathspec struct.

Most of the work went to simplifying the prefix_pathspec function.  This
consisted of factoring out long sections of code into their own helper
functions.  The overall result is a much more readable function.

Brandon Williams (17):
  mv: convert to using pathspec struct interface
  dir: convert create_simplify to use the pathspec struct interface
  dir: convert fill_directory to use the pathspec struct interface
  ls-tree: convert show_recursive to use the pathspec struct interface
  pathspec: remove the deprecated get_pathspec function
  pathspec: copy and free owned memory
  mv: small code cleanup
  pathspec: remove unused variable from unsupported_magic
  pathspec: always show mnemonic and name in unsupported_magic
  pathspec: simpler logic to prefix original pathspec elements
  pathspec: factor global magic into its own function
  pathspec: create parse_short_magic function
  pathspec: create parse_long_magic function
  pathspec: create parse_element_magic helper
  pathspec: create strip submodule slash helpers
  pathspec: small readability changes
  pathspec: remove outdated comment

 Documentation/technical/api-setup.txt |   2 -
 builtin/ls-tree.c                     |  12 +-
 builtin/mv.c                          |  44 +++-
 cache.h                               |   1 -
 dir.c                                 |  28 +--
 pathspec.c                            | 449 +++++++++++++++++++---------------
 pathspec.h                            |   5 +-
 7 files changed, 301 insertions(+), 240 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

