Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8EE1F442
	for <e@80x24.org>; Thu,  9 Nov 2017 14:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754961AbdKIOSL (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 09:18:11 -0500
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:45724
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754955AbdKIOSI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 09:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=13N8pXAN5jhl8I+QWFaXgJn9j7ce4cVsbfikJ8bnR64=;
 b=JBiOMQpm8jFVEW12deVMky5/xx6EfIojeUkO4nBq6bKoB2VvGBqv2f+JpdAYeB6vxiWYYsucmWpBOa2h7bkFuEhp799MwxEjqj9OJSgnkJHKAof3vqfNaP9hm6eLWGabPXQTfZplqr93DddALV80dJzLng3NE4xpIsRnlNHyzaE=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.239.0; Thu, 9 Nov 2017 14:18:01 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1 1/4] fastindex: speed up index load through parallelization
Date:   Thu,  9 Nov 2017 09:17:34 -0500
Message-Id: <20171109141737.47976-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20171109141737.47976-1-benpeart@microsoft.com>
References: <20171109141737.47976-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR13CA0015.namprd13.prod.outlook.com (10.175.123.25) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1cb7f99-fd59-4403-a79f-08d5277cb0ab
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603249);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:K/RZkFyxJUo9iLEdrePhPl4R9Zcfyy5flhgLU6tkt8K8etZgINNwpjHfjgjcGDdFiENVifr1S8e87BntYRsgDoFbiV7dHmWlzahFrxiT9gv86XS5Ali8bRurcAgZ3BY8IDFKBDODAnznp2aCml09h8WAb7hchloHNOx7+PkC9CscgxNFlgi8xYpGZNvl5A6p8jVNTIx2kyMknP2cxPBk0dJR4VuO4wLI89Y74rIZwcGSHwaZ7Ht+GqkEoaT8DmId;25:XZC61xreIuom4T8044ZLSJobA1lEV9Nehk0c/qZq7IWCdqgaZkMJc8NFEerZBsrygQAFiUL6J9PuBC3rJB9jCSgVNdAjxT98Enwv8+smyaPtohm5cpgXdfgnOIYonyNCNaAWdV3NIpt32b+l/ylZSdEz/NL+77m59s/ywBEe0u2kunQVj3UiMla5rqvvgRNleuMqmCbkKxeWmcvvp/ndcgdSL8YQl+bY096wCm+RAPhDHng3Xev0ZriFBFmyXgFLhzDv27C6Ov6XhROacucrXUZk+Nm2CKSwSRDlxQaxCgFnI1Obg+5TJuzUXVCJYxPOgfzrOdGq2UnEommLGjop+w==;31:4k4B4Orl7F01fhhMTfZ8XVEELW971WJvVPngrUo/v0vQf/hDkv/Zk2A/6M0pllb2345KO16W9RTP4aaZHJtWfGygTc/zLGEBEroKvdkoS0GDU5DH0m+T9d/UHsAzJv9HAcTZkNOOdic90stPiFdFljfVuYDkalWMjEBkorJ+G7ZPzMptrqzDgEda+Yv1X2PgS67zTyrX95o/37GTI/fZdnkEae09TKHEhcnvzPo6Uec=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:lVKys5LF3GIOrwPIgkF7l9T0O0EJ0tMo/Glz3sNGjEnEG/dEOK0w14yZkwAv84/uD00cr6ab9bXyjcG9iROyE9gp/FbbDMBHiQgumjcVMynhuC0nunuchNBgRVEkCWmwUnKs/zB4J+I4X+lApprlru86vgqsviOyzze+Oe36s6MjdVk9LW41iZwowbWlPeoPNaXdy5vzDaCwzJKazqvBchybYmOt9RxIz66vU5B8neFI7m2BTd0SquUbFkvVXf/57Ul4o/nNKpkUS8bwKGTGwa6nl5purEqAkc/dW7cc5mkYjsTYfAG9aWNVYh5ehu4DQ2+HCJ1GOHaLEdA6J3fPVe2Dh5imLHysxz3JjLi8NQcvVArJ5gd3VNk1BofJYxJx3XaH73DHzrKVVuixfS6N3DQj3lwEzRXKlwhgNnhAPM1LoDSWy5XNtRAweHDstnxOYIhxQfs4g/Z9LuhppgbgU+AuwsxyoHstZ8w/eAOGg4tZzqm8IF5NWwYmvn73P4eC;4:djirFpM/Yey5P77GVo/zXAJcyaZvqX2G5dbGyeANwHmo6CRgnMJYQ5Goph+akbbRAXLNk1dhdEMEWZ7CZOQlorEhYRjJPBRfAzdHHiE9kUvjQ8R4ECNBJtqelLVLMpGwTO5C4l1u+pt4Vm6r4Z5O7c6AIuo1/EqvBqAoqqJ1zDZhX3iFmNyyaJuN2DfR0Hg9ZxHstAgEgSntvfyVqqzLe80A9c6NuXtu24xL6RisHWHppzg14I5qzWX7ffRZr8ulanE1IeHzNJNTGzcsNOJdu0oVvswX8kpPmngjwqk5r26grFi8gqjzagqXqZr/OvzYn9b52rWyzf6Bw6+b8x+pug1UCWtupPftptKjCnsL4s0=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(209352067349851);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471F4153B9F588B1A6DC5F6F4570@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(3231021)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(376002)(39860400002)(346002)(47760400005)(199003)(189002)(5660300001)(53936002)(8656006)(47776003)(68736007)(66066001)(48376002)(107886003)(101416001)(50986999)(4326008)(6116002)(8666007)(39060400002)(76176999)(81166006)(50226002)(8676002)(7736002)(16526018)(36756003)(2361001)(105586002)(1076002)(305945005)(106356001)(81156014)(6512007)(2906002)(8936002)(10290500003)(189998001)(10090500001)(2351001)(3846002)(478600001)(22452003)(16586007)(6506006)(33646002)(316002)(72206003)(6486002)(5003940100001)(6916009)(97736004)(6666003)(86612001)(575784001)(25786009)(50466002)(2950100002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:8dCLfcUqClJi/aKggRA5Rx/TMRaM5Iqv48BWVE/js?=
 =?us-ascii?Q?QV3RfQ/kb2nyBzDxnK8Uu6Y92RFuO7lvOsxSK8owBREXMfJ437Bv7b7urhAx?=
 =?us-ascii?Q?+Q3n9Sqj47L5BE+zc4Afb4ohMiePr5aaQBi9XbbVtucJKlc/dAXhrbV1IVlk?=
 =?us-ascii?Q?E9QfH9aRvZQQht/Qk8msm0cR5J7I8t8aN0X7beCQLuEaLrvqnEev0ZOgNzAT?=
 =?us-ascii?Q?T2ghVQkh9ERYrUmGvVH9yi5lJhQA6FXvX7c8bYrl7rDMeDU61xUY9rjR5jit?=
 =?us-ascii?Q?F8VIR302b867g8JPfZ3syrkGMzkuiFKaN+kXf8CGycRQDUrjwA7DuRoQo7xt?=
 =?us-ascii?Q?7xHs/i/IEoQjvf3Xp7/rwWt8UslS8BQRqdtUtn57Tny1wcoNEtuGTZnJMyKw?=
 =?us-ascii?Q?JSRnHukjVnVrK0py3g77YfC4isi4Jb8IO7ebY59UHXX1pQaNGMLv842C+gBr?=
 =?us-ascii?Q?YAx70DiiWo08L1gt/dI11mRLPg0CAlv/oOftOz/gE6xnxTDMm356LkuFES3l?=
 =?us-ascii?Q?esNaGmj/5uPAEHSSKFlKLOJhcl1GrG45s1krpkOXX+atz4JvvEVnO9fuTZn7?=
 =?us-ascii?Q?FEejDK2cLUYyYkP4s5d915SkeKemvf0hgTty+6P072rO5zRG74nX5SLntdCS?=
 =?us-ascii?Q?8ldZH0+yh5yvNIqwlS+y9OyjdLZ+h2yfBrQuE/pNyW5uruT19C3/TB5h47bQ?=
 =?us-ascii?Q?sgIIhc8wf9Y47KhvUaaKNyMFVObWk5ZtuFuTVv6nso/YgJ9Jaf1wO4Cwwx7l?=
 =?us-ascii?Q?bljwTrj2LUACSKtirukuATqNGMnuDWpuvTPB3yokd7WKgCwTB646W0YXZI7g?=
 =?us-ascii?Q?yf3+RUdGxi99eNn3rcWDwWz8PYA9LjXPU9Z1pfa7+z9mDLUGrxPwSQGlGO5y?=
 =?us-ascii?Q?nADrQUdzYDKhzk2W5YGT0kCZvpYnU7+IM3O9Y3IWV6CjL+PXndKeIm3MtFHL?=
 =?us-ascii?Q?V2wEveyJ4Swo18jq/WdYEGnD29UKar3M6Bj8sAPzFVC+MitK5xbgXxIaVIve?=
 =?us-ascii?Q?iUhCo2orhp2MPA0rofDe4MT964alQO5LYquHTm/NzmIwwAQAzq2yOy05qBLw?=
 =?us-ascii?Q?Ens0X0yu357HmLcq3BLoIZhuPpLKTUNEOQFM6GDLpQRl75cCmM8/ooaA4v9q?=
 =?us-ascii?Q?2LYGU/70+zomcrt18kxr7VfyDwMTznjB23LzzaC8soCuTzEx51u05n6iPhaZ?=
 =?us-ascii?Q?NCaZKa3/OaOc0wrL9e7ZLLuqScl92XMwA9pjh7KN7UG4S/Rdb/tTN3Zk4neC?=
 =?us-ascii?Q?OKsXMHNFQxcx/AC7oqT37kXeIt9Y+71LATcRaIFENa0fQ8qIBkYRsg1MtgIq?=
 =?us-ascii?Q?rkg7oTVK842GHlzlzxhE6y7yC+4h020xaUUp51VTkAYWCNio2afo8G42g8fd?=
 =?us-ascii?Q?0BniRMEhLUJEapSXqCQ6CVPNScSM4WUevd6C3zGSMBQW6T57HZqeOKFWqi6U?=
 =?us-ascii?Q?IyfjD6RKw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:Q5RKks64zC4M1FvkG7I+oBHGv44fIHjLkYm7qolvX8SXeZ+c5WaLgUcPxs+9JuYrrxYi/Vnp4aLk1ox42cQNdUURRsABHoLqIakgNLGjNu6be5YmHZBj6DmU3wwj7gJvo75OnhQgxFtLJFtg7uO7T2I6WFO3pGDJTpRO+rPtESkcYCEaKvX+wBa7YaLPQZX01JuRpShOpnN+L/o4/VqM4rnZRg2JsnIPbWK58kfogdk2Hi31ymXVEJdgQKTmxDFyGYrcsKbhuevnlLnNt6B269FKEcTWk+wwc+Lh/evf3N/8vK3MAcp8+XkjCVTuMCN84q5xzijI2f234AAHE6PembS5vhY3RDHIBzJQWO0m70E=;5:QMBPp2sXYzSKWtVn2n1ru6HNp5Mab0mcwqAKlqD7O/8fvSNLJyJQRQQaZj4zs3rz3AneoIppqsyj0dtACRrUXGcUMCjBWiHSGwWDi1TpS3CiyMwKi7YANqiQs7WMB5xlZOgfZ7nmwe3zjBzHk912R9aApNIlEoIAEWdTpucbm04=;24:NtEn07RQcaVF776BO2ijdiYmzO1rfz/4F8YMZVDnFjVY4DydnW+VTzCnVPnVRSCGIUR4GFYkpaVHGqReoIrQfK1Fd3JAfKA6+OIDfNGNGvs=;7:wo7zMoTrFrQBvOUK1pdhw0X/BzUFsnGlBtmQjgAuxMgCreTnvFyntvXrvI6ADLW2lQdf3iglaKvpOBuLRmb3fnyE20Rq0IBACJEyrIy7N72qoCsiySFX0k6V5lhbtlSwk50yUoZOj8Q4sURHiEOqaYoSrgSkBgJz6HLwVx4Jm/etbXBxnlKHlbEWDuVcm698BERufV6LK5RSlWkRxq4V+tXLkvhuuMNNB9VgzagvyTZ9pFRK/bGp/EDfE0LrTbKw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 14:18:01.9073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cb7f99-fd59-4403-a79f-08d5277cb0ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch helps address the CPU cost of loading the index by adding
additional data to the index that will allow us to multi-thread the
loading and conversion of cache entries.

It accomplishes this by adding an (optional) index extension that is a
table of offsets to blocks of cache entries in the index file.  With
version 2, 3 or even 4 indexes, we can utilize the Index Entry Offset Table
(IEOT) to parallelize the loading and conversion of the cache entries
across all available CPU cores.

To make this work for V4 indexes, when writing the index, it periodically
"resets" the prefix-compression by encoding the current entry as if the
path name for the previous entry is completely different and saves the
offset of that entry in the IEOT.  Basically, with V4 indexes, it
generates offsets into blocks of prefix-compressed entries.

To enable reading the IEOT extension before reading all the variable
length cache entries and other extensions, the IEOT is written last,
right before the trailing SHA1.

The format of that extension has the signature bytes and size at the
beginning (like a normal extension) as well as at the end in reverse
order to enable parsing the extension by seeking back from the end of
the file.

During index load, read the index header then seek to the end of the
index, back up past the trailing SHA1 and look for the IEOT extension
signature bytes.  If they exist, read the 32-bit size and seek back to
the extension header and verify the leading header and size bits.  If
they all match, we can be assured we have a valid IEOT extension.

If the IEOT extension is available, create multiple threads to divide
the work of loading and converting the cache entries across all
available CPU cores.  Once the cache entries are loaded, the rest of the
extensions can be loaded and processed normally (skipping the IEOT entry
as it has already been processed).  If the IEOT extension is not
available then parsing the index will proceed as usual with a single thread.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 cache.h       |  25 +++++
 config.c      |  20 ++++
 config.h      |   1 +
 environment.c |   3 +
 read-cache.c  | 343 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 371 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index d74f00d8db..ea0c4b4b97 100644
--- a/cache.h
+++ b/cache.h
@@ -794,6 +794,7 @@ extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int core_fast_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
@@ -1942,4 +1943,28 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+
+#ifndef NO_PTHREADS
+struct index_entry_offset
+{
+	/* starting byte offset into index file, count of index entries in this block */
+	int offset, nr;
+};
+
+struct index_entry_offset_table
+{
+	int nr;
+	struct index_entry_offset entries[0];
+};
+
+extern struct index_entry_offset_table *read_ieot_extension(void *mmap, size_t mmap_size);
+
+struct ondisk_cache_entry;
+extern struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
+	unsigned long *ent_size,
+	struct strbuf *previous_name,
+	int use_length);
+
+#endif
+
 #endif /* CACHE_H */
