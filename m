Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03991F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDCQw3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:52:29 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:45952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752622AbeDCQwM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WFwP3LvvjaYaXoKCT4hPzPp5Xm5umbLTpnMMuCCh0X4=;
 b=CEd7ABNgJQ5YtbIrAk0LKoPRuTpH3lHD+U/rV1lvhnekgGPKKJ233Lfm7lEC/GONdCkqSSG78TVB8GBHIzDMOKSrV/d+kkdbRkaIOEM3hO0Y2Pseg5Z1gRSz/7wOw/W7m1oucWBTQwWv2gZlO6v5hIawIGF/Lu8Nyc3VW3ujupA=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 16:52:08 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 3/6] commit-graph: compute generation numbers
Date:   Tue,  3 Apr 2018 12:51:40 -0400
Message-Id: <20180403165143.80661-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaf4a1ba-6b36-444f-8778-08d599833d3a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:zEMcoE3B+u9oII6jlFlIr4wDGuxKF3AMY/4jQXGQdl1qVcNhflibUrQg18F4ojqiiOqDhgzAv8Kspgw2xx1nMRrHkKHDGTVAe4fO01T0f7wKmgbhykEQw/grYI6ymnyw86Zp6qwCJnF57VUv+5HKi7Hyrg+O3JAEU+JMphQUPeXQCEvtsmfVtsy7W8CPiCde7gapAM7CzXkrh36R7tkx2AUTDVhRD5F9gTWQjOXdgQ6wF4ztELGxojOhp41HkNaM;25:S80icRyDONN2YIKTx0Js1eRsiNbtmauzDZRezz7qqDfmKq7hPzJpq7oMKBO0ZIfrnWWAsiW+Acp/LqaVJQl8AOlefgIFfZfXZl8GXh+zMn2Qw9s57A7FWkK/Ug2+WX6Kx3eXnMmlAd7U9BF0fABm9KmylkJbo7127NIO6N+goachHVM39FEmFWKFVZT5iZ1E1CQ34iFPPCdxzqN+Uox4v4R7ZCjUrjLaSjrOHKvamjuhU+CYv1QAup4ENlPNaMzNiqy+2HzFboaSsvTQGZjNXVRlO/mGp5I/9Ld7vgyjGpj1JSmbvq8Kmbn1AzLXPBeih0o818RAKWmpwaUzFRYvjw==;31:Hr9qmqVaDKlWw8u1Oehxkek0ZtDu9lk9JGzqOMEgYE6lBOkD+MBBdH0xkdFchc7N1quwfqWFLY8EPxo4+cV+KIOKrqyDhIY6XLUFyt8Cbh9++7LVJM3TaXbDJIw79hCbRI0/jkFbJ7AhYrVcrVUrC2wzg22/5QcXEZA2FnZM8JjwIhZzcKo+rZJ1+R7nZ8lAbKI5Fk4/cGEkSs/+uwIQTtmhdD49a9XhsqiWb4f+Gtk=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:UhDKDsMR1v+9FC1452KatxIz1CTVXM///L30P8xjoTqCwZp698VKxo48zQzrT9G+6GKMVgwSAGXwXYWQEHs5GM+HYdlBVU/7BzcAcRENy3/ISMMbHGyoFMYPkSj1rfEu3gJnFiPCV28pdpr8bB/R70BA0du5vWB4DKQhZrVNX/+Ai89uDDZM6WYi+qD/GWuyg+Qfirb5CyLRvQSWzlhGTfahqPb98/JDvuTw28pn8VOdY38fUVWRQvhjLfxoTO1ZfPitENk2I8MPCOXnj1KrbNFkqdGEzv3rXj0YZaK27OCxitV71PuE45R+3z0hNm0VHe/FEGFnCbJkvvj+AWDBLjPJ06WbkLXgUh6OxC+mKQUj2eJqGUrDnMth/1Ytm6zbI4k6eI+rdF3dFEITxhLOcQfCzosK9Ugklp1LmmFH+p0GMhc494OOhKegWM6hlqbbwDWoAwuNVqjGqXZ1JVrIUf236OJMWiiU3IXukw9cTSEFOP+utp4K4dWJnciV5gvY;4:k8p1dhu750xkYDlLD8CcBurykeWECuUAAkxswb+xhsftXeS3SGZsVKwSDOWFdVnBLC3FWqxNZgf3NUV9Uwfpt3EZRrU3N70sjO6zqld9CCSalMXg/KOGr+3sW5DX0hVR8QsYw8P6vIvDmnwe0x9uofsoaLJrsubF4WkJg78ZV5j3irQ+N8kbmutH7qNNOHVr0RRG+es5lr2lY39VfM3ZXvMBhwEJ5GU2nuM9cqe8WS/XibwHj965+/a2Ore7l0qfY5oERJkfp7Jy+sc9NWoOauqHmTPSf6U1e9k2pRXnrgAcaZ24ZpoD2iW3Z2nLD70u83HvZ072C4xmdyk+SbixctYUvZGwZ38KTmL9xKs2ZvI=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1011BF58A99E441244A53F97A1A50@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(6666003)(6916009)(105586002)(53936002)(7696005)(52116002)(68736007)(51416003)(76176011)(4326008)(52396003)(1076002)(107886003)(86362001)(386003)(106356001)(59450400001)(39060400002)(6116002)(22452003)(478600001)(86612001)(2906002)(16586007)(316002)(50466002)(2616005)(5660300001)(25786009)(97736004)(81156014)(486005)(486005)(50226002)(186003)(476003)(16526019)(305945005)(81166006)(48376002)(11346002)(8676002)(7736002)(47776003)(46003)(6486002)(446003)(2351001)(2361001)(10290500003)(10090500001)(36756003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:dyD0X57nSRr/1Rt8SHChRj2HSxRMJKOZWIXVs6U?=
 =?us-ascii?Q?jeQnGJZX/LPIkwqCa8KYtOdtRQZQ7QAaiOZAB6+TQQg/qZs0y8gqPhNNpDOd?=
 =?us-ascii?Q?Qd0ZfWLAXPmcSIm+No3bZSFS0rb1Pgx2T88rM36tff+q8Tjo1H7y7JJLhdPV?=
 =?us-ascii?Q?N8o9JhTB4gwHfA81KkiHHWd4Xht8QT7Eb1d6TkvOUKpp5y4wLWtWOj0M43v4?=
 =?us-ascii?Q?Jp6OkbxOeecveBS8N5A8qMfNa5jtlzlbfx7JUM4rCjPcoOI9Ry7RJv5riYwJ?=
 =?us-ascii?Q?UCe2fb9RH8WccXorM/Kqfu8hB4/M7awNLcjIMabyRvIj1va9HDKmTbv3JfjY?=
 =?us-ascii?Q?TLW9tUJ1D2/xnIpF0G17fW3STIyPSpXQkIXffm3Kv8Qt8ZwB7oRUqjFKZZ0c?=
 =?us-ascii?Q?OiiY0MAdQos9+fX0CmILhJtYP8Nwi0wW6fRLmrZJfXiKXQr+jZnEk8W9oEJe?=
 =?us-ascii?Q?Nt6ingJPnCQfxBzHCN5wDShLwXZ7c+bPvkJ7uyHZf5yCfCkeKMtrcRg+YsTp?=
 =?us-ascii?Q?pW8DI49Q+EuTI6NKu3TSvGxAP0yGYCcqkOFU4cGlAS10pzmR80lH1/TVGUom?=
 =?us-ascii?Q?wqER4flpYqFB2HoA6voDvXcUX/7FUI2tM6iU0h9RHbatQQ3COl+MF+p3177m?=
 =?us-ascii?Q?3tb7h/RwT4efai2ofQPPc4NpiExhs2+ICPcJifQJe8Cbwcr9qEvJoQYrXPPi?=
 =?us-ascii?Q?Sj0JOe+3M3gbdmDjUHbyFIMTkg4DRHZw2Wh7mQnlLHeOeUPoRs9Y8YQDrecu?=
 =?us-ascii?Q?SNWa3rRz8Gc9OUe0GvEGRNHk8vhbyKKxTANb2ActhDe7JW6zUKObgVbc7/5r?=
 =?us-ascii?Q?xm4UFh7BzWX0YCq9mY7Oj/dONIgC3uRdi//lsFDTJBgsrkLImieERNKRZpDI?=
 =?us-ascii?Q?E0De+4HMiH43vNwkndtADuONQE899jjWzoSZY5PO2rHzJOQvwBZEhahnM0oI?=
 =?us-ascii?Q?Rj6zlpYzveYRQJ9gxLVq8YGbTbiEJDY9KwYsD3zYstUF7Vxd+rlDvvXrF4Sw?=
 =?us-ascii?Q?kXPD6dpQIPMurxWuX1byZm69JYGa5xAbcXDk6/YVaPbiZonSKW0Jg6+fsuI/?=
 =?us-ascii?Q?xPEn2sn3LYmgLxNtYlUoxOFMkAeTflZ3KwBjEqGcY7z4UFR/wAI2BJ7WKEcF?=
 =?us-ascii?Q?px68RyK/JPp93AA/FDcFrmaTWO9oiGFqRQGdHASf81hEqVRO2nmqtmCyfpZb?=
 =?us-ascii?Q?lcv3DpMr297kBkreZ6Y6casCV2ZGYmGew86piuHxozaz8QV6lkJPWjOBdKvQ?=
 =?us-ascii?Q?TtkXlFVJF7fxi7+Ds4waFTxp28jnlNGpkeI35BwnPcVBPdO0ClJ9AY4yNSUk?=
 =?us-ascii?Q?FoHCp4jdbxqKbSP+MqLZCJjY+jVp7jGl0hPF86DEzH5kbcB0zwTjm6+cvYMI?=
 =?us-ascii?Q?tjk/9erpovjxv1qMeOlRPksV2roo=3D?=
