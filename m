Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D69C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhK3OOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:14:51 -0500
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:59719
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233690AbhK3OOt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:14:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjcj0l/JB/gqu+g8eePtGp0lHYiaqddnGkZ9jJuq+q/3vKu+K7Aqe3zEV1eQ+lD+q62N4r+1YW0kn7cKH1UnhMuPDxJCv7WHURnv1ehtJcXkItkvGKilsBixI2YZRu3IM25l/vRivjP6pU2vR2pTnPJqN3DUYSCdxLcrXyuqtcLaU6pO5wmWmbjeNSB8UMRNipE9anJsuwqlPa+5Hy1xfCZqsQEMkO1ZexL8mFFUukKTZYuNRRKX9khRQZQHNBXqKU6p3JkLf+9PPgT/5j1eTaFF3apal5cF+yga/Qcf6HLHVQHy6Ed1w9X/hCTmLlUSDcfPeXb6TKW+A1UVtjYsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FilPsKYyCBGSYIVXJQY0bcREmGWFKGncouCe36r2oRA=;
 b=ZHZy/R20zOpyXdlXNR7Zo9bW6CbfMD7y3Dxv3kRXDraAq+VFWHyoT0BWk73x2XjRR4LBR5hQQSrmSrwt3iUXV3x2P39lIm93OhpVezdxTA+ZvcaqgspEFTtNVUVifjMDD5wJY3S26aep7bdMNY7Ek0b2CUPBq8VhX5GElgZ7bqw/AikxT1ehJeWV2XAVNDZshyuxrsK+4Toz2cEOfy5ihn3Ldf6YtjkdEbxPxWdO2ACDgzuwaKVbUIzmCi7e0PqY/i1eeokK8bEe2npFtjJ8YXfbuL0zA+f/HuSag7sGzwYnrjGGPJpkWZg0AAn44Vwvmcz8XIi0GO4VRRsme8CqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FilPsKYyCBGSYIVXJQY0bcREmGWFKGncouCe36r2oRA=;
 b=dfXEagUps6sXPTY22kqgoiAn6mgg911vVH8JuvLnveAGuFRsZTAEIUwOveuFtlR1Z9CDePyuZgnwakBERsBPMYljzMhihsinp9rHcNJeJlZ67of2QSjJX+FxmJ0hw5hqaGpudi8p5D5elue8Up29BmtPEb1S4D18edDB0duK//4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 14:11:27 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 14:11:27 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 0/7] ssh signing: verify key lifetime
