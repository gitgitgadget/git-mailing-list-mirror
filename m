Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB34CC433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhLHQhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:23 -0500
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:23374
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231571AbhLHQhU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:37:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlovvqgbUoZfSDNA4XXrbxtoj+GpOiqve5H+FRqzKNyQke2ZCndFZVNOtYqkNSIwX6sgy5nhsfDuiUeD5jMdFQ+fBawVRkF4sgfYX+C5xliu8i7HWuHvUMDmJYeUNB6QRCzqBmyggFlX7kcTgHt8KoccbJbFaiylIfy+LeUyAYdHSOB0iDpsqHBUafiUJCO/Mf/L+8zvRJJdXRbbvHLGCjGcokdsps5SZYIWJxl4Yw1k7wVhRgDhS1k3OtEvJFdlylHLorzCva9K0+ugPbLaLXcjPgGLspPDQrdqzuDBSqDxGc3p1AvhbVck4Pc0fr9uxgotjBcmxrwpoemilB+8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFdItirRw71jkL0A+M51+28p9YcwTrp0Mzrq8UYb0tM=;
 b=Nm6bpvcHQ6GccnoeIFKQEShLyqp57C438/nfAhTCjR58g4xpDa3E1mdHhrd976z0GVuN8uitPTmv6Kk9ELZs04Gs7n98kzb6cAgfcC83WekBIaKsf3G5l5FyfBnK1EU6tByvUvYhhbdl47fimQYoXXcxQ+XwIvgmDhdQGQIFk3HohSssy24lvOh2W/EwfwH57CjR8Ogedb0HxYDT5QYYA4z3lhb7JnPoANXLezxy5wDRRKLvij+KgVKHfGfLkrwYfBZJc6geUrOtPHsSfhtbITWYpXueLzN+EXTVEEeqUIJAOGzqDEVnP1EUfNas6LL8ia4hF0Fpq4H6UgMGPMP3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFdItirRw71jkL0A+M51+28p9YcwTrp0Mzrq8UYb0tM=;
 b=I5QcDdl+mzkANb65NlI2BKbPT5Qkca4biH+8c0oBBbGqGypmDedNu6VpN5uNYfoyywNcLHbdE7Fvql5B9eJleKZbSJez7MXGKVKJn+vhhKgEtq9bzJILzAO/sImPOrsG8iD4P0OXnCXsc5KdHEFX43rV4whmK5/wm7BC/KfdwCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 16:33:46 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 16:33:46 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5 0/8] ssh signing: verify key lifetime
