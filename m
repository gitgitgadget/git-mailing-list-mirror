Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE661F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbeIGBlW (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:41:22 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:53953
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729281AbeIGBlW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSf8sk1eAvkPgd4yifpvg8R46V6DL/xVKDoJzmQ1bnk=;
 b=CjpzqQq2n8atK7Lc7QwadjocF/9f37w8DJ6IJObIqWH2R2T4y8v61T91ENWmomvlje8k6Hshwlqop8FeYehUr3v0XJfLHQ6WOEtDHg7tIar7MrrHmu/BM7PpF1fhOzAVilqym9fB1KzaicjYY2E1GRf8isfwR4WieZLrcEjDt6E=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1033.namprd21.prod.outlook.com (52.132.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Thu, 6 Sep 2018 21:03:59 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858%4]) with mapi id 15.20.1143.008; Thu, 6 Sep 2018
 21:03:59 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 4/4] read-cache: speed up index load through
 parallelization
Thread-Topic: [PATCH v3 4/4] read-cache: speed up index load through
 parallelization
Thread-Index: AQHURiUhq1RzrFmLIE66PDgRALLWKQ==
Date:   Thu, 6 Sep 2018 21:03:59 +0000
Message-ID: <20180906210227.54368-5-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com>
In-Reply-To: <20180906210227.54368-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: DM5PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:4:4c::31) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;6:5xGY3sQ8/PnT04D0oXoAS5Lsh5+ofeVhfhrkPlP/3G87AEPGASueQKxrSKG/sDycN56X3x9MJ4ag+HRzeYycQp4zxRhZyw8Sr0oyzmhAlCq5CQWT+7806lwvgopgrsgkVWMgjUlK+fCEVsXTCixt8lG0Oi6lDN9fz0uOLda1jqZOnE4/GJA69uIc2Xmx6JYhBuwQlM5Xf/+6WRNXS8oEE+Cw2mbR2a1S5DqsEAtcb3Q7g8BaxUhRZTv/npdgH7ZnKnjhoA73RCmT8YzVbekXGtBgH4wEdgrAOXqRCdz222lmp3at4enbHKGekfPxqBoljnD60Shx6ODdYi3me6SdTSivYD+Mv7ApgNySVuVO4mot+JXi5FjZYHdjTwG084xWQPiDbiXooKfpPEFVxxnXAPJkXTAjz+6nEMchG9xe+XoWxURmzCsoq/4kMBvCrv9il8DFxJ+pZmY2XWIaa+C90g==;5:qNwD0tQuO3eBvDtMsDJOPxujkx96Hn06XoeHai8QVaiXsg83dgn7J98xI53leuclTca8LyBqYvGWkU/84YZyAFukp1LwAJpEvsc6rLOlPLwpUL8in4dbtaKak4294DpaYVDZRC6kVdCH9EXJlkhB4L8TZ4mJhqQBu9FX+q1EIck=;7:HcrYTZUSleqT4dZAIGCrFIs4mVnsrz5jbqmIVy/+W1zwUwEBRr+BH+LCNGsfcJn7az9BWkRFkWZ7uIv4dL+UqXBhI3ymrw9icqsTh0IesLV9pr0VpPQXbuJB+m8Nl/tn4Df+7UE6HGvize38l2Y+GH9nmHI6ZBIb2fOJ85/kAsF+pN65fS/JyWcBZMuH16P0kZUrrXznp8yVKlGaA0QcF+t5bUpCvo1Q6HYJfmTNjCO48Eogn2gdpxyGWpx5z+tq
x-ms-office365-filtering-correlation-id: 8da4ec68-dbe5-4256-1eff-08d6143c43d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
x-microsoft-antispam-prvs: <MW2PR2101MB1033465368FB533175CCF25BF4010@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(476003)(2616005)(446003)(22452003)(102836004)(486006)(68736007)(39060400002)(2501003)(5250100002)(2351001)(1076002)(3846002)(53936002)(6116002)(50226002)(36756003)(186003)(6346003)(26005)(52116002)(76176011)(107886003)(14444005)(25786009)(386003)(316002)(6506007)(54906003)(8936002)(99286004)(11346002)(4326008)(72206003)(86612001)(6916009)(10090500001)(7736002)(5660300001)(14454004)(10290500003)(478600001)(2906002)(256004)(105586002)(305945005)(8676002)(81156014)(81166006)(1730700003)(66066001)(2900100001)(561924002)(106356001)(6436002)(97736004)(6486002)(6512007)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: hmYjp1hX6lX5I2BkOdwLRhCSwhMYc4J53sA7Wa/lf3DnTVo7mqA9YsGaMlswW8QjGQBa7XUUzMO3wMdPIETHtjmVk25w0i7aIeIKbAy4UtKOfBhQQZ0h1pzqeIxeLZ7xFv4RMN/4gj957pSFJkfQALy6tz7pkc76Et9mKDFDTvLNJJgJ0nC1YWHAJdCEDqbsteRtT7lLMl6tk1xjfFmxAFmx1LYazbz4VXV39C+/g/y7Xm3C0kQe2eyhbf63tjlAwdFI+xw4EDMW+CpveTL/9cdfNjc7uZ11E44r4DOzMWKm4BTRTQVSou/CI5Zi8jz+TPbj174iuxy1r+V7c2KYD12teBksqEEyqJ+ZXZEPdFQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da4ec68-dbe5-4256-1eff-08d6143c43d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 21:03:59.4962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
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
thread to process each block of entries as it comes to them.

