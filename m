Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE33C433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 02:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AF620684
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 02:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgL2CHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 21:07:25 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:10817
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbgL2CHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 21:07:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxVwYVgUjd8KeN2+PAB7uGlaPo6khkqM4DtsWQ9c254GCedRtt1yNBohSkpXf8EC/lrloNrWmxnCPeWL6/EtRK9EFyJDdwSq57WJHaPiEdjnUe5ECaD6qINH8Su/SuNvOs6E1u31urq7JPj7jhfnnWmUP9xbzyZxbw4F4bawV+qqw39ezy8rWObCmcNyc2JcmMLP+ws3pcfdchU81hkehYckG6JVu42V10eeVlozibPyUQxSRZ0Jo53b0f5wfc4iYTZJ3CdMofEl/88JE/qZOk67YhjSfbttNoHa8zNPFtM/HNKGHaqRcqm24zZhe4a9y+ZKAvEnBhxW5hCTiJyV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/KAetPrHQiNAPvh5mmfNBTJeBB/FxHLfLzTW5HAjWs=;
 b=GPGi8Ktl6FEpIdOHbVtLPtjN3N7TiEXy7CcUWFIrxFF49o4hD6UHYY+ASrawBJyOWMQ2zldRf3frPTLBT3tQ/PCLLP12ogwNc/6KUPF/5TEK79kwEU1ictZvaCKnjqsuQkrangg1KJ2nNk93zDM8C6UNz3ZgK9My8jJwAOpKt0HDzxIEKWP/fc/tyUQiTaoAoBl+G1vcf7+C2JZ9qayLUhdo6acxG+YQgISoa5LihtwJhKdwQ/U822QH1M+c9XxW/M/EBtIj/CD10NmQuEBhG9SGT80tPj9U98mYSOdCJv749f0mbUZHOQsSA320WHBtLzfNdbkOGHwY+suhEYHRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/KAetPrHQiNAPvh5mmfNBTJeBB/FxHLfLzTW5HAjWs=;
 b=Drgcg7eH4QvxYgYMl/96zFq3l2mg6U06+uQttRBx2vuHx1yCkIVaq04XcOwD0kcNxWqvCjNydKjY37Ju6XgXoXKpDw8H2/zu9npH6357WX9ANXURKJWj26LlFHwRXiMZgvullGoNVyrWjkM3pYctdIRZRvcZN4R3G9JCUsxFqRY=
