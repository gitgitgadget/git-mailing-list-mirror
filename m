Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F11C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbhK3ORJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:17:09 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:8481
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242097AbhK3OPE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:15:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxgTJPaBIx0I9V9uI18wW/nd9YNdTX6dFHoiL5XpIrGavFw3XYfZA7usy3TXOqjQbe8dCipVa4Yd6Fu2B1G5XYkR5PCzTw5YevfOifdDqBd0f3pUD5FPdZCC5ybg0FmsZezP+l0DC2oaTMeovguf6AIE6/IUQwjuHYj4LjjIFWHN3g6p6Kv4lURUg3PO+hWJkvmPjs58OTIDWAhGFctSnY062RzEI+oPEAEMlPOl39dlc62OBUnAxBtoIiU0sCFzXHQugHhG2/X+RypojyvOGGTwKwoa72rcm0ycFNLBSi/Dd1zwLD73OLX1HOiID0U2Xcft2YG2tZs/dhwmpvxCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqXAXvJxFfijWtIfXPjhBQEVCtCFbsViLD+T2fFn5LQ=;
 b=fIN0hVdFAkHxN0B0SLg8J4sxSigYX6siY1Mjf1oq5dk56ZqF9KxmEEUBB6TDqbYm5MC3KiVVxJrlZdbSirc59EzVZzoWPYlPEjMkZwvyi2LPwe0lEK7y5RCaJdU5Hljmix94zwNe533BOQUlCh6yI8I6pqUBdEE/sjzTLfPRYyOsmWrinn2wKt9rn79naSlHY9x7eMWnWLg1MuMS8r7tz4XFVHjreKG2y5zhhYjkNvwX97PqGBUwVkDckO6HD839P9zSt+JdxSeG9f3wYQcgXgFu/+zi5HpAEAfKxcq1n2W9e+zg1c6rICqEfL1Rz56vsY04xMk2gcTTo5XJOHFYWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqXAXvJxFfijWtIfXPjhBQEVCtCFbsViLD+T2fFn5LQ=;
 b=ihQkLbxt3/sjVKNgH0P4YOpWUmVY/SfOd44HfV+gNWc1MPvA+ow3mOGGXOiKLfNGDlyGSgj3oSSEKXOe9jxp3w8/PEeN+BzggP5jIw/eXgbuuYQoVTJ3JkrclGdL0a6F1z+pnJegb5dJ6DmigX4Oqx11W0/ujUDpCwm07Ubg020=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 14:11:33 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 14:11:33 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 6/7] ssh signing: make fmt-merge-msg consider key lifetime
