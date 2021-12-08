Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37160C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhLHQh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:29 -0500
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:23374
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231303AbhLHQhY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 11:37:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGaNuL25PkcgLDmC0jHTwIJNkaNWltXauyQ0kF1+GZu5AgLQF1uRp06WuoFS8QTQFmJX9mKdEagUCsdmYMYmjqHU1SttCaDX4Ma24lkrkb7DY2p963GsGYxqC/41guwnJqy1/Ycll+uZ50qX0DIJ8OSAmtrLPxCRvBEdRemghQ9RtNQY9TXnvfMJC5mKYE/dz25+SbCFBJIBhoWQmPC+EK2PfyXD9zrVtTwQJNl39aonrRqwvmo34EYmJay+5OQ+LPbsjyepNSua8Tgy2i8HftjkyzWCwy2soJbtOuVhLHvz+PWHswPgSKlsKOnlG4wtkXsABHZVuCvt1zVnNDF+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3sccrQyi7gwNykk7BAg8YyNI3Nho2xKTBAsNPAwDAE=;
 b=ENGHTAhuoqo8ydegQAwopZS/V35eOEQK6LQ7MuLs7iLiTXcgp/oku51VhcnSdhJnd+oWOrZ1on5MdV+QYVtGswVA5mW8LXPmZtPymtLxO9ZuV8bEjzhVBv92jsjoAH9Nou56vFhTyezTN8PLMk5t800aMutMzC3IUuoguZS5wWiWT6jM33xOqENKRuL2SyFwaLEnv8ya3/2njsIX00eojANOdScsqPVAwc392rS+trSBZVubvPkUWmAJhtzZbi+k98QCIT57deY7jDaFEt3hxDoEeGCgv8QNe20EDycvmwCwIrDs/QONQYXwUtZI6yss6kw3JY+0TfX5WKlOdOs8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3sccrQyi7gwNykk7BAg8YyNI3Nho2xKTBAsNPAwDAE=;
 b=PADUc9krbjrSwUhrXS56Q78oxuxXjKBK5+hnzUi/g8QY3MnTWZuGG94uP/id4acYx460BV3xYqAk3q7S4XWz3AJPHZy7rHsW79qZVfqfdeEv3C3HaOKJpWQjqZVsSQjDDI/cgOvfV+1axL3KbClM27RwKDMpi3iiURZUd3KRyUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 16:33:48 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 16:33:48 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v5 2/8] ssh signing: add key lifetime test prereqs
Date:   Wed,  8 Dec 2021 17:33:29 +0100
Message-Id: <20211208163335.1231795-3-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208163335.1231795-1-fs@gigacodes.de>
References: <20211130141112.78193-1-fs@gigacodes.de>
 <20211208163335.1231795-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0069.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::46) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6PR10CA0069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Wed, 8 Dec 2021 16:33:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c15242b-a3a6-4214-29e4-08d9ba6882c0
