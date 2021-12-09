Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C28C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhLII4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:56:32 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:64384
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235279AbhLII43 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:56:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzDjnIcmI2X8ObI29JeWXAJ0aJjCox95p3bcRDPLyk3sMnBvuD+HQ/mBv9HjVcesURfcTCAc9j5myfVmBUUkYBtE3GGH4F03xVFTNQRhmoOgTqrmULskPoHrtptPPpDzUi3UdW1npq2CP3NrShlBqJ4NZ0tn7x/8LxVYkF40GACus+FD8vd15M/ptDXcW6zPgg2cBB01mGcn/Ly+4dlN3tUbFhlwrmqBsRqLS05GK84L7c3LAeA30InUpntzf/tJctLJDDY/eDS9LBcgR/jqtRXLSLe5Dy7xYRL/CYJ2AznZ17XhyHYCPnVp1r4Rq58cyCgOHw62m5O3m8Zexjbhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFWk7mStrYAR15pRt33iPZVLIawsSF5hY44xdMc4tQM=;
 b=SuipOQ/ab8zVZi49QmhM4vTJdVsRK7WXXrxc11B7AVcgwUAXJdF2P62GNz4lca3ISERBocyDgpQeX112dmsU30CDOspFxkPddW1Rk0DA8PQknUyRRDFTxtEB21QFvnWgD9HQmD6KlF+uFOqgOq+RgUdhpBfjTmHmVVP2v7Mcb7zZh08o5pWCOwMAv+TMYKsTpr76YDB3TKoZ8/3lmmvHLZsjOCtahbaDTfP4oQa2rhZCHASjSIZUzD+ND+SfJFLo53jXf5dOswG9tgiF8t8wngnManYy6n5Pjb92lxJioAIvQI6BAmj5a5zymfWykCIaEXb4Eu4d1GnNVnGwvSHBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFWk7mStrYAR15pRt33iPZVLIawsSF5hY44xdMc4tQM=;
 b=Zg1t/2XCgn28MhQxYsh9JO51SCIvmLDFrVX46oK39qjTGuRaF/UDyKIp6JiS4EWZzk9FACTgj+wy8wDgB9dJADFaBoDMaypv/zin6mDDsFBRkkqZp5DsyACk+b9Y4Mt/2S74DjyBiiaK5mlBvDz94x7blbCiS4F+xsNtkJjKpiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 08:52:55 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:52:55 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v6 3/9] ssh signing: use sigc struct to pass payload
Date:   Thu,  9 Dec 2021 09:52:43 +0100
Message-Id: <20211209085249.13587-4-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209085249.13587-1-fs@gigacodes.de>
References: <20211208163335.1231795-1-fs@gigacodes.de>
 <20211209085249.13587-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0193.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8PR04CA0193.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 08:52:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef670b09-fab5-4057-27d3-08d9baf14a6f
