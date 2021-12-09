Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA200C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhLII4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:40 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:64384
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232964AbhLII4a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbzZSshMhSO8AY+pXMl0iddR+uTZGQ1QTGtc0GtFAD2S1WezRdR7MfYfNytPv5abFRNxEnID90C8yAwSmjH0gpVy3iysgYvwChqNllQ0Rgf8qxgjLBn8AD1uRGtor0iSF4SzpwPPwoccwyeShd9IuFzDf4CURPRbKEzU5HFwDnkVG6zWB0KKm0Je/d1g5Vt6uJi2pncvkFGgouf/Oi56G2JwwwWDla9DKXyOV6q/pZocDVmShkL4U4HCrixxwAtxpRrKNfC76zSIWziNpGH1kOyx7mgh6/areYgqVSgdWPLuKBpVlRj8dNPAEzvNbOFnAVf0UbC7SVSIMTToAb9rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3sccrQyi7gwNykk7BAg8YyNI3Nho2xKTBAsNPAwDAE=;
 b=aPV32kHrehcMn/eXayqWc/Y39Wbdd5atDI6AvCSpurjFC2aNlJTsygPUMv/AjPh5sdf9vAUwwfzbtvhpxXd5Zs1cMaDIqZatfv+BpWASrFh/VSpeah/w3as6gVh4R0gprW02l6lG4uNbParIVtBJkrBgp1MS+R5+/Ys2OHKZTS1dN9yoyLCVj/hzXT0YAfYP+ysAWSIfPdJ4d3QQhHHJuKFo3oZhzyLTm/hQ/FB7wUfYxXZYnnJfhCfb/KP2H2V5DUmaq5NY8usEnqyq9BI1D7gy/yOHflrepOv0gb6VsfvHOnBPKWWTHnpFOtirr4qkrXvEyv6hKJhgV9jQQTx0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3sccrQyi7gwNykk7BAg8YyNI3Nho2xKTBAsNPAwDAE=;
 b=f+RRfb9OidUACr7NFqMQxZJrIgK7vvZ0mQkbYny3xcV8Zn366d6/qbCtkZQEBczFJVXOWHKTXztnCdqauVc6Ut/C03I3Jze427wMNHId9uz2IynyPBesF2bEXOGuY+Rn0XGWA7L4OOK0ZtkhEVP9GoW62du81zYMlTQJw0UISdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 08:52:56 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:52:56 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 4/9] ssh signing: add key lifetime test prereqs
Date:   Thu,  9 Dec 2021 09:52:44 +0100
Message-Id: <20211209085249.13587-5-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209085249.13587-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
 <20211209085249.13587-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0032.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::30) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS9PR05CA0032.eurprd05.prod.outlook.com (2603:10a6:20b:489::30) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 08:52:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cfe5e71-ee3f-4aea-d69e-08d9baf14b13
