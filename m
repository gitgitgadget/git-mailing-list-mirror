Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A05C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbhK3OO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:14:56 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:8481
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233591AbhK3OOv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:14:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GelnjGl9OXfVyjiYsDYfDo2kDC5rqWzfXscGKCnz2gp2inPuf+JVZH9AlAOSnBJFWQZYpzYa6L2cx3lZ7Wba4zpurEljQNtnkUDc5Ynuwbtt0JiiRJLYOQLzrZQFkEEWanZNoSZQ3PCIcVcGw+HDlq43d3d06iVne7NTnUTegw10PiUrERCLXlkhRG/lhj8j41QEhe52X+bTiXT+hUOXrN3eS5P5A0xAAo4dTP1dX9qIX3lzrwWfYEdvvxofgykqu84tc2VTuH2ih/GeWf5uGPtUiNwtWARMngH8HZS9zAoMs0/4p7uOj7VDEElbGeQWEmbLuQ8HbRg7fPrgMp3dhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3sccrQyi7gwNykk7BAg8YyNI3Nho2xKTBAsNPAwDAE=;
 b=ocSneAqiI2hYZF+OUAZ6NwhGpBKY8cj6p3Ge92DfrpkBZbXsLzBPozJ+1hXJinUsB6QOR7RSqUPMEsPG1ajGUSs1IQqMKLpTOZI6it5QiNXCLToaDahlZYoBYCAskdYKghIJGraLL67ZTc4GiAuRdIT3PBZmK/V6WnycEUdddMT16mmu+9Nyl7yAAAOB+nBYZIYxch80DK4M5U/dAmtivaOxYVrI5DQrAa/K96qrIyH+ZmptlORWx/UY9lgpiYayT0ybKTvLvi98AxJcSczVGpYJAZ5rJpK1hBnw6b5qAJzfy3wdkxNQQ+PUj6XP8yTjIw0CqUUdFaZgHWc49Fv/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3sccrQyi7gwNykk7BAg8YyNI3Nho2xKTBAsNPAwDAE=;
 b=uKOjzeZ7bHuE68y8cpNvHisHaTKRCDvj3SdHg3Zzm5U9u7+A0y5eENBsV/FsefG2ageGDXYQ1KuY9+PjHy5dqUuCONvlVGL+tAkcqigHgh6hRJrvsylu36yIET1Y9OnJ3lQH2a5lkgieyLmAJBZzgfeUyJE7Hc6Laa40iWyYnSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 14:11:29 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 14:11:29 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 2/7] ssh signing: add key lifetime test prereqs
