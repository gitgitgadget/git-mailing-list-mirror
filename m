Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24E81FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 18:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbdJHS3x (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 14:29:53 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:45072
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751610AbdJHS3w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 14:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GzymkpM7OVNs7+QGOsf3MCfMgGSBkxG6AGafVJbw1+w=;
 b=IggiGg0waqyAt7qmEt9jlaY713yOEDSy7a8KN/pQ5GMogNDVIZeAhdBp1/dZJA877GjXUGTPgU86RjfJhK4mwP7dGEpiNamW/euBhnr4kiqR0SMjttI6R4gRR5QqPe5JLJVWISK3XePl2QxrgO11tNenjY5GCU3pglQH0dOrE+c=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 SN4PR2101MB0734.namprd21.prod.outlook.com (2603:10b6:803:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Sun, 8 Oct
 2017 18:29:49 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2] cleanup: fix possible overflow errors in binary search
Date:   Sun,  8 Oct 2017 14:29:37 -0400
Message-Id: <20171008182937.69205-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <bd3c5fe2-ac6a-b978-163b-da07208b879c@gmail.com>
References: <bd3c5fe2-ac6a-b978-163b-da07208b879c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:404:121::17) To SN4PR2101MB0734.namprd21.prod.outlook.com
 (2603:10b6:803:51::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9720813e-55bb-4d2c-6917-08d50e7a8f53
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR2101MB0734;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;3:2uolCZHaSJtM5cSfZwCaZvvEG67dH+s9cP5v/AxYvxV8PIQudk4PQG1yF0947TOBOktDYXx6OJfc7BFsIkv2AKCulqVWw9+aUeD99nPzhntPyH5D6WP3E3IYNqhrD2Xq+550itmnAVkrT/vKhu95rlp6RIjmIOA+WvMbxBSmQjP6Lh3XV0sXGwZSJg30SRExMCrmaDSJVcEqLry/w4CVJ54gveqeyoC6Zy7RttWuUR5hQmTcf/mpmRqLPgagGbaC;25:x6vS0eS39ZQ02q6wRF6pst08YeEQrmfFZgN+vcczgb9YPva+JIaTPAQqPKzMZriyy4zUaBJVsgFvb+J9KzgSGmzvWeuVN1DX7romN5PgDA4rsutFRYdf4Rl9IYjCBGhTllcgOdKSMZPpQnIam5hV6Ve3u6h6Wk6g/fJklqRJyhOfNcjPQcSeb4XQcpnsZcYFeMuSQgz9VRdz2TdcvGX3ujmk8tVLieMAmdYNwRPmeBqMEdj/nVLRb72VZDQpmAjRFrn5TfAsCWAMTQKnetqEA9DHAQzyMj+rB3a57LYPGM9kx3q0/zLmBSF3tzndojyrRKT+kYH1EDEKzD14GkCYeA==;31:GPhIgxTw5PbPbKKHyO4seUXoFVqC91Wa/U+j06AbUYrdeGHMp71KbuXj2zxFfN4MLIHMDAUvmlH8fT1jebPz19Mk+G6EWtB3C8dRGkeBMGnLg1rRBH4wKlH+Nr1tXhqIcxb9aaVE0YILxv+kKa4uBcJ/piQGrqTiM55PLPrq0d1r70miIzLL3hbxXmUe3RRF5RR+dxvv42M2RsZEEpupYcEKnldzN6Dl2SM7/5xvlzY=
X-MS-TrafficTypeDiagnostic: SN4PR2101MB0734:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;20:1iEioB6h1ulQVk46L9zd2G3gQwrMGGQARon3oZVWs3Ny8w+xxcA9VkHhA/HpwDaYTbr2zt/aC58PRvVt/qFgHcAfjj7QYvvOpOASrSst3+eME+O95qATCAvQFFAImWBBS8zARkwCLbcc+VuZLSY1v/q6IzFeYyweA6DOQm60w+EEeyxYR7Zkqd/L4l3485q1nak493KQ16qDUTMcuXjiSUikFiP6w7UMAUyVB4Y+A39dNvICBGi/iOBbHX35ezs41gxcMWyPe/HY705b4+1Ca+vS5vCQhSgTZ0pNnqS4QqW2LGdNAHES3SvcAy/PWbA0hMMMw0gJeLX4kN62lBhFdU4dOc7S8ntTsoNkHaV/TSdvzBMiREO7n7CEPLGfJ6mbHjJlZOjGietY9Wd2eHPOcASH7RwZ8VeV3xztTKzHhTgJQpUzn7qg5IfuBOwEAsyzVlLmXaIH2XT46E4eDPK3o2WXs7MfO+6k3iL659R1pPzojncMx8P+ow1ZRAok8zlf;4:ADTvv3sxeS94br3ExrwDXKmmnHeY2UURWnD+J6c2UUVvhx5zybCBHKZYqj4J1u4BwHfK4GTPLFX48ZK5BhfGPJkxDjbSXG9rzLPLgr/oD6D2Cva7wSdLM6c9WlbcEttteoqzAVCAoKE6j9/fTsIfQjgAQzT1eosYtEAkgBJ49CWgqOuMYwfmH6TsHWCeaJPLR+elbYhDP1Bpm5adYHnPFtZ7Wap89+b9RiauSUjXOXaOO5ao2VmQfcKn4ItX/0tgL12D6meimuicD1LL7FM+FHUNkx0NNQuaM6lMqafr4qSI84ik3aVl1HZZeuVn6VTB8160hTl/rGHssbEr4lAGmA==
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(17755550239193);
X-Microsoft-Antispam-PRVS: <SN4PR2101MB07344DDABC946FB8552CE20BA1770@SN4PR2101MB0734.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(12181511122)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123562025)(20161123560025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR2101MB0734;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR2101MB0734;
X-Forefront-PRVS: 0454444834
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(6116002)(81156014)(6666003)(33646002)(81166006)(2361001)(47776003)(6916009)(8936002)(2950100002)(50226002)(8676002)(97736004)(48376002)(50466002)(2351001)(1076002)(22452003)(10090500001)(189998001)(25786009)(16586007)(86612001)(53936002)(575784001)(316002)(4326008)(5003940100001)(36756003)(39060400002)(107886003)(68736007)(6486002)(106356001)(10290500003)(5660300001)(76176999)(2906002)(8656003)(105586002)(86362001)(50986999)(478600001)(101416001)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0734;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR2101MB0734;23:6LFl1h4+UghITw26Q4TPiAAb2fcVjTTFPv/sNAt?=
 =?us-ascii?Q?NcD46Y3ynreOqlpUMBjqG+yZXuoA1+GaKeaMC5w2V9vTdssdGa/kq0XmEs4a?=
 =?us-ascii?Q?bX/rzcxSSP4C6rSZindD0vZFW4Z9dcAqdqiGIFsnJafNeoA9sDrTb7b+zF0Y?=
 =?us-ascii?Q?d8y4+fcTCIvIClKES2DMD1cICUpXt9DIhBT5T8nuKOsVga0WYNRTmq4+3tZ2?=
 =?us-ascii?Q?QUTuXIem30dtGaFdj3xDI5ZGU8IP2o/8z9LNMrulj0GBIxrtSKpSa9/7nE1v?=
 =?us-ascii?Q?hxF/d9dX03Y8xQpdAR7lhBUuuQ/RJDBLl6o6mbJfG93b239XCbnW2CLnVruQ?=
 =?us-ascii?Q?nnQTPg63CZed8bsYivCRiq0AIiDsSw5uWIxjwf1m+nqJZwC766wSABZ5zzCN?=
 =?us-ascii?Q?9karoxfl2zAZusvNN3twf1B7npZdHqzlJKAyrUX3n7i2qr2eUe64NMPR2C2/?=
 =?us-ascii?Q?VbI4IWj9CVU4mkNFLUoNeYIfIE9zgTVTgVMouN3GJPrtryuzmMYeRn8chKa5?=
 =?us-ascii?Q?3vUB+6CMBXPrxxF1xx1225bo3kZ5N+ijAp00kM7vU9p+niEXTnmr3XuhIx7e?=
 =?us-ascii?Q?jNxbp3ltzZYvhUM2H7reD9JhOmKnjvzX1eEK92gobtXcGqm25NhPrXFlZ9fz?=
 =?us-ascii?Q?gH7Hpv8pJpnWpL+gavbDNs4wteGmJNiOnXL1obL55ZizcVagMkS7u9goAO+f?=
 =?us-ascii?Q?G7OSj931zEYWEhnJVp5q/9bDBPgNG6D5OfyM1jBKBYwK9cFR3IoGxSP0xWqx?=
 =?us-ascii?Q?W67rwDgsjkFf1xoJSFXcnhMDlVsZ6nRy/ID2pdnkDgXbZaBpEyGI6SDZHVRR?=
 =?us-ascii?Q?C3utxrPd1zvXC9NB0KaKcalx54A18WEEuqnxfn1/HpW/TD3XKf1V7H0HGgVh?=
 =?us-ascii?Q?wsPSwsQVO7FpgSUNkhowPdeQL3SmExHHWuAPLaAZSiFkX5OkkTFR1M6ynGd7?=
 =?us-ascii?Q?ubkPzeH8LqwUDj6ihVrr5kyEWiSiy9UMqwKTgdmdJoY9/s3m+5VftOeyxMSI?=
 =?us-ascii?Q?DFgfyrQZaJqcBGSbIX+l1ZRi6jPhZNS/M59ddFSVuv7GvQpb7D3jWKavjI50?=
 =?us-ascii?Q?9cIEvhAZsJYPgwApxGfsMGkIi/OcN2gep7sNwPFYrhS0xOinLq62mw6HYQr0?=
 =?us-ascii?Q?G9T52CFhYbl2luWmQshwZ/9QY+2BTBIaLUHvKEo6Ag1sV8OOlXbj6x/ewbUZ?=
 =?us-ascii?Q?q47+7vyo54qfvSrVOfecRQV/oyViQmQ/wo+3kVu8wjLY8K5gr9qc+6tTSh36?=
 =?us-ascii?Q?JhKGM/4aQYMKKEFqJl9WSU3NLe5jkEigokULMuyGb?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;6:fvUVLyinHWyGvAG/Qa+sxnkCFLFdL7kXuVBntz3IyuUXvkBGQZ9k+gcueg1idZHB629v/4Vw29K9JVg7omqNXBUxrU9S5gZMrdQ/LM2U9jeLe3+E5uvWat1yMQD63pNR1lAIAdwQk+EVzJwxSVGeAMip4JroY/86BuQlrkNk3ButVXMD3dIx+ACAM0Xik2L9GqD+Fdnu562tvLs3/HCEXNDvwp+r33F1T3It9xHx6b6WKLFePX9dfX7g50C8HJkKE56Y/pwf6ALHlq1EAdjn1H5XCd+GNh6ItggRgLv5KTWgNLiEh/9plkSqJjlP5DG4rZ/vOJIqujWDTHxUFlnGIA==;5:SQN8FGKn/qDPB83PACUJZOVkf5rApA3kFt3xM0oAZNLApnNn6Ke7juv4Osjswqwi4fOLaZdfqV3cN5uh03r2AEEdgridfy2Tkif35GK8COUeZqZ9hEeLXTfEYgbFSiLSm1erupgF+kXuO8ZXYbkEtg==;24:eKmqo/KqeH8et+/VHsrjp8s15uqsk9c/jLXwc7RG5Sw6Nd9ckwaGEn4bA0SoSxWoROcCrWwMwZub6z1Bwsrxujcq9+spMZ8LukPXnEYOh6k=;7:s7anj7yebHjFeMF09T/vG50QY8TczmdQqb5zvzRUtROx9jwZpUolkbyD9MNvDhEITpn0x6kLxPUl4Di5flwvhSG9IQCcL2s5EELIpCF6hw5mEhq9Sps07jVHiI2ix70fHLlvHjnMY9T6vj849ojDVO/hRALIIisw931WnNIuQpFYH01PSjTyKHfsfaYmtEXG36BQIxslEexcaYz7AZDx7OAwMuEF+zeKjlg/nD51hek=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2017 18:29:49.1669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9720813e-55bb-4d2c-6917-08d50e7a8f53
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common mistake when writing binary search is to allow possible
integer overflow by using the simple average:

	mid = (min + max) / 2;

Instead, use the overflow-safe version:

	mid = min + (max - min) / 2;

This translation is safe since the operation occurs inside a loop
conditioned on "min < max". The included changes were found using
the following git grep:

	git grep '/ *2;' '*.c'

Making this cleanup will prevent future review friction when a new
binary search is contructed based on existing code.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/index-pack.c          | 4 ++--
 builtin/pack-objects.c        | 2 +-
 builtin/unpack-objects.c      | 2 +-
 cache-tree.c                  | 2 +-
 compat/regex/regex_internal.c | 4 ++--
 compat/regex/regexec.c        | 2 +-
 packfile.c                    | 2 +-
 sha1-lookup.c                 | 4 ++--
 sha1_name.c                   | 2 +-
 string-list.c                 | 2 +-
 utf8.c                        | 2 +-
 xdiff/xpatience.c             | 2 +-
 12 files changed, 15 insertions(+), 15 deletions(-)

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
diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index d4121f2f4..98342b831 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -613,7 +613,7 @@ re_string_reconstruct (re_string_t *pstr, int idx, int eflags)
 	      int low = 0, high = pstr->valid_len, mid;
 	      do
 		{
-		  mid = (high + low) / 2;
+		  mid = low + (high - low) / 2;
 		  if (pstr->offsets[mid] > offset)
 		    high = mid;
 		  else if (pstr->offsets[mid] < offset)
@@ -1394,7 +1394,7 @@ re_node_set_contains (const re_node_set *set, int elem)
   right = set->nelem - 1;
   while (idx < right)
     {
-      mid = (idx + right) / 2;
+      mid = idx + (right - idx) / 2;
       if (set->elems[mid] < elem)
 	idx = mid + 1;
       else
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 0a745d9c3..6f2b48a78 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -4284,7 +4284,7 @@ search_cur_bkref_entry (const re_match_context_t *mctx, int str_idx)
   last = right = mctx->nbkref_ents;
   for (left = 0; left < right;)
     {
-      mid = (left + right) / 2;
+      mid = left + (right - left) / 2;
       if (mctx->bkref_ents[mid].str_idx < str_idx)
 	left = mid + 1;
       else
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
index 2552b7902..4cf3ebd92 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -10,7 +10,7 @@ static uint32_t take2(const unsigned char *sha1)
  * Conventional binary search loop looks like this:
  *
  *      do {
- *              int mi = (lo + hi) / 2;
+ *              int mi = lo + (hi - lo) / 2;
  *              int cmp = "entry pointed at by mi" minus "target";
  *              if (!cmp)
  *                      return (mi is the wanted one)
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

