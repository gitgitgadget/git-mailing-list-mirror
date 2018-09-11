Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE851F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbeILE2U (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:28:20 -0400
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:1880
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbeILE2U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDlqD8AB26clchFncoKDaD5GJe10Q2ptMeV3mXv0HfU=;
 b=cFWtVIWuVVwzQXMgxoVhBDH++sNMjsYr++1ZldPITfO8+x5CUE5T8q/yeHBSEp/0mb9dgwQq7ChM3U+YS3tBN4LsfMJ6DkQZbpaRlePVCWwp85GgZnsQ0tJCLAwQ/L2jMQD+5/oRWPDSQVCPbkPKl19uDy5pZ+5QhskTiDuKO1o=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Tue, 11 Sep 2018 23:26:39 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.006; Tue, 11 Sep 2018
 23:26:38 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v4 3/5] read-cache: speed up index load through
 parallelization
Thread-Topic: [PATCH v4 3/5] read-cache: speed up index load through
 parallelization
Thread-Index: AQHUSibj7wYRqAwsWkCACmaYa/1R8Q==
Date:   Tue, 11 Sep 2018 23:26:38 +0000
Message-ID: <20180911232615.35904-4-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180911232615.35904-1-benpeart@microsoft.com>
In-Reply-To: <20180911232615.35904-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY4PR1601CA0021.namprd16.prod.outlook.com
 (2603:10b6:910:72::34) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:hU44TBTPTMA7TsSkknEfnz9d9b0nrxZ9VD79srpyjVXrUmqePUQK4vIRf9nVUbKhepAekwsJAGN2CIMhLkaADvzym+XhW4nX0QUz0B35kkXSVBEpCWS2LjEIlDUeLOFfU4CMnC1I5GIYxLLQxpd9/74G+IxGYfrGx4SEwtts/OdavvN1o8/mgxpaxwc6rIyNtxvGG73tT3yN9zn2sb9v2WAqyuHDFULDYQiP8rrpL0y3HxAZ/EMWlJrLel0wLIBEP9XKEN9rTz7fYUklUEEy5H302M9ZSmlj0AMeTxSVG+mA3ModdO2LCOuqg5I6cPeSjHFEQGDTv0r5fi0Q9e/fFqYFkykxgqPC1/eNJTDbTgHwBPxDZSi8MeO9fIZIvWOR4rCJjp/RCapFPh+ozEB3N2FQBQfA762tatmmnFwuzQc1TdPwQdi71TZciQiMaXof5hu/ywd6aoJfq+MNkd2TDQ==;5:aaX0zRtIqLxDX3SWKpXNhpZ4P/j6jGYyKbamfAk6R4mb/Q0SEVDdOaU18llSVr8zKsXp1VmWtTVXubBwxYUQTgA56xsdXGir0dtJpAbsuLKhpnMtpT+rxLK4lyhHhSGTzcMD+G4AkD3pHMh7pGvVHZvDFQJpeBDlyTZd6tbx8eM=;7:L3hlNuBAEvf3YlzJR56s2CngN6xnQGzc2A15mYRgCQjnTYCKIU5o3UhW/RU/K89LT7HBFq2aOLVhN+A1PHoqdDkiMJX2ZAPDlWqndDpQVe89DNGiCFyJ+P7obersZdS8ohQyrqZjwUE19HbB5H/ztBV8/hlDtWCwgFPBaCXz6t8X6QtetVHH7Y6iUX1A4P0JUKK9ZY4sVce7JlW/84uI5gJSubEoJGMV1nIXtzwytApQo0Nmj02l7mxOImUsLmzw
x-ms-office365-filtering-correlation-id: 9b1a2008-c0ac-4d91-0b9a-08d6183e05bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113CBB5D46B63A246CD01AEF4040@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699050)(76991037);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(386003)(6116002)(97736004)(6506007)(86612001)(7736002)(5640700003)(81156014)(81166006)(26005)(2900100001)(102836004)(6436002)(1730700003)(6346003)(305945005)(561924002)(11346002)(14444005)(446003)(2616005)(476003)(486006)(3846002)(256004)(36756003)(10090500001)(66066001)(186003)(53936002)(1076002)(106356001)(105586002)(2351001)(6512007)(316002)(4326008)(54906003)(2906002)(52116002)(25786009)(5660300001)(107886003)(68736007)(22452003)(76176011)(39060400002)(6916009)(50226002)(478600001)(2501003)(99286004)(72206003)(14454004)(5250100002)(8936002)(8676002)(10290500003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: DOX/A4eyYVORxrGaSo9cOIOI046dAMUo7dmwxAJmaAgxfyLosaQjFbF8EuUKoFzC8IhY5difPd9kcEqkMJWbEoh0tQxFIhoE5p1OZvPcbAYjyOn5T8wcme4PWwIQ/AYq32wzGgBOHNsviccTpDBdErvHj5np4wqbGXTxuPWAaAT/LMkmhRQMd1NdBkWE8a3J3z+7P0cFa2MgwZ52d+WanoaZjJU0ZtSMCI9oE7mLpBRWCynIGAuG2O8GXt5lEhCXtGEmKuEMUIRIdRZ+HOh0UEpUjs5rGuog0cs5ylBMKnmPXzx8y4GSQkCYHpdWL/ChJ/926V4XsNx6Qe2BMGO0VgQz4IiWheKcg+01yfTdF1U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1a2008-c0ac-4d91-0b9a-08d6183e05bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 23:26:38.7530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
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

Test w/100,000 files                Baseline         Parallel entries
---------------------------------------------------------------------------
read_cache/discard_cache 1000 times 14.08(0.01+0.10) 9.72(0.03+0.06) -31.0%

Test w/1,000,000 files              Baseline         Parallel entries
---------------------------------------------------------------------------=
---
read_cache/discard_cache 1000 times 202.95(0.01+0.07) 154.14(0.03+0.06) -24=
.1%

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 read-cache.c | 240 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 212 insertions(+), 28 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9b97c29f5b..c01d34a71d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1942,20 +1942,210 @@ static void *load_index_extensions(void *_data)
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
+		mem_pool_init(&istate->ce_mem_pool, istate->cache_nr * (sizeof(struct ca=
che_entry) + CACHE_ENTRY_PATH_LENGTH));
+	} else {
+		previous_name =3D NULL;
+		mem_pool_init(&istate->ce_mem_pool, estimate_cache_size(mmap_size, istat=
e->cache_nr));
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
+ * to have at least 10000 cache entries per thread for it to
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
+					estimate_cache_size_from_compressed(p->nr));
+			else
+				mem_pool_init(&p->ce_mem_pool,
+					estimate_cache_size(mmap_size, p->nr));
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
@@ -1997,10 +2187,20 @@ int do_read_index(struct index_state *istate, const=
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
+	if (istate->cache_nr > 1 && nr_threads < 3 && git_env_bool("GIT_INDEX_THR=
EADS_TEST", 0))
+		nr_threads =3D 3;
=20
 	if (nr_threads >=3D 2) {
 		extension_offset =3D read_eoie_extension(mmap, mmap_size);
@@ -2009,33 +2209,17 @@ int do_read_index(struct index_state *istate, const=
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
--=20
2.18.0.windows.1