diff --git a/config.c b/config.c
index 903abf9533..44b08f57eb 100644
--- a/config.c
+++ b/config.c
@@ -1203,6 +1203,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.fastindex")) {
+		core_fast_index = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!strcmp(value, "rename"))
 			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
@@ -2156,6 +2161,21 @@ int git_config_get_max_percent_split_change(void)
 	return -1; /* default value */
 }
 
+int ignore_fast_index_config;
+int git_config_get_fast_index(void)
+{
+	int val;
+
+	/* Hack for test programs like test-ieot */
+	if (ignore_fast_index_config)
+		return core_fast_index;
+
+	if (!git_config_get_maybe_bool("core.fastindex", &val))
+		return val;
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
diff --git a/config.h b/config.h
index a49d264416..3f78b1d262 100644
--- a/config.h
+++ b/config.h
@@ -212,6 +212,7 @@ extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
+extern int git_config_get_fast_index(void);
 
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
diff --git a/environment.c b/environment.c
index 8289c25b44..492ef9c741 100644
--- a/environment.c
+++ b/environment.c
@@ -87,6 +87,9 @@ int auto_comment_line_char;
 /* Parallel index stat data preload? */
 int core_preload_index = 1;
 
+/* Parallel index cache entry loading? */
+int core_fast_index;
+
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
  * ensure that they do not modify the untracked cache when reading it.
diff --git a/read-cache.c b/read-cache.c
index f3d125c114..174be0da38 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -19,6 +19,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "thread-utils.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -38,6 +39,7 @@
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
+#define CACHE_EXT_FASTINDEX 0x49454F54	  /* "IEOT" */
 
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
@@ -1551,6 +1553,9 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_UNTRACKED:
 		istate->untracked = read_untracked_extension(data, sz);
 		break;
+	case CACHE_EXT_FASTINDEX:
+		/* already handled in do_read_index() */
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1604,10 +1609,12 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
  * number of bytes to be stripped from the end of the previous name,
  * and the bytes to append to the result, to come up with its name.
  */
-static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
+static unsigned long expand_name_field(struct strbuf *name, const char *cp_, int use_length)
 {
 	const unsigned char *ep, *cp = (const unsigned char *)cp_;
 	size_t len = decode_varint(&cp);
+	if (!use_length)
+		len = name->len;
 
 	if (name->len < len)
 		die("malformed name field in the index");
@@ -1618,9 +1625,10 @@ static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
 	return (const char *)ep + 1 - cp_;
 }
 
-static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
+struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 					    unsigned long *ent_size,
-					    struct strbuf *previous_name)
+					    struct strbuf *previous_name,
+						int use_length)
 {
 	struct cache_entry *ce;
 	size_t len;
@@ -1654,7 +1662,7 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 		*ent_size = ondisk_ce_size(ce);
 	} else {
 		unsigned long consumed;
-		consumed = expand_name_field(previous_name, name);
+		consumed = expand_name_field(previous_name, name, use_length);
 		ce = cache_entry_from_ondisk(ondisk, flags,
 					     previous_name->buf,
 					     previous_name->len);
@@ -1725,16 +1733,208 @@ static void post_read_index_from(struct index_state *istate)
 	tweak_split_index(istate);
 }
 
