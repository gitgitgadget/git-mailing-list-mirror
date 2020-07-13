Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD22CC433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914A0206F5
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ma7ZI7b4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGMTsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:48:55 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:48139 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMTsz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594669735; x=1626205735;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=WtmxGczbUCrTP5gADH8fUSjctlwJWWAJz7C4cv5hVzY=;
  b=Ma7ZI7b45ZjveXzTJxOkwOyL1B9vc0sXtTCg6ZWngsnpNiJjDf2q3M0J
   R/YVJjsZ/g73PhJhmBgwhyfw7WCOcQINZDTzc7nws7CLH68ij0qN1/O1t
   w2iSumnvXnghhuy1wnb51Gf94483ne75MAAb0mhVkG5uycjB3zy3DrN4y
   A=;
IronPort-SDR: /RRfw6nYcyJo+GxMvK0MRMDPAFLi1dmJLtM3yDQc0V8QCYOVCi8b+29xgf3AWZo5rcY3DslxZ8
 ySLkqm4+Qugg==
X-IronPort-AV: E=Sophos;i="5.75,348,1589241600"; 
   d="scan'208";a="41647269"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 13 Jul 2020 19:48:53 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id D2F23A1C54
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 19:48:52 +0000 (UTC)
Received: from EX13D10UWA003.ant.amazon.com (10.43.160.248) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 19:48:50 +0000
Received: from EX13D10UWA004.ant.amazon.com (10.43.160.64) by
 EX13D10UWA003.ant.amazon.com (10.43.160.248) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 19:48:50 +0000
Received: from EX13D10UWA004.ant.amazon.com ([10.43.160.64]) by
 EX13D10UWA004.ant.amazon.com ([10.43.160.64]) with mapi id 15.00.1497.006;
 Mon, 13 Jul 2020 19:48:50 +0000
From:   "Peterson, Alex" <alexpete@amazon.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Temporary credentials timeout during long operations
Thread-Topic: Temporary credentials timeout during long operations
Thread-Index: AdZZS2dK0GgPJ4/xQ12KUmHdKoU5yg==
Date:   Mon, 13 Jul 2020 19:48:50 +0000
Message-ID: <18381efb749d43d097665960021a76ef@EX13D10UWA004.ant.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.203]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,  recently I've run into an issue where long push operations fail=
 when using a credential helper like the AWS CodeCommit helper because it p=
rovides time-limited credentials which expire during the operation.  Is the=
re an existing method to enforce refreshing credentials from a credential h=
elper on the client or should I go down the path of creating a credential.t=
imeout feature that automatically refills credentials from helpers during l=
ong operations to avoid this issue?

Steps to reproduce:
1. Create a repository with LFS
2. Add a large file that will take a long time to push (long enough for the=
 credentials to expire)
3. Enable a helper that provides temporary credentials=20
4. Set a remote that uses HTTPS and git push

All initial HTTPS commands authenticate OK and the LFS file uploads fine bu=
t by the time it is done, the credentials have expired so the final git-rec=
eive-pack fails and the entire push operation fails.

> POST /v1/repos/example/git-receive-pack HTTP/1.1
< HTTP/1.1 403=20
error: RPC failed; HTTP 403 curl 22 The requested URL returned error: 403=20
fatal: the remote end hung up unexpectedly=20

For testing purposes I modified post_rpc() so that it always requests new c=
redentials before every HTTPS request, and was able to push any number of l=
arge files.

SSH works fine (with keepalives enabled) and so does HTTPS with a permanent=
 username/password, it's just the credential helpers that provide time-limi=
ted credentials.

Thoughts?
