Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9E8202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbdIVQga (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:30 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:49189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752519AbdIVQgR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LHoVoOAwA5syPmiKhLMUR2XcislNC7EltJxOoXn7qlg=;
 b=dwJL4RtudaAYhvnjiHuHWTQNO6VbEs6+N2Mh+TxWGITunQQaIg15pSUKh+bl1ojSbWO6vGCUwemxnqJXqEGrYkzvXUsv7NUuGRSYe97smSK5dEedipAtkrgkd6x3OlIhopaMM3w4tg2aFgbKwGQj4MdODJmcYrD1k7mItrey/Q0=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:10 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 04/12] fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
Date:   Fri, 22 Sep 2017 12:35:40 -0400
Message-Id: <20170922163548.11288-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d9ceae1-775d-4cf0-7715-08d501d8085a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:uMHKrtCzTDFtq/j4bPk581g15gArxhyTa+ZcRJjtu9fW7yjn8GSktl2cHTigXTUh+y5QMSLPXnDbpbYG30A5FYDpinF2y2PJUlPvkwB7V74mqud0MC8zeBD3bG5qwByNnnvC6JMq7d3rv37KrLXN0zrjVUgBPew9G3m6b4xAhJpeWRO9KTquWs2gunRUQms0aeg3Bn1VWp7qJoiStRFqoGsrDGUwd/3bLSm5dJE14xtNG/oi/Wmo4L1w14D7Vcjs;25:ZeSVbx56bCJWMxhdha1QQ2EQgT4J1CQXKkL/jojENOoTLBTCbRL1qYrqF40MWjm2NuyyxryBRr6fOvhjbK79OlnYoJA2IBP47t36/TLxd74OqHADM1JxR6QpqTMtg8ZF93LU7D7gd5qHgfXy8LkuU/l/ivg5eHQugSUdVZon2uBpwynSa12QPVuCvcQC45ugoUnD6iZXCOgpMUo219zcW0YSO6VP9mRcrdzoJYhqMwj+xMrfnUEEFxlmTAPP/j7QrJzxx+dgx9/7K0MzQICv8LwCWq6Xb7RAmS09euHAyZ4E9sZiwgb30X4kC0fN0DcfH3FEzDq5CaKEDDQTe4NeVw==;31:/ZGEUrFUNBIaprNE6IIneR44Nm7vnmGrvNzKwd9yEIC6yZ098zstukQG60furyL4jKaXv9eTmQ2Jjg9ao/SOpseYsVf2SBrPc0/UUK3M5mbLBSdgwYzu0TiKesuQDM6vfwaVpxWADae6p3S0/bq6kwFKSAUnQd9VRyyJ+RrkoBCHo6ByBayimDh4vOkBO1/ckflGfFYmUMv6QseoM2qri6m2pK1TOdg+GmGL9rgifZY=
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:GsqCAiW8kEBV2VMjC+TTnOMSa31ndq7i8FcvDTjkzOcbiWt6FD0Btl//2ihxyFuJ230G6fv29G8kXPBVxuefhjrMdiXa1MeHTZyDh+uRJJyld/QqV+n7XIKjrrQv0OK562ykYjfeydNPmM0NUmzNzM6T2xo6HE0p3aVoP9Jzswsx1Fu0a9UH3KCeIW1+/sqEwz5FWvXBSyXtB4Vt9CQVlH3zMX9DMiAcO7f682au8n3M9XkbI1UlcTLSI6fjuOB3hcfa2KosEHL6Icp3fhUf59kmkPmZZOyqWPQluApNMRFeIseW3czXiH51d1mLF9wmjf57NRURSc7Anz9HWlaN5++DO9Txg4mkAs/JB7tAKrYtzqRPn7QErtaUsm5UHDwHYb88c8N0Diqcwt6DZ1u0ddXlnoEhggT81D/9F9bXjrsE+kYJYGCnYOGkYbwCqOGCw4bWCH0UXmJfBgCRLsDejdq7PRceLTIR1FeRBfbmJfwOlpRqBOTYK9CUdU1+up3u;4:j4O1ennlSEbZf5jbb7mczOTkj5HpxmLADzcuxJ7wcz/e4t7BIev0xB6s2rvijF4DOhgfPvByGNzbse20gFga/iIBc9Em1j2Zl1CHeVSgQgzBaiaUhj+Q7FbddOcImC+pAHQ4SZB2KcDCIcPflz8KIHe0Es7ve+AdapVFOaIdK+exuPRL0Xv8Bd/cJ8p7CNcQ4HV+qLVMoVAcYApAzsurzIHPfyAkyLcu1ToFRF4+a3lWKVvQZTKFt21xqejI6+cUmikoWGoclLvNkcrM5ksOyg6fLuEZJVlDrMYp4uXv3jmw0W+K00iQofFXQy7cGPV89vxuqFheD5l/ceuQJwPKGE/hld7cx3wJvHqLSgLbbYU=
X-Exchange-Antispam-Report-Test: UriScan:(244540007438412)(89211679590171)(788757137089);
X-Microsoft-Antispam-PRVS: <BN6PR21MB04664B2A14D5008600D1A7DBF4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(575784001)(68736007)(76176999)(50226002)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:T5Nvh9upSTL4rAuP4iAW/5gRG3RFRZmo6HVFcrikS?=
 =?us-ascii?Q?4YeTwGlUOCF7BoAINZcB26S212R3hVj1HBZJH9XwXpDFWCCOMW2ofkgTGDfJ?=
 =?us-ascii?Q?tDLTAOMPvy3Uek4m6fh5WS3vsXzQDQvBaQ0r8hJhhisAHXcAXJwOjjjwIUxL?=
 =?us-ascii?Q?yCtMqSU7kBj1bRP2FQ0iTs0hTp+16Nug5v11Mp7bvbmH3uWVd/Gux/CaZEUB?=
 =?us-ascii?Q?8aFus9R/1wXMrCZ/9E5OR5VkhdycNJRMykFpOF1QsTXUAu4ffKCtAaeWf1kE?=
 =?us-ascii?Q?cNAa1Npa/FcddViTwuL2VTFa/puVn4QGYMkr0vh+gtEiYX5uEvphJ4T05btI?=
 =?us-ascii?Q?H8LtzqhH7szsqD6qlHDTI6Ig6F1hOXqe+7/WseVmcCfjmTgVEYlwSCHiVzGA?=
 =?us-ascii?Q?ePhC7BcH9od6G83qEesrogFVzaqqkbxDewcb1AsEY7JWSDXFRR5YUSxBblKj?=
 =?us-ascii?Q?L+YbyR8RgjeCQDRRANwSOiLqo0KWtnNwVQ98OUeykJxHw6Jud613IH3Qs4aw?=
 =?us-ascii?Q?O4Qi0Ss8mOS1lSsvK3TjBn6IP1YVM77iTkdg5N7WZ617UX2huQFqK5R3RrYH?=
 =?us-ascii?Q?xaPFjfCpcBPmjyBL+NaZibOTabrsRj/+LIff3ws/JCv7OsVWqg3t3PCERe/z?=
 =?us-ascii?Q?zF5JvbrStnJxu2hKCNiTJCAjvDsqIY/fymiQ8vd1I2CnF/Js2qXiwZnrFQZ7?=
 =?us-ascii?Q?+SBDOAIhZsriKnFzOc4xSOMdD65G/oUNBvKE6r94nzq2FzdxUAMIO+5QN/tg?=
 =?us-ascii?Q?nv1yxRuH6g5H+yCMF+/QcMEhhmRK/tfw9QUkD6XAJl95V83hCRmhk+m6AT/Z?=
 =?us-ascii?Q?lTTaPORefqS3dwQkHRxRKVxiXcE9blCT3lXTBsjz3orsNXM+DVhSKBLVWZMN?=
 =?us-ascii?Q?s1ki0ylfZkzZa1DB2eNDsfjcm/7N24pm9dCq6wvszSOp6B+L5OLWvdSdiEYT?=
 =?us-ascii?Q?YNp4oUi6MH79wIiV3X5tzhXQshV8KIdZXcEQmtmvWF3jRXf3XZm44HnccM+R?=
 =?us-ascii?Q?I5Q6+2OdponUJpUbYGwosuvVbH/hDtXGfMyccZHuQ/y+nSWre+rgOJ5/7U07?=
 =?us-ascii?Q?OM1FMzlzQHq0bw2Oxrw62od7pJ90j/KhAiF305XkCktE+8HaEoXzGfWF/XND?=
 =?us-ascii?Q?DjfrAY84wGgk55b2eEJtuHHxvZrTGUUYhTpsxY5MlTTyQ7pAaNezjO1KZ2Fe?=
 =?us-ascii?Q?VMrE5IZXL7WCPxvTf16S1l0Mu80wPh2tdshUFHQHVqvmlJyIUoQG0vswqtQu?=
 =?us-ascii?Q?maTGz8Pbcgfe4RMT170Js6aEjRZ/NfDyiW9S1UZCSKyLYG/0ELfVada0+6xf?=
 =?us-ascii?Q?NQLXztYP7gwt6k/ag0SATNDhWg2CDlNvNiqov7Mv1eSWvUAWEY5Tlq/FxXJ9?=
 =?us-ascii?Q?JC/fJ1C+kvy/q+ortmdp3OFIEPLSuzaCdG45SgGx1q9Chk9xn1cT/M7TyEXS?=
 =?us-ascii?Q?XkGEWolgjuI6E7bfVjApOefs3uas5zAyvIcvHdF2kQeTGGwZ8YCBD5+HqNbF?=
 =?us-ascii?Q?dS5jDZOsXyQ9A=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:y2nQPfDrgycd1sU+GFO06yho6Vq58R1Zh0IR0mQ7Fw8pLFZvmdyBJSNHcj0bOLTi54HKRn2q+SXnCJ9E8yXL9GmjyM5iSVCR+trGQd4aDIR+n9qXIKXoVvdyK05zApzxva0y9JuKbmnqsubzcz3zjeujWkQAyv3mzhXVDpDQLyzHPtyciddm7IeTWWMr5ZFALpGlFlg/9NJ/gOjf6lNW4AEGyd6z1+5vX5/drQ2haYIqY4bmz7jC4df1MoFiaXKO+kGz5s5lcYRZgyc3o0frHwXM28V4/84/vMuWtT+yRuWF1fIFSnzjb1XBDthvjtk9nCPKJgpp864m5RLEHqeyIQ==;5:Js1nmVypni3q0MTChsaUvVQz4ciZhjJ7n28zSgZgR45wla4Q3RfrV3XImnIPFZ6YGA2lzM/rdFyyZ/kl30mslsCvjxJdqZD4/UZz5F5LpNjI9dxvi66QisSbmmE2OUiG6h61sWyuwZ7/Q+OHnOfQ3g==;24:CZXHB0e0I3OYleGx+XUevIlyvP/MmDype+s8LMdqvH1wH6rAIwLBFhNPckMHkVP1gA0tADX0pJRB+2rHPmQkLKbzciXsHEByaA0nvaBoEek=;7:9simuqOmgLxiGOV8lq8hV/1d3hCFfMNKQpgMOKV/CdAbTp4wz+a52Zh0zwp6cJGw41jebk4qvWio2TlBIYWVXZfTlCOyLFlkh5GpLfTsTC5mSRFJ2bGYMR6cuUmS8cST0pXQAM2BTujFzTwb9xEhW9/S2SpYMwuE41DrMoQLBL6b5x0OnSt9KZgwo/nbG9tph7P7+rm97sx62vnBjq2llkfBPvUuAFXGjn+KDhM93xc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:10.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the index is read from disk, the fsmonitor index extension is used