Date:   Wed,  8 Dec 2021 17:33:27 +0100
Message-Id: <20211208163335.1231795-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130141112.78193-1-fs@gigacodes.de>
References: <20211130141112.78193-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0024.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::37) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:20b:92::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Wed, 8 Dec 2021 16:33:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7767d075-2cf5-4e28-392c-08d9ba688155
X-MS-TrafficTypeDiagnostic: PR3PR10MB4128:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4128DA213E8D1B882CFF7781B66F9@PR3PR10MB4128.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlAO3/QiU6mh70c4jnNEck7sskd71/xbxFgV8ZVAxb/ZUwplzVisF5xnZYKa051WyD6DNVZN60ZX/tmUuws7gBfk+OvldBmFsBJMtiSNDtENElUbtdRcNSLQCCyHtihlqUDmVc+AH8JAh2Nw5qkQd9KctPTdUHWE0TzN60xnN8tyLmn3W/JUipX6br5PKdpnIAk6oA8CH2WSa00/KoDTjQgI0AwumaLZ2I5IRI2HwXl8w+EIbJ6iD0JbXCvaqSM1BmBaGi7Fa8YWgkpwDfzkATs3W5CFAtc2+BAOhcOElf1rY4s+aFNEty97NhWI8eu2+vwlj0Ts4QD069q6QOZxRxhOA5icNFprBe7mWS4R1Dxre518rGqU8aU/jnU61hr/mAF29VUocYYoQeB2KQ1LVZ9EqUYrMQa9u2HH3S1BLO/5q3tIXYOBegnF7kVmk8KQWZ+KEjBK1ok4l3BGcpaNsTszOsB67HKOhnjPqfsJvPK3r2VfI7ImdR63LQIRDqmkGFW3iHatP3w0Ot4rIJmA2I0oA6n9K78PSuQBx9Pg4Q5onra6QKmNKlEMxPBOZX5r/0XpLmAQt7ILhjhLmOiyEf0OfHlLzUyYOJucopjDhEmOdGHAJNXZbavWU2BfTNyMwpRd+RDPqKRQrQ2jDhmZ+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(6486002)(54906003)(8936002)(316002)(83380400001)(4326008)(6496006)(38100700002)(1076003)(6666004)(66556008)(66476007)(86362001)(15650500001)(2616005)(186003)(8676002)(6916009)(5660300002)(2906002)(36756003)(107886003)(508600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lbmpzrc/zWOtn+hfZKqdWzRSKG/yp77VhwH2FgMy9rNPe8KxgAUo7MyEbIPy?=
 =?us-ascii?Q?vrpTeC2YKMHvvOve8wapwHOAPx9OaFIttxijfpQLXI8WkI+F14sE1WR0Hk9L?=
 =?us-ascii?Q?KC+XMKf6+BACcdlb+4gCE/JC/aGFvs5ofNuACBOWXeOLgvezkq7XmScZgAoQ?=
 =?us-ascii?Q?CxiSnH5KUFpz5LtyHsqAlbHpYb3HvtVRDN1QuuMXvw5ErEkLwuGsqqRwwwLa?=
 =?us-ascii?Q?4udZMIErGCGtAuwVOvDSDmIIfwYBD3sOG87wRnQfyuYhYcNpoHyRQgaXi8sf?=
 =?us-ascii?Q?0BmLFCAwHI+AFK4QVIJk3CgRaORW2oAp6cOyBx7wy/i0B6Ka9rU9HW6qZDPp?=
 =?us-ascii?Q?vdd52aMbPGC5MibcbRobUlI3chV4ahlY+Ad9ZH6CFtD4WHAPDlO77j03psaJ?=
 =?us-ascii?Q?mj6ENeZ0a8QzLKX+ijbukcgFC+9zQxYkDD9byLS+ZZ1ICgG7NYWd8zcPIMss?=
 =?us-ascii?Q?orCM05gMmjtL4mRqxgrAmSm2fnyQ9IEJjuD2JVM5hNVf3wtM+kJHfRtgRsfI?=
 =?us-ascii?Q?YVNXmlr1HohEKVCDRbMRJ6PCH7IlyCjAfYkq7z4m/Nh9h+5PuMLYlElDNnD1?=
 =?us-ascii?Q?h/DS1JXF9f2yhwmXkOe/pWp1vzpAieGvWQTiYQbReiynB98l3tdmS3/pJXbj?=
 =?us-ascii?Q?0BQbn6Sptj4EvzaHHJzySm3y1Uzb5tf4erYvRPJxVBL9IpVykyIQtuciaE64?=
 =?us-ascii?Q?hS+I+P5RNFkakRlByFczYVr5kJFRfd9KHV0Ut1LA2HNrRWB2cwCY1Ho8R1nH?=
 =?us-ascii?Q?5UyKt6Hw8yZdGHNg47gM1qIFXCen2IiCrysnPGEqY7DSGqmCfdFIDobXQBAW?=
 =?us-ascii?Q?n3/qiHXPJaLLxNbJBp3ob8rY5fKgr5hHDzyr2tAcayOG3EQamPpgtY1Zmw72?=
 =?us-ascii?Q?lkNXTPPhyqZh6XADYr5bNDlNMdW274ezGU60Azu8zIg5HxT+8OFCI+X4ueZP?=
 =?us-ascii?Q?Bguy/XnJKLeShTtbbNk9mne94975LLgZI+zIVgKpjWcrzCY7dYXjjIXShZGH?=
 =?us-ascii?Q?fpwUHSXI7bs6sdXbIsJFXpQhkKtF332tGPURCnsyJwJIwFEhjnvIi71wb42x?=
 =?us-ascii?Q?q17HTnOxMg/MJ+te1Fusi1zpGE1P4kNLLh+vcyUL891rDCUlu5eXhq9Y7uDz?=
 =?us-ascii?Q?qEAEz1SDvwMR2jhFW9FnZGaHgD61UR5FuneI9cup/5Yzuy5d/DkZo3pG4IHf?=
 =?us-ascii?Q?dT7B+LRgUIE/A8k54BXPJQLIU0r2CeBg+qZdnZXm7P1AbCsri9pnDNH1Uyjf?=
 =?us-ascii?Q?qZYju3dNoiiV3NG8K6tOjLH82LPXkwJCD0x0E+YfE0k0wjPL9atOYC2H13yQ?=
 =?us-ascii?Q?m4wweQSi90tfvYEKpLTzVbYF8cHeZggsirmH1ySpADxD6Gafyrcz6ejHELHq?=
 =?us-ascii?Q?RHtXdWyXHrkjUml8hPe2eLx5tiR604mob2pIwPjAf0Eak5uI+JzZ6Gn5CMr3?=
 =?us-ascii?Q?6aIJtCE/M9k6f+4ZzvX2eBu6SpJbKFj5N0gxWPVOOWGNsqJa+F5VPMnMNVNQ?=
 =?us-ascii?Q?eTyfP9GQQ7tJSRn7/AtlgOzX6ENCQzt5xp2NYiL/ziZO6aOA2Yf53AVBBhvU?=
 =?us-ascii?Q?lzgK0kMDIwsXUmF+7veuYvSQyz6vgkfWjnWrvESQhbJHpj/CnSFDa90Z4IwP?=
 =?us-ascii?Q?0kaRF3wDImkijlWzsQNadw/kb6xrGofkK5A+0C3Bp8D0LKeb4RjBIQc6txEu?=
 =?us-ascii?Q?36mtwycc3SRrA251R/LKYPLC4jTMy0G6q29ZeU26QdDXr9Yqm6SUZqG+jCON?=
 =?us-ascii?Q?vNK3hjE4Pw=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7767d075-2cf5-4e28-392c-08d9ba688155
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:33:45.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWTHTRoKWjadEE7dmRZ2Z2sfe1Mpyx6c2bWAIrz7ZEFGaXEjiiVyqyvxltRn0GGfmN078903VeyKGb+h6mtQswKDKd8+zimG3bKGusThSpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4128
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

changes since v4:
 - removed unneccessary io redir in merge-msg tests
 - added grep for merged tag to gpgssh merge-msg tests

changes since v3:
 - improve readability of prereq setup code by using heredoc and some
   variables

changes since v2:
 - fix swich/case indentation
 - BUG() on unknown payload types
 - improve test prereq by actually validating ssh-keygen functionality

changes since v1:
 - struct signature_check is now used to input payload data into
   check_function
 - payload metadata parsing is completely internal to check_signature.
   the caller only need to set the payload type in the sigc struct
 - small nits and readability fixes
 - removed payload_signer parameter. since we now use the struct we can
   extend
   this later.

Fabian Stelzer (8):
  ssh signing: use sigc struct to pass payload
  ssh signing: add key lifetime test prereqs
  ssh signing: make verify-commit consider key lifetime
  ssh signing: make git log verify key lifetime
  ssh signing: make verify-tag consider key lifetime
  ssh signing: make fmt-merge-msg consider key lifetime
  ssh signing: verify ssh-keygen in test prereq
  t/fmt-merge-msg: make gpg/ssh tests more specific

 Documentation/config/gpg.txt     |  5 ++
 builtin/receive-pack.c           |  6 ++-
 commit.c                         |  6 ++-
 fmt-merge-msg.c                  |  5 +-
 gpg-interface.c                  | 90 +++++++++++++++++++++++++-------
 gpg-interface.h                  | 15 ++++--
 log-tree.c                       | 10 ++--
 t/lib-gpg.sh                     | 62 ++++++++++++++++++----
 t/t4202-log.sh                   | 43 +++++++++++++++
 t/t6200-fmt-merge-msg.sh         | 67 ++++++++++++++++++++++--
 t/t7031-verify-tag-signed-ssh.sh | 42 +++++++++++++++
 t/t7528-signed-commit-ssh.sh     | 42 +++++++++++++++
 tag.c                            |  5 +-
 13 files changed, 350 insertions(+), 48 deletions(-)

Range-diff against v4:
1:  c4447d30f2 = 1:  c4447d30f2 ssh signing: use sigc struct to pass payload
2:  0bb1617529 = 2:  0bb1617529 ssh signing: add key lifetime test prereqs
3:  f60bd1efd0 = 3:  f60bd1efd0 ssh signing: make verify-commit consider key lifetime
4:  5fc0ad5c37 = 4:  5fc0ad5c37 ssh signing: make git log verify key lifetime
5:  f1c225871f = 5:  f1c225871f ssh signing: make verify-tag consider key lifetime
6:  1cbd4dbb6b = 6:  1cbd4dbb6b ssh signing: make fmt-merge-msg consider key lifetime
7:  d60f4ec82c = 7:  d60f4ec82c ssh signing: verify ssh-keygen in test prereq
-:  ---------- > 8:  679a02d1fe t/fmt-merge-msg: make gpg/ssh tests more specific
-- 
2.31.1

