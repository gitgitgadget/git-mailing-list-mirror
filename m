Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3B320372
	for <e@80x24.org>; Thu, 12 Oct 2017 12:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756853AbdJLMCw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 08:02:52 -0400
Received: from mail-by2nam03on0109.outbound.protection.outlook.com ([104.47.42.109]:35352
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755701AbdJLMCm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 08:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=f1y486UkRpN4ZGq4HCCtcMyOkGIlFQu6/rPQVx/32r4=;
 b=iu0wUlAoFnHyfHTSSRE5u1GRLLrJV5sLLkzEMc+FTuECDfk6ANo0wFfY8aDQFRlDv4tBueuLDPPU+c8tsaTRMrW3VYAjFWT4y9CutDtDi561478rFr/t46eisXv+0V+S2dlxE1tVHROrtrczJMLLDQBk6iJ8auutVuq57Z1YRUE=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0729.namprd21.prod.outlook.com (2603:10b6:301:76::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Thu, 12
 Oct 2017 12:02:39 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 2/4] sha1_name: unroll len loop in find_unique_abbrev_r
Date:   Thu, 12 Oct 2017 08:02:18 -0400
Message-Id: <20171012120220.226427-3-dstolee@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: cb90d874-61de-4c84-94ec-08d51169235e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603210)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0729;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;3:K89JbHM7tLn9UUcsVKVp40FeCBA4HZCWxoVVFZ1AZDE0/TMuw2MxP4sGZrSENvBT1aecNjBwYz+TMkn3835NAMc2b+RQE8GEeMLexAxLatVEw9bTFFxZbBfzUp9T1sBTzX09ebkVEsYjiAYWCmYH1moPqvVi64yZDhRYd2R/QhDBDJTcVLPPeko/xyWLTBUaLGzmppePG3D0AZVO3BeiN0vK9fgqMiTx2a7zuZfpAINcTVTm2g+VlCHI396F1yx6;25:etylQDNUNBemIIUhd2Jd+CL4nO6coINj5DquLBMCeO+TtMA93oISh5kE2xCTe0JJtsJ69VoxJk7mfA6QcU7MWwgVyExuRpJunrLI+F5mFThhFVWdio8VPwCblrV+E6l9CB2f1lyARXLmA0El45yAK85WDrhcnbkedITsieLgegZw70mJlf67Ho7e4E+dTK3NhwuDgmAIlEci65Uo4lv3ePMzqGq84xekRBO63vXm6cjgR+19rOFSnGBIHHlq7aoqOzT3QWi1FmgJZYp3X4krMa37H6XQxnng5+nEKFF/xz3SeLt6VXNiSlV3Fnt0QjzyJ1Lb+zxHS2X14enSjgwiRw==;31:PXcCyZ78Jqs5GhsUWvmH90nlLgUjSxwB05yX2k/84pImwCLiblXUfSDA9CXFqwI4hhb0ef+krCItNAW1+Mjr9IEkyQHs/554z6/4U72i7C4Nlnz1V7LuGjWCVs7rCUJjLrEpGcnK9pq+z22eqh2D9mE7xm05dqIUytWXfSiRrZaB8sep4bQjfyWRll7M/K8XNY5WdBCvTaJHMtjWAckP0vq3OBfk/fXfItHUTnMNRGg=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0729:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;20:v2T4PzFBHbTOR+dgTlVtBpuiFSAB6iaEpsrLsvsRC2+ugELZlN9Izau4IXMrMau+ZwA6xZSSp79hoXDbjchWnrf0ZyrxYVEj4noxjwmKTizbBhsCodZ8mCTIfsu658VD5KKFBskbmQxocnu0cxtX6W3A3yC+ivmxWw61yXMD8wmzD/wRIdTp8ZTUkaB2PMazau4u5TG6EaDaXnAQT4ALYcosNOhr9JqxtxEJhitDxLHVnOnSp1+7UfB8O3FlDUBmDhs7VxxbyYsTz5QHRYcl/KR73KqYtzLca1h/omNsIa76J9ZP/khhECwuAIchKjMZgrrFe5BKSTNCdmTWQbdDcQrJl7c4vuZ+abDV/huvKeN+pnvgjn6Dbpi3NdrHSEDaq3MwUt/WVyvE9CFQGZjpKy7iV90RwSDAuE23w5cZ3VGRgXt7SMN9AEgSbg4QsK3x8OfjYgJbqi8QoidKaRHQBeF1MQKAQ8RrX0r05dCzhR3R2e23PLoHsD+Hgg2AYLv/;4:8kwUhUEJfEo22S5PaEPLXXRoQ+nTRwtij8egFCsE6frczNGYBg+zC31YgNq1arqGWq5H560IaaEXsb7cCzcOz6m7YyhWdQn1KhXJ+nGZqXCNE7Usr/NBaNmypLYYU5iuyNMhWBeeILnbDBZlx5dCZ8ThuhOcGbOnjcm4pVW6dY8am51NspbQRdRCypdBE8W47DHbxdR2BgEWRb95pS8awlgHlP+/e4wRlCtQZM98YEwlcB6Rno3/lHDoyLydC/nzLmjR8b+IpoZoDSaRbuvDR4ektV1AhX775VAdaAmXKj0FBqAQPdBcasH8sKDaU+2HGKiz++hcXQaMjhfzOSo7YQ==
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(17755550239193);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB07290AD6C95E8080BA131A0CA14B0@MWHPR2101MB0729.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123558100)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0729;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0729;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(76176999)(189998001)(1076002)(6116002)(2351001)(50986999)(105586002)(106356001)(53936002)(2361001)(10290500003)(6666003)(478600001)(25786009)(47776003)(33646002)(36756003)(305945005)(39060400002)(4326008)(101416001)(107886003)(6486002)(97736004)(22452003)(50226002)(48376002)(68736007)(7736002)(50466002)(16586007)(8656003)(5660300001)(2906002)(10090500001)(2950100002)(86612001)(81156014)(316002)(8936002)(6916009)(86362001)(81166006)(8676002)(5003940100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0729;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0729;23:aIFTVNsXhtmBPUlGQ6p+wqLkCcf7fd9jTJIgs6U?=
 =?us-ascii?Q?AV4jqBLXyFmwU/Re18q9pLRU6b30/pEIhIJ7h+88iTvsNaT3gmM+CAIadSuw?=
 =?us-ascii?Q?tftoMBF0lqBmi5ZYdBq6BabZgkTUNkEHGhljPtRgE2/eGV+OSmJIFD1oaHUE?=
 =?us-ascii?Q?9n812aGX6vTYlwjbjKIyq2Sw5MP0c0LRI3W5NMoaGRqHcGnx15N3o8vUTCvh?=
 =?us-ascii?Q?lSPaDkvsQKM/5GQ0y49La1HYMBP+TaHiYhiitrY6beu8N5pzliW8IFjsvxsu?=
 =?us-ascii?Q?acbooYbVNnIdgC6MskDjJfmCpYWIrXu1FG94KVBl82DSWsSDS6gTOY4wnn8D?=
 =?us-ascii?Q?xHEozn2pQMjRbux2YDPj6fvwPl/79krjrF+OsjjbKlZYUS8rNiP4o1pk2CKi?=
 =?us-ascii?Q?403Ygwfoz3VtIV6bko4YiznMz10IfrTGCJWTekWHnAzkZjUOSFuZvIYwVEy9?=
 =?us-ascii?Q?/5zU1vSNpi8feN5wr25C4Z75tEQPAF+K6iix+9Ltfub7aJNwKYh/ZJLgM08X?=
 =?us-ascii?Q?EwkuOyjH1OHOAq/7vsQ4VCzVsRJipi0VP+npT4wOfxcVQ/p9d3y0LpPnU8Ss?=
 =?us-ascii?Q?4haDyVZho32Xd3nHAh2cTnQKobF8Ja9uhuMnmq+RLMbQQ7pCQywSVe2qAO4i?=
 =?us-ascii?Q?IhO623st3q27jNlFz3QeubKvyTwz44+iQmKgboiqcvI+Lt8Y9k931Vn+KsX7?=
 =?us-ascii?Q?mTfCleRQ4NDOcWhgKP+KxAL+YCQERHvmiS38FiotZTrwaoXwDjoxq4aTjoDP?=
 =?us-ascii?Q?+gCHcfMtSZGQgniR7i+1SmoP2Tf9ViOijViJcXTr4AFzcJs6U8xheWOiFViM?=
 =?us-ascii?Q?z4IW0oEAyWLJ1qGXutSEg53M6FfytoqOfGOSpjuzyhn9RFev2mNqH0qvvFsi?=
 =?us-ascii?Q?4/AQvujgd3zsl4BtpC+OcHNiqjGvQPDDdpPnZ7Zd851jXfuYuqLDCtLDVlYb?=
 =?us-ascii?Q?0Ht4T5XuhxUQoKCiyCsHOIkhppC8mA5KhquGI/jtY0Y2+aAXYb5FX21nAMg0?=
 =?us-ascii?Q?+szw5dsykgPgiAV49tnwT04j0VNGDL8HG3m0S+1NVEPWGtpVazXCK8EgT6lo?=
 =?us-ascii?Q?ATUglO4O4PBGdeD6t+khKqCGJv2XzJUpqnoAx3FN7EMZaQWRwOCE19VFaaP7?=
 =?us-ascii?Q?r4aqXijydmZhHqsbhvcUf85wF8/w62ArXl31yVVwzDk13hV32GYTOwl5nVyX?=
 =?us-ascii?Q?Sg2w2sbv5Spi1kIvNBj1MpAo+6x4WZqwSs1xFEfADWHCVQIRpA/IzK6SapnA?=
 =?us-ascii?Q?deIdGd/dyWvx3dm5yckY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;6:kgPpRgUr5kCrAA9k9FWb5SvJNsFyKX6Aajn7pmRCNPipL15nfZzovHsVvvV1FCSPcEzEkL/DKtuFiuE6zFZ3tbfQAZqTr53neRqnxhx/h86GQlHt7/ypE5TFxktqWuFr0uSoAM5golCAIj/Nzn2HP54UrsgrW4bCfahOilOX6sesHN0nJwqmfMLIy3l/IkqcOacr8nhQc9i7f8I53C/Nr4u6dZWbXV5KzCbIHgNZw2mtCDC6D8hstIft4nFKKRP8zrx43fiHX1leSECtzZDotMUjpwGgcp+qi0swVX+dTY56Frea4Ncy/m5FrAWuF/WYn7wZ6KjdIpzqG/lUxZ0Xaw==;5:hOvnp3K3sSbSohmST5aIE6+Iv72A7pdxUK7wVLRr9knbJjUYEFVoXCKU8iNlbHTqhJtmk7uwvG9qReZB8mx2judRup3cPUaokMIno5dX+E3rofFdF238NZadc9W4HezpNrs7W4y1nEQD5w3smFAUa1aWlg3NKQ1AfiDAuxcr9mY=;24:pBpgDpHqmI9BF3nNJ+Rf9l9Xj0eOvkEur3tFsINN83oyJvZGc7ZW2FxAU5vI3wQBKGt8paD7au+SuBDntE2PxWAcwvB0ypO/l4OX0BitaAA=;7:dL2qrKXR+ImsC371aogI+iB0G8gRXkcjnUYR7i1vVs+Ov4sOg/yg+yD3cX7+iflqg0/4XRZ3qu1NtMvZjtCmGGG4I5whWYTMWEpBbQHqt4nFQB3HvkkFApm1vw6nnRDixvP8sTvnNIrpqjc8aTs/P2skImvqnPDnWheCC4l3xG9b3bqxDjNgFZlI7u3aWw08tjKZxMnK3MXeUaGZI77Q9OAG4gJERZdGwp/jkWmLGL4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 12:02:39.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb90d874-61de-4c84-94ec-08d51169235e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0729
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unroll the while loop inside find_unique_abbrev_r to avoid iterating
through all loose objects and packfiles multiple times when the short
name is longer than the predicted length.

Instead, inspect each object that collides with the estimated
abbreviation to find the longest common prefix.

The focus of this change is to refactor the existing method in a way
that clearly does not change the current behavior. In some cases, the
new method is slower than the previous method. Later changes will
correct all performance loss.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 57 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index c7c5ab376..19603713f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -474,10 +474,32 @@ static unsigned msb(unsigned long val)
 	return r;
 }
 
