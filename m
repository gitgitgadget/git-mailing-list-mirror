Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5211F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeCZREe (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:04:34 -0400
Received: from mail-by2nam03on0104.outbound.protection.outlook.com ([104.47.42.104]:63106
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752739AbeCZREa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=z3Jj50FpwhSNL1HNs4G8X2DjxL+lbjuUclFiGm0lf1o=;
 b=QMQQWBYg3KBQdkCdxL4yEUG57XUaByXj0tg0Az3JicwgqjbtZRx88ochH92wOfo2MqQKo9Fxv8QJKVa/9TY1RkPOz1lO9R4OL0ovAGlqhePSKy7cwOLJcZl3e0bsdbf3wNsNA/+vAWAVQEPqlRhEqlQgManN+0yehObUsfemKxo=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 MW2PR2101MB1115.namprd21.prod.outlook.com (2603:10b6:302:a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.653.0; Mon, 26 Mar
 2018 17:04:28 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 2/3] fast-import: introduce mem_pool type
Date:   Mon, 26 Mar 2018 13:03:50 -0400
Message-Id: <20180326170351.197793-3-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1:1060:bd2c:4297:50e]
X-ClientProxiedBy: SN4PR0401CA0030.namprd04.prod.outlook.com
 (2603:10b6:803:2a::16) To MW2PR2101MB1115.namprd21.prod.outlook.com
 (2603:10b6:302:a::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ffa0bcd-eb0d-4557-3e47-08d5933ba2ee
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1115;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;3:BoY5kCjMZddsa/aVKfSIYeEHj64VRgjs/BCcaZtEHAA9eeveEXIyFOgQHsFbXrsZZ1sbnvT5TLaAsrF9Ocfl2enRVkaxkNcCqGIXfpDXvOZ39ta5TzsTqx2MuUuKckrmEXcCtb1ckXx9YDysRmc2WW3qJ4o8iSM/RqTPUVt6NlcPeyuUNnm+XuZT/nk2Eug0SdxuvvEEItVVqCJJeCt9Lz6IPaycMku78VHOqi3/wX8kJsORObNBbO6AAcsfvnqU;25:eUxkeAOUvfh+0kFzvKgyrjhZR+LmmhqXeBAJ4O+0NtbT8NLb2HVlfQ9nYr6ynZq/h1daep9bKQtPtlJH8ZqFm9D/o+vCxrIcP8cDySHu8GnRX1+tHMa3vE7wo3/LgEPYO26JJDdXxJcXR5X8i6f4xjkqeF2vkeZgNR6tLPw8+Le+Iqkbg/V4qbrUeFWHL6epLmdQn56RBlKXWt4TO2Y3Vr/HNn0bYQ61Vt1hWjNVT0pFNHpI81Dc7369VL2miKRHnVUKcwOG36b0gC7h7jZjqKWSAqLZkztMxnCvlg3XKHiLi8hnsKdEclf7MWAPo/DichtXc0RF2RrFqyEDBWsIuw==;31:dQR/qxPeN5yl9LRWNGTse2lQ6VP4Rph1nyE/fffidg8PJB00lNIzKY3HXRKh4TO2n0MU7D3QijmKdMkIzqfx8I+6wLRUtwFXa2tON7hoiyB+NjYP26XvyfMXSVSE1WBkDqhrKxEpN/bGuNQRGUTwnqe82QyWRcb/rK+g0WxcJ2+Yo1Jnd6h6OHyX0Qdl275K0ZAENiL4F8PVWdKpR49/9ZFzlLhgHN4gvDOajAikbqo=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1115:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;20:4ZW2k1N46W73FLeh2Vd62mPTPkwlM0UKIyOzu0QJXz/293We4WJ3BGQDC1tR3dAM3mKuasuPIg535asaOje7YKE3v8/u3kZvKCYbaiNR7eOMtIlq9hk0BswbwU/cV4i4Ocfm+8HIsJC3xm7GffsjfGaDXR1fqlK/v3Gbe+tatxMH6kh8xK6h/0yFrGJjHCXZOtw2q3hHXPseXfO3nx6hYcxoIqOywKVbUs6lEmcbn7JpYhDKBipuhjQYAyHxpZDauCAKSWJO9awHRhArCnFaCKig4u/MVhJXhQ0zXApqQhzu4GHhWuFymlxXg73qo5RgldfOm3GBYNnRzI0eEidnHmqj8DH8Am1iGUO/K7+1Ok8JUV8MqIs4HGQ7LOQo33yPSACRTnxP1sT06VmOEqoSfUK5LExUFbXlTZMyeE5yVaYv2W+x5KvqRZoWeOHfkShqbD2wn67sGMNpGW2zRPUwQesLjj109r/sn+kVkG+0M6h30JKzh2kM4rFBTYTRiDmn;4:V1PDHFNGKZ6SjNbsHRXTsnQrYpoYdf48irP5JEgHAYmBi5t3NWMFDULOKKkKY/3qC5DRFXU0moV1MJou42rqjQ4+/2F4OXGa4ocGPiFu0/fWp+Qb/3zqVQTv79zYGXWoqRZSwsHgCZzqLGDiSs0JN9z1T34mHhOiv8kfeqiJBlV5i1KplNi7grEFxHjDqLqH/zBWjvM7ciT3D0XOWI7Bml0Pf+UlImTlwL86ot9Dm5gGZ3XZ3XSI4GBw8T2l1FiFJOhhaFw/spZ7J2MTcE0cHeqc1rMk5rZdbjFNHeD9J6c0DGHGauVUcwIh98Ep4cd8FY2rpekfU9jI6e9aTy+vXSZKHzKiQR0Wf+PqimoUDMI=
X-Microsoft-Antispam-PRVS: <MW2PR2101MB11154F618BCBA4308AD4C6D8CEAD0@MW2PR2101MB1115.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(316002)(81166006)(52116002)(4326008)(8936002)(50226002)(1076002)(52396003)(6116002)(48376002)(51416003)(7696005)(81156014)(386003)(16586007)(2616005)(446003)(11346002)(8676002)(22452003)(36756003)(6666003)(486005)(486005)(2361001)(25786009)(6916009)(5660300001)(2351001)(106356001)(8656006)(6346003)(68736007)(76176011)(86362001)(53936002)(107886003)(10290500003)(105586002)(186003)(6486002)(16526019)(478600001)(46003)(97736004)(2906002)(10090500001)(305945005)(86612001)(47776003)(76506005)(50466002)(7736002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1115;23:8IDZBApiqGTonHvOlU09baxjz3qRPybLctkgazw?=
 =?us-ascii?Q?6tyJ+4JL91mR8rH4pAZDIsUmw5tZY+6mmoGB2u2NmJM0DTjzfW32ywM/cOrs?=
 =?us-ascii?Q?5h3RTEhra2gQ6/GFIVesTFSx8DP2mtf1E9zce8WkHrT/lUVYatg7vDoEhsYr?=
 =?us-ascii?Q?AdHnbDyE8HT8LrywlxRhtP0bdtTtpgoLXAf52NBBz/9QsZj6tEtnUuQOl4je?=
 =?us-ascii?Q?IGRjdbPK6sqFfsuXoouIkpK1xZm55/0sccGCPFVBluFw84UwkWx8f5bnczA3?=
 =?us-ascii?Q?xarTK7+EQAREqFGuArQIsn9uyxqKTlhov6jvBK+v7KCuI98t+oFRpr4UOLSa?=
 =?us-ascii?Q?vOw1ePzVD0yVFfmyR5pVVnNur2QkklIj5pou4Xua4Ey7nR4VhlVR5yfxycVJ?=
 =?us-ascii?Q?kao5N/33WlEL1rqdgc6o+APPoCMbDQohd+lHJ3QaBBl6uCoFKVuBXDF5VMuN?=
 =?us-ascii?Q?gWSbU/JYcsZuqaZnfZhpsZsWzOv2Dv02PheGRhhLymoPSWNdwEHXoW1Fcqk1?=
 =?us-ascii?Q?wUE29np25XlHyNKZdC4h2NWSaai0a7aJi/EcmH5REMuKOZzi3If8YTGqH3LY?=
 =?us-ascii?Q?uQQTvxsrGrjRky6odfVAPbWb7mdfYbTsJxhxlkIei74LeP4UKMx40XjpbxsQ?=
 =?us-ascii?Q?5tY8Y4lJMPj1vlDuTjfJlwweD8I8X7dwkAazO9GNo7e4CQ6JuDCpAdFDINas?=
 =?us-ascii?Q?zwciDmf+e/Nz3FI5Y5Eim8u4g7H+b59HcQV6u1UZE2VNLxSwtn8mUp/2+XmU?=
 =?us-ascii?Q?NXzeMP418RW08SFJuO0s0/SoEYqOaKs6xk1RWi6HWrMxoxbjua0WR/zKZdPe?=
 =?us-ascii?Q?e7nyUA55wkNsXlUpslnqK9M7BlSzoyzFNvA3T3kLsdbdFW3IW+jam5W4PLO4?=
 =?us-ascii?Q?VRFRZVXnQ2n2yQ0oZIwO1sAcEgH5c0eB/F5jXJnUSPjrS7CrmomT9/FKJlgj?=
 =?us-ascii?Q?OUu2uKN2RgEW1WcOio4A1v+aLP0KUN6zyzjkHH1lO39FIYVWCyfMUgm5sSt5?=
 =?us-ascii?Q?gxmGKFp3cRi6RAcxm1N3IowuYQKqURMqDCFAyUTWCkPo1rgsGTQWonz8n8/K?=
 =?us-ascii?Q?XofkU4uwKcYhleWiaAb3tjdGzcdkmC546UdMciHLAViwlStNPDnAR+U2VIl6?=
 =?us-ascii?Q?g3Jv8w2atp9LbBZt3MFjE2CvAqOskyewOzkhPZWZw+nffg5kL1lO9lNRB++F?=
 =?us-ascii?Q?2yssQv/vuXEw7fN30F+1ScdHPwL9n/0U2Er4VgG+zZbTeXIkpYpFn08O0e8Z?=
 =?us-ascii?Q?DX5mF+kF1F8xkHSGTZNjNrTVCGUFJfI3tDPaDm5lHBlCJay3aX+r7tTR3ey9?=
 =?us-ascii?Q?mz9YSTD8TEJaeOnRe8FV6h4DtqSVfeTA4VSrztFsRjLNS5k1ErM2TUdArFxS?=
 =?us-ascii?Q?p62CgSflYLdbAnSHFsglVbQktRmHYV9cdNbs8+wE44em8o27p?=
X-Microsoft-Antispam-Message-Info: OJuJYMoqREDbQu8X1bmAuGg3vbYwEkKYzRnPPuQsxeM8bvlVh2p59q/BgcsiLdcIhN4ksg6xcryD3hUwXERVZVKk1Xau0jzOcpKi/6XYWWRujsHYEzUwyCRKRC8/QjFWxotR4tb2JYqCpgwF89mr0PhPTdFw6mcFQyPpxZ9CiRCut+wZ9hxG0FHQ0RDrDeOG
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;6:XV0I2ChFEmBq1nnmRa5FF/ga9x99gbkNXglx3BHxlA0IuCUQBJOia8UUJPCKUD5ikrd/8t1fKkeScR/5HL41lhAwuvhrCn0QCPUFbjNiHeNWDolWtx9LrTWROWMRDdHmrNmT3kKJamlK8956J0TqnI9VgTHHxiQ4KnOC4NosLkHBsOPwBRHgkr3Pxb9dX5Ic+FHAWwjnilRZAwAJsI6lo/iYinXY0I3D9XEUxu/tHUIiiCnjxfc5gfG9MuHxR0B8lJVntbrJVktIgik0bR7U2opJpFyysbUKhz4F1h35S8QDSd8nCe/uSF0WswBUJOuFJSV4XwBQ+WkaLZe+HizXKcKx5Su7234AoPasEFAo9P8VjQcwdG2BTakWl/XV7+NIXXC+EtwVdtUvBc66jK8xx0cwH2jInY9+YZ7iIUzQLXoTlqGPxcEopcUJXXpWQ3NkNKNSSk2Bmq4Ch8FVgmXZEw==;5:nJIKvAukHgQbrGsiCqTGAuLsV+mBImbW+a+xHGcpZlY/LFjD0Dv6V34USrrke+X98C1j7xAX5FH8cYNjjGXrRZvjbDf/PV4Uw94RPh+reenVi9xIb4EQHCBCX3S8xBQKS7mHu5sh5rpM8L8lngQufGvO1UVma2zfY15OVHSxHyE=;24:Ee0R9d8EwBj9C2yrgkFrMBNc9PFTPtfDJ54EAmG4DFS3aia1ifv5dO/4u7xT9IENSZD8OpAWXz6AnGe6IGW2YRaMq5eTJRFBgkLFx2za16g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;7:3nf9brLVdApElBNzJ0S74Fn7HCEbD0eumwZVb0kiAoZ252hYlw6xmLb1xA33V4kF1KFtfdcGvEomQ1ZZgbMYwEKnUUrqeCAl9Cnzt14m9B9uh0wUKyrBkGnYYB4x+lQk2Mv//enAwUKI7FfmHDqr/LZGxTGyxsTZGwFG/MXgmiP+y0kemVnA5IOWYDydB1YZwDIwsS98EfHRAfpIrHeGJ4dbJCoZefZRHLrQUOGv1NyRbl4kryEIgzLjozbbBTrZ;20:qPhLI1sbcNuNSV+2MDPzJjhFd4QIZfPq4pRmgTDynhEur2MeSrRZGfk2Hwv5V+ln1mB1Htmabss0eAM+dCc2ieo2U9V5YjCC585hnuLpI4MCaT0QopOFGDt0DMGqm2nGjNW8J6uu+9G6jcFmGpEW4WnCgkrpFIHpOqZdxakQnUI=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:04:28.2604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffa0bcd-eb0d-4557-3e47-08d5933ba2ee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the mem_pool type which encapsulates all the information
necessary to manage a pool of memory.This change moves the existing
variables in fast-import used to support the global memory pool to use
this structure.

These changes allow for the multiple instances of a memory pool to
exist and be reused outside of fast-import. In a future commit the
mem_pool type will be moved to its own file.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c | 80 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6c3215d7c3..e85512191c 100644
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
+static size_t total_allocd;
 static struct object_entry *object_table[1 << 16];
 static struct mark_set *marks;
 static const char *export_marks_file;
@@ -634,7 +646,21 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
 
-static void *pool_alloc(size_t len)
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t block_alloc)
+{
+	struct mp_block *p;
+
+	mem_pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
+	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
+	p->next_block = mem_pool->mp_block;
+	p->next_free = (char *)p->space;
+	p->end = p->next_free + block_alloc;
+	mem_pool->mp_block = p;
+
+	return p;
+}
+
+static void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct mp_block *p;
 	void *r;
@@ -643,21 +669,17 @@ static void *pool_alloc(size_t len)
 	if (len & (sizeof(uintmax_t) - 1))
 		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 
-	for (p = mp_block_head; p; p = p->next_block)
-		if ((p->end - p->next_free >= len))
-			break;
+	for (p = mem_pool->mp_block; p; p = p->next_block)
+		if (p->end - p->next_free >= len)
+	       		break;
 
 	if (!p) {
-		if (len >= (mem_pool_alloc/2)) {
-			total_allocd += len;
+		if (len >= (mem_pool->block_alloc / 2)) {
+			mem_pool->pool_alloc += len;
 			return xmalloc(len);
 		}
-		total_allocd += sizeof(struct mp_block) + mem_pool_alloc;
-		p = xmalloc(st_add(sizeof(struct mp_block), mem_pool_alloc));
-		p->next_block = mp_block_head;
-		p->next_free = (char *) p->space;
-		p->end = p->next_free + mem_pool_alloc;
-		mp_block_head = p;
+
+		p = mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
 	}
 
 	r = p->next_free;
@@ -665,10 +687,10 @@ static void *pool_alloc(size_t len)
 	return r;
 }
 
-static void *pool_calloc(size_t count, size_t size)
+static void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
 {
-	size_t len = count * size;
-	void *r = pool_alloc(len);
+	size_t len = st_mult(count, size);
+	void *r = mem_pool_alloc(mem_pool, len);
 	memset(r, 0, len);
 	return r;
 }
@@ -676,7 +698,7 @@ static void *pool_calloc(size_t count, size_t size)
 static char *pool_strdup(const char *s)
 {
 	size_t len = strlen(s) + 1;
-	char *r = pool_alloc(len);
+	char *r = mem_pool_alloc(&fi_mem_pool, len);
 	memcpy(r, s, len);
 	return r;
 }
@@ -685,7 +707,7 @@ static void insert_mark(uintmax_t idnum, struct object_entry *oe)
 {
 	struct mark_set *s = marks;
 	while ((idnum >> s->shift) >= 1024) {
-		s = pool_calloc(1, sizeof(struct mark_set));
+		s = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
 		s->shift = marks->shift + 10;
 		s->data.sets[0] = marks;
 		marks = s;
@@ -694,7 +716,7 @@ static void insert_mark(uintmax_t idnum, struct object_entry *oe)
 		uintmax_t i = idnum >> s->shift;
 		idnum -= i << s->shift;
 		if (!s->data.sets[i]) {
-			s->data.sets[i] = pool_calloc(1, sizeof(struct mark_set));
+			s->data.sets[i] = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
 			s->data.sets[i]->shift = s->shift - 10;
 		}
 		s = s->data.sets[i];
@@ -732,7 +754,7 @@ static struct atom_str *to_atom(const char *s, unsigned short len)
 		if (c->str_len == len && !strncmp(s, c->str_dat, len))
 			return c;
 
-	c = pool_alloc(sizeof(struct atom_str) + len + 1);
+	c = mem_pool_alloc(&fi_mem_pool, sizeof(struct atom_str) + len + 1);
 	c->str_len = len;
 	memcpy(c->str_dat, s, len);
 	c->str_dat[len] = 0;
@@ -763,7 +785,7 @@ static struct branch *new_branch(const char *name)
 	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
 		die("Branch name doesn't conform to GIT standards: %s", name);
 
-	b = pool_calloc(1, sizeof(struct branch));
+	b = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
 	b->name = pool_strdup(name);
 	b->table_next_branch = branch_table[hc];
 	b->branch_tree.versions[0].mode = S_IFDIR;
@@ -799,7 +821,7 @@ static struct tree_content *new_tree_content(unsigned int cnt)
 			avail_tree_table[hc] = f->next_avail;
 	} else {
 		cnt = cnt & 7 ? ((cnt / 8) + 1) * 8 : cnt;
-		f = pool_alloc(sizeof(*t) + sizeof(t->entries[0]) * cnt);
+		f = mem_pool_alloc(&fi_mem_pool, sizeof(*t) + sizeof(t->entries[0]) * cnt);
 		f->entry_capacity = cnt;
 	}
 
@@ -2862,7 +2884,7 @@ static void parse_new_tag(const char *arg)
 	enum object_type type;
 	const char *v;
 
-	t = pool_alloc(sizeof(struct tag));
+	t = mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
 	memset(t, 0, sizeof(struct tag));
 	t->name = pool_strdup(arg);
 	if (last_tag)
@@ -3461,12 +3483,12 @@ int cmd_main(int argc, const char **argv)
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
@@ -3541,8 +3563,8 @@ int cmd_main(int argc, const char **argv)
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