X-Microsoft-Antispam-Message-Info: IciIaO7ZthFmhWRhoOGnGks42aGI6+ujubfS4g86vvjBY+R6UprS9BnUOps6oKuB8I+X+hn0b1fN5mFyWL4nsX6p+wWTlS00ngjhIM6x7+9Z8TU+jOv3tIXS/x9+UTAgLERh2wJqJv4snF3qpztYh9uwM9tFuq7AR7ZOQtlrx7Gbph16hpUzTA2sxCuSJS5J
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:yonA6aWJGiQPenuI+j4lywBfLpHr08BWnQTzZrYCmO0/ZiPT0B582dLmOVY+4pBjNP9oKNsCkxzMtFgJBjWIFZUCRuGXPuhwze9gR1vNHQBXw/vTjk9qGT6WYSwfW7rDzSOQgHZmBFgyf20b1NpIkA2zix9NnU1y4x1exqqDzxj0fchdg93urQI1ppkC8yt9ToKuEYZNcvE5sYpSDah9x6jEhiyf4RNrnIQ5Ga97oRWV+Zn50ww7KScSsgnskLW0w07mU0JZuLWnvpCqPe3LFCQnjbDDU3xToykszdSJiJsKmZdPOGFS+VsNFDFcLI5z9DDybRiFYm7AyUo4fOun/7zy3Jkc8C/9yW4yQqwLvP/Z4qi+rIKOR+k6DOuG/XN3yPuSuLO54yzYzkfk/W1wDrE15wwxkbjeMEZoWdG63Owh8nvclvWLA937lUksCpjOtagSgtvJ7HnpJK+mAMxPYA==;5:91uy+GMoYVN5FYJW+Dd1N7Tjl1obBlLhFbJS2i8AN4BtfwTDMn+wIBi+g6oOi82nyQJwvZPj+l5CQFHsSQ2zXAryjKHkniVGFT4j5S+ZJX7C8CGuONwF8hAso9NshZN6PQgIRXm1YmUqTwtAwprHvosBb1xzO/El0OwtAwEB8VQ=;24:FukTHbIwPHz41ivM42p7li+UxVNG0ZIvQI/1ijkNp8lGdsa3quJ1i0OmFnHT8hlhO6b+abJ17JOEarb99LO/dj7bxtPEhtWT2nWnzSca2K4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;7:DunWzQ1HRSShH4188NlWjRVcmdUAz1It/Oz6ud31KWDnphZve+UXQJGcIW5Uumy/7kp7DCTYa5xLcc37z4dbbzvYk8fZPBo84/eXBVwx9OBHI+pRontL5Jm7W/bjhSm8gh9mTJv7jsfxbxyufnqECit/6ak+mTIc2GRg2N/DFFCDNVRj2agH0tD0gnkzmWimeD5r67qofNh5oI9BVbFIjV3k+Htsn4vgDv62bo8l7HlyErw4Mt8LtlFkt0hXeOlC;20:yHJDkUJ1oXhAmjBcHaZuO5GNH3AFyjB2aHCo0EejOXpaRXxzoXA+iJ5aUznT406G/PUUeJga50CHJ10KPf7EC3cRcX3neE7zLN2VMflTKSlnFWnY9KZ+uGASMawWMcwl7eajVNOxNMB1ydX286LBUJ+QG0ysyduwvFkDloNbeV4=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 16:52:08.7304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf4a1ba-6b36-444f-8778-08d599833d3a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While preparing commits to be written into a commit-graph file, compute
the generation numbers using a depth-first strategy.

