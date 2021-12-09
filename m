Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD561C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhLII4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:42 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:64384
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235337AbhLII4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVVOgVus388z5mrjTJeqVU3/gsM+vIE5qrBeZ4PzHHxtbTHpKKwq9zUDQqcRDiGpslkgEPtZ13J/AeRgD/JL7OT9zIZ+m0jn6t+QIj+56V5+SVTGhenjdO/inVHC90Lx7MtCxSv1/7SMbmgURXTZYjlhqiTYd03OePUbatRXeFFpOZpaheq/3nCpDRPEd68VO8Pc7ABdiGiFT6J/6mJRJ5VWKLfwCtyDeQc3dsxsKVLRBLLj+oatAQk3Z02zwC8R6K6xoaMOHKeps6s1mub3JPwmFVTGh0EcNvvoguuoy2XUzqrErZwj7aOlhkg9nJXSpfAEDsBp2A6liR1DoAbbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRZHm4oyw3rcqEpk5Et3zIGO7W3mYBS0JOU6Fk/tIkE=;
 b=SCvU0YlSQiCURobWofNTeVX+tqqTBrJF2gt4Rbn8NVXnc4APCsKhnUieVgwoirfJxEUYWxc54Ilu9+PZAg6F5D6knIKo6+RrTkgbllvMRs82yvIBS0DMygmbv5JqX41eAov/ZYwuCISct67MU2KwLbw2CZf36MumcAYcvM7d+zcRfiMQbt81DVYW6g+nOKSszoD/je2sbykmjNvEudTymFlCcmsQT5RVG9plsDaoi1gSS8YcPdJ2lSdelxYoGPvUE5LPxN9wI2N8mW85HZok1UH7CFr6GTveVs+3jKuczc6yiYuzls+tjZ8wAbIeo6it3dH8cBP2p326CBeS/9BU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRZHm4oyw3rcqEpk5Et3zIGO7W3mYBS0JOU6Fk/tIkE=;
 b=FQX89TjVO8jW/MF/V+rlYScv3MrzL2dl59elLW4RkQt9ON3VslbuATziV7SfrtixkvvDW4fGJlZBDhNCXkMc9voVHYglBKJnmOaqA8gl8gnaQnF6K9FVEBbHhPSqgM6rS3FwfvAUSBg45NeY6P4cdVv2eqdOd3X7mPr+WDAcDdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 08:52:57 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:52:57 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 5/9] ssh signing: make verify-commit consider key lifetime
Date:   Thu,  9 Dec 2021 09:52:45 +0100
Message-Id: <20211209085249.13587-6-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209085249.13587-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
 <20211209085249.13587-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::36) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 08:52:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff169e95-be0d-4671-ec68-08d9baf14ba4
