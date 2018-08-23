Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29C11F954
	for <e@80x24.org>; Thu, 23 Aug 2018 15:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeHWTPc (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 15:15:32 -0400
Received: from mail-eopbgr700121.outbound.protection.outlook.com ([40.107.70.121]:24992
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbeHWTPb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 15:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0YtIYNev/Q7SgrcfPf86ySE715FG2+hBs4pEXbczhs=;
 b=giQQO7CWzaoeXiuOUKMWvK8yRpw6XV1XAGUK49q2Og1MULcmxPtx+jy3i3sSznLueXZswQIcLK6QhQi9O3Dck/Vg3MpgWS+O/9P7Kkgoy/HWmunH2B/xe+59+aIb6gKojY7yf7ku56H8aIIOVUL8KkannwrIVJUx0yh1yp5ydDw=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0892.namprd21.prod.outlook.com (52.132.152.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Thu, 23 Aug 2018 15:41:12 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf%3]) with mapi id 15.20.1101.007; Thu, 23 Aug 2018
 15:41:12 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] read-cache: speed up index load through parallelization
Thread-Topic: [PATCH v1] read-cache: speed up index load through
 parallelization
Thread-Index: AQHUOve4uFWQ1nAzZ0q8oX/6ULh64A==
Date:   Thu, 23 Aug 2018 15:41:12 +0000
Message-ID: <20180823154053.20212-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: BN4PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:403:2::32) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0892;6:dUK6+Uq5hZK7RBkeSqBp9n+PP0/8hNZ5AHUx8cw4JI6VcK+p34OQDshUITrztwuhj3GO6SWNqItTJkgARaPaAzZO01od6yPvQ7TPcFlqxXdYFlY+HDXixvBdR3h9D5pZfpVeZCCpfAng4QpteFcfBW4mOCM19M1T+oOJefUHHU/+6QRVYahFUL0Ty2WWy+MgkhtNh0qs/EJVNrvShBrcz0G67J/VN7fXTXehLbf7bZo+QVGXYqoNzQntDfUU4V5CY7+kCz3m1io/sG97P5xEqBIFH9ZCf5Ll6lnm+aAwE3Gej2cTVkByLNPIfcW98arbDRuvEb+CY2Cuy27QX47XFYffzrhZ4tr7tWZXUegWL9AU6nHqVD1e5VKA+05C90CShlipF/lYzcbrQlZPUjAalMz0G9zDnjKkxpnlejxbOWAmaBHqlaprn4JW5VTr76xJe42KoaOQATGAneJyLtteXg==;5:j6nrCIA5BMwleQGP9rqUfBe9SlajkHVw+BZcv5ts5DR5M0Faxxc6d3JZCV5XQEnWCZQyqWKgmQIN2JkEozXUIIqFK4TJC3wXtiOWx0UnYSDcCu0s2TxBxRNsKZNsjSh8NO5Q0ykaJwBGmxRnMVSmjtAEBhfrtTm9FN6v4ENCGwE=;7:9hNzf0TJKmTFor5CXNlkSp1R2gt8zmNL4XdwxGxXGcjaz8FkXjonUUsL8FYTiWvRpahZIASvRvO4ITPvJeJvp91tflGH2L0SJOxOqaPUOf/ja1QGLofiZuFQb41l2ijHmkFSvcvesTZ2BjJJ4tASfIS2Qiph7OlruulC/V1accMEQr3dgBGZ2GKwrBeI5pE2U0r4lmngqXe011XAaS2uJdOKbsgMjJUVf1HuMzdnFLgUelnCK/XH+j9jzqR/Whrk
x-ms-office365-filtering-correlation-id: 4b0e4151-b4c5-4a37-5df3-08d6090eda1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0892;
x-ms-traffictypediagnostic: MW2PR2101MB0892:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB08920C4926389A0453F6EF27F4370@MW2PR2101MB0892.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231336)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699037)(76991021);SRVR:MW2PR2101MB0892;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0892;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(10090500001)(2351001)(575784001)(86612001)(50226002)(97736004)(25786009)(305945005)(8936002)(2906002)(7736002)(5660300001)(316002)(6916009)(66066001)(3846002)(6116002)(54906003)(52116002)(105586002)(22452003)(99286004)(1076002)(106356001)(6512007)(2900100001)(36756003)(26005)(81166006)(256004)(14444005)(6306002)(486006)(561924002)(102836004)(53936002)(8676002)(476003)(2616005)(386003)(186003)(6506007)(107886003)(68736007)(14454004)(10290500003)(72206003)(966005)(478600001)(4326008)(5250100002)(6486002)(5640700003)(6436002)(2501003)(1730700003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0892;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z9uHZdkTuQbCnCy35nhqTUGl4HjwHTErzm3iFs0dEtIlWXLe9jpbZPragiaezyHi8wB8qsymCnL27c7mmPr3b8B9QWqurGHw8DHu9PDSHOPLL6tykLahCCv1qw2uCPTMGvoyde55Y2zPxBF65xtI0qZazhE+GJuOOcwy1bL1jq9qpBSfIdEhE236gdvJVnfpg2Gr2zZEyctquWSQbzK87nZU8pi9IFdS/Ug2JOrQHtD5h1Li1UADc5JrOn2NSRyGuaocR2uoZBP8UgEOXhpQjmrXaJGCSMAo6hDpVjod68JSor0fdGOkR29g5xkW0yIbpw+Kdp4S6bwCQiIVifqsjIfzaY9xvxQ0xwmeMNxxIBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0e4151-b4c5-4a37-5df3-08d6090eda1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 15:41:12.5486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0892
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

Performance impact:

read cache .git/index times on a synthetic repo with:

100,000 entries
FALSE       TRUE        Savings     %Savings
0.014798767 0.009580433 0.005218333 35.26%

1,000,000 entries
FALSE       TRUE        Savings     %Savings
0.240896533 0.1751243   0.065772233 27.30%

read cache .git/index times on an actual repo with:

~3M entries
FALSE       TRUE        Savings     %Savings
0.59898098  0.4513169   0.14766408  24.65%

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/67a700419b
    Checkout: git fetch https://github.com/benpeart/git read-index-multithr=
ead-v1 && git checkout 67a700419b

 Documentation/config.txt |   8 ++
 config.c                 |  13 +++
 config.h                 |   1 +
 read-cache.c             | 218 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 216 insertions(+), 24 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1c42364988..3344685cc4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -899,6 +899,14 @@ relatively high IO latencies.  When enabled, Git will =
do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.  Defaults to true.
=20
+core.fastIndex::
+       Enable parallel index loading
++
+This can speed up operations like 'git diff' and 'git status' especially
+when the index is very large.  When enabled, Git will do the index
+loading from the on disk format to the in-memory format in parallel.
+Defaults to true.
+
 core.createObject::
 	You can set this to 'link', in which case a hardlink followed by
 	a delete of the source are used to make sure that object creation
diff --git a/config.c b/config.c
index 9a0b10d4bc..883092fdd3 100644
--- a/config.c
+++ b/config.c
@@ -2289,6 +2289,19 @@ int git_config_get_fsmonitor(void)
 	return 0;
 }
