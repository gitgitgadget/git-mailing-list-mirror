Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5718EC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbhK3OO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:14:59 -0500
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:8481
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236954AbhK3OOw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:14:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpPqjHXPFTALlAfcGYYVQS0IvITeeUxBHh7ZYWQHZgP1JZHTSXr0/FSwxj7c51rCan1UlcG2/JFobgaRlyE2tAkN2svJFLKlUarPuKxmpupAS49A/t6hkjeUumLuWAra8jjTCd0Kc1rQ47squU25vYLWiK4/33owlRMU61xOkdRX50NR1L1UM9S0pSPq6nNh5/nbk6qY6Et2aUg+k4Xp7n8JbJEX4REgSAtJn+RWulegRrCjkTN4z8rM9fgpNq5v+MziCOZT5OECHYX8y8U2Ewq/W/8N/dmvw1uPoNrfls4bthQtdbT+4+SzSPHUb+Le/gAYStWoDB8zshW1CCP3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRZHm4oyw3rcqEpk5Et3zIGO7W3mYBS0JOU6Fk/tIkE=;
 b=WJqj7QycjqWWY1Cz9RjLRNthaqGDuMeI6AtAzWW7cMK+3EGrNclba8LHx72qv8FRkJa47QU+cb7DsjmOANJ5fvs2Z90Kj2Kp0qXM14eFnwq6C6WytvuWekyWCNyLGSkS0HeK51VO91OU9j2ybpHD8d0nkPa4Kj4V0RZvUN24NHyiz6Wq4FIngwHEiXRRxtHFKFEq53rtuuI17FBHHElJskxcSnbLhNRTomGSyM4ZuMoH+RNd406cDuKrABj8yK79hIIKkjHZJAvP904IJ4yeI1PpC/5JDJxXYrqpvKwABHhl+JqtpC3lgnvZZuCdwdgQ43lRWqCG05U+BRDIhFzEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRZHm4oyw3rcqEpk5Et3zIGO7W3mYBS0JOU6Fk/tIkE=;
 b=Nnw5TMotfQsDjsihW/4zRNATo2hNa5ACzNtBJWVsX1LSsstUrCaKO2DXgP5rl0uEhu79sFLA0hiQEJT9UDHTDbygou6Pl3VXI+uVgT64lJypfRwnC2vm2w/bgGxDzTa6BDRk2pobQ3TmHN5gOCNo3xbepA2qOOuPcKT7cfoA1hU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:101::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 14:11:31 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 14:11:31 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 3/7] ssh signing: make verify-commit consider key lifetime
