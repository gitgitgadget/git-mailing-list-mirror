Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD391F404
	for <e@80x24.org>; Thu, 18 Jan 2018 11:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756060AbeARLEh (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 06:04:37 -0500
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:45129
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755343AbeARLEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 06:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qqayLYxHhLyeqBXLggmAaucATBhwB214vPR1Srw72tE=;
 b=FGILEYJlH0v6v6jl3/vuj0iAF3rohRfLCSnVqB+zto3qc9mEbaDXrjTs3hzteasAerTlPbqjypyS1/3wuimomlwZr9JKPYXQ8zWDEY/ToluDoJBCJkvxLi5eoAW7cTd8Kfcst1Y7tK2MP8gh7oV/5j9fl5f0zAPb1KgkV4KKIX8=
Received: from stolee-linux.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:7308) by
 DM5PR2101MB1014.namprd21.prod.outlook.com (2603:10b6:4:a8::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.444.5; Thu, 18 Jan 2018 11:04:31 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, peff@peff.net, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2] packfile: use get_be64() for large offsets
Date:   Thu, 18 Jan 2018 06:04:19 -0500
Message-Id: <20180118110419.210006-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180117222953.GB16031@sigill.intra.peff.net>
References: <20180117222953.GB16031@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:7308]
X-ClientProxiedBy: DM5PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:4:3b::31) To DM5PR2101MB1014.namprd21.prod.outlook.com
 (2603:10b6:4:a8::36)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cea1983-59c3-4fec-ce0e-08d55e634045
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603307)(7193020);SRVR:DM5PR2101MB1014;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1014;3:KTA9KDP0IdprP/lE4AC46pRUy3S6qxY8YkXICQ/OdNKOhWXDncgN9lHDRAZUFCubUQL32hdOu9JNEsohkCAS8HpKKhYQ5kAFkcMxUuyz5lP8mER/Xej1nd+keqoQcSbK9f4VL/C2Ij0Qu7pIda2otuRC00JZdruPX2G37Ig8XRb1D3nyfrqIDbLWbdaQu38fUNb6B2kw8JgE6VHedSfLgDJqQw+NkPjAL1RORxHo2uPW7Rc7EPff88rBIW1A4iLY;25:SaR8NVzuUTZthAm5n10fQ4CfTNYQAaMxN/hJGgboj56n0SJhELolSkVZXQl2KeJxfE88h6hh60p1kHVsT3VHM17DmzqGX2eoe7iuSDK6OT4F2k2C0OqVYiRb6pPQyCCw5tdIyKuA6d1oBccg9nZKTxXZ7eQZyUVR/Fm7DtbZyQmgQmIp/a00tpqZbJXJ/OGVpIY4aALMOq9b0HgfsNXCbNt2kiqYcGGeTTff3/cx0oaI53wMMZf03WUQ0IrHX5ScCeDPHqhboiNYmGkI7NmvHMzAO2vQiyiYuxOVGZo8uCV9y8B5IcYc5IXs2PHSApXGpOlba4fSSPWOeHLdxfMvbQ==;31:Ak1WYCsHU/ZYL2NB15Ae1H/L9Pch2PV2avr9URb6M2hX15BCqy5ScpbilcqGWtq3SBpbJZIgRLwXuBNy1KEWZh9f7AjjZBYnhoep+BYTqbquMx49JGaMxal1exnVzF8FVnfPiCUMzivPe+jvdM+vl85jPCJqE2lvM4fmhc4+lFxOp36MxFDclzHOirhiHduNOjOE1cHSmTvx5F/y5TzqQFzFIYSqPgm/G2lvvQNPAdM=
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1014:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1014;20:wbWXwf4693qVG0kp9d9+8nsQG7+AWI8+eLedWODm+emIIFiMCiuLnOmllp4lOnScK34R2UpS3KKnzEj+ZrclUFyFzVCwxAVWuC7v4WpEUvQNOuQtPeBVZ1Y4M/gfNMWyibC5lAlOVzC7uTToYMNt/G7PpJBZetIOdkxSoiaYV/syFh9rc1eph9448t4hqMxPG1kw+ee0GlLbf2np7eVGVy7y9GS2MsuLVwaoXJsESojhZquy45UrpjkutnI38yGjJ+ogIwHBmbSpdMKFh/nu4oUrYO4kUK/hRwiPhRPUmiO2Tdd6T7lsp7b9Ytl6GdlGsQ3F5a0JPXhfpViZnFtEBsTBcPE0bBdcicBRa0mtuBa8DdWO4oKjrBPq8Lcg35DH52F693jZy0kf8gHCe5Ioc+ovKGcjXI9L49jtnEWU7YZvCAYPZrqsznNyV2okZzhidg8N5nHoIwEpzFBXHaUOU+l6L7YhMdI8GSex2OZMQu7eLyno6df6S+QoZttlxg1J;4:2/IBuLKtaHRwA+h3DYo9H+MIVqjcIQ6eiuQNvKTpm88ETTVYpTJQHzr149G67PqOjO9W4qvbEyyAemunajNmWf8HQJouaoP5m/kki7SbSUvZN64qHSWoYC3Xm2jkVq7znvvjnvFylrddDPktMfHJat9+s8FosaAdMfU/wteCNfSN7rQl/ei9bFv3n6xc7cgFM9v3fx/BsemNI0uIQI8jez8LP+w1qmJmkPguZRVZ4WNTN7tSi5iCboDDbkz0Dvo9aH9x6YIY0W2y1E5FzfHmI4kmqtaE9PiwlZE0fk4WZ1pV9uCzr3+8oyHvwawKhYq1b84XslBcH00W7aFiilwJaZNnIvwKvuLPwjrDazBN7os=
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1014E8DED4C98AB3FA5D2D4DA1E80@DM5PR2101MB1014.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(61425038)(6040492)(2401047)(8121501046)(5005006)(3231046)(2400060)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041279)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:(100000803126)(100110400120);SRVR:DM5PR2101MB1014;
X-Forefront-PRVS: 05568D1FF7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(366004)(396003)(199004)(189003)(2351001)(5660300001)(22452003)(575784001)(6916009)(6116002)(1076002)(2906002)(86362001)(6486002)(2361001)(86612001)(39060400002)(10090500001)(105586002)(106356001)(316002)(10290500003)(16586007)(478600001)(2950100002)(36756003)(6666003)(48376002)(50466002)(59450400001)(305945005)(386003)(7736002)(25786009)(6346003)(47776003)(52396003)(68736007)(97736004)(4326008)(53936002)(76176011)(8936002)(50226002)(107886003)(52116002)(8676002)(81156014)(51416003)(7696005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR2101MB1014;23:XHfETY4tsU6AVFgRTK1Eu2AEGrTPMmsydI8XuId?=
 =?us-ascii?Q?4iS9DKnzeBeRe17Oriz1tzQ/dnSl1IoMarWNbeagOjvK63j4oM5hQ7FnRSko?=
 =?us-ascii?Q?GVZqtMo6ZDNmA/2HSrfLOeG5ISFPZne9Q1VABQQjHHYibbit77GUQdUhG0bx?=
 =?us-ascii?Q?CAiYr3LRfZFq+fIpBL5ThUTiTWkPVJ2E0lQ7nuw2HqiN5S2yinrVDwmjNhKs?=
 =?us-ascii?Q?inIk7IcwCSk4Cv9ySlEM/yVB8kvdebXehs9yFDO7ffG0sVa3RVM3io2Yxe8G?=
 =?us-ascii?Q?RS6bPyxpcfINB+osSeS86RnLSOC9hU32XGYC9Wj37JBvAFlCXriyOKOR2mSz?=
 =?us-ascii?Q?cTwadsoaC0tvqgQL0cIOi95DRy3HTNlSn+dQBo6PQ3Hkfb5ArSiCe9PFqLJC?=
 =?us-ascii?Q?IdF2pMG/m1MnlNiEqxPFHTPAx29MR6aKb3azIFR2V3EQCSS5WDXP9L93eoHU?=
 =?us-ascii?Q?TCwHuXwF8s4pt4Pri/aNh7ov48OTDVmTqqy50KhEHkSfcpIaGd3vHo+VgP/X?=
 =?us-ascii?Q?KRcoKyYoTz48hEPqEeUzMXZ3PSajWxv4ogyvf/Yp/onfkrAYugclQBO75cSS?=
 =?us-ascii?Q?CXrRqw/LDDxIXd1vMhIT+n+dVuQhuaAd9kdu38Cqive/+kY327WkL79FNuJ5?=
 =?us-ascii?Q?c3W7aRG7CHSuoHM14Zk0IXJLIHJcLQf14d/j/locHAbfyXRX9bMdcBDr+gm7?=
 =?us-ascii?Q?OGLJFZTY407oJPs47w5qUhhUffEvmunAZIG0dipSfCbd5iBT8LZ+TU1+LEU4?=
 =?us-ascii?Q?1hs6krkM5hW9X07PsQMOtvbIUI9p9cJAiYOXcpPOfsFB5KVIpPCF4FJtwL4t?=
 =?us-ascii?Q?IMY6vb1aSJR6jYFyXRQ5iyLeWkh5/VecGLfV20ixMaYAgOPRmspQ/4H4+BVT?=
 =?us-ascii?Q?Lz5K6vfNff+LUMX0lfYNo1whvyyYGZeZTKDCxuNu9rTW6wCC63aQULLiTdld?=
 =?us-ascii?Q?F02IRj16L3Jx/RqzpgwSPcjmMTe1GvvCZ3tS6GG3kQMwUeC8rqpC8+awdxzP?=
 =?us-ascii?Q?eSEazlnA5s/sOdCtnfL69dQpuRNXvnvemjsD0yxQYSPvjpYy3e5YWJ2K6v4Y?=
 =?us-ascii?Q?eP4hede+IgpdUhLW2WWbdt8nkfPnDnznDNanKvxlUNBlvYSG3XWownQn5zqf?=
 =?us-ascii?Q?YwLjOh6L3+tGcV03cn97T6ZLoXLug5bVOUbBCRwXRcA4U9vHS4BsCbabUyB2?=
 =?us-ascii?Q?x/l6bdiRgd5Yq/Rgon3Oim3AisxAwJ7Y6TFXw7dadIaFyRJXGyoi30z6PSfa?=
 =?us-ascii?Q?YvCr7RkafHjqxJ1pTFvKDZBFmYmN0nlEesLWrrKwr+x4gENYe74ChhPd4Jw1?=
 =?us-ascii?Q?7og=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1014;6:3Xgta+eTGKS11trH1RfpO5KYYEvgiQSUrxbgLNp4z5LLmQo3UXJFrSR83z231MjRPXKSxvkgpnjRgHL4VSc1xjd5K0qLOZSeJQDG63nDjsij33wIxQ/MmKTTlv0TxZ4z8/4HzW24759Y77OllPzLloOkEleV3TYf6HZvzlpqWYgpnf8gQlLm261Al9KbQLJc2+eTw/VkUUkhBgP7wonCVaZrXWOk73ZTXJ+tG2gqgkR0+3ccuKuyq/yV3ecKsOsw+jXVrK1STNLeI5ZafFhzXk+RfovTLmWPV7CTmNwhv2anz+xTruGVz4CVxxpQyBEylh14ExJAHaoBvjCNPWRXJQh6X++0DzGzz9cC9Pz15Ow=;5:hF+5rw3N9LtSwJu88K0WF4shod7sDgJH3InWcA65fazqfTbgRpPnYJrwe+0MSrn1/sMGK8WOuGgz0ld4KIAHaeA/zBadrakIzHaRgO6NOfyUdq0ADa9P9mziG1Wmi2Aj1i0TFEPrDP8w49gWGeaT7igzKH1/UNXJFzEpBOwnywI=;24:wpnSWjld0cLDFHhnArzJ7mQdvXdPKRpH0TZ53jvHYDbtQbtipfbYCvibFU/5EUr3n19+Bqzd2/FO1wmY3RMUiWdpxIuKF9vwqrSZHMrclt8=;7:SNVR7qugv6TCtaJXotkd5FjtObqu/55buuz0QwrYTYFdtPuc5Sb1W92jZqbc+ztrbKV45ByW6oQbX9+nmKs9O83NlyPHs4lDu6UF/ur9s9G+jDe5JbggvlzghRBG3CLji3cIdzoE3oH4mgxFQX4uaUjhOEhHBf23mmCFnV2rTV81qNiJxH96KP11rWe3EzZIwHtZObiuzft+s3RmV2h9ywHJGMklhkJsMZi2y65+BzTNEKWHeewSzpbdtYomXvAs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2018 11:04:31.1620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cea1983-59c3-4fec-ce0e-08d55e634045
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pack-index version 2 format uses two 4-byte integers in network-
byte order to represent one 8-byte value. The current implementation
has several code clones for stitching these integers together.

Use get_be64() to create an 8-byte integer from two 4-byte integers
represented this way.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 pack-revindex.c | 6 ++----
 packfile.c      | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 1b7ebd8d7e..ff5f62c033 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -134,10 +134,8 @@ static void create_pack_revindex(struct packed_git *p)
 			if (!(off & 0x80000000)) {
 				p->revindex[i].offset = off;
 			} else {
-				p->revindex[i].offset =
-					((uint64_t)ntohl(*off_64++)) << 32;
-				p->revindex[i].offset |=
-					ntohl(*off_64++);
+				p->revindex[i].offset = get_be64(off_64);
+				off_64 += 2;
 			}
 			p->revindex[i].nr = i;
 		}
diff --git a/packfile.c b/packfile.c
index 4a5fe7ab18..228ed0d59a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1702,8 +1702,7 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 			return off;
 		index += p->num_objects * 4 + (off & 0x7fffffff) * 8;
 		check_pack_index_ptr(p, index);
-		return (((uint64_t)ntohl(*((uint32_t *)(index + 0)))) << 32) |
-				   ntohl(*((uint32_t *)(index + 4)));
+		return get_be64(index);
 	}
 }
 
-- 
2.15.0