=20
+int git_config_get_fast_index(void)
+{
+	int val;
+
+	if (!git_config_get_maybe_bool("core.fastindex", &val))
+		return val;
+
+	if (getenv("GIT_FASTINDEX_TEST"))
+		return 1;
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int line=
nr)
 {
diff --git a/config.h b/config.h
index ab46e0165d..74ca4e7db5 100644
--- a/config.h
+++ b/config.h
@@ -250,6 +250,7 @@ extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 extern int git_config_get_fsmonitor(void);
+extern int git_config_get_fast_index(void);
=20
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..0fa7e1a04c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -24,6 +24,10 @@
 #include "utf8.h"
 #include "fsmonitor.h"
=20
+#ifndef min
+#define min(a,b) (((a) < (b)) ? (a) : (b))
+#endif
+
 /* Mask for the name length in ce_flags in the on-disk index */
=20
 #define CE_NAMEMASK  (0x0fff)
@@ -1889,16 +1893,203 @@ static size_t estimate_cache_size(size_t ondisk_si=
ze, unsigned int entries)
 	return ondisk_size + entries * per_entry;
 }
=20
+static unsigned long load_cache_entry_block(struct index_state *istate, st=
ruct mem_pool *ce_mem_pool, int offset, int nr, void *mmap, unsigned long s=
tart_offset, struct strbuf *previous_name)
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
+static unsigned long load_all_cache_entries(struct index_state *istate, vo=
id *mmap, size_t mmap_size, unsigned long src_offset)
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
+	consumed =3D load_cache_entry_block(istate, istate->ce_mem_pool, 0, istat=
e->cache_nr, mmap, src_offset, previous_name);
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
+	p->consumed +=3D load_cache_entry_block(p->istate, p->ce_mem_pool, p->off=
set, p->nr, p->mmap, p->start_offset, p->previous_name);
+	return NULL;
+}
+
+static unsigned long load_cache_entries(struct index_state *istate, void *=
mmap, size_t mmap_size, unsigned long src_offset)
+{
+	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	struct load_cache_entries_thread_data *data;
+	int threads, cpus, thread_nr;
+	unsigned long consumed;
+	int i, thread;
+
+	cpus =3D online_cpus();
+	threads =3D istate->cache_nr / THREAD_COST;
+	if (threads > cpus)
+		threads =3D cpus;
+
+	/* enable testing with fewer than default minimum of entries */
+	if ((istate->cache_nr > 1) && (threads < 2) && getenv("GIT_FASTINDEX_TEST=
"))
+		threads =3D 2;
+
+	if (threads < 2 || !git_config_get_fast_index())
+		return load_all_cache_entries(istate, mmap, mmap_size, src_offset);
+
+	mem_pool_init(&istate->ce_mem_pool, 0);
+	if (istate->version =3D=3D 4)
+		previous_name =3D &previous_name_buf;
+	else
+		previous_name =3D NULL;
+
+	thread_nr =3D (istate->cache_nr + threads - 1) / threads;
+	data =3D xcalloc(threads, sizeof(struct load_cache_entries_thread_data));
+
+	/* loop through index entries starting a thread for every thread_nr entri=
es */
+	consumed =3D thread =3D 0;
+	for (i =3D 0; ; i++) {
+		struct ondisk_cache_entry *ondisk;
+		const char *name;
+		unsigned int flags;
+
+		/* we've reached the begining of a block of cache entries, kick off a th=
read to process them */
+		if (0 =3D=3D i % thread_nr) {
+			struct load_cache_entries_thread_data *p =3D &data[thread];
+
+			p->istate =3D istate;
+			p->offset =3D i;
+			p->nr =3D min(thread_nr, istate->cache_nr - i);
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
+			if (++thread =3D=3D threads || p->nr !=3D thread_nr)
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
+	for (i =3D 0; i < threads; i++) {
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
@@ -1935,29 +2126,8 @@ int do_read_index(struct index_state *istate, const =
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

base-commit: 29d9e3e2c47dd4b5053b0a98c891878d398463e3
--=20
2.18.0.windows.1

