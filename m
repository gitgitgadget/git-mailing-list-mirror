Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1D11FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 13:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdJFNxA (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 09:53:00 -0400
Received: from mail-dm3nam03on0113.outbound.protection.outlook.com ([104.47.41.113]:9703
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750970AbdJFNw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 09:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+xbu/y3bhHgi9MeaX8TzEpDMGOIExTHC9uI75i/cVdI=;
 b=BB3B+vrM6GdJFkvnjHY7UlXqCcR6ThmzwoZoMHLGnVLgRJh1D8/eH6d0J1wXKVwqR9/faOYU3J8iTGoH7mwrMUZNervNSwW9GyIVZ7BDILZs38CWiopdim72Q4YWmI0ojHvlyynm/ZaaFxGjWY1t7Qp6zKjgG6FxMT5TrSbxPfM=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 SN4PR2101MB0735.namprd21.prod.outlook.com (2603:10b6:803:51::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Fri, 6 Oct
 2017 13:52:55 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] cleanup: fix possible overflow errors in binary search
Date:   Fri,  6 Oct 2017 09:52:31 -0400
Message-Id: <20171006135231.239232-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20171005094418.irm6omly67bgyvo7@sigill.intra.peff.net>
References: <20171005094418.irm6omly67bgyvo7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:404:5f::19) To SN4PR2101MB0735.namprd21.prod.outlook.com
 (2603:10b6:803:51::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d35107c-c95f-4fc0-c48a-08d50cc18bd8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR2101MB0735;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0735;3:u7VVbg4fQsYWStLxmGdYHddiV0feQ2WWJMJ7SH6Yhs2uww7R35t0YbaaQKNg6XYoYcYneR4w27b2MlisUtHgI+7RnHBJux+F9kzgMkQ14iBrVZUkfyEnbfYFCCXmGlyFnUo73T8Q4z7NpYCwTbeQLxW1qP07zShtpk7PiJzebTEPsQx0ubOI3QqljlVxu4tOcgBMPUmSxEJSMSnKXFn1KQBSJ5NIw7bTuf/3D+R8/RERoe6urFf33aM6ZxbsEXe6;25:PgaODDfHVeSdl0xBbDiWEYcLR34B4ZwynnyulFrTAerZmt1J/Vj+wL93EjNAxzGmO17b9uOwwKRLt0Fh18o06g332X2rCEy3G2bcb+9Ki3MYuWZpzRlgrcp6d2EgioY3iLVsIBV8Dg5fvhCFgV5fPLT89OxTQTE9O4nnLYnsBIdDxci5+e0yZdtURFzzz3HjEU94fUrbhqWs7L7vtlig8iaxGsNhnQjW7xtgOne6qV/26bt+UuUHz+Q6ahu2VpN0MfwsRO3qzhIRyQ8qsgUko8wpxH0zXNNvn1WPE0n7sZJ3O2Ox1TgLbEqMwsGpbLab0fVWZ9035Ss+TENLynGY/g==;31:RuAJWzKo9vkd/PDAG6ruJbVG7Zh8Oryog+KwHB2/+yH08VpQg193A0AFEjHxiMC/SshvSFpyX6sKY3Vv8PikCadoEhyEvi1+JSbmQNUvxhbtyLv10pSc1ojUInMeF0ZXpRYt01T3uq7eTqa0tcbCTAVwb4eIym8aL+Eh0P/cdAostpaC0zPHUFpmyfcWUowRZEZu14tlGk4lL7ee8GjKl26z1VI8qJ5ZUqb1GKAp59g=
X-MS-TrafficTypeDiagnostic: SN4PR2101MB0735:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0735;20:au30c5ki1Lc8zoZZr3pZyZeOl9ENJEU81KJ5gTXWoCe2Ox3DIDYwXkLx4CqJoTxLcNdjquVXN7OQThq/dolPt49l4kJjHyBYwfYyj2vXajWlLEcSNB71q4iCD1pjr60E3khY45CvFM9Q7g6soFcDadLkHR6bskzMEg7lwjkmbhcysZytDKM/+QhOscxiaW4WIxYuBui43WUKpmaLxUNNaA+j6hoqbUr2MAiZwrLMC5x+QEAFBZAfS6K02VWv1X92koCBLJUoQFAi+abEQC4S3cZq3wY7uxPm8t7m1JqleCCqWcqsPUq3u/4rplkvf3yQlEQwwEz6+cmtt/IpcqzGDlm+MRpgfpm6tV0NVtpCL1MmYqQf5oWVLelcYPHlYdqI3fYDCom4fd1sg2vECDUHUro7Uwz+7uSkWb70ZWT4YoIxCcx98HeeyJDxiw6YNjySsqulzTKmuU8tz948D6fyK5BWcCWjnf+RrMkV+jcJVZRuzgJP2Otyess8nFrSun6c;4:P+LEklf6wUk8NAD58swHeQn95ITK3Fncp9PzNxGtacxwz1CDAn+QAHnRji1jd9D1uAmDNjaSWfRJTl1mUQRsIOYmsGXCjEpBozg0V/EZqJ6WZJSbZfath/BvdYMMTx2tfDEWPM+LN1AEBR1qYNNUTG5xiJA5S73ifeRdp6ytBm1B1hX8qW6MZNruNjVQD6rPfUt20oYwlwN38MotqooWg7CkE/8/kEuV+xDf85+qSsVQgmyC6F23vqCHCUz9IuFCW1UXVMh/LHCxoTYuDx2ZH962PNH+c4WpyFZE9cW0qGk=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN4PR2101MB0735FC68EBB4A216374E356DA1710@SN4PR2101MB0735.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(100000703101)(100105400095)(12181511122)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR2101MB0735;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR2101MB0735;
X-Forefront-PRVS: 0452022BE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6009001)(39860400002)(346002)(376002)(47760400005)(199003)(189002)(7736002)(8656003)(6666003)(6916009)(16586007)(36756003)(2950100002)(50986999)(86362001)(575784001)(76176999)(106356001)(5003940100001)(189998001)(105586002)(101416001)(305945005)(86612001)(316002)(10090500001)(10290500003)(22452003)(47776003)(25786009)(68736007)(6486002)(97736004)(50466002)(1076002)(478600001)(50226002)(53936002)(8936002)(6116002)(5660300001)(2906002)(48376002)(2351001)(4326008)(81156014)(2361001)(33646002)(8676002)(107886003)(39060400002)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0735;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR2101MB0735;23:uFg576U97K7JIqd3DmPCleQBRFLoi5fuQ4y2+V9?=
 =?us-ascii?Q?UDsKNshmg4dKpG2F16DW6ELVqxRr0+bms+RTCuPlMyee5ky4MmafkVq2gKIg?=
 =?us-ascii?Q?/sc7ZZGJUnn/XTlN7oDX/lFo1PXhlYBkaJ+EGIpNRTRaRNrc9mTjXOwDHYip?=
 =?us-ascii?Q?m8Rf6m1RBMITjDZNfb/xExRei5z01it7iO0tpqyh+6gLwWO3HVWO3UuBHk00?=
 =?us-ascii?Q?sCSS0BK8ARzhEiYhYVe6e3ZhgGhOjvRSgGNZoKRenrymsuxE7o7z3Et0b5ZE?=
 =?us-ascii?Q?pV+3bIyR8sh6coP/ZNtsQ8nZrk6gL8EOb9wR447Y5yEZWT5u+kmW+y0x195K?=
 =?us-ascii?Q?3h6unnXBXV8QKQ2mH8cNkA9PDlmnhTX6wgH5JvUHBbkvJIv1lIsf/yyZsjPY?=
 =?us-ascii?Q?ySw2KBSjVlZD0VYWEOKMZmhKzEY6ewc4F/p8A+eqiEsrxW2Y3qf1gGbY24VN?=
 =?us-ascii?Q?HVHH+r9QmZJc+YiZJIWrvPcwAaogBecrf6Gz9BIYiRzZ8eA2YgwPGLT/6Twr?=
 =?us-ascii?Q?Qb5FCPwe6vf+rDyf9+d0LjQ9p7cDQfp2IyKXJ/61o8KOJ9xzVlf8LFj6T5fr?=
 =?us-ascii?Q?HG3B1NCZJ/rv1hNsaiYMD8NjOZSt5JQru+D4QSvC7IWBIOoqDfm/gHVNDctl?=
 =?us-ascii?Q?r6yhPBCcMnL/8v0i85HJKz0C5PnktuBZoLjVEnUnFo4iKZSFhcuKR8X9DEqL?=
 =?us-ascii?Q?j80T9ihIMZxcIzxR9QAR2p5cejO+3WrPyP2FnbQF/NgPYV7ioBOvddtSZe73?=
 =?us-ascii?Q?f3DzfNWIpdFMR086aKTMr18y34w9DaarIMt5fy2soIS/brWcgwH30ty0YQ3W?=
 =?us-ascii?Q?JDFtXiSACC8uenXO3sETaSci20+QLDXjFf1/ras/LUKe/BDL0G4A1eQKgIa3?=
 =?us-ascii?Q?0+72L2bVcv2d7vzb/XxgpiQ24DQC34v5qargw7RIgCdnSD/S79z1NZdxejW2?=
 =?us-ascii?Q?AfdZCtJtRuWqbnEimfDt1jd4Djnv/gu6x0i4g8RF53/sh2wQdRJLEicDrvry?=
 =?us-ascii?Q?lKbYipD5Yhnpo59VBMOnKxAqrS0E6ibomgvmhmmb5uRhnUVcweMuYgHFDbxx?=
 =?us-ascii?Q?WmG4u4sZXolkLj8HoP20QVuyWdd08V82Ss2dz58AeMeCFR3GwmFTJAWTR/XH?=
 =?us-ascii?Q?Qqa9aReXgiXUzxJVDFcStpWuZTis9pnhev3bRRQsM8uYR0hBZdNd2/Gb5OJA?=
 =?us-ascii?Q?AZgZ4vA7WCuQcSguFeZaSlFTx+UWHUbqwE9AffdBy1kB9KXiNHRd7qghLdPN?=
 =?us-ascii?Q?31rbJXuZPubJgYWwXX0K7CtUfW6obhfNmXMf8qnzlDSZGOPpgdHldqI82Hrd?=
 =?us-ascii?Q?86/IZo63YtL1WeiYshs5hhtc8HgoKPQhIEriteyWzv5RmD/hQ0f08dCOKB9z?=
 =?us-ascii?Q?E2CmG8w=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0735;6:yP+VjsdyttugDDHm2MWIFhUJd6qANJFyiZ0gMtRcbCLzScN9bvs73THu7H6REj8oEvXOn27BU5wRT+VLoLH9JWtoMdvjBreOt+m57yQZOT9xC8J2VFwiPK7DP1YzWXDPQmwwfQr5bm9KG9J57iCJIGqA+eH7q8HAkuGwERw8AK/UVTJ213JIyY17pMuxLnRd2w7/GZNRLGN+dh58aZE/AdEM/sixT9T61MzDRN3h7R8ECpewo7jx7i9OGfLLFrdeTHwbsSQ+fehUnvdL+jHZYuls3RtluLKWLAUuoRSapknrJ5xqiuFdT4y61o9ybSJYfC3aqro4x333Lob+oGdMUQ==;5:+tbRRomQy96D/PfzDTnQZHrXMx0L68lPv/ujZN3MpHBwCO2b9GwNbJ5vVjIkTvoaQzphRfSHyg5T25gCIhHcwAgz7SN42P+GWsv20wCAhYgzpFlNO/h5qLyn6+KdlEIb7SZxVLvqTB69XVZ4nuva2A==;24:6lGl3Brg3saA9ENa5pX9DOBWRZbqZWlHAf/xxJUKFg3Ari1LxwvgQ2v0oh5jPMXC7QM+hedm0Gsuta9LoRGQQhqFtWloaxlhlW/1Y8H5q3A=;7:YgXXbDx73tj22mnIR6qPZ1dVbSVwyNXhN/8Wu7rGJKoI/b3LlqFsiKyAY+06lUIabsv+e05bgSi2ussqE9gkqnRei8bRWvuiMiDx4fvWDwkeor8b6/zOh34AZv7BxgHLpOFeNiWmqZPzUFcl7tIo4vs9SRTeR5vQowlEfyb/oRESTfEEzQ5Zjxyb/LsU0Hr1IhvgjvWew5UVKS2vAuckkjNPtf0ACbxdrqjmIzachYE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2017 13:52:55.3191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d35107c-c95f-4fc0-c48a-08d50cc18bd8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0735
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common mistake when writing binary search is to allow possible
integer overflow by using the simple average:

	mid = (min + max) / 2;

Instead, use the overflow-safe version:

	mid = min + (max - min) / 2;

The included changes were found using the following two greps:

	grep "/ 2;" *.c
	grep "/ 2;" */*.c
	grep "/2;" */*.c

Making this cleanup will prevent future review friction when a new
binary search is contructed based on existing code.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/index-pack.c     | 4 ++--
 builtin/pack-objects.c   | 2 +-
 builtin/unpack-objects.c | 2 +-
 cache-tree.c             | 2 +-
 packfile.c               | 2 +-
 sha1-lookup.c            | 2 +-
 sha1_name.c              | 2 +-
 string-list.c            | 2 +-
 utf8.c                   | 2 +-
 xdiff/xpatience.c        | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f2be145e1..8ec459f52 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -633,7 +633,7 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
 	int first = 0, last = nr_ofs_deltas;
 
 	while (first < last) {
-		int next = (first + last) / 2;
+		int next = first + (last - first) / 2;
 		struct ofs_delta_entry *delta = &ofs_deltas[next];
 		int cmp;
 
@@ -687,7 +687,7 @@ static int find_ref_delta(const unsigned char *sha1, enum object_type type)
 	int first = 0, last = nr_ref_deltas;
 
 	while (first < last) {
-		int next = (first + last) / 2;
+		int next = first + (last - first) / 2;
 		struct ref_delta_entry *delta = &ref_deltas[next];
 		int cmp;
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5ee2c48ff..6e77dfd44 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1277,7 +1277,7 @@ static int done_pbase_path_pos(unsigned hash)
 	int lo = 0;
 	int hi = done_pbase_paths_num;
 	while (lo < hi) {
-		int mi = (hi + lo) / 2;
+		int mi = lo + (hi - lo) / 2;
 		if (done_pbase_paths[mi] == hash)
 			return mi;
 		if (done_pbase_paths[mi] < hash)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 689a29fac..62ea264c4 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -394,7 +394,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		lo = 0;
 		hi = nr;
 		while (lo < hi) {
-			mid = (lo + hi)/2;
+			mid = lo + (hi - lo) / 2;
 			if (base_offset < obj_list[mid].offset) {
 				hi = mid;
 			} else if (base_offset > obj_list[mid].offset) {
diff --git a/cache-tree.c b/cache-tree.c
index 71d092ed5..d3f740127 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -49,7 +49,7 @@ static int subtree_pos(struct cache_tree *it, const char *path, int pathlen)
 	lo = 0;
 	hi = it->subtree_nr;
 	while (lo < hi) {
-		int mi = (lo + hi) / 2;
+		int mi = lo + (hi - lo) / 2;
 		struct cache_tree_sub *mdl = down[mi];
 		int cmp = subtree_name_cmp(path, pathlen,
 					   mdl->name, mdl->namelen);
diff --git a/packfile.c b/packfile.c
index eab754248..4a5fe7ab1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1743,7 +1743,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		       sha1[0], sha1[1], sha1[2], lo, hi, p->num_objects);
 
 	while (lo < hi) {
-		unsigned mi = (lo + hi) / 2;
+		unsigned mi = lo + (hi - lo) / 2;
 		int cmp = hashcmp(index + mi * stride, sha1);
 
 		if (debug_lookup)
diff --git a/sha1-lookup.c b/sha1-lookup.c
index 2552b7902..df08f8355 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -95,7 +95,7 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 			hi = mi;
 		else
 			lo = mi + 1;
-		mi = (hi + lo) / 2;
+		mi = lo + (hi - lo) / 2;
 	} while (lo < hi);
 	return -lo-1;
 }
diff --git a/sha1_name.c b/sha1_name.c
index 134ac9742..c7c5ab376 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -157,7 +157,7 @@ static void unique_in_pack(struct packed_git *p,
 	num = p->num_objects;
 	last = num;
 	while (first < last) {
-		uint32_t mid = (first + last) / 2;
+		uint32_t mid = first + (last - first) / 2;
 		const unsigned char *current;
 		int cmp;
 
diff --git a/string-list.c b/string-list.c
index 806b4c872..a0cf0cfe8 100644
--- a/string-list.c
+++ b/string-list.c
@@ -16,7 +16,7 @@ static int get_entry_index(const struct string_list *list, const char *string,
 	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 
 	while (left + 1 < right) {
-		int middle = (left + right) / 2;
+		int middle = left + (right - left) / 2;
 		int compare = cmp(string, list->items[middle].string);
 		if (compare < 0)
 			right = middle;
diff --git a/utf8.c b/utf8.c
index 47a42047c..2c27ce013 100644
--- a/utf8.c
+++ b/utf8.c
@@ -32,7 +32,7 @@ static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
 	if (ucs < table[0].first || ucs > table[max].last)
 		return 0;
 	while (max >= min) {
-		mid = (min + max) / 2;
+		mid = min + (max - min) / 2;
 		if (ucs > table[mid].last)
 			min = mid + 1;
 		else if (ucs < table[mid].first)
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index a613efc70..9f91702de 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -166,7 +166,7 @@ static int binary_search(struct entry **sequence, int longest,
 	int left = -1, right = longest;
 
 	while (left + 1 < right) {
-		int middle = (left + right) / 2;
+		int middle = left + (right - left) / 2;
 		/* by construction, no two entries can be equal */
 		if (sequence[middle]->line2 > entry->line2)
 			right = middle;
-- 
2.14.1.538.g56ec8fc98.dirty