to flag the last known potentially dirty index entries. The registered
core.fsmonitor command is called with the time the index was last
updated and returns the list of files changed since that time. This list
is used to flag any additional dirty cache entries and untracked cache
directories.

We can then use this valid state to speed up preload_index(),
ie_match_stat(), and refresh_cache_ent() as they do not need to lstat()
files to detect potential changes for those entries marked
CE_FSMONITOR_VALID.

In addition, if the untracked cache is turned on valid_cached_dir() can
skip checking directories for new or changed files as fsmonitor will
invalidate the cache only for those directories that have been
identified as having potential changes.

To keep the CE_FSMONITOR_VALID state accurate during git operations;
when git updates a cache entry to match the current state on disk,
it will now set the CE_FSMONITOR_VALID bit.

Inversely, anytime git changes a cache entry, the CE_FSMONITOR_VALID bit
is cleared and the corresponding untracked cache directory is marked
invalid.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Makefile               |   1 +
 builtin/update-index.c |   2 +
 cache.h                |  10 +-
 config.c               |  14 +++
 config.h               |   1 +
 diff-lib.c             |   2 +
 dir.c                  |  27 ++++--
 dir.h                  |   2 +
 entry.c                |   2 +
 environment.c          |   1 +
 fsmonitor.c            | 253 +++++++++++++++++++++++++++++++++++++++++++++++++
 fsmonitor.h            |  66 +++++++++++++
 preload-index.c        |   6 +-
 read-cache.c           |  45 ++++++++-
 submodule.c            |   2 +-
 unpack-trees.c         |   2 +
 16 files changed, 417 insertions(+), 19 deletions(-)
 create mode 100644 fsmonitor.c
 create mode 100644 fsmonitor.h