X-MS-TrafficTypeDiagnostic: PR3PR10MB3851:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3851AA3D64838A9EEA7B14C0B6709@PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:103;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tge1z2fRGInVI6CUB5PvLoA6O/wf57LD2Xxo0rvR/c0NZIwRdZ3MgVxu8nEiABQNBkvbkKpeD3QVl/Oks3On80bmvWOy8zcxNrVAa+rF/zJC9vnTeXKDVehcH3KV5aVqIdn+I6PFFXLi7wUWT6WxrwPLo3HxTUUeciqdHs+pT4yOdZ7t2tTj+x7Kikc8XpABjVRpXNlhYlGsqt/iDzK56OtGIp88EcJYopumr2viE3kZMP2i6leK+0WnuweXqBKiHIBKmoeDm3/ApypwUhlfi0bhCf/Rg12C32H+dBH+npXJl/2ZW8tJqBET0kEONSrN0DUPbzWKRVRzpFOsAPf1cwTeo3ehwc0M+xQpkfe7KIEjkAjBJppL7g8mwuANoK+NseL/Y7sIKThGpFC8RB6voLUb3t5vDfDUrDjtp7HDQxPxiyQEH56mi+S9MaKSSPBxXS1UsbgMW5IeKC5RQiQkHC7pr1OkKagNOyQOAfBMFGn/wEnBN9FjWaFBdmSGdIAMaC5QFy3wrMTahFFsNo82LZcthAq7RoslfSOk6Z+8MS6t2YGCpRvtYh1Bah4Ba84i+iFg+K4JN7Z+pFYVDV6A7zuX+ImUFLwKyNsILBuqUNbI5b3tlNrTNZv+4WHinuwF55HYcv2g0pJEYPYyf7yoJTxbUWlXrL5NkXuj3HspYQrFpx/hgb5b16y3R9VUYstSpzpoemq/IQj0PCwHYHF3r68BtoekL9KwcJZbjU5DiRt/PN4bV0s2nQldRbfoJJhxLpWw0zMo3QD+/Z8PLl/yLo4WR4o+x2gYs6yoozer670=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(366004)(346002)(376002)(136003)(84970400001)(8676002)(4326008)(36756003)(186003)(316002)(6486002)(6916009)(2906002)(86362001)(1076003)(6666004)(2616005)(66946007)(6496006)(38100700002)(83380400001)(66556008)(8936002)(508600001)(107886003)(54906003)(5660300002)(66476007)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?es4TnQE4tmJdhFJZyciIl2Ck4sb38h+i2Hceia4+C1oJNEslNTUtqkgyGBVB?=
 =?us-ascii?Q?/JYUsXLbLfcUoXOZeDTqKfdV+XbHAzjS0RldnAyEfE2gx+0yhxvlpb8UhzPn?=
 =?us-ascii?Q?5Y7hzgk60bax6LJUtXfmIBNUaWuFI0a7cUqO1gxSUlSdS2Ajuih3HEqHv4NP?=
 =?us-ascii?Q?xgAL/FrsRzP10DuIujGcW+5lnWGajz33amsBNtTVZ7AFHSsS23UxKhOiosta?=
 =?us-ascii?Q?vdS0Tm5BgPAH+LSBJcpi755ZpDvcxagyLNMPXe+5WqgXnfUrnXlQGGVKYBXc?=
 =?us-ascii?Q?mJnrDYQu+KDMIPld+DqkUFpe8HvjHZplv/XYswgBzJDvSP3brkkTliLbxhCd?=
 =?us-ascii?Q?7RiSsIipkUp50pmFZlcvumRisZ6wxv6tvvTOjj+4LPmHrj60URrxRvExLmQR?=
 =?us-ascii?Q?b/M6COn5h7QkhY4LR7piJ7H8tU+vuooLujhHJJ9lSC08DzcXh79ji6BXySzr?=
 =?us-ascii?Q?9f3lifo14psuT2y8ZekCk+t9YQ63++IZynig/+TPa/tYFQHkxYfFoWakLHcW?=
 =?us-ascii?Q?RKnXhbIt/jpXzLZeRLdM6VVe5SohOLn365jsMUpIvyigtzfawcuYd16QwBTT?=
 =?us-ascii?Q?rYBwSfXYlUvNoMWTNWKhRkZDkpP8Gfj/JEoFsxV67rz3plzyMNk7ItmtrrO6?=
 =?us-ascii?Q?3ykJSUZI5urhxwZGc8pk5XcVpieAPkN+R+dl0fZxuEL1Do2bHEu9K8qmOHyc?=
 =?us-ascii?Q?3+r1xYVt5uqXdi5e1iTxG0SH0yu5NBFWgRaBzauHk9RGdKDlY+CLyLPF1KY+?=
 =?us-ascii?Q?w209l4lD27Afj+ZkbWgzXtZ2nRlY3ta3xoKbbexw5gDhMm8bchQJB4f0QX3n?=
 =?us-ascii?Q?7hr/rH5NmcPwLxQHuW72ddHspRwq8B45dQUx52fzOU8kpxqrKAsBBXRRElhD?=
 =?us-ascii?Q?/oF5ABEoi22g1dnjkL/V5rmIRgRd9wX4R9KVFuudhIckgj9dNNNeHYpVDmRk?=
 =?us-ascii?Q?ieyZatyaVzh9d380ZdYbxFda7EJJuWRpiUgMl3Azr8KQIXF3BuLulm2dtPFl?=
 =?us-ascii?Q?QEL+i/sc7mBtf1MYWvWz6wfKPqiscVJMfeytiHhDPWnb/5A5WVHrclZtA0rp?=
 =?us-ascii?Q?OZodA1YQPOPzGQFbgjRlURfEVDbNg/2O/krR2ZjnwJ/k4TFCHZNZbYNqNDTt?=
 =?us-ascii?Q?my+k21wrhktUXAL0ZJclK2yvd6KVt2GgG8q5TiwLJClOZZ2uOy14yD9OMuJr?=
 =?us-ascii?Q?z86cdDY5Ja/47uSUxTgpqoJPvGQwZ+cSacXIbGMbAZW8y22MoQIHljR/sqQ2?=
 =?us-ascii?Q?EWR3YffvbBqUvUsRZB0XcQWV2LxDICyrTzy/aTrm9jeFTu/5ZXhgcqRWZmnA?=
 =?us-ascii?Q?X0NyrZrXYRaCi9QIn2PkumDBMk78O1T8VaaPVsrefr09wmeVbhacbXa6yU+R?=
 =?us-ascii?Q?oNngfn5yoc2KyFGKzGmOPoqMzJ+oyY2PYxAD1Y/dspXUT7T8tfYavb/CfUXg?=
 =?us-ascii?Q?gy9k3R+iQaPsOpGKV/PXudt6pjIMrzDdbgR28CT58pTw6/82PHgoOLF1ZnyN?=
 =?us-ascii?Q?beYqaVpeJVEcq0D5R5qExZhEfqD+HeOUJdGD4xV76+Kaw9yGg4G5mjb+G05G?=
 =?us-ascii?Q?ahldlLy+z7qiTR9lFukFk7I4sNzziq650ze1jj55kkhjvSZf+IS/acDw6VbO?=
 =?us-ascii?Q?sXNGIURP05chLBtRA+QtJAwtZ8tUYYM8rC0Orfbr7ho2Yp/V0TMt5e1lxLwN?=
 =?us-ascii?Q?quNp9Z5D+Kt6gM/SAC308mcugGt+IlG8eOv/lnPnuGbuElmLLLriIBI6Jn0t?=
 =?us-ascii?Q?gsAGMnz0cw=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ef670b09-fab5-4057-27d3-08d9baf14a6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:52:55.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcfaJwq9oL65kj/plb/hwDGR+UXeU77CkZy0M0cWqO7nNLNN/ovWwikTJtcZdyG0vddYbs8e3cRxaCUQqqanjTw7syKdqeOvJE7sDm7hJz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3851
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be able to extend the payload metadata with things like its creation
timestamp or the creators ident we remove the payload parameters to
check_signature() and use the already existing sigc->payload field
instead, only adding the length field to the struct. This also allows
us to get rid of the xmemdupz() calls in the verify functions. Since
sigc is now used to input data as well as output the result move it to
the front of the function list.

 - Add payload_length to struct signature_check
 - Populate sigc.payload/payload_len on all call sites
 - Remove payload parameters to check_signature()
 - Remove payload parameters to internal verify_* functions and use sigc
   instead
 - Remove xmemdupz() used for verbose output since payload is now already
   populated.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 builtin/receive-pack.c |  6 ++++--
 commit.c               |  5 +++--
 fmt-merge-msg.c        |  4 ++--
 gpg-interface.c        | 37 +++++++++++++++++--------------------
 gpg-interface.h        |  6 +++---
 log-tree.c             |  8 ++++----
 tag.c                  |  4 ++--
 7 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d960..61ab63c2ea 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -769,8 +769,10 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		memset(&sigcheck, '\0', sizeof(sigcheck));
 
 		bogs = parse_signed_buffer(push_cert.buf, push_cert.len);
