Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D2EC5ACC4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6EA24656
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 02:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lfrlpH/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBTCYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:24:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36858 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727291AbgBTCYg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Feb 2020 21:24:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A666360791;
        Thu, 20 Feb 2020 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582165475;
        bh=eeAyQBlLtROXUytGDIYnYZ4cJVGDFOrtueW24/uameA=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lfrlpH/pW3s3sVJ0hKn3rW3sDpT80+OIt5l/qX77/ajHFV+vn9kh19yYuYLizQyBd
         O7nSUKsra5ncoi0s4QYsn3j8v/GRCpakOeOAdk7VY9WPMrDjvpVpo9qTtUriGOrixu
         8cbDQB7acgz5JjWZWM9X6jbN+D0cXyOWVJKUlJYJS5C9JCD9HsdACi7lLbrviji7B1
         cYxgCnDK1rtdgVwqd0d6niSZ8r2kv2tm8DJmkYIedAMON6xMB5HIDU5N243L6DjAQK
         q5eB2neWpPqzYtnovAfEushK/sG7XyezyFmhOJ7FEP5KfEzhcNVB88oo/x87ViS1d5
         otU6zmyN0ucGPn9xfcoHUxDHvXEz2FyX8LCXdrQ5vaPH1WaUGzvNoLddBAFWbuWKvd
         7qBDRr4CkV5sZBu3S6BD0/TtKhJeCyHzP26NGqRtNzyZYTURbp3s81MPKAjiO+m3hM
         VGJMFB8t+n/Zc0Ieujc3RcltVgbiAVy92SjgJLOacBJ2nVjaWH8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 0/5] Wildcard matching for credentials
Date:   Thu, 20 Feb 2020 02:24:08 +0000
Message-Id: <20200220022413.258026-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces wildcard matching (that is, urlmatch support) for
credential config options, just like for the http options.  This is
helpful in corporate environments where custom credentials should be
used across a wide variety of subdomains.

Changes from v1:
* Add a variety of additional tests in patch 3.
* Switch to using the last matching config option for
  credential.username like we do everywhere else.
* Use all matching config keys, as we did before.
* Skip calling git_default_config.
* Fix percent-encoding handling and add a function to handle that.

brian m. carlson (5):
  mailmap: add an additional email address for brian m. carlson
  t1300: add test for urlmatch with multiple wildcards
  t0300: add tests for some additional cases
  credential: use the last matching username in the config
  credential: allow wildcard patterns when matching config

 .mailmap                         |   1 +
 Documentation/gitcredentials.txt |   4 +-
 credential.c                     |  75 +++++++++++++-----
 credential.h                     |   3 +-
 strbuf.c                         |  15 ++++
 strbuf.h                         |   6 ++
 t/t0300-credentials.sh           | 128 +++++++++++++++++++++++++++++++
 t/t1300-config.sh                |   6 ++
 urlmatch.c                       |   4 +-
 urlmatch.h                       |   9 +++
 10 files changed, 228 insertions(+), 23 deletions(-)