diff --git a/Makefile b/Makefile
index f2bb7f2f63..9d6ec9c1e9 100644
--- a/Makefile
+++ b/Makefile
@@ -786,6 +786,7 @@ LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
+LIB_OBJS += fsmonitor.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e1ca0759d5..6f39ee9274 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -16,6 +16,7 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "split-index.h"
+#include "fsmonitor.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -233,6 +234,7 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 		else
 			active_cache[pos]->ce_flags &= ~flag;
 		active_cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
+		mark_fsmonitor_invalid(&the_index, active_cache[pos]);
 		cache_tree_invalidate_path(&the_index, path);
 		active_cache_changed |= CE_ENTRY_CHANGED;
 		return 0;
diff --git a/cache.h b/cache.h
index a916bc79e3..f1c903e1b6 100644
--- a/cache.h
+++ b/cache.h
@@ -203,6 +203,7 @@ struct cache_entry {
 #define CE_ADDED             (1 << 19)
 
 #define CE_HASHED            (1 << 20)
+#define CE_FSMONITOR_VALID   (1 << 21)
 #define CE_WT_REMOVE         (1 << 22) /* remove in work directory */
 #define CE_CONFLICTED        (1 << 23)
 
@@ -326,6 +327,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 #define CACHE_TREE_CHANGED	(1 << 5)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
 #define UNTRACKED_CHANGED	(1 << 7)
+#define FSMONITOR_CHANGED	(1 << 8)
 
 struct split_index;
 struct untracked_cache;
@@ -344,6 +346,7 @@ struct index_state {
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
 	struct untracked_cache *untracked;
+	uint64_t fsmonitor_last_update;
 };
 
 extern struct index_state the_index;
@@ -679,8 +682,10 @@ extern void *read_blob_data_from_index(const struct index_state *, const char *,
 #define CE_MATCH_IGNORE_MISSING		0x08
 /* enable stat refresh */
 #define CE_MATCH_REFRESH		0x10
-extern int ie_match_stat(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
-extern int ie_modified(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
+/* don't refresh_fsmonitor state or do stat comparison even if CE_FSMONITOR_VALID is true */
+#define CE_MATCH_IGNORE_FSMONITOR 0X20
+extern int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
+extern int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
@@ -773,6 +778,7 @@ extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
+extern const char *core_fsmonitor;
 
 /*
  * Include broken refs in all ref iterations, which will
diff --git a/config.c b/config.c
index d0d8ce823a..ddda96e584 100644
--- a/config.c
+++ b/config.c
@@ -2165,6 +2165,20 @@ int git_config_get_max_percent_split_change(void)
 	return -1; /* default value */
 }
 
+int git_config_get_fsmonitor(void)
+{
+	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
+		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
+
+	if (core_fsmonitor && !*core_fsmonitor)
+		core_fsmonitor = NULL;
+
+	if (core_fsmonitor)
+		return 1;
+
+	return 0;
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
diff --git a/config.h b/config.h
index 97471b8873..c9fcf691ba 100644
--- a/config.h
+++ b/config.h
@@ -211,6 +211,7 @@ extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
+extern int git_config_get_fsmonitor(void);
 
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
diff --git a/diff-lib.c b/diff-lib.c
index 2a52b07954..23c6d03ca9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "submodule.h"
 #include "dir.h"
+#include "fsmonitor.h"
 
 /*
  * diff-files
@@ -228,6 +229,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
+			mark_fsmonitor_valid(ce);
 			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 				continue;
 		}
diff --git a/dir.c b/dir.c
index 1c55dc3e36..ac9833daec 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,7 @@
 #include "utf8.h"
 #include "varint.h"
 #include "ewah/ewok.h"
+#include "fsmonitor.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
@@ -1688,17 +1689,23 @@ static int valid_cached_dir(struct dir_struct *dir,
 	if (!untracked)
 		return 0;
 
-	if (stat(path->len ? path->buf : ".", &st)) {
-		invalidate_directory(dir->untracked, untracked);
-		memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
-		return 0;
-	}
-	if (!untracked->valid ||
-	    match_stat_data_racy(istate, &untracked->stat_data, &st)) {
-		if (untracked->valid)
+	/*
+	 * With fsmonitor, we can trust the untracked cache's valid field.
+	 */
+	refresh_fsmonitor(istate);
+	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
+		if (stat(path->len ? path->buf : ".", &st)) {
 			invalidate_directory(dir->untracked, untracked);
-		fill_stat_data(&untracked->stat_data, &st);
-		return 0;
+			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
+			return 0;
+		}
+		if (!untracked->valid ||
+			match_stat_data_racy(istate, &untracked->stat_data, &st)) {
+			if (untracked->valid)
+				invalidate_directory(dir->untracked, untracked);
+			fill_stat_data(&untracked->stat_data, &st);
+			return 0;
+		}
 	}
 
 	if (untracked->check_only != !!check_only) {
diff --git a/dir.h b/dir.h
index e3717055d1..fab8fc1561 100644
--- a/dir.h
+++ b/dir.h
@@ -139,6 +139,8 @@ struct untracked_cache {
 	int gitignore_invalidated;
 	int dir_invalidated;
 	int dir_opened;
+	/* fsmonitor invalidation data */
+	unsigned int use_fsmonitor : 1;
 };
 
 struct dir_struct {
diff --git a/entry.c b/entry.c
index cb291aa88b..3a7b667373 100644
--- a/entry.c
+++ b/entry.c
@@ -4,6 +4,7 @@
 #include "streaming.h"
 #include "submodule.h"
 #include "progress.h"
+#include "fsmonitor.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -357,6 +358,7 @@ static int write_entry(struct cache_entry *ce,
 			lstat(ce->name, &st);
 		fill_stat_cache_info(ce, &st);
 		ce->ce_flags |= CE_UPDATE_IN_BASE;
+		mark_fsmonitor_invalid(state->istate, ce);
 		state->istate->cache_changed |= CE_ENTRY_CHANGED;
 	}
 	return 0;
diff --git a/environment.c b/environment.c
index 3fd4b10845..d0b9fc64d4 100644
--- a/environment.c
+++ b/environment.c
@@ -76,6 +76,7 @@ int protect_hfs = PROTECT_HFS_DEFAULT;
 #define PROTECT_NTFS_DEFAULT 0
 #endif
 int protect_ntfs = PROTECT_NTFS_DEFAULT;
+const char *core_fsmonitor;
 
 /*
  * The character that begins a commented line in user-editable file
diff --git a/fsmonitor.c b/fsmonitor.c
new file mode 100644
index 0000000000..7c1540c054
--- /dev/null
+++ b/fsmonitor.c
@@ -0,0 +1,253 @@
+#include "cache.h"
+#include "config.h"
+#include "dir.h"
+#include "ewah/ewok.h"
+#include "fsmonitor.h"
+#include "run-command.h"
+#include "strbuf.h"
+
+#define INDEX_EXTENSION_VERSION	(1)
+#define HOOK_INTERFACE_VERSION	(1)
+
+struct trace_key trace_fsmonitor = TRACE_KEY_INIT(FSMONITOR);
+
+static void fsmonitor_ewah_callback(size_t pos, void *is)
+{
+	struct index_state *istate = (struct index_state *)is;
+	struct cache_entry *ce = istate->cache[pos];
+
+	ce->ce_flags &= ~CE_FSMONITOR_VALID;
+}
+
+int read_fsmonitor_extension(struct index_state *istate, const void *data,
+	unsigned long sz)
+{
+	const char *index = data;
+	uint32_t hdr_version;
+	uint32_t ewah_size;
+	struct ewah_bitmap *fsmonitor_dirty;
+	int i;
+	int ret;
+
+	if (sz < sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint32_t))
+		return error("corrupt fsmonitor extension (too short)");
+
+	hdr_version = get_be32(index);
+	index += sizeof(uint32_t);
+	if (hdr_version != INDEX_EXTENSION_VERSION)
+		return error("bad fsmonitor version %d", hdr_version);
+
+	istate->fsmonitor_last_update = get_be64(index);
+	index += sizeof(uint64_t);
+
+	ewah_size = get_be32(index);
+	index += sizeof(uint32_t);
+
+	fsmonitor_dirty = ewah_new();
+	ret = ewah_read_mmap(fsmonitor_dirty, index, ewah_size);
+	if (ret != ewah_size) {
+		ewah_free(fsmonitor_dirty);
+		return error("failed to parse ewah bitmap reading fsmonitor index extension");
+	}
+
+	if (git_config_get_fsmonitor()) {
+		/* Mark all entries valid */
+		for (i = 0; i < istate->cache_nr; i++)
+			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
+
+		/* Mark all previously saved entries as dirty */
+		ewah_each_bit(fsmonitor_dirty, fsmonitor_ewah_callback, istate);
+
+		/* Now mark the untracked cache for fsmonitor usage */
+		if (istate->untracked)
+			istate->untracked->use_fsmonitor = 1;
+	}
+	ewah_free(fsmonitor_dirty);
+
+	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
+	return 0;
+}
+
+void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
+{
+	uint32_t hdr_version;
+	uint64_t tm;
+	struct ewah_bitmap *bitmap;
+	int i;
+	uint32_t ewah_start;
+	uint32_t ewah_size = 0;
+	int fixup = 0;
+
+	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
+	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
+
+	put_be64(&tm, istate->fsmonitor_last_update);
+	strbuf_add(sb, &tm, sizeof(uint64_t));
+	fixup = sb->len;
+	strbuf_add(sb, &ewah_size, sizeof(uint32_t)); /* we'll fix this up later */
+
+	ewah_start = sb->len;
+	bitmap = ewah_new();
+	for (i = 0; i < istate->cache_nr; i++)
+		if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
+			ewah_set(bitmap, i);
+	ewah_serialize_strbuf(bitmap, sb);
+	ewah_free(bitmap);
+
+	/* fix up size field */
+	put_be32(&ewah_size, sb->len - ewah_start);
+	memcpy(sb->buf + fixup, &ewah_size, sizeof(uint32_t));
+
+	trace_printf_key(&trace_fsmonitor, "write fsmonitor extension successful");
+}
+
+/*
+ * Call the query-fsmonitor hook passing the time of the last saved results.
+ */
+static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *query_result)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char ver[64];
+	char date[64];
+	const char *argv[4];
+
+	if (!(argv[0] = core_fsmonitor))
+		return -1;
+
+	snprintf(ver, sizeof(version), "%d", version);
+	snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
+	argv[1] = ver;
+	argv[2] = date;
+	argv[3] = NULL;
+	cp.argv = argv;
+	cp.use_shell = 1;
+
+	return capture_command(&cp, query_result, 1024);
+}
+
+static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
+{
+	int pos = index_name_pos(istate, name, strlen(name));
+
+	if (pos >= 0) {
+		struct cache_entry *ce = istate->cache[pos];
+		ce->ce_flags &= ~CE_FSMONITOR_VALID;
+	}
+
+	/*
+	 * Mark the untracked cache dirty even if it wasn't found in the index
+	 * as it could be a new untracked file.
+	 */
+	trace_printf_key(&trace_fsmonitor, "fsmonitor_refresh_callback '%s'", name);
+	untracked_cache_invalidate_path(istate, name);
+}
+
+void refresh_fsmonitor(struct index_state *istate)
+{
+	static int has_run_once = 0;
+	struct strbuf query_result = STRBUF_INIT;
+	int query_success = 0;
+	size_t bol; /* beginning of line */
+	uint64_t last_update;
+	char *buf;
+	int i;
+
+	if (!core_fsmonitor || has_run_once)
+		return;
+	has_run_once = 1;
+
+	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
+	/*
+	 * This could be racy so save the date/time now and query_fsmonitor
+	 * should be inclusive to ensure we don't miss potential changes.
+	 */
+	last_update = getnanotime();
+
+	/*
+	 * If we have a last update time, call query_fsmonitor for the set of
+	 * changes since that time, else assume everything is possibly dirty
+	 * and check it all.
+	 */
+	if (istate->fsmonitor_last_update) {
+		query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION,
+			istate->fsmonitor_last_update, &query_result);
+		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
+		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %s",
+			core_fsmonitor, query_success ? "success" : "failure");
+	}
+
+	/* a fsmonitor process can return '/' to indicate all entries are invalid */
+	if (query_success && query_result.buf[0] != '/') {
+		/* Mark all entries returned by the monitor as dirty */
+		buf = query_result.buf;
+		bol = 0;
+		for (i = 0; i < query_result.len; i++) {
+			if (buf[i] != '\0')
+				continue;
+			fsmonitor_refresh_callback(istate, buf + bol);
+			bol = i + 1;
+		}
+		if (bol < query_result.len)
+			fsmonitor_refresh_callback(istate, buf + bol);
+	} else {
+		/* Mark all entries invalid */
+		for (i = 0; i < istate->cache_nr; i++)
+			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+
+		if (istate->untracked)
+			istate->untracked->use_fsmonitor = 0;
+	}
+	strbuf_release(&query_result);
+
+	/* Now that we've updated istate, save the last_update time */
+	istate->fsmonitor_last_update = last_update;
+}
+
+void add_fsmonitor(struct index_state *istate)
+{
+	int i;
+
+	if (!istate->fsmonitor_last_update) {
+		trace_printf_key(&trace_fsmonitor, "add fsmonitor");
+		istate->cache_changed |= FSMONITOR_CHANGED;
+		istate->fsmonitor_last_update = getnanotime();
+
+		/* reset the fsmonitor state */
+		for (i = 0; i < istate->cache_nr; i++)
+			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+
+		/* reset the untracked cache */
+		if (istate->untracked) {
+			add_untracked_cache(istate);
+			istate->untracked->use_fsmonitor = 1;
+		}
+
+		/* Update the fsmonitor state */
+		refresh_fsmonitor(istate);
+	}
+}
+
+void remove_fsmonitor(struct index_state *istate)
+{
+	if (istate->fsmonitor_last_update) {
+		trace_printf_key(&trace_fsmonitor, "remove fsmonitor");
+		istate->cache_changed |= FSMONITOR_CHANGED;
+		istate->fsmonitor_last_update = 0;
+	}
+}
+
+void tweak_fsmonitor(struct index_state *istate)
+{
+	switch (git_config_get_fsmonitor()) {
+	case -1: /* keep: do nothing */
+		break;
+	case 0: /* false */
+		remove_fsmonitor(istate);
+		break;
+	case 1: /* true */
+		add_fsmonitor(istate);
+		break;
+	default: /* unknown value: do nothing */
+		break;
+	}
+}
diff --git a/fsmonitor.h b/fsmonitor.h
new file mode 100644
index 0000000000..8eb6163455
--- /dev/null
+++ b/fsmonitor.h
@@ -0,0 +1,66 @@
+#ifndef FSMONITOR_H
+#define FSMONITOR_H
+
+extern struct trace_key trace_fsmonitor;
+
+/*
+ * Read the the fsmonitor index extension and (if configured) restore the
+ * CE_FSMONITOR_VALID state.
+ */
+extern int read_fsmonitor_extension(struct index_state *istate, const void *data, unsigned long sz);
+
+/*
+ * Write the CE_FSMONITOR_VALID state into the fsmonitor index extension.
+ */
+extern void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate);
+
+/*
+ * Add/remove the fsmonitor index extension
+ */
+extern void add_fsmonitor(struct index_state *istate);
+extern void remove_fsmonitor(struct index_state *istate);
+
+/*
+ * Add/remove the fsmonitor index extension as necessary based on the current
+ * core.fsmonitor setting.
+ */
+extern void tweak_fsmonitor(struct index_state *istate);
+
+/*
+ * Run the configured fsmonitor integration script and clear the
+ * CE_FSMONITOR_VALID bit for any files returned as dirty.  Also invalidate
+ * any corresponding untracked cache directory structures. Optimized to only
+ * run the first time it is called.
+ */
+extern void refresh_fsmonitor(struct index_state *istate);
+
+/*
+ * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
+ * called any time the cache entry has been updated to reflect the
+ * current state of the file on disk.
+ */
+static inline void mark_fsmonitor_valid(struct cache_entry *ce)
+{
+	if (core_fsmonitor) {
+		ce->ce_flags |= CE_FSMONITOR_VALID;
+		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
+	}
+}
+
+/*
+ * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate
+ * any corresponding untracked cache directory structures. This should
+ * be called any time git creates or modifies a file that should
+ * trigger an lstat() or invalidate the untracked cache for the
+ * corresponding directory
+ */
+static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
+{
+	if (core_fsmonitor) {
+		ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		untracked_cache_invalidate_path(istate, ce->name);
+		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
+	}
+}
+
+#endif
diff --git a/preload-index.c b/preload-index.c
index 75564c497a..2a83255e4e 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "fsmonitor.h"
 
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index,
@@ -55,15 +56,18 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce_skip_worktree(ce))
 			continue;
