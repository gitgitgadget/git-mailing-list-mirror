Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4010C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhLHQhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:31 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:45379
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237081AbhLHQh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:37:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDq7iIdk3X8BNRt477k09q0Z3z8iD07ry21ih9NOfvMuZMPpWnj4F9RPYEu45UQbuw+3m7q7G/CCJoVT2JDL2P1Rd/Oq+IzSCwx5h+F3YOAtRe0Lttqs34zFAqUzk8HM7OiZBzXRbspS29faGy3dKp2YRV4bjQibp+5CTBt26EkH1wbOKWiy06JNRXdswCp5QnjMG0QmUFoN6aICBvkHEiUnUCBKoqJl1moYz18Wmu6Bjcoc70B9do/VHjg02eYg2NZDzmXXNJ7AzB82oG1LVsDJp3RHh7pBRF09nPdO6C31aoMbiSjhAhWK9P+JXwx/5DdqOs+kVwKv5p0CZt3IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l9qmJoDiqvIXf+fkiDiFP54F8XDYP7oD2aRaUktoYs=;
 b=oBAlKHSh605/39RYMyzx2ZOF89OlFJLVgKPtIHlbe1KpARPqSDnGJJplr3Kqq6+ymCY9YT5BaChit6LdwJWAYWcuZtLR6vdYO6rormvpfgGlC703zToxf1a9CF3tkodQYOgqrW2QxO/UYXNa++s4E6W+yYSF/UfSV7bHLUywjhYzysNvxTISgYbJqr5HLEDaCB1oXfEFFZmiXs7EF7tIXrekHplrtNGIBxsHSW2qAl+P7yZi/Uj91x7UEClgpudsTMBpNRQUN1OXEsrtQnKyQTI9qX9kWCdvYdwWrQB8cUFAarRclMlDeE3E879bTDMoZ6OztvNS3Ne5CMLLxPSdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l9qmJoDiqvIXf+fkiDiFP54F8XDYP7oD2aRaUktoYs=;
 b=uvkN2FubcZysTv1rd19mw5piF9ulE6U1TnoIChMsCr0I7GIsmc29vqYUZJMbSXOpRsL1JSfmsgURL71eIp6chkyRiMS0lTZu13bxFk34RvgseDu/SeifEDiURi1TZe4wnPHQTcbtJj+FBwAESh1MkkRnoqLrcjRdO+mdSv+04yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 16:33:52 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 16:33:52 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5 4/8] ssh signing: make git log verify key lifetime
Date:   Wed,  8 Dec 2021 17:33:31 +0100
Message-Id: <20211208163335.1231795-5-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208163335.1231795-1-fs@gigacodes.de>
References: <20211130141112.78193-1-fs@gigacodes.de>
 <20211208163335.1231795-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::10) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Wed, 8 Dec 2021 16:33:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc317613-78fc-4446-dda2-08d9ba6884e1
