Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C96620A26
	for <e@80x24.org>; Mon, 25 Sep 2017 09:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934510AbdIYJza (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 05:55:30 -0400
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:37136
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933128AbdIYJz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 05:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WWnLtAUpUuY8hulT1KN0psyFoAL8b9mhjDKsXLl7jVE=;
 b=k2DARrZCnz8KWJ+KSTHCJ8DpOwEenJ2559kFs6JNLdxXvc7C0+hUJPHVu2E4QhSbZogopVA15aE4RYK96/U/goRRsUA3T7PTcJ1FOQpSgFNpLKYt1GLbT0rEbg3uAxRAIcfmP78Jz1EpDyf+uQ8mezeGvn4LF+ZOkQABKUOuV3Q=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 DM2PR21MB0092.namprd21.prod.outlook.com (2a01:111:e400:50c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.98.3; Mon, 25 Sep
 2017 09:55:21 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 5/5] sha1_name: Minimize OID comparisons during disambiguation
Date:   Mon, 25 Sep 2017 05:54:52 -0400
Message-Id: <20170925095452.66833-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:404:b9::17) To DM2PR21MB0092.namprd21.prod.outlook.com
 (2a01:111:e400:50c7::12)
X-MS-Office365-Filtering-Correlation-Id: 04f22e70-8800-43ec-f51f-08d503fb891d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:DM2PR21MB0092;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;3:KBCsinP+5CGjbFGOsG4AXUFZ0SVl1ktV80cymDScgx4/gMC0HqnxikjI1lBLXCLVUbts9UeabvsEz9ljvgDrR3K9eJ75EWf1/fXAbsUM50vmURpgd6OVQ9NtyHI/g5AjQgZQk2FzVHkRPtvl9jwJhMh4mt0hu+Wd6esCAOyC63IBLmCw0kuGCloPfxv3CxWTT8RDlqa9Aec/OxE6li/OI1cUrjNCI92bLRKnMtGWfPJfSOMaex6Cbgsza37OPqmd;25:Qegj28WbHqTJZd9gLPwk1wqknEsGYxBasAnzBo//4kATQHAXyFja27OundnkXICXF3U+YnSMi9vce/nShkszCu5afgfbJINRf51lqgUk4o7FwBexxfZjHTZRk9EXwg0a4sC2giZ3BWge2z0WavofLCUkc1dZ/a/AJHJT8LRgx7sRPr16fYat31BcfKiLOTz0+p0WIPWDT0onKO2HK8wPLWxG9Lkefo+ymyRSu1uhmHgFOLI/fgqdZEzFyAC7wnWIDfgSbxlHtdnco4D6I0TehUcMmD42UH07QdDkKtJLmMN4IeUqeo/BjBGcT3mVYXP5RIvpvTmAehmv+saSaVxpwA==;31:zRwPoO5zDUqnzQmIYArAuStnVW8AD4VDgVrJwbuXxiVqsGMCob7J7piUUDt+8JuGuSZhZdBdsXzusvJZFUAio+2mVgdEpdsY+hHY1gZhHDtiWNICs9S4iZXKn58Cd0z6fJdzrOoaFVDp5nXTMchAhwtHiyDEocVQRaZmIP7cN2r3SXPQqGqEhcGnBaMlMTi5h9/JI+eaA+kgUOIyg4vczOLsyelnSwI8UChAGCYhXEQ=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0092:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;20:pkJb7voSITJi/tfHkZmLBkXo3nDG9K1gxdfa7jUFsoKzWA7jPYqOT7nbiCp4ZzQFQqTfvHm80SbM9I6Uwq6wwweCNCeo+oWGCfY5WWgYFf+q0DSvjH53yHC6vjmIYfJ9DyCNbVqBO+3kr0IAOtjm680abzxsVVSK3yCztBkQ6GjyT8gWBxkxabr+LSEeN80Bh0rk0TNTy0V5cEZSk5n2R0ZYYDq51VtokXwTkqLP0s6SAwK4cd50QCJ7WJxTJNr55XORsSZPmH8sUhWgMNh3635IrjGlRc5gJ5oC4OghTEJ9EMu+8yzFFZKS9ypsQDrkq6YyExP0CPvGvJ5VcoDngfkMtRyXPTCydrgmOQ0RBd2wUpqQ0LpE+/PvOenDH5NuqFYtrRSJPcqsfobo4FD/i+1alaAaJKm3p5Lwj6UEgjg8L/NEeWuooqByUuuiYFP24YTzWK/TfBf26rR/UjvxKC1lVKsi7dt74iyKsoZIjiWoo3iPUNKvvNvzUefufuUp;4:9jfK5jtmUZiJQ9FG5/wi3kyTERrhL8Ij2n6lG9aAmM/WkgZoWEORPD1cEDM49x08I2LqxQRA1xyFzENyOqrXiFE2G8GNwnqbPXuF2j0lOpqZ735hrzsxHS18ym0IYMBggBAs4PhYY9jz67Wf7RJIhVj254uIZzQdYHG/4qRtFX4vZ1QQg1B6OYwyyYoNKZi156y8U+4wWp0Orq2/9eUrWgBvKl4P9ubMyip8A4HW587qFEoIS/NOz0f1xkelcsZSUiECH+cFAOxsOrZmc75xdYHtMGVR6qp4Cco7oyoBvC0=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <DM2PR21MB00924C82D2F6B0790FDB82A9A17A0@DM2PR21MB0092.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123555025)(20161123562025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0092;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0092;
X-Forefront-PRVS: 04410E544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(43544003)(189002)(199003)(316002)(305945005)(68736007)(86362001)(10290500003)(101416001)(6666003)(7736002)(478600001)(2950100002)(105586002)(53936002)(6916009)(2351001)(86612001)(4326008)(2361001)(1076002)(48376002)(10090500001)(6116002)(189998001)(81166006)(5660300001)(25786009)(8676002)(97736004)(106356001)(39060400002)(107886003)(81156014)(36756003)(50986999)(22452003)(6486002)(8936002)(2906002)(47776003)(5003940100001)(50466002)(16586007)(33646002)(76176999)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0092;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0092;23:VYsNozrQxd8IT2wqnptaat+2rtWJfMbdw/7CPrN37?=
 =?us-ascii?Q?TE0MXuoyOAaMNDFJJFGwWAnwYHm/OIjVe6OOBBg5xF+wykrxBhsItrm7QIKD?=
 =?us-ascii?Q?Nn60VcaCXtIshXUC2MXmlmS07rW+h0JXQnIdb38k6KaDJQAX0wmgjn73V/lY?=
 =?us-ascii?Q?2aJjQoLSoueRG6kcWoE4GxUBUQFki3j2Hfw50ksaAJwxfyI6oaedQwN53ea5?=
 =?us-ascii?Q?Spg66YEBlO/6khXI9vvPf5fLyw50ZwCC4b7UBkNdWYhNwiyyymmFWOVtS2V+?=
 =?us-ascii?Q?o4S5785ALxVPMgwcZJFa+4QbP9CpMzkel73iQzjYoBBs5d2GIsAG9IEilPDA?=
 =?us-ascii?Q?BIi6M3FsB3tHRMmbNqnx0GmWAEs0oGg0b5m1M4vR2L6PN8Jp/5H/rrPCqQzS?=
 =?us-ascii?Q?CBixPlkxbKxZ49vkGYDri8h1LnmGoMuZcXrLCZznX2jf2a+W1ezJNYEkznvB?=
 =?us-ascii?Q?R9s8XrTukeNYmdSFYyrZLDabEj1rH4DN46ToSVTESiXJIdO24JT3Cnx8sgqc?=
 =?us-ascii?Q?5BAI/+0q2rwZhG7NJcjrQADkA15hBSJTzNhR5kIqw+OvK7qnZM+WH77cNZGf?=
 =?us-ascii?Q?U284M58SRxGufpsQKpUC8fm7hkX3IpxPPNwVLt1h0iXBrLU0HW7W2zNNzrSC?=
 =?us-ascii?Q?gBKSNDZXs5GEj0+5ytmp+N0o5MeZOr6lnyK0LT3/FlJ4PdIgZxB0ZkPw1vKt?=
 =?us-ascii?Q?IfB5MUKCPPvewV3dhYeNc0j8+pAgZFJYUYQd4kdEE7AGmLFpxrSpUkJuSiLT?=
 =?us-ascii?Q?gCcJqmD7QFkBz6/mqBfzV7FHAha76aHUBuN7nwgrzOKeaQX3U9VXId5qjBuD?=
 =?us-ascii?Q?CDbgcR6euaM4cMfktwJrAVGejjKBL9gLbYtG3v8C9T5l55BBpZPoEsOlYBJb?=
 =?us-ascii?Q?8y9/r0rfRBPxQuuFRomWY5FkfiqtR12AIf0dJB1nFLRLcueleTLYLocUi813?=
 =?us-ascii?Q?Psk+8GuNbynhf09v+GCI8sbTmpT+9PUJUafIGGbcRjX+L1l12fzV6+5+UENR?=
 =?us-ascii?Q?JFfvXk+5XaqxyRTmwMdkHmTnKHYmgX5nxcP/Buwg/M9Yb1vLB9thB8gOI2vy?=
 =?us-ascii?Q?dkWpUNePi7dccTrnLdmZi6K2CqgDT9TyKiMd4Zs4y4t48ui53DfYohH7a5qL?=
 =?us-ascii?Q?fGp4W9kZcPmRMVRDzYSTrw2Uuz1czuOdUV1QzXy3uXBzNfkcAqszaGDa8qF5?=
 =?us-ascii?Q?YivfLBEFch7nzqtnllkIBpvc9It0UVGDhRk/SQGpafn8k8O22961xamkAwgM?=
 =?us-ascii?Q?MHbDe3W8E2D7khpFkY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;6:zdEdCfGeGCsOy7JPEPf0CrpASHpa/bHDL36tVw2rUiEBqcsfe78MsghHNFaEfMGqtUqEIL1w0yxMXUtvcl561XtddAGdeEQODdeKmlmujasessHcyAJb4YGmyK7hdoIAaKgPXR7bzpRviJs4btGhcAM93trAzpaP29NrR0sdhfngb7MiHG0yOUZBH0PWymKWLOp77zS+RokmVLsjDgT5tOFPx4GYi0tCfP3GyRaomaB+8i/WCD7GiA4DwO2Tx2zPOveizu/Ev0wEXdELQOuTomcijunZkg2AgWQCDUBSwvU9WMRN5646J9nE5ZM5VCQ0kVj7OMrO2fXphJRvvZkrhg==;5:ZtueXJfH0/2M4a8GExxu1DJzt2RPElZhsbedwYtOcVotAa9zxLoKnD7+Fp10aPXh8A8ISwHJguyb9iWSYPpHyFPXGiEK+uXbmMZH6/9kp06rYUjYMfKkFcQk8EgwNjnkh4uRDS5VAfP+gq6yPcnQvQ==;24:c6csDNQ7s5O3i8N4eXRLzFSB8xYfxqIimD+jE3CCahxxMDF7RwPtkyMzqn7mZPQ/espfx5cYILKTCAOhnXEg1PXolr3PhF05+cz14Ycbz14=;7:w+JDKJPjw/6oOW+Gzs05ioO51bhX+6rY4kE1F/rCgxQHyZKnpSWrpjSo54wthjiUWNQPsGdFjNBi3+DntcEStT5BoXwfmoW7AYwPynen8GiGYx2aXDbbKfcawu3KGi9Naneq1tmoUOCclngV1Vcz2VKsrJC/IEgh99AMaEEiF4DZvh6m4Zf/XhU+wkNvU5aCcCRWqt0XiowcTgXp+FsRTSLWx2E/iQnPxg4Rm3jP7MY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2017 09:55:21.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0092
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minimize OID comparisons during disambiguatiosn of packfile OIDs.

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

