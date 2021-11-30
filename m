Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB8BC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbhK3OPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:15:14 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:8481
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242019AbhK3OOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:14:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsxzKCNZ+jgpE283FAMO7MzAc1pF8Sl48iOs948z3G0ohzWTla2htGgBEo3QOUt+M1HhisHzdq8mZXKC5C4inhGGU4OWiDUzekPlCZHTcF7DZYruLb1eQB318CWrQ4+24dgN7muUx8f2gTa4oBtTdcYiHFc/SDM8ex1QB6xQfpGjhxoVm/zZtlXoUOqPJKH33ivvKkAvCM+lf6STbgS0phhElN9ROxg8pb9CDJC6uB1L60simjnITbB90WeQeWvIT5qEDcygVvQrtcXalzSAioNeNWS55H+PB4bKG2gDlMWSzfE/yEfV/EU0GTg4rt10yPg6ciKKqfn2rLnLf/K6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l9qmJoDiqvIXf+fkiDiFP54F8XDYP7oD2aRaUktoYs=;
 b=cke85Zmkgb8T4hG3B5p2uUayS2MLvdHkr5fjz9wKyqTqZk3xzaSDhyIBrXKSRyQzpunOQwUNsQHNPt5q35ciSS4xqEnxIQVMKkdT0gvwYIY/plh8B8xF5lthKgllvhl2imi6sFrpJj749hh7vuoCBkZrqebWjDNicxjxK2IPtIJT7QeW+6pgmS2U3UaNIgOoL0N5vRlAsNvNL0rxqMk4hkUmCIUvJQw/C6/ShdyiQMsGHKERHxKwkexW86aY/WOeFx09pzi9F5GtIt2A0hm2COTbWg0MkeNSELS0Odgojz1cOlvpoosEewvDt68FBMen1uxXrDRhT/mITfLyFUMKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l9qmJoDiqvIXf+fkiDiFP54F8XDYP7oD2aRaUktoYs=;
 b=Ak4e58cwxmRxe83tPGB7VlXjm5JGv56bv5sUbdGoDxbOey7j/32CBTuiVk9si04UmgL+E6lYQk5ouP1+MGMEGtRHFxMrDNTVkA9ganuwp9M7AAqI4/eLInyMOWNIPutozVOS4rH7QEkQKmjQZqrUyXAf87UXTCSH8JrIMxkk51g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 14:11:32 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 14:11:32 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 4/7] ssh signing: make git log verify key lifetime
