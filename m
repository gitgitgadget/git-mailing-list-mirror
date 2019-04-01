Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE0E20248
	for <e@80x24.org>; Mon,  1 Apr 2019 18:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfDASCX (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 14:02:23 -0400
Received: from mail-eopbgr810123.outbound.protection.outlook.com ([40.107.81.123]:61961
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729908AbfDASCV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 14:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fApAHcZQMtYa/QSLAHsE4NtFBjm4hfFqSIphn1aIuO0=;
 b=D8bMt3XsXp4EmUHiY17vY/6n60XbbzVOSL15KV17y1cEO/EDa/J9ZQSLwxJvgklNTzdFYNpTHtuX7C42f2xz6WEs4eqt3M5O7ihPh958qNrp7bfMgFtlKjSQzvrFU2pAAwGmi/Ks23ga3Z4OlhY7VpbhVHnCpaEvxrh+l533fI4=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5610.namprd08.prod.outlook.com (20.178.26.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 18:02:17 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 18:02:17 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrew Oakley <aoakley@roku.com>,
        =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Andrey Mazo <ahippo@yandex.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/8] git-p4: detect/prevent infinite loop in
 gitCommitByP4Change()
Thread-Topic: [PATCH v3 1/8] git-p4: detect/prevent infinite loop in
 gitCommitByP4Change()
Thread-Index: AQHU6LULPukLbzpG80yBUB+l08v90g==
Date:   Mon, 1 Apr 2019 18:02:17 +0000
Message-ID: <bd009a5ca5679883f9366a58fbfbdcff1cf5f8fa.1554141338.git.amazo@checkvideo.com>
References: <cover.1553207234.git.amazo@checkvideo.com>
 <cover.1554141338.git.amazo@checkvideo.com>
In-Reply-To: <cover.1554141338.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:405:14::30) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c56b122-ac44-456d-add8-08d6b6cc2da2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB5610;
x-ms-traffictypediagnostic: DM6PR08MB5610:
x-microsoft-antispam-prvs: <DM6PR08MB56102AC05A6187E77DB296F2DA550@DM6PR08MB5610.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(486006)(102836004)(118296001)(86362001)(2906002)(50226002)(316002)(4326008)(54906003)(5660300002)(2351001)(105586002)(5640700003)(6486002)(26005)(106356001)(52116002)(186003)(8936002)(71190400001)(76176011)(68736007)(71200400001)(99286004)(6116002)(3846002)(97736004)(6436002)(6506007)(386003)(14454004)(478600001)(1730700003)(8676002)(81166006)(53936002)(7736002)(81156014)(66066001)(305945005)(7416002)(6512007)(2501003)(36756003)(476003)(14444005)(11346002)(256004)(446003)(6916009)(2616005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5610;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y2W/dsKkl8o7rB92dDIGCHyAwGzxundE6CkTomLwzxb86je7i9dYLEnlG+XLF3XmrXPJLDz5FphtFC704+Cl+kYcsIecLZI0Bj/vZBoY/eZ07KNMvcX2ALUi6igvXCm1tQkGZgJSZ7CEEhSKseCQ/FyArXpK5tB4fTUuZJedsVOOs8LjDzZXzzgFgJax88bXtnKn+b/qVrCgPZE04ceABM6f2liOBP0U6kO6xaup2XaIwIV/1H/xMK8odCfsk9LhdaXlO4P2u2jqhd8osgWyqET6kZIaxI9Vk8Zv5WszdlD/64JM+V94CatyXBE63o54+22WxNJB0kLymhGaj8S/KvhtboEFsKzbgznjTk9672q75RyKOVMNfyMR47gzq06r+evfbw3NLHBivQut4SPsCj1pIKIEMDA7Hsy2F62OypM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c56b122-ac44-456d-add8-08d6b6cc2da2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 18:02:17.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5610
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

