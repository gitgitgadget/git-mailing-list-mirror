Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9B7C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhLII4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:45 -0500
Received: from mail-am6eur05on2089.outbound.protection.outlook.com ([40.107.22.89]:26977
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235376AbhLII4k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfkSonPIZGaVEpsOBpzIeb7mbKf6Oa1hsR8r2ZHlM5ZOaCigYv/oOuPlQC7K/hg23XmIowapfEQd2wTh4ytddfGVMlQ38FCYDvSG1dppcRQFbBWjkZ4qr3HLhSy29hpzOPHzJdovx7ZnJmJF2N71b4a24Qt+vATQ/SN1hC1+745IoheroptsbazdATVBhuzWhWI5XyKREMqhQ0LYKUPaxOC1t1chFmPDZLwNAvGlM9ZSSLjQRT9iAGGDuORveI4xZCY/BPgGwgvr+XJl5/oqcfR9+KiQa+bfl2xwTHt3lzoSAPQTDruW3GgLQjMtMt+xwyyIjnk2cXLiF0YjPYwssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=fnnP3lKyuHyvA79bNdwvu922GsJKELk061J4HxLJvQVlmxASrK1NI04u2OLuWOHFC+jrVhPyxVmPsSMMM52vYhB1bUaKlP+NvoAV+Y7MXcNhvSaKVa7SSyDf/+Yuuz6X+V/tY+rdGLTAT68yR81/8H3TsU4x3AtJxNEQehaIjhTFImFDJIQfZAlDuqHjXEgGOV27PmLdxLFnt75/m9hNcO9tw5ZiKeSMgH/EIzAZ0u3PCgOkrQk9DRe5MBEhR6gwriUUGyau/Ktw/S73cJUti709uZGZmi8sMhExoN4tHHlVEh7GT3qsu7sqnlKiO4nMJG0VuEqMLRB/pqTtGtGiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=Ope2DOQ3mmNFEAEeaJSZ9kx38t4j5rKeBo0glmLczlw4Ac9bBoLx3oZNH+RrgD/TVPbTKHJNYhaJgr/2Wfn4xv2ArZJEnkKSAfEEXWoTesP2iaPnYD3LwYIi7Af71AaVI1dhxEsKnR1v1Gs0qbIK3iy/f02UEZtTYjttnZsXP6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 08:52:58 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:52:58 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 7/9] ssh signing: make verify-tag consider key lifetime
Date:   Thu,  9 Dec 2021 09:52:47 +0100
Message-Id: <20211209085249.13587-8-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209085249.13587-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
 <20211209085249.13587-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::48) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6PR04CA0071.eurprd04.prod.outlook.com (2603:10a6:20b:f0::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 08:52:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cfa0e99-2e85-47bb-7f52-08d9baf14cbf
X-MS-TrafficTypeDiagnostic: PR3PR10MB4110:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB41103C71C951E1D9B78E1211B6709@PR3PR10MB4110.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:54;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6hVACOrFquaQzt3Exc4id2bch3A7zL/jtkTV62YhCJMO+8Nz9H8Os+tiW4iobznNTxL+Y7ny3EA09Epe0LeervfL0tNIwPMfZbw5YochMQXE9yNylgV8/7UGR0EJTou/JNn4Fh3KeqsDCVTYPX88vjKS39F/tMrOrhAKJvIXkVnmml2FJDv1nlJTiV6Gt3rRpqHonYLR1pTeSspU+G1mC28S0KkkJEZ8L7fqScpdV/pCJcdjUp0iCUkoRJ3KLdlNR6tSQgDjQi0cPx8IGIw696Dp38uiHuzMCayoLuxSUqzJdB2pvzRXS20ozbBrt5iJBp7AzGA9cRStIDnnlbLLVVgtOl8y+pF5ccY3gBLEAs+uZv5sr8KJ8mlGef0B9aEv68V9KHMizP4iuTaC9l2OhRtDCuk6Q5Oas0dIezfW8TYYOSDtvND6LC1yUEu4ijRctOSkcQUyKlI/EMYDIz7uGPZNdDYAA4UJR++3Rv2dAU0tOMA1MqEseZ75iwfTdaHVmyGhFLufOTyMRxc0czglxX61oWPqt/H/eAdtYaYXhsPIEiTnPwSyNneDdSuCOOhZIUN5IcQxB6gyw0sPVx220x9Oav6Bk9y72Ryuvvl8pU7p5xJZX3TpkQkAs88k0x5C+bdp/oFKAAY7lYkoBmqig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39840400004)(366004)(86362001)(15650500001)(36756003)(8676002)(54906003)(8936002)(316002)(6916009)(6496006)(6486002)(508600001)(66946007)(66556008)(66476007)(186003)(4326008)(2616005)(107886003)(2906002)(1076003)(6666004)(83380400001)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ywrnx3B+NYZm6ZQtCVCcAr40Yh0wgGKPigWuxDDCiBFx3MFFXmOsxto+uhQn?=
 =?us-ascii?Q?yOECEvoOKm/7tJEc24O/vwi87ml62kZKyNnlgYZ6Pch45j4U3fhIKv+0NEji?=
 =?us-ascii?Q?ybtOMsFcrrxz4PqcI1C3P4VKavrdiYaZt6w4FEMlb6omDzHlx1ED+Ow67QLP?=
 =?us-ascii?Q?CQzJ1UQRB9ikuun7DYdt1U/vpozKigtCfnwsjLlJs0hQGQhiFm6AgQE3Rciq?=
 =?us-ascii?Q?c+GVm86018DVgDEkTJOwQI88y3wGe/Hsnae8or2fMn7LsQN1i/QijVkyOlVd?=
 =?us-ascii?Q?RS+q+kdLcgC/rIg3qdjCMc3UzkaQIMhPvfppqCGilrLgw3jh5sRc4rXA8lg2?=
 =?us-ascii?Q?AhXYuGrzX/hFf/Vr8SMcRGy8tea5igDXAkrH4hKRAEz6kki0s0Uls/wa9NdC?=
 =?us-ascii?Q?U+1b/ZsBJG3WIQtJMWbiH+/+K1VYRQmRQzLG0RgAV2fvdIfjc8MHL6RimnxA?=
 =?us-ascii?Q?OhZd8CW7rcY2iLCc5ZCrdkHkMaXK+DgvDCQzsKajr3bTn/1xI8MGbZ/NsOxc?=
 =?us-ascii?Q?AR0ASgGL2hkTXDA7T+WeeW5CtePyyeLo1PJzd2rJjyp8Lt0c0ixrEIvmdYML?=
 =?us-ascii?Q?M2GFS2TTbHv5ouOtP+I39TEXhTmVdSD4V5LVskFapo03Dh/wsHAuHbJ3UtKs?=
 =?us-ascii?Q?QEkDdddSKkhhlUAcFutFbdTe+HrD3bmSNBjp45E/Nw985u99Y2OqeseqaZ8c?=
 =?us-ascii?Q?woaErFOCwLuAyzTOyoCjgAqkBbDfLSa7wB6oD2NcQoyznJJvPQjM5gtQLA5F?=
 =?us-ascii?Q?a+E/MqzHyc2NJHT5aI8Sqb9N+y26QWI4ahiV0mS5pVhJdfJ8prZ5Pcv60ahf?=
 =?us-ascii?Q?4PH0qUybHPMds0VfswApMcNsPjiPT4S8QD4YvK6kgJtv3v6bvy/yuF0R4KMP?=
 =?us-ascii?Q?Ke7Ccz7V8OqI2Ac2POQEIkdLEUverKDTpQdlPqUNycl57R7CXVYJIRIFYHUO?=
 =?us-ascii?Q?IL6R7aUFnRPev99107aiz7gG5DhZQp64V37E3OyvVH15L9kOIrwnM7UXmhZv?=
 =?us-ascii?Q?BRT97T8zGhJbPd5+dqPFlbaTwPaSlxQiGvMueWLxVa55YIUuyEI3AdBAZAyR?=
 =?us-ascii?Q?/SZwQnZG3L4qOVVTKO0BSF0qvqgIqJblZp1zs6oE63/2CiuMcvvBSWyNIyfZ?=
 =?us-ascii?Q?Hi6Kx4e/J4w82KkkT8NluXZ5MlM85EBIzz7DKSpFOO5tbDipQwEUk6nCZkcz?=
 =?us-ascii?Q?y1gQKLeiEHBpKej69BNI/BJ3GKL7s1osZo1OUzQAV66O6tM3ww/0tuSFr+kJ?=
 =?us-ascii?Q?kG2E3G44mIHSBNAT2aqGLcGf9mAtZqAqBsabQHDY9CPznDbx4rAzgBDW+5oA?=
 =?us-ascii?Q?NwICCPPgcIz/J+XPcbpcxOqNVrbKyLuM+4a4R+aabt66lrVMEpN+M9ay/xw6?=
 =?us-ascii?Q?zZT4//VM+c90USrj6iNQmRdquwEzjWHg2kdahr9PQTN1UzeYrO8t7aw7IdzA?=
 =?us-ascii?Q?rD06OUvzzFmcAXF79lCmmH7/IEJqiZsdFxDtcIx9kzh+iu/uPCwprmMXRMhG?=
 =?us-ascii?Q?sTdWQ2Lep1ya6sjspf5+FjtlFhczj2D5dzA5DmZWMhC341D/St3kfXLFbQ8v?=
 =?us-ascii?Q?KYAhaO6uB5Yg+IOncyx5Qpzb1TfOhw8zrDsr3Pdyhcs1+aYnDbGG4Ymi59KL?=
 =?us-ascii?Q?/4d54oiqx3/sFVVPoW6ft5ApvhBm+ZSYLMt8UxSPD0Vyxv/UFHl9aROddv0l?=
 =?us-ascii?Q?+pRhpofIxi9DOq6+D3b227YhWnuSCIB1qpOPvc2WyB9zM/t936Mp3ey9KTkm?=
 =?us-ascii?Q?Gm5I6lbQOGDNw7E7Uk4cI4MLAO4dgrE=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfa0e99-2e85-47bb-7f52-08d9baf14cbf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:52:58.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXXFv4GjONgI0ehNax2N4E1exi7qT3IWzHFLUFF8bsinkuiN3UX3n6K+ujQAgnzDbxRRE4pNIpSCbjwBn6AVpLLeSCGa0rAfNP8dQIEvpyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4110
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the payload_type for check_signature() when calling verify-tag.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/t7031-verify-tag-signed-ssh.sh | 42 ++++++++++++++++++++++++++++++++
 tag.c                            |  1 +
 2 files changed, 43 insertions(+)

diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 06c9dd6c93..1cb36b9ab8 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -48,6 +48,23 @@ test_expect_success GPGSSH 'create signed tags ssh' '
 	git tag -u"${GPGSSH_KEY_UNTRUSTED}" -m eighth eighth-signed-alt
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
+	git tag -s -u "${GPGSSH_KEY_EXPIRED}" -m expired-signed expired-signed &&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_NOTYETVALID}" -m notyetvalid-signed notyetvalid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDVALID}" -m timeboxedvalid-signed timeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag -s -u "${GPGSSH_KEY_TIMEBOXEDINVALID}" -m timeboxedinvalid-signed timeboxedinvalid-signed
+'
+
 test_expect_success GPGSSH 'verify and show ssh signatures' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	(
@@ -80,6 +97,31 @@ test_expect_success GPGSSH 'verify and show ssh signatures' '
 	)
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag expired-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag exits failure on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag notyetvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag succeeds with tag date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git verify-tag timeboxedvalid-signed 2>actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag failes with tag date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-tag timeboxedinvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPGSSH 'detect fudged ssh signature' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	git cat-file tag seventh-signed >raw &&
diff --git a/tag.c b/tag.c
index 62fb09f5a5..dfbcd7fcc2 100644
--- a/tag.c
+++ b/tag.c
@@ -25,6 +25,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 		return error("no signature found");
 	}
 
+	sigc.payload_type = SIGNATURE_PAYLOAD_TAG;
 	sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 	ret = check_signature(&sigc, signature.buf, signature.len);
 
-- 
2.31.1

