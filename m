Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CEE71F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeCWOpH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:45:07 -0400
Received: from mail-bn3nam01on0117.outbound.protection.outlook.com ([104.47.33.117]:25505
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751670AbeCWOpE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3zGR32t90apoIBCs8D8ubkJWKO56baY4J63sdEVGLS0=;
 b=B4j/YT37xZTUaSgCyKBwDkUfQ0fadHXm1jPtqQ/t4zxqhFvJ9jPE5NHYsVNKzKkmKh5QBsOoWmaF3isZkYNQkTDbIPhPEwYaNKdG5r3LRV7mnZm7lrXTbnwytHcsRQROWV2BbiMBFc6jHjedQLcvq3ANIbQ+6JMZHnNV3kmlae8=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 BL0PR2101MB1105.namprd21.prod.outlook.com (2603:10b6:207:37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.631.2; Fri, 23 Mar
 2018 14:45:01 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 3/5] fast-import: update pool_* functions to work on local pool
Date:   Fri, 23 Mar 2018 10:44:06 -0400
Message-Id: <20180323144408.213145-4-jamill@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba00c542-f221-4f22-b8c9-08d590cca8bb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1105;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;3:fFuBdrsW3gd0uaidNQyIGyVxWnxleEaFtrNuGkelbH4vsDbjPJSwNFn3PCC5KlOBnSKjQjj8XoaHWf7fl8mdy/9QyPk/UiTx1Dix/P28ik3fhZqsA9msi/wYvsxGH1mwjYCENuKXnAw/dqaGq4b/P/6ryiqbw26WSZ7li/qgOhPeY+ZMLUyLqFQAlIbHsh5ngS92jqD3FExXdyLMFGWgtRbsAYNscbtYmwvqd3felwwqg9hb6O2MDq5IhZswVy05;25:/EV3jZKPnIodzlwib4TgcbSdVUjciOlhuDp5gclaE8yAiduIMlDXf+D2EzWlKPJwtYKL4xurH5iUKwzF60Fnw0BYP+th//9l5LmPGcLJRaKFXkTpUphI4EAE4h62iVs1N3+dYo3R93M8T2lShPkpPX+e4Xq5e/bkTIjW8WhXCxq5aRzH02gLGXrv27plrIw0dx6cqcOOgx7mHPAPkPQZ2xXjBvC7bVVvvMotE29eNTiXzjUJs+0pqYrW7BuzH+Nbe9scO33toiqTNW2+8Pj8Q3TeuiAJ+jWsOcU3dAefuubGaUEQ74T+noHO1gXDA9LX820g7G8PP2B3Co/QvsHj9Q==;31:9qAlPltaCMQY1D8HxmF597m+s2NicwJ+/1ZYyHNbOtpBtdqMwyPO0AqkPGElEOYA38l2tCPHG14nE5c5E6LLPZxvY10if9LLU7VOs9dBDGwMFLN5/35OnhGD+e7/gyERgYsZPzQyUIc0GsCqyR0YMpAYCCYgaWMCipp37UUtS4fnMwEjsrZDv+vqx/DSxyJEMmm9u1gOMpiXN/vp0f/+3VVFVuYzD0g5RfA8EHsHhHE=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1105:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;20:inKbw51MJpUt/eXMi0TkW8jOvDWWlWWC+y35p5N4YQz5rpuOU1JvUu4FHzmwR0bhkWIwQjmqIUvYQa9JweMtCQLWM5AsFYophNsxju5Y9VMUHagkoH7hbqkLK4CP99nTp9yGr9tMDzlHXCw35E9DMSc+OXvRDltKYWcxoCJjuZ8O56oqHpCvMizRX+vGVRr6waMy2HWR5Xr+ZCJ2R3FlpIZLOL6UDttgUyCnUKl+RqXMoaWz9FGoLQrRajPayObw9mYilUjpR1nlsUeHgvbYFQk50vx+NDJLziWE70sZ3llq4ZvSt3LG5pjsHdVjz3a+XXN0FIgAFa5u0iXbW1XiHVqnuvZ6yj12N83vkNYa7hoS9graucJYeuDDiu/8ZZOrY8H1NXD4UJjPPg0EDY6/a5FpkIb6nYRuOcmAser6VYHZ4x69dfBMJiKCrNe8nJHokxjV9pf4tkKYq1Dhf++9Z9tt5JzvKvfzq7DfG19NRJ71VIIQfpNcmpCLHGdVG3oy;4:H6ZsFqysgAaa5wzLurWgOHVK41Bv9feQPEcSNke5MLnatZ+9lxVq8DlQquCtSpHpEm1+mFRUxpQhJnFd8zpsMow/TsfnY+AGfnj7n0AqPhViAxLhZL9yciBpjDFdSMaxWM7zlu+UxlMr2U+DqHH7pRlxcybcrTdSPgOtGwarYD1OlScyb58G6mRISLGBzpOhm5LyTWriEwxcUkZCf9od8jHPc4eXEGy9WjszmLJ7b+hudr4rj1ByBh7Wm+eRZA/ZWbwXD2reStylT1aKmiRpbtNtqAfs4GdHDohl+8xbZBowKueygBZxG8Jp6NS1P+Zzr13AxC0gp1Ojp5PK21bTN/bSCPLLrhPPqH6gnbExzMc=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1105471FF470D667CFE2F499CEA80@BL0PR2101MB1105.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(305945005)(446003)(46003)(11346002)(36756003)(6916009)(4326008)(5660300001)(2906002)(186003)(68736007)(10290500003)(25786009)(7736002)(107886003)(16526019)(86362001)(2351001)(8936002)(8656006)(22452003)(76506005)(478600001)(50226002)(47776003)(52116002)(6346003)(316002)(52396003)(97736004)(48376002)(86612001)(8676002)(81156014)(81166006)(51416003)(7696005)(1076002)(15650500001)(105586002)(106356001)(76176011)(16586007)(386003)(50466002)(2361001)(53936002)(10090500001)(6486002)(6116002)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1105;23:KQrwuFEkxO4PT6jRAdI7JHo0PLNVUyKDQwb/imd?=
 =?us-ascii?Q?5UqOfACIjzDKL9nyjOY2SkzEXA/KSzvQRGGKu9hYAADQKmgg0cWLWjVB2CiE?=
 =?us-ascii?Q?WLK+xaOjzK7M6cG1LCLFzpg4Q0DVdArdaicsTaWc0kFffsNWS4COsF9f7AKx?=
 =?us-ascii?Q?PNK4vCwzNFkl2wZBR8CZQ60WiJyGYCDhoxY9PKMgCi+hRo75GFibsldhyRSz?=
 =?us-ascii?Q?KQAVC75BdhzDkSyElj2858nJvPuJsujAZUpkwi6z5UJ6P6AE6T6sZAj1JcMQ?=
 =?us-ascii?Q?VWQaKO4IEGKMTf5IQ9EdgPD1+dv9XZpU45QhJX1W4yIrMJuvtPOCKSZ3GqnT?=
 =?us-ascii?Q?XXAhtR0l0LVfZEr7/LKU5kZTTEj7rBiRnAXXFO9L8sC4c3axGaa1Kg7ciE9b?=
 =?us-ascii?Q?Sok1/EV8XCUoRaRBqplqOxyu4uWnQAqEjxWZInxx5RHjzWbA5AVW7jlSkOS+?=
 =?us-ascii?Q?Lje6cs8pHZFXA1lnb4bpSusngf5dx8+Hp2aosJn7UjAIA30EkcynGp6BOWVO?=
 =?us-ascii?Q?kmxHH29bb25Yk5ARpwVyt6OWj142jPJcxaJdHapZw3UasR+10cCXdaqMRA5Y?=
 =?us-ascii?Q?1QEmBelOJ58IkyCk4U27K+yAIbOWutcUuJfNQDkC1P6cdJ4bQ6nbbMHw2pP0?=
 =?us-ascii?Q?5uoRusj+rgmG2VUyEe21STN6O3aVb2Ve/KZTzzJrg6H0dUY8higNCUW8aLZB?=
 =?us-ascii?Q?oTbsgm3Jf/lkXjasV27AFQHHRkE+xaMMJ1fEyYL7distRX2avuCk2ciI83tz?=
 =?us-ascii?Q?E/6L8Jy1QH4w3WtIWKo1FOlNOKi+K9+t8wqpNxLT93mnmxCsxWlK27ErZTR/?=
 =?us-ascii?Q?Qzj77EB7R/iqN18aao5OKMYViS5ShlzWWnYdRcIG5iusbspajJKUS87BlF5h?=
 =?us-ascii?Q?rgNykHreynrmsn8uuHdBdyM8PSAWGgBECik5PNT0l27DIVYQyAMozF7ajR54?=
 =?us-ascii?Q?fmVunETm/t/Pe2eqWmYaBDn1xRUHiyehZbarYOXKFFmwnWZTci4qT+fQIcQi?=
 =?us-ascii?Q?G/tpAYtmsT+HGVjMXMDH6GpIHVwpOVx0BZwkGqbULt+qNVe4C8xYwuMf8kDE?=
 =?us-ascii?Q?oGBT4een2YGyXSKolZqaV3te4Im0iHrsGPBoqzNFn7giNZPlg1ehBKgTJJrm?=
 =?us-ascii?Q?pNK8iVxkT5MuUGo2HcWmxzzl1NKAAhK65pJZAIMwuqF4ZveeI/tUJMooV+a3?=
 =?us-ascii?Q?Tw8fy+1RTtcmuJEa5rzQFsDG8i/5el7QiyHY0gYaVOtfzp9FhO0cfzq6wZBi?=
 =?us-ascii?Q?6Wpk5yn6W2eIxO/klyhlPpV6uTcc2M0gAXMktuok6/AcHSM0wYPl/V/Wy7Xz?=
 =?us-ascii?Q?WJj1R9LMsujlAOfjDfiCwDEb0iYezJyBh5trKxixl9oD1AWZhhaSeBAXihWm?=
 =?us-ascii?Q?sV5VwKA=3D=3D?=
X-Microsoft-Antispam-Message-Info: NU2Cdd0cJR8vVESMr5VEDWVa05GeD/oBCyhjusfar7jYZbExabr+ZNPJ6eDd3CCZokfo6rsHmWmFwgQUAryiqaq8SQNJlvDLj1hQTLzjzw0RNtkWxZQm72XAOupLTL9RhhWJTJRrh+d/GsLmWFJhmkwJFsRaStcI61mN49KR2xdGvdG8nkzDfT+maNta5cdR
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;6:QzxDT7akg7AGIVN26F9gqUa6IUap2tqGDlw4i19nRBXZdJxKTbQZ6YmFovKihNNtzHI/dVunDfG9JA3wAn0z/xq71QP4ah6H/70Tae6ASeRbSwDj6CfkC/vwvRb/IkRYf14RtKHt6p5yEYFkP4FGiG6tQHM2ZFSt3Na7+Vct2Ntap7Mito0JUIlCB6NKHCvkUi5m2bzgHIeOSZ1s1ahvzbDNdJgeJjP9K/D/g4hcTtSnFJN+hILjly1AL2BlXBBuFn2u+7njWN0AQpdVYaH0rtHcskNqh/6epJgXzzcGMrTGaHcLDxCWr8WHcx6Lgt/uWrYHs3ofCoadB3mkXKXL8hMz2wceZFufW2qGIP/Sp0mUiy0Yy82MUTzDP9dewwRHnVlylbKKaZ162+ribTcrRCjvYTG1oGYUH+7Wo3DBHf6hS/N/zasMfB36NyNIYs0qvevElQRe9PFZWdEuPX9LCA==;5:kx9vPsvTiTkgvXYXZ8GnBmMTpSbQeCyxrAMc6b+kJ/sxqJ/h/CcKX2Si/tJGnCVtSe0oH73eExKaLfJhvYbFEEslxaCqu+bcVR450a68n+pcc2LoMoFwlyXi9djvdVXZYw9R02PxC4MkjvKt2Gw/UYqd7jR+dxtHuYRrkJffFdE=;24:JbxvopaMXmdBhD5qVBXBYSUhyu1xzhyqJ2l7xjGXOc6Xkwm1UN+63LEpK2ALYl/RiwD2iRNgDPm9FiZnA3Rnk9CHRXETSbbyb386+SnjW5c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;7:UWk6WEK3vxkfRC422DdU5zA5y851sNvnWYfDkSp6BtbJMf6+PV4Lqk5csEDx42XuaYJUi3e0bfX4gS7wKWfD1npvA3QsvtpusdtuqEHld1SFXBjNgxtM+4fXxthHpr0WELkbxXsp3ikVUZbPz+psUZPfQrjqqeL+mwdLuxnGg/UIw+79gpgxxgr49kl2RLZ187RGfsIucj9L4v/FfGMOXt2YvOqpTI1Qq/izAk8VzA/R7jc7M+YXSL0IvgFkunso;20:C0GB+7Mk/nuOUUZ7h1h0nr2CvXxKMLYERNhFi1ZQ83BneaDr8RLqRqGto+a8uRhTwXVI5FKPEWOofD6hPAQnS+G2q5QGpbcahfv+VSdpQottwD8ke0cSRluoxossIoBDeJPCXtGE/WrVYUq2O7yScXQHYcs0j1XiswsBt1NBp18=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 14:45:01.5582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba00c542-f221-4f22-b8c9-08d590cca8bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update memory pool functions to work on a passed in mem_pool instead of
the global mem_pool type. This is in preparation for making the memory
pool logic reusable.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 1262d9e6be..519e1cbd7f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -646,16 +646,16 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
 
-static struct mp_block *pool_alloc_block()
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool)
 {
 	struct mp_block *p;
 
-	fi_mem_pool.pool_alloc += sizeof(struct mp_block) + fi_mem_pool.block_alloc;
-	p = xmalloc(st_add(sizeof(struct mp_block), fi_mem_pool.block_alloc));
-	p->next_block = fi_mem_pool.mp_block;
+	mem_pool->pool_alloc += sizeof(struct mp_block) + mem_pool->block_alloc;
+	p = xmalloc(st_add(sizeof(struct mp_block), mem_pool->block_alloc));
+	p->next_block = mem_pool->mp_block;
 	p->next_free = (char *)p->space;
-	p->end = p->next_free + fi_mem_pool.block_alloc;
-	fi_mem_pool.mp_block = p;
+	p->end = p->next_free + mem_pool->block_alloc;
+	mem_pool->mp_block = p;
 
 	return p;
 }
