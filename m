Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D36C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhLII42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:28 -0500
Received: from mail-am6eur05on2045.outbound.protection.outlook.com ([40.107.22.45]:10529
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232177AbhLII40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7UInzEWi5n9/oEY7FpCzMgwTqw2H5zbPgDcDZcRczaaaR9A3RtTu6xnVqOEzMZz9plcihmz3aDxRXrjpSjKJr447KF3aNQ7ChxfvDHtsRQKL1Hpy+uO5xyEUD67bWfsvKJzwrDQhw3EZVVL3ZTfU60bphhgvED7AfAWrwu1blwrZk3/g0VavBvB5bN7n2ISZccEUHpbiUmLEuEJrlDrr/qVikD/rQ6ohBsHCrlYfVXSK9P4xpZzKkYBjajiLi3vzvEYkag0CljLLWh4mqgE9+cxV+LRIcUFwugtqpmQ3kCM9YKT2NFXFq5JJS+qRoSJl1v2T7JJ6Z05hthuMzM83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QANBe1mya0pOOPbHeT5XSnVYOXA4IAiQ05EE5fDQ934=;
 b=i1VUpp+leYXsTdXXtL72RrXtanSPNW6EjJJl7faRROQaLyyDu2OaIbjPnZZ0Z7z1Mtom5BiHQs7yuuje4zGVtu50owJrRb8t5hw4kwDQUUQNmoOVNs4verwwZxFL+3SAK9mN7jHEIzbRDtEjU+ea0+rwgbZO8jJdTVja+2Lj7/V23GfgWWLJa20EIxqwjIEYY638gVkJBEWC7ExEZV4l8WiuzkqxBtHwysD2doDYqG9yCFksnpzaPToxWAmO6Is2cc38EBnud9FPmzhaYj4YhJxhqQa9QrH3x/bhnE9VaAYFmjuED31ki1w9UWDVHx97CU//v33cMgt2o2t14ooYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QANBe1mya0pOOPbHeT5XSnVYOXA4IAiQ05EE5fDQ934=;
 b=ud4bOaRKu1M/CLNAWfWAE58BTMLBbS70e80zeHjoMfVR7gAXP/bSKM1R+BKKByymTt6VCmC1MyvASQXsAZPi6qOitAexBWNzYTZ84ZXCAW/PEeNLxmhmhW5Z1fhpk/Nz/F5Gd8Sd4GkMcQJjd4pu4V15UtuScz5kStFlATL8hYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 08:52:51 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:52:51 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 0/9] ssh signing: verify key lifetime