Date:   Tue, 30 Nov 2021 15:11:11 +0100
Message-Id: <20211130141112.78193-7-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130141112.78193-1-fs@gigacodes.de>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0099.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::40) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P193CA0099.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 14:11:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4264d562-19b2-4e27-a6a9-08d9b40b507c
X-MS-TrafficTypeDiagnostic: PA4PR10MB4590:
X-Microsoft-Antispam-PRVS: <PA4PR10MB459082073B5453D4DD71BA40B6679@PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t62hbXKdgbSHis05qTMKDIT4MIwl/j5J6BD2zfMrBTkEXJg0TbkvGLNwScgqbONnHHYMgUAIq6M0jCZYP7X55ojvG1exBRPV3f+8888meIBJ/azCsMYogiTH7JnI70DgjFgDsD2aXmfehPsPnLCvQ5pctLr9vp8ePbb8m2KLu6F0x2vB+tz0N6CbjLz9U/Kw7p1b1PRnx+38AorSr8jCqrDndNd2U9cZhfqrkfJUbQSSGZsJ7ij49j7QC82SOPw4P/uUM+qX3rg5AE6Z9BtuZ1rq3TY0+twh6TVl2D83fqGXLFPIYDd9c+TmK1jkuNS4507wn5jo8GkdJevR2diSxPbJy4xKNllzityE1EIduF5PtNL4LTzoCAJoWPkY/4i+gC9kJV7B1+2FUhiOnse4kRRBDnS6uwYyNwcDO1pojmtW72mzShzvMRpqiRcQti7wXVVPswBRqfwcPi8VGjrMijpxnPV/xy9+bn+5xbKKwE0NQ3Z2n29KV643Xuh38oMA3+lsrwtN1Q0cCoPbkLDcnzW8yr2UmZEwUriLSMUNy7PAWV8c4t+XIn4o0xX8XhX1ruLkruF5Of89++X7dbaDzht1kyrntt/P0F8E3WUw/nCqjJbyVWMtWtB9E9jTiRJFmSJxORo/q86bz7tx0tC7+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(396003)(346002)(366004)(54906003)(186003)(316002)(66556008)(66946007)(66476007)(6916009)(2616005)(38100700002)(5660300002)(508600001)(6486002)(107886003)(6496006)(2906002)(36756003)(86362001)(8676002)(8936002)(83380400001)(4326008)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6R9cHUghQyLY/DIrZS6db8xAuFfiD0xQZWNnOPRR/1jeq9I/mc6qbrI87D8p?=
 =?us-ascii?Q?swPDJhEAA5p8A10AdM+fC5p4VHpovRl5AXmLuiA6ZyL5pRh1jBFnYlrkq0on?=
 =?us-ascii?Q?B5FpTHIW9+3yPz6nO+GbsVtIdQj36Lqf3cBbD0d9hgoUStT8frtrBElL5uhh?=
 =?us-ascii?Q?MpUP4u8fsnSMKg0JE6wuIwKynMjbcPe/FWd8AG6+wle9r/Pqaa3QjQp8lEeZ?=
 =?us-ascii?Q?yNAcMsqBvtADYxcgM7CFwf8CL6gw4PqwoPKeD6Nfg0uk6VYnLLyeo/Lsbkfe?=
 =?us-ascii?Q?WehSRXXg+vRr8BU+NMfarrexY/JScWGUgcaYJtPxKmy6BwvoHOCVa9Gwxjhm?=
 =?us-ascii?Q?Eq9IdNcQDCLtUzm7ZcqvZ0qBuKSbZn337F6L0N8uxTBPA2NyF7Tt27PX9tPP?=
 =?us-ascii?Q?olBjKmB4m5v5EBlVFQbBV3M1+tuz96C7I6y88e8/JzEaNgsMnN8+boIduJCE?=
 =?us-ascii?Q?XgBh9Cgcf30T9JeKgzqFpXhcy4RarcnhDt60cEi1tXTrN60ri2duak/yEU+M?=
 =?us-ascii?Q?PPgAXkz/3s+L1yRQ7ZB5D+pcRgHWvBHJu0/ctogvvO/9LV9oWk0WfkPyllce?=
 =?us-ascii?Q?Axukuql+t5vlgT8vqebQ66dXIp6vIRTmkD9Bbj+bEOVbzc1AZCkhHrI2xByu?=
 =?us-ascii?Q?kvJjWM1dgqVGFGRkZHAOcU+JPu/HFC2NAtUTKGeBMti4OwVqncr+X6qae2Md?=
 =?us-ascii?Q?XVSnPAv4h5bRAhQgfjtI8m4tS1ka6FelxLql8izujiLMW303KtzT+GtlBwfL?=
 =?us-ascii?Q?ZAShZTQlsgUezv5HFq8byeK6zUV50x2urlWJueu5Ykhlr/W+VxiU7gEkZE3/?=
 =?us-ascii?Q?i+WSPL6bcCwMl3EULEYFA5tLCDLZv4beguXMwub7byS+rfSLfvwcRSajheoF?=
 =?us-ascii?Q?zPMUNqv1phW04GiDtUpQUF+31mViA8s2VMqFyLJ30llYnfGtjSWgfFcZTkGp?=
 =?us-ascii?Q?jrSM5oPc2eljjv5Iva4jXlGV7jGpv7N58+SjJ31ObSNWlARGAPM17FJx/+gV?=
 =?us-ascii?Q?R8xivFYxDRU73Igyuvhu2M7n2n2TWvh46nJpneZMQhfBdzKHTtQe788jkB8f?=
 =?us-ascii?Q?1E/89r2DRssBAXHRKNdRSMiW91vPPulWLigP7C9Fhhr63TrJGzM4J6afNnih?=
 =?us-ascii?Q?JWPvV7k8SIwk7+zWs3D9Ij5s5OHNNgPckv3v7G44omZKGTEBnla37j+Xgoqg?=
 =?us-ascii?Q?1wqYal6LpT8v1HLcPJGsL9YOK0qNdByzwo8jBOE3a56JhrqKJ45aHqTKvKTn?=
 =?us-ascii?Q?iWTrPBabu2L67Q1UDZED3X3V1reAQ6LTJSN0EU1Av4UNVFlIUYTTbz2PUpKz?=
 =?us-ascii?Q?mbSvm5Rlf/OE32K8DyxNTsmqVl0WshebgT2SvjWmmARNfxsK9m5Mc4M6LKCn?=
 =?us-ascii?Q?zE+LTWC4iU9HKp79AOi8J5sZ+0mtTgJ1IKNAjphG02O8rorgtwjarXcWu8Qi?=
 =?us-ascii?Q?bDQlBksun4lXVsxld+gQkQEFhwYPSwl4v/1yOJnvNO5G0Ty8d5Z278OV/pBl?=
 =?us-ascii?Q?I8Xqw9Eo69E0sRFsey9dsbKyEPCeEqua53/090V4Bw+yUE3K3+3hwkyf8/kV?=
 =?us-ascii?Q?5wVk/Qi36iWdyDCXKeQs5JkffuBEaFgwPA5eXdNXQlBD6kRjdBTCAXdh7QjA?=
 =?us-ascii?Q?h5J/50UV1ww68a2ZZBG6BHV/c9nsHxODs/ui1vpi8VCCkHRPTiUiHzwlp8yt?=
 =?us-ascii?Q?YP/EesWBYMxhcqPehmlhkAo0iBH/yPaSE6m5a+B/SgtCPYRtb85kDwyMu28K?=
 =?us-ascii?Q?rWk0gwgmYJv1rZHLBTpeAs679PQhNaI=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4264d562-19b2-4e27-a6a9-08d9b40b507c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:11:33.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+u42fWR9fZjtnqlJ0qocWo61WQM1Vk8oV2YbQbqA2LA/Aqx6ELPO80qFBv6xY6hgGkbpPB6H8AJDc2WiXsFUZH39TPrswwM2iVLOj5//aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4590
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the payload_type for check_signature() when generating merge messages to
verify merged tags signatures key lifetimes.
Implements the same tests as for verify-commit.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 fmt-merge-msg.c          |  1 +
 t/t6200-fmt-merge-msg.sh | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index deca1ea3a3..e4f7810be2 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -533,6 +533,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf = payload.buf;
 			len = payload.len;
+			sigc.payload_type = SIGNATURE_PAYLOAD_TAG;
 			sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
 			if (check_signature(&sigc, sig.buf, sig.len) &&
 			    !sigc.output)
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 06c5fb5615..2dd2423643 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -91,6 +91,26 @@ test_expect_success GPGSSH 'created ssh signed commit and tag' '
 	git tag -s -u"${GPGSSH_KEY_UNTRUSTED}" -m signed-ssh-tag-msg-untrusted signed-untrusted-ssh-tag left
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed tags with keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
+	git checkout -b signed-expiry-ssh &&
+	touch file &&
+	git add file &&
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
 test_expect_success 'message for merging local branch' '
 	echo "Merge branch ${apos}left${apos}" >expected &&
 
@@ -137,6 +157,40 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by expired ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . expired-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by not yet valid ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . notyetvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by valid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag signed by invalid timeboxed ssh key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git checkout main &&
+	git fetch . timeboxedinvalid-signed &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success 'message for merging external branch' '
 	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
-- 
2.31.1