Date:   Tue, 30 Nov 2021 15:11:09 +0100
Message-Id: <20211130141112.78193-5-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130141112.78193-1-fs@gigacodes.de>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Tue, 30 Nov 2021 14:11:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f886d4b1-6823-4622-37ca-08d9b40b4f5d
X-MS-TrafficTypeDiagnostic: PA4PR10MB4590:
X-Microsoft-Antispam-PRVS: <PA4PR10MB459030B5FA6036E0EFC1EFDEB6679@PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VN+Rrt5mwEA0i4BTI+KZYeQHcsny2H3Fsc+UMda0UBZqWUYN9ldtXqEa+06cMVX3PHVHoza65ZLyLtIvl8+guJKg4t5TCv4cu3CRtvWChntfhU2mhPZ4sIhlu5onTdXZo3iDP17L3Or83xBeIB+dNO0aLTessIoRGXSbVvTnuhuVaUH5IZmDM5bDrOqXknzEgPuvzi6qIWiTe32oPCWZOphgc+lCJ3AFG2/MrOnMlDCerlhtWaGOeqa8d0yvCtV46DYUvLGl0Z/d0KP1gnLT7oCQCBM80WrPAQQi0WOOzkbxyM8JdAuRuCv9Y6/DfGrqyYWj/3kKtA3XmBaYNWgX3sVlAwulUqkj7FHZ46rRTAeYFe5cIs5/0kUwpmu2QJob/LbYw9ENay+/+4k6T2LqU1fIFdzxViOlB8aUyzajoBrOZxN7jLTovS21CVosztVLssnU+M0QV5NheD4/Ob17xRjN36es3LMZAB6T+u/AhhBAUrechw61wgbZh8j9avu1nKFWWDQAZo+BNRoH8RCzD62QWYRX2BelI0ne4udOwUKboWmQtq4yXVTJUnakZXgWoLeBacptpuhq2nrZGOUumcm7IoOGNzSefLWhNrwcGTrRzgFtSxEa33lIMPZmLGLOFiysFzytk8w+UVNv5UiXYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(396003)(346002)(366004)(54906003)(186003)(316002)(66556008)(66946007)(66476007)(6916009)(2616005)(38100700002)(5660300002)(15650500001)(508600001)(6486002)(107886003)(6496006)(2906002)(36756003)(86362001)(8676002)(8936002)(83380400001)(4326008)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8J/GPJS/uljukmZTgi0/SCFgMyiy4H/szwO+Mqf1brZG3KIyuHGdQNxuCXjN?=
 =?us-ascii?Q?cj1EnEPX6LZw9yopUhbyJHZPFBc3LAbmoto645MyXVlj2AqxUEMP54YwZESH?=
 =?us-ascii?Q?nkU4Z2XUf+GqRVLttpLVHFH6wffL+I47BIlrCHuNwIYFMBiCQr0JuH9ktjez?=
 =?us-ascii?Q?xKehODSTyBnYU5ieRY+3ZAFWtmjg44QO8RYQk/EcbcIY17VnmLgUzR6Jhd7t?=
 =?us-ascii?Q?MubjKlh6q8OvhGhk0n4BUEqXJk6G7oQewhQ2+KTQpLCpfVIfu7J3CicWhLF7?=
 =?us-ascii?Q?GDarR05I//bA8O3fE+YvlvgFFkL6ewb0DpJsT6AsnMPCxBAUgMMvhxlQvpIY?=
 =?us-ascii?Q?XHzs3WOj3HBHDhj1qj0wU7EcNk0+akwEGQi+DVUGbWMyzsg6oLzRJk+j24j6?=
 =?us-ascii?Q?laqV9NWc7alPUVVUUkp56HWwE+QvWae1n0sQhfQfYesMTJ1JqhvV7qwFlfvs?=
 =?us-ascii?Q?e543qWUPIpCBV8DeSRJdgVlMrlK4xQeNSi4HQ7C8QxL9jpRX1fKJ4yt63kBF?=
 =?us-ascii?Q?nF5IprXDypFGmJhA9K1jf1zbxrb7h0BIUAlvRDBtxo2/rnJNaPXpdi+2rdJh?=
 =?us-ascii?Q?cajkdtCN1sNb82RtVZ25qsE6+ENtZytyLR4p0gWFNSHnf4GBmjD2YtTThiS7?=
 =?us-ascii?Q?QFI2Pjj/Lp/fplUIWWNdBj2TxKbaX3hwx16K770n6rZmXuBXkrrjcpGuBogI?=
 =?us-ascii?Q?Zdg0DANnKr4waMWajwELrjST9Wz0v7MfX7eyYmo7MaOyKFP5/q9A/+y9tpZD?=
 =?us-ascii?Q?/b1u++TltrjUazc7tJbnP0Mw9g/3tLDNVTUizCh+rkAKtQqszNS7msTxiHm9?=
 =?us-ascii?Q?Y7svo0WyVUt3a0MCBvEqVqv+aEtjTR7wh6Wd6RyipG9g7svIb/Dc0vJQG9J1?=
 =?us-ascii?Q?g05qAV5SUPrfGcxxBXypZZDYBVA5cfpeB2+FXTB7gm7JQVirhC+qk7PlYUCq?=
 =?us-ascii?Q?HuiGcAsfPdsyNKO7mWTpzeMOhP3F9O9R05A6us9kfzoNsJmd212NLlWT9W0m?=
 =?us-ascii?Q?xbP9EXujl1//rPu2dnCdkU3DLY2vcnGPc4ORZcANNCEPir3Ocq156QfTFOAN?=
 =?us-ascii?Q?1XN8LOIYwyEoOpW5s1iSs4Tyjzz5uFjDbAFAnd2+J7j0h1+fmwQjiSTakWtv?=
 =?us-ascii?Q?ZZk4rQXbCddBU+TAJLbDEj7MRp8AZaJLQWzu8+ibntCBh9hK78udO7PR+5fc?=
 =?us-ascii?Q?ifxgt3tR3AG9PLgGa2Dj0iEcnmveXzJxGTMScUCJ8X/iM5hwDpv6JgV9J3XR?=
 =?us-ascii?Q?trjzVnjo+QJyDmm35Ccq06os+e7GE3rNqRB7b9kJko+6So5XsPYsyrwTR13x?=
 =?us-ascii?Q?ywJbFTE2drId7DezpWyhLQEQTbIwH+WowIAjkMFAtlwZubwikfChXGZp9OT+?=
 =?us-ascii?Q?nc5eMxlGtXunJCnu+/o3QbhQToGp43WLYhtaOrZ66ES3d9YWAKCJhd87QiZ+?=
 =?us-ascii?Q?i+mXBWq0rgDNPQ+jrhbnwvJvF02LCRjUPwRxuJoLpxl0C755tsYQhaeJ5ckr?=
 =?us-ascii?Q?Q2ksJyN/pFndwPnteK4z9qaluewhM9gGvtRZReiRJycdJoBl6Jl62NTE/Ocr?=
 =?us-ascii?Q?0wwbcGE3q+JLJWGUb3ezWZKGT51BSzLD1z9SIDwJldvFCFxm2lprX6QtX4NL?=
 =?us-ascii?Q?4Sg8JLh9r2T09dWhjXaYLBNIpYEuowQbLg/eyNLIzeIb30GT4KtgKvyGbewX?=
 =?us-ascii?Q?d5NQtjZnBYHtazFWoI5IOVOyFwHKr/TcRyAxhihXFi59wBWtdSueYJ7vvnH/?=
 =?us-ascii?Q?z7f7kVMNWQ5kVLj16rauOcaVFakRoq0=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f886d4b1-6823-4622-37ca-08d9b40b4f5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:11:31.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBoVOthqgpdMt3WCGcFQYhyHJPAmiXXmbfLNbXeBBICK8/q0hQ7Jgbe07Z6d58XRkZdmNGvT/sx+7jQFPehWhRRPn3ImvyUeNUHzzjI20fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4590
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the payload_type for check_signature() when calling git log.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 log-tree.c     |  2 ++
 t/t4202-log.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index a46cf60e1e..d3e7a40b64 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -513,6 +513,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
