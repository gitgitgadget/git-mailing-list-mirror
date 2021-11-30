Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EAFC433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbhK3ORH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:17:07 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:8481
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242079AbhK3OPC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:15:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAIHzL7LxKHUBPCRQrlN3XKjjFVe+qGF/JAQDbRR7YkoGI50gYUvs4+3luGYwXIpFWIy9N5E5TTPQn2P2I8awvnJaHtztuW0D1kOYk0TEzcClllekaZd1KLrom9r/eGChp13aLj+IktkSZxjLHDLabkk7f7RCBP41z7IufUEkmyYftiUUrj9+GdGTbHZvLq6RQ77ZnH9LCahQSJeLO9PDREvOwICKFnGqkUn/mszIxyegZUcjpp8xMEC7CSMOtchcjphBgY9sw3ef1qmak/vKr8OZosTD0ZQeaDDIusgP//Y7atat5XhVDHb/AI+JkXEqw+XFPtVrHL1EAplosvAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=WZOR7ncbRb23+ecl99k6KuBEHWLPzVy6wCDRI+EQUxMwrSANlK2mOq6uMdl/5xss2+bSy2WXXKCXJhXeIvFFMu7jW0lWSMynJ3GzV2gR3n5/To91CmDyOkEckcyNkqL7Es4XyJVymshLHpkYTb37pWTujvDp6ii7ZFTs8SkaAMtpZiJUSsedQjGJmy6VHMxD/dQH3TS9VuzP1uU19+DdBQH4euyz5AuFGB76dwJS3GAmKnu9zDmHOvITV2vN4iJUkuGiBiVMVU38kMYO61XDKGOZm0nUqqQqOHfd06KxUR/D58hhQya+vFjQj3OIY7O0RyhLf2dFzk2BlnDwqwVwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW3HmvIC+coz5Fp1EH38QJ0Hs52tSu4XrwUA3cBq5Tc=;
 b=BT0lBHDsdR0CCMf5Cm4VCwQ1PSZNlkYXjkSrYKhRyT2AvVavXyKhLWKXfVcKCHmtX+dSzQmuoGxpFdyJ+n0QmMkkaoNE44WghrFL7BYXuGyRwCh71LQtuD2Ut+5uzcuyvc2hID4JBQXF76U3i+ti4A/3NNaXVNnDdA2JlHnZvrg=
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
 14:11:32 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 5/7] ssh signing: make verify-tag consider key lifetime