Received: from (2603:10b6:a03:104::13) by
 BY5PR21MB1474.namprd21.prod.outlook.com (2603:10b6:a03:21f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.2; Tue, 29 Dec 2020 02:06:38 +0000
Received: from BYAPR21MB1158.namprd21.prod.outlook.com
 ([fe80::99ba:5c75:8ec4:bf45]) by BYAPR21MB1158.namprd21.prod.outlook.com
 ([fe80::99ba:5c75:8ec4:bf45%9]) with mapi id 15.20.3742.002; Tue, 29 Dec 2020
 02:06:38 +0000
From:   Dan Moseley <Dan.Moseley@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] git-mv: fix git mv bug with case insensitive fs
Thread-Topic: [PATCH] git-mv: fix git mv bug with case insensitive fs
Thread-Index: AdbdfnlTng+mY+/VRbOMbNIcv93gTQABdTogAAATZfA=
Date:   Tue, 29 Dec 2020 02:06:37 +0000
Message-ID: <BYAPR21MB1158D9E88C96D51259A0CC04E0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
References: <BYAPR21MB1158F64E1141453F7D00B46CE0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
 <BYAPR21MB11585FFD46DEE7AD4EEEFEABE0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB11585FFD46DEE7AD4EEEFEABE0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=78a564ec-b378-4b2e-ad7e-65a7ce0f4c55;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-29T01:03:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [216.9.31.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da1426c6-cc7b-4ea9-a44e-08d8ab9e6052
x-ms-traffictypediagnostic: BY5PR21MB1474:
x-microsoft-antispam-prvs: <BY5PR21MB1474E200A0EED8B50E13DF37E0D89@BY5PR21MB1474.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: csfncZ6NwHAEmrtAH5Kw0EtmcSxJ238ZKTEt1Pz2g2j93SKKk7wRRXZzpHNdWrxWiyN7G8DLw1iDcw1TPoCuBq0FGUy0pIBXYGlb8EcteWnPCYNKciL9s2B0qfSwt7yzuPW17idyNI3bhvO+Bjo5p6GlILfmdY+7VhQB6GILPYgJ98CnsTUouqb4WFa5bb7B482lGzmCT/gcDfHLtS3hsgQE8GqwTj9EKxQBt4AwXQ1tVJsJyY2vJmrFBWta0EFqREhO0BjG9Ls66zrCA3JpUG8nDFEf6AHb9z2Bx631H6hO7BblnwQGu1PDHYXk9Rny4vg/gmHyAniu6aIm1IMvyw0umjXQr7rrXIggQ/R+RJ4+J3HAmnR86nq8Dsnj965rTcBB36qZqMOMsD16aR/8p8nGfjJyZQ9Mv3z2UWlcAr/IGsVD4GrZbghk00QJAyUBNpaZsgMmyCaoPmrbE+Zngw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1158.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(7696005)(966005)(316002)(82960400001)(8676002)(86362001)(26005)(82950400001)(66556008)(64756008)(66476007)(5660300002)(66946007)(52536014)(66446008)(71200400001)(55016002)(9686003)(6916009)(2940100002)(33656002)(76116006)(83380400001)(186003)(66574015)(8990500004)(478600001)(2906002)(10290500003)(8936002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sN/X7iue53B94476MWT7YUUnriqt629QD8dMKPVOjTLkRTPh01pz7SVruIzH?=
 =?us-ascii?Q?qC4qQ2Qe8PE9MfL3vNUFbUCVnJqrSrRQjkQEW39yXIxOln0KAOB8q2AKRE3P?=
 =?us-ascii?Q?axm1MuFsAkJEEoIUhAPKFP+YKsJUNMgezEgTTOwA8ULozp+aHlZH264JCRcW?=
 =?us-ascii?Q?2hdrb2zX6K54PuFHk8iITAJafsuqXIoGcicLhON6xZJg6v7buUas4Y9OCwxO?=
 =?us-ascii?Q?cF3sIzgU5IpBS+7MfUMjqSCHpUJoKaMmELUYj6VKYuUWjgKHMsvvi4Ff7QMZ?=
 =?us-ascii?Q?bl0y6ysWGfgNagjfuTTnT7DvFaB24lpiM8unA1pi0FvtKIm5poVU9h83puY7?=
 =?us-ascii?Q?jlznLBLG+KE9Owy6YTEH3HFMZpbzP/j438wAZYmlTaoZBPxsT4yjKJwLZ8iE?=
 =?us-ascii?Q?pmZXTybCDjqn+SOdY7z3WmPv9U78kot66FowGDLunhB9s4rKrNo/oT1WPWtD?=
 =?us-ascii?Q?s1Ej8niCL9OEZOv+y70t7g457ebqjB/8wjhVcx4Fb3TDTfLKoegeM9QtcGBx?=
 =?us-ascii?Q?ZWMcd3m6hkwyk7EChFUZJparVsJ+w0Uc5wX6Hh04rGolJuSazdDTsoAFcird?=
 =?us-ascii?Q?0pSNxyFVtXP2B2lfgEom0Kz0ZxFBfo3DuLmdDj29WHEHNgCKWLNHX4kHHedD?=
 =?us-ascii?Q?F6/Kt0GTHoIvykCvztqbHmz3JrVeiWIn2Iv2K/t8MVE5OMyvvvN6LNx8a2nN?=
 =?us-ascii?Q?5xiDv4Hg2gc7yawxdP5PzajWV4GC4Cgs0Tg9Q31s5iRZmIWL8kcyh1NrA18+?=
 =?us-ascii?Q?I+BShRCSjQEObyBtMh0o2SBcXMzQl1LJhIBREZRtNqMy1oqYjQnz0O3NNByR?=
 =?us-ascii?Q?OdRUpbTEP50Q3TICEUdaHRaqzpnGLlLcqrmbLCSNzVzfKuDUwVU4vS+j9/M7?=
 =?us-ascii?Q?ZshxUYQizBnk5VOVsvQDkaVhlNg2Z8ILGECNAQUpKnINwVHZba15oGH0d5i8?=
 =?us-ascii?Q?RsTKivGWZTtDMfEC7AKoyWp6wUrgDHq2oWPXykubLfg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1158.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1426c6-cc7b-4ea9-a44e-08d8ab9e6052
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 02:06:38.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKAosbA9n06vOTuZAA8ZQ4vWig04SECRtshwXUgKPpiZuLsA0yXQi0VDktXmM5xn5gvY5NVUgOk3HOgzyMsi+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1474
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix git mv to not assert when src is already in the index under a
different casing, core.caseInsensitive=3Dtrue, and the file system
is case insensitive.

Since 9b906af657 the check that git mv does to ensure the src is in the
cache respects caseInsensitive. As a result git mv allows a move from a
file that has a different case in the index than it does on disk.=20
After the rename on disk, git mv fails to find the file in the cache
in order to rename it in the index, and asserts.
Assertion failed: pos >=3D 0, file builtin/mv.c, line 295

This is the simplest possible fix, suggested by @tboegi. It does leave
the file renamed on disk, but that is easy to reverse after the error.

Another option would be to change the aforementioned check to always
be case sensitive, but I am not sure whether there is a scenario where
it is useful to be insensitive.

Signed-off-by: Dan Moseley <danmose@microsoft.com>
---
Originally reported in https://github.com/git-for-windows/git/issues/2920
but this is not specific to Windows.

 builtin/mv.c  | 6 ++++--
 t/t7001-mv.sh | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c index 7dac714af9..e1fd8a5e00 10064=
4
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -292,8 +292,10 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
                        continue;

                pos =3D cache_name_pos(src, strlen(src));
-               assert(pos >=3D 0);
-               rename_cache_entry_at(pos, dst);
+               if (pos >=3D 0)
+                       rename_cache_entry_at(pos, dst);
+               else if (!ignore_errors)
+                       die(_("bad source: source=3D%s, destination=3D%s"),=
=20
+ src, dst);
        }

        if (gitmodules_modified)
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh index 63d5f41a12..5c7fee9bd8 100=
755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -152,6 +152,14 @@ test_expect_success \
     'move into "."' \
     'git mv path1/path2/ .'

+test_expect_success \
+    'fail to move file already in index under different cased name' \
+    'echo 1 > foo &&
+     git add foo &&
+     git commit -m add_file -- foo &&
+     git mv foo FOO &&
+     test_expect_code 128 git mv foo BAR'
+
 test_expect_success "Michael Cassar's test case" '
        rm -fr .git papers partA &&
        git init &&
--
2.25.1

