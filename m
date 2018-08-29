Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98A41F404
	for <e@80x24.org>; Wed, 29 Aug 2018 15:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeH2TXY (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 15:23:24 -0400
Received: from mail-eopbgr690122.outbound.protection.outlook.com ([40.107.69.122]:6608
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728903AbeH2TXX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 15:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3k2mhxw1qs/0vw+PYvOnDqAGuZPGiFHclAS3iS6WZw=;
 b=YLG9E4fUaVdqbXJZm4kBgo2B+hpQn8kkCI9wVtHbndoirCmpxnewEi+9+/hp8j+cQQgv6JNn5wjIfkXJua1DrBduLA3bvwwrjGVlrHORMFUNi4BdfG0dl9nMo8RvjbH5wuMH1aTaB9azO5u3YkIJQirtWQpOVWlIDfnPBMeOnKI=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0972.namprd21.prod.outlook.com (52.132.146.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Wed, 29 Aug 2018 15:25:19 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf%3]) with mapi id 15.20.1122.000; Wed, 29 Aug 2018
 15:25:19 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2 1/3] read-cache: speed up index load through
 parallelization
Thread-Topic: [PATCH v2 1/3] read-cache: speed up index load through
 parallelization
Thread-Index: AQHUP6x+Qigsb1YKekyjCoHYqseIfQ==
Date:   Wed, 29 Aug 2018 15:25:19 +0000
Message-ID: <20180829152500.46640-2-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180829152500.46640-1-benpeart@microsoft.com>
In-Reply-To: <20180829152500.46640-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: BN6PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:405:70::11) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0972;6:tQTj6H8X3x1b4PNqG89ayS/3h4IAfiMiBRImvUdGVGSWKZkk7z6BBCNXdT7oeLzGGNx0ALwZE0qq5qhfSlRQOGNHQaoOSNFcAmBsqMuj1baRECUU8MH901pMM3RyGg5bGhXHtipiZjSCnrRT/6SrjFZL9csNJwbiewwphKdpopxmAEnVsCS8Fe9fL2aGgC6j5SowvGxv0nZOcCIijx6kafyoeIkZIWZELmDrRg6THILP2WX57kbi4BmKdK+efO0daWOZ8HUkV3EBzmWDk7FAadRZkNOwRBOTeQQ/33H7YG+02d5lTA1GvWtXXxeckU+zhvU1XmsYEiUy4yz46Lh6JuplDIx0eMjoRrOeoFZOeBN+3ukK7edVh4Q9h6wgP1MzNu4ga3fJH3a+j4d0sp9FojLvUISyPmAJ5uFnSEdN1i8laGrW7kMcyIIWqk0pqqi/BcFZHQSDCduZLYDkNFQfDg==;5:2k6c2qmhvNlmLaqXwXLwnalYC8D+8SF7dfMahbRJ9UfcZgBnRzWE6e7zzNAat56mriiZd1PvAp9XdVtxshSSdoCCb7jzT7F4ykv9jayfng/LzFfB0bqhXrPpbf/gFxUkRj6pZpNA6KODMtJNgFPXzV03Oj31YkqfRnTijTLx9j8=;7:rZo4WFiDuFqVu4Yxi1l/AGWsCiOU1rgJICF9JObcxyfWnSSSKzeLIChLDtHGaXNzkv2uEjjmAjxfYZXSRx+uw6nY+hMDYOjXQFVTc2MMUSra7aGNXEQqWyIZ1ZvHx1Wq/6uDi1jDYicvUseDJa6wgg7QJCmHo9SPHPfV6+aRGgPcMIfwnEOqXmDkhKUXc9bl4qKSbQNiwgm6bZDjC7DrtbBtOsVyA7mA0iYyCDu821o2IC/fEwsGBbt9jRUYLvyN
x-ms-office365-filtering-correlation-id: 6e4e2a10-bac6-4797-c4af-08d60dc3a0e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0972;
x-ms-traffictypediagnostic: MW2PR2101MB0972:
x-microsoft-antispam-prvs: <MW2PR2101MB0972C3E95B3DF882F464F41EF4090@MW2PR2101MB0972.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB0972;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0972;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(102836004)(5660300001)(256004)(6916009)(14444005)(97736004)(2900100001)(6346003)(386003)(4326008)(6506007)(26005)(10090500001)(3846002)(316002)(7736002)(54906003)(1076002)(39060400002)(36756003)(5640700003)(22452003)(107886003)(305945005)(6436002)(561924002)(6512007)(6486002)(6116002)(476003)(68736007)(81166006)(81156014)(186003)(5250100002)(575784001)(2616005)(86612001)(25786009)(76176011)(8936002)(1730700003)(52116002)(10290500003)(53936002)(66066001)(2906002)(72206003)(14454004)(11346002)(478600001)(50226002)(8676002)(486006)(99286004)(2351001)(106356001)(105586002)(446003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0972;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: gkXRLpjTCerRNNjVJpycScqp6+AxWpqqlCLgkJYlxAm7kWuWeLbFW5rja+sZjSrT/5K6t3vHPWN3kM+97StrhQV3NKWkHei5a3HYSrQaeqYpZzGO5hl/fWiKITMK6QVMOjVlpEnYE7wX0oSAZ4zikxxLNZXCDGXWU/rXracfz4EgoeNeGNCherFU52HVjN5gtIePBEBJz4qx2evH4OnJdw1KI/57j4+EYgTFlYHXeTbo0acWusVZiyjjGRTNNCISvEa1zcqOEN2QgVAl5IWb1hbCmXEkThPA1Ioc3xWN+Zx4lVLmP7rTR4q31tvUTTVIXavMRvPP5uK4rF9rWeDWOSeZ11OhW/UFi25VqRcfFC4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4e2a10-bac6-4797-c4af-08d60dc3a0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 15:25:19.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0972
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch helps address the CPU cost of loading the index by creating
multiple threads to divide the work of loading and converting the cache
entries across all available CPU cores.

It accomplishes this by having the primary thread loop across the index fil=
e
tracking the offset and (for V4 indexes) expanding the name. It creates a
thread to process each block of entries as it comes to them. Once the
threads are complete and the cache entries are loaded, the rest of the
extensions can be loaded and processed normally on the primary thread.

I used p0002-read-cache.sh to generate some performance data:

100,000 entries

Test                                HEAD~3           HEAD~2
---------------------------------------------------------------------------
read_cache/discard_cache 1000 times 14.02(0.01+0.12) 9.81(0.01+0.07) -30.0%

1,000,000 entries

Test                                HEAD~3            HEAD~2
---------------------------------------------------------------------------=
---
read_cache/discard_cache 1000 times 202.06(0.06+0.09) 155.72(0.03+0.06) -22=
.9%

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 Documentation/config.txt |   6 +
 config.c                 |  14 +++
 config.h                 |   1 +
 read-cache.c             | 240 +++++++++++++++++++++++++++++++++++----
 4 files changed, 237 insertions(+), 24 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1c42364988..79f8296d9c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2391,6 +2391,12 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
=20
+index.threads::
+	Specifies the number of threads to spawn when loading the index.
+	This is meant to reduce index load time on multiprocessor machines.
+	Specifying 0 or 'true' will cause Git to auto-detect the number of
+	CPU's and set the number of threads accordingly. Defaults to 'true'.
+
 index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
diff --git a/config.c b/config.c
index 9a0b10d4bc..3bda124550 100644
--- a/config.c
+++ b/config.c
@@ -2289,6 +2289,20 @@ int git_config_get_fsmonitor(void)
 	return 0;
 }