+	sigc.payload_type = SIGNATURE_PAYLOAD_COMMIT;
 	sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 	status = check_signature(&sigc, signature.buf, signature.len);
 	if (status && !sigc.output)
@@ -583,6 +584,7 @@ static int show_one_mergetag(struct commit *commit,
 	status = -1;
 	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
 		/* could have a good signature */
+		sigc.payload_type = SIGNATURE_PAYLOAD_TAG;
 		sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 		status = check_signature(&sigc, signature.buf, signature.len);
 		if (sigc.output)
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b..ba855ec893 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1677,6 +1677,24 @@ test_expect_success GPGSSH 'setup sshkey signed branch' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with keys having defined lifetimes' '
+	test_config gpg.format ssh &&
+	touch file &&
+	git add file &&
+
+	echo expired >file && test_tick && git commit -a -m expired -S"${GPGSSH_KEY_EXPIRED}" &&
+	git tag expired-signed &&
+
+	echo notyetvalid >file && test_tick && git commit -a -m notyetvalid -S"${GPGSSH_KEY_NOTYETVALID}" &&
+	git tag notyetvalid-signed &&
+
+	echo timeboxedvalid >file && test_tick && git commit -a -m timeboxedvalid -S"${GPGSSH_KEY_TIMEBOXEDVALID}" &&
+	git tag timeboxedvalid-signed &&
+
+	echo timeboxedinvalid >file && test_tick && git commit -a -m timeboxedinvalid -S"${GPGSSH_KEY_TIMEBOXEDINVALID}" &&
+	git tag timeboxedinvalid-signed
+'
+
 test_expect_success GPGSM 'log x509 fingerprint' '
 	echo "F8BF62E0693D0694816377099909C779FA23FD65 | " >expect &&
 	git log -n1 --format="%GF | %GP" signed-x509 >actual &&
@@ -1714,6 +1732,31 @@ test_expect_success GPGSSH 'log --graph --show-signature ssh' '
 	grep "${GOOD_SIGNATURE_TRUSTED}" actual
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 expired-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 notyetvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log show success with commit date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedvalid-signed >actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'log shows failure with commit date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git log --graph --show-signature -n1 timeboxedinvalid-signed >actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout -b plain main &&
-- 
2.31.1