Date:   Thu,  9 Dec 2021 09:52:40 +0100
Message-Id: <20211209085249.13587-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208163335.1231795-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0181.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::6) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8PR04CA0181.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 08:52:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f2881d0-6c70-4065-9969-08d9baf14878
X-MS-TrafficTypeDiagnostic: PR3PR10MB4110:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB41100B6C565195C5A6DC1AD2B6709@PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWtpoFrlAf7hfRa6NQemfG7hmeGFoRUbG/7r00gIrq56VOgl8s8ueQByjmetWxVc723Kk+KORBj3gdPKDh5maiL+7CRWEnMla0AXpM/84IL9v7tx589vRYkOViRSNBifaRWBXW7Tj5/J/sl6b37CkbSS5iU9V23uO6fmRycT1hmI8k4m3c9iOKrPUPe0DumBJI+Pmazth6jeQO99lBKig4PQnsgogWdSECRt9uiy7hOwhCq0T7hzWfRvTMpaR97BPlRsd7ryUsrRNBtgCXAB/DCJJ0UQhKPVHAiO9d+5jYrnfhXWQFqKktnBGrUB8N9HfZOws2R4z825JS4LXL8WfyqGGxO0G7zn51GsMsSKXOUL17ZbKD2G6O/zwkYSER+RX80490BggX8DQNsO7XjaPkAO7F7eVDvDMXmgdzY0Vr+bWIyWh2rbXwo2ishqABS6vesluuaG9N3DIff793MbnmJINxwRYcYjSxMLhAFTB76vxUdcMP/Bc4NlMV2LHetQOCnSurjtk8Bbv1uWBKu3AtRFwXCs8AKa87Hr30ZX7+O5I08hok1ClTAwBTBPBV74rCdRZQjCLlPfHBre4WgdZA8Gy0SBA7t2pSJKRd14CjHdLeMW7m9eAQDLOnK+4a2z+RRKFdvQ0LMLA466R6zoPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39840400004)(366004)(86362001)(15650500001)(36756003)(8676002)(54906003)(8936002)(316002)(6916009)(6496006)(6486002)(508600001)(66946007)(66556008)(66476007)(186003)(4326008)(2616005)(107886003)(2906002)(1076003)(6666004)(83380400001)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4lCpX6gGbZsL0HhUI3BTEuNDyzSHDwwL+wJyJVNfyUTLK1YLU5kBaUfefLD?=
 =?us-ascii?Q?/5abM3mhWQFpYgoNyQL6ekwjlDk2kDr/oF9io6Ks8ZeP5X63QESL++rtuAHJ?=
 =?us-ascii?Q?S+1tM4wvcstLxe0/i+ysgHRf9bnZgMaJ9PQ0o+Z/u/xGd/EkMlvgmpWtKn2p?=
 =?us-ascii?Q?N18qzT1C6LMj5q59w7j/DRiFMwk9FyxtqpAjXwBKbCVMF2vcKToohgTkWTQn?=
 =?us-ascii?Q?9GojztVuuei321KNxXZ2VfHaJcUkLYG5pbmYmU2iRunJFs/B50thT09QPrOw?=
 =?us-ascii?Q?idzm54yOCxzHaTYuY/J8L3K+owtyX3xBHWpam72fDYGpyBtkf+x8u4J1PDVO?=
 =?us-ascii?Q?btb61Ej9iWJ0WPouZmFxiwnAeU4vg8b/rXNHO6W7qR/c/SqUOhlG4s11WUNv?=
 =?us-ascii?Q?uAks3zdGjdMAjskCkCvZnIBz9ngnF7rlZVpuL4x5bLn2b2Iuy8TyRJhAvfbP?=
 =?us-ascii?Q?lsfD2SDfM2ReE3YqVd1M4gNgcTwApIKvkOSz/kVqQaB2CaV3KK43slIlb6AF?=
 =?us-ascii?Q?9BPviQ2ZFikh6uxZBkl6vN82w1Ly8Hxf5JXsyIsq/O3lomOZfrXjFjf2NRf1?=
 =?us-ascii?Q?1RTq1Eor/zYvZCEE9WB/wq22H7g45DjWHqhuhfE7IgQjc1atYDM8lWvhfhU8?=
 =?us-ascii?Q?NMDSAOz6fUKjxAKXIiZJU1SY7XAKpmDitaigp1Yn60o4D9gMtw6T109icRAv?=
 =?us-ascii?Q?0OQs4hXWfNYmYl3aappI6SjLSKdVhxM3SPGfGYJKARtjYOuWsjdSvaTbEx0J?=
 =?us-ascii?Q?3mLmyHEhTbCFfidWQgMcKsddgUzkzDtcw69DGTrp+EwPqHV378cVEeNsBEsy?=
 =?us-ascii?Q?m1L6vFg4UyZmx/SO78MjaEsvW7d2laPCguY++xTNKlaVMJ9rMJ4Pxiocg+sC?=
 =?us-ascii?Q?sZ1yH0qhxeDpq4Z3MhxrIs3spt8YwatfJypMHqLQZp639kqMKdfNYYhNFRqu?=
 =?us-ascii?Q?JDAF2EbsT1GbIKTq0NW60VLK3T927vDFLLBW6vaF/nXPMReE3Pfhj6EjyV1P?=
 =?us-ascii?Q?8v0ttKee/+ACYDO7ZgeiQSBbrjaCadn1o4goKTEmtqUhGcC24Dnefi7zJEMO?=
 =?us-ascii?Q?0HV5jaVGvMolucL6DqHLa6KgO8t36EcJqIgMpWbjrj0D6tqgj56m/ZE5ROhE?=
 =?us-ascii?Q?bEJwNACMNqx06yiqIfVASmRkjdUmPxa3VXptD99sstyw8aO8mJmdhh1Z8JQw?=
 =?us-ascii?Q?LOEk2jQyOgRYz5WEiXk1fBEhkNFr0oHNVF2Qj+FyH9UXJtW6kxeYShYQ3+jd?=
 =?us-ascii?Q?OiagwDN2z9tsVujxq8B1MUHOyw/XXV/abHj+P9AnDUXHtBmLvSb9CUKUM009?=
 =?us-ascii?Q?tNq1dheh0J5pdFakZm9CzEjuQQUo3IQiXQLENAKh1nMJrHZhV7fKREjwx62H?=
 =?us-ascii?Q?RqccfGnou0iPvnrud83wyTRpRItihRX/g6YI6QTp2XtmawsFwzVz2MVEDa1c?=
 =?us-ascii?Q?eHrXWt22PmVh98T25rZtuIeslALeNKuyEDYP7MXpKZvz2E42gGBRedh343e5?=
 =?us-ascii?Q?NZ7uKzjyXnuW/rO8COIJIMkKwASz20+ECjLRwjycJbZvTS/vf66mpjbqSbQ6?=
 =?us-ascii?Q?YjrGK59GLQg89Aa3u1oMdmEk/e4GV1G9ivB7urfQdW6alt07uVPXXcDeJ4kQ?=
 =?us-ascii?Q?WQIPloPNgCBFR25DkwVYvwqd+BR5x4GoOJWcus9kviQ8djj1+k5qK62JvI8J?=
 =?us-ascii?Q?WryhpUT/a+C8SS3spqMlwyFmBeS6uI6bLR/e++yw/wPZS2TW5sR0offDgUpF?=
 =?us-ascii?Q?SL1njQqLmV1BKe2Fvu6lPbf3EZYYMJU=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2881d0-6c70-4065-9969-08d9baf14878
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:52:51.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9mZqhT9SQstCzsGe2JQE/mXqSel7cJZ++8SMWNTVPJ5ijeY1qk1/mVGmHZc0xmcmeF1VIG66Ick01IQPZhRwo3G08wl/uXTxGc8u6du4VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4110
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

