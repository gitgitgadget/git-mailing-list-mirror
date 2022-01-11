Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C78C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 08:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiAKIlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 03:41:20 -0500
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:31363
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234862AbiAKIlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 03:41:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDadhAd5WqnjL+XlzPm37uxdVaUj/MVpdxO4Iv4SsqdIbvnWdb0XMamYwdvIuaBlZA3D1sPtoDV3gZcrRtzCOx1Zc0grM23GNZNVekdf6vfVrtvKA1OPajOp84WESIRt96xIGC05L0/xAlotZqZl9FEMX18pN3VmE+Kjeu4B9lcK5FUOBzofVjnWU+4vPLl07iZaIJlmfMOQvfqkM3Xaj9goA5WwusbO0B1+x7QZARTi0ALrTW9abZ3LesTWdPCWywVyJY3c8AtRW/7ynCpS2q1i7NH4vOzIfom5ty47ISvL1aO8d7hRXp6UsFuqJOtxq1THT2RDm7Rqq5vhEO8ArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I3oN0vJdMeWxf4a0m2iWlEX1lPI/lBZatbd0RiOU7M=;
 b=LwR1boEJWV0vxnyctUOMqOKP7nd3/Zy6y7VX6AoHsY0GAADVBgVHwn8Fe+MkoNvW7eRu6g6Mln4cPhPSqrBT7IQNDZl1FgVFU2iWKz4b02Le2ifjbhb+/iMoTVmDowMca8pCWZKMmiQxJVMzK9NBhKW/zCmVMSlTmwaP2e9NWsibBIhotrfqpsl2+CWLNCx9XQT9uSyp0afz48Aa4s+4gHzfWohhYfVtW3idw35iJdT+YFPH8XHmBKLLlozrB/CERrO2SnPIBuoJV7AJFUUmtj9fiOPTmHjhnTRUQOAGSKSY/XNCOGqL1nbPsIS3kC0FSFupinGUyEEbBpAUn+eicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I3oN0vJdMeWxf4a0m2iWlEX1lPI/lBZatbd0RiOU7M=;
 b=Iu5M3x8ObwGptpiQ4eMTR57RitA3nM3Oyv92aemOzGMlI4GTx5IeoiatbEFrbYmBruPJ7F/VB2ztHakImVqsSGWaUNn6XlJq2qmilINVYsqyPJxcj7ql12KRrvloBQXqEuXyP/ufPg4fwd7o3rYLo8nLBNtJ8z+VbTVp+oae1LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:107::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 08:41:16 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:41:16 +0000
Date:   Tue, 11 Jan 2022 09:41:15 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fmt-merge-msg: prevent use-after-free with signed tags
Message-ID: <20220111084115.esuyxeopdpaq7g7y@fs>
References: <YdxqshqXB/+ApOn2@nand.local>
 <6e08b73d602853b3de71257117e85e32b96b5c19.1641849502.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <6e08b73d602853b3de71257117e85e32b96b5c19.1641849502.git.me@ttaylorr.com>
