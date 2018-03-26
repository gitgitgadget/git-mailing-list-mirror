Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ED361F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeCZREl (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:04:41 -0400
Received: from mail-by2nam03on0094.outbound.protection.outlook.com ([104.47.42.94]:62775
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752740AbeCZREc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Rs49vvaSqpYMhmBBPf+rAfhChqJcQeT8TAvyp1ADJrY=;
 b=TWTI5/+Nrn59jf85EsC+kGC1wR8JYzJHbtBULQ6oHI8YHsq9xSZDiJ/71s0U4pxBijwu6JRgCJ5gt8BhTe9YuEJSiZamPwsg/kElmYHhL5iald0wgH07BEKI26UE8E8jD1IcV8/HMZzNGZCpCzuCLxNODF81d2hgZ7c6TvtpApo=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 MW2PR2101MB1115.namprd21.prod.outlook.com (2603:10b6:302:a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.653.0; Mon, 26 Mar
 2018 17:04:29 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 3/3] Move reusable parts of memory pool into its own file
Date:   Mon, 26 Mar 2018 13:03:51 -0400
Message-Id: <20180326170351.197793-4-jamill@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7ecebc4e-774e-4b2c-3ab3-08d5933ba389
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1115;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;3:vm8YW0UaWsGoeJDvDYF78E8WQzao4hzDTMJ9G554q9Yw7Xz4u3/2MdbKQn6t0a5oPa91ClKfttLcZJ8oo4OElHJPIAwH0JWHvVjP5Tpcuoq8FCu/qH9vHP/wTpMgVSB+1UeJZ09YKej5ES6nBbhmw2YxGE6WliYKpS2eOjT0eSkeV7cQ6NPBxGiDTQos5TlacYZWv5JxIbtQLaUqqgyEZI5yOM6Ysq3fJTNAfde8V5XBEoVvxRZ6FhAFObvxAnJN;25:ATKpN2VdcI/yAYYzPJs4aoc/xJqIY1uBDORSHYpN0AsQ31dgLouRMoxARecqyG1ihry0YSL7DBdeMLsEzE394iCBCmMYlpJoLdynMwxEyc7CuYPxXnDEBeC9183dqEvnzgMPDrqthl5I4bNoQzEvqD1kUp2+OuaDsA1wshgJjGyxiWIowp/8hZ4hALY2xGoycfHO0RZBvemrCZ+/BfUajpNLxXtmaLfIYr70pyVnPPWA7fqoOELm8YN8Rx+NNyHeRVnF5GYZBZY0p7PSkeD9qjK9dfInn6Ep1tnAMRQxxij2TJZIVdhmMoZ9Jw/bLf93zrM4M12lwTws7rs5V7DDRA==;31:BeuvmUf8LXHLgpk4+wVvYXXKlRYQjhUSbYv6CMnUnhK+V/+I+wEoRm+6Vgw0tH9TjGZ4UCj7E9evrKz+8FCnrF9MjqrFXECcGX13KEdwpZMq/jJUjjlr2aMMgi6Ocr0FVGjpEt7/Cb1mng8ck+KZ3MrHbvvjNHJqGnbyPLKuMpyMTEU32VutZPsaS1VBnTRfdzBYwQX8RtIWLlRFfIeACpi7WXsjg5JXiFTJjBeEYxY=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1115:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;20:jAazC6A3atY2L6/CPpDpVNAMz7IvVF2lw90MK0Ge+WUhucEti6kdpxoAGeasrXv9GbyxTzWxbRfK+VzIQydKbz5ZbT8NZFhn9/tQKPXRaLiD8W96YxtHhv1r7/OwWhbyB83HfrsIWSaWCggjV8JQ/isZYb6Ie/f/cpRrVVIKYNXDYhws4h7XKbs92AwDPdIEU7vQLfZQPnneV6OsCf1IeSXAuCye/X1G/xOGz702b57uFY3ss5flyVUiZaX8DPB/3p2gulV//0w8l9CAUyR+SVlElN9ag3eq9xO+YDCQKioh70llmVUybvFxfmKY5RcNmfpKJQ3ETs5VL2lOPl9nw/oHzDt8vlaZ75gYYkX+WjJFIiYU4yxUMj1IWViXYzYRrpJapfxJS9GT1KJ3qhx+QJyOYo5j0ihLN5aerQPZFSRJWdn2E9SE4RHE7pr0UKlwIznTZm2A3rcbdXixCE6ZL7BQUrOgmeHTVWkfdr4HFk9rbz1IPaWfQJye/7JFFTE7;4:EexKh59HeW71vRzCIgS2Pp+OjLXJoAVQBLrKaEhNIuU998bCNo/l+fLu9GEsw7jI/DYhX498N3DA48edqt3crJh3NhijMC2Tiq3a7XOgFehM87wt6N0RxbSSmkc3KbyWOoQ/smxenrUqbrwVhh9RHOJrHKHj8CbtHiRocETQqEuT6B+Vf8dUYoZ5C9LXQ1mcn22IDjmNH5PYUo9kgDgcbaYV1VzVsVP843bag9e+MpnjycMkBdWHb4xZgSM0hk0M2qJECmIchteK2rkIfgXpY633XTvs5Z/UiPRZML+r9nwuP2LA/zd0R6oDmdpJvmNDaC4nw3gw9Ehq8PgpUy541JbKSDQdI8Jb3vmxWO/dfEo=
X-Microsoft-Antispam-PRVS: <MW2PR2101MB1115186117DF0349B69525E3CEAD0@MW2PR2101MB1115.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(316002)(81166006)(52116002)(4326008)(8936002)(50226002)(1076002)(52396003)(6116002)(48376002)(51416003)(7696005)(81156014)(386003)(16586007)(2616005)(446003)(11346002)(8676002)(22452003)(36756003)(6666003)(486005)(486005)(2361001)(25786009)(6916009)(5660300001)(2351001)(106356001)(8656006)(6346003)(68736007)(76176011)(86362001)(53936002)(107886003)(10290500003)(105586002)(186003)(6486002)(16526019)(478600001)(46003)(97736004)(2906002)(10090500001)(305945005)(86612001)(47776003)(76506005)(50466002)(7736002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1115;23:XnP36A955wLQlsejS6JgZcoYBfdcoOl9ZO/DHFn?=
 =?us-ascii?Q?k+Go3mJT21EuIHPajJMY/ASZFAAMvDQNYkVF3K1ynr2CEckYvmL0b1hdn7a3?=
 =?us-ascii?Q?n3VlZmW2JeAsrNe9PJTw7xt2bRuf4oOJ5Or5VizeUheUS6S+YXBzlawcjeHe?=
 =?us-ascii?Q?lLNoT194WANpEBAZW+6sbi0CQZ3QfJiRxQF4ENK7fkWsv2dVkGAgd59yQ4gK?=
 =?us-ascii?Q?aIpE6uRUvaTDKzaCPvEvBIjcBFIAidk4UDF5iweqfnmTHWXs5JSb8WzBZCJL?=
 =?us-ascii?Q?u/mA3BaKAYwC2CM7KT02Ac+IgDDeHA0uom3zB/pN8IINbk2f/6PkDcSsNqrj?=
 =?us-ascii?Q?x2i2ASPNh5iNL/xRyJJX3QdPNysx4lJkztqaT8LoGk4Q1AYp8lmp5IScb/51?=
 =?us-ascii?Q?iUGinoWVB/TAKu6WmRMoXZRy6Y4GYhICrgswjZOuTwnfi9+yyZQvh/wLUnO5?=
 =?us-ascii?Q?5XWV5eQMg4JbMloJNeDFiGUzJwQ8kP4pC4jQc7dX4/hI7XP6JqtZo4q2rj8V?=
 =?us-ascii?Q?adedN6PAqCcJ6Qt44UcB7gtYsFJWZtV21/zDluxWS5Ie2JmhdqpdTJI7055l?=
 =?us-ascii?Q?Gl6BBN3tvcSiNzp+MA0rEe963rYv4Kt0Zk0LmfW040hWS6VrjRaILmAAkaht?=
 =?us-ascii?Q?bt2ttTAcnbnobVZJA4jShxgOox2R6IZ3oo+gO45vLRa7vpN3l+3IGfKs0lPq?=
 =?us-ascii?Q?m2LwGT745J1XDC0bQDmscgUAkBnQxbiNCCCfTGymSd7qQyiOnA7LvMZqkw7z?=
 =?us-ascii?Q?q8ppLOfJGwORVZhn7xCdjIszGw15teqnNO1r5hEbYZ1P8jaYTFw4U3e4X96B?=
 =?us-ascii?Q?PtJHOdgVT8ux9/6PDOLkPd25oGQM/72SOwruLdBw4wEfK79nbq9xRSyuEQzG?=
 =?us-ascii?Q?jmDTgMPTIoBqNaVHu4YkmocsAykFSrIsMUnrs2jJEIFzwmCittT6Pmb/iWm8?=
 =?us-ascii?Q?L8PN3B+27lWS0fhl4hfb/k2FkSqvg5/q8hKdwyN0QB+iNhOK7fn32KP9V+6n?=
 =?us-ascii?Q?W6N4j6dH0StSfZVB87qVqN1hhxXI0qW7SXvld3pPUNmqRQTR9ltaQit9o4Ko?=
 =?us-ascii?Q?aZIQGvdXZQx7K2YsU2FrqvMdK8XRb7JH37ME3ayKHxSmM9+y0uEZxThjEbKt?=
 =?us-ascii?Q?sVC+uEsHmbXp82uwmFNFPOzXzT7Ki859wugf1++Aw324OW8r8gWRiER0yKgF?=
 =?us-ascii?Q?WZqciHnXkSNaVHoyGJLd1focTr9PnpHJ+iiZwyeOWAg7IjmZvVSXe/r2nPp1?=
 =?us-ascii?Q?08sYuC6pEXahakb27W879jLUQRvN1qlxaMbYz9mtLKM3s5gs9vkNNP/rxlAK?=
 =?us-ascii?Q?IcvBYABTz4tI/L/BbqUOrIlTelsgndZK64IVo0wZ/awuR0RVAHGvvoe/h3ks?=
 =?us-ascii?Q?0V9kSEuaS/POsmHs2spAfUmwTi/mN/jWkr81IbZvI0I5Bvxf3?=
X-Microsoft-Antispam-Message-Info: 8L4PKi4epTFn9SE0RK1h98iMlNAqnxUMBAyPbTfEntolhKvVq9QpQw0V1Bv9mc4mooLZ9iq2qt5pH/RLeylrKq4e8m9U1sCQ7yCWWEgR5QhRCGzL2dcpGw5X36Xhei5/wKWH4tuluyCj54rBScPKXHU1qiGHcyzm4cy4cqdutwK9/bNwM4QoRJBUkxsgeadZ
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;6:SYR2gdDNAkD/LgsVC9sJMvif2dTYkDJqVj9g5tVmvwxL5mN7RzfIgX+hcaeOO5QvDKm0Mtx1F7CglRbN2yvOnqqneHWBS7GoJWLdFA010z3eUMxA2+lx2Py2AYNvVh33/9MHnJ9H+xmpXHyTlDLN31nQacefb1sR9k3mrnfk9OdqtMlyp2Hno1+0llWEixeSIeeJksamsPVljKytvVbGGU9MzwddMCu8Lf+iGz4L52g+23v/8+b71qsaQoVzSf8y3ZBx29cIoSXPRacpobnB+NAqms4aaIpNEMk8KglZG6o2qh7YDDoRP2ZHY2pDtT0EUpJEF+MJQuVYlu24HX3xwnR5MxG6tCphmTXWHpodDNbmtvH01cL5mNDHiUhrud1xKXVrnbHqkrxQiiBH1RfX984jN6h26DAwV1POOyxufoJEG4L2t0PhPBkzSapQ6jRRli0v7XLbtXnSLG1xMmx2Dw==;5:VMSg1z2q3wwnd/sqGYlK1E522rAR018GzmYQkd9i5wBScxN8h0qRBzBlC8HeX62NcWhAq0005SV0wcYl9RTStrjYAObDIPoE1QYTz2uOoRC7L7Vy4+OFXSA21RJ5WUVSORp26GJn20X8HmtbN3O0WRgqRUQ1Yaf6JwKiZ53aZCI=;24:XmXalOw73n3wo0O53KVhZXCwVRd2Ex+05/HuISIMipathz19LtJOZqKO5ajKRhZjRWHAV6g5mJPGYpProKB8fnburmQJkGvGq7Wml6Qv8Tk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1115;7:rfNH0Kkdwkiszxj+7tT3ZvgKgJu/RW/SQw3GOtqznnJJiKlpdlcQxM7vw/BpswqU3em66k58gxrXnrm3Drn5sFTz1VBuFwtiuubORaTu6Lu4PptsqkqSliyw44Mi2MkI+HRGdiGFbAX8pxctIrVBVuP+9V+v0vljzEUwZJ7zT5qM1peYkvHhwaoAkGYvyATux1Xr/ZE85Fn4rhkNU01itGtqZKA/XCQC6zp2zVZB2ZuI/QbC8wBw6n8p5QXo3lOV;20:SzW0YBLLBuGy8zI5R2tKhqJ18EYoZOpCRO5ljpOQ6UNLjYY0V81mBBccBq+9G76Jff6+CpgkGBrRB7RBzjaRQRLpUC0JoaGnn02QfVMBQ8gmopI1VYDpPlJhfotlA4jn00LwIWbMaFgmd5zeIMdsag+XSBbUjVi3tIHepEZw1NI=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:04:29.2782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecebc4e-774e-4b2c-3ab3-08d5933ba389
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the reusable parts of the memory pool logic used by
fast-import.c into its own file for use by other components.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 Makefile      |  1 +
 fast-import.c | 70 +----------------------------------------------------------
 mem-pool.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h    | 34 +++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 69 deletions(-)
 create mode 100644 mem-pool.c
 create mode 100644 mem-pool.h

diff --git a/Makefile b/Makefile
index a1d8775adb..1e142b1dd9 100644
--- a/Makefile
+++ b/Makefile
@@ -832,6 +832,7 @@ LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
+LIB_OBJS += mem-pool.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
diff --git a/fast-import.c b/fast-import.c
index e85512191c..12c0058c06 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -168,6 +168,7 @@ Format of STDIN stream:
 #include "dir.h"
 #include "run-command.h"
 #include "packfile.h"
+#include "mem-pool.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -209,26 +210,6 @@ struct last_object {
 	unsigned no_swap : 1;
 };
 
-struct mp_block {
-	struct mp_block *next_block;
-	char *next_free;
-	char *end;
-	uintmax_t space[FLEX_ARRAY]; /* more */
-};
-
-struct mem_pool {
-	struct mp_block *mp_block;
-
-	/*
-	 * The amount of available memory to grow the pool by.
-	 * This size does not include the overhead for the mp_block.
-	 */
-	size_t block_alloc;
-
-	/* The total amount of memory allocated by the pool. */
-	size_t pool_alloc;
-};
-
 struct atom_str {
 	struct atom_str *next_atom;
 	unsigned short str_len;
@@ -646,55 +627,6 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
 
-static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t block_alloc)
-{
-	struct mp_block *p;
-
-	mem_pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
-	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
-	p->next_block = mem_pool->mp_block;
-	p->next_free = (char *)p->space;
-	p->end = p->next_free + block_alloc;
-	mem_pool->mp_block = p;
-
-	return p;
-}
-
-static void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
-{
-	struct mp_block *p;
-	void *r;
-
-	/* round up to a 'uintmax_t' alignment */
-	if (len & (sizeof(uintmax_t) - 1))
-		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
-
-	for (p = mem_pool->mp_block; p; p = p->next_block)
-		if (p->end - p->next_free >= len)
-	       		break;
-
-	if (!p) {
-		if (len >= (mem_pool->block_alloc / 2)) {
-			mem_pool->pool_alloc += len;
-			return xmalloc(len);
-		}
-
-		p = mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
-	}
-
-	r = p->next_free;
-	p->next_free += len;
-	return r;
-}
-
-static void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
-{
-	size_t len = st_mult(count, size);
-	void *r = mem_pool_alloc(mem_pool, len);
-	memset(r, 0, len);
-	return r;
-}
-
 static char *pool_strdup(const char *s)
 {
 	size_t len = strlen(s) + 1;
diff --git a/mem-pool.c b/mem-pool.c
new file mode 100644
index 0000000000..389d7af447
--- /dev/null
+++ b/mem-pool.c
@@ -0,0 +1,55 @@
+/*
+ * Memory Pool implementation logic.
+ */
+
+#include "cache.h"
+#include "mem-pool.h"
+
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
+void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
+{
+	struct mp_block *p;
+	void *r;
+
+	/* round up to a 'uintmax_t' alignment */
+	if (len & (sizeof(uintmax_t) - 1))
+		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
+
+	for (p = mem_pool->mp_block; p; p = p->next_block)
+		if (p->end - p->next_free >= len)
+			break;
+
+	if (!p) {
+		if (len >= (mem_pool->block_alloc / 2)) {
+			mem_pool->pool_alloc += len;
+			return xmalloc(len);
+		}
+
+		p = mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
+	}
+
+	r = p->next_free;
+	p->next_free += len;
+	return r;
+}
+
+void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
+{
+	size_t len = st_mult(count, size);
+	void *r = mem_pool_alloc(mem_pool, len);
+	memset(r, 0, len);
+	return r;
+}
diff --git a/mem-pool.h b/mem-pool.h
new file mode 100644
index 0000000000..829ad58ecf
--- /dev/null
+++ b/mem-pool.h
@@ -0,0 +1,34 @@
+#ifndef MEM_POOL_H
+#define MEM_POOL_H
+
+struct mp_block {
+	struct mp_block *next_block;
+	char *next_free;
+	char *end;
+	uintmax_t space[FLEX_ARRAY]; /* more */
+};
+
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
+/*
+ * Alloc memory from the mem_pool.
+ */
+void *mem_pool_alloc(struct mem_pool *pool, size_t len);
+
+/*
+ * Allocate and zero memory from the memory pool.
+ */
+void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
+
+#endif
-- 
2.14.3

