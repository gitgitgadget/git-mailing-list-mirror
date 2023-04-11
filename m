Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0A4C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDKUDp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 11 Apr 2023 16:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKUDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 16:03:44 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 13:03:39 PDT
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C0F46A5
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 13:03:39 -0700 (PDT)
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
        by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4PwxPN1Tzdz3tbq
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 21:54:16 +0200 (CEST)
Authentication-Results: mors-relay-8201.netcup.net; dkim=permerror (bad message/signature format)
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4PwxPN0nBwz3tbb
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 21:54:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy02-mors.netcup.net
Received: from mx2ee7.netcup.net (unknown [10.243.12.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by policy02-mors.netcup.net (Postfix) with ESMTPS id 4PwxPM3tm3z8svV
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 21:54:15 +0200 (CEST)
Received: from smtpclient.apple (unknown [45.153.183.212])
        by mx2ee7.netcup.net (Postfix) with ESMTPSA id E03531A0074
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 21:54:10 +0200 (CEST)
Authentication-Results: mx2ee7;
        spf=pass (sender IP is 45.153.183.212) smtp.mailfrom=jonas@lophus.org smtp.helo=smtpclient.apple
Received-SPF: pass (mx2ee7: connection is authenticated)
From:   Jonas Haag <jonas@lophus.org>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Infinite loop + memory leak in annotate_refs_with_symref_info
Message-Id: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
Date:   Tue, 11 Apr 2023 22:53:59 +0300
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-PPP-Message-ID: <168124285127.27024.18266503911800580311@mx2ee7.netcup.net>
X-Rspamd-Queue-Id: E03531A0074
X-Spamd-Result: default: False [-5.10 / 15.00];
        BAYES_HAM(-5.50)[99.99%];
        MV_CASE(0.50)[];
        MIME_GOOD(-0.10)[text/plain];
        FROM_EQ_ENVFROM(0.00)[];
        MIME_TRACE(0.00)[0:+];
        ASN(0.00)[asn:208149, ipnet:45.153.182.0/23, country:GR];
        RCVD_COUNT_ZERO(0.00)[0];
        RCPT_COUNT_ONE(0.00)[1];
        TO_DN_NONE(0.00)[];
        MID_RHS_MATCH_FROM(0.00)[];
        FROM_HAS_DN(0.00)[];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        ARC_NA(0.00)[]
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: XwC1RsLpiTSo9z2CbTaU64NXHDKA31iKF+zYXwGCKIQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

There is an infinite loop with an accompanying memory leak in annotate_refs_with_symref_info that was introduced in Git 2.28 (I think in commit 2c6a403: “connect: add function to parse multiple v1 capability values”).

To reproduce the issue, start Klaus [1] using the --smarthttp option and attempt to clone a repository. git-remote-http will enter an infinite loop.

I think this is triggered by a bug in Dulwich, the Python Git implementation that Klaus uses. I’m assuming that Dulwich sends some invalid responses that make the Git client go into an infinite loop.

I believe the bug in Git is in connect.c, function parse_feature_value, in the updating of `*offset`: It doesn’t seem to take into account that `feature_list` has already been offset by `*offset`. I believe the update needs to use `*offset +=` instead of `*offset =`. When I make this change, the infinite loop seems to go away, and cloning via Klaus/Dulwich will fail with “invalid index-pack output”. Cloning from github.com works, although I’m not sure if that’s a relevant smoke test in this case.

Jonas

[1] https://github.com/jonashaag/klaus
