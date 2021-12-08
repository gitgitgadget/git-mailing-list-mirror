Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7586AC4332F
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbhLHQhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:32 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:45379
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232823AbhLHQha (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:37:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2jZL6MLjrq+ZCjRCTWOshH2/odwvXkvjVSpgzRTMRLLGJv5uwjyUmyYHyuTQk91HvkdwgQ0z7xG3LcBrafQz8HyMU9ho4pKyXC+PTCxmR4wkyzJHojLjnMcV8cuyKuLxU26SxU1LhAlRLXzZbFz3OLaCWH2tbCi3x9pP9cJLTKi3gZOVndueeY38n2lqPVkL7sr32o5RAngDCOsDPyH8pPxLiuFhAQ8XCTQwxdIN17rguMYzps570gF1tIo79+rvbCWoOZEssOEqetriItwH3vW9dhzt15OCWx2tUZcvEhOMgmbB/JpEZV5quZnN39cJRoW7Q01TbnycdOyLkNhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=Tg1uMGPlmSgml5RpppXiOwY0ewo7+NnF2DfP5JupiphjQy+7c5N0DasJIEbLbfs9/WzU8ydxJdg1cCLzdj+4a4OOCaKRuYVN9Z25MdOt3At6F2QKtE/ob4mEbxqEJu0nTamtTN4s6G07ZVGhQlMSQv9vPTQllElKo/7z5TSJi7FFJ//kEjoiO9POdKu1Mh76yS4PmUdqCESl510EAy/+ra0ytVCZsMKErf6QaK3rIvjIMRKlrLPnPL/j77w3S5JGLh2aU5ymUt1TrJkaOn9Io3qgwRx42Bqx88qum2LP63sH6lW5Hq7pniE/LLYs7OVkkz0ERqsRn+ggzBwa8yN9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=EY1LtOnl3BBV9vJaVobTyUNCZkMA0eXpQfeg0t752O53EkkkQrvWAwRkvskUCR/WO3gwOog2NZ0lWDVbOPvLYQffvDp2QYpo+ujDvwq5t8FQMI47MO4mhtbA7AtfqxG1k7Vt7wl0KDc6kdgGZiBP7qBLQbLmAnE4BwZfp3P4AUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 16:33:53 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 16:33:53 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5 5/8] ssh signing: make verify-tag consider key lifetime
Date:   Wed,  8 Dec 2021 17:33:32 +0100
Message-Id: <20211208163335.1231795-6-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208163335.1231795-1-fs@gigacodes.de>
References: <20211130141112.78193-1-fs@gigacodes.de>
 <20211208163335.1231795-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::24) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8P250CA0019.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Wed, 8 Dec 2021 16:33:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4bb9e38-6f83-4124-d827-08d9ba6885a5