changes since v5:
 - moved the fixes to existing test to the first two commits and merged
   those fixing new tests into the corresponding commit

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

Fabian Stelzer (9):
  t/fmt-merge-msg: do not redirect stderr
  t/fmt-merge-msg: make gpgssh tests more specific
  ssh signing: use sigc struct to pass payload
  ssh signing: add key lifetime test prereqs
  ssh signing: make verify-commit consider key lifetime
  ssh signing: make git log verify key lifetime
  ssh signing: make verify-tag consider key lifetime
  ssh signing: make fmt-merge-msg consider key lifetime
  ssh signing: verify ssh-keygen in test prereq

 Documentation/config/gpg.txt     |  5 ++
 builtin/receive-pack.c           |  6 ++-
 commit.c                         |  6 ++-
 fmt-merge-msg.c                  |  5 +-
 gpg-interface.c                  | 90 +++++++++++++++++++++++++-------
 gpg-interface.h                  | 15 ++++--
 log-tree.c                       | 10 ++--
 t/lib-gpg.sh                     | 62 ++++++++++++++++++----
 t/t4202-log.sh                   | 43 +++++++++++++++
 t/t6200-fmt-merge-msg.sh         | 68 ++++++++++++++++++++++--
 t/t7031-verify-tag-signed-ssh.sh | 42 +++++++++++++++
 t/t7528-signed-commit-ssh.sh     | 42 +++++++++++++++
 tag.c                            |  5 +-
 13 files changed, 351 insertions(+), 48 deletions(-)

Range-diff against v5:
 -:  ---------- >  1:  0b3848d23b t/fmt-merge-msg: do not redirect stderr
 -:  ---------- >  2:  f29d838574 t/fmt-merge-msg: make gpgssh tests more specific
 1:  c4447d30f2 =  3:  b065dcb7fb ssh signing: use sigc struct to pass payload
 2:  0bb1617529 =  4:  c37d33db31 ssh signing: add key lifetime test prereqs
 3:  f60bd1efd0 =  5:  640e9a4a99 ssh signing: make verify-commit consider key lifetime
 4:  5fc0ad5c37 =  6:  2e98307c18 ssh signing: make git log verify key lifetime
 5:  f1c225871f =  7:  75d213ab15 ssh signing: make verify-tag consider key lifetime
 6:  1cbd4dbb6b !  8:  498821af14 ssh signing: make fmt-merge-msg consider key lifetime
    @@ t/t6200-fmt-merge-msg.sh: test_expect_success GPGSSH 'message for merging local
     +	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
     +	git checkout main &&
     +	git fetch . expired-signed &&
    -+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
    ++	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
    ++	grep "^Merge tag ${apos}expired-signed${apos}" actual &&
     +	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
     +'
     +
    @@ t/t6200-fmt-merge-msg.sh: test_expect_success GPGSSH 'message for merging local
     +	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
     +	git checkout main &&
     +	git fetch . notyetvalid-signed &&
    -+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
    ++	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
    ++	grep "^Merge tag ${apos}notyetvalid-signed${apos}" actual &&
     +	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
     +'
     +
    @@ t/t6200-fmt-merge-msg.sh: test_expect_success GPGSSH 'message for merging local
     +	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
     +	git checkout main &&
     +	git fetch . timeboxedvalid-signed &&
    -+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
    ++	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
    ++	grep "^Merge tag ${apos}timeboxedvalid-signed${apos}" actual &&
     +	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
     +	! grep "${GPGSSH_BAD_SIGNATURE}" actual
     +'
    @@ t/t6200-fmt-merge-msg.sh: test_expect_success GPGSSH 'message for merging local
     +	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
     +	git checkout main &&
     +	git fetch . timeboxedinvalid-signed &&
    -+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
    ++	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
    ++	grep "^Merge tag ${apos}timeboxedinvalid-signed${apos}" actual &&
     +	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
     +'
     +
 7:  d60f4ec82c =  9:  0816dd2ec8 ssh signing: verify ssh-keygen in test prereq
-- 
2.31.1

