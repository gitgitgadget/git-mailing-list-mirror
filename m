Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147A020229
	for <e@80x24.org>; Tue,  1 Nov 2016 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbcKAWNj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 18:13:39 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:59932 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbcKAWNV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 18:13:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 42360100067
        for <git@vger.kernel.org>; Tue,  1 Nov 2016 22:13:19 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9NImGWNXcXXb for <git@vger.kernel.org>;
        Tue,  1 Nov 2016 22:13:19 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 300CF80035
        for <git@vger.kernel.org>; Tue,  1 Nov 2016 22:13:19 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Tue, 1 Nov 2016 22:13:18 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Tue, 1 Nov 2016 22:13:18 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Submodules: two confusing situations
Thread-Topic: Submodules: two confusing situations
Thread-Index: AdI0jRRfp68lFX9gS7ekJMOp0evpQQ==
Date:   Tue, 1 Nov 2016 22:13:18 +0000
Message-ID: <6533af94ebd74952b75e51c5609d8c20@exmbdft7.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.15]
Content-Type: multipart/mixed;
        boundary="_002_6533af94ebd74952b75e51c5609d8c20exmbdft7adtwosigmacom_"
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_002_6533af94ebd74952b75e51c5609d8c20exmbdft7adtwosigmacom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Consider the following two cases:

We have commit X and commit Y.  X is an ancestor of Y.

We're at X and doing get checkout Y -- or we're at Y and we're doing
git checkout X.

Case 1: Between X and Y, we have deleted a submodule.
In order to move from X to Y, git removes the submodule
from the working tree.

Case 2: Between X and Y, we have instead added a submodule.  In order
to move from Y to X (that is, the opposite direction), git *does not*
remove the submodule from the tree; instead, it gives a warning and
leaves the submodule behind.

I don't understand why these two cases are not symmetric.

--=20

Perhaps relatedly, consider the attached shell-script, which I have not yet=
 made into a full git test because I'm not sure I understand the issues ful=
ly.

It creates three commits:

Commit 1 adds a submodule
Commit 2 removes that submodule and re-adds it into a subdirectory (sub1 to=
 sub1/sub1).
Commit 3 adds an unrelated file.

Then it checks out commit 1 (first deinitializing the submodule to avoid ca=
se 2 above), and attempts to cherry-pick commit 3.  This seems like it ough=
t to work, based on my understanding of cherry-pick.  But in fact it gives =
a conflict on the stuff from commit 2 (which is unrelated to commit 3).

This is confusing to me, and looks like a bug.  What am I missing?


--_002_6533af94ebd74952b75e51c5609d8c20exmbdft7adtwosigmacom_
Content-Type: application/octet-stream; name="submodule-merge.sh"
Content-Description: submodule-merge.sh
Content-Disposition: attachment; filename="submodule-merge.sh"; size=1021;
	creation-date="Tue, 01 Nov 2016 22:04:21 GMT";
	modification-date="Tue, 01 Nov 2016 22:04:21 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gNCnNldCAtZXVvIHBpcGVmYWlsDQoNCm1rZGlyIGRlbW8NCmNkIGRlbW8NCg0K
Z2l0IGluaXQgbWFpbg0KDQooDQogICAgZ2l0IGluaXQgc3ViMSAmJg0KICAgIGNkIHN1YjEgJiYN
CiAgICBkZCBpZj0vZGV2L3VyYW5kb20gb2Y9ZiBicz00MCBjb3VudD0xICYmDQogICAgZ2l0IGFk
ZCBmICYmDQogICAgZ2l0IGNvbW1pdCAtbSBmDQopDQoNCigNCiAgICBjZCBtYWluICYmDQogICAg
Z2l0IHN1Ym1vZHVsZSBhZGQgLi4vc3ViMSBzdWIxICYmDQogICAgPiBzdWIyICYmIGdpdCBhZGQg
c3ViMiAmJg0KICAgIGdpdCBjb21taXQgLW0gJ2FkZCBib3RoIHN1Ym1vZHVsZXMnICYmDQogICAg
Z2l0IHRhZyBzdGFydA0KKQ0KDQojbWFrZSBhIGNvbW1pdCB0aGF0IHJlcGxhY2VzIHN1YjEgaW4g
YSBsLT5kIHRyYW5zaXRpb24NCigNCiAgICBjZCBtYWluICYmDQogICAgZ2l0IHJtIHN1YjEgJiYN
CiAgICBta2RpciBzdWIxICYmDQogICAgZ2l0IHN1Ym1vZHVsZSBhZGQgLi4vc3ViMSBzdWIxL3N1
YjEgJiYNCiAgICBnaXQgY29tbWl0IC1tICdmIHRvIGQnICYmDQoNCiAgICAjQW5kIGFub3RoZXIg
Y29tbWl0IHRoYXQganVzdCBhZGRzIGEgcmFuZG9tIGZpbGUuDQogICAgPmZvbyAmJg0KICAgIGdp
dCBhZGQgZm9vICYmDQogICAgZ2l0IGNvbW1pdCAtbSAnZm9vJyAmJg0KDQogICAgZ2l0IHRhZyBs
LXRvLWQNCg0KICAgICMgTm93IHdlIHdhbnQgdG8gZ2V0IGJhY2sgdG8gdGhlIHN0YXJ0IHN0YXRl
DQogICAgZ2l0IHN1Ym1vZHVsZSBkZWluaXQgc3ViMS9zdWIxICYmDQogICAgZ2l0IGNoZWNrb3V0
IC1iIHN1YjIgc3RhcnQgJiYNCiAgICAjIEZpbmFsbHksIHdlIHdhbnQgdG8gY2hlcnJ5LXBpY2sg
YW4gaW5ub2N1b3VzLWxvb2tpbmcgY29tbWl0IGZyb20gYSBicmFuY2gNCiAgICAjIHdoZXJlIHdl
IGhhdmUgcHJldmlvdXNseSBtYWRlIHRoZSBsLT5kIGNoYW5nZQ0KICAgICMgVGhpcyBzaG91bGQg
bm90IGZhaWwsIGJ1dCBkb2VzLg0KICAgIGdpdCBjaGVycnktcGljayBsLXRvLWQNCikNCg==

--_002_6533af94ebd74952b75e51c5609d8c20exmbdft7adtwosigmacom_--