X-MS-TrafficTypeDiagnostic: PR3PR10MB3851:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB38513118A991947151CA7A6FB6709@PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/XVqbH2IGbgSJ/0XWbQy9VvVGG3cI5wlooU8ueLe/lg2rQneQ00K3FTBwnBy93Bvwe+VTAG9JewKijZfueAj4tRAY+b118g+BayWHMSnMt1EETh48yskj9dL7g50YEEMRJSyxJ/IL+nlzZU5Vc/7jAVRhmUTfKhl7BIahQT2rnE2lNDmFhXm/w+AWhCfhIAolBBB8OuMPyXVuDubuvPAEG1Xkl2CRls097beABPciL9J5RpVomKUdKCKS4DmFXdeGMJFr0IMEOdl6s87e9VJwvN9aFT93sGtIS4yG4HBSXgRnn9q0sTq1vc/TppJpU83H9aZ6NDPjSvLiSjBp8+1/BT7LhV/t47gruFdvM5BmQ6y7UjIH1ZdF735C2BBtl17PAV23wq15we2z/Mw9J/fIc82YyYpLbDSdYjHtKj8yJaay120Ls7qw2VlfMNBgEJ6/R/ObCrLtb/eE+FhXtzrfhmdKNi6zfRqrN7LqIKxxIlz/H4rmZCcsFAHvhoaL9IzjlDejoq9544RGIXkYE18/Gg7b36EH9vFzB51AwOHAIwv9w/huVPfFWrLG6SBCz1gihZOPT2ZkjWKxbBN7LmuuySGp8jdIwHGEKOiztSiN1EcVdfoWjjglziCpkf9W0E4gCRZohEqzK3AEmrU99n1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(366004)(346002)(376002)(136003)(8676002)(4326008)(36756003)(186003)(316002)(6486002)(6916009)(2906002)(86362001)(1076003)(6666004)(2616005)(66946007)(6496006)(38100700002)(83380400001)(66556008)(8936002)(508600001)(107886003)(54906003)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aICoys6zFFnx6yFwf09gSkUhyYvbiV5ykfkntr//vNp1ahV3+mRKUQAMCzp0?=
 =?us-ascii?Q?9mHVbXTMwUb9CmE/xrFzIWgN4/duo4uAGeKhpwHNl1ZceXukY7i9SseIhovp?=
 =?us-ascii?Q?2VduaHbxT+86PhjB3HO2g8IkYgZidOsP4hZrlAY0d27MgfxMmesyR+FNcB6r?=
 =?us-ascii?Q?uoanHaGjuxCgcAlJKuyIDUKvaT+ycTPpe6adutQxPQWXsGGI9SSRH9rYxC2X?=
 =?us-ascii?Q?hE8XJh0h8VL6K6tmQWkcSqatCxfSL5Bm9P8+wnwDqzZU+s+rr9HVK5Th9+v2?=
 =?us-ascii?Q?rKDzsuJ19xLR+6fHBDVLH1F3Br+tEVJ/lmOTcH3+oYVvHFN88KwkRFP4lTC5?=
 =?us-ascii?Q?uQ9MxQ+0MdWWEV24BeBA4viz/QKXjh0cJKsPyAJVIJj4zWQr5HTl/ynjIFLm?=
 =?us-ascii?Q?TwDnWoj37fhrKxWp+ZSmWLVoqVaTsC5FKsIDOIRRU5kTikx/zFvhMoQVKWEV?=
 =?us-ascii?Q?V/uSLvk7mssj6inZQglHpGYhvYctsHzVBBPtKa+VQJMgursq/VPPe7oIvYti?=
 =?us-ascii?Q?cXYcF6a1N2PvpeeuiTo55QYqMIaOc91fPsaaCifzlPHn3XY5hcupkVBVLuTH?=
 =?us-ascii?Q?YOLYHd8rG8GtvUn5xTC0ccxN/tD6QObqsgkFPP1yPK8O0vuiAnrZDjNYCx8O?=
 =?us-ascii?Q?2uCF8ogw1oOb9DenJcNO0XYsAyrTe3WKBRAvM9cTOvv5nqDCSQDTwIWBGYqo?=
 =?us-ascii?Q?Kah5Xuj+aalBsrtAusUFAueFgrPBXORojIy3/fT9QChHwvXBGQ/FK3rRzVr/?=
 =?us-ascii?Q?KFh7e/xGU06FiPj62RkrGWETavz3AlOsiiDkaZzV3Ew5xF2eMpibCJ2AWcJF?=
 =?us-ascii?Q?6U+madtO+wXUBiof7lMx29u1sKtHiEqsTTu+aQ3ZsT2mma6nLcCwZOkbmIYw?=
 =?us-ascii?Q?nwdUCyJtOQCNJvsDb9wjaxXWJCRgdW0xSHSrchJHbs31q+v4bngv95B8X7B/?=
 =?us-ascii?Q?v381xgz3X8zDmI7PDKy4pkTn5ORunCgalnVZWQV/otk/Xnng3FA2cmJWw0vk?=
 =?us-ascii?Q?AIDWHGl/hU0r+hApse/ItOmEF9YdZWCoWPi+ndhYWBK7wz0Cpr9feEFzRyuD?=
 =?us-ascii?Q?jNth1SCopHMkloQNLcyUjNsruTwlB+UXBrDm7mleaHW/+YQ792THGEAZHQC1?=
 =?us-ascii?Q?yZOZGJQv3vcNONGE1motrutxQQ/FG/BatvOUyMAYS0vt+FtJ0t9OQaT6yc41?=
 =?us-ascii?Q?tfGp/jK3aYdrGZx0nbn6kVt3xqNSTPQQ67KAuWppSFpwWdmo7eO92yRGfgIO?=
 =?us-ascii?Q?FDXwwx1VdtJcqVTW0U+HOr/EmbyGA6Y0OcbRcQTNwO8vlFTcTZaEfHy0DC/c?=
 =?us-ascii?Q?v/4HVqDz+gjnvdetNu4W4H1cEAhog+hhLCBy2ktbEiqEX2ZzaH+mVrmGpbvg?=
 =?us-ascii?Q?85/wYY5VdXXGejVaBr/VJO919OArFW2EKduwqCnQeL8m2Z2L3tHLlt6yoPoI?=
 =?us-ascii?Q?KAfQq+vAP/rmYvvEBXGkGCyNKGrbeWxDGjrcqfGrjPNECr5ZNf+ii7PFbpOe?=
 =?us-ascii?Q?Pogr44mRd+Nxv28FO2ewVL0DUOWBNCnZcTcQmtxQVHh1PDvgZ2g9ZXbdNQqn?=
 =?us-ascii?Q?VVE4aMOfK+1cyn0U6/P4lxaPGUTw1xX3Co4cq7iw+9b+pdZJoEF08y7tfGFU?=
 =?us-ascii?Q?GCXs7UwbTLvyWeEV3NB/Y4J8M5Ro7tsRxsU8keAJL4BskwwMhQym6sLm1b56?=
 =?us-ascii?Q?zvWTr1BbIAoRE+NuZ0D0CB7YRgxmg5so7cV2RqrILwavQ1yPu7dmOAIg3fmu?=
 =?us-ascii?Q?4Sx7cixoow=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfe5e71-ee3f-4aea-d69e-08d9baf14b13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:52:55.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF4BP/Gi2Ny+nONQUmAUVVssv+qnnLRQb1V+ex+LHfXY0ZM82suqXFynRBsvPsjCvlggEWQ2PcyFdNSA+mHCK9LqSBoQxI0E6CEt9qhkIWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3851
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