+static unsigned long load_cache_entries(struct index_state *istate, int offset, int nr, void *mmap, unsigned long start_offset)
+{
+	int i;
+	unsigned long src_offset = start_offset;
+	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
+
+	if (istate->version == 4)
+		previous_name = &previous_name_buf;
+	else
+		previous_name = NULL;
+
+	for (i = offset; i < offset + nr; i++) {
+		struct ondisk_cache_entry *disk_ce;
+		struct cache_entry *ce;
+		unsigned long consumed;
+
+		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		ce = create_from_disk(disk_ce, &consumed, previous_name, i == offset ? 0 : 1);
+		set_index_entry(istate, i, ce);
+
+		src_offset += consumed;
+	}
+	strbuf_release(&previous_name_buf);
+	return src_offset - start_offset;
+}
+
+#ifndef NO_PTHREADS
+
+/*
+ * Mostly randomly chosen cache entries per thread (it works on my machine):
+ * we want to have at least 7500 cache entries per thread for it to
+ * be worth starting a thread.
+ */
+#define THREAD_COST		(7500)
+#define IEOT_VERSION	(1)
+
+static int ce_write(git_SHA_CTX *context, int fd, void *data, unsigned int len);
+
+static int write_index_ext_header(git_SHA_CTX *context, int fd,
+	unsigned int ext, unsigned int sz);
+
+struct load_cache_entries_thread_data
+{
+	pthread_t pthread;
+	struct index_state *istate;
+	int offset;			/* starting index into the istate->cache array */
+	void *mmap;
+	unsigned long consumed;	/* return # of bytes in index file processed */
+	struct index_entry_offset_table *ieot;
+	int ieot_offset;	/* starting index into the ieot array */
+	int ieot_work;		/* count of ieot entries to process */
+};
+
+/*
+ * A thread proc to run the load_cache_entries() computation
+ * across multiple background threads.
+ */
+static void *load_cache_entries_thread(void *_data)
+{
+	struct load_cache_entries_thread_data *p = _data;
+	int i;
+
+	/* itterate across all ieot blocks assigned to this thread */
+	for (i = p->ieot_offset; i < p->ieot_offset + p->ieot_work; i++) {
+		p->consumed += load_cache_entries(p->istate, p->offset, p->ieot->entries[i].nr, p->mmap, p->ieot->entries[i].offset);
+		p->offset += p->ieot->entries[i].nr;
+	}
+	return NULL;
+}
+
+struct index_entry_offset_table *read_ieot_extension(void *mmap, size_t mmap_size)
+{
+	/*
+	 * The IEOT extension is guaranteed to be last so that it can be found
+	 * by scanning backwards from the EOF.  In addition to the regular 4-byte
+	 * extension name and 4-byte section length is network byte order, it
+	 * also stores the 4-byte extension name and section length in reverse order
+	 * at the end of the extension.
+	 *
+	 * IEOT
+	 * 4-byte length
+	 * 4-byte version
+	 * variable length extension data...
+	 * 4-byte version
+	 * 4-byte length
+	 * IEOT
+	 * <SHA1>
+	 *
+	 * If names, lengths and versions match, the extension is assumed to be valid.
+	 */
+	const char *index;
+	uint32_t extsize_leading, extsize_trailing, ext_version;
+	struct index_entry_offset_table *ieot;
+	int i, nr;
+
+	/* validate the trailing extension signature */
+	index = (const char *)mmap + mmap_size - GIT_SHA1_RAWSZ - 4;
+	if (CACHE_EXT(index) != CACHE_EXT_FASTINDEX)
+		return NULL;
+	index -= sizeof(uint32_t);
+
+	/*
+	 * Validate the offset we're going to look for the leading extension
+	 * signature is past the index header.
+	 */
+	extsize_trailing = get_be32(index);
+	if ((index - extsize_trailing) < ((const char *)mmap + 12))
+		return NULL;
+	index -= sizeof(uint32_t);
+
+	/* validate the trailing version is IEOT_VERSION */
+	ext_version = get_be32(index);
+	if (ext_version != IEOT_VERSION)
+		return NULL;
+	index -= (extsize_trailing - sizeof(uint32_t));
+
+	/* validate the leading extension signature */
+	if (CACHE_EXT(index) != CACHE_EXT_FASTINDEX)
+		return NULL;
+	index += sizeof(uint32_t);
+
+	/* validate the leading extension size */
+	extsize_leading = get_be32(index);
+	if (extsize_leading != extsize_trailing)
+		return NULL;
+	index += sizeof(uint32_t);
+
+	/* validate the leading version is IEOT_VERSION */
+	ext_version = get_be32(index);
+	if (ext_version != IEOT_VERSION)
+		return NULL;
+	index += sizeof(uint32_t);
+
+	/* extension size - leading/trailing version bytes - trailing size - trailing signature / bytes per entry */
+	nr = (extsize_leading - sizeof(uint32_t) - sizeof(uint32_t) - sizeof(uint32_t) - 4) / (sizeof(uint32_t) + sizeof(uint32_t));
+	assert(nr);
+	ieot = xmalloc(sizeof(struct index_entry_offset_table)
+		+ (nr * sizeof(struct index_entry_offset)));
+	ieot->nr = nr;
+	for (i = 0; i < nr; i++) {
+		ieot->entries[i].offset = get_be32(index);
+		index += sizeof(uint32_t);
+		ieot->entries[i].nr = get_be32(index);
+		index += sizeof(uint32_t);
+	}
+
+	return ieot;
+}
+
+static int write_ieot_extension(git_SHA_CTX *context, int fd, struct index_entry_offset_table *ieot)
+{
+	struct strbuf sb = STRBUF_INIT;
+	uint32_t buffer;
+	int i, err;
+
+	/* version */
+	put_be32(&buffer, IEOT_VERSION);
+	strbuf_add(&sb, &buffer, sizeof(uint32_t));
+
+	/* ieot */
+	for (i = 0; i < ieot->nr; i++) {
+
+		/* offset */
+		put_be32(&buffer, ieot->entries[i].offset);
+		strbuf_add(&sb, &buffer, sizeof(uint32_t));
+
+		/* count */
+		put_be32(&buffer, ieot->entries[i].nr);
+		strbuf_add(&sb, &buffer, sizeof(uint32_t));
+	}
+
+	/* version */
+	put_be32(&buffer, IEOT_VERSION);
+	strbuf_add(&sb, &buffer, sizeof(uint32_t));
+
+	/* size */
+	put_be32(&buffer, sb.len + sizeof(uint32_t) + 4);
+	strbuf_add(&sb, &buffer, sizeof(uint32_t));
+
+	/* signature */
+	put_be32(&buffer, CACHE_EXT_FASTINDEX);
+	strbuf_add(&sb, &buffer, 4);
+
+	/* leading signature and size + extension data */
+	err = write_index_ext_header(context, fd, CACHE_EXT_FASTINDEX, sb.len) < 0
+		|| ce_write(context, fd, sb.buf, sb.len) < 0;
+	strbuf_release(&sb);
+
+	return err;
+}
+
+#endif
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
-	int fd, i;
+	int fd;
 	struct stat st;
 	unsigned long src_offset;
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
-	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1771,24 +1971,75 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
 	istate->initialized = 1;
 