X-MS-TrafficTypeDiagnostic: PR3PR10MB3914:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3914C1983B7CC2628849231BB66F9@PR3PR10MB3914.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:54;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pv0cQGPLiM/TBG1jEV8j3Y+zM6ydcK4xWQTJ7na1MlgdcGRUJAhO66H4a0T8IFHxPb72sYJg0XOtciVGx8qOocCY0DJYFCyz99CwqWMeANUTmJ78RNfZFgZX3dF3z95XUKV0JbiyDOhEX5m5+ra+00Lgm/nFR8cnuqaY+P/kEq8jvqnknfc6QgBdRABhBcnSWfIsTR0jZjr3RAyHKmoKhoIMjHt69+/P3L+6AlCIAWrtm6cUvKWMi1MwZCbH0n+DNyNPtBq7Ee8qnrD+z9BIFgkrmIFsMACwvpuoVdl1lx2sgve2JDR+bWzqXpJucChbFk69gtwgpyHvXbZAoAFQWhdGhASvV1kMeo8PmIL3CctX7H1rbnw3kP5dw/TXnmFRB3nBVvlm/wDFPCm2+SMkD7YTSzo/j7FLawArgFf3MKqGJUht+61knMxKsQPMVfa31aWs8n2YDUvBBzMPDgL4VWhfK1vKe3JLwn04zGwuVtEJx/56SY2ajKraxUsUL0hMcyO7iy04uPulzcCt2WleBGIfNMnmbyNl/7YJT0r1xPxjo/tBeq8kvCSl6Gsc86deCuLQf7mB+G2MVxTZ0ZF5GG42jtRveSameUb8vbSAchCDtTF3/oAkB8Qrhkikn9WZJP8NEZE7cuOcsMce5UbCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39840400004)(508600001)(2906002)(6916009)(15650500001)(2616005)(186003)(6496006)(36756003)(38100700002)(83380400001)(66946007)(8676002)(66476007)(8936002)(6666004)(1076003)(86362001)(66556008)(5660300002)(107886003)(54906003)(4326008)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uhLOJ+/Ynfa6xasTaULbsI7FTfC/Zf8Fgf6Boz7YNqCbrVj2mWV5UOVaJ1tT?=
 =?us-ascii?Q?3Euj6rUCN8ju+7icNLOa/nv2Qtukg4qurau9kCXeqCpBr20sjctF6MlEqOI7?=
 =?us-ascii?Q?2kVX0FRvLjCzWNFQT39LFbDOZ7bYCX4QGKrDdXdNSXmGyR7t82jfSyl9Wz2y?=
 =?us-ascii?Q?nmw8+2rJRRAYjPJ8hgHCsjX7QwMQxdFxqhUnN0t27n4VS96T8Tcng/8lDKuq?=
 =?us-ascii?Q?dvmtZsBxhtNVghHlFjz0ohdaiUNiMMwcruzrKupE8asZJm8hYzebE5VwtZSn?=
 =?us-ascii?Q?vKNGF0PUUpT6pl3NPovo0HdGJbeHiAE1yClHaqkfRLSCnuvNZLxNrYHqZs1L?=
 =?us-ascii?Q?ekLQP4Y0aHtDl1jBIVLUtWed5rVPzWLU0mPTBu7Ac9qEkFFCVg0gkcNRj+CV?=
 =?us-ascii?Q?MQlwn4jBWlSZRnApNo2wphTYQNf4QWU244J6CMRlYn6B000NkzZqYZnaU82M?=
 =?us-ascii?Q?nTQk/edWDbsqz4ge47ivsfVkGWlo3ttAhijGBWdRvN3Jw+/kVnkb7lmix5tg?=
 =?us-ascii?Q?EAibf8qpMhTQPSvyfLomnI9MyAfOLFDal8P3rz1Crg9a/4Dr/i5bE0kCClEw?=
 =?us-ascii?Q?gibhoXW37m1zmfN6VDtxc+ZRXZSfACgMy1fdSP+veFW2mAJw+GsvL48hbR1d?=
 =?us-ascii?Q?WBWas+lXN/cXnybVZm4W1P3h0ULlO8VOhzB6tLAEJMWJj+4/FY1sUuZr2kRP?=
 =?us-ascii?Q?anA6mfl6roteCDMM5eaG5ZDYFT4l40vMd8M3CHk4VX6w/TAj2/qC/EQjHWEG?=
 =?us-ascii?Q?2poG7D538eDlPQ+xgFSRAKk0wDrpYgm0Z9hXCyDh1y8G+u0eJoT0IhgU6DY7?=
 =?us-ascii?Q?07Qvejp4sxxMBbudrckNap1JMFiZ3H1WS2JgN+yki5zXUInsJXGL8YFFL+6n?=
 =?us-ascii?Q?VOURQCR84haCiKEZm4kaoX56oitPVsdhdxbRvuYSS9V1IL3wjVIV8J6u9vcU?=
 =?us-ascii?Q?uTbVOUmCtkwD8D6Uts9oyutuA9apfwzlkT8oJfsVwbeIF0xhZycRpnDsLyeX?=
 =?us-ascii?Q?F0EiqexIfz9taJr5SvlfxVRC1WIaNx9CyTXuGKLS4yObV8+rO0UL/QRlbo9M?=
 =?us-ascii?Q?RF99hzzAN0jCnvgBSxjxWHJA4WlwO/SRK9XeTdP5qBYGLq5JHwuzeFepGkGW?=
 =?us-ascii?Q?bBBJ1v6Qb6h+5J2eKNtBKFGYD8HnqULL3WUFhTbzhGOf5SU7tWKXKGMuhUD+?=
 =?us-ascii?Q?qv1olCXHKAmywVxnDwpgYrgtVmvwPdEA9JAi9RYwadDg8nE8nM7gePUyGX2J?=
 =?us-ascii?Q?5w5hw9eqD9QmfMyomtR0j9YBnjwv68m1Jx3dGMTDawF4OVNUGLS+X+zMpwwS?=
 =?us-ascii?Q?aMyMHJKNYYqKW/goW+4ojkgP9Ooh/E2eRDOCwgqbeM7M50TbbISxRyM02Lpt?=
 =?us-ascii?Q?gF8cMG3bLXOwwu+3y0rL0KQ5u9KhD+v7MLFnWrQaRHxNNH9bxX7Bqz085NJ2?=
 =?us-ascii?Q?Kof62ctmt1TG4Ay4NxOknqK7CrTYCRNb1d2tDrPEEw3U5uc/YhnYksmDF217?=
 =?us-ascii?Q?lDQeSZe9GGRqiPX0Omsu3zlBTb8m/pFoxDKnWG8TkkwnESJVKp4voZ3iFToP?=
 =?us-ascii?Q?EIAzkncoXLTy6PMKjUQusS1FskYAv4C0IpUD0ZXQkQJ4sRtL89zQVA2aI5cW?=
 =?us-ascii?Q?K+HBuVwGNnLWy1xCFHDdHiOiFpzY0sh8vbJrgezyfyOcGVcNHB362BmNCzJG?=
 =?us-ascii?Q?CGnMTkKS3kiKH8j4SG8fYkg1pT0cHhkAJbTWEiLBrHXIYOC17dUI/oe/Xoq0?=
 =?us-ascii?Q?VVwwXt1HHA=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bb9e38-6f83-4124-d827-08d9ba6885a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:33:53.2055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6BT0mRmA+Slz0ssZFHgXfbDbULVIDJGgnp2PYuquzzFF42vL0Abmzaty8NNlUQOneaovz2Llw+IbrtgUX1bE9gcMI3+tpFmdOMVBRQyIXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3914
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

