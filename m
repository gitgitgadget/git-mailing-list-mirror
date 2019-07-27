Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5106F1F462
	for <e@80x24.org>; Sat, 27 Jul 2019 17:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfG0ROD (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 13:14:03 -0400
Received: from lovelace.chead.ca ([162.223.226.168]:43568 "EHLO
        lovelace.chead.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387665AbfG0ROC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 13:14:02 -0400
X-Greylist: delayed 1155 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Jul 2019 13:14:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=chead.ca;
         s=lovelace20151122; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:
        Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OftBB0lTXgcrlBzThbC1/ViKzUzwr56OEXr4YNYFR8g=; b=ZyeFGmAG0LY77+gNKf1DHd2yiY
        jsTvBxrDKCyvmmnxa4jFHtESDJdYY8VBziEkXJgd7T6K94rGKFPFZBysq+dgtLB1ABxQcqrckehrE
        FSwGo4HF2bY2t4C3S6h4N6vhVxk+3mvY0DuPowXUrpEW8eUMD8j34CZVrj3Amo8Y95iE=;
Received: from [192.252.232.184] (helo=amdahl.home.chead.ca)
        by lovelace.chead.ca with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <bugs@chead.ca>)
        id 1hrPxz-0003oH-8N
        for git@vger.kernel.org; Sat, 27 Jul 2019 09:54:43 -0700
Date:   Sat, 27 Jul 2019 09:54:40 -0700
From:   Christopher Head <bugs@chead.ca>
To:     git@vger.kernel.org
Subject: Push force-with-lease with multi-URL remote
Message-ID: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/MmcJtnahYmKduTkLsCEB/Hh"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--MP_/MmcJtnahYmKduTkLsCEB/Hh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi folks,
When a single remote has multiple push URLs, Git’s force-with-lease
logic appears to be:

For each URL:
1. Read refs/heads/mybranch (call this commit X)
2. Read refs/remotes/myremote/mybranch (call this commit Y)
3. Send to the URL an atomic compare-and-swap, replacing Y with X.
4. If step 3 succeeded, change refs/remotes/myremote/mybranch to X.

This means that, assuming both URLs start out identical, the second URL
will always fail because refs/remots/myremote/mybranch has been updated
from Y to X, and therefore the second compare-and-swap fails. I can’t
imagine any situation in which this behaviour is actually useful.

This is what I would expect:

1. Read refs/heads/mybranch (call this commit X)
2. Read refs/remotes/myremote/mybranch (call this commit Y)
3. For each URL:
3a. Send to the URL an atomic compare-and-swap, replacing Y with X.
4. If any (or maybe all) of the CAS operations in 3a succeeded, change
refs/remotes/myremote/mybranch to X.

Thoughts? Does anyone have a use case for the existing behaviour? I
have attached a shell script which constructs some repos and
demonstrates the situation.

Thanks!
-- 
Christopher Head

--MP_/MmcJtnahYmKduTkLsCEB/Hh
Content-Type: application/octet-stream; name=test
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=test

IyEvYmluL2Jhc2gKCnNldCAtZQoKIyBDcmVhdGUgcmVtb3RlMSwgcmVtb3RlMiwgbG9jYWwuCmdp
dCBpbml0IC0tYmFyZSByZW1vdGUxCmdpdCBpbml0IC0tYmFyZSByZW1vdGUyCmdpdCBpbml0IGxv
Y2FsCmNkIGxvY2FsCmdpdCByZW1vdGUgYWRkIG9yaWdpbiAuLi9yZW1vdGUxCmdpdCByZW1vdGUg
c2V0LXVybCAtLXB1c2ggb3JpZ2luIC4uL3JlbW90ZTEKZ2l0IHJlbW90ZSBzZXQtdXJsIC0tcHVz
aCAtLWFkZCBvcmlnaW4gLi4vcmVtb3RlMgoKIyBBZGQgY29tbWl0IEEgYW5kIHB1c2guCmVjaG8g
J2hlbGxvIHdvcmxkJyA+IHRlc3QudHh0CmdpdCBhZGQgdGVzdC50eHQKZ2l0IGNvbW1pdCAtbSAn
Q29tbWl0IEEnCmdpdCBwdXNoIC11IG9yaWdpbiBtYXN0ZXIKCiMgQW1lbmQgdG8gY29tbWl0IEIu
CmVjaG8gJ2dvb2RieWUgd29ybGQnID4gdGVzdC50eHQKZ2l0IGFkZCB0ZXN0LnR4dApnaXQgY29t
bWl0IC0tYW1lbmQgLS1uby1lZGl0CgojIEZvcmNlLXB1c2guCmdpdCBwdXNoIC0tZm9yY2Utd2l0
aC1sZWFzZQo=

--MP_/MmcJtnahYmKduTkLsCEB/Hh--