X-MS-TrafficTypeDiagnostic: PR3PR10MB3851:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB385144382DE844D4EDB56108B6709@PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BrEIbPZhAHp0s2CbeOEZ3n2O4E2h1u1t6ZgcjFI1/AnQEqmGz8z6HD/uB9fwUdZna+973Yzh3ZTTB3cbir+RtdhZzi6Hpj1Eowmx4Juqi5CFckmcIvKvx8/3cFUKHEDEMseJWwKjMY5YWf1uY/ZvATXPqRSTrqRdzt8/zUmcgG9BZs97YHbcDy4GAdPqayXzrBwV6cyRV9kRp/ZGZ3eLtA9d/0zz7uBPITv9GsdrDnhM3PyShLW6T3LNtc+alv2uYp6xv+/sH5XvDR8ZvbYDX4IyzOJP3VGzFSnVl4JU62SgQCfvA8Rm7UQkZ0kaiNn8fefKVKbMtKSif0fKZfUuFmD+NgXCUC0WaJx9WuwZ0gGDksIYxk3pn4h7Scu//YK3zxm+rk8jhfrjz7zXuY+6f2WD42Ldi7+s8dvOJlsukxt5XF705MCXNiEp+noQFeCH6t7CseylN3UMddaOXPEeat6kKNtC0micTDxhIkbp+oA2aVb1SYERgLTK/SYRonvwDgiSucBou9dowFwRkXMyWaN8Om9MxJG1IuPtStMjCxLcV4VfrXBNlTMYaKsMMDwRp2zewDFKw9IwDCyeucqbwDjVKmIgBKZdGyUY+Yc9nilC4FzHtT0x+DGILyjiOat611+sZTwlHUwbzaguDOQOcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(366004)(346002)(376002)(136003)(8676002)(4326008)(36756003)(186003)(316002)(6486002)(6916009)(2906002)(86362001)(1076003)(6666004)(2616005)(66946007)(6496006)(38100700002)(83380400001)(15650500001)(66556008)(8936002)(508600001)(107886003)(54906003)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5czyKk9gXtwvylOel7UrcEWfwqStyRFWRIB4cRMChKlQCo40KqWDNiMrn5kJ?=
 =?us-ascii?Q?NHV6hX1JVqpIa6bCpE3oOPCO+GGd/lQ0wMjYzIY1YCgEjIyzC73j91ljWNeG?=
 =?us-ascii?Q?NrBdn8f9K8+yDIaPgeJfLRo9GK+ALxwd3tmkxDs+VeTqec2NP2GIR+/zbHk7?=
 =?us-ascii?Q?eA4mhbyqbhfpaI9OA0PrCiY5LgXvxs5IqS9pqMTY3etcGX93MmMv1ugih3Gk?=
 =?us-ascii?Q?9cPhO4G+9NgWI5n062RtG5p3+vRRloUBSf03fp1Snz3FMGHz4xuNS4ARalab?=
 =?us-ascii?Q?XrpGq7LAwqgDE0rvSb0S0NpoUIx7st+3oiCcuyrGu3AHXst/2VHrnfLzglXb?=
 =?us-ascii?Q?auQt7ntwJFL6Xd5q9GV1ZUVzLOwlbeyvdo98X2Um7qZZHy9wh/CMn3vli2bD?=
 =?us-ascii?Q?02V/XYH00I09XSZKn8LUGusJzU8nDOy5jiryaJiL9xF9qsuNkvyU4B6ZfhZ5?=
 =?us-ascii?Q?nDy2MBNH7zGCduGV9V+/RgwYnFniDwPbSZ3Yi4u96lw7v1Mikgb698jIDevi?=
 =?us-ascii?Q?xPGPVSuN1epvmrqyB8wEb1JHUiTf4GPsjNYHIxopoXmsraBeVypCNe4oRUVA?=
 =?us-ascii?Q?txN7mrMg0V4hPBjirUZ+pstJ8WUv1Ekh98vYu/jvE3bVwZir7UGG4I5m0Dps?=
 =?us-ascii?Q?AdR/bY9zFLnr0BnTRTdwGhAB4a5jjVP24FUI+Igv5deA3FZ6qIdiS2045kuH?=
 =?us-ascii?Q?G8uXDa9VZDA1/iWFPnR3kFNphzwIAhGFnAWGz8ZJt3XXvY/oIJkC3W2CdyeD?=
 =?us-ascii?Q?+C1Xd66GMpt9MevCmyz91zTgK1TyEMCoHBPPmyC8sogDT4ORFueBxlprJDcn?=
 =?us-ascii?Q?R4/FHgwUXGRG9gojRv2qgUeFj7FhSWu5f5IBP3eiyE9kXFqhZdVPw/7PPixi?=
 =?us-ascii?Q?YhJXAay7FUjpvDg064Y0yh7O+8ohPiErYqJNYXQxRhWVPOyfLnngVfNMDxH5?=
 =?us-ascii?Q?IkYT0pCGb9cqKaebPWi0+q7xuVzr1bsyUtWddxFyZrODUWR1MrJohEgQWyGg?=
 =?us-ascii?Q?nN3+B2XcUZ/LtOKOmVkUuiwrxLHyLJfzH0ePtMM/w3v+y3F07QUvFmCBiYka?=
 =?us-ascii?Q?u6DterLQCEr5HN0uPR5sw1ihMLppstQnwr960Y6Ahy30mdPzGqGa6OADLIeo?=
 =?us-ascii?Q?pQSn3fqHPVsaV4IyBmK8iO5lkbcfPs8m5ZLNXc43mEqmdAz/WzLFMZYPZJxC?=
 =?us-ascii?Q?WNwusP6vVqK4WL8JizUeTTWVpbvrFjRvTGjsuTpFclZLktiWTqTBAP8SyT3Z?=
 =?us-ascii?Q?weTLSYYHKbGpKg+rsOxKkskXT3sI+AvlBLqkD5V/yij1R4TL7i+m3oq+//bd?=
 =?us-ascii?Q?reGcSx3YljPj+NY2PSod/0mck56v4QNQz+XDud9Iz70fSO2Io1RzUhHDBko1?=
 =?us-ascii?Q?+FPMThCRSCmWSrDYJMXb6oElwAtwdR7vfmXZSMBTVans9Fnz+gxLzHtgzHOV?=
 =?us-ascii?Q?QxtNJu67RhwiFR0ifMxHBnS+1FanNgsqJekSb6kqpIfzoCJYuKh7xGft8I2X?=
 =?us-ascii?Q?2pbh5V3/9G6eotTcih6thZJv2LTrHvGcg5nJx3hfVZHtL1QpmScOIP5f4RIp?=
 =?us-ascii?Q?U4SeR99ouLgIs/KiJJVt1Cbi6F6jO9vmwOVu//IcWkLGLYlVKpsHi9WphkdW?=
 =?us-ascii?Q?yW3WNXiZMpGkCT+zjJyy2/fTE7arACe3yrUdNzW2dCYAbot4QRxxZshUYpUQ?=
 =?us-ascii?Q?Q7cwDzE2n4gqapUX6KHH10FeZ709ROIeMIXMRKL+zwU6fMu8qdTiGzOAuvLY?=
 =?us-ascii?Q?YLzZ1vHjXt1ROAcSaCp9KAnn7H/FsZ8=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ff169e95-be0d-4671-ec68-08d9baf14ba4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:52:56.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9A/eT3UPqwOfU9O97A9tkb9kCvbJdrca8zj3rAFcCzmXKB36DowbCnOwuGkUKLtjEIWlpthySuxp3bTCLsI5LE4oyhMhci7CxYsYgHH1do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3851
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If valid-before/after dates are configured for this signatures key in the
allowedSigners file then the verification should check if the key was valid at
the time the commit was made. This allows for graceful key rollover and
revoking keys without invalidating all previous commits.
This feature needs openssh > 8.8. Older ssh-keygen versions will simply
ignore this flag and use the current time.
Strictly speaking this feature is available in 8.7, but since 8.7 has a
bug that makes it unusable in another needed call we require 8.8.

