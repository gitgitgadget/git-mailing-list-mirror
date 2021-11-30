Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFDFC433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhK3OOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:14:53 -0500
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:59719
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231585AbhK3OOu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:14:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUS6KHRtK435Hxo7602smffOqZV3a4q+6LbxIuRXLuOVW64z+lP8z0TBjc6Fs2aSrGRqoba9os5RiX+SWhszufdVAgL4O9MvifGd8uJvMH4KCJpDXrXLFec+VB4bXY1UpUJy/Y3D7V28JLxxNk8ZHqYsjnr/Dv96fC1tzKdzZuizEPuwaiu7jZw+7nfnmIKpmIIeDcfr50tffdJuOz1AbBpSZwPNvxBrqeEwuCCuf4dUnm0sn4Do5cwebENrlrGVlcJN/NBUCg2/9t5mJstak9o0YWid9+iWZf99cVK7+3Q9W7EeB4s2g8lclufEe/VLwpJwAwYRKYQGsNeLMdiZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFWk7mStrYAR15pRt33iPZVLIawsSF5hY44xdMc4tQM=;
 b=NMmb7vrU2ghgNk1Di8V56tDwkPYZOxsjgaCB3Fd4EKGnTttdERewxsQ3V86cRv1kGPmolae15uIRXITB4xxbxMUbp7FQtkabmDjsUqbh2FL6Ja35HFsnnS0jQMZP8of6sMq4AbwD2GQiriT0rwOWTmKh0UYxwfdcEy2BErjfM5D4F0g3aAAeWO9waX2aFK53gc3OVvBLQXxdXKbsfy8s+kqdCu8cHjfFvZP13qqsUjZ165gStv0rmd3P0M2XHZYS4zDUY7kL21+CSIErebcPbE/8pT7+novlmX4J7ELWUQksvw0DmmuDG3jDj2BxbpUiShIpyRhY2/Je0r8fYdGCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFWk7mStrYAR15pRt33iPZVLIawsSF5hY44xdMc4tQM=;
 b=aKiWWRK+cU5o+LAPsD9fYJCjkcmDXbGKEIyU1zldZqS4f+1RutexxqyiF7PUtv8f3R6A4Rp/2bc8ir9Z5O7upUqA2CkZ5GK6/nwdTSbMSY3Iluyy1QvP6nRgtP/lXJiyAQIQ3XX7bO6DERj36A42cqhAp71shcLTx+INzy4j07k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 14:11:28 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 14:11:28 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 1/7] ssh signing: use sigc struct to pass payload
Date:   Tue, 30 Nov 2021 15:11:06 +0100
Message-Id: <20211130141112.78193-2-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130141112.78193-1-fs@gigacodes.de>
References: <20211117093529.13953-1-fs@gigacodes.de>
 <20211130141112.78193-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend Transport; Tue, 30 Nov 2021 14:11:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f37402-6227-4e39-b0c8-08d9b40b4d64