@@ -676,21 +676,21 @@ static struct mp_block *pool_alloc_block()
  *     the end of the list so that it will be the last block searched
  *     for available space.
  */
-static struct mp_block *pool_alloc_block_with_size(size_t block_alloc)
+static struct mp_block *mem_pool_alloc_block_with_size(struct mem_pool *mem_pool, size_t block_alloc)
 {
 	struct mp_block *p, *block;
 
-	fi_mem_pool.pool_alloc += sizeof(struct mp_block) + block_alloc;
+	mem_pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
 	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
 
-	block = fi_mem_pool.mp_block;
+	block = mem_pool->mp_block;
 	if (block) {
 		while (block->next_block)
 			block = block->next_block;
 
 		block->next_block = p;
 	} else {
-		fi_mem_pool.mp_block = p;
+		mem_pool->mp_block = p;
 	}
 
 	p->next_block = NULL;
@@ -700,7 +700,7 @@ static struct mp_block *pool_alloc_block_with_size(size_t block_alloc)
 	return p;
 }
 
-static void *pool_alloc(size_t len)
+static void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct mp_block *p;
 	void *r;
@@ -709,7 +709,7 @@ static void *pool_alloc(size_t len)
 	if (len & (sizeof(uintmax_t) - 1))
 		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 
