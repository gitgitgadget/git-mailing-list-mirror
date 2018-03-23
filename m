Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A31A1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeCWOpF (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:45:05 -0400
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com ([104.47.33.111]:49120
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751812AbeCWOpC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xbFqMs4ThRCOXyliPFHGrlROEXe60SF08PluZkho194=;
 b=frRtEmiVISF1l++MOyT3pNczB8jd43f3KYjtWvI6CxByP1xrWC2YrHd3dwZSs7bhS9tQ3Rfzmekn+SH5yQZo+0v6gRADXA1FNUUSXZ766e4Y25KTHej6VHfKkdTPHkAMzx1Uf9c8MGLszLAPP0rQ7tiboLshjqSsWybQdV7xeKs=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 BL0PR2101MB1105.namprd21.prod.outlook.com (2603:10b6:207:37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.631.2; Fri, 23 Mar
 2018 14:45:00 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 2/5] fast-import: introduce mem_pool type
Date:   Fri, 23 Mar 2018 10:44:05 -0400
Message-Id: <20180323144408.213145-3-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1:1060:bd2c:4297:50e]
X-ClientProxiedBy: DM5PR0102CA0021.prod.exchangelabs.com (2603:10b6:4:9c::34)
 To BL0PR2101MB1105.namprd21.prod.outlook.com (2603:10b6:207:37::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1d4aa82-95be-43da-8da5-08d590cca824
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1105;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;3:nPdaB+VL2dSKol8wnKZIpeCFAFzpJ10fKz3MUufewwrlO3g+EckdBzZsPmzH0+cDHog/XK1PpfqXg7b8Rb33YACz0K1PlcFduhd5+afbUE7g5aDhBM3VLSxNFcPvERwc5qa71kypMW+4UHzkLf5hcRsxGhnm/jhnmYuJbEyl3YGn8y6jq213+mzAm80HCHQvS6i8UNx8uQyUx6HdURLBpjZhQqAk6l04hDHnFBwkTnAXPzvkDqvmvwfwTcn25owo;25:AtY9g6jzIMcn6xVgPHmA//8pEsLFgaPv6Ptlns8ivtc3QLdpj7I7R0vFlTmfVdFVG8QPBfwckj3rUWkO9nCh47SrgPQvNhL8xpLMVloyM1Y5MIrVRdX5+YaenuuHRl0D6bDLcjwzSChcpDuaj0QFLrvRbZje9Y1C47eEQwAb/v81xWbawvXUWU2bwEblh/ICJBUOkV+fLfFnfl5Pj33oLIfRLFkISHDS58OwWiY9LABbu2hbUX34+VQov/ifkUoCejTkEgRTa2kPu/1ASWyeI6YyK6nwxcRiJRukYequxm8x8OiXVaQzjM4sK2xxWfGhptQ+opG4SXMho1mPOkt1Ww==;31:xxDhhPk9sjC64Y7Bf78+Kd25IYAPinrcHTSP8YJUCJpAYR8al0Vojp8rbZx16O4Uvkx2qytm0qw2vL0j5Bj0aRMa5fSCYy4LkFay4PpnEuaqyR22kMIAjMVAioN0gXSLnESqopkAz41fLMVbu4aJEr7SXUtFeKAO6Uk8HxT3h1as/pEhBylF9mvpAD6t2iPN+NN4XvzAYiOH92tz5brFXPsCmBng5SiwnZ4meLpW8zk=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1105:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;20:b5cgpAzUdPbPL0zq2X070i2LPc6iri8vH8y7uNaRGiuXJ9TRpZtUZ9Ihv0QwCvybeJWdrLftJDIcU98ayhroco5igTfbtSxL/PndU5+ciZ9uzV15LtsOcekgNZQ+gI05Mq3ejWOiBLCGfNIC9bDJl/1H3hsCxlsErsgeyt0S+JQrr6jTTNPildkbmTDHxE9r/O0JNMar1y9RRH2u7B/XsBeg+/Z4ROYIqQpBg1RUYCMF6ouC/GWAaT85RQtCwrF+lovLnV8pYudAuhAZOFTaY1YXthKyJpJWenPd6chXauVbrkw5coO0m0vvhVp0CsuS9Cyqy+JSzFIBnJomXKRA2gOaMShfSESxtbdVDQ4+ByeIcJUw5RV8cZEdxKkmIQNfmAb00tQnvOgENEvsrVNIgGWC6817oMCeWh7TEYWg2GUW2AO9RnKW/JGh1sWuOxCNzx0ToY7vDTKCNyuOnb+tF9xtPKZXl0nZ0twsKe263rT28AN5EWPdov72aO+CihmG;4:Ml+J2rz5KBJikJlLQbb+ckoxM6fohVGJh+6ghNddj3bTM9Wz67+nMU6OYZGRqbhOq44wYCwL8IXyCKEUpgRklXR+m3ifqyoW8qQEYskTfKYJ8+Jh5O7mfgQtXINiCu7lOZFOBXGWDvIp4O33x6/i0YajQXH9foa51xXZuSYFkPf2HSasGZjf91qh43xc0WKYxHMc3+4/eBJPUMf6gGXF5gpYj3Uwf6JN3l6mjLAgPhzkwKBH5drRrrVl9PmWJGkMNOW8Y+XILpbCit7b/ojsIfzyG2DuDgSJQW9TaP/kfZL2ZzaAadYsiXRat0+j52TrhqTmjfqHn8ha6vF4ZGdzPQesR9fTwaBZXMEcMYSIzZ4=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB110564F433D9327B0308659ACEA80@BL0PR2101MB1105.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(305945005)(446003)(46003)(11346002)(36756003)(6916009)(4326008)(5660300001)(2906002)(186003)(68736007)(10290500003)(25786009)(7736002)(107886003)(16526019)(86362001)(2351001)(8936002)(8656006)(22452003)(76506005)(478600001)(50226002)(47776003)(52116002)(6346003)(316002)(52396003)(97736004)(48376002)(86612001)(8676002)(81156014)(81166006)(51416003)(7696005)(1076002)(105586002)(106356001)(76176011)(16586007)(386003)(50466002)(2361001)(53936002)(10090500001)(6486002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1105;23:6LnDS9YrJfcy9Ro2AiZup2gpWwdJIhdlrNyZRD/?=
 =?us-ascii?Q?C7beGeVokQxG0pF5KIqiCH8ZJy6ValRDmjkOFmvKd/eYW7anhndBKY8HyMu0?=
 =?us-ascii?Q?TDbpsktY2+FMtABk9GcRoNg9B24c7KN26mU+IYoxe1mrXDaublzPim578MHz?=
 =?us-ascii?Q?CRvlFD2Tj0bcioIuxlN8SoJYDWPsPagCdfv2rkcj9wiP8qgto8R1N7CH3ylx?=
 =?us-ascii?Q?kJD3gCZdIQOUSzERb2MtZn5HT6Yh2hYQM1UfBGpGMTrwEI6rDWmF0bC3Ky7d?=
 =?us-ascii?Q?+05JXJe7+PvagqTCfZL0ixbp7qbDqPnTu07v/t51ajamZ9b3UgqC22S6Oc1s?=
 =?us-ascii?Q?AnJrxBaMMlp19iTYHqf3IEwKHg7CTKWAmoP9zC7MlmpBhDPJFhXmV3XbykuP?=
 =?us-ascii?Q?8j+se5JDaaCLjytOPVRC/LkYOWZYmsfbK3nhimWWn5/3IWacIxr2vEk3n9ou?=
 =?us-ascii?Q?TVg+b/2FaVgaTgkxS96gldTDcIAttn7JDGaAD/y+xlHYo6q/8RVno0F7eXuY?=
 =?us-ascii?Q?modr3ARbloswQHTu+5YxLwuU6IcXrXZxPiFa9IJmNOa0E9dif2J4p9WKhGUL?=
 =?us-ascii?Q?REyrwqLT3E6wGJPzInPIhfTwv35Zoi848YjnJ6NKLfJgLWmFhFqJ2wNMkIcn?=
 =?us-ascii?Q?0uoC6TkvSgCFj0TkI0cf4/6m1dsQfuM5f+eiqBqaqrJhpkgIF3iWo8qbwriw?=
 =?us-ascii?Q?M0j3igZA1UAmSYjbdR0qs61lzIURpSmcWPk+TFu3cOELe7bjMFZZ3BZQrHwQ?=
 =?us-ascii?Q?8ajPC4oxlSXtuVCQUf3Pc5lX+Tb9CRvLD/uMnEK5ELeo7uNsSkpWkwJBLFlL?=
 =?us-ascii?Q?sVCp++ga5vPk2ktYwj5NBVhhpMcNo6tASnsjNseElMkHxY3E4dQMkhQNp8Ry?=
 =?us-ascii?Q?PgCY5ASeOd4A/cjKDFC3Yi47e3ciD5DcVpykigdkUcBgtlr5gmwUzDI6JASC?=
 =?us-ascii?Q?PVUW0VpuqzzjUw2YiPMV+R/Wj6KKr5PkCmXukJARFgd41shUAzMmTVOIlwz1?=
 =?us-ascii?Q?zS3N5ktul9S8IK8fktWay0Yr61M7vdaP14YKs3CJ7ouMZcoOpsYAmkzVykOE?=
 =?us-ascii?Q?5W3l6urV6MIRnm9gwHZp2VvG3vpm9n++iSrqTBfsaQVs+7hNid8rtUQqZTrt?=
 =?us-ascii?Q?//iWHBX/FGBbmH6FWIQzFUSZyRcVzKxiD/K22TAqzToyzuG1nJUZqlCoWSsS?=
 =?us-ascii?Q?WpI/+zjsGHL/GKDsNasizfCjxQqGDvORjc5z4j2lh62bKbCbt4JjZz1dMuti?=
 =?us-ascii?Q?AM5IjxboJ8Bg6++7aTHkq99FC6VzTbyusuB7yJcsCFXdCSaru5w9iGi3uB+0?=
 =?us-ascii?Q?TQbBntoNyufmZkb5hd2h8U5E=3D?=
X-Microsoft-Antispam-Message-Info: pLcT0Te98GrUDg31L+vVW0Jv7htgR/M7XK/8w/+MTLbDau4uAhJKy3daLJj8OmPbvBV4oh+eI5QmWoHrDwW7HalQlhrg6ic0oncuOdwVRp5Ry2w1B2jZc/OhBbCGuxz2blJiHiFz4J2R63D0STad4wQWeoYlum1U/s5SPQ8oEApwaSU5vcxtd//MecN39051
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;6:9r3M2dubM37e5pIf36uALurYOE8aMQF9P5Qz8lPGmfLKHdeoYs8TbA60uQ3EExY6g6ATIUt52QMfN3nauln6nEiWsHgHLQPQLh8qyDKBFenrXS/sXrRzumlRMT5bQyRn7NGUffo5sXVyF8HGuLDGhwq5Ujl3wv3Mw0z8ciaMxJuAvs9GoUie2CwRoMnJ29Jii9jJfpoH6QUakh7fJn6y1U/5dfbzZyLWPJA1prZOW5eS7kKhlFFvXXduInYOGP21RpxVum4A/RR/15/X1Xjig+nuazPAtSOAHQgzsHjoKfLvBjs+0PgolrALQ8II2mylgS31XMk83n6SYfZxruh65NmvsLrsx/ImxzaSv/Nbq5vidnmfz9VFh3BW/JsYAbpAciMcML32UUBuWhPsVU2wKQFnJsHzoUU9uZJt7gU38cvxx6GI9eE92b4ZtXr6Gl1znQG2CLdokSY11Ud3nfLtzA==;5:hXnfrlgvToW2CRb4KbCpDIsuvDyfdCf7CtfkIeVoEo4r7a8N1IJMq8EB8B8wlPV6tW5S/jFn4POPqrUHeL/j4vZCbvAsxtxcRPrENTN0VUJUp54V+DX58EM3amBBT80JgImNJ24fDFF8er9et7fzWJHIQ1xuW3EypWNVRkV7XTY=;24:MSb0KIjBPD37KDaTF5FQhogBcl1HSDosfPYClfW40huVp8EUM7fEDxcACmj/4awvjQvzm4jbKDQADMJ9tV3tROCDQEkWiNgD+uwUZZeskhs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;7:1Knj2Jdo62xbAFQvzf0+5XeR/Varwi+8PZfDQfUQz4mKwHMpBblOA26TcPfTJEKfDzSc6+wzx4NP7fkynuHRy01tRnL/Xxq39Mls+EfIIUEjlq/UGTN8ad/CZr2Y3gvM5PPx9vbqAYH/82L8k7WOcc7Vju7oxZkGUJoWPb+0j+09rQkfbliBxMe/PGFZz4klWeZma9NcHF2bOkfOF/XbFnJmBKyRKUFwxD9sedLEMM0Ms/QIMa3zuS/fpkSv9Pwu;20:3poFVSNDpJMkZXHUTdmmqw3KAe9cVQHQaVXj1tpRWLA8kxYCGKL6MIYyazoGrV4miXydfeTw9+PgD4TM3VeGm9lOXUB8sVhJ1Dl1XwGq/3mVlBVrtbUCOg4BLE0pof+xWB/V4F94+hw0g3K4AwxlAw3hOsbNh+zz/WgRj/9JdQQ=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 14:45:00.5665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d4aa82-95be-43da-8da5-08d590cca824
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the mem_pool type and wrap the existing mp_block in this new
type. The new mem_pool type will allow for the memory pool logic to be
reused outside of fast-import. This type will be moved into its own file
in a future commit.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 19 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6c3215d7c3..1262d9e6be 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -216,6 +216,19 @@ struct mp_block {
 	uintmax_t space[FLEX_ARRAY]; /* more */
 };
 
+struct mem_pool {
+	struct mp_block *mp_block;
+
+	/*
+	 * The amount of available memory to grow the pool by.
+	 * This size does not include the overhead for the mp_block.
+	 */
+	size_t block_alloc;
+
+	/* The total amount of memory allocated by the pool. */
+	size_t pool_alloc;
+};
+
 struct atom_str {
 	struct atom_str *next_atom;
 	unsigned short str_len;
@@ -304,9 +317,7 @@ static int global_argc;
 static const char **global_argv;
 
 /* Memory pools */
-static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mp_block);
-static size_t total_allocd;
-static struct mp_block *mp_block_head;
+static struct mem_pool fi_mem_pool =  {0, 2*1024*1024 - sizeof(struct mp_block), 0 };
 
 /* Atom management */
 static unsigned int atom_table_sz = 4451;
@@ -324,6 +335,7 @@ static off_t pack_size;
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
+static size_t total_allocd = 0;
 static struct object_entry *object_table[1 << 16];
 static struct mark_set *marks;
 static const char *export_marks_file;
@@ -634,6 +646,60 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
 
+static struct mp_block *pool_alloc_block()
+{
+	struct mp_block *p;
+
+	fi_mem_pool.pool_alloc += sizeof(struct mp_block) + fi_mem_pool.block_alloc;
+	p = xmalloc(st_add(sizeof(struct mp_block), fi_mem_pool.block_alloc));
+	p->next_block = fi_mem_pool.mp_block;
+	p->next_free = (char *)p->space;
+	p->end = p->next_free + fi_mem_pool.block_alloc;
+	fi_mem_pool.mp_block = p;
+
+	return p;
+}
+
+/*
+ * Allocates a block of memory with a specific size and
+ * appends it to the memory pool's list of blocks.
+ *
+ * This function is used to allocate blocks with sizes
+ * different than the default "block_alloc" size for the mem_pool.
+ *
+ * There are two use cases:
+ *  1) The initial block allocation for a memory pool.
+ *
+ *  2) large" blocks of a specific size, where the entire memory block
+ *     is going to be used. This means the block will not have any
+ *     available memory for future allocations. The block is placed at
+ *     the end of the list so that it will be the last block searched
+ *     for available space.
+ */
+static struct mp_block *pool_alloc_block_with_size(size_t block_alloc)
+{
+	struct mp_block *p, *block;
+
+	fi_mem_pool.pool_alloc += sizeof(struct mp_block) + block_alloc;
+	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
+
+	block = fi_mem_pool.mp_block;
+	if (block) {
+		while (block->next_block)
+			block = block->next_block;
+
+		block->next_block = p;
+	} else {
+		fi_mem_pool.mp_block = p;
+	}
+
+	p->next_block = NULL;
+	p->next_free = (char *)p->space;
+	p->end = p->next_free + block_alloc;
+
+	return p;
+}
+
 static void *pool_alloc(size_t len)
 {
 	struct mp_block *p;
@@ -643,21 +709,25 @@ static void *pool_alloc(size_t len)
 	if (len & (sizeof(uintmax_t) - 1))
 		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 
-	for (p = mp_block_head; p; p = p->next_block)
-		if ((p->end - p->next_free >= len))
-			break;
+	p = fi_mem_pool.mp_block;
+
+	/*
+	 * In performance profiling, there was a minor perf benefit to
+	 * check for available memory in the head block via the if
+	 * statement, and only going through the loop when needed.
+	 */
+	if (p &&
+	   (p->end - p->next_free < len)) {
+		for (p = p->next_block; p; p = p->next_block)
+			if (p->end - p->next_free >= len)
+				break;
+	}
 
 	if (!p) {
-		if (len >= (mem_pool_alloc/2)) {
-			total_allocd += len;
-			return xmalloc(len);
-		}
-		total_allocd += sizeof(struct mp_block) + mem_pool_alloc;
-		p = xmalloc(st_add(sizeof(struct mp_block), mem_pool_alloc));
-		p->next_block = mp_block_head;
-		p->next_free = (char *) p->space;
-		p->end = p->next_free + mem_pool_alloc;
-		mp_block_head = p;
+		if (len >= (fi_mem_pool.block_alloc / 2))
+			p = pool_alloc_block_with_size(len);
+		else
+			p = pool_alloc_block();
 	}
 
 	r = p->next_free;
@@ -667,7 +737,7 @@ static void *pool_alloc(size_t len)
 
 static void *pool_calloc(size_t count, size_t size)
 {
-	size_t len = count * size;
+	size_t len = st_mult(count, size);
 	void *r = pool_alloc(len);
 	memset(r, 0, len);
 	return r;
@@ -3541,8 +3611,8 @@ int cmd_main(int argc, const char **argv)
 		fprintf(stderr, "Total branches:  %10lu (%10lu loads     )\n", branch_count, branch_load_count);
 		fprintf(stderr, "      marks:     %10" PRIuMAX " (%10" PRIuMAX " unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
 		fprintf(stderr, "      atoms:     %10u\n", atom_cnt);
-		fprintf(stderr, "Memory total:    %10" PRIuMAX " KiB\n", (total_allocd + alloc_count*sizeof(struct object_entry))/1024);
-		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)(total_allocd/1024));
+		fprintf(stderr, "Memory total:    %10" PRIuMAX " KiB\n", (total_allocd + fi_mem_pool.pool_alloc + alloc_count*sizeof(struct object_entry))/1024);
+		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)((total_allocd + fi_mem_pool.pool_alloc) /1024));
 		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
 		pack_report();
-- 
2.14.3