Date:   Tue, 30 Nov 2021 15:11:08 +0100
Message-Id: <20211130141112.78193-4-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130141112.78193-1-fs@gigacodes.de>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0100.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::41) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM6P193CA0100.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Tue, 30 Nov 2021 14:11:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 826d1e2e-9048-468f-a0ca-08d9b40b4ecf
X-MS-TrafficTypeDiagnostic: PA4PR10MB4590:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4590B1CE49B01480BC8857FDB6679@PA4PR10MB4590.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqSw0SkQbwLCOb+/o7BZ//TqHqDiNzsF5LkMxiOg8MtGLMjdrlpWh9s2dMDZIefAo0Zo4rp7xjCDok2gmvFz/unitdxA4CcsDDlONWa79sas0sjrI36ew0ZKW0RMkTjo6y5cQKg9JalqHhdmY+zbuFt3L0Rgf/CtEfEeyBVN4AkUM3zyZvpk0mhtgcRgoXkAbb+qPNUQFaGxVI2DlRNPhNzgvwanRZbPDpEKlqEALhDK2e0FL7MDNF0UhVVNfFnfc+jXLwNDwIBjn1RG3ffsg4q3p48uRVWZIYBCbe/bMg5i7aPpoDDGH9g0VKuHH7LRBfNjZdZRp5baJVzxis/oe5UjDWmdNe/MqGdvBDp9Fu5SZelb0fkKXE/OUf32sUGhXNiucZ6WlPaGvvmB9vju88LAXeQ46f1iQWZ6UMfP8Jh+CLq5XMm6hkHmlAEFC4djB2DutwRNpm5+bdcMbj/9AyqQ6zq242JnU04BtOiUZ6oxsfUQdDJKp6scLEr/yKMCSchwN1NGH1A74JxrdJUFNUH1ry1l72Ka68ZsfM+MvSsHA/khkd6FKqcPmW4lukDamXCOKRkiYpFhXPTynZU6jZV2FHbfiFdFZC4uxzQHuvhLKHhTl6gib8uM5hCafAE2X1T1fAc0HeerSOODfFYyvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39840400004)(396003)(346002)(366004)(54906003)(186003)(316002)(66556008)(66946007)(66476007)(6916009)(2616005)(38100700002)(5660300002)(15650500001)(508600001)(6486002)(107886003)(6496006)(2906002)(36756003)(86362001)(8676002)(8936002)(83380400001)(4326008)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rm5nZEcWT80yBiCnj5QxNhRuFf1HlmR3WWoicLNWGOFDk0Imxq2+LFty9eJr?=
 =?us-ascii?Q?1yxofCuXxwyYf7jNCrU7wbRgPyhB7JuESYQKcZK46omMbg2h+zfN2QykrHV0?=
 =?us-ascii?Q?9MDPueTDbUCau5BsTx4UGITxLUuk/HVp0QEKcJzxAhKQjrRq+Ps7WnB1GUZn?=
 =?us-ascii?Q?oln7dITOFr7Rtgq+csaLlFFwitPN3BmGBV7XQMYxyZHwUmpwrMrDnPij6vHF?=
 =?us-ascii?Q?/7H+jJVLTjn3OJRlfqoK+9DFOXqieyDWy/roOoyTtDncPQA1PBBS3PlX511Z?=
 =?us-ascii?Q?h9vH8gQYDAPHEYvMIcQ1Yn5iRH9xX+lWW4+N+lLe+G1s8tZI8RjYFa4VDHKi?=
 =?us-ascii?Q?QlwXr4rZYz5gokrYTryUzAB1WbRGJf9KSQ7eRLap/ziViMbyyg+Jhw2xK99C?=
 =?us-ascii?Q?5cKOkgq/R/JeGAOqCgYOFLxjXAsyPRkXhu2c0F/yb4K3QRLD4qLKv3fCtFD6?=
 =?us-ascii?Q?VoHe3yt2bJec9o443j4zwbQ4CoTUa6G8Lg1Hie3oUllhLahMIciYfNau+3NB?=
 =?us-ascii?Q?rlIVLqSs18MfQOfV0yfhjmY0DvBkOiryGRxyEKl9zv608iMvlPImNsOm6TbT?=
 =?us-ascii?Q?AcNgF5H1pckQ2gl3vRdXJ1ujdIqCit0c3TEk0f7z0vj44LQ7axxHyVHkXOwd?=
 =?us-ascii?Q?h7WXxumfGq0nFFfJ49mskXoByf+gE2uKx6Gu/wsNpAPJ12DdHV+FFbcKVhQk?=
 =?us-ascii?Q?ShixhykNiWKZo0dNNXfaAziZ1Dq+8SINUqSeZFPiETjgtcbE2PpxIyFzuzdQ?=
 =?us-ascii?Q?/GXGyi/YEjiSiw98X4G0HibmBUkDY8Dp/MofNVRK+J3WSihf2fpiPCdMeZx7?=
 =?us-ascii?Q?IzBw9ZMv1XyCeL9XHe4A6Bv2LQOfOrV3CFIpmIjP5k57HkcGYTJMjuBF0xbb?=
 =?us-ascii?Q?y8KHiSoHJmK9QhxdeGE2xGa44Ej0ZC165UbR31u3G70vKc0EVCPBaqGUAfB0?=
 =?us-ascii?Q?K1LZQrdOkfNWJaLMhDHW96zLRGz0I4llGkij6F9nJp5dTswZU43A6pIigxv/?=
 =?us-ascii?Q?gy0CjZ0/u3Ud6LJgWjZWy9+r6K1Qivr70GdSUn7PI0F2EYrzB6E0J8NhIphI?=
 =?us-ascii?Q?CkbauLih763ndW6r0YUgRFzbgcrsI62xh10uQyCyz55HBJg4olSXt/W39hCJ?=
 =?us-ascii?Q?2D4hf0owzUEDzZyJAa/PXiuva9TU4rMkKIE7I8AvtrzKgzxKrXZepdEqfQ1P?=
 =?us-ascii?Q?amz5AhHhYlsfABFxXP3KiJ1eGSVPKoJMNiEx/aetd96506YCgyKDnArCq3nZ?=
 =?us-ascii?Q?m4GSeoF4oOVI9FxhLOPpU+VkMXlIEwi3tgRZmvuX36jVjPHoyeeJpHniEkI5?=
 =?us-ascii?Q?E77H3kb7c+QqORpIcG/YVHFiMdOxiVdnm/7JbAejnzx1TrwA8nR4l4C/LFFk?=
 =?us-ascii?Q?tAPGi/PCGLRW8NdEmKvW6FaJRX3CG8Th4af+CWjJk8Jxowjp9JUUxkWBacuU?=
 =?us-ascii?Q?Ord8W5QYxe3uXfbiYVsO7fUPcMbHo7BK6OSnw+e8u5N6ZXhPqSiQ8X0jtsPI?=
 =?us-ascii?Q?Y4BgUs7gJZN0+YGB7qdsZzq7h3gIl2lI8kwErkku/zl4cepAhkErLHYeWzRo?=
 =?us-ascii?Q?5xyamXRaGh9ogf7eKZfZPldRmT9SayRY+oFWJFF0Y6efVgXj3jNw5bfeRtvZ?=
 =?us-ascii?Q?yCAPHW5UUVjy3TH2Q+tNzHxWYjD0tUjzwMYE8dE+s1EoWyepVt8PHbaVXKgy?=
 =?us-ascii?Q?BG6s32QCYkY0l0Pkc9nXrzPs5zcidlL8XYgy2gHEkZ9vtTR1klMMl6fZaAl1?=
 =?us-ascii?Q?sJG1L+NP5w=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 826d1e2e-9048-468f-a0ca-08d9b40b4ecf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:11:31.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nor4Y/J8iwODK9Ggg7PireUs08O9nPzCUw3iXvYzEhx1yuBEKDogEyBH5K0U3njCu+ION5sI9ykAf5ltHTX1x31KDoWoFAYZSBRSNzTHO9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4590
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