I used p0002-read-cache.sh to generate some performance data:

p0002-read-cache.sh w/100,000 files
Baseline           Thread entries
------------------------------------------
20.71(0.03+0.03)   13.93(0.04+0.04) -32.7%

p0002-read-cache.sh w/1,000,000 files
Baseline            Thread entries
-------------------------------------------
217.60(0.03+0.04)   199.00(0.00+0.10) -8.6%

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 read-cache.c | 242 +++++++++++++++++++++++++++++++++++++++++++++------
 t/README     |   6 ++
 2 files changed, 220 insertions(+), 28 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index fcc776aaf0..8537a55750 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1941,20 +1941,212 @@ static void *load_index_extensions(void *_data)
 	return NULL;
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
+				estimate_cache_size_from_compressed(istate->cache_nr));
+	} else {
+		previous_name =3D NULL;
+		mem_pool_init(&istate->ce_mem_pool,
+				estimate_cache_size(mmap_size, istate->cache_nr));
+	}
+
+	consumed =3D load_cache_entry_block(istate, istate->ce_mem_pool,
+					0, istate->cache_nr, mmap, src_offset, previous_name);
+	strbuf_release(&previous_name_buf);
+	return consumed;
+}
+
+#ifndef NO_PTHREADS
+
+/*
+ * Mostly randomly chosen maximum thread counts: we
+ * cap the parallelism to online_cpus() threads, and we want
+ * to have at least 100000 cache entries per thread for it to
+ * be worth starting a thread.
+ */
+#define THREAD_COST		(10000)
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
+ * A thread proc to run the load_cache_entries() computation
+ * across multiple background threads.
+ */
+static void *load_cache_entries_thread(void *_data)
+{
+	struct load_cache_entries_thread_data *p =3D _data;
+
+	p->consumed +=3D load_cache_entry_block(p->istate, p->ce_mem_pool,
+		p->offset, p->nr, p->mmap, p->start_offset, p->previous_name);
+	return NULL;
+}
+
+static unsigned long load_cache_entries_threaded(int nr_threads, struct in=
dex_state *istate,
+			void *mmap, size_t mmap_size, unsigned long src_offset)
+{
+	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	struct load_cache_entries_thread_data *data;
+	int ce_per_thread;
+	unsigned long consumed;
+	int i, thread;
+
+	/* a little sanity checking */
+	if (istate->name_hash_initialized)
+		BUG("the name hash isn't thread safe");
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
+		if (i % ce_per_thread =3D=3D 0) {
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
+						estimate_cache_size_from_compressed(p->nr));
+			else
+				mem_pool_init(&p->ce_mem_pool,
+						estimate_cache_size(mmap_size, p->nr));
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
 	struct load_index_extensions p =3D { 0 };
 	unsigned long extension_offset =3D 0;
 #ifndef NO_PTHREADS
-	int nr_threads;
+	int cpus, nr_threads;
 #endif
=20
 	if (istate->initialized)
@@ -1996,10 +2188,20 @@ int do_read_index(struct index_state *istate, const=
 char *path, int must_exist)
 	p.mmap =3D mmap;
 	p.mmap_size =3D mmap_size;
=20
+	src_offset =3D sizeof(*hdr);
+
 #ifndef NO_PTHREADS
 	nr_threads =3D git_config_get_index_threads();
-	if (!nr_threads)
-		nr_threads =3D online_cpus();
+	if (!nr_threads) {
+		cpus =3D online_cpus();
+		nr_threads =3D istate->cache_nr / THREAD_COST;
+		if (nr_threads > cpus)
+			nr_threads =3D cpus;
+	}
+
+	/* enable testing with fewer than default minimum of entries */
+	if (istate->cache_nr > 1 && nr_threads < 3 && git_env_bool("GIT_TEST_INDE=
X_THREADS", 0))
+		nr_threads =3D 3;
=20
 	if (nr_threads >=3D 2) {
 		extension_offset =3D read_eoie_extension(mmap, mmap_size);
@@ -2008,33 +2210,17 @@ int do_read_index(struct index_state *istate, const=
 char *path, int must_exist)
 			p.src_offset =3D extension_offset;
 			if (pthread_create(&p.pthread, NULL, load_index_extensions, &p))
 				die(_("unable to create load_index_extensions_thread"));
+			nr_threads--;
 		}
 	}
+	if (nr_threads >=3D 2)
+		src_offset +=3D load_cache_entries_threaded(nr_threads, istate, mmap, mm=
ap_size, src_offset);
+	else
+		src_offset +=3D load_all_cache_entries(istate, mmap, mmap_size, src_offs=
et);
+#else
+	src_offset +=3D load_all_cache_entries(istate, mmap, mmap_size, src_offse=
t);
 #endif
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
-	src_offset =3D sizeof(*hdr);
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
 	istate->timestamp.sec =3D st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
=20
diff --git a/t/README b/t/README
index d8754dd23a..59015f7150 100644
--- a/t/README
+++ b/t/README
@@ -324,6 +324,12 @@ This is used to allow tests 1, 4-9 in t1700-split-inde=
x.sh to succeed
 as they currently hard code SHA values for the index which are no longer
 valid due to the addition of the EOIE extension.
=20
+GIT_TEST_INDEX_THREADS=3D<boolean> forces multi-threaded loading of
+the index cache entries and extensions for the whole test suite.
+
 Naming Tests
 ------------
=20
--=20
2.18.0.windows.1

