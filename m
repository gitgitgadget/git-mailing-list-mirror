Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70CF20248
	for <e@80x24.org>; Mon,  4 Mar 2019 17:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCDReq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 12:34:46 -0500
Received: from mail-eopbgr760120.outbound.protection.outlook.com ([40.107.76.120]:18492
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfCDReq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 12:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fApAHcZQMtYa/QSLAHsE4NtFBjm4hfFqSIphn1aIuO0=;
 b=EY37a5Ps5GotVlV8UKQItdKBWfo8Vzn9vIl15PlMpKYq1f+tceYCPkR/ap1n4lXKLh2Mrhg3T8EyihFx7vwqofZ3XO4FleQJtjhzS7wSa1TzvpF1ldAICc1OIeg5xgjrdZrdKAg7M90yx4SezEwOdNjdpw1rtJztWNAEdUbN8Vw=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4377.namprd08.prod.outlook.com (20.176.82.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 17:34:42 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 17:34:42 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH 1/5] git-p4: detect/prevent infinite loop in
 gitCommitByP4Change()
Thread-Topic: [PATCH 1/5] git-p4: detect/prevent infinite loop in
 gitCommitByP4Change()
Thread-Index: AQHU0rCMKg9+jkG4JkOzdp3MsikA5Q==
Date:   Mon, 4 Mar 2019 17:34:42 +0000
Message-ID: <3ac39171d441b84a20d5e918a9995e8d8de627c5.1551485349.git.amazo@checkvideo.com>
References: <cover.1551485349.git.amazo@checkvideo.com>
In-Reply-To: <cover.1551485349.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:404:13e::32) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8557468a-4eaa-42c3-1448-08d6a0c7af32
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4377;
x-ms-traffictypediagnostic: DM6PR08MB4377:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR08MB4377;23:3TpuRZZJNbemQAI4UNn/OEekq6KDAW3Y7Rb4PXU?=
 =?iso-8859-1?Q?HirxD6JuC+CSkBxO0+bv1oRyoY/cBaqyMPH/UliPhtKd+YmAfCsTnk1Tn5?=
 =?iso-8859-1?Q?NqyrxhB24diGMKGGzQyA6cYuFuQW7V2qM6YkP9ha/4QVgUUMUr87/Rtyqm?=
 =?iso-8859-1?Q?CXRLwyoB+gVjcnukYy4snK4rVsp458nDOaZUfLHG+9v1G2DD91UTrkAwsd?=
 =?iso-8859-1?Q?F0HtcH94s+29UyPzK4j8hojqsBOOKDFYtzkO48uKYIvsvSEamyVbqnv+Ib?=
 =?iso-8859-1?Q?jN3tIF8HgdbO6ys07LBmJ/4qkzrmghxq/pTzPb+SRhkxLxOzHCWvd6w3wd?=
 =?iso-8859-1?Q?VlW/JJHQoqYD+gKt8M8NwwY1NVVDRRjg1d5kSaTIgIR60oQDgTtndvL3Hl?=
 =?iso-8859-1?Q?NNHtUvB8eHiezjGp4vwlEYkr1XOIUciSFG0yyowGSBq6sKztfaZHYIYzXh?=
 =?iso-8859-1?Q?qWS+nZoefjQ12smCtUbrsL6ZpKwqPsIr3HUxy6N6XV1h9q8ePuB1Pr2huM?=
 =?iso-8859-1?Q?zULipBBcTVCPz2vVU35w23nOx7EsNb41NkXBAaYo0Voq3oIRLv+3B+V+Hn?=
 =?iso-8859-1?Q?Uj5pDElnfiEbYCbogOVq9n0iJ5Nkg7U+fXjyetNbj+mqS9a6o4qBimH6k0?=
 =?iso-8859-1?Q?Rwpgs2jmxXXTW4bOU2MeiDCsHmjTfp1wT2sG2Sn2ayq05HymRkHsZpx9SI?=
 =?iso-8859-1?Q?Jh1+4N2SQsfpFzouEq000gSvGqGUrF5muNGkmYjT8rXjSkTWPFT+Qb9wOf?=
 =?iso-8859-1?Q?l2SrVuEDpFQxt0IxSYNbV0HwtYqQJeR146+3+GsnX9Cxpe9hhXrerweabu?=
 =?iso-8859-1?Q?AQlbpM51PUuQEyqbNJ4NYHpbbhJI/s8vZiqAqH2icGufb+ZKVPfx02/kFi?=
 =?iso-8859-1?Q?dYtpVTAt5WUezGw8AUKQUKTBvNrlIzZ2c2ytbDz6RHA5SgpbZDwxI8ofEa?=
 =?iso-8859-1?Q?AiVhVDB8SwyrSqYb63zHFL3xcsqkACtvINlsbGL5FdmEB42JshYLLI/2jz?=
 =?iso-8859-1?Q?8xyQmu4Dbj3tam10QfNeRL9KjHlTLZfDLcr16CTCAjrJ+ZjP6FAmC+Tm1S?=
 =?iso-8859-1?Q?FBOjMaHDaUu9REn5rykFSoM3CYc5oFT+QKFqnCvNE0wLPsxvMUnM2PJ24H?=
 =?iso-8859-1?Q?UYghFjXJvxzI/Ry9JdBir1HyV2ObWp671VflwZHRp5mm+YTTBla0fFCjjA?=
 =?iso-8859-1?Q?U060mRUlSTCQ+za8e4uhy23OHnmXORxXJ9duGpTfWFktEK4SgiqgZWw0Zb?=
 =?iso-8859-1?Q?YpDUK47GERBOme5iX3zbqN6mU/j062pcmvOJdHxaAJNJ5Q/58qQyjz2Nfk?=
 =?iso-8859-1?Q?NJ6YeL9FqzBYUKCm0qS/iwPBM9sSTw3ZG80H6j9kiXePWKMjjsL8SNFlqg?=
 =?iso-8859-1?Q?mnptsSP44J7G0w7hTF7nGNJBFAmUoqBtVNssR2sUMUCzelXdocA=3D=3D?=