-	if (istate->version == 4)
-		previous_name = &previous_name_buf;
-	else
-		previous_name = NULL;
-
 	src_offset = sizeof(*hdr);
-	for (i = 0; i < istate->cache_nr; i++) {
-		struct ondisk_cache_entry *disk_ce;
-		struct cache_entry *ce;
-		unsigned long consumed;
+#ifdef NO_PTHREADS
+	src_offset += load_cache_entries(istate, 0, istate->cache_nr, mmap, src_offset);
+#else
+	if (git_config_get_fast_index() != 1) {
+		src_offset += load_cache_entries(istate, 0, istate->cache_nr, mmap, src_offset);
+	} else {
+		struct index_entry_offset_table *ieot;
+		int threads, cpus = online_cpus();
 
-		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce = create_from_disk(disk_ce, &consumed, previous_name);
-		set_index_entry(istate, i, ce);
+		threads = istate->cache_nr / THREAD_COST;
+		if (threads > cpus)
+			threads = cpus;
 
-		src_offset += consumed;
+		/* enable testing with fewer than default minimum of entries */
+		if (threads < 2 && getenv("GIT_FASTINDEX_TEST"))
+			threads = 2;
+
+		/*
+		 * Locate and read the fast index extension so that we can use it
+		 * to multi-thread the reading of the cache entries.
+		 */
+		ieot = read_ieot_extension(mmap, mmap_size);
+		if (threads < 2 || !ieot) {
+			src_offset += load_cache_entries(istate, 0, istate->cache_nr, mmap, src_offset);
+		} else {
+			int i, offset, ieot_work, ieot_offset;
+			struct load_cache_entries_thread_data *data;
+
+			/* ensure we have no more threads than we have blocks to process */
+			if (threads > ieot->nr)
+				threads = ieot->nr;
+			data = xcalloc(threads, sizeof(struct load_cache_entries_thread_data));
+
+			offset = ieot_offset = 0;
+			ieot_work = DIV_ROUND_UP(ieot->nr, threads);
+			for (i = 0; i < threads; i++) {
+				struct load_cache_entries_thread_data *p = &data[i];
+				int j;
+
+				if (ieot_offset + ieot_work > ieot->nr)
+					ieot_work = ieot->nr - ieot_offset;
+
+				p->istate = istate;
+				p->offset = offset;
+				p->mmap = mmap;
+				p->ieot = ieot;
+				p->ieot_offset = ieot_offset;
+				p->ieot_work = ieot_work;
+				if (pthread_create(&p->pthread, NULL, load_cache_entries_thread, p))
+					die("unable to create threaded load_cache_entries");
+
+				/* increment by the number of cache entries in the ieot block being processed */
+				for (j = 0; j < ieot_work; j++)
+					offset += ieot->entries[ieot_offset + j].nr;
+				ieot_offset += ieot_work;
+			}
+			for (i = 0; i < threads; i++) {
+				struct load_cache_entries_thread_data *p = data + i;
+				if (pthread_join(p->pthread, NULL))
+					die("unable to join threaded load_cache_entries");
+				src_offset += p->consumed;
+			}
+			free(data);
+		}
+		free(ieot);
 	}
-	strbuf_release(&previous_name_buf);
+#endif
+
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
@@ -2205,6 +2456,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct ondisk_cache_entry_extended ondisk;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = 0;
+	int ieot_work = 1;
+	struct index_entry_offset_table *ieot = NULL;
+	int offset, nr;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2238,6 +2492,22 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
+	if (!strip_extensions && core_fast_index) {
+		int ieot_blocks, cpus = online_cpus();
+
+		ieot_blocks = istate->cache_nr / THREAD_COST;
+		if (ieot_blocks < 1)
+			ieot_blocks = 1;
+		if (ieot_blocks > cpus)
+			ieot_blocks = cpus;
+		ieot = xcalloc(1, sizeof(struct index_entry_offset_table)
+			+ (ieot_blocks * sizeof(struct index_entry_offset)));
+		ieot->nr = 0;
+		ieot_work = DIV_ROUND_UP(entries, ieot_blocks);
+	}
+
+	offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+	nr = 0;
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
 
 	for (i = 0; i < entries; i++) {
@@ -2259,11 +2529,30 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 			drop_cache_tree = 1;
 		}
+		if (ieot && i && (i % ieot_work == 0)) {
+			ieot->entries[ieot->nr].nr = nr;
+			ieot->entries[ieot->nr].offset = offset;
+			ieot->nr++;
+			/*
+			 * If we have a V4 index, set the first byte to an invalid
+			 * character to ensure there is nothing common with the previous
+			 * entry
+			 */
+			if (previous_name)
+				previous_name->buf[0] = 0;
+			nr = 0;
+			offset = lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+		}
 		if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
 			err = -1;
-
 		if (err)
 			break;
+		nr++;
+	}
+	if (ieot && nr) {
+		ieot->entries[ieot->nr].nr = nr;
+		ieot->entries[ieot->nr].offset = offset;
+		ieot->nr++;
 	}
 	strbuf_release(&previous_name_buf);
 
@@ -2315,6 +2604,18 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
+	/*
+	 * CACHE_EXT_FASTINDEX must be written as the last entry before the SHA1
+	 * so that it can be found and processed before all the index entries are
+	 * read.
+	 */
+	if (!strip_extensions && ieot) {
+		err = write_ieot_extension(&c, newfd, ieot);
+		free(ieot);
+		if (err)
+			return -1;
+	}
+
 	if (ce_flush(&c, newfd, istate->sha1))
 		return -1;
 	if (close_tempfile_gently(tempfile)) {
-- 
2.15.0.windows.1

