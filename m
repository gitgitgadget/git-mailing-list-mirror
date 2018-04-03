Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCD11F424
	for <e@80x24.org>; Tue,  3 Apr 2018 12:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755490AbeDCMBb (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 08:01:31 -0400
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:22187
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755371AbeDCMB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 08:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RLzLidXiU5JAJnv6kg7l/5J22OgtTho/M7zDwClrcHc=;
 b=QViqfjRKpCjXKmkyR/v4uOS7SbCVvXueHTJviiMMTDG38eOiGUwfnvIJCbitMVsKhNDBmJTu8d68gAGmYdiGKa9K4xG7gmZmP8MarB0txKF2qXsOUePjzkt14e02+8JviL3K7eRfvfLnLht3RcqeAPqzROAP+oo2+IJk4KVy+Ds=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 12:01:23 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 3/3] commit-graph: lazy-load trees
Date:   Tue,  3 Apr 2018 08:00:57 -0400
Message-Id: <20180403120057.173849-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403120057.173849-1-dstolee@microsoft.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: DM5PR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:3:37::11) To MW2PR2101MB1019.namprd21.prod.outlook.com
 (2603:10b6:302:5::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74a627b2-a667-4b4f-6f74-08d5995a9f5a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1019;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;3:h5EuDUVVeH75l8pTX5YSTnN4ehFyIS5oPT/MXRCVhq21lj/fPGVWiNT7Sb3NGq00rSdp7vNSku2LLS/solZuDH0xhSmYeRzmHPFqsfFGQDiZZH0RTEIu6NoBvKspXfjuRni3jt3N7BmoWmS4YPvtfKdKHFOqcEmEbQyn6AxLSorLnONYAJ8SjINyAhPeszC7yMjzHJz7r2tugibvWoDwS6OWCrHtOdiYyAQY9648BRLbOtINuRsoXlcxNi0Uxl4v;25:3icDxmDOTzcm5HzTcxcHPKSakeZ/wuzIEoNFsCgjW/JXWXwcoRcuXM1tHQpI53oxqRJ6ZnRKJHTEmca0fKSf5hI6GwYOpiSzQu2xbu5MBalVEkhxRGZ7tiv1fulVrUYWh+WHwQPlYM61NBz/0x53LvTHUtKZT99EJUryH4WiwZmv16+w0JyiLTNuv0qjW6M8EHYD6xqslYMNHgzrUUTmN+F+gO+MmQ1pMk7Eb3Mkf2Y2E7Il4GvXtibtKtsQ1w1GFq3MmEumkGRKzIWlpZV7lJVmKw09Hixugjzpgj7kcwTyso3bjVElVkXQywF0EQLLv6bbn3RpkW+iKbAxyDSq8g==;31:7JE1cmmaSiTNK18p9w5zvMlUBw7yo2eSC0BM5UsWS70acCW3IID/Gv8CSVvW97obWLJiAJ/A0yBsZuljdpVg4jMJ5zPbDsGzZoJ2wHNYj4qxRxIBfhajXLR0fASGL/ISPlsokYhcNUF6k1ZP+4qL3frv6pNYfF1I6xnfxvuH8XCG7W3ndPgpn0jtX5lClvEjmLaER5y0bOWVc2O+CWULl6PEvNKMxll1BH8rpm+qK7k=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1019:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;20:3mex77A/2iwAftoMOEQIR6y0/trwX9S4ceYXKitCu2uaXNByswotqgbKZRSRtDOKmFoCg7v/Gp9dLEQ2AVsv/ri79PTsrtHvUGl16VkaB6bejRTuMxgDOmFGO7gBfjh13MHJozvGEsEUdD5vnXzcm3Bv8Lbo5fiaS79sp/gf3ySqYEXOxwqHd+p4rcB20+bEbFg7UWRc2a7xCYlj5Wz49qGEM4yotIwGyMmCje7+VsNVshH+ydCRzUNO52UKwhY6zvCqczM717K+/EDABiIwS/hfBE/rKpOec4nVIa/uUXwlW0cdPuzBJ4BkFsVXKMpRWEhl4VqZE857gVYcHn2p2FZxUM4gDQd+S+G1BibJm43DBUzD7zA+hKTEfPwNeKp/7LZLnxndasb/uXmISlScH9Uivti98KeEIR192+0UqM9bNKmlDlQNXvV9OVtsFkq+BeiBrO3bMCs+JLWg2iekVWk10bwR2M8arnN81aO7pXA3yD9/In77baoc58NZYocl;4:Fpzwgq2hbw3wHqqIOjuRBtLUHU0xJQygna/o9Cz810ETafautQL1Kf3i3fNxLvzbF/FvE6lDUYYdu3t1wt4pV2Yv0UvMWelVFCoBWXb3PDmqwSaKiRAT3LTtxpXrU294sdtnxSW8NrjqN2oKU1s2j8v0bMmoMrjFHNfVss8WTFbvqbYzPCjn7lsygNhTZr4hwk7/cvM0uqWdfHD9+DabWIeWb0PTcUf5iPgGMNrQlO3pzBOESvb8HQYopng3Ag9o6UIxjSj/6bSZeDc2RfPBw4Kw1Eu/2lO1Nmq9tHuRxMzP2kPSqlntK2kqVHtt1lcavMNJz34WCP3RbDx3NPwNOatCRB048lVLs9AzPjR5EoE=
X-Microsoft-Antispam-PRVS: <MW2PR2101MB10197CCDB7F4939BAE1D7195A1A50@MW2PR2101MB1019.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1019;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1019;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(189003)(199004)(47776003)(7696005)(59450400001)(6116002)(16526019)(1076002)(52116002)(50466002)(476003)(68736007)(97736004)(486005)(486005)(51416003)(11346002)(25786009)(106356001)(186003)(6916009)(10290500003)(6666003)(76176011)(52396003)(386003)(305945005)(46003)(7736002)(16586007)(316002)(86612001)(48376002)(2616005)(50226002)(22452003)(478600001)(36756003)(8936002)(81156014)(81166006)(39060400002)(2361001)(86362001)(2351001)(6486002)(10090500001)(53936002)(8676002)(4326008)(107886003)(105586002)(446003)(5660300001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1019;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1019;23:DFCU6zcnETW8xgqxkWi/JhZPNGYJjWPwl4LrcsP?=
 =?us-ascii?Q?LR5K55Jnz4avUcLrzxkvNZpCmykeiABypWc9Pyxn4IKizvsK+ARLiA1lWSAE?=
 =?us-ascii?Q?qhsH85fIcbQgL8HNC9gikaS+VHbYcTSfE1Yx9FbQo6zPpk109NWyBOPIiUKU?=
 =?us-ascii?Q?LnO3VaTz+2OvyuRRLmPvX9QjtDZUCqcd3tY3VXpfxMAr7ZXO74Cqqq1MiZbV?=
 =?us-ascii?Q?LvFzsRQ/BiqF/GuCZrm/DPsalnniUCGnsnDBXwGeMzu0dj7HlI1lZ5y971Lv?=
 =?us-ascii?Q?ZUhElAT076E8YxJHbpM8asaru+NSgyrbp+t5QPvduUHCKbgIG+JR8sO9lwki?=
 =?us-ascii?Q?vVF1tAVeZnLmh13OWi2SgF8Nzm/yBfuO+sv7ZzEjeXKc/ig/p1vYMewqNnku?=
 =?us-ascii?Q?sPoUxSXs7VUKoZPNLhRWjmZZJCusEHal1PkBI2M0Bj2NKQncQFPbqcfS1Kmc?=
 =?us-ascii?Q?aPH747lFev1AFpMB1kST1IbTp771EXt1k6uZX3Klkfehob8XPESmRTxmLYN7?=
 =?us-ascii?Q?STw+Q2z5pMeu14GeYMG3CdDPCZMbPNpsCOUamJT1jN7LocuOClPNJXzMoSSS?=
 =?us-ascii?Q?amyc1SwR+dP0uz/m4f0dJs0medOXgmqEV3//AtbQ438ZeG6/EqqELMiFj5gP?=
 =?us-ascii?Q?dfQARTB3GLbVpzOMl3Y8aDmdAe5DjxgHoRLgGdcDK4tIGLzqgiAJJ6WQ8/8v?=
 =?us-ascii?Q?6LEq6qtYPElpOciEMCjdOIiPCas1CEA/+Tii0npqJ96vSt07+5/ocwTw7wjn?=
 =?us-ascii?Q?aZksGRYTI0AmO8sbPnw+yT9RIIXNDOD9329DM5zu8JfgaAHbfFTzoz7w3Y9B?=
 =?us-ascii?Q?fAIqMxV1SAYnn9lcjMYzwh+3hWOIlLTsjhKrzs/uJv8XOIFrKuEQsFryorK9?=
 =?us-ascii?Q?dU/bgS6bVrtJwv2SSweJcTML0bYANdW7GMBcDMzBxS1LwSFhW9fMBt9yLrD5?=
 =?us-ascii?Q?Rg7URnvAdD/V2cfaCTOWv1uXia4mSiHiMslRD3pbInhGAgunRf7I4//DyUa+?=
 =?us-ascii?Q?zVDtPgTjDA3eCURme78CZklHV/xMThsmmXHRNmCZjT1Ss9wj0kqYRMWbNN/1?=
 =?us-ascii?Q?btN4jox/ognLxs2qpk+3Yq2mkj5hzWOeuv2Ahex5O+073oKK7WBb1JcNKbQg?=
 =?us-ascii?Q?iOmB+i4wwEeOz4tjWA06P/F20uO/re27aY7mT8x3aFni2pj0LH2gU4E8ZqP4?=
 =?us-ascii?Q?Ay98f6vnAC5rGAWefYLK8z49Lh64xjwPEYHnIfC0Xi40DF7RRGoqGIW/iXGx?=
 =?us-ascii?Q?Pzg0vYv14ctkyTlz/FVbY4cLSKW/6P7iiHAW7k4+Gr5kHgYvrR/qkxBfHdTG?=
 =?us-ascii?Q?t0MTb6saPE9FLR49GOq3bpCVa1pl09pJifkzFlY3TfaMMHIpwpizGhQKe7Rr?=
 =?us-ascii?Q?sero7yugg6vBeUTY1JLQwan+TthI=3D?=
X-Microsoft-Antispam-Message-Info: LyQSREgmAzvchnWjRreyUz3ctd24nYjLu1QoTuF2ml4Oel53Z7zFim6OQObNQYRzDwAHW7APH0u/5bfMmSyml2i880CVVX0jqm0NADrYnfZf1QrEyuVurnrZryOpu3m4bW1uYn0GYaW/umOFn3rR/6Kr77nJcMRWE6NT4llykgtun3UDjo8Y4kr6PHa/k8ay
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;6:zLpAWtr06akYmgPUPxQ+VycIU+WLyOJzhiWnJm8OSDWXhu5eFRjlBu/b6jWR9ADsgmPShSo69FnP1+PyXE5TNiRQ2LXbV/2f14mCOw3Kawff760FZLCQECPIeTQSPU/jtisBJfs7pJfj4FD5bajnkt/FDMWkR2ovHBRS6thlBPJOUfFceYpT2610uao/ulECkvw1AJpgAO8MOxhid9mTwO0LZJ2Mc/E3jiFO83kSKfZNv7rgGZznTmzKt6BBle+aRqkusVijbvHqRaTTFwIECspWhQ7DT8Lg9ZYfcO354jMxsSg04gLffSo4mvoPzS4cuHHg/lDjQ46ZfS40oHd7hWDBH+AcRkDzvVOplS2mHPyrV/NnM6G8jSko2aWcTEjbTb1aUSO8aN4nz3AbkdozJbuQmifcOxxx4uW06cBILXiLUlzYoCvtjUORfCRKr10Jb3bZbpHNBmUK8jXPc7ea4g==;5:KMZXIx1NpJnPXORvKlfALrpKKpdDl6YTUHwHBwZnvjY4S+MBM67Ek63L06NDnh2kUXi3RT2CifVn/t1fTOJfVIVVPUY++pzIuNr44SbyDmdYXTsrxQfLHZuXJusrA2VOeDiV1VF7EmS5pD59Na4XyNEmU7ALd18ZZOCRngR8sps=;24:cBaMquU+9ovjc+38uI6Upq0GDWomRXAg1n51uFG4YlnQa9+Bj9aaTG5MAax7nlcdQBkLGmJTPdYwUR3Mv903zkpQGjSD9GVGjy5RhqtGcN8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;7:tdkPvladb3fDJTsLo/jxsME/XxI3ibRerEGBwUNuIsetG5kTul4pJRvx8T+GigH/5fQyN4Uqg6ADTi5fthsT2Sp5nQrz2jobuwdgzQm1o5dhb779iCavbiAKqvLManvHpYtucsGtXBQDghi2qRCrtxBC/TxdesPbCTslaGf5PeJ2p0d81x9B3c2YOd/S8L+rZ9nLlP6kPgYcew5S+JccRqJw+bMlcTalko99hC9Lb2cM8dD4xyhwONtlHhC+aLmE;20:sgnkYYt6m9+c+fw70A+nsfNRByeAq9Qq1e42TnNay1ALDGheFyAHkdCHSH9Xw3r9Ua4+agQn14Zvs8jXQMwbdH0uLWVRD4DbZNBvosWL8ci7xtIIkfV5N5RTAa4VLLZl7xnRj1iPH2bWx2Va2Q7foS0V8GXe3BGIKcFHdLXCtwU=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 12:01:23.5685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a627b2-a667-4b4f-6f74-08d5995a9f5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file provides quick access to commit data, including
the OID of the root tree for each commit in the graph. When performing
a deep commit-graph walk, we may not need to load most of the trees
for these commits.

Delay loading the tree object for a commit loaded from the graph
until requested via get_commit_tree(). Do not lazy-load trees for
commits not in the graph, since that requires duplicate parsing
and the relative peformance improvement when trees are not needed
is small.

On the Linux repository, performance tests were run for the following
command:

	git log --graph --oneline -1000

Before: 0.83s
After:  0.65s
Rel %: -21.6%

Adding '-- kernel/' to the command requires loading the root tree
for every commit that is walked. There was no measureable performance
change as a result of this patch.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 25 ++++++++++++++++++++++---
 commit-graph.h |  7 +++++++
 commit.c       | 10 ++++++++--
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3080a87940..a3eeb25f22 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -247,7 +247,6 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
 
 static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t pos)
 {
-	struct object_id oid;
 	uint32_t edge_value;
 	uint32_t *parent_data_ptr;
 	uint64_t date_low, date_high;
@@ -257,8 +256,7 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	item->object.parsed = 1;
 	item->graph_pos = pos;
 
-	hashcpy(oid.hash, commit_data);
-	item->tree = lookup_tree(&oid);
+	item->tree = NULL;
 
 	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
 	date_low = get_be32(commit_data + g->hash_len + 12);
@@ -317,6 +315,27 @@ int parse_commit_in_graph(struct commit *item)
 	return 0;
 }
 
+static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *c)
+{
+	struct object_id oid;
+	const unsigned char *commit_data = g->chunk_commit_data + (g->hash_len + 16) * (c->graph_pos);
+
+	hashcpy(oid.hash, commit_data);
+	c->tree = lookup_tree(&oid);
+
+	return c->tree;
+}
+
+struct tree *get_commit_tree_in_graph(const struct commit *c)
+{
+	if (c->tree)
+		return c->tree;
+	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
+		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
+
+	return load_tree_for_commit(commit_graph, (struct commit *)c);
+}
+
 static void write_graph_chunk_fanout(struct hashfile *f,
 				     struct commit **commits,
 				     int nr_commits)