-		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
-				push_cert.len - bogs, &sigcheck);
+		sigcheck.payload = xmemdupz(push_cert.buf, bogs);
+		sigcheck.payload_len = bogs;
+		check_signature(&sigcheck, push_cert.buf + bogs,
+				push_cert.len - bogs);
 
 		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
diff --git a/commit.c b/commit.c
index 551de4903c..64e040a99b 100644
--- a/commit.c
+++ b/commit.c
@@ -1212,8 +1212,9 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
-	ret = check_signature(payload.buf, payload.len, signature.buf,
-		signature.len, sigc);
+
+	sigc->payload = strbuf_detach(&payload, &sigc->payload_len);
+	ret = check_signature(sigc, signature.buf, signature.len);
 
  out:
 	strbuf_release(&payload);
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5216191488..deca1ea3a3 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -533,8 +533,8 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		else {
 			buf = payload.buf;
 			len = payload.len;
-			if (check_signature(payload.buf, payload.len, sig.buf,
-					    sig.len, &sigc) &&
+			sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
+			if (check_signature(&sigc, sig.buf, sig.len) &&
 			    !sigc.output)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
 			else
diff --git a/gpg-interface.c b/gpg-interface.c
index 3e7255a2a9..75ab6faacb 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -19,8 +19,8 @@ struct gpg_format {
 	const char **verify_args;
 	const char **sigs;
 	int (*verify_signed_buffer)(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size);
 	int (*sign_buffer)(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
@@ -53,12 +53,12 @@ static const char *ssh_sigs[] = {
 };
 
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size);
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size);
 static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			   const char *signing_key);
@@ -314,8 +314,8 @@ static void parse_gpg_output(struct signature_check *sigc)
 }
 
 static int verify_gpg_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
@@ -343,14 +343,13 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
 		     NULL);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