The only commits that are walked in this depth-first search are those
without a precomputed generation number. Thus, computation time will be
relative to the number of new commits to the commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 commit.h       |  1 +
 2 files changed, 47 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index d24b947525..b80c8ad80e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -419,6 +419,13 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		else
 			packedDate[0] = 0;
 
+		if ((*list)->generation != GENERATION_NUMBER_UNDEF) {
+			if ((*list)->generation > GENERATION_NUMBER_MAX)
+				die("generation number %u is too large to store in commit-graph",
+				    (*list)->generation);
+			packedDate[0] |= htonl((*list)->generation << 2);
+		}
+
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
 
@@ -551,6 +558,43 @@ static void close_reachable(struct packed_oid_list *oids)
 	}
 }
 
+static void compute_generation_numbers(struct commit** commits,
+				       int nr_commits)
+{
+	int i;
+	struct commit_list *list = NULL;
+
+	for (i = 0; i < nr_commits; i++) {
+		if (commits[i]->generation != GENERATION_NUMBER_UNDEF &&
+		    commits[i]->generation != GENERATION_NUMBER_NONE)
+			continue;
+
+		commit_list_insert(commits[i], &list);
+		while (list) {
+			struct commit *current = list->item;
+			struct commit_list *parent;
+			int all_parents_computed = 1;
+			uint32_t max_generation = 0;
+
+			for (parent = current->parents; parent; parent = parent->next) {
+				if (parent->item->generation == GENERATION_NUMBER_UNDEF ||
+				    parent->item->generation == GENERATION_NUMBER_NONE) {
+					all_parents_computed = 0;
+					commit_list_insert(parent->item, &list);
+					break;
+				} else if (parent->item->generation > max_generation) {
+					max_generation = parent->item->generation;
+				}
+			}
+
+			if (all_parents_computed) {
+				current->generation = max_generation + 1;
+				pop_commit(&list);
+			}
+		}
+	}
+}
+
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
 			int nr_packs,
@@ -674,6 +718,8 @@ void write_commit_graph(const char *obj_dir,
 	if (commits.nr >= GRAPH_PARENT_MISSING)
 		die(_("too many commits to write graph"));
 
+	compute_generation_numbers(commits.list, commits.nr);
+
 	graph_name = get_commit_graph_filename(obj_dir);
 	fd = hold_lock_file_for_update(&lk, graph_name, 0);
 
diff --git a/commit.h b/commit.h
index 3cadd386f3..bc7a3186c5 100644
--- a/commit.h
+++ b/commit.h
@@ -11,6 +11,7 @@
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
 #define GENERATION_NUMBER_UNDEF 0xFFFFFFFF
+#define GENERATION_NUMBER_MAX 0x3FFFFFFF
 #define GENERATION_NUMBER_NONE 0
 
 struct commit_list {
-- 
2.17.0.rc0