diff --git a/commit-graph.h b/commit-graph.h
index e1d8580c98..3ab45818e2 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -17,6 +17,13 @@ char *get_commit_graph_filename(const char *obj_dir);
  */
 int parse_commit_in_graph(struct commit *item);
 
+/*
+ * For performance reasons, a commit loaded from the graph does not
+ * have a tree loaded until trying to consume it for the first time.
+ * Load that tree into the commit and return the object.
+ */
+struct tree *get_commit_tree_in_graph(const struct commit *c);
+
 struct commit_graph {
 	int graph_fd;
 
diff --git a/commit.c b/commit.c
index d65c7b3b47..d4293ae8f6 100644
--- a/commit.c
+++ b/commit.c
@@ -298,12 +298,18 @@ void free_commit_buffer(struct commit *commit)
 
 struct tree *get_commit_tree(const struct commit *commit)
 {
-	return commit->tree;
+	if (commit->tree || !commit->object.parsed)
+		return commit->tree;
+
+	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
+		BUG("commit has NULL tree, but was not loaded from commit-graph");
+
+	return get_commit_tree_in_graph(commit);
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
 {
-	return &commit->tree->object.oid;
+	return &get_commit_tree(commit)->object.oid;
 }
 
 const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
-- 
2.17.0.20.g9f30ba16e1