X-MS-TrafficTypeDiagnostic: PR3PR10MB4128:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4128061EDFF842C5451EC850B66F9@PR3PR10MB4128.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNeqFOCPe+eFyKYErd63+edxlbQ/bQ2A0LgbvYqp9gFwgsEpIsFFCQrgbsO7fHhzFNHXog0poIBQ227fJlejV9nHrKPRI3ghTzRXNrQi6e2qxt3ahFRVauDvyENvTWsBwtYHAmaiRDVQgATv+2l9heQHKbj4rrcQMBfT+D+/WpoAmPbo3MQkY+R7DbOhEXbBjmwh3csfM8pbe8/OlPlGRuSSjcSQZ+VXAmCPXQxT9xCHapFDt85LM8/fLz0msSY8AHFELc/5eLjflyeOCSHoCxeobhx5vfFgfmmZmyvlsn3aWVl73rnsx3/uXLExKK4vwjmKnmSU/qVVwrpB6U10Lm4GE1n1qicJQXQ4xSvfwnkXsgiD7re/0Qxmo0UMHPaJzKe/Gmj3by0Z9N3PxCzEgAxiTxCga828wA8VM06zBOVP3PAqy9cwnePtREJNV9e6vaWuHl+M7t99AI0e/CkIGLsbbt3Dn8H26ep5yRjgsz6t0hv0D+T5eW9Onf+x4lKnruyIFo4ccTLfwO+b8QT9RC8uQoiQ7pmxCodn1nmIFtxKmcVpeZenfzmPsPFU1LD0vYBdKgfHZBnycn6f4UFSzKvzsy0uTnDMZThLjuBUA5az29ONA8phh2p/yiGDkYJb4kS9npXRn9iOs0j0qFqz5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(6486002)(54906003)(8936002)(316002)(83380400001)(4326008)(6496006)(38100700002)(1076003)(6666004)(66556008)(66476007)(86362001)(2616005)(186003)(8676002)(6916009)(5660300002)(2906002)(36756003)(107886003)(508600001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8AyQIaUH9bxZaEt8lYbACQ7ByX3M9noQsYxnHsFyjnaLQkPQWW757pJ4k+lv?=
 =?us-ascii?Q?Hl6WZAkF1lcgWDmhPvKhYIIxbp3y6z1ubU6HOahjlcRpxqPamevLc6uM6ahF?=
 =?us-ascii?Q?Czefdz085V9JDdPivZSrL57EaPmQluSJ01IB5rYuxUNnNea+ssEC7BtYHIwb?=
 =?us-ascii?Q?UiO/njksM02SnJ/pX0RioBwLmuwCF7YxmsqxLbUlOczAFyl60jxdgN3yJE+H?=
 =?us-ascii?Q?CRuHvdvu96AHt6VnLLgIBC++5qmoSKP6h5qpDslObc6uU59kVAT5hquBwoHz?=
 =?us-ascii?Q?BbYLzKydNHOoXXru8Z2TkHAGOASD1xyL54ZQPuw11Sg/AM08DznPZZ19Lbxa?=
 =?us-ascii?Q?PY2/mj9JBW/phYxwkk7AfkwYotAO22WzZk5F77hTgJ48N9Mm1Z7BIu5duVlr?=
 =?us-ascii?Q?9xaBZzBMTx6w2JJ0vXR8Xzk/ww5ugK3yof+Corf5Mh7iGS21bdqQAQLK5G7H?=
 =?us-ascii?Q?rh+Cl/Pf8E/nAvM6FDe9mEUWUZsuC5qJstse64qlhnrASEG3Kc96AlPn0yVj?=
 =?us-ascii?Q?8TkkRILeijpTwRSPL9azfBgZl3rI57D2jCL6OMMJJFrynyUMtGgNgWgqDhKt?=
 =?us-ascii?Q?BefmCdu8s/DMblhhc/um8tj4S06yrK9EmzIwWDDHOdep0I909rnOBlVk0edJ?=
 =?us-ascii?Q?jI31reEoHP5cmjZ4j2zXTjSaBq0qO9kW6/lHMUlNd5KMvF7UDafJkbHissCo?=
 =?us-ascii?Q?usA/6DIO/ZatWplnGGUGw/9lMxJvxjfW46cLMgq7eMQcFuLU3cGpt96Q8jKD?=
 =?us-ascii?Q?ZWMGH5M7GARcqvRyaqyH1OKifFaAfQj4fEQtYR1T4M4OlCuBdvG7QCUhtN1M?=
 =?us-ascii?Q?SEa9u0Esbc1UQi89GHI+d1a+SKH0iCw4ucEhSlgThUAuntMsbei/BYt2cfxC?=
 =?us-ascii?Q?ggYirbwfbQ1VJTRVjc1kNSQ5vvRDKK0hpOLeLRCIOkA2Tyo7xl5u+EPeXhIw?=
 =?us-ascii?Q?GI2c09NddpGMPxq0bBZ5zQFvcl7X4GaTcyifjaffXMGhvTOFvtl/s7odCGjS?=
 =?us-ascii?Q?vUxQFrMRNri8m+mBrkWn5alSB9fBOAqSVUyCX54OtlGiSzFgB6w/O74rDa2e?=
 =?us-ascii?Q?uLIIgf0J4pf1yfXNRIoftiNHVgWW46WlnMviMsQPTmSiE0JyuRYKYNH0rqcs?=
 =?us-ascii?Q?Q7kRslCSa2IazFxGmATBCpOs+wI33lEZyd+bnzWYqtbE13BmMhsz7Js0mdpL?=
 =?us-ascii?Q?IzI7C3ztl3kkpGUCXA3IRj+QvNmxPjBfv0ok6DKvdGwOSXD5DpEhLzJjuix9?=
 =?us-ascii?Q?35rKQyLIavEQk23qfeUfW/JeVmW3+4+ALRYbMU4V4//p4+TlWUAy2TLjdL9b?=
 =?us-ascii?Q?lrQGF2Snacd+zUd7qv84OFej38pDyffboQ+f/4YQfY6BNUYjvJbI09nocZky?=
 =?us-ascii?Q?7UYKw7J80nLnOCPMFLBx4a3HGGXNt4jMimiwnL3qPnmMmnYzJkxLM2Fz4o30?=
 =?us-ascii?Q?+f+bjlGmyeWLzZXkgw5WQpBtkqkH/mmxphQ4Jnm2jzpVGQkThNIKrYQAS3Pd?=
 =?us-ascii?Q?yLJmOHpHis/APvTY5MWrlL/SOGrl0D7vOgRBwKX0gRuC3j4v7Lclj/FkqogN?=
 =?us-ascii?Q?WjQ+EocYnx7kHVCSiZ+OdDdcu0ARyMFpEd6PnF8rlwQ8J14q97k6yTuQnt+M?=
 =?us-ascii?Q?N7SIK1gvtYxDCyXrI7Px37tddPFtOqlKMFqFneozzZcAZGJp68ph9Cas966/?=
 =?us-ascii?Q?rnLnzcaPCtliGaEeAAewGcj+jLxszt8zSk4Ad6OUxUukbApHl8PZOyGN2tUK?=
 =?us-ascii?Q?qKLQ4uKroA=3D=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c15242b-a3a6-4214-29e4-08d9ba6882c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:33:48.3369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNWes+1C1gSLcMjjy1uq9H0bjU+UvYthXpFtKVg+D0ozBg611QVG/3XQVbdskmqPkCfxuZE5RCu+jZ26gNLIJM1a2ExHm6j5PTQwKAIGBu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4128
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

if ssh-keygen supports -Overify-time, add test keys marked as expired,
not yet valid and valid both within the test_tick timeframe and outside of it.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/lib-gpg.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index a3f285f515..fc03c8f89b 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -90,6 +90,10 @@ test_lazy_prereq RFC1991 '
 GPGSSH_KEY_PRIMARY="${GNUPGHOME}/ed25519_ssh_signing_key"
 GPGSSH_KEY_SECONDARY="${GNUPGHOME}/rsa_2048_ssh_signing_key"
 GPGSSH_KEY_UNTRUSTED="${GNUPGHOME}/untrusted_ssh_signing_key"
+GPGSSH_KEY_EXPIRED="${GNUPGHOME}/expired_ssh_signing_key"
+GPGSSH_KEY_NOTYETVALID="${GNUPGHOME}/notyetvalid_ssh_signing_key"
+GPGSSH_KEY_TIMEBOXEDVALID="${GNUPGHOME}/timeboxed_valid_ssh_signing_key"
+GPGSSH_KEY_TIMEBOXEDINVALID="${GNUPGHOME}/timeboxed_invalid_ssh_signing_key"
 GPGSSH_KEY_WITH_PASSPHRASE="${GNUPGHOME}/protected_ssh_signing_key"
 GPGSSH_KEY_PASSPHRASE="super_secret"
 GPGSSH_ALLOWED_SIGNERS="${GNUPGHOME}/ssh.all_valid.allowedSignersFile"
@@ -119,7 +123,20 @@ test_lazy_prereq GPGSSH '
 	echo "\"principal with number 2\" $(cat "${GPGSSH_KEY_SECONDARY}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
 	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
+'
+
+test_lazy_prereq GPGSSH_VERIFYTIME '
+	# Check if ssh-keygen has a verify-time option by passing an invalid date to it
+	ssh-keygen -Overify-time=INVALID -Y check-novalidate -s doesnotmatter 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed valid key" -f "${GPGSSH_KEY_TIMEBOXEDVALID}" >/dev/null &&
+	echo "\"timeboxed valid key\" valid-after=\"20050407000000\",valid-before=\"200504100000\" $(cat "${GPGSSH_KEY_TIMEBOXEDVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "timeboxed invalid key" -f "${GPGSSH_KEY_TIMEBOXEDINVALID}" >/dev/null &&
+	echo "\"timeboxed invalid key\" valid-after=\"20050401000000\",valid-before=\"20050402000000\" $(cat "${GPGSSH_KEY_TIMEBOXEDINVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "expired key" -f "${GPGSSH_KEY_EXPIRED}" >/dev/null &&
+	echo "\"principal with expired key\" valid-before=\"20000101000000\" $(cat "${GPGSSH_KEY_EXPIRED}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
+	ssh-keygen -t ed25519 -N "" -C "not yet valid key" -f "${GPGSSH_KEY_NOTYETVALID}" >/dev/null &&
+	echo "\"principal with not yet valid key\" valid-after=\"29990101000000\" $(cat "${GPGSSH_KEY_NOTYETVALID}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}"
 '
 
 sanitize_pgp() {
-- 
2.31.1

