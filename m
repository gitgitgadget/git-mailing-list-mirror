Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F25281F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 02:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753660AbeGFCYM (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 22:24:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52408 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753560AbeGFCYL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2018 22:24:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B302360102;
        Fri,  6 Jul 2018 02:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530843849;
        bh=888afzV3z4ue2kCXu4Xdhs6Daemvr3d6knTxaZLkI3I=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WrW9C4JoItcKg1OiIYXxfYcRRVOO3ugec9rbitHjGDibL6XTptjCtzLSXLAN/TOBe
         crLANUwqqOzSv++JlxUR6IUonIlmjvq6U93wi/2rIlmTTOxL04ueDYPIVDXjGfSkiY
         6Wa0Mtp8Wu3uXZTSmf9dv0wJC/VNbdzyOb2kzgpJXrKhzkElRtzYi8XK5+bKzBAWEG
         /lqPwwiN+BR2UIJB4bwBAKjQDlBQMQvE8PP42q5vlOSvx7ICC0oMK3B/UpndcQ10yr
         txPbJKpzAm1GbL+j26ieP1KqvMUW5DduJu/Khqt5ULdXUMv6tphCkBPCEeGWbAszIv
         5v9j0KBWBoVY5xKDe0vVs/+A/kZJlFZJ49aDynrwldatMankvoPN5zYctxya+OvK/r
         nn6vQWpxOwD06WY1/nmJx5o0FIWv6epYhIOF0t6LrhRLYgwkZqnnNt0Lu19LL92Rxw
         t0vNJ7UMPnp9adMwl/iG5UQ777gGy96vTVH7QuvgV+iS80FKnLe
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>
Subject: [PATCH 0/3] Automatic transfer encoding for patches
Date:   Fri,  6 Jul 2018 02:23:54 +0000
Message-Id: <20180706022357.739657-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.132.g7d961b6d40
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git send-email has the --validate option, which is the default, to check
if a patch has lines longer than RFC 5321 allows (998 octets).  However,
it doesn't take into account the fact that using certain transfer
encodings makes this issue moot, and it also doesn't provide any helpful
clue to the user about what to do when this fails.

This series introduces an "auto" value for --transfer-encoding that uses
8bit when possible (i.e. when lines are 998 octets or shorter) and
quoted-printable otherwise; it then makes this the default behavior.  It
also makes --validate aware of transfer encoding so it doesn't complain
when using quoted-printable or base64.

git am already understands how to handle patches in any valid transfer
encoding.

As a result of this series, we always produce MIME messages with a
Content-Transfer-Encoding header.  I don't think this will cause any
problems, but if someone knows of a reason why it would, please shout
loudly.

brian m. carlson (3):
  send-email: add an auto option for transfer encoding
  send-email: accept long lines with suitable transfer encoding
  send-email: automatically determine transfer-encoding

 Documentation/git-send-email.txt | 15 +++++----
 git-send-email.perl              | 36 ++++++++++----------
 t/t9001-send-email.sh            | 58 ++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 24 deletions(-)

