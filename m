Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21211F406
	for <e@80x24.org>; Wed, 17 Jan 2018 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeAQTIn (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 14:08:43 -0500
Received: from mail-bn3nam01on0126.outbound.protection.outlook.com ([104.47.33.126]:19040
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752802AbeAQTIk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 14:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=a/JEhTMOKOpfhi0CYvW3jmGYIXfa89AKkZIUFP0BQ8Y=;
 b=o7XwANk0oGKK5CagWsDCYX9jbLx0UUEqlF+9CMvW8BiFUIy097FiUC2U7bIyQHVwVq1bff6BXG+KrvYxwkQk/+KXb8gQZyAr+iZqM4FLs0F2uKfjzmd+dhe8zxToKEZjW3hP8GV0dtBKtydA4FkZCsClf5HmFMdx28FTRLgiTUU=
Received: from stolee-linux.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:7308) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.444.5; Wed, 17 Jan
 2018 19:08:37 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] packfile: use get_be64() for large offsets
Date:   Wed, 17 Jan 2018 14:08:23 -0500
Message-Id: <20180117190823.209469-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:7308]
X-ClientProxiedBy: BN6PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:405:39::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 054c2b95-99cd-49c7-173a-08d55dddb6e8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603307)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:hulUKS1YE46lRHdFM6pxcVqcrI5eZvy+XRnzATrtNEh8QbEo0g8qxIy+vbhhzdxF7uXEwxlZ/fOwnXBOx992NPM1DXFhJ216c/FibV145pW0O1389E624gAY+uu0AMUxsNbkVLqk7yZBBPSAoIY9jyhY/MFqz6PYIhePSzBBOweqH6mCm/ml7oqLxhRxwR/juFMuNQ0uZLl66I+azxu/SfrmWiP7nH1BnzdEJfXXdngIk6MD9eQ2feP0Y4TPutb8;25:RwyQbVeUMvnNhB5XfjCC4lqqeEoG49xegNL7SwTnzcqeZuMV784L0rzvWTAAQavvhsgystwlqrIUyaMUdLqx/mKTYWMRlVy/GxnR2RHjVJOSiWFWWIoq/I4WepY77U43jSqgd/2YEhN/Fan3IrGWvnLeEHBlzpAQr3098POTovVk7qXZduzHrhI890xZ0iPoQgLK8sU9nD4eyZzrc9p9I2cFXAZA309JmcfZxaL0R5KTugFQykk8Iqs0Ar2U2vQmzQVvYnzXQbyaTknwCKaM1z/z9Wxqg3QbIGJqxYleNTyUiASPUom+NvvRBhprHrqDZLbtgK6dwd7gz6zEyEBqew==;31:mU8fP7/h6BNdtaRAgv7Eso6rDp0SnEn0USstFOzw2sk9khOmPntwqAMba7aIhvauHrXEWCizUHJXw4VHKkz4JKpoGnr8Ws5F8bbUiKqKnrrQZyMba8OcaoEsLkM30yMxIkXpF7v0pIjsnMNWhVD+SABM1qj6IMIUtEmXiP9/Hig9WrqYhcw2tM7pDDqt9oEUQtKXWejjMrUJE1tMyEtHDGIdx0I5pwPuSYRvLUaSqKA=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:i99IIWde/J1KwUz+uc0klcu5uIAe9fPS8PBMUr51GXQV1mLtxxPPqgdYAN4GE1E44z//E2U+LF77t/gvufXzZ52t8R5p7NZqqRTrH7+Vq6z8UDy/LlMuFaps6gwn0ZJ3B/mGSe/H7I9tk8rGetTnjbH/PqNwAzDtReF0Hp2jNi1BunRzCunE30mk1RYEu4gJhAJhl5/rfLDw6HxC4cbDUVha1yQULfZoviEFLFi4yMNG4IGwKyOOE5Jm5D2bc8m0gCOlIKCh4mTMq75y4kfI/f/UIbOHrw097YxazFLPd4/FYn+ZKLXuVAVZI+J5Xl4jdaipaufwwmhvi8UcbYisDXOzFzpfi09pbttGuH5t9BANSJHJrfgyytv/9Rz53EjWvMeRh5idG4ljU2A1x7VPoJ4LMqj/Wj+j/qJcsVyoknpz2/qWAWiRUMXeOaK5mjC0XNwip5qlGV3w57M7DvK5VtMt3+PUhp661JhsqnW0+2vkq7fb+15X5nXIG5Fs1W3E;4:XK0ffz5IyxECX4ctroozpzm+3KW6J0WqhqIGo1EZhpyaL9dXpmBxEG3dZFDHRFOyXgD5lRaNh6pqXX/DJuI+1OZRPkU0sKiTzcfbblGRnpbYPfNsy3VAIuRwvyAXQyN4XffJ52S8VLvy3uyf0/aojQ+axQgp/U4WhPGQQieXzMwBYQZ5g1pq5tw2h2KFTkZwyudq5H1kNzvJOsTZk1TOL3k7enFhFQ7SLKopTSw9HIqSy7i4QgWs0dgjyD1mIhvUw1WSiBIkCMsR9xZvu0XG6/YKRzTd2oCDXjXNK80YHKWdoORRAatdj4IUMn2h1R0JI/j+0L6ZuGHB2TUaRWe0oaIDXnCKhqNgS1Ee8VjR6fg=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1011ADF9B929DAD86A95555FA1E90@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(61425038)(6040470)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231042)(2400048)(944501161)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041268)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:(100000803126)(100110400120);SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0555EC8317
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(105586002)(6116002)(8676002)(2351001)(2361001)(106356001)(1076002)(6486002)(6346003)(59450400001)(47776003)(25786009)(386003)(50226002)(52396003)(81156014)(16586007)(53936002)(81166006)(10090500001)(52116002)(51416003)(7696005)(107886003)(316002)(10290500003)(8936002)(478600001)(305945005)(2906002)(6916009)(6666003)(48376002)(50466002)(97736004)(39060400002)(575784001)(5660300001)(68736007)(86612001)(86362001)(4326008)(22452003)(7736002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:lPc990rpQmhzfLXtBRh8rqMwINnKpvO+Fdw9H+d?=
 =?us-ascii?Q?O93uSQLtblbAkjltmo/TS+o/tyfmHAUTbi7mPzaj125x85i+rqYG4pqZqzj+?=
 =?us-ascii?Q?7eBKQ4z0xDpbj4EAP/pXt5KbZq/9SRgx/586Phqxt9iDzZGap2kZT4aMiwqU?=
 =?us-ascii?Q?zIjmlwngAqaYDw/sm0lBsX7iAy2jbBplrDbrEZWAkwNTkfxrarkeHNR8QVRO?=
 =?us-ascii?Q?/gW3V9r0PRXqiCkuW9h6LtJ74GT9rh+eMPJ+omL5XaYu/3naqx6YdA8MaHzu?=
 =?us-ascii?Q?CjLjkukxa9tc2H0OpaFWekELncbawst8vp6PYyTyRqGkyaUN5nVlX9y8KUge?=
 =?us-ascii?Q?0Fxw/W+sMBmiebX4mtVsuVc5ru1n0aLKQCeRqI2lSgKlaEbOQfiNPNCyswhr?=
 =?us-ascii?Q?K2tO/Uz6WgRGzzV46gZ8he0y7qoKxSSAMvIVSqNllbQ5kaxxhwyZeutcYxko?=
 =?us-ascii?Q?o/jCYvoovCPRAkC9kU3daaddFExPxRHIG1A8vLq+/D3PUEvjO0wqIWPNNaR3?=
 =?us-ascii?Q?p+54QVw8PxLirgI0f5lCelbMVELHHSR53NzmFRYS5X+CMWm7475fHSGEjTX9?=
 =?us-ascii?Q?rxiWTkwpzPRRAe3oGPeNCGChoNIKaoNui4r+I+VkMWU/rHq6TJwGFCG2R4QX?=
 =?us-ascii?Q?rMhMjEX3ym8LtzFST6X3FAwCKNDxrrORz7/atj78i0vIrqMhVCj7ZssE/9nD?=
 =?us-ascii?Q?imwyfOkJNXmTH9d7MUzUc4TiG/kRxnstgYOksBE4p+u6Wo9eV7RIq01AGVXr?=
 =?us-ascii?Q?6AxZZ/Ptr3/3/pTcqx+TN7TyAOLsMBGGqDfycMJhKOBe7Qs9SKylxOvYQh4o?=
 =?us-ascii?Q?gZSQyKMgxuLKLqPTaOgkLSQtA+vT4AqVfvNzGB8k+cLRactV1KF9URWJfdWK?=
 =?us-ascii?Q?Sek1jSwc/vHenWSNpCU9V7PiKK0avu1rQccaLlOKPAHRgEZbHlZPpM7Xhmak?=
 =?us-ascii?Q?zzP1+thme8bjHDS0ep6oF3udj2rldpBqBpF/1DDEciE3/UYky+tCMUgf8Wjk?=
 =?us-ascii?Q?7BKCmUTHco0k87yqlrhluPvcXybgG9U0sAyrN91n0kzBCw5MCyZCnKyPXY6e?=
 =?us-ascii?Q?sERK9jImPC4mpK6ajtOQUqCFtSj+aW/N1TG195XjE8DPW43ivYCyOZeYQEIX?=
 =?us-ascii?Q?a+7oWONlwQQfj03b3NnHRM/X3Pz3ANPSQZztxmEVbPBKS07FqUoUo4H4HgKY?=
 =?us-ascii?Q?tjHNn5jBD+s1CPwD1N5wBjQbPByCnlqufEaNc7PAeKjGPJeFU/OYx+IorJtU?=
 =?us-ascii?Q?JAAQ/anZWpJY1PZ+CvIs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:0zesRgL/axIoZ/kM+IS6CTTHTEh8+kMVM98Xrh02WnkCJX8Zxvt94Hucs7RYp4VH9D7zHRMeutwkQXH1RGyF43Dyf0rr+2GstiV7jEYngsFK0tGg29pamx1bhjs6yK1dZjcNoan2Og4JQrD0ttCfbCwO9B+I3VdGUJyM/wYOS3wY1AbYIB4bJ7x4H/EX9l0urekZTNsknrrA3eTEQOm74scmfL/IwAOrk6aiFQAK4k1oG+gwTaJs5RU/cuDaKXptoBzW+pEPGjVN49ugttRGqrdl/ck/fYA3MKEh+pTrtQHMExSNGCo4tgHHrUAFJyF12UeAUMpZo/wjyNxi4+1rGD1N82KW2wtGJ6nwLbK+J5U=;5:RrsFNhyQFi9x73+9kyPRQ43mEtc27rE5uRZRLeNk466LB3AjggCWneyllf0JLjW9fJET9ZC70RTZgOaN+uA7GkDK1i0jhQLwV/+QTZY1mOtCfPBtrs1XMCg6M3vzj3RyP7cq8u9uUJTB7XzctvmDYNBtC1VUbjCO238bePjhiTs=;24:enPgKaNqcKjN4cw10OU42oCqBZbtKfRHRe4L4n5BPvV0bH4v4LV+zEMukrQbqp86e8ynjrQblvEVL/W2RrR6knoOLkVlRrn9cDKDxEZdM5U=;7:42SXF8ZhK6RhjJFQcKdUzEZrXDQEE8mB39pP0LR1Z2PttnZ54WCpdafnFpD+Vt2OFuTz3Cok8HcWlqkQIq2/zo2pkHxHdw70+y3J8awZAGXDJRXDKmPrB1cHvGyFo0qyRnJZh5p4Oo/nMcW63uQcZXJ9QAPUTwOyFRf76iwG8QXTYats/bc/ebQ74RB+IYGLarN0tx7kigeSiGRC8y7upXrak2kkxmC0K/RSmHHuohsTw8srYUHRpt6Chd6VqUj5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2018 19:08:37.8260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 054c2b95-99cd-49c7-173a-08d55dddb6e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pack-index version 2 format uses two 4-byte integers in network-byte order to represent one 8-byte value. The current implementation has several code clones for stitching these integers together.

Use get_be64() to create an 8-byte integer from two 4-byte integers represented this way.

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