Date:   Tue, 30 Nov 2021 15:11:10 +0100
Message-Id: <20211130141112.78193-6-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130141112.78193-1-fs@gigacodes.de>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Tue, 30 Nov 2021 14:11:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49b5745e-01b5-4a04-a7d6-08d9b40b4fea
X-MS-TrafficTypeDiagnostic: PA4PR10MB4590:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4590C407672124E2467E37C3B6679@PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:54;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNOtdxODUw+7yN2M5KCcayjgS/ZtapcSSTXv8A9g60N3FsrmVhpmTLzJ3BEgSk62na4yKnWWloxPaKplVvnJx1DQRm9N07vkkucG53tsJwZyIkm1M/pz8Ep8YhRreaEiVjJUPSvpk+pKIF09mHXZ0h5G19mQgPhHvdnMPj0aJyEju5tsLxBUCI25PQ0WJHoDG1m0QDNzom4cQcV962ymRis/Y9JAJv2ircv+zUjTYEZO/CMkE/Di0ZW0MNR08fd+WspYMfnGmBX3dwjI4exxHogFx936bu1ajBwKAHpI4jNMv/yEdHkEVOHEW+NPpctJP0/XM1EQdobD0hljv1LtzUTAPfHs2zMbGbIdIElpAApTKnk3wvLb7v4UOyvS1TUyIO4qfHfUrFppf0KtFtmbDY2f9Vr7lQCVXfXCja8yl3AljcjohsMR5mecaEqGdY9OO2sJRc0SGTxhMTiamA2fOhvS2hFBySyf5E6t0jT/BG158gEdq8kzedfd7Mtls+4LmXSRCISKGtI7jg+yzLLIVShJVlx77JXHYOySmY5SFtyfXtEan+5GDR9exlPcoJyx7xYsQLIhACkESu049AN7W9s87bgF1RHBihKH43QMDSCgN+vR+whSvXQIjMq2XsqzGrixbMOtLSLJ1FyzHtTAaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(396003)(346002)(366004)(54906003)(186003)(316002)(66556008)(66946007)(66476007)(6916009)(2616005)(38100700002)(5660300002)(15650500001)(508600001)(6486002)(107886003)(6496006)(2906002)(36756003)(86362001)(8676002)(8936002)(83380400001)(4326008)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0sV6aN37n5Pid86WQhfUby9ZbAsrJsYmC1VjViAX/R+76V0qQD6ijiPaILH?=
 =?us-ascii?Q?UbfGkMaIaPT1L2j2AmPJlgw4doBE7nzRyytwYD6VjbzMNvb60rSaVWOz4vXj?=
 =?us-ascii?Q?CX0ZDQCnOMX6B1TsRBItp4BThhtPUC48PxVvk1USVjsUwuORBZqxM+Mms7cr?=
 =?us-ascii?Q?FRskb4Ja9D1dBYPPbriN1ZRBoGZiHSxp4c6A1mU0wjCCRKR0qFSFbUGefad6?=
 =?us-ascii?Q?gcKYXoKcq1PNaXT3/hwzEqrBnxo36KxG1S1F1Wuuv9M5KM43lf+tr27218+7?=
 =?us-ascii?Q?yT65Z35N3nulo2SVcRmU9STDCVsEUKHhxdD2jJzgAnmmB3xnb5pK8WVHXNvJ?=
 =?us-ascii?Q?yyPfSou6+r9/E6H+0xN+gpw3fwSMUhu9bcte4wDRGYmiLLDD9TeLrL3dafh+?=
 =?us-ascii?Q?SIBAvSvIeVgkBUqiPfeUR4dEk+10PLZaJiNnmhPaeyn7fWyKYjcJ1XlkbZHV?=
 =?us-ascii?Q?S4mdEcS6AmIfKTrWL/RpITgQp8C0KFAFjZDMP3a9nytoxOV5xpE5C7Brb3Fe?=
 =?us-ascii?Q?60YG3imi1bkFIBJ02wtMCHZjwpwx0eQceY4KrjQGIK7AaafbsNhd8qqiqB6b?=
 =?us-ascii?Q?CaMt8S116LI0n8nHf2Ug2B6ltU7P2d1jHO9KnT14y5rKce4lRWbyOY4CXZ9V?=
 =?us-ascii?Q?2g+jIe/tOWxKUF90qN7//Na8CQLymybxxgCWwtUn2V4DhP2Ok3JtGrcMwSso?=
 =?us-ascii?Q?qzgkYGRH3RZS+kphAUNhaHhDz8jsb3LtRH4gq2KhCttWtnKkjS6jnqpjClwy?=
 =?us-ascii?Q?C5mW+UiRoKGsOH6l6qkZ8AeBKU/pkxJGYg1nnG+kL5eZp2nsi1w4TGn7Eab5?=
 =?us-ascii?Q?H8P38pbNRIuuyMhN5fo83QPOTf+aYin8NTnMt7Psb1iRlioMAgbuf02RzEea?=
 =?us-ascii?Q?7wl7IE/0hCMdzm12xqjlP1emdEzE8hnW0kiTZ9bwULFc9j5pijN39gxdj+Ji?=
 =?us-ascii?Q?Lcczw8iKExQKP0mpGYYszrQns3pkmd6NSyZLvEjrGMGI9exEAcRmInXDqx7B?=
 =?us-ascii?Q?hHLbi39D4PknbUOBWb5CJnSA4g10Eo5uGXNu1G+aMOmmwXDuvnVneYmPBRsl?=
 =?us-ascii?Q?35l+zPwE4lJr1oLpRReS3LQTTQdGxY02+0W6Rkv9QgeOnc2io8CDCqOAL2ZW?=
 =?us-ascii?Q?EtOsmrM1unAJaLofiuZMvSBOWTW3x8QAFsKuBy9g8rzmNg5yl+CbLxPtjDFQ?=
 =?us-ascii?Q?pZVvX3Bs7j1ot/aC4GuWBOreR7LlzonxaLQv9GPpX3/Fej/lYETsTXozAKu4?=
 =?us-ascii?Q?Oc0TGMulgAeXMoQQ4cvoah39aPt0Aw9rdOUPmxXEELHpoOY4trOldw3W1gkj?=
 =?us-ascii?Q?zdNoh7AkuJ2frZmbTJycGMFD/jD9AsPC7VXsdthjT9PBTaSegnqBZyYERTTl?=
 =?us-ascii?Q?K+Zq67idWPMAELeKuu8A4S4JTRRIkT3Qwqiz+YEYOBHQ/eCN0IFqTlIiuho5?=
 =?us-ascii?Q?8IbXLzJCNynXbgc5HnOIgqdU0Vzl+NiOmSws5kXq6Gd4tcoKYJuZ6zqnSET7?=
 =?us-ascii?Q?AVbZfjvpDm0P06h0IUrIaqeP4ytonzw5WrR5fxeq9iX+HHUbumNOWigIjm70?=
 =?us-ascii?Q?iabp9M4CAkVCb3wEOYgUtByq7zP110KJVNiLArkNXgw3UEhJNqVjJ3phxIub?=
 =?us-ascii?Q?vuxuJyJyqUAI6hG5AM7zE6FTn40Tqe1gQcacdeFec2YePJBYvKaHGgnwbDEJ?=
 =?us-ascii?Q?WvRz4NzInaot35ZOf40RA5OHpr0eJomU8+Tpxky7Y6XTyinD3ea+NTlsR7jy?=
 =?us-ascii?Q?LXQWZYfCJPmkZWCNSGusoA4HRtVmH7g=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b5745e-01b5-4a04-a7d6-08d9b40b4fea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:11:32.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuRXYff/k5D6zoBzkFWHL0QTzJ4MYLWXalA9EZSTznD5Rpsw4d39p9jGYC8mvJVcVHSZBYlDSFT6kg5iNRm3qX8VqKjtCKWMALd28Dg7Kh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4590
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

