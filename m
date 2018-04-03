Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC87B1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 12:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755415AbeDCMBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 08:01:24 -0400
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:22187
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755300AbeDCMBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 08:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9/LdPKlUlKX6lFCnO3IbctFyXdk11Jaf8vPeawNwac4=;
 b=nONqqu+grB19m82gGYxwDRoQVUkcpbmJjeoKUWgkM20IPLH6+uGxdGPCfnPhxyN+RlTy3/PgPUTcZ3j3McsSJuNDtxp6ZlIx10OrlRFl3URg2fK2z4GPW+YXb5Pf0gqzTMqkQnPjrOccweB1MCeJCpH3fLP9+xGiLmD18pEJjc0=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 12:01:20 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/3] Lazy-load trees when reading commit-graph
Date:   Tue,  3 Apr 2018 08:00:54 -0400
Message-Id: <20180403120057.173849-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: DM5PR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:3:37::11) To MW2PR2101MB1019.namprd21.prod.outlook.com
 (2603:10b6:302:5::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18eef142-4c47-4af8-01d7-08d5995a9d42
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1019;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;3:6U/X1k57BsyqwQNshf/91oo2utg56UBqAOno8HlZx3CuxzD0yPFsCNjoqLhsWCnb4M+hvgMuCknzGHQeFGhxpG98r8NAqzvTi7qt1uax4mYoL1Fkvgr4NfBIDsbaTFiuIm+kgQuXBjK6NNWuRDCB4tW/eUxUnnCRjLf2FeQWkJKXT4hIBiJO7DIqLF2OPtDHkc+hmvqOWV8eIW3wwvR56wkWOC3HnHqD4jVv7gxHaH9CJbMsK9x1oqE1Niu9M16O;25:njE/tbap8XczidpgQQ6GXS1RwT4N5LyGPpYIyGek0gs5Qv/4ZMZ1265A8rgazSaE1ftebldrooDy51S1fLAY71254JAX5in1oBr+VkHpxT79OFtR3GEgXjxqEwyP5ouWzztYxHk5Y44CA/UTDSFD8YCR0ivtQH+cTPafNPz+Kslc3Q+/2cVKPyRdvo/uFrsuKmLmx5CX/oXyLSet1UlgWWOTF60FxSt5VjU7IS8zWPliz9ITLABMCHgAlid+V/U5JGmMThbgnG518KRbJ45vMkC0b3uZme1VySWbAQvaGvc9T9mvW1EclEtYtYiXTZF3RI3yq4IiNMI/S9gWscn9EQ==;31:PXFEgcnhIPIswqlMO3NM2y1HkbpWhvWYN4YV30E97hQyj7hkYTLL2e4ptXd2dFhwyj5y1DshVz+tmU7J21iof2Y1TexqplpMRy0BcJ/51nApc7gR+is2hybnw7lFoCoRr5qmKSNj6fqp1HywTJlASYBxfhsfPjG5/Sz6VrpCIUloZjrNpFGk62BbhJVkCxA4Z5ygnu1xy7cifUz10IHrHahHBSYMJZgchdyVdrgP/54=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1019:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;20:JBVfa357VYAncfeIza1S8dKotb8drHy5w6tMIw3/IY6WI9ASiG+u8w/mkTYjb+/dFrG/gGm9YTjdAy0nvc1flDY9vWXa9OK1d+ODHUXhj98iGwQsXaEcg7PdgnjCnWGqoyPxW7Y+p7wOeZKk7LC/o5zyKpqRLDdC/e+O1gbQuYfb8+AfLoQa1WIXZySt1jDTdpftHvwDIel7rouPtaYAxC9ZYVcaYV1rJAbTnQBD7tOXjMX0PWTLNOyfbouEoqdj0+FYXKZTasVlmsZfcRKKF1BqN1KiuUfIt1ch87wvIVCODbLgiSGRkvtp6TLL6+kwLNP7/jN4j5MBRCgYd0ei69KuLFpAPLIYIPKtUF7SV56Sxn/9E73NHnLdI/PGj1otovk2qLv2wzNDQrMDKVyMba0h22+Yn1vXxwuhXAl26F0J7yF9kPrfgEUYZTiyYJH9NP3wIzgRN5EFxGe92UyjBLDUlmNJE8AWu2J1luJB375OIRU9gaEgAlpZt1tf39Zl;4:VPdsBeWqBOdDYU51jucs3Pc5UmTIc5YUREewnZIHTGdU0PMuvtNH3DtPYVqgTXNO+OKNlnlyzbPfvW8dcdVG6M8hAEXZw6md1ZD9DQ6aFO/M2gYFkVpGSHUnsMJd6gvg2ttPfbVtW5JcJab5gI9zFgmSpVjxuLG+xcOThvQCbLN8PvNyKlUQGi6NJmW2tN/BwoFs5lcsBYecmzvnBOefm1WRNgMLMvdU6ik5rmgQ/SfpNCLvU5XrRz5KeAoow4IH1LH8ATIZD9nm7xdzcOzsPw==
X-Microsoft-Antispam-PRVS: <MW2PR2101MB10191D9F9774C36CA004EAA4A1A50@MW2PR2101MB1019.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1019;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1019;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(189003)(199004)(47776003)(7696005)(59450400001)(6116002)(16526019)(1076002)(52116002)(50466002)(476003)(68736007)(97736004)(486005)(486005)(51416003)(25786009)(106356001)(186003)(6916009)(10290500003)(6666003)(52396003)(386003)(305945005)(46003)(7736002)(16586007)(316002)(86612001)(48376002)(2616005)(50226002)(22452003)(478600001)(36756003)(8936002)(81156014)(81166006)(39060400002)(2361001)(86362001)(2351001)(6486002)(10090500001)(53936002)(8676002)(4326008)(107886003)(105586002)(5660300001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1019;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1019;23:8kzhRvR2S7eTSqkzIkm/+RHZNrr0kbaCVda6fJa?=
 =?us-ascii?Q?J3UyDmXUCwIvcX6KBdrwPAT4L9v17KO6UvDoT79vWsq9yxhH4tDluK2pCnVX?=
 =?us-ascii?Q?CCP5YImvpZgkLmW7asg1W47pPZ8NeXjxWViE7phqG7KHFPQ6o7Nb06XXcmHf?=
 =?us-ascii?Q?bJrRtPjx0WbcCwNqB2fUc5PibPhvK7OCqYmrY5WPzuwvTHni8iYbkxmSliYm?=
 =?us-ascii?Q?yNqsnRF7OWUpqtlpssDwVdrIkUaj1/16pTUjbliFGQtER50Th9fWZHXdEiD7?=
 =?us-ascii?Q?jgIwHgA/cLXk0bxEIy5dvebdPg8k5srVuZhOQajWf4erLyo4XsNmSkXTCKAA?=
 =?us-ascii?Q?Z7Qmv7LxGz0LATOKayA3P8t585z+Q+SnBxsyYajF10P4dW9Q/181HapIuaAy?=
 =?us-ascii?Q?J3t1qd3fGiDcli7vJadI4raSRq9GUa0LhG2XZ1b38S2dT0pa1RoedmMtEY5h?=
 =?us-ascii?Q?zbJOmup2DNFblwAeVS+V06I3TROXANzlGYMWzI8J9DBfTBZ2cjqQkCdBqqvX?=
 =?us-ascii?Q?aHAoeQ5YMGRic+ZnEpXxrNy6SGPAah1AvB0cUdrMz1zlyduPRYBZaA+NrfzB?=
 =?us-ascii?Q?QQIhk6NlqgB4y8RcVo4WGyEXHuGGxbiclgGvgkKeDZrCZFx18HriZ8LDGRjh?=
 =?us-ascii?Q?u3Sf3Zdhf9ID1oEy/93OAhhYmjyK04fHR0U/XpJ7V9Y/kUYOXbsKePahAP1q?=
 =?us-ascii?Q?FNwfVtIyT0tylp9J03lsUtWNVz8jpMbOM6QabC3pDpNonWoqt7q820e1+JZa?=
 =?us-ascii?Q?Uc1afF90c4K0A++2YQy/QOWzkLu3GsJ79gvqaMCcwnMl1c+Wl5xJKLXxNzJU?=
 =?us-ascii?Q?Bs844e4akqq1JTRFlYyvC2d2bmA2D7uI/WYkdXu61boWDsHLJBz2TC/iBYBy?=
 =?us-ascii?Q?NPqgOzUJ+6Crd9QuEHAeA8h/ezCnmqSJ8xVI/ENK8+PwrZJLeJpWPtUIllHz?=
 =?us-ascii?Q?5GuGSmd+FsYtlzmZTo0Dpa/bgkrkc0dKuxp6E8SAxXj8vOnydiU7eoYZHxZv?=
 =?us-ascii?Q?zRdGcU4YTPU2nw1qHyHGmF+8oEY5vJAtXtQmjj+6ipmKe49EcwE34iDZlyAz?=
 =?us-ascii?Q?PxGmtTNNDARBky2G1eesv5GzPpWdDnaVZbQKkIhZPqCZyW9churet8D0rOwq?=
 =?us-ascii?Q?8wfnC/4tDouVWGk1UQEXacLBSAft1JwppiK+PO3ycZaUJI1A2ThLgfZpdgMK?=
 =?us-ascii?Q?Y8Z+hUCzp4swOADC2ZkpOcR/m61zudyAdvmxX6pVTwDIls7DVtJSXmmFMDzq?=
 =?us-ascii?Q?9eS56j46l/wFuH4GQ2yTb35NvS/CEIVsZoOGg9GuEbEzGQ89+4nwQBR2Jbux?=
 =?us-ascii?Q?3UvltW7Z0i6AbWSzBTQEvC9I=3D?=
X-Microsoft-Antispam-Message-Info: t4pat7cQbvLW5RNH3HRnksOcpn9iTdvMeyzoOTqyP588vLFN0PlR261btNObU8Rq4qY5THpaA3aRaOjrZD0WMXFF5OtqkxxMZrg1m/gUs91tBE+H1c/98Qy+X4b+7lpFQcyW1Koa4HcLDAd+uG+u+VrbS1soh8OIXhj6nLCbgs5Dq4lxUxDydrRgpeCrOtNB
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;6:nAXOT2M8ASyY1Lua0JsyXeCvZHddI7e6oyY4XLbfHF+SlGXfHanjkcN8owah1Nt6FR/4d6EsJkamcAvGJsGzt9fOpnVgvTy8nZEeA522alB9+ljaurOfJcgLNhQN9edgMBTHnmDOnwiMgfmdqAGbexdOUkdGIxDXYJtmGbAzLT3ixWxth6lu0JBUFtrtAYQM12eAsjrCMGo3CnrlsvyOTtN/LJeLLwvAzdlwNt9/kuhtbmFx5Gt9i2hCj2vH4FFtTsjxezo/dHCRUWlSbSqH2XcujWcxwGP+1z10Df4raEuQSp53Q7hfSbhm24Y+mgmzuWrz43nGqMW0aiy5J6Q19/RWqxYw9d9YfKtAHvGBVZrVF97r0+3YxyZWF6uUuwYYDdxWj8edjE5imAw9FU7pyrzvMROEflW+2snc74W1N7WCM8AAs63EmqFlgoQ/UfSZdzLVPBuSdZfh+qYj4HudiA==;5:ueZgw943NOVsb2tbEVd1afaRngwoyxVooajhzHEbfP7J1UXfki6pcGiu4lZuOsOGNEt4dgvcmw7qrZ4Y/T50hIafcoziwaMI2hWvcv/pE1e9IChrXm4co51gC8T6Jp5WdqG2NXa4pP4Tz86d1Uz0jtXCcvBbVLaPc0afS0LDgA4=;24:Y2lFu0YzPManCW3RYEMUuhPf1/yb8gbfzj7vLPhYC20vzCNQJG17cytQaYHItLStyPNDFnhw3QvLubYUXeRupne5Hh90hc4v3mgIBX7p/lo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;7:1GqlV7KXGZyvZ+45UrDV7Wh5OFyfCnA318LMxuYljpRSHm+AM2+uyNg3Wt7pLG0wF+RDJLsTlwjuSw7ieQGIE9O1xQzMN7m1cdAseDWhnziVzJJ0sAKBekUw6yJEmOeU2EHNo2/qoWpBclfG76PHael4RTiQVYtleeABRkrTzBKYQFZ3fzYsZEmLkCJ+rQQf+okFKvAj7uT4elnyWIYIbS+OqpMhYqKR8K6hK3Vakl5Bwjc2HFgeYEqD2zYy8Wmj;20:RKwv44CR8nFI3JtbgB6g9t0KJrnpRTkSTTw5FcYz94cRbsKzzcb7B3Vu3Snb3/Api7P5NpHnloDomgHccZSD0fCW5F1gyGkiuZ3u2U7HFGYG9bGQoonZSb+ZlKm7TYZEBfxJ2nMXkT3giaUol4KzB5YyAwhzOroYXkLyfqa/dns=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 12:01:20.0529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eef142-4c47-4af8-01d7-08d5995a9d42
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several commit-graph walks that require loading many commits
but never walk the trees reachable from those commits. However, the
current logic in parse_commit() requires the root tree to be loaded.
This only uses lookup_tree(), but when reading commits from the commit-
graph file, the hashcpy() to load the root tree hash and the time spent
checking the object cache take more time than parsing the rest of the
commit.

In this patch series, all direct references to accessing the 'tree'
member of struct commit are replaced instead by one of the following
methods:

	struct tree *get_commit_tree(struct commit *)
	struct object_id *get_commit_tree_oid(struct commit *)

This replacement was assisted by a Coccinelle script, but the 'tree'
member is overloaded in other types, so the script gave false-positives
that were removed from the diff.

After all access is restricted to use these methods, we can then
change the postcondition of parse_commit_in_graph() to allow 'tree'
to be NULL. If the tree is accessed later, we can load the tree's
OID from the commit-graph in constant time and perform the lookup_tree().

On the Linux repository, performance tests were run for the following
command:

    git log --graph --oneline -1000

Before: 0.83s
After:  0.65s
Rel %: -21.6%

Adding '-- kernel/' to the command requires loading the root tree
for every commit that is walked. There was no measureable performance
change as a result of this patch.

This patch series depends on v7 of ds/commit-graph.

Derrick Stolee (3):
  commit: create get_commit_tree() method
  treewide: use get_commit_tree() for tree access
  commit-graph: lazy-load trees

 blame.c               | 18 +++++++++---------
 builtin/checkout.c    | 17 +++++++++--------
 builtin/diff.c        |  2 +-
 builtin/fast-export.c |  6 +++---
 builtin/log.c         |  4 ++--
 builtin/reflog.c      |  2 +-
 commit-graph.c        | 27 +++++++++++++++++++++++----
 commit-graph.h        |  7 +++++++
 commit.c              | 16 ++++++++++++++++
 commit.h              |  3 +++
 fsck.c                |  8 +++++---
 http-push.c           |  2 +-
 line-log.c            |  4 ++--
 list-objects.c        | 10 +++++-----
 log-tree.c            |  6 +++---
 merge-recursive.c     |  3 ++-
 notes-merge.c         |  8 ++++----
 packfile.c            |  2 +-
 pretty.c              |  5 +++--
 ref-filter.c          |  2 +-
 revision.c            |  8 ++++----
 sequencer.c           | 12 ++++++------
 sha1_name.c           |  2 +-
 tree.c                |  4 ++--
 walker.c              |  2 +-
 25 files changed, 115 insertions(+), 65 deletions(-)

-- 
2.17.0.20.g9f30ba16e1