Date:   Tue, 30 Nov 2021 15:11:05 +0100
Message-Id: <20211130141112.78193-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117093529.13953-1-fs@gigacodes.de>
References: <20211117093529.13953-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0090.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::31) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P193CA0090.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 14:11:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f645840a-89a6-4d31-e5ac-08d9b40b4cce
X-MS-TrafficTypeDiagnostic: PR3PR10MB4238:
X-Microsoft-Antispam-PRVS: <PR3PR10MB423837E0FC7C36278EDE42D4B6679@PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCQLVCq7wGObXSRZYXeDn19ftU8s7ZvESqC0z+TWHSDlal958NsVVjGzrfDJXH8cdPf7qAdLFCJbDi+XaNMEWJZK6FAZFHkEl97Y0Fmj7Md1vEl2DYGdXlPPOdh2tm81uwsfIBIWO1P2shvWRPvsxersKgRKxhz1NAgdPIsFuHeFFvC2hV8hEKniGa/T71/6FWskFe1YwZbhMVJri79/5B3G8U1xseQ2Em0HLTgAiylVgzExMHpDQkO/i2/3QFgzcXg5UYgRjLMe/MfuAqiRYYlg147BXoX171WDLgxlSX/mfalbQkafmX3JzU0yjdaOajk9N1ekZ4v/92hPqp0qMcPCRsb6KezXFwQNxH9Qw1hf8p9FIPr+HwnJkpdvcfQeprEcp98ywSfvAzo0QUZxEFF74n6LGqdIOiL2O7D0kPCjcYz61xhHbBD3tmy8B1hJaYwrJXTlnilq3qw7e8pB/yBkGIT+h0/t3FUGu00xjI5+/sklY0EXUOpbSymf7TajQpYFhk/nxd9mNoF8lxhL9qbvobwwjp6BQn+3XYKyiULu7JdZNs6d6+0e4+8BErs/fO3Fy5XL7KXqJ9+QPjuyIbLVkb1sDnieNpd8E8LfJSJ2hCowzXINAY2O0sZaQdiHbIEBDNwzoAjTjPKpQ+v4dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(136003)(346002)(376002)(366004)(2906002)(66476007)(316002)(66556008)(66946007)(38100700002)(8936002)(2616005)(6916009)(508600001)(6666004)(83380400001)(5660300002)(6496006)(86362001)(1076003)(36756003)(15650500001)(54906003)(107886003)(186003)(8676002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OKJddgATP3+0iyIS4d/PM/oU2Cl2hGUDMb6nxneXsd6EDt6Vh/tHtM2ZMy+i?=
 =?us-ascii?Q?ygxsrWpb40KNJF3WHpT3emUl+Zbo2+wNY95eEDeNpVM39xIN920jNNXxuMta?=
 =?us-ascii?Q?kau/A5S4woA+kk5jgqof6ctQHOrbem1OvHekb+rd3MPjMQa/tR9YJoTh8RXq?=
 =?us-ascii?Q?6tqJpPK33n5yss0zr8UMTptyU/eVuLwDL5AGTsqdk/xetDIeQtJnEmVt/tZa?=
 =?us-ascii?Q?QgBqAHaWyh490FIlcL67tbaPbm6kG6jd6iu9gCDfOXpuqlEHo9rkea37l3I+?=
 =?us-ascii?Q?SgmFt0MznebQhCYyS8nsLJ3EKUCxkMxsFDIr2CT9kfVKQch8w0O8lk0tJw8S?=
 =?us-ascii?Q?G+JLxEEY1mxITYTcSxqxtlfaKz9A43ljdlClnRu60m+SA8IQfMVz8teRfEK7?=
 =?us-ascii?Q?dPXvZt5n0PDXk3xA0/l9w2pdYkWN/p9q3xZUTibX1dxUZxFrvDoyj7KgS6aL?=
 =?us-ascii?Q?KXaH664/OmoMfV8+jgqYIk22Vx/p2fJxkpb5Xh0PjDzlqS9nyAXFifiWMWNb?=
 =?us-ascii?Q?BjsdLII+iH/Xk83+AJs2aiClT/mecYCe60YAuAFzngGSjFaywges4i5pKc56?=
 =?us-ascii?Q?J9L22XyLhuKi93hmkaMAbYyX6dDZAWQxUZF86Q4rNCVcoch0qcH0OMJURAo3?=
 =?us-ascii?Q?RqjAxZdWwxkVpXhBTuh7FLF8mrEf82n99jxRIqFnOs4hy+Z2sgzDxvnY2m/Y?=
 =?us-ascii?Q?+bFl+7cOZHVluc4sTJZJus9jD8IR8ESyIt0/yg0D+ksSk+E+m/ty9x57cqAH?=
 =?us-ascii?Q?d8bSKrRsp20LrzgcQWIC+PmMxik2Z9WOtLsfRej+aGzvFB1ToBteHi/NPtL3?=
 =?us-ascii?Q?lbiEMvyrBL/EHK/pA312wLLKcaRQ3yl/3ktAM1Ze3BtsZlU1FgWI6mEzrsde?=
 =?us-ascii?Q?B4j2WhcM31TRiywE2Ov33IqM7Jg0iFTx1a7dDf7Q8eB38rWoaexooMN9xfYj?=
 =?us-ascii?Q?203QMDrJhcR/f3uBmMb5droOZecTMpf3L9CCafOaG/FwMtYKBsPAR5WlfRZ/?=
 =?us-ascii?Q?NMan08g0/3dFLjGY8R+jsKuDVrXDPmK+u9jxd7gJGSMbXGHPdr5d5ZoYJEoC?=
 =?us-ascii?Q?wC8Jjb9NY8jOOW/N6gMySTdPKVmBPsVa6+6HB4QvlvOmBuKC6U2plRY5+gn1?=
 =?us-ascii?Q?Mv+IQT9uD3cHSMgXPXtf9VJo7F1WX1H4KCT975fQzTWiIpBdk4Twgg+hjSU5?=
 =?us-ascii?Q?VdXo7/mOV/8NPAD5GgdsxYAE4d9IQUtkZjErsPEOizKha6Ibd7+dSXiIwECq?=
 =?us-ascii?Q?POmgYwDJDVC7luM/+jGkPbX0hw3C5i4m0QAitehxB/UAj3OwkV5LFUOBt5od?=
 =?us-ascii?Q?WtJAJyKU6PYqEdzFX2Dic5nEzDbXF/GW4GA1JNJQv70gk/jcWYrHmVdW/72D?=
 =?us-ascii?Q?qPiCmLgBp6X/rR0JCwEvQ5IEVu5kDh2ad9cB8v7/3znwgrez/69cACsA9SiV?=
 =?us-ascii?Q?WPq+oCmg9WKuFsslK9XZWG3H/boAGYjowNvjdKWQvESfr/ENUFZuXkSGAqmi?=
 =?us-ascii?Q?uXIWsBuex8KStJb9dzrDkVrN6OkCpmOnNV/bU7ZAsfnQAdKgZKRv9OoekArN?=
 =?us-ascii?Q?vGhAbonnWeKLfpl7zIahSvB8CthrzWrnubgakii8dE9hxxR9RngZN+gh/Tqf?=
 =?us-ascii?Q?OPkG/dN+6N+T9aFdJSBtRdBqA8zYM2iE48YpzpNvPv18y76ckBr44X+EO3om?=
 =?us-ascii?Q?LyOFXPXMfoiTiWqaJbKwbxXI1/ddjpa8+DfCa88UPL+VIdMoeXYbx+UOJrRi?=
 =?us-ascii?Q?q/uXUUqeRA=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f645840a-89a6-4d31-e5ac-08d9b40b4cce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:11:27.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJvJ41DPWv8LInoGrPASM7k8zkNqDTalumXMZNvAaS6jBWXl2DeM3AWzQE8VLiyS0+YaNl9fTsC/PiAIpjcPbflxmRwuur+6CuSYvW8B6Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4238
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Fabian Stelzer (7):
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
 t/t6200-fmt-merge-msg.sh         | 54 +++++++++++++++++++
 t/t7031-verify-tag-signed-ssh.sh | 42 +++++++++++++++
 t/t7528-signed-commit-ssh.sh     | 42 +++++++++++++++
 tag.c                            |  5 +-
 13 files changed, 341 insertions(+), 44 deletions(-)

Range-diff against v3:
1:  9f71fd8639 = 1:  c4447d30f2 ssh signing: use sigc struct to pass payload
2:  5ee143bc38 = 2:  0bb1617529 ssh signing: add key lifetime test prereqs
3:  3183e84e2e = 3:  f60bd1efd0 ssh signing: make verify-commit consider key lifetime
4:  e35515867c = 4:  5fc0ad5c37 ssh signing: make git log verify key lifetime
5:  e20177d950 = 5:  f1c225871f ssh signing: make verify-tag consider key lifetime
6:  2af2b6d098 = 6:  1cbd4dbb6b ssh signing: make fmt-merge-msg consider key lifetime
7:  e6e2236a52 < -:  ---------- ssh signing: verify ssh-keygen in test prereq
-:  ---------- > 7:  d60f4ec82c ssh signing: verify ssh-keygen in test prereq

base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
-- 
2.31.1

