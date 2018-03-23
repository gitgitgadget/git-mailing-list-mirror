Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6013D1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCWOpL (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:45:11 -0400
Received: from mail-bn3nam01on0117.outbound.protection.outlook.com ([104.47.33.117]:25505
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751812AbeCWOpH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HiGBVHhnBMtggfhs09i13Ivoi+IxU+9CdmDFC/i4v1c=;
 b=NjXEdOlMXleoNUU89/CDCOT5xX7nGBI9SC8KxDBzYKNANxD6hYJA+ISB5VIuglg166Ojx/1waznj0s/62d5bVB/nnRt1c4G1iYOZOTH7FuxVjN4NqjhQRBXT7rWdy86NHQv5jj8hYk8ZOSSiNW6JxKz29DQ7DeaMHdTS7tcQdA8=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 BL0PR2101MB1105.namprd21.prod.outlook.com (2603:10b6:207:37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.631.2; Fri, 23 Mar
 2018 14:45:03 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 5/5] Expand implementation of mem-pool type
Date:   Fri, 23 Mar 2018 10:44:08 -0400
Message-Id: <20180323144408.213145-6-jamill@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ac3bb0f-7fad-427b-1908-08d590cca9ef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1105;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;3:IMZKY6EO/qgcHw73XBpzEeZal+U1ZZYSPGvhjrsdCCffNKmf+hZPzN2y2+wkaOmjct7rJDCAKv6tbbegXmsdHym89seQoxLz6k9QS797awEH4fTdFyjFwlSGi+1XT1cNIaLbpRWD0VKffPBu8i073w1qE37xyGmsPGljD/kpUpecWOufVD8OU0N1Fog6codLZYhyZzBKdW/fqQuLVio9iYBqPVOazxZ4wkyq58jYVM3D9SA2/1qVK8mWK8J90BDL;25:IWwv9fTRcUQfQiB/bffLj7FyBNY+0zBfjm+8573FIKt2+MOPlwMSPfsjRrCiXHM2TsMvuAhfKnd829V8B1P7fNTpmGU5wXTqF09tsleBKoXqFQMgpG+M/X0C+hCD7JUCkuwzzM/K0Z0M2TFx2zZ1LPNGnCzbAuMimLUELI+7PhLA7iXdvqKJZywRdZJNGd2BQCnz+FRa7fC6hctkeJFvHpd39HBakzpad9DltkTcjrGooIG7BDuQDSPzpcLwVzlcq2jtb36tiKHL808LJxnXPKsEnAENk5zM4MIIyiP0y61InJp8N7vApxmn9/9iVRbMXUgEx4y6YYo/uRMxnAgKAg==;31:zDe2E8PWa95DZWD/zfdZJoboV/qb3YFFQ5CpLXC84PeihZumJQ5+Zf3IcY+5UBtWNYhMdeZIcMzt3PXQSSskKXH5VzOd2C7II46QhV9RkX/MxLFxmmxILYKgyWJcnJDZSAYq5CvAqokeMlKNygCDvfjjZdHDx6wTeE3IFSeMGlbIWaDIyes9D+a9SmQQ8QAsCxeUe0A09VIfOq4ju3iZ49dRxqWc0moJYLamKZmwnDI=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1105:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;20:Mujop9k8N3uE79iuxJdNeyQRlrOtByeq/U81xeShOf0ajyEae2Sc2NSbQBBVweKaKwNGNQRjtcrsATSQ8Wa30sCsTYCZxFit3tedEhtDetX2sOBJdmZU/eOZW89xL0RbiS68PzM3eBPoZq2V56TlomVcveMuOQUUl1l6fAg+2RS3OrmBNpi2+M73BjiIixhUa2y/G4k5hvBfp7x47pOAjLSb/jsTf8zkSfrPIP7XzwH1B0kq9o5i6mYYhT+Hnv+qOeFUgQKnDfngeU9ARmTKNGh/jHdOvIF8rxPMzAGqxMdzvfj4gVBbcfBJXGoG51LjHyS/CAx4BGafJT0AD8tS9hfdWzzPJuKuqYipRnAOEpshpSpPvb3uIAeoStpvX0W2I+OlR3d/Z6lHhQJhQlG0QOI95ewrxsbT1N+c1RU/c1CXSeuc0ZYZAFzomSVZJ2Ici4vZK2l4SJ+MfMavg/bGY0kJBWOgVMN3D4tQ/eGru2sR2FW4ebUF5BmLxAb1/vWz;4:c9sGyWvlB7Qgvki8cbUYx0AzxWUFqRKphjCZX2klpbAmIkzSSTGrPBQ6MPxVxLeKckuYSDErcv2I9F6dqfxRqr297uq7Jp7sOhXOnaLLVverRm0sT2/AbrDIus0vHNCzAof2wcpU65K7mircguhFslfEus4kAh83TjKkyzfjiBJG1bzAyLwcmLBTC+0ng1ADt0dPKd6wXlAYN0K4NbH+mcyFksvL8fCHLsAVDRYGTcNqjamCo+Z9MSDASKxBTjyU6Oig492tPly4R52OLOeLENHq1wc2Yn+nCdvVxD5McVgNC6TCIXbGRhI6hm9SWCl7ga/k0zjz2Vk5ZpEiTk7dGfe1RTn/D0EJw/TWelesEG8=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB110544D2ED61561CA2A9A81BCEA80@BL0PR2101MB1105.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(305945005)(446003)(46003)(11346002)(36756003)(6916009)(4326008)(5660300001)(2906002)(186003)(68736007)(10290500003)(25786009)(7736002)(107886003)(16526019)(86362001)(2351001)(8936002)(8656006)(22452003)(76506005)(478600001)(50226002)(47776003)(52116002)(6346003)(316002)(52396003)(97736004)(48376002)(86612001)(8676002)(81156014)(81166006)(51416003)(7696005)(1076002)(105586002)(106356001)(76176011)(16586007)(386003)(50466002)(2361001)(53936002)(10090500001)(6486002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1105;23:BE+NnMobKOnXkaYumfEgmbApzp+rn6NGWrdMTwS?=
 =?us-ascii?Q?0YEXJ7KoF/QOf0PGsSwGRvPzm67PzyI4LDwZRJ6dFHHx603nIYYkZ+UCnMU7?=
 =?us-ascii?Q?+TZgdq18bIekMX+fl0rtyULoBlIWXn3fxmvRUn8jDvkdufMB/gbYxTFZVC2C?=
 =?us-ascii?Q?T06CZuc9rOrbLSz0HC7PQtoFNYtAimKGWKwAG0NUXAy/ldaM5DcFE9kgzWDc?=
 =?us-ascii?Q?DZk4cewmhzemQisi5Hdh2eZdmEpNtw2ib1O5QoIJPAZLCS4xQlbriF3jfy1Q?=
 =?us-ascii?Q?qsHhlG/ZSy8yATv4AvzzbjvxS54Lq4StsKIydO6XJwzBa57oZlrz0lHI83F7?=
 =?us-ascii?Q?eoGWz5zTGO7XmfTnV1b0VrTSs5cFdgJnRu3J6fEDe+Wr9LHrXeGAYNiaJPJC?=
 =?us-ascii?Q?4XI5Y5JqCUI490yl6Q+slS4ScS0/HJ6el8DPmQA7Vt0EfDQ7A3AJ4U+SeQqR?=
 =?us-ascii?Q?zI8+EQ8xeXRogOHfoEZARZHsvQ7v8Q/1nlwUZuDdk9ViW3/7qzxfleAtoRgh?=
 =?us-ascii?Q?ImpvjbEtBCsVREFBsRicFan4dfzZfTwAbstqlLuGkY/fk9peUqlQNiJBGaHJ?=
 =?us-ascii?Q?SuhOhSp0lUB/bRJyNXODwYJaJIlbCnSZP7YaKx0eJdpAIYHEfixT40+VvXNK?=
 =?us-ascii?Q?OjVsKEiDZFJst4ad52lz4V5BfiUbYVqS0bweRfE20NlxIS4NxYeLGJ3sMsg0?=
 =?us-ascii?Q?GGRsKeucWqn+ik4tMtz99Pa5nOnpuLtG+DjMa984u0T1Q7LzUgqsIwQqrRXh?=
 =?us-ascii?Q?xJTIu0bDgSok8cMBzTaLWDAzP/YaXa4txx0/VqDyGpOkqJr1G+JMMRZixkHs?=
 =?us-ascii?Q?J7i8w7DCwhlhFWQdMYmljYipzChPuH45APGFiLr0iZ1Nt+2+hOzUyxoLgMdo?=
 =?us-ascii?Q?2tjAMc2g7kxBvaoptcbX0+he8ZOEe5/OZmlpXg9DSDwKvf3yNhztgcY/sPTg?=
 =?us-ascii?Q?JUexNhLoD6DE0U8N8I1twdHhyYQR/SRxV1SrXk8uuYOX0mK09jUWg37xrEFM?=
 =?us-ascii?Q?V8BADR5ybAHD02nbTqY5Xu9AzFn+QREfdKWV4omTAkmcifAGvuPhGc0RJZGl?=
 =?us-ascii?Q?UbUGwzmJUDjv10WJz7KVusBBd4uU628jNGaryEOWT/1y//7E0YGiXvVwrGle?=
 =?us-ascii?Q?6Sy4ED3gqJjDbhso2tdssOfSXqZZqztlVZmqdyPqy0LDv6R8oak5sHBjv/Gh?=
 =?us-ascii?Q?PDRiVVRluIZGsgdS9nBDun2Eh/HCeZ7koCKAdz1pzOcmKq6r902kiV4vRmNN?=
 =?us-ascii?Q?ot0U6yIQRChhdA0Digq3xV7SSr2ZkdPY/VvFOkNcBoiTRpOCkaShsaGCmWYG?=
 =?us-ascii?Q?ZyAxH5ci1n580Lwcz3FBbcWo=3D?=
X-Microsoft-Antispam-Message-Info: QiASnHO0ZUZE9LLoMnYbk9m10V5E/vv6GmQiSK+R7oN7SMlTr33VPdh8Pxn2MrtdKoyOyDFeyPSvqvF3Ll3uzwBOcpC24ET6bsvv+BFcxj/MWsT2fHV7IbydP76V+T4MXbYtwkZD8/W8Y3zEdtknrBjc/ZwyvoTKtkAk41osVHQCQ8b9PZs23Ssg+A+e4c77
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;6:if+V22o7dIar1uvQXRvZJ1yIwK7xBaHN5BRYy60z/KkXkIzM8WDzl16G8UNFmP4Yh8cyIiObjMvgGjre6jHy8di3v1ZVfwXqBgjzBpOzUAD2OK5943N3IU4wIjZ6ZAtvwTp06qFNRhd3jretaTOqLH7Y32rvpBLj31FAqSnwGclniGLOQO+GscK+jzBDAMFpy5vyHcl1j1b5EEuch2gVlH1vzPamHkmunbE7ihe55jvK49UC8z2HtTJflY6ARv0xE1x3lkiUyK7pzgG+RkIt9z1V603Zc2H6r2i/qxBTSB2m+fZEY2vcZDrQ2EnCy1p3izkjvz9YQZhg/P2ZuxHL+FI+1V8KGZ+uSYIbuFtDRheXBp+W/xZ3/zaaEdTPsRTlwAWIas/ruIKAQtcp2AQ48PPu+JBUTtsPPyeyrvXj8X9r9h6Rm4PXcU6jKx8FitcqSVaxVoJpD50lXCh7N6Kecg==;5:SssIRuVediGAHtFGrQA2s6QQKGeWEwi+FBhQYOnk5WNFZjqiOOGaxgM6AP6V5Z0XaU/ubOcDrhocila0CyRxQx21jnkeqelfcHwrnJfuJXWlNfqGfpoiJh3nR3ELcP86As+k5x1SBjJu4lYfdkEXbfgnJABVa5vFTsGlSIYF7KQ=;24:3gDQrKY7xWxB+Bii9ErBD60MUuii4NaiTKD2S0buzNLQ1Nwb5qYBlIhpnUc1zMQLAsRnhXfPixKyoTy+lsTsBzs/WdPZE6ewpPRYe6RqF0I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;7:zRctzu7QCvhhX/dAOrWhG1UzAdOO5QF6Q2cLLjFWGUrV/1g6zLYMdH64hm0d6m6HcMEP0pQX42oGdPVp4OpJz5wyA4Y+cTCukMEQw9yIxVLrf8K7eMtbZD5P9ty2WSqY5XoyMBt+veYZAWRBnMO1sRB6LeGtiFsQ8sqk1PxL/ka3vgBy+1KGLyQYcFZnb90Mq6AuoR84ofLws1EKBnL3rWdte5CLVkK3ZVCKUdyPWLxAMTj5nQ/mL+E5e6vdicKw;20:XcIPlp74gmXaZl466U11OZ9K9lR/jvf7N7GLvXjcLj4TV2e1BweZwAWGb4TxpDFodRXrIJtJerK5vqT8wtpnstC/elpfaCb0cH+MmqLGHRKUa6HIPpTdvLOXpF7ONjA4s2RlHHdc8OGfqeUPk1jUxMUr6Z5n23JoFZ2nOXS/WfY=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 14:45:03.5726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac3bb0f-7fad-427b-1908-08d590cca9ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds functionality to the mem-pool type that can be
generally useful. This functionality will be used in a future commit.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 mem-pool.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h | 24 ++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/mem-pool.c b/mem-pool.c
index 992e354e12..7d21a7e035 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -5,6 +5,8 @@
 #include "cache.h"
 #include "mem-pool.h"
 
+#define MIN_ALLOC_GROWTH_SIZE 1024 * 1024
+
 static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool)
 {
 	struct mp_block *p;
@@ -59,6 +61,36 @@ static struct mp_block *mem_pool_alloc_block_with_size(struct mem_pool *mem_pool
 	return p;
 }
 
+void mem_pool_init(struct mem_pool **mem_pool, size_t block_alloc, size_t initial_size)
+{
+	if (!(*mem_pool))
+	{
+		if (block_alloc < (MIN_ALLOC_GROWTH_SIZE - sizeof(struct mp_block)))
+			block_alloc = (MIN_ALLOC_GROWTH_SIZE - sizeof(struct mp_block));
+
+		*mem_pool = xmalloc(sizeof(struct mem_pool));
+		(*mem_pool)->pool_alloc = 0;
+		(*mem_pool)->mp_block = 0;
+		(*mem_pool)->block_alloc = block_alloc;
+
+		if (initial_size > 0)
+			mem_pool_alloc_block_with_size(*mem_pool, initial_size);
+	}
+}
+
+void mem_pool_discard(struct mem_pool *mem_pool)
+{
+	struct mp_block *block, *block_to_free;
+	for (block = mem_pool->mp_block; block;)
+	{
+		block_to_free = block;
+		block = block->next_block;
+		free(block_to_free);
+	}
+
+	free(mem_pool);
+}
+
 void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 {
 	struct mp_block *p;
@@ -101,3 +133,29 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
 	memset(r, 0, len);
 	return r;
 }
+
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
+{
+	struct mp_block *p;
+	for (p = mem_pool->mp_block; p; p = p->next_block)
+		if ((mem >= ((void *)p->space)) &&
+		    (mem < ((void *)p->end)))
+			return 1;
+
+	return 0;
+}
+
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src)
+{
+	struct mp_block **tail = &dst->mp_block;
+	/* find pointer of dst's last block (if any) */
+	while (*tail)
+		tail = &(*tail)->next_block;
+
+	/* append the blocks from src to dst */
+	*tail = src->mp_block;
+
+	dst->pool_alloc += src->pool_alloc;
+	src->pool_alloc = 0;
+	src->mp_block = NULL;
+}
diff --git a/mem-pool.h b/mem-pool.h
index 829ad58ecf..d9e7f21541 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -21,6 +21,17 @@ struct mem_pool {
 	size_t pool_alloc;
 };
 
+/*
+ * Initialize mem_pool with specified parameters for initial size and
+ * how much to grow when a larger memory block is required.
+ */
+void mem_pool_init(struct mem_pool **mem_pool, size_t alloc_growth_size, size_t initial_size);
+
+/*
+ * Discard a memory pool and free all the memory it is responsible for.
+ */
+void mem_pool_discard(struct mem_pool *mem_pool);
+
 /*
  * Alloc memory from the mem_pool.
  */
@@ -31,4 +42,17 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len);
  */
 void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
 
+/*
+ * Move the memory associated with the 'src' pool to the 'dst' pool. The 'src'
+ * pool will be empty and not contain any memory. It still needs to be free'd
+ * with a call to `mem_pool_discard`.
+ */
+void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
+
+/*
+ * Check if a memory pointed at by 'mem' is part of the range of
+ * memory managed by the specified mem_pool.
+ */
+int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
+
 #endif
-- 
2.14.3