X-MS-TrafficTypeDiagnostic: PR3PR10MB3914:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3914E5D4B244A370AC36CA05B66F9@PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IM5jIh7VkNNZk5U/pLhb7iw7cWNpB0+DXdObggstl0fppw6YCZ9OqjadMc0lFJKBEcHcdOeLbnQfxHim5brftI0HTAKjak/Ty0KFquQ1JvV1ppNRFJkbM3bodZ+4mLG5jcFk1MQ8Avkd6G+tK5AZ2x9+JX/gC6X8d9CSP+Tv+FqdzBsjMqpyLtuq6l3E6cd09JNktox7SSlPnLkSImXV9RhOKj5PBtn8Ix1Y0zIL+3Wp8qrYlklMofEPEzEo8Wvdl0KOFWrj0gVy5hv2dUfsWvbqWWokCWaPT/zWyx+VRJ7GSWuvA7AYVxWJbjxpPFODo55vDA9HEMDwLSihPQ8EPwGQnIMJB4dfyMqUVMWGamNXgp0x0OGse0DGMpT9FaRw2PjkDFgLQ8y5u+6fWLFRN5t5Zwx9IFNIPS1Sf3RU3FCG4lF0/xNGdC9Yn4ZE4/YnWkg+CrUr4w87Mkb2D/FVmKJGNbrLinoEHAr/AfI4wOWUIZtKTThvxHajy77uhnfV7NmoQWT805M/flpYt/nmKpuTD+fjvQRmLmUSsic5xC1dYUm/Wi9Bmjwj5Hgr94V2jU/QdrwCACQsA6mUytRrraN111yOgAXRmSovIMfR9JIEu0+iaHD/EhlhSMEXmMytem3kLh1z7eQWfXEnvupLew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39840400004)(508600001)(2906002)(6916009)(15650500001)(2616005)(186003)(6496006)(36756003)(38100700002)(83380400001)(66946007)(8676002)(66476007)(8936002)(6666004)(1076003)(86362001)(66556008)(5660300002)(107886003)(54906003)(4326008)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ts8g5NJiTa653LCOrn90yzGa7YDQRpaIHGGQ2GWugJaqXtJupvgTZ6G0EUyZ?=
 =?us-ascii?Q?StKw0QlGO/kZa41fORSlO6jcfVALZtrKSbBqG/gH8TYebGi77e3GwHYI6Pgs?=
 =?us-ascii?Q?xtYuVtI0luFv4piEG+iDQZRZc1ZzikSdBMZjtGQ9n7GZ3ilgQgDaPAW7CNnH?=
 =?us-ascii?Q?pARy/4MEAujPEnuRE5MLc3LrSYBvcjTNW5tn8NjjzziajI+WysDkQ+Hzl8JZ?=
 =?us-ascii?Q?0UZYJuYgzV0Rg9J7qSNubksNBVIzws9mfRHHkX5/0PXvm+Tvtcl3D/ODKgwK?=
 =?us-ascii?Q?UHYUJPt03aWHcSxZrPQ5rdGEw5y2QVXUiPS+jUTPqxoXEneNXyZIoL1aYeeU?=
 =?us-ascii?Q?xmCfB7RYRmvr+kJtjdBa6tk9/iGMuO73P7FTXYoHUFofkYf0EZGmRCe7Ledj?=
 =?us-ascii?Q?SA1lWxnHSzQl7Ux6KdbxMMEOBJupOo88xLtbgcV+CuBP+FbAjNI2nKT1Zzc6?=
 =?us-ascii?Q?a5/zsqca6LZJfUEK1XI7goX/kUH2XA7MGVVes5AYzw37qsnCqzXhW8mRd7gw?=
 =?us-ascii?Q?Vw8i7lnVFdxy1QcyoBEdZYmcIz+oDCq1UYnDKNCGa1U//JBGlnqpWLqGQdTV?=
 =?us-ascii?Q?p/b4kSOSmsp8WW2HLYm9g3EzjnhoIKrd6k6dG1ocUzT5zNSZBbUwRz9Ml1+F?=
 =?us-ascii?Q?4938SBCu96Uwjr5hyTbTo9jmLw2asvMBA43QavNyK986P4a6IRxM39T9W2zh?=
 =?us-ascii?Q?O/m5xkVfjUhEmloWuWnaEDKnph60sbkq3lq8KOqwsWf/WbM32oaSycCIy689?=
 =?us-ascii?Q?ZDGlJ35sJ1MJVnA5vaeskz8bU/QRSZQoM9mvCI9zcpYpyOduhegzSbqTuFop?=
 =?us-ascii?Q?RyUgyHoWudSshG4WkFSaKO2sl/HSbyPGRsXMr7fBBEQnmkoLmtNtWlNaKcXS?=
 =?us-ascii?Q?MPUI5AwMprCztI5/veJZeZ6xL/Bk11ezRu/2DfBwpytAyqXOMNoBLwtNZ92k?=
 =?us-ascii?Q?61q3t6YrMUnf5d2DtRnQ/X5J+whP7r1jmA1Er3G1kBdWVWpYaZ1q8v90s+VM?=
 =?us-ascii?Q?o7P5aSpEwM4CiiLNENNgCtjShc6+bji2NCCcRr9pfz6lZtsDU9/NpIbrnH55?=
 =?us-ascii?Q?VegyhZfkejAhG6+hKpsIwRcnbywN3dSfT9bnpI7bjflbtMkrg8l/fuEyanag?=
 =?us-ascii?Q?gWTGQW+JihyVEy2ZHQUp8A2W1sf1TnvJRzuTC+Vqg12ZIV48cu3xNKLgD66M?=
 =?us-ascii?Q?PJthkdZeOowLI0S2wBskGaD1FQLQg8+AwxzoSFs63rEVXmmZACbn6DKyovJF?=
 =?us-ascii?Q?A2a3n1VE1qGyPCzvKAEMlZ12KHIxgA+NHrOHwHctpYRrIlENhmAw6dteCZ7r?=
 =?us-ascii?Q?PT0N+7Ad9ykZMBeygX0FiqD691S/FjVRx8SsifHTa6wOgCwu6wxBvPdLJWG4?=
 =?us-ascii?Q?VVZkuV7WQ5tW4iUFkSbN4UZhvgPYEXJqV0YgHKq4N+mWvGWFwSgDop/wrno8?=
 =?us-ascii?Q?LbYcxqllKkGqZKopeIk5MnwQjijrT1fJNBg7Kts2A4JjIVT+G6vmHLwwTrVb?=
 =?us-ascii?Q?tplN9oG0c36JtzuQZT9RAkl1AirUrbCO8pGPVOICuZlQsNGVWGgO6TPHbcAn?=
 =?us-ascii?Q?DhgA6VUcGRffz96cbD1pKg18SLP9elcQPlAYg0OLzFf18FyZxp/tO7+YWdqM?=
 =?us-ascii?Q?CLXWfDgOm6aA1UG7nQVDDtJnkhmCFU3Z7FI358lqOO2ShRNF5vFHJuMZw31n?=
 =?us-ascii?Q?cHHgom4G8Hjv3nw/7aI9nLv7tbfcq6zzfYCjS70FKmx8NCxZyeE1rKiFoDVp?=
 =?us-ascii?Q?1XUQ2un7oQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dc317613-78fc-4446-dda2-08d9ba6884e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:33:52.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MF8cAuRP7MFx4eX3nBZ0XP7c6pl+megCJztTbmhtpH4FVsWe03S09Y+SgCP7ZzVL1KYSsSP51dvJtwQje7NiHnuXm0icnS4pEA9BPz7qxKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3914
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