-	p = fi_mem_pool.mp_block;
+	p = mem_pool->mp_block;
 
 	/*
 	 * In performance profiling, there was a minor perf benefit to
@@ -724,10 +724,10 @@ static void *pool_alloc(size_t len)
 	}
 
 	if (!p) {
-		if (len >= (fi_mem_pool.block_alloc / 2))
-			p = pool_alloc_block_with_size(len);
+		if (len >= (mem_pool->block_alloc / 2))
+			p = mem_pool_alloc_block_with_size(mem_pool, len);
 		else
-			p = pool_alloc_block();
+			p = mem_pool_alloc_block(mem_pool);
 	}
 
 	r = p->next_free;
@@ -735,10 +735,10 @@ static void *pool_alloc(size_t len)
 	return r;
 }
 
-static void *pool_calloc(size_t count, size_t size)
+static void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
 {
 	size_t len = st_mult(count, size);
-	void *r = pool_alloc(len);
+	void *r = mem_pool_alloc(mem_pool, len);
 	memset(r, 0, len);
 	return r;
 }
@@ -746,7 +746,7 @@ static void *pool_calloc(size_t count, size_t size)
 static char *pool_strdup(const char *s)
 {
 	size_t len = strlen(s) + 1;
-	char *r = pool_alloc(len);
+	char *r = mem_pool_alloc(&fi_mem_pool, len);
 	memcpy(r, s, len);
 	return r;
 }
@@ -755,7 +755,7 @@ static void insert_mark(uintmax_t idnum, struct object_entry *oe)
 {
 	struct mark_set *s = marks;
 	while ((idnum >> s->shift) >= 1024) {
-		s = pool_calloc(1, sizeof(struct mark_set));
+		s = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
 		s->shift = marks->shift + 10;
 		s->data.sets[0] = marks;
 		marks = s;
@@ -764,7 +764,7 @@ static void insert_mark(uintmax_t idnum, struct object_entry *oe)
 		uintmax_t i = idnum >> s->shift;
 		idnum -= i << s->shift;
 		if (!s->data.sets[i]) {
-			s->data.sets[i] = pool_calloc(1, sizeof(struct mark_set));
+			s->data.sets[i] = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
 			s->data.sets[i]->shift = s->shift - 10;
 		}
 		s = s->data.sets[i];
@@ -802,7 +802,7 @@ static struct atom_str *to_atom(const char *s, unsigned short len)
 		if (c->str_len == len && !strncmp(s, c->str_dat, len))
 			return c;
 
-	c = pool_alloc(sizeof(struct atom_str) + len + 1);
+	c = mem_pool_alloc(&fi_mem_pool, sizeof(struct atom_str) + len + 1);
 	c->str_len = len;
 	memcpy(c->str_dat, s, len);
 	c->str_dat[len] = 0;
@@ -833,7 +833,7 @@ static struct branch *new_branch(const char *name)
 	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
 		die("Branch name doesn't conform to GIT standards: %s", name);
 
-	b = pool_calloc(1, sizeof(struct branch));
+	b = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
 	b->name = pool_strdup(name);
 	b->table_next_branch = branch_table[hc];
 	b->branch_tree.versions[0].mode = S_IFDIR;
@@ -869,7 +869,7 @@ static struct tree_content *new_tree_content(unsigned int cnt)
 			avail_tree_table[hc] = f->next_avail;
 	} else {
 		cnt = cnt & 7 ? ((cnt / 8) + 1) * 8 : cnt;
-		f = pool_alloc(sizeof(*t) + sizeof(t->entries[0]) * cnt);
+		f = mem_pool_alloc(&fi_mem_pool, sizeof(*t) + sizeof(t->entries[0]) * cnt);
 		f->entry_capacity = cnt;
 	}
 
@@ -2932,7 +2932,7 @@ static void parse_new_tag(const char *arg)
 	enum object_type type;
 	const char *v;
 
-	t = pool_alloc(sizeof(struct tag));
+	t = mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
 	memset(t, 0, sizeof(struct tag));
 	t->name = pool_strdup(arg);
 	if (last_tag)
@@ -3531,12 +3531,12 @@ int cmd_main(int argc, const char **argv)
 	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str*));
 	branch_table = xcalloc(branch_table_sz, sizeof(struct branch*));
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
-	marks = pool_calloc(1, sizeof(struct mark_set));
+	marks = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
 
 	global_argc = argc;
 	global_argv = argv;
 
-	rc_free = pool_alloc(cmd_save * sizeof(*rc_free));
+	rc_free = mem_pool_alloc(&fi_mem_pool, cmd_save * sizeof(*rc_free));
 	for (i = 0; i < (cmd_save - 1); i++)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
-- 
2.14.3

