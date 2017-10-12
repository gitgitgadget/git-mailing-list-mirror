Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE2320372
	for <e@80x24.org>; Thu, 12 Oct 2017 12:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756724AbdJLMCv (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 08:02:51 -0400
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:5006
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756105AbdJLMCp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 08:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NuouUr6umjc/FqkhzV7y7fnRxnQYTYCSRPzmXq5zuJQ=;
 b=ooidOi1q1Rmg1VZGm09ic3G7hYtp4Fa5sdxVNRmaxWaZ/jC/4nhX4TmUhp2GZtHFl/d6zHrwPRe21bOvkdBfeIUx/Y5dpL6OToO47yU0NmEPn5MiwCEtlp/opWPNTQIczfmHTO9toCrsX39ai0VoGw9A6OMK2RGys+W67bDoNbo=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0729.namprd21.prod.outlook.com (2603:10b6:301:76::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Thu, 12
 Oct 2017 12:02:42 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 4/4] sha1_name: minimize OID comparisons during disambiguation
Date:   Thu, 12 Oct 2017 08:02:20 -0400
Message-Id: <20171012120220.226427-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
References: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:404:151::28) To MWHPR2101MB0729.namprd21.prod.outlook.com
 (2603:10b6:301:76::39)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d060ae66-ae6a-49f9-98dd-08d5116924c6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603210)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0729;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;3:EVFDmIPWXs6cEQUeA2Ex6/u+91TuaVFH6lTzbwd9oc74kUjdqO/VprO6DyH6jD46Lpen6H6x63TgP50EVMc4VvY83q4SOwvN5iXfNPrKxbRvZA3v/tgWU3tx8e6/1cdpYNAYL9iVRw0uK6nsMz4CU/0x6ZkV5g/aO8Zt7xIc4BeBAJQIzUk/PtSCv3f9d6kmNO8QY3vTSy87fhF8I+PMvu3ae8voPkrQREzUn5IU1Y5mJZRK3bX9G3WgkNLRB46E;25:P/E+0CZ+GuY1jcI5pZ2AdhJUGgJVdtbazHNaFr2mjJTU6N8RW8ixExNAXqJ7jQUgfR6VpLKjx5Ly5hhJC5KSb9P9kLIe51ldvu346Ta3YUGLi/07HMIynXBaDg7fjQnMdDLrxnelH2Lrkl6Ww5vqrQ68CV2+m1UjR2xuT9Vy2LtRw7MSLjLfktlw1lVRRk/twFDAFJj4u6NVMxoAQFiXOJq0bqpf84Yw/eFwk2EmjHTICxOoCx/BR3SBBYN+K5vZkBYI1ZvxXdCPYIKnorNgAKfCRAEcFTAZKSGrAq0OFihqDZRg18eydYoGV/1LwFPIeFBVu5y1f7+kJrMKu4Q/eg==;31:H8i84d2Qce9e4JE6f8RHcORw+rm5xl37fiKX7FVSZHytB4ZZIhJW0nEbkuCTJSA0zGIWUP/7/ds1lhXiUvz5C5w2O/PjJURd3yZKmso5AAzX+SsQ7xE85Kt1lojW8ELrc+Pb1apy0cM/32j3VzQhJFzIGvaoltjt44QFVZjzzuc9gx2FTSTnWi0s8CEKGV5Km7bHbwxenhIhm4OoIhAD9BiwRwt6UAyAqxKc7on1s9I=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0729:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;20:hMUgQBnaJNHeMbrYOTDzhXlk6/MUwemFqJAacYKRt/5hCmDadhtaU7rGfkh7ZcYkCn+6qSTxU2vJ1Jd8xQBjKmPVZoSfPOhu1Wp0Ex2dnqaJzqOWasyI+g+vZvO9YxXIh4k5TVnI9+mg+ncK77f3RbcqahKN0EdygKt38WGy1nRKdoe9DIVj/Ri7gHrUQp05XWD4bY3zL0AjjAbFE9trI+Up/5U4ci4yOoroeiHSUVqmtFRobbBfSTfTLvB0akkA48tDv0046ecrtczc+y5+g3EjA9TeYEaH6G6MfA+44DWsR00LQJCmkWzHJ3+AQEHoALbfKtzEdoNCAmNN96HWJ7TlZjjthbmFZ62T5Inf2wrzWzF/gTFTjlT9ZWSj0Q1NxmFDZiqpwLez8jX4u7bQO8Xmaq86zU5LF9m20zNk2dqC4gzVvPqTIf6Nw5YSZSBUGHTMwwvL5pw28RkNia49YhilrW4xZWpJNGTwMqOYqkcfD+79Evpw+hz+YGLgRXiu;4:Azrdr1T6a7yWWZeHZ860PagYLbAqTh1DSt2UBlgTl+adjQZjfpvphth00pjjVz8s3SnTOLmGntX+0EXPl7qBNpnH1XSaX/cK8KxSuxXqfZxDQUJlK6Pno8irOTXN9+sB8FGPMSktYOXIIX+Lisbaye5frE0K8/V/0Xk8/zJ5RAuuRnw2f4YaWhpT/MnT9ShyD+9KhcRPlaGKIe+wYO4X1x7v44BezgcvmwWBVeYMNe8NZFPjhrjuBkTLQYPT7yaRc75p7gQyD6figFBdXi6e3FL4mxW8eKVWXwsIiaGOTms=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB0729767B08A0BE8BF419A671A14B0@MWHPR2101MB0729.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123558100)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0729;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0729;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(43544003)(199003)(76176999)(189998001)(1076002)(6116002)(2351001)(50986999)(105586002)(106356001)(53936002)(2361001)(10290500003)(6666003)(478600001)(25786009)(47776003)(33646002)(36756003)(305945005)(39060400002)(4326008)(101416001)(107886003)(6486002)(97736004)(22452003)(50226002)(48376002)(68736007)(7736002)(50466002)(16586007)(8656003)(5660300001)(2906002)(10090500001)(2950100002)(86612001)(81156014)(316002)(8936002)(6916009)(86362001)(81166006)(8676002)(5003940100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0729;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0729;23:kLzPjdbgeZR15+oCoh/VkpRg9r97wSQ/L8PDoeJ?=
 =?us-ascii?Q?QQCEbq8dwR6k/vAeTp7pUcd4eikZNL30BfW4D3/4glfRgGlV+DZbIW/dzYvL?=
 =?us-ascii?Q?Uh4H3osXVvYP2gAdgHoofseq+TFQrI8AuqesT0m1GoJCUg9SgxvtGEqwZn5x?=
 =?us-ascii?Q?tMf/UrPqouKSVB/e0URXVdZWbZFIvGoJLLJg6DMP4MBcCB+kb26SwigM4GK2?=
 =?us-ascii?Q?AXAF152sVIk+pap4ef0hg78zkwzWObx24lVh4dic0IhZW6PAKRnhJG5Bv3QI?=
 =?us-ascii?Q?q6lbE662VtJM++sy8HBkLIa976Wg8sSg6EnmSfLIyUtLvGpjOgjR/dssttWQ?=
 =?us-ascii?Q?QQyqb4gMlB1V33DlD5WK3FjBzcQLuZ/3F3ikluCfI0POetXsl9A4d4IDTdfn?=
 =?us-ascii?Q?eqEY86/ILxym4poHyFY7FXMkxh3JULh4tri6hNdItPX2P7IbWY6xtiFXSr9K?=
 =?us-ascii?Q?a7K0/1KpLy0oBd6CPsLBcnEfIM3GWIfo1Ep8b2viGEO8orzehU6/dwX2n014?=
 =?us-ascii?Q?AYU9awpEKI3EQk64cLn8v4wi9o7er01QrmGGErtjSkhU5CHrPE9f+h8slCuG?=
 =?us-ascii?Q?gE37d31dVnpl5c9ZykbcBxuw0i+BXravprBsGJBGCqbPh13iEyA2aV7ETSAA?=
 =?us-ascii?Q?1t03OqyhUywSHy6oFTuvYPxaOt/4O7qmpykBSY6JHl7YozFHgxHnsobU7m/F?=
 =?us-ascii?Q?d4f6chSE/oIIzzbGvqdkt0N3vyPb0aOb/SqcFscxljuVIoVGdvGjUFYJxxaX?=
 =?us-ascii?Q?ERNUi9cTRe3jsGbjSCR0A8cV6Y+iTtvjjXUSyMGaKIo6YLuiE37wUNssNdRA?=
 =?us-ascii?Q?OuiBXqBTXg9X77eR+TUujXn/AHcBk1wn/58KTL2oy56cDyCbsDzTLdvXRZ5k?=
 =?us-ascii?Q?q0PAExTG0gVNb1q6kLSzKpfWkQbIp7IvgDQUQe5p5ucnSOt/HR88yv52YtS7?=
 =?us-ascii?Q?PVUc04ar8Y+0kvvQiQJZ79Xw24uwEHFMnhaFUFVqB5ywYWmyRfhD/WOvLwnM?=
 =?us-ascii?Q?V3Y8LWk96/uEcZBl+KFSl1gU+tuI5jrlMj1wVkIxvHEKulUW/8HmVsFiDBPi?=
 =?us-ascii?Q?IT5nYQlnoLS8OmHF1Qbie4Edhu0zZvaffkcg5m3FBX0XzdThC8O8sXLL4FeC?=
 =?us-ascii?Q?oqTZ6RB7Z4z7WzyHf2pI45Rm0syfqEm9ztmQ6MmGGv+M7t60FWk7ASiQjfHJ?=
 =?us-ascii?Q?n7+ka/9+XM4W1SOma0wr/Oj1qe2SyHVjuMpCWqLeZfHxAM82K5Tq0CEinZco?=
 =?us-ascii?Q?JCOn4eyIHmqBwOJHua8WQKtwW0jucwsKPaoEb0tBC?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;6:kFDOYJdQ55D2Ir0LOOWIVPX4h+is96glJcgj3eTw1g0nn+rke706j0jQsyuOy6NccLwCHQ3/VDAQfk2XHl+zsChSa9BrZfJooe9wXY+HafHx/kxbRZc6H0Etlyx0Qsr+dPqrxtC4/8Vzd+XTIp1Enqvv0dc7MQudjQ8JLt6mkBAj4D6jxMIuXwZ1ZWqJxBABjFximdseRLLXOsS6P9EdvCWUnBRwSemfvweD1YBaYf4ixXH8PzRXqb6ocvNlurH9UP00vRoB/ytGXDbiFiz8GPbtaW+1lH+odpkpG4xrFRWZLV+N4WhCtg5Sckmm5hQS5F8u3QMHlM172043uxbMqg==;5:B6dsheOvtbCxFN3jNzStoBx8HROlnc8S+WhXLzuknsQTzl12Pqkq4S4qEOQoFXX59yYFqRaOMppmOZ1wgbh49IbVDBXsnzcaEGmeJtHegbZWSc/PqDtSXVUWGbd4jSlDiftT7oViaea3ZAWSOBHPBFw5aqrG5mS6ccrGK60eTbs=;24:UDmCAzniEIJJwSEZVtiIpehdii9qvWbFWfXT0bbKeyNoiN6VOQlnvxIXUkgDujyhzmTvGAD2OC1x8MpNRV7adoZB2uKo6SO5kPtIS+oPpns=;7:SZNBJ1ri2YJl7X40Ej8hQ0agQUQK727/NXf5wPkjIJhJ8kMGoA8ZaOewbqTyWF+yeGpmRjP5PoPLlssu+SBRBN39uxSG+bKZDkoOZ2nO2n8FgmzPxV27i9d4Xh5na0tkEmjdZXSlVLZ2a9uHUAzHM98u7sZ6RHc/Dr479KGIBP+gBljKB2VJvrv6vFjgAPebMdKSF7QbMufIiecGB6Ab4G/YfW/kxaa94gOPof+nmbg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 12:02:42.1526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d060ae66-ae6a-49f9-98dd-08d5116924c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0729
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minimize OID comparisons during disambiguation of packfile OIDs.

Teach git to use binary search with the full OID to find the object's
position (or insertion position, if not present) in the pack-index.
The object before and immediately after (or the one at the insertion
position) give the maximum common prefix.  No subsequent linear search
is required.

Take care of which two to inspect, in case the object id exists in the
packfile.

If the input to find_unique_abbrev_r() is a partial prefix, then the
OID used for the binary search is padded with zeroes so the object will
not exist in the repo (with high probability) and the same logic
applies.

This commit completes a series of three changes to OID abbreviation
code, and the overall change can be seen using standard commands for
large repos. Below we report performance statistics for perf test 4211.6
from p4211-line-log.sh using three copies of the Linux repo:

| Packs | Loose  | HEAD~3   | HEAD     | Rel%  |
|-------|--------|----------|----------|-------|
|  1    |      0 |  41.27 s |  38.93 s | -4.8% |
| 24    |      0 |  98.04 s |  91.35 s | -5.7% |
| 23    | 323952 | 117.78 s | 112.18 s | -4.8% |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index fdd2711a6..7fd5f5f71 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -153,7 +153,9 @@ static void unique_in_pack(struct packed_git *p,
 	uint32_t num, last, i, first = 0;
 	const struct object_id *current = NULL;
 
-	open_pack_index(p);
+	if (open_pack_index(p) || !p->num_objects)
+		return;
+
 	num = p->num_objects;
 	last = num;
 	while (first < last) {
@@ -478,6 +480,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
+	const unsigned char *hash;
 };
 
 static inline char get_hex_char_from_oid(const struct object_id *oid,
@@ -505,6 +508,67 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static void find_abbrev_len_for_pack(struct packed_git *p,
+				     struct min_abbrev_data *mad)
+{
+	int match = 0;
+	uint32_t num, last, first = 0;
+	struct object_id oid;
+
+	if (open_pack_index(p) || !p->num_objects)
+		return;
+
+	num = p->num_objects;
+	last = num;
+	while (first < last) {
+		uint32_t mid = first + (last - first) / 2;
+		const unsigned char *current;
+		int cmp;
+
+		current = nth_packed_object_sha1(p, mid);
+		cmp = hashcmp(mad->hash, current);
+		if (!cmp) {
+			match = 1;
+			first = mid;
+			break;
+		}
+		if (cmp > 0) {
+			first = mid + 1;
+			continue;
+		}
+		last = mid;
+	}
+
+	/*
+	 * first is now the position in the packfile where we would insert
+	 * mad->hash if it does not exist (or the position of mad->hash if
+	 * it does exist). Hence, we consider a maximum of three objects
+	 * nearby for the abbreviation length.
+	 */
+	mad->init_len = 0;
+	if (!match) {
+		nth_packed_object_oid(&oid, p, first);
+		extend_abbrev_len(&oid, mad);
+	} else if (first < num - 1) {
+		nth_packed_object_oid(&oid, p, first + 1);
+		extend_abbrev_len(&oid, mad);
+	}
+	if (first > 0) {
+		nth_packed_object_oid(&oid, p, first - 1);
+		extend_abbrev_len(&oid, mad);
+	}
+	mad->init_len = mad->cur_len;
+}
+
+static void find_abbrev_len_packed(struct min_abbrev_data *mad)
+{
+	struct packed_git *p;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next)
+		find_abbrev_len_for_pack(p, mad);
+}
+
 int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 {
 	struct disambiguate_state ds;
@@ -536,19 +600,21 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
 
-	if (init_object_disambiguation(hex, len, &ds) < 0)
-		return -1;
-
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
+	mad.hash = sha1;
+
+	find_abbrev_len_packed(&mad);
+
+	if (init_object_disambiguation(hex, mad.cur_len, &ds) < 0)
+		return -1;
 
 	ds.fn = extend_abbrev_len;
 	ds.always_call_fn = 1;
 	ds.cb_data = (void*)&mad;
 
 	find_short_object_filename(&ds);
-	find_short_packed_object(&ds);
 	(void)finish_object_disambiguation(&ds, &oid_ret);
 
 	hex[mad.cur_len] = 0;
-- 
2.14.1.538.g56ec8fc98.dirty