X-MS-TrafficTypeDiagnostic: PR3PR10MB4238:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4238601A89CD47F254A9F40DB6679@PR3PR10MB4238.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:103;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lL+VRGTueYO4XcNPowWia7O8JLYna+AMfYVjz+BJlmw80nbCqGjTeT1ipB27WRrdJpIaiCeU/06k2i3NP8dPtUueGPycW7CyFGwMXOqg3GiJET+30kp2dImMJkOpV9y3hUZXSln8h5WQDS7L724RhtRk70VMH0xrAmq68G2P8nDNw4T6u1nQC+QU+QdMp0d6Vn6XkxQxGW0BGCDLeHEu8AuHrHNH27b7H53RInxYLa+eKo8uNMrTC2QVtvsnWe6wiUV/NOUIOyLnaiIa24HaIyBt1dtAQI5dov0GCxzB5jvv0BSD5RgBN7+l3mgPgPGgli47wQV1BHACYeHfjGJuANHL/Db7q4jyRkLCvZdpbhdzdifoT03Kh3HXmhUpYwBpFvGc239W+T6IigZVEGelkTPDSXwjL+j3SIaYdScxP86lOGBe69Zr47YpXIGzxxG6dXQd5/kQghFyDpYa8hI04biwaqO6PoTcjAfMRkpRM9GzUvQ/HdGAzuWKLPdp5tcM0a+Y1/cPEeCUJENccAcKG/toHl12Q7A4VXZKF+hVufSMYqxfnZV22TCAdOcsFwbH/hezb9QNDaKhA/0Cs4lvntHJrtRfRv+uDereAsiV4Biy0rdbahH8zXNb0dr3LquRqzKPSnmO12HLpc3IZa4HsDC8/lOZtLHzmV5XRBEa89xFDnZ8ZvLkpFHHKQfHrQ6xGITOPoPZT4c0Zi0mdukaDn5w5zghXoueIAByiK/9318zHOGLKrM7oCCPpx1xySmCl3J9JoZsYEUSz9hcp+5pFl7rm3G9sjw+TsEbYbI5M6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(136003)(346002)(376002)(366004)(2906002)(66476007)(316002)(66556008)(66946007)(38100700002)(8936002)(2616005)(6916009)(508600001)(6666004)(83380400001)(5660300002)(6496006)(86362001)(1076003)(36756003)(54906003)(107886003)(186003)(8676002)(4326008)(6486002)(84970400001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zZUKGkReaFYJgPCGfQPjU7bN3aOo4QCdpMDwjlr/j2wwT8RCYrDGdCcQc+wk?=
 =?us-ascii?Q?HQ3wd7NiZtWygzwwc01yPnvCt3BXKO94xGz6JrqUQV3TwifXnvXsNdbGtQqm?=
 =?us-ascii?Q?0E5SkdtSGQ8uXir2IbjPKm+xMRhYpRpjOwziRzgIVY3CvLD7TNr4QRNoolcX?=
 =?us-ascii?Q?0Oasz79sbim2tcHQw9iF1SGD7U0N6XV28FRa1OoBOqJA2OD0tjFw5ZGKrVlc?=
 =?us-ascii?Q?a5F0OH4/r9RhK0SVHBn3lCxKPZHkAhBwQkBQsgA30zby5BqpNHjQtNcghCqE?=
 =?us-ascii?Q?H5VgDKmUV62D+FUiIG67u4t1jMolKF+z55MYS/MygfjfgxGZPp2BYg4TqdKz?=
 =?us-ascii?Q?91d8bG+NW+8ncZG7lNyCw+t0M1PjZ8kHFtUrjAg0N4/kulBu+szXKReY+HDF?=
 =?us-ascii?Q?ZzYqUmIltuJnqjGx3GoHpSx+EDs3H6RRfyfFpyBmyQ6Bc/HMCWHEmf3K1Mk+?=
 =?us-ascii?Q?mIJt8aGUIIigLGoWcLhNDIfLuEtb7JGQQlBE5rbDElZ1unAQcxsLdg0bHj11?=
 =?us-ascii?Q?DEUpE8GoXrEUnqMFGsfHQVPGsbZ4r98bi59O0z4MJS+0jSHQiwaDBJCw0AY1?=
 =?us-ascii?Q?ZkCb7UfjiRPKATVS33TIu8x0ZTvPbMLhYENAxiQpEK+uxjQga1iEtS9gV0js?=
 =?us-ascii?Q?L5iZY+rVSQ1gk/pfuvFfGBwlNBWziMHpeZKzjyH2KzDVpZCX74CYT5zlVTJ6?=
 =?us-ascii?Q?QFg0N4LcHNcPwHFTOWDRg5rqQJWlzckSxjboyag15WnegOVYOjLIZ3xGnfzg?=
 =?us-ascii?Q?Sd7XvhiX3XK7pLwMRMeRo9CSzGb22a2NTEpi5Gt6JQENff9IzqgBDV10ZtYP?=
 =?us-ascii?Q?2QkfFnrJgfwocsicKzxzJ2VF6nZDwfGPXIs9KANpBSvQ/DGuRO4SYV9bwg4S?=
 =?us-ascii?Q?6/gSmAYn3dGugLRSs5igGZpQp4UxhLw6buTUpbs6k0LV83bSsaW7pyBGMVs+?=
 =?us-ascii?Q?i0NLTzQ4hgqXiSYpdrNb8+UGFNyOHdhNiJyw5z7U+tD+fvbRdXN9q7cbnr3r?=
 =?us-ascii?Q?t03i01Fpi4dvLoaJAbcSn+nt/lsUfb1yTl2z5AycWnhiKhaoilOi4TNRueW+?=
 =?us-ascii?Q?wGbTuG0vNSwLbDwCdB2zVH+CNLgTWwB4NHy2iRkTcJMxa3mhojHD9hwmHmS+?=
 =?us-ascii?Q?Nx1timDrPaUyaJcYxqZytAfqeBaSUY4681On4aPcqDlYg6PEuLYrNfdt+PWS?=
 =?us-ascii?Q?ly0BZIqBQSMFcm54VcWoIo+vC/Bu0FFcGeq30/ZuAfcfd7UFeIpm/p8yvVKz?=
 =?us-ascii?Q?TMd81HkZFrwSHCWLFPBr11MzTjeybc4TZEBA4e5vUorNlGxFXeGh3xnkN0Hg?=
 =?us-ascii?Q?cOxRSeJo5fqyAss3U4Qx0giEtLRjySb41uJZpxSgst5E0NtOtMViIl20uSY/?=
 =?us-ascii?Q?HTwKcpRyxPPJCH83JUuSHJmI2x4L6NJwDYrpCkG4KGGE9TSbZQHHKPMDbYoA?=
 =?us-ascii?Q?jD8Y7PaojLo7PcY5Hmk6+CWpwdBK3+zo04dLEBHLP4PtUDgThQHDB+26ryuL?=
 =?us-ascii?Q?4/X0cL7Uj6tptGBQjVXfCXEz99UZkWmPQqW5/gYXWtGqeDvOhHax2Ph3a4JD?=
 =?us-ascii?Q?AB8gUliLUOql3uVbKUMfT5afditiVI8m21AIzVyRVq/WuvkVNe3vDrAhAKOH?=
 =?us-ascii?Q?8mofznjwrPCzqXlyH4/OBifM1WkR/nnAYxVdSod0e3UVpTJEgwSWkg/ItzDY?=
 =?us-ascii?Q?J30o2vi9q2lw6XvT72b2dsODdxTr7rVDqpqp9CWvWYB9II5Q4l/Ant1hoL30?=
 =?us-ascii?Q?gZVztNBsGQ=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f37402-6227-4e39-b0c8-08d9b40b4d64
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:11:28.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MClA93sm+gGqk3dmfSwI6aK6QNFWpLTl/5YKg7iz4FafRBg8Nd64gZPC+aQPVVnU/knOuJ6Kim1NpV5ZH8AC5bONnoTZo2IAE+krHmnkCkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4238
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