+		if (ce->ce_flags & CE_FSMONITOR_VALID)
+			continue;
 		if (!ce_path_match(ce, &p->pathspec, NULL))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
 			continue;
 		if (lstat(ce->name, &st))
 			continue;
-		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY))
+		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY|CE_MATCH_IGNORE_FSMONITOR))
 			continue;
 		ce_mark_uptodate(ce);
+		mark_fsmonitor_valid(ce);
 	} while (--nr > 0);
 	cache_def_clear(&cache);
 	return NULL;
diff --git a/read-cache.c b/read-cache.c
index 40da87ea71..05c0a33fdd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -19,6 +19,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "fsmonitor.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -38,11 +39,12 @@
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
+#define CACHE_EXT_FSMONITOR 0x46534D4E	  /* "FSMN" */
 
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
 		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
-		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED)
+		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | FSMONITOR_CHANGED)
 
 struct index_state the_index;
 static const char *alternate_index_output;
@@ -62,6 +64,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 	free(old);
 	set_index_entry(istate, nr, ce);
 	ce->ce_flags |= CE_UPDATE_IN_BASE;
+	mark_fsmonitor_invalid(istate, ce);
 	istate->cache_changed |= CE_ENTRY_CHANGED;
 }
 
@@ -150,8 +153,10 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 	if (assume_unchanged)
 		ce->ce_flags |= CE_VALID;
 