X-ClientProxiedBy: AS8P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::23) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4a2032f-936c-407b-9304-08d9d4de2172
X-MS-TrafficTypeDiagnostic: PA4PR10MB4544:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB4544931E141A043211A658B2B6519@PA4PR10MB4544.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9Tc6UUZ5tqeuZulWyYHUQNiG9YjWsWKYKktqwshzVYaphdySEam8hE5uEf8/o08bfQsT03iEzmwz/MB+RvatpLCCTcYwXvmop2zsy2+z5eK20xdKcEEj9tDBNVffQrJol/HDA3SAIi7oy9Dgmnh+lOYD9Ppe9tTkdH8/Auuelqc5XHvhUhburfzy1KRZilNoy8LiqjmUowtFpM9JG6Fjmb9vdQRBZtASDfkMHyHLHpfq647LkEt+uVUTrC2tmMa+x8V0XJmG4cLYfJf87Zng8FkgXkezO6UBZuwarQ0qQq9UCY3v3x3fZX3PpVGNV3TptDiHh30shKQk5UEsJoklybegBuJId1b76k7RY5Oe1ukf/rHsqkMK8/dwotv6iWm14Spb3pD1fJ/SA78V9188f9whHkJ8mFPJ63kz9lSru/0aDvzO+WNqtEOD9SXwQvU399r0sJQ/fbwJwWu0ITmE3ipuFUf2ej32WAo0IN9aGO7VKuA0He0UIKaj2v+nbrwCMvRjlQv/7/1dNZDUYp/6G479SvVNgpHGNmVtp0pLVhgmuN2/5FgHHwQTx3mknp8pN+xvh1GxxOhFcnj9qamnXXCj0A/34Pc3BUVFe/LbZ3yTmrWOStwVBR6z3lKWdTQQpSp2veSD3TRqaZd9pAf4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(39840400004)(376002)(396003)(366004)(346002)(38100700002)(53546011)(508600001)(6506007)(86362001)(6486002)(54906003)(5660300002)(4326008)(8936002)(6512007)(316002)(2906002)(9686003)(8676002)(33716001)(26005)(186003)(83380400001)(6916009)(1076003)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UndxdW9zK3BwRzFaWXJrWE5taW40MVZIUFRsZXdlWURxZHRQWm9wcThiZ3d0?=
 =?utf-8?B?RFRTQjF3aWpVSmF5aWhWcDNsc0F1bENpNU9PM3lnZ3ZxZHVEYkhCSnhiN2RI?=
 =?utf-8?B?NWdnbldOaXN2cnVVbC91ODlPWmI0YXZPL2J5V3RLYVJSZDEySEc5RkRTUnhm?=
 =?utf-8?B?VEJsWk9tenk3N21xL0c4TVM1V0VvakZyNmI4eVgvTjNOcWpmd3NnckR2Z29G?=
 =?utf-8?B?d3JrK3NHdUtZeXVDQ3hEUHliNW5yWkV3em44OXYwak4zN25IWlB4L2NhVk9O?=
 =?utf-8?B?M0JsVTBlSGdLZlJDcmJxNzhBU2NiMExZMmpNc2pkSDBOQzAvN0VtRml3WGR3?=
 =?utf-8?B?dkh6MzlVSzhYNkJIRUFXZjNzeVZhUGY2SGF0MWdWemxaajZqYmFBSTIrN2M3?=
 =?utf-8?B?Mk1sN09URXFNaGRhWiswWC90c2ZtTWJrR281VXVRMk5ra3drbDZGc1QxS3M1?=
 =?utf-8?B?Y0lML0FnZGpVVitlT1d6aExoZ2E2SjRrcmQxZzgrWEdFYzJUS2dDakhyTzVJ?=
 =?utf-8?B?TkVRNWhaV1NwekJ5cWNxTkV1UDg3TTBtWTNUL05SZUdONVZSQ1Y3RTJXOGR1?=
 =?utf-8?B?ZC9mS1FtWDhEdHYrUk9ML2xSaHBpamxFaGExUlJhcHl1blhCNlZRdjU4b3Vk?=
 =?utf-8?B?ak9lTThoSjJZb2tZWHNaQXNqK3ltdSthdVJUSVVBZ0RVSjFWU3BxT2g4WTUr?=
 =?utf-8?B?djd6THBkbWxxUkVzMjhKU2x2blBha2k5SmdEODd5dkhPdW1aa3Y2MlF6eGx6?=
 =?utf-8?B?RHNOUkZlL0V1WWZXTHVhQ1c1NUpCOHh1VWxUdDlxQXBCUm5ucUFwU1dIWTBt?=
 =?utf-8?B?L254YW1nbFV6ZXBlN2FKdVdMaElmWDdtSkdERlVXeGU0TmV5VDRHeDFwSnhr?=
 =?utf-8?B?OENVOW1uOWRwOUl3aW9pSG8ybEhtbTBhMmZmdHB4eDhwVldCUFFjZEZMNlE5?=
 =?utf-8?B?b25NOGxvb1g3aEZwTTk2WGZyS3JVbUtGQTE0WGkyWi9UK0h1c2g3TUxIUjA3?=
 =?utf-8?B?eXhqelBFTFZQRjZYNHZuamxjbjdXcjAvdWo2L0FDMlVjOTEzcUV6cDI3dndO?=
 =?utf-8?B?MmF0VnRzVzczQTNyb241SmtsZlhac1ZXMFMvQXJLeDUzUERnU3g4QXpERDJq?=
 =?utf-8?B?dTZodHYrWkZkYWNQb01xR2JhTTBaOGllb0ZaL2RkQmxPT004VjRCK3c1TXlr?=
 =?utf-8?B?QzRxaktxSE9FeXc0MkxldVdVVGY0VVlibm0yZUJlekVXZDlIblpONVNLOFh3?=
 =?utf-8?B?NDhvVGpGM0tCa2JzZE5HZ2VOOC92Wlh0elRPaWN3b0V2bE1qRXFMRGFHMEgw?=
 =?utf-8?B?d1ZPSHB1Rmt2U2hEanFYREY4bTlqMFB0VzhoWmVUKzdaTkJPSEhRYzdsWHRs?=
 =?utf-8?B?cWxEOWhWYTJSY2VnQUZDYTNiMG5FWk9WVEVST1hSTktOdTB6SjR6elBidG5R?=
 =?utf-8?B?TnpicmI3bElKOWNxVWsxY1h5OWdpV3Bzc3cyZGNwZXNBMUQ2VzZGbWtPQkJQ?=
 =?utf-8?B?a2hLb0xiRmVGTlA3YXFlQXo3Y25yZ2o0WkhnbGw4NzRaWlE1ZGNVTElOK0R3?=
 =?utf-8?B?UTBBdTVKaHQ5SGIyTFhGdWM3VWxnejE4V25tSDZjTXRPU3hiTi9Rb0FDeWVv?=
 =?utf-8?B?QlRXV0xmQnNNR3JTbUo5S3h3NzYrVHVTU3Zyb3FISGlXVWFlQlVRWW9taERD?=
 =?utf-8?B?U2F3K2EzTWNUaW1zUWRaMjlGelZ4Y3BLMjE0eHdPSnRhVzJ5R3daclNHSmQz?=
 =?utf-8?B?STF6d3hQRWFVVWo3WkUzVll3Y0RhNVgyQ2dsUlVuYi9kUGpxZmRBdHV4SWpM?=
 =?utf-8?B?dkVZd0RYODJKd29obWJueU00aDY1TEZNNVhwMHhKR05BTFV2S01hblVLVDFy?=
 =?utf-8?B?RTBYQ3RXSTFMOXptTlVTSnFzalhXQjBJK0txTlNiR1FUc3R2TjJocmJCd1pk?=
 =?utf-8?B?YnVzaEFKZkxSMGVDRk1OME8zSVN6b3JmQWwwRENtb0hlczBlNmFuYWpSY2VR?=
 =?utf-8?B?RmtRcDNJTlpJRCtOUVNVV1Q4NDBMWm43aEEvTDcxM0JHT0ZXNVZRd0NkRGpT?=
 =?utf-8?B?ZHJITFlrbHFyQTEvdGtROHpIa3FVMzRVZGZ4OTFFUFNXUmNiakRzRHFqcVNL?=
 =?utf-8?B?Wi9PSU82UGh0WURFODNWWURGemlEV3A3bmc5NzI0SHFDTFRZcmxUM0xDdThN?=
 =?utf-8?B?cC85YXpIRFF1T1VQM0pzaGlxcXNiY0EwOHhLalA0VDN6ck5OQUhMcEREdDEx?=
 =?utf-8?Q?rcwipRjnQ92jHhUxsmVVx8T8FaP1UV6vAtUeJMeKSU=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a2032f-936c-407b-9304-08d9d4de2172
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:41:16.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCkLPsjjRP0Hv78+Ilxm1rEBsShqLzo9R2fCGxmiK4DSG1HZvjIY5aarUfKnnZrwdisQ3fO0kYnAlgizmfWYJQxRnhfTld3IwMdmpj4L0tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4544
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.01.2022 16:19, Taylor Blau wrote:
>When merging a signed tag, fmt_merge_msg_sigs() is responsible for
>populating the body of the merge message with the names of the signed
>tags, their signatures, and the validity of those signatures.
>
>In 02769437e1 (ssh signing: use sigc struct to pass payload,
>2021-12-09), check_signature() was taught to pass the object payload via
>the sigc struct instead of passing the payload buffer separately.
>
>In effect, 02769437e1 causes buf, and sigc.payload to point at the same
>region in memory. This causes a problem for fmt_tag_signature(), which
>wants to read from this location, since it is freed beforehand by
>signature_check_clear() (which frees it via sigc's `payload` member).
>
>That makes the subsequent use in fmt_tag_signature() a use-after-free.
>
>As a result, merge messages did not contain the body of any signed tags.
>Luckily, they tend not to contain garbage, either, since the result of
>strstr()-ing the object buffer in fmt_tag_signature() is guarded:
>
>    const char *tag_body = strstr(buf, "\n\n");
>    if (tag_body) {
>      tag_body += 2;
>      strbuf_add(tagbuf, tag_body, buf + len - tag_body);
>    }
>
>Unfortunately, the tests in t6200 did not catch this at the time because
>they do not search for the body of signed tags in fmt-merge-msg's
>output.
>
>Resolve this by waiting to call signature_check_clear() until after its
>contents can be safely discarded. Harden ourselves against any future
>regressions in this area by making sure we can find signed tag messages
>in the output of fmt-merge-msg, too.

Sorry for breaking any workflows :/
Thanks Taylor for the quick fix and the additional test conditions.

fmt_merge_msg_sigs() could probably use some additional refactoring to avoid 
these multiple pointers to the same (detached) buffer. But thats for another 
time.

Thanks

>
>Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>Signed-off-by: Taylor Blau <me@ttaylorr.com>
>---
> fmt-merge-msg.c          | 2 +-
> t/t6200-fmt-merge-msg.sh | 8 ++++++++
> 2 files changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
>index e5c0aff2bf..baca57d5b6 100644
>--- a/fmt-merge-msg.c
>+++ b/fmt-merge-msg.c
>@@ -541,7 +541,6 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
> 			else
> 				strbuf_addstr(&sig, sigc.output);
> 		}
>-		signature_check_clear(&sigc);
>
> 		if (!tag_number++) {
> 			fmt_tag_signature(&tagbuf, &sig, buf, len);
>@@ -565,6 +564,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
> 		}
> 		strbuf_release(&payload);
> 		strbuf_release(&sig);
>+		signature_check_clear(&sigc);
> 	next:
> 		free(origbuf);
> 	}
>diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
>index 7544245f90..5a221f8ef1 100755
>--- a/t/t6200-fmt-merge-msg.sh
>+++ b/t/t6200-fmt-merge-msg.sh
>@@ -126,6 +126,7 @@ test_expect_success GPG 'message for merging local tag signed by good key' '
> 	git fetch . signed-good-tag &&
> 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
>+	grep "^signed-tag-msg" actual &&
> 	grep "^# gpg: Signature made" actual &&
> 	grep "^# gpg: Good signature from" actual
> '
>@@ -135,6 +136,7 @@ test_expect_success GPG 'message for merging local tag signed by unknown key' '
> 	git fetch . signed-good-tag &&
> 	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
>+	grep "^signed-tag-msg" actual &&
> 	grep "^# gpg: Signature made" actual &&
> 	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
> '
>@@ -145,6 +147,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by good ssh key
> 	git fetch . signed-good-ssh-tag &&
> 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> 	grep "^Merge tag ${apos}signed-good-ssh-tag${apos}" actual &&
>+	grep "^signed-ssh-tag-msg" actual &&
> 	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
> 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
> '
>@@ -155,6 +158,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
> 	git fetch . signed-untrusted-ssh-tag &&
> 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> 	grep "^Merge tag ${apos}signed-untrusted-ssh-tag${apos}" actual &&
>+	grep "^signed-ssh-tag-msg-untrusted" actual &&
> 	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
> 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
> 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
>@@ -166,6 +170,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
> 	git fetch . expired-signed &&
> 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> 	grep "^Merge tag ${apos}expired-signed${apos}" actual &&
>+	grep "^expired-signed" actual &&
> 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
> '
>
>@@ -175,6 +180,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
> 	git fetch . notyetvalid-signed &&
> 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> 	grep "^Merge tag ${apos}notyetvalid-signed${apos}" actual &&
>+	grep "^notyetvalid-signed" actual &&
> 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
> '
>
>@@ -184,6 +190,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
> 	git fetch . timeboxedvalid-signed &&
> 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> 	grep "^Merge tag ${apos}timeboxedvalid-signed${apos}" actual &&
>+	grep "^timeboxedvalid-signed" actual &&
> 	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
> 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
> '
>@@ -194,6 +201,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
> 	git fetch . timeboxedinvalid-signed &&
> 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> 	grep "^Merge tag ${apos}timeboxedinvalid-signed${apos}" actual &&
>+	grep "^timeboxedinvalid-signed" actual &&
> 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
> '
>
>--
>2.34.1.455.gd6eb6fd089
