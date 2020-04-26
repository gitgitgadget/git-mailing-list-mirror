Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F6C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 19:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CA12075B
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 19:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="uovCOYFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgDZTWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 15:22:04 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.100]:32964 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgDZTWE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Apr 2020 15:22:04 -0400
X-Greylist: delayed 1207 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2020 15:22:03 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id CC98E5AAB
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 14:01:55 -0500 (CDT)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with SMTP
        id SmXLjrBCIEfyqSmXLjhRth; Sun, 26 Apr 2020 14:01:55 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:To:Reply-To:From:Subject:Message-ID:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QuFI/Jzrhq9ypYdCmvlcaoz3A8pqafbDurOTlfM8daA=; b=uovCOYFZbeWCT4jINqTZNIY6rh
        1LAdjsRn5LdDoxEL4s55y2HvVWSBJQtOdQUZvYKHObrSnWrnZ9qcFULc3OE7LW49Ty79A5VORv6+3
        d8a+Fi6Ykgq+UTQlZuzTlnqnJ;
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:49074 helo=pdslaptop.home)
        by box5922.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@mad-scientist.net>)
        id 1jSmXL-002Rq3-IP
        for git@vger.kernel.org; Sun, 26 Apr 2020 13:01:55 -0600
Message-ID: <9d9fe8376e47a9f5330cd644c76d96987fc67c57.camel@mad-scientist.net>
Subject: Git configure with static curl is failing
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Git List <git@vger.kernel.org>
Date:   Sun, 26 Apr 2020 15:01:54 -0400
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 98.118.0.140
X-Source-L: No
X-Exim-ID: 1jSmXL-002Rq3-IP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-98-118-0-140.bstnma.fios.verizon.net (pdslaptop.home) [98.118.0.140]:49074
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all;

I'm trying to build Git with my own static curl, not the system curl,
and this isn't working due to an issue in configure.ac's curl locating
code.

I invoke configure with --with-curl=/other/curl where
/other/curl/include/curl and /other/curl/lib/libcurl.a and
/other/curl/bin/curl-config all exist and work correctly.

When configure.ac attempts to local curl, it fails; config.log shows:

  configure:5387: my-gcc -o conftest -O2 \
   -I/other/curl/include -L/other/curl/lib conftest.c -lcurl >&5
  /other/curl/lib/libcurl.a(libcurl_la-content_encoding.o):content_encoding.c:function gzip_init_writer: error: undefined reference to 'zlibVersion'

and many other errors, because the link line is missing needed
libraries.  If curl as a .so this wouldn't matter since libcurl.so
would contain references to the libraries it needs and ld.so would
handle this, but a static library obviously doesn't have that.

The problem appears to be that configure.ac is not using curl-config to
obtain the correct options to link with curl.  If I run
/other/curl/bin/curl-config --lib I get the proper flags:

  $ /other/curl/bin/curl-config --libs
  -L/other/curl/lib -lcurl -lssl -lz -lcrypto -ldl -lpthread

If configure.ac tried to use $CURLDIR/bin/curl-config --libs to obtain
the right linker options, then the link test for curl would work.