Timestamp information is present on most invocations of check_signature.
However signer ident is not. We will need the signer email / name to be able
to implement "Trust on first use" functionality later.
Since the payload contains all necessary information we can parse it
from there. The caller only needs to provide us some info about the
payload by setting payload_type in the signature_check struct.

 - Add payload_type field & enum and payload_timestamp to struct
   signature_check
 - Populate the timestamp when not already set if we know about the
   payload type
 - Pass -Overify-time={payload_timestamp} in the users timezone to all
   ssh-keygen verification calls
 - Set the payload type when verifying commits
 - Add tests for expired, not yet valid and keys having a commit date
   outside of key validity as well as within

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 Documentation/config/gpg.txt |  5 ++++
 commit.c                     |  1 +
 gpg-interface.c              | 53 ++++++++++++++++++++++++++++++++++++
 gpg-interface.h              |  9 ++++++
 t/t7528-signed-commit-ssh.sh | 42 ++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index 4f30c7dbdd..c9be554c73 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -64,6 +64,11 @@ A repository that only allows signed commits can store the file
 in the repository itself using a path relative to the top-level of the working tree.
 This way only committers with an already valid key can add or change keys in the keyring.
 +
+Since OpensSSH 8.8 this file allows specifying a key lifetime using valid-after &
+valid-before options. Git will mark signatures as valid if the signing key was
+valid at the time of the signatures creation. This allows users to change a
+signing key without invalidating all previously made signatures.
++
 Using a SSH CA key with the cert-authority option
 (see ssh-keygen(1) "CERTIFICATES") is also valid.
 
diff --git a/commit.c b/commit.c
index 64e040a99b..a348f085b2 100644
--- a/commit.c
+++ b/commit.c
@@ -1213,6 +1213,7 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
+	sigc->payload_type = SIGNATURE_PAYLOAD_COMMIT;
 	sigc->payload = strbuf_detach(&payload, &sigc->payload_len);
 	ret = check_signature(sigc, signature.buf, signature.len);
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 75ab6faacb..330cfc5845 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -439,6 +439,13 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	struct strbuf ssh_principals_err = STRBUF_INIT;
 	struct strbuf ssh_keygen_out = STRBUF_INIT;
 	struct strbuf ssh_keygen_err = STRBUF_INIT;
+	struct strbuf verify_time = STRBUF_INIT;
+	const struct date_mode verify_date_mode = {
+		.type = DATE_STRFTIME,
+		.strftime_fmt = "%Y%m%d%H%M%S",
+		/* SSH signing key validity has no timezone information - Use the local timezone */
+		.local = 1,
+	};
 
 	if (!ssh_allowed_signers) {
 		error(_("gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification"));
@@ -456,11 +463,16 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		return -1;
 	}
 