x-microsoft-antispam-prvs: <DM6PR08MB43772F00A6F34C1A2CC90ED4DA710@DM6PR08MB4377.namprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(316002)(5640700003)(86362001)(3846002)(6116002)(186003)(26005)(6512007)(4326008)(6916009)(486006)(6486002)(66066001)(53936002)(6436002)(256004)(118296001)(14444005)(6506007)(52116002)(102836004)(76176011)(99286004)(386003)(2906002)(478600001)(14454004)(2351001)(2501003)(81156014)(5660300002)(81166006)(1730700003)(8676002)(68736007)(2616005)(8936002)(97736004)(50226002)(54906003)(7416002)(105586002)(106356001)(11346002)(25786009)(36756003)(305945005)(7736002)(71190400001)(71200400001)(446003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4377;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lGCMi3gYoIzT8fq5/Vyl77+l5Yd7h486atq8jGj8nWY7QS5bihdZunnLfYqJ8i+rzlGbSHkveIyCudr3KeJiSRkJmPLN3qE9px/GOGYU0B2PSQC3iROx6PMwIUqJ+MSrniNnfghhyWKvGGTCGJQCSbCT+oiE8RV50cYprlWBVdRPMqFAb5SGNolC+r9U/5yBKm34pKDSx25hOuk8sslzrc0t0hHRfeGUZWTR/Oyn9VgAkNtBPgmrMApzIgRh5dJTi6v7MPuCiJCJjhXvHiP6EUxxj8iQcXrL2APm+JQwvE3x1QVn95oAXeN9E4ZfcUXW1WdsVAeJ2JsN4O2zlTln9FzxzMka/rLMC/Qrydx0E/myHbOGMD3itp4G4cyongD5laee5ZR4ulPwmIU+oLxNxgJa0GJVPnPW5f9nFTQXpHQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8557468a-4eaa-42c3-1448-08d6a0c7af32
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 17:34:42.0226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4377
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Under certain circumstances, gitCommitByP4Change() can enter an infinite
loop resulting in `git p4 sync` hanging forever.

The problem is that
`git rev-list --bisect <latest> ^<earliest>` can return `<latest>`,
which would result in reinspecting <latest> and potentially an infinite loo=
p.

This can happen when importing just a subset of P4 repository
and/or with explicit "--changesfile" option.

A real-life example:
"""
    looking in ref refs/remotes/p4/mybranch for change 26894 using bisect..=
.
    Reading pipe: git rev-parse refs/remotes/p4/mybranch
    trying: earliest  latest 4daff81c520a82678e1ef347f2b5e97258101ae1
    Reading pipe: git rev-list --bisect 4daff81c520a82678e1ef347f2b5e972581=
01ae1
    Reading pipe: git cat-file commit 147f5d3292af2e1cc4a56a7b96db845144c68=
486
    current change 25339
    trying: earliest ^147f5d3292af2e1cc4a56a7b96db845144c68486 latest 4daff=
81c520a82678e1ef347f2b5e97258101ae1
    Reading pipe: git rev-list --bisect 4daff81c520a82678e1ef347f2b5e972581=
01ae1 ^147f5d3292af2e1cc4a56a7b96db845144c68486
    Reading pipe: git cat-file commit 51db83df9d588010d0bd995641c85aa0408a5=
bb9
    current change 25420
    trying: earliest ^51db83df9d588010d0bd995641c85aa0408a5bb9 latest 4daff=
81c520a82678e1ef347f2b5e97258101ae1
    Reading pipe: git rev-list --bisect 4daff81c520a82678e1ef347f2b5e972581=
01ae1 ^51db83df9d588010d0bd995641c85aa0408a5bb9
    Reading pipe: git cat-file commit e8f83909ceb570f5a7e48c2853f3c5d8207ce=
a52
    current change 25448
    trying: earliest ^e8f83909ceb570f5a7e48c2853f3c5d8207cea52 latest 4daff=
81c520a82678e1ef347f2b5e97258101ae1
    Reading pipe: git rev-list --bisect 4daff81c520a82678e1ef347f2b5e972581=
01ae1 ^e8f83909ceb570f5a7e48c2853f3c5d8207cea52
    Reading pipe: git cat-file commit 09a48eb7acd594dce52e06681be9c366e1844=
d66
    current change 25521
    trying: earliest ^09a48eb7acd594dce52e06681be9c366e1844d66 latest 4daff=
81c520a82678e1ef347f2b5e97258101ae1
    Reading pipe: git rev-list --bisect 4daff81c520a82678e1ef347f2b5e972581=
01ae1 ^09a48eb7acd594dce52e06681be9c366e1844d66
    Reading pipe: git cat-file commit 4daff81c520a82678e1ef347f2b5e97258101=
ae1
    current change 26907
    trying: earliest ^09a48eb7acd594dce52e06681be9c366e1844d66 latest 4daff=
81c520a82678e1ef347f2b5e97258101ae1
    Reading pipe: git rev-list --bisect 4daff81c520a82678e1ef347f2b5e972581=
01ae1 ^09a48eb7acd594dce52e06681be9c366e1844d66
    Reading pipe: git cat-file commit 4daff81c520a82678e1ef347f2b5e97258101=
ae1
    current change 26907
    trying: earliest ^09a48eb7acd594dce52e06681be9c366e1844d66 latest 4daff=
81c520a82678e1ef347f2b5e97258101ae1
    Reading pipe: git rev-list --bisect 4daff81c520a82678e1ef347f2b5e972581=
01ae1 ^09a48eb7acd594dce52e06681be9c366e1844d66
    Reading pipe: git cat-file commit 4daff81c520a82678e1ef347f2b5e97258101=
ae1
    current change 26907
    ...
"""

The fix is two-fold:
 * detect an infinite loop and die right away
   instead of looping forever;
 * make sure, `git rev-list --bisect` can't return "latestCommit" again
   by excluding it from the rev-list range explicitly.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---

Notes:
    I don't have a simple test-case for this yet,
    and I was able to perform a few complex initial `git p4 sync` runs
    without hitting this problem.
   =20
    I suspect, I had somehow messed up with branch definitions
    and --changesfile option at some point.

 git-p4.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 5b79920f46..c0a3068b6f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3323,11 +3323,13 @@ def gitCommitByP4Change(self, ref, change):
                 return next
=20
             if currentChange < change:
                 earliestCommit =3D "^%s" % next
             else:
-                latestCommit =3D "%s" % next
+                if next =3D=3D latestCommit:
+                    die("Infinite loop while looking in ref %s for change =
%s. Check your branch mappings" % (ref, change))
+                latestCommit =3D "%s^@" % next
=20
         return ""
=20
     def importNewBranch(self, branch, maxChange):
         # make fast-import flush all changes to disk and update the refs u=
sing the checkpoint
--=20
2.19.2