-	ret = pipe_command(&gpg, payload, payload_size, &gpg_stdout, 0,
+	ret = pipe_command(&gpg, sigc->payload, sigc->payload_len, &gpg_stdout, 0,
 			   &gpg_stderr, 0);
 	sigchain_pop(SIGPIPE);
 
 	delete_tempfile(&temp);
 
 	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
-	sigc->payload = xmemdupz(payload, payload_size);
 	sigc->output = strbuf_detach(&gpg_stderr, NULL);
 	sigc->gpg_status = strbuf_detach(&gpg_stdout, NULL);
 
@@ -426,8 +425,8 @@ static void parse_ssh_output(struct signature_check *sigc)
 }
 
 static int verify_ssh_signed_buffer(struct signature_check *sigc,
-				    struct gpg_format *fmt, const char *payload,
-				    size_t payload_size, const char *signature,
+				    struct gpg_format *fmt,
+				    const char *signature,
 				    size_t signature_size)
 {
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
@@ -480,7 +479,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			     "-n", "git",
 			     "-s", buffer_file->filename.buf,
 			     NULL);
-		pipe_command(&ssh_keygen, payload, payload_size,
+		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
 
 		/*
@@ -526,7 +525,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 			}
 
 			sigchain_push(SIGPIPE, SIG_IGN);
-			ret = pipe_command(&ssh_keygen, payload, payload_size,
+			ret = pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
 					   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
 			sigchain_pop(SIGPIPE);
 
@@ -540,7 +539,6 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		}
 	}
 
-	sigc->payload = xmemdupz(payload, payload_size);
 	strbuf_stripspace(&ssh_keygen_out, 0);
 	strbuf_stripspace(&ssh_keygen_err, 0);
 	/* Add stderr outputs to show the user actual ssh-keygen errors */
@@ -562,8 +560,8 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 	return ret;
 }
 
-int check_signature(const char *payload, size_t plen, const char *signature,
-	size_t slen, struct signature_check *sigc)
+int check_signature(struct signature_check *sigc,
+		    const char *signature, size_t slen)
 {
 	struct gpg_format *fmt;
 	int status;
@@ -575,8 +573,7 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
 
-	status = fmt->verify_signed_buffer(sigc, fmt, payload, plen, signature,
-					   slen);
+	status = fmt->verify_signed_buffer(sigc, fmt, signature, slen);
 
 	if (status && !sigc->output)
 		return !!status;
@@ -593,7 +590,7 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 							    sigc->output;
 
 	if (flags & GPG_VERIFY_VERBOSE && sigc->payload)
-		fputs(sigc->payload, stdout);
+		fwrite(sigc->payload, 1, sigc->payload_len, stdout);
 
 	if (output)
 		fputs(output, stderr);
diff --git a/gpg-interface.h b/gpg-interface.h
index beefacbb1e..5ee7d8b6b9 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -17,6 +17,7 @@ enum signature_trust_level {
 
 struct signature_check {
 	char *payload;
+	size_t payload_len;
 	char *output;
 	char *gpg_status;
 
@@ -70,9 +71,8 @@ const char *get_signing_key(void);
  * Either a GPG KeyID or a SSH Key Fingerprint
  */
 const char *get_signing_key_id(void);
-int check_signature(const char *payload, size_t plen,
-		    const char *signature, size_t slen,
-		    struct signature_check *sigc);
+int check_signature(struct signature_check *sigc,
+		    const char *signature, size_t slen);
 void print_signature_buffer(const struct signature_check *sigc,
 			    unsigned flags);
 
diff --git a/log-tree.c b/log-tree.c
index 644893fd8c..a46cf60e1e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -513,8 +513,8 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
 		goto out;
 
-	status = check_signature(payload.buf, payload.len, signature.buf,
-				 signature.len, &sigc);
+	sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
+	status = check_signature(&sigc, signature.buf, signature.len);
 	if (status && !sigc.output)
 		show_sig_lines(opt, status, "No signature\n");
 	else
@@ -583,8 +583,8 @@ static int show_one_mergetag(struct commit *commit,
 	status = -1;
 	if (parse_signature(extra->value, extra->len, &payload, &signature)) {
 		/* could have a good signature */
-		status = check_signature(payload.buf, payload.len,
-					 signature.buf, signature.len, &sigc);
+		sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
+		status = check_signature(&sigc, signature.buf, signature.len);
 		if (sigc.output)
 			strbuf_addstr(&verify_message, sigc.output);
 		else
diff --git a/tag.c b/tag.c
index 3e18a41841..62fb09f5a5 100644
--- a/tag.c
+++ b/tag.c
@@ -25,8 +25,8 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 		return error("no signature found");
 	}
 
-	ret = check_signature(payload.buf, payload.len, signature.buf,
-				signature.len, &sigc);
+	sigc.payload = strbuf_detach(&payload, &sigc.payload_len);
+	ret = check_signature(&sigc, signature.buf, signature.len);
 
 	if (!(flags & GPG_VERIFY_OMIT_STATUS))
 		print_signature_buffer(&sigc, flags);
-- 
2.31.1