-int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
+struct min_abbrev_data {
+	unsigned int init_len;
+	unsigned int cur_len;
+	char *hex;
+};
+
+static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 {
-	int status, exists;
+	struct min_abbrev_data *mad = cb_data;
+
+	char *hex = oid_to_hex(oid);
+	unsigned int i = mad->init_len;
+	while (mad->hex[i] && mad->hex[i] == hex[i])
+		i++;
+
+	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
+		mad->cur_len = i + 1;
+
+	return 0;
+}
 
+int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
+{
+	struct disambiguate_state ds;
+	struct min_abbrev_data mad;
+	struct object_id oid_ret;
 	if (len < 0) {
 		unsigned long count = approximate_object_count();
 		/*
@@ -503,19 +525,24 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	sha1_to_hex_r(hex, sha1);
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
-	exists = has_sha1_file(sha1);
-	while (len < GIT_SHA1_HEXSZ) {
-		struct object_id oid_ret;
-		status = get_short_oid(hex, len, &oid_ret, GET_OID_QUIETLY);
-		if (exists
-		    ? !status
-		    : status == SHORT_NAME_NOT_FOUND) {
-			hex[len] = 0;
-			return len;
-		}
-		len++;
-	}
-	return len;
+
+	if (init_object_disambiguation(hex, len, &ds) < 0)
+		return -1;
+
+	mad.init_len = len;
+	mad.cur_len = len;
+	mad.hex = hex;
+
+	ds.fn = extend_abbrev_len;
+	ds.always_call_fn = 1;
+	ds.cb_data = (void*)&mad;
+
+	find_short_object_filename(&ds);
+	find_short_packed_object(&ds);
+	(void)finish_object_disambiguation(&ds, &oid_ret);
+
+	hex[mad.cur_len] = 0;
+	return mad.cur_len;
 }
 
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
-- 
2.14.1.538.g56ec8fc98.dirty