=20
+int git_config_get_index_threads(void)
+{
+	int is_bool, val;
+
+	if (!git_config_get_bool_or_int("index.threads", &is_bool, &val)) {
+		if (is_bool)
+			return val ? 0 : 1;
+		else
+			return val;
+	}
+
+	return 0; /* auto-detect */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int line=
nr)
 {
diff --git a/config.h b/config.h
index ab46e0165d..a06027e69b 100644
--- a/config.h
+++ b/config.h
@@ -250,6 +250,7 @@ extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 extern int git_config_get_fsmonitor(void);
+extern int git_config_get_index_threads(void);
=20
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..c30346388a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1889,16 +1889,229 @@ static size_t estimate_cache_size(size_t ondisk_si=
ze, unsigned int entries)
 	return ondisk_size + entries * per_entry;
 }
=20
+/*
+ * A helper function that will load the specified range of cache entries
+ * from the memory mapped file and add them to the given index.
+ */
+static unsigned long load_cache_entry_block(struct index_state *istate,
+			struct mem_pool *ce_mem_pool, int offset, int nr, void *mmap,
+			unsigned long start_offset, struct strbuf *previous_name)
+{
+	int i;
+	unsigned long src_offset =3D start_offset;
+
+	for (i =3D offset; i < offset + nr; i++) {
+		struct ondisk_cache_entry *disk_ce;
+		struct cache_entry *ce;
+		unsigned long consumed;
+
+		disk_ce =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		ce =3D create_from_disk(ce_mem_pool, disk_ce, &consumed, previous_name);
+		set_index_entry(istate, i, ce);
+
+		src_offset +=3D consumed;
+	}
+	return src_offset - start_offset;
+}
+
+static unsigned long load_all_cache_entries(struct index_state *istate,
+			void *mmap, size_t mmap_size, unsigned long src_offset)
+{
+	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	unsigned long consumed;
+
+	if (istate->version =3D=3D 4) {
+		previous_name =3D &previous_name_buf;
+		mem_pool_init(&istate->ce_mem_pool,
+			      estimate_cache_size_from_compressed(istate->cache_nr));
+	} else {
+		previous_name =3D NULL;
+		mem_pool_init(&istate->ce_mem_pool,
+			      estimate_cache_size(mmap_size, istate->cache_nr));
+	}
+
+	consumed =3D load_cache_entry_block(istate, istate->ce_mem_pool,
+					0, istate->cache_nr, mmap, src_offset, previous_name);
+	strbuf_release(&previous_name_buf);
+	return consumed;
+}
+
+#ifdef NO_PTHREADS
+
+#define load_cache_entries load_all_cache_entries
+
+#else
+
+#include "thread-utils.h"
+
+/*
+* Mostly randomly chosen maximum thread counts: we
+* cap the parallelism to online_cpus() threads, and we want
+* to have at least 7500 cache entries per thread for it to
+* be worth starting a thread.
+*/
+#define THREAD_COST		(7500)
+
+struct load_cache_entries_thread_data
+{
+	pthread_t pthread;
+	struct index_state *istate;
+	struct mem_pool *ce_mem_pool;
+	int offset, nr;
+	void *mmap;
+	unsigned long start_offset;
+	struct strbuf previous_name_buf;
+	struct strbuf *previous_name;
+	unsigned long consumed;	/* return # of bytes in index file processed */
+};
+
+/*
+* A thread proc to run the load_cache_entries() computation
+* across multiple background threads.
+*/
+static void *load_cache_entries_thread(void *_data)
+{
+	struct load_cache_entries_thread_data *p =3D _data;
+
+	p->consumed +=3D load_cache_entry_block(p->istate, p->ce_mem_pool,
+		p->offset, p->nr, p->mmap, p->start_offset, p->previous_name);
+	return NULL;
+}
+
+static unsigned long load_cache_entries(struct index_state *istate,
+			void *mmap, size_t mmap_size, unsigned long src_offset)
+{
+	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	struct load_cache_entries_thread_data *data;
+	int nr_threads, cpus, ce_per_thread;
+	unsigned long consumed;
+	int i, thread;
+
+	nr_threads =3D git_config_get_index_threads();
+	if (!nr_threads) {
+		cpus =3D online_cpus();
+		nr_threads =3D istate->cache_nr / THREAD_COST;
+		if (nr_threads > cpus)
+			nr_threads =3D cpus;
+	}
+
+	/* enable testing with fewer than default minimum of entries */
+	if ((istate->cache_nr > 1) && (nr_threads < 2) && git_env_bool("GIT_INDEX=
_THREADS_TEST", 0))
+		nr_threads =3D 2;
+
+	if (nr_threads < 2)
+		return load_all_cache_entries(istate, mmap, mmap_size, src_offset);
+
+	/* a little sanity checking */
+	if (istate->name_hash_initialized)
+		die("the name hash isn't thread safe");
+
+	mem_pool_init(&istate->ce_mem_pool, 0);
+	if (istate->version =3D=3D 4)
+		previous_name =3D &previous_name_buf;
+	else
+		previous_name =3D NULL;
+
+	ce_per_thread =3D DIV_ROUND_UP(istate->cache_nr, nr_threads);
+	data =3D xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data=
));
+
+	/*
+	 * Loop through index entries starting a thread for every ce_per_thread
+	 * entries. Exit the loop when we've created the final thread (no need
+	 * to parse the remaining entries.
+	 */
+	consumed =3D thread =3D 0;
+	for (i =3D 0; ; i++) {
+		struct ondisk_cache_entry *ondisk;
+		const char *name;
+		unsigned int flags;
+
+		/*
+		 * we've reached the beginning of a block of cache entries,
+		 * kick off a thread to process them
+		 */
+		if (0 =3D=3D i % ce_per_thread) {
+			struct load_cache_entries_thread_data *p =3D &data[thread];
+
+			p->istate =3D istate;
+			p->offset =3D i;
+			p->nr =3D ce_per_thread < istate->cache_nr - i ? ce_per_thread : istate=
->cache_nr - i;
+
+			/* create a mem_pool for each thread */
+			if (istate->version =3D=3D 4)
+				mem_pool_init(&p->ce_mem_pool,
+						  estimate_cache_size_from_compressed(p->nr));
+			else
+				mem_pool_init(&p->ce_mem_pool,
+						  estimate_cache_size(mmap_size, p->nr));
+
+			p->mmap =3D mmap;
+			p->start_offset =3D src_offset;
+			if (previous_name) {
+				strbuf_addbuf(&p->previous_name_buf, previous_name);
+				p->previous_name =3D &p->previous_name_buf;
+			}
+
+			if (pthread_create(&p->pthread, NULL, load_cache_entries_thread, p))
+				die("unable to create load_cache_entries_thread");
+
+			/* exit the loop when we've created the last thread */
+			if (++thread =3D=3D nr_threads)
+				break;
+		}
+
+		ondisk =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+
+		/* On-disk flags are just 16 bits */
+		flags =3D get_be16(&ondisk->flags);
+
+		if (flags & CE_EXTENDED) {
+			struct ondisk_cache_entry_extended *ondisk2;
+			ondisk2 =3D (struct ondisk_cache_entry_extended *)ondisk;
+			name =3D ondisk2->name;
+		} else
+			name =3D ondisk->name;
+
+		if (!previous_name) {
+			size_t len;
+
+			/* v3 and earlier */
+			len =3D flags & CE_NAMEMASK;
+			if (len =3D=3D CE_NAMEMASK)
+				len =3D strlen(name);
+			src_offset +=3D (flags & CE_EXTENDED) ?
+				ondisk_cache_entry_extended_size(len) :
+				ondisk_cache_entry_size(len);
+		} else
+			src_offset +=3D (name - ((char *)ondisk)) + expand_name_field(previous_=
name, name);
+	}
+
+	for (i =3D 0; i < nr_threads; i++) {
+		struct load_cache_entries_thread_data *p =3D data + i;
+		if (pthread_join(p->pthread, NULL))
+			die("unable to join load_cache_entries_thread");
+		mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
+		strbuf_release(&p->previous_name_buf);
+		consumed +=3D p->consumed;
+	}
+
+	free(data);
+	strbuf_release(&previous_name_buf);
+
+	return consumed;
+}
+
+#endif
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_e=
xist)
 {
-	int fd, i;
+	int fd;
 	struct stat st;
 	unsigned long src_offset;
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
-	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
=20
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1935,29 +2148,8 @@ int do_read_index(struct index_state *istate, const =
char *path, int must_exist)
 	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(*istate->cache));
 	istate->initialized =3D 1;
=20
-	if (istate->version =3D=3D 4) {
-		previous_name =3D &previous_name_buf;
-		mem_pool_init(&istate->ce_mem_pool,
-			      estimate_cache_size_from_compressed(istate->cache_nr));
-	} else {
-		previous_name =3D NULL;
-		mem_pool_init(&istate->ce_mem_pool,
-			      estimate_cache_size(mmap_size, istate->cache_nr));
-	}
-
 	src_offset =3D sizeof(*hdr);
-	for (i =3D 0; i < istate->cache_nr; i++) {
-		struct ondisk_cache_entry *disk_ce;
-		struct cache_entry *ce;
-		unsigned long consumed;
-
-		disk_ce =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce =3D create_from_disk(istate->ce_mem_pool, disk_ce, &consumed, previou=
s_name);
-		set_index_entry(istate, i, ce);
-
-		src_offset +=3D consumed;
-	}
-	strbuf_release(&previous_name_buf);
+	src_offset +=3D load_cache_entries(istate, mmap, mmap_size, src_offset);
 	istate->timestamp.sec =3D st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
=20
--=20
2.18.0.windows.1

