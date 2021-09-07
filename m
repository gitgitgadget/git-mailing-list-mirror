Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE406C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11B860ED8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbhIGSOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:14:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:40832 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245148AbhIGSOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 14:14:00 -0400
Received: (qmail 19907 invoked by uid 109); 7 Sep 2021 18:12:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Sep 2021 18:12:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16311 invoked by uid 111); 7 Sep 2021 18:12:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Sep 2021 14:12:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Sep 2021 14:12:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: expired key in junio-gpg-pub
Message-ID: <YTerpXCxYx+f+8ws@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like your signing key is expired, and tag verification fails:

  $ mkdir /tmp/foo
  $ export GNUPGHOME=/tmp/foo
  $ git cat-file blob junio-gpg-pub | gpg --import
  gpg: WARNING: unsafe permissions on homedir '/tmp/foo'
  gpg: keybox '/tmp/foo/pubring.kbx' created
  gpg: key 20D04E5A713660A7: 27 signatures not checked due to missing keys
  gpg: /tmp/foo/trustdb.gpg: trustdb created
  gpg: key 20D04E5A713660A7: public key "Junio C Hamano <gitster@pobox.com>" imported
  gpg: Total number processed: 1
  gpg:               imported: 1
  gpg: no ultimately trusted keys found

  $ git tag -v v2.33.0
  object 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
  type commit
  tag v2.33.0
  tagger Junio C Hamano <gitster@pobox.com> 1629141357 -0700

  Git 2.33
  gpg: WARNING: unsafe permissions on homedir '/tmp/foo'
  gpg: Signature made Mon Aug 16 15:15:57 2021 EDT
  gpg:                using RSA key E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB
  gpg: Good signature from "Junio C Hamano <gitster@pobox.com>" [unknown]
  gpg:                 aka "Junio C Hamano <junio@pobox.com>" [unknown]
  gpg:                 aka "Junio C Hamano <jch@google.com>" [unknown]
  gpg: Note: This key has expired!
  Primary key fingerprint: 96E0 7AF2 5771 9559 80DA  D100 20D0 4E5A 7136 60A7
       Subkey fingerprint: E1F0 36B1 FEE7 221F C778  ECEF B0B5 E886 96AF E6CB

  $ echo $?
  1

Have you extended the expiration on it? I wasn't able to find any
updates on the keyservers I checked. But regardless, we should probably
ship an updated one via the tag.

-Peff