p0008.1: find_unique_abbrev() for existing objects
--------------------------------------------------

For 10 repeated tests, each checking 100,000 known objects, we find the
following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.08 s | 0.05 s | -37.5% |
| Git   |     5 |  230162 |      0 | 0.16 s | 0.15 s | - 6.3% |
| Git   |     4 |  154310 |  75852 | 0.12 s | 0.11 s | - 8.3% |
| Linux |     1 | 5606645 |      0 | 0.25 s | 0.10 s | -60.0% |
| Linux |    24 | 5606645 |      0 | 2.08 s | 2.00 s | - 3.8% |
| Linux |    23 | 5283204 | 323441 | 1.69 s | 1.62 s | - 4.1% |
| VSTS  |     1 | 4355923 |      0 | 0.22 s | 0.09 s | -59.1% |
| VSTS  |    32 | 4355923 |      0 | 1.99 s | 2.01 s | + 1.0% |
| VSTS  |    31 | 4276829 |  79094 | 3.20 s | 3.02 s | - 5.6% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 4.62 s
      New Time: 4.09 s
         Rel %: -11.5%

p0008.2: find_unique_abbrev() for missing objects
-------------------------------------------------

For 10 repeated tests, each checking 100,000 missing objects, we find
the following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.05 s | 0.04 s | -20.0% |
| Git   |     5 |  230162 |      0 | 0.15 s | 0.15 s |   0.0% |
| Git   |     4 |  154310 |  75852 | 0.12 s | 0.12 s |   0.0% |
| Linux |     1 | 5606645 |      0 | 0.17 s | 0.05 s | -70.6% |
| Linux |    24 | 5606645 |      0 | 1.30 s | 1.28 s | - 1.5% |
| Linux |    23 | 5283204 | 323441 | 1.10 s | 0.96 s | -12.7% |
| VSTS  |     1 | 4355923 |      0 | 0.12 s | 0.05 s | -58.3% |
| VSTS  |    32 | 4355923 |      0 | 1.34 s | 1.36 s | + 1.5% |
| VSTS  |    31 | 4276829 |  79094 | 1.34 s | 1.36 s | + 1.5% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 3.08 s
      New Time: 2.72 s
         Rel %: -11.8

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index bb47b6702..1566cd4fc 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -478,6 +478,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
+	const unsigned char *hash;
 };
 
 static inline char get_hex_char_from_oid(const struct object_id *oid, int i)
@@ -504,6 +505,65 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static void find_abbrev_len_for_pack(struct packed_git *p,
+				     struct min_abbrev_data *mad)
+{
+	int match = 0;
+	uint32_t num, last, first = 0;
+	struct object_id oid;
+
+	open_pack_index(p);
+	num = p->num_objects;
+	last = num;
+	while (first < last) {
+		uint32_t mid = (first + last) / 2;
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
@@ -535,19 +595,21 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
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

