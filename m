Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D919F20248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfCUWda (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:33:30 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:2850
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbfCUWda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fApAHcZQMtYa/QSLAHsE4NtFBjm4hfFqSIphn1aIuO0=;
 b=mAZQivqGFUFXUtzxT+yMM+L/39Y+jBpcxhPWFE68oHhEqcAluzT8egHimxFD0qoGBj+PBZONAdSPqLOlMhVZa/Er1QpqmJEe54XUHU9sbX5Xih0+G4abKG3k2t0/dPetjQdHW+WeG/37t/g0CSYlUAZvtXrrSWYyOcnWbWp0uk4=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4251.namprd08.prod.outlook.com (20.176.82.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 22:32:45 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 22:32:45 +0000
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
        "ahippo@yandex.com" <ahippo@yandex.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH v2 1/7] git-p4: detect/prevent infinite loop in
 gitCommitByP4Change()
Thread-Topic: [PATCH v2 1/7] git-p4: detect/prevent infinite loop in
 gitCommitByP4Change()
Thread-Index: AQHU4DYBurNperuERU6FwqqqyjyYfA==
Date:   Thu, 21 Mar 2019 22:32:45 +0000
Message-ID: <3ac39171d441b84a20d5e918a9995e8d8de627c5.1553207234.git.amazo@checkvideo.com>
References: <cover.1553207234.git.amazo@checkvideo.com>
In-Reply-To: <cover.1553207234.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:400::33)
 To DM6PR08MB4956.namprd08.prod.outlook.com (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8420298-d124-4a2f-317b-08d6ae4d23a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4251;
x-ms-traffictypediagnostic: DM6PR08MB4251:
x-microsoft-antispam-prvs: <DM6PR08MB425196FC53FA101B480F8E37DA420@DM6PR08MB4251.namprd08.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(396003)(346002)(136003)(39860400002)(376002)(366004)(199004)(189003)(3846002)(6116002)(26005)(7736002)(2616005)(6916009)(71200400001)(7416002)(4326008)(118296001)(6486002)(102836004)(11346002)(71190400001)(2351001)(1730700003)(81166006)(52116002)(5660300002)(105586002)(8936002)(316002)(66066001)(50226002)(81156014)(2906002)(106356001)(99286004)(14454004)(54906003)(36756003)(76176011)(8676002)(6506007)(386003)(446003)(486006)(14444005)(53936002)(6436002)(5640700003)(186003)(478600001)(476003)(86362001)(6512007)(68736007)(2501003)(256004)(25786009)(305945005)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4251;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gT9blEmpKTpVNfIw1okIe5Yz8T+X3n2T5i/IuDy5AD5JdZTfZdqlit21REQLo22+ELiK7OmRIMk+pkU5sC0S4xjLcdH/Kg1eart2M3c/q1R9AALsdBUj9jFQ6Ku8RD9ENUb26UOBd00naJYVVn6S0H2PpRjmtjnYNLxnhs3x8uBzblmgMbCE7Q5nKENg4WN9aTkymUak0+KFlxO/J1u2RfozmbEhxZd1Pm1A2S1QuzLOPQItNdtu3il4iUzct0HNmef7+jQmmVMb+pRGgv0Y13ce/uSxnFvnRRRkcFiGoLz04bV/EIKCWwM4oYT4LBemEqtvT3oNL7SXqdTkzyZsSS9o8QJ1IDbcRFzuEYHIIueGSl4YnO6AF3huDn+Qts3yRcTrRKDIgWKc4NidNjlS9/t8SJ1RcwUv426s3KYq7sc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8420298-d124-4a2f-317b-08d6ae4d23a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 22:32:45.5939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4251
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