+	if (sigc->payload_timestamp)
+		strbuf_addf(&verify_time, "-Overify-time=%s",
+			show_date(sigc->payload_timestamp, 0, &verify_date_mode));
+
 	/* Find the principal from the signers */
 	strvec_pushl(&ssh_keygen.args, fmt->program,
 		     "-Y", "find-principals",
 		     "-f", ssh_allowed_signers,
 		     "-s", buffer_file->filename.buf,
+		     verify_time.buf,
 		     NULL);
 	ret = pipe_command(&ssh_keygen, NULL, 0, &ssh_principals_out, 0,
 			   &ssh_principals_err, 0);
@@ -478,6 +490,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			     "-Y", "check-novalidate",
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
+			     verify_time.buf,
 			     NULL);
 		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
@@ -512,6 +525,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 				     "-f", ssh_allowed_signers,
 				     "-I", principal,
 				     "-s", buffer_file->filename.buf,
+				     verify_time.buf,
 				     NULL);
 
 			if (ssh_revocation_file) {
@@ -556,10 +570,46 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	strbuf_release(&ssh_principals_err);
 	strbuf_release(&ssh_keygen_out);
 	strbuf_release(&ssh_keygen_err);
+	strbuf_release(&verify_time);
 
 	return ret;
 }
 
+static int parse_payload_metadata(struct signature_check *sigc)
+{
+	const char *ident_line = NULL;
+	size_t ident_len;
+	struct ident_split ident;
+	const char *signer_header;
+
+	switch (sigc->payload_type) {
+	case SIGNATURE_PAYLOAD_COMMIT:
+		signer_header = "committer";
+		break;
+	case SIGNATURE_PAYLOAD_TAG:
+		signer_header = "tagger";
+		break;
+	case SIGNATURE_PAYLOAD_UNDEFINED:
+	case SIGNATURE_PAYLOAD_PUSH_CERT:
+		/* Ignore payloads we don't want to parse */
+		return 0;
+	default:
+		BUG("invalid value for sigc->payload_type");
+	}
+
+	ident_line = find_commit_header(sigc->payload, signer_header, &ident_len);
+	if (!ident_line || !ident_len)
+		return 1;
+
+	if (split_ident_line(&ident, ident_line, ident_len))
+		return 1;
+
+	if (!sigc->payload_timestamp && ident.date_begin && ident.date_end)
+		sigc->payload_timestamp = parse_timestamp(ident.date_begin, NULL, 10);
+
+	return 0;
+}
+
 int check_signature(struct signature_check *sigc,
 		    const char *signature, size_t slen)
 {
@@ -573,6 +623,9 @@ int check_signature(struct signature_check *sigc,
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
 
+	if (parse_payload_metadata(sigc))
+		return 1;
+
 	status = fmt->verify_signed_buffer(sigc, fmt, signature, slen);
 
 	if (status && !sigc->output)
diff --git a/gpg-interface.h b/gpg-interface.h
index 5ee7d8b6b9..b30cbdcd3d 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -15,9 +15,18 @@ enum signature_trust_level {
 	TRUST_ULTIMATE,
 };
 
+enum payload_type {
+	SIGNATURE_PAYLOAD_UNDEFINED,
+	SIGNATURE_PAYLOAD_COMMIT,
+	SIGNATURE_PAYLOAD_TAG,
+	SIGNATURE_PAYLOAD_PUSH_CERT,
+};
+
 struct signature_check {
 	char *payload;
 	size_t payload_len;
+	enum payload_type payload_type;
+	timestamp_t payload_timestamp;
 	char *output;
 	char *gpg_status;
 
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index badf3ed320..dae76ded0c 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -76,6 +76,23 @@ test_expect_success GPGSSH 'create signed commits' '
 	git tag twelfth-signed-alt $(cat oid)
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with keys having defined lifetimes' '
+	test_when_finished "test_unconfig commit.gpgsign" &&
+	test_config gpg.format ssh &&
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
 test_expect_success GPGSSH 'verify and show signatures' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_config gpg.mintrustlevel UNDEFINED &&
@@ -122,6 +139,31 @@ test_expect_success GPGSSH 'verify-commit exits failure on untrusted signature'
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
 '
 
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failure on expired signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit expired-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failure on not yet valid signature key' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit notyetvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit succeeds with commit date and key validity matching' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git verify-commit timeboxedvalid-signed 2>actual &&
+	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
+	! grep "${GPGSSH_BAD_SIGNATURE}" actual
+'
+
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-commit exits failure with commit date outside of key validity' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git verify-commit timeboxedinvalid-signed 2>actual &&
+	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
+'
+
 test_expect_success GPGSSH 'verify-commit exits success with matching minTrustLevel' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_config gpg.minTrustLevel fully &&
-- 
2.31.1