Date:   Tue, 30 Nov 2021 15:11:07 +0100
Message-Id: <20211130141112.78193-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130141112.78193-1-fs@gigacodes.de>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0039.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR0301CA0039.eurprd03.prod.outlook.com (2603:10a6:20b:469::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 14:11:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9e7c856-2777-44ec-fdd1-08d9b40b4e02
X-MS-TrafficTypeDiagnostic: PA4PR10MB4590:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4590CC8C4A4D434044582426B6679@PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLPpEmgVE/lCKnm0kgOUUFWJx0QmWm1AUuznWWrTx0ayMtjPfFSqfYJGsWhKb4Dt9nEluRnQpzRASXfUM/POKpWcYptguMOeR6ie3nBLBOQHDGJyBdUc/cCf/d1pMbcQsnHAwJTAGYOdm0c0+HsEE7Uy6ykMItzl9/J8CfKol2hT1j4H79w3SI8Wv38IqTKNsh2aHWhiLvvYjdb893rpiostyxlHzOWf/g73O5You0lBrHpzNFiGhesmQRXjIQEm/A+cULCwHcRxx7NQNqY07qPISlkNpjMuCgpRXekRjkI1CBSSzXWIbRZa0saUrv5msh7gLQdWBPZG3ULU8nOz7m09K+dD7Eiz6BMzD+of3EHdfjfB3TrHxmyD3GNb8W/O7qG3WW8TV+sDSowqK6WubySR/qlQAe9ULhb5cuIpCO1k3WDVfsfwfAs74p/fuGzWJEeQc43JXth2yc6CdOhwl6KCFoHrdLPBNyKAxYejg/8bYt26OqONpfCzs4XYk48uU4JlCSJBFVplh9HkSz4jpjkWwaDi+08QVDPIv3OhVwfhrCHtA1WVjVAN9MIi11VCewz7gbblmPk9+pPeD0/Fl1gvehOzXUSoB5MRgfXTwcKmxS8kNarR6sj7oRyxQsVARzfLEtF4L3fgkv39DQ51Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(396003)(346002)(366004)(54906003)(186003)(316002)(66556008)(66946007)(66476007)(6916009)(2616005)(38100700002)(5660300002)(508600001)(6486002)(107886003)(6496006)(2906002)(36756003)(86362001)(8676002)(8936002)(83380400001)(4326008)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amJGEuY6cq7WYCkjtgRboGX5lB4whqey7Z85kn86B/jHITMQUmCyrwC4IUMj?=
 =?us-ascii?Q?NcMVuntaeoKPLF+fzcIZCr0WEFo7Aw3cbqlzBRwwbdDMGp+gOaGLSRSYFQxp?=
 =?us-ascii?Q?9AzbXPZxYqYw8S0X1hYz75jcVW31Hy/lqpXTC8rX6NDoDuDXqFS3QpASA+lK?=
 =?us-ascii?Q?9f5SpBo7QDn8Zy1qU59Qy2cq/IoBmiLoq+bPBdx0soSqqQMEx9EwdGAzvbFW?=
 =?us-ascii?Q?tpTH30zgig28d++lFL297suJ4yMXDjyeWaSvmm8de1xVNqh+lgHzEQaGZkCr?=
 =?us-ascii?Q?k8jHAESzzHLnw/LhLZuu5WSUZ9WWJDLr7RVLVyttXJXefc9a90CL/L1KZYxf?=
 =?us-ascii?Q?gEJxOKUon/tTD8nYQKppsgl24QyzVmBWnTH/g0bRtGpgx/x8YL9zsHRVf7Z5?=
 =?us-ascii?Q?+gtJe2fHN8m+o+Q0e4xxRA35bGD10x0SFMP/258A9X3i3QsuLgCHB2YpUm2X?=
 =?us-ascii?Q?WlWcnOY76qqv3FJtVnizVLxKD4+uwZ8X0TvBxhuOcw3VDanNldWMpnWVRfjg?=
 =?us-ascii?Q?XkJyMlGkWMPoyy1KMdCima/AZ66Dxr5HTYCR0KDuuY8Ekrl1NBTledHFZG/V?=
 =?us-ascii?Q?AKsGHy4CygYVORbLzHx4qlihR146YsuG1G36phAU3qmiLWQJc+UAKb379KpP?=
 =?us-ascii?Q?V/NkZUFLc0RzzKqO7XIr+UYaIVjIpml2Hjh4Eg1+5FBgJq3QjddZfU7Bp3te?=
 =?us-ascii?Q?lCGaSui5ZFQC6LzS/In8BtTUiDc4Bf4LwJp7fMeigSVi92z2uenG4kH4Uan3?=
 =?us-ascii?Q?Fc7JKFHT3BtHNvAo42JlAkFyxnbZ+eJ4e+x0SjkAN4E3LncbepwWq414M3ye?=
 =?us-ascii?Q?FlNJsnUz5lT06krtFH+q96WJiBOYER3xL//Ksholmrrc/126yUdL44mx6JnE?=
 =?us-ascii?Q?kj8i3Zm52s2tdqIt9x2+JTijSgShA+sC4DE+5BQPHBrE3Tbp0oMl+JFUP+WP?=
 =?us-ascii?Q?caRstzjBZGVDj2eGSXQP0dwzVEcRTDjrvBYECc6uKeQpJEQlUUD1o9Uyi+fH?=
 =?us-ascii?Q?I7wt0NoSmPNEa6ww4BmDA/tCkXam6S7Go6h7cXMM+WYNEx2Vv429p+dRdUHP?=
 =?us-ascii?Q?PCUyUD5wYS92+qMg2Hngr9LCSiI0WbjxOiyRz7dFuc34a/TnAkQtN1GXgdUf?=
 =?us-ascii?Q?yBjN6DPQsE1j0wEjD4YY6Q1d21ROoZvePtJA5ATJETT3PSTk6ipPM0Vxs9RB?=
 =?us-ascii?Q?jyQ6OeS2MCl/0xGd+rUatwURylcQKAtCBpv43+xmB1Zgg8qshnwBahk3VfXO?=
 =?us-ascii?Q?49e+P/cB2m9zaG3JJya7Fgrvtf0SymiOJkZ3wQlFII0cr9/WW7QUIRYj0uFM?=
 =?us-ascii?Q?weVUq927XWv12Wi6I2c5qGL2sISQs5Il1BEmycEdtT1qaENdk4KRJEHzZFsO?=
 =?us-ascii?Q?mLOY5gSmZzyEJmhFwEbVxmfW1rvuXurrV1IN50SiaVjMGRepoZS5aG9Pe7nX?=
 =?us-ascii?Q?TUX86guJTC0eW0G4w0Uw6e713Ps+bumfP8Sw32ZiuytooG82mQhIauwHT96h?=
 =?us-ascii?Q?ddds5EkEXh9RnC4uZ0x/k5mNrbuD0pHQfdthT5QY26u12pjRWjg245sghuDl?=
 =?us-ascii?Q?3tOPfTW6lEKEVYnyCBdw82Ddo/gEsG39mrkRbYWr6xAYMP4rWssn+VcV8tEU?=
 =?us-ascii?Q?58MjuOdp2IDQFNvXPkf+bfAzfOVo4iH7in+39OMUgeRmzMAzMERBLdUC970s?=
 =?us-ascii?Q?TEbUbuGcuI7IqrE17QDPC0hbI5izmRwwkoSXoqIyWP3kV+h4Jcsn51zr6if7?=
 =?us-ascii?Q?Q7qWSydSPQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e7c856-2777-44ec-fdd1-08d9b40b4e02
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:11:29.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5yKgrZY+w4fto/XEdw5ad1sJb4DwAwk/ClHKopYyuK4fk+0pTQVj9QZNg4wL1iJ0M5vGa4v/5n/qADd1BPhjnl2DFyMs38oQEvCGeGgdO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4590
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

if ssh-keygen supports -Overify-time, add test keys marked as expired,
not yet valid and valid both within the test_tick timeframe and outside of it.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index a3f285f515..fc03c8f89b 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -90,6 +90,10 @@ test_lazy_prereq RFC1991 '
 GPGSSH_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
 GPGSSH_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
 GPGSSH_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
+GPGSSH_KEY_EXPIRED="${GNUPGHOME}/expired_ssh_signing_key"
+GPGSSH_KEY_NOTYETVALID="${GNUPGHOME}/notyetvalid_ssh_signing_key"
+GPGSSH_KEY_TIMEBOXEDVALID="${GNUPGHOME}/timeboxed_valid_ssh_signing_key"
+GPGSSH_KEY_TIMEBOXEDINVALID="${GNUPGHOME}/timeboxed_invalid_ssh_signing_key"
 GPGSSH_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
 GPGSSH_KEY_PASSPHRASE="super_secret"
 GPGSSH_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
@@ -119,7 +123,20 @@ test_lazy_prereq GPGSSH '
 	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
 	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+'
+
+test_lazy_prereq GPGSSH_VERIFYTIME '
+	# Check if ssh-keygen has a verify-time option by passing an invalid date to it
+	ssh-keygen -Overify-time=INVALID -Y check-novalidate -s doesnotmatter 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_TIMEBOXEDVALID}" >/dev/null &&
+	echo "\"timeboxed valid key\" valid-after=\"20050407000000\",valid-before=\"200504100000\" $(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed invalid key" -f "${GPGSSH_KEY_TIMEBOXEDINVALID}" >/dev/null &&
+	echo "\"timeboxed invalid key\" valid-after=\"20050401000000\",valid-before=\"20050402000000\" $(cat "${GPGSSH_KEY_TIMEBOXEDINVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "expired key" -f "${GPGSSH_KEY_EXPIRED}" >/dev/null &&
+	echo "\"principal with expired key\" valid-before=\"20000101000000\" $(cat "${GPGSSH_KEY_EXPIRED}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "not yet valid key" -f "${GPGSSH_KEY_NOTYETVALID}" >/dev/null &&
+	echo "\"principal with not yet valid key\" valid-after=\"29990101000000\" $(cat "${GPGSSH_KEY_NOTYETVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}"
 '
 
 sanitize_pgp() {
-- 
2.31.1