-	if (S_ISREG(st->st_mode))
+	if (S_ISREG(st->st_mode)) {
 		ce_mark_uptodate(ce);
+		mark_fsmonitor_valid(ce);
+	}
 }
 
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
@@ -300,7 +305,7 @@ int match_stat_data_racy(const struct index_state *istate,
 	return match_stat_data(sd, st);
 }
 
-int ie_match_stat(const struct index_state *istate,
+int ie_match_stat(struct index_state *istate,
 		  const struct cache_entry *ce, struct stat *st,
 		  unsigned int options)
 {
@@ -308,7 +313,10 @@ int ie_match_stat(const struct index_state *istate,
 	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
 	int ignore_skip_worktree = options & CE_MATCH_IGNORE_SKIP_WORKTREE;
 	int assume_racy_is_modified = options & CE_MATCH_RACY_IS_DIRTY;
+	int ignore_fsmonitor = options & CE_MATCH_IGNORE_FSMONITOR;
 
+	if (!ignore_fsmonitor)
+		refresh_fsmonitor(istate);
 	/*
 	 * If it's marked as always valid in the index, it's
 	 * valid whatever the checked-out copy says.
@@ -319,6 +327,8 @@ int ie_match_stat(const struct index_state *istate,
 		return 0;
 	if (!ignore_valid && (ce->ce_flags & CE_VALID))
 		return 0;
+	if (!ignore_fsmonitor && (ce->ce_flags & CE_FSMONITOR_VALID))
+		return 0;
 
 	/*
 	 * Intent-to-add entries have not been added, so the index entry
@@ -356,7 +366,7 @@ int ie_match_stat(const struct index_state *istate,
 	return changed;
 }
 
-int ie_modified(const struct index_state *istate,
+int ie_modified(struct index_state *istate,
 		const struct cache_entry *ce,
 		struct stat *st, unsigned int options)
 {
@@ -777,6 +787,7 @@ int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
 	}
 	cache_tree_invalidate_path(istate, ce->name);
 	ce->ce_flags |= CE_UPDATE_IN_BASE;
+	mark_fsmonitor_invalid(istate, ce);
 	istate->cache_changed |= CE_ENTRY_CHANGED;
 
 	return 0;
@@ -1228,10 +1239,13 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
 	int ignore_skip_worktree = options & CE_MATCH_IGNORE_SKIP_WORKTREE;
 	int ignore_missing = options & CE_MATCH_IGNORE_MISSING;
+	int ignore_fsmonitor = options & CE_MATCH_IGNORE_FSMONITOR;
 
 	if (!refresh || ce_uptodate(ce))
 		return ce;
 
+	if (!ignore_fsmonitor)
+		refresh_fsmonitor(istate);
 	/*
 	 * CE_VALID or CE_SKIP_WORKTREE means the user promised us
 	 * that the change to the work tree does not matter and told
@@ -1245,6 +1259,10 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		ce_mark_uptodate(ce);
 		return ce;
 	}
+	if (!ignore_fsmonitor && (ce->ce_flags & CE_FSMONITOR_VALID)) {
+		ce_mark_uptodate(ce);
+		return ce;
+	}
 
 	if (has_symlink_leading_path(ce->name, ce_namelen(ce))) {
 		if (ignore_missing)
@@ -1282,8 +1300,10 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 			 * because CE_UPTODATE flag is in-core only;
 			 * we are not going to write this change out.
 			 */
-			if (!S_ISGITLINK(ce->ce_mode))
+			if (!S_ISGITLINK(ce->ce_mode)) {
 				ce_mark_uptodate(ce);
+				mark_fsmonitor_valid(ce);
+			}
 			return ce;
 		}
 	}
@@ -1391,6 +1411,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 				 */
 				ce->ce_flags &= ~CE_VALID;
 				ce->ce_flags |= CE_UPDATE_IN_BASE;
+				mark_fsmonitor_invalid(istate, ce);
 				istate->cache_changed |= CE_ENTRY_CHANGED;
 			}
 			if (quiet)
@@ -1550,6 +1571,9 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_UNTRACKED:
 		istate->untracked = read_untracked_extension(data, sz);
 		break;
+	case CACHE_EXT_FSMONITOR:
+		read_fsmonitor_extension(istate, data, sz);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1722,6 +1746,7 @@ static void post_read_index_from(struct index_state *istate)
 	check_ce_order(istate);
 	tweak_untracked_cache(istate);
 	tweak_split_index(istate);
+	tweak_fsmonitor(istate);
 }
 
 /* remember to discard_cache() before reading a different cache! */
@@ -2306,6 +2331,16 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
+	if (!strip_extensions && istate->fsmonitor_last_update) {
+		struct strbuf sb = STRBUF_INIT;
+
+		write_fsmonitor_extension(&sb, istate);
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_FSMONITOR, sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
 
 	if (ce_flush(&c, newfd, istate->sha1))
 		return -1;
diff --git a/submodule.c b/submodule.c
index 3cea8221e0..8a931a1aaa 100644
--- a/submodule.c
+++ b/submodule.c
@@ -62,7 +62,7 @@ int is_staging_gitmodules_ok(const struct index_state *istate)
 	if ((pos >= 0) && (pos < istate->cache_nr)) {
 		struct stat st;
 		if (lstat(GITMODULES_FILE, &st) == 0 &&
-		    ce_match_stat(istate->cache[pos], &st, 0) & DATA_CHANGED)
+		    ce_match_stat(istate->cache[pos], &st, CE_MATCH_IGNORE_FSMONITOR) & DATA_CHANGED)
 			return 0;
 	}
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 71b70ccb12..1f5d371636 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "fsmonitor.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -408,6 +409,7 @@ static int apply_sparse_checkout(struct index_state *istate,
 		ce->ce_flags &= ~CE_SKIP_WORKTREE;
 	if (was_skip_worktree != ce_skip_worktree(ce)) {
 		ce->ce_flags |= CE_UPDATE_IN_BASE;
+		mark_fsmonitor_invalid(istate, ce);
 		istate->cache_changed |= CE_ENTRY_CHANGED;
 	}
 
-- 
2.14.1.549.g6ff7ed0467

