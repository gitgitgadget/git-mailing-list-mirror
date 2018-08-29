Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C52F01F404
	for <e@80x24.org>; Wed, 29 Aug 2018 15:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeH2TXG (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 15:23:06 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:6275
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728748AbeH2TXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 15:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5S8VWNsBgf6eJ6lOOB85EuYTWIFhWBMQwHQTr0eGRE=;
 b=UK9PCi7lAe/NGig+zY+0OkSFSYtAkUEHtXX+AX4xlpDH2Tq5kHY9yJjA18YMdHy5d1h47V0W2kCvx4I1sz2ixiBNeQYi4uW6Qzn/5zZyaOrv2FFS58X8K8mwSCjjoz7gT2pHae83uhkelAK38wOGlBuHTCzC2d5tWusP5EKJhGk=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1036.namprd21.prod.outlook.com (52.132.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Wed, 29 Aug 2018 15:25:20 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf%3]) with mapi id 15.20.1122.000; Wed, 29 Aug 2018
 15:25:20 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2 2/3] read-cache: load cache extensions on worker thread
Thread-Topic: [PATCH v2 2/3] read-cache: load cache extensions on worker
 thread
Thread-Index: AQHUP6x/5tfA8jJTdkC62n7mlAAjlw==
Date:   Wed, 29 Aug 2018 15:25:20 +0000
Message-ID: <20180829152500.46640-3-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;6:Xc+wZ1ICTMi9VtgzHFnv7InsTzf+5W2nj4wArsz2tNvj/qKUbT0yaRiMKolNB4JCs9RkHeop5or0xjeCQL5xvjc927HWL/XhMvE7W/LRbIPsRpkCTCU7WiveT1pOqajSsQvhnjPuyn5Yk22QJ/sbN6UEPX98yuaO+cxz//K+FHHoCxxXjFHuxW9YziBI7L1q0fWKFFdmyIcuoXlxi/N19Qgh8aldzncUpoOJNg59Uz8fQmEZjC1H1v9007G7twuEYdKXejmxQk9Y2MMZCcr4cjz1ACR6R2OeNG5LoNQCMb1cTOIUMUdL4vSvG+YVL1qcUHVhVzJi/16br7TTv3Nb+E7EBg0AWYj3JfQHikZtGTPaySJsTcMpEbDWZ4UJ2xTGA8v7QMxTjm7JMu5Ogs3Kqtoy+Z5HD1BOzFB0Kj59cdm7Y+mV20b5z2V2Qo4vqPHqWbRRUoaxIa7jpUX1hpho5g==;5:1968iE6UAwK4uADaM59aN2QXv+4XbCerKC9ol6SGz6QV4YS72zfwKvQsyiw2gk4mYGCZ9CQXe43vka8+gZt+WXtFH67MZDjFs6tMRF9jMK6QhYxzbgTPPJmseB/JL/RVdoWIvRRJGAyXIJ7ZvwqsEzc3atgAMyQS4XqvhOajkcg=;7:VnSi/ljfIyzyOGE8UP+Wd5/JyWdJgWeLPJNTOSctn8sHksDnsnZXDIGpWvt/p6Hy9FGmRVLqW70dGHuJ7ji7bP0WiVd2/zmTqiPx/gJPJz8SPLTRAF5w7m0TuJaPlAmZ87qcif6Cbfqn9xiKz28aKaLrinHClhrIaAbPSStH0LRisvMcfEBtDUJK/tEfNtxk6TE7PUMKYhnkjGoWb7xJBNK51J014NgCzvDKlEBRTysTIil5jNneV5ksXUz56KoM
x-ms-office365-filtering-correlation-id: 7658e6e5-031d-44ed-a4e4-08d60dc3a19c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
x-microsoft-antispam-prvs: <MW2PR2101MB1036AC1FEF6BE8311320C992F4090@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(6486002)(8936002)(36756003)(25786009)(50226002)(2501003)(446003)(5250100002)(97736004)(486006)(561924002)(72206003)(68736007)(10290500003)(11346002)(6916009)(476003)(5660300001)(2616005)(478600001)(107886003)(39060400002)(2351001)(4326008)(2900100001)(106356001)(105586002)(14454004)(86612001)(2906002)(1076002)(386003)(10090500001)(54906003)(99286004)(6512007)(5640700003)(6346003)(6506007)(53936002)(76176011)(305945005)(66066001)(8676002)(52116002)(6116002)(186003)(7736002)(102836004)(81156014)(26005)(14444005)(81166006)(256004)(316002)(6436002)(1730700003)(22452003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: T9WdUMZMk4pZ42MMJdtPj8GFcD8ZusH9e1YGEwqahkTAMQVg37CW1pkVHh6gwV237+lnA9e9zVfOWAvDfhbg8JfAnR+jbtP9LkzI4G2Y67UebKeA6a/Ch2Pc9doa/zmSvGiqhh23MRR7VmHIQh8Jx2yQqsjabN2ktZ6o2JjePQm8BnrkWM3bV7UvR16C1rmwpYXKvnvM/fsmXc7lM9WK5j6xAix69T0BvATvxAC5Dnv37tgZ3ndL+7TTNAo2N2vh/epY9+DSsF0NyrhIyS3r3dpgOkcPgQSdVnnSkgGmJThmjqBNHudkUDBWUTLvH7lAd8H6/satVw8/8ZNeHpiuL0kOXSjck+YN84saNNYepQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7658e6e5-031d-44ed-a4e4-08d60dc3a19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 15:25:20.4948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch helps address the CPU cost of loading the index by loading
the cache extensions on a worker thread in parallel with loading the cache
entries.

This is possible because the current extensions don't access the cache
entries in the index_state structure so are OK that they don't all exist
yet.

The CACHE_EXT_TREE, CACHE_EXT_RESOLVE_UNDO, and CACHE_EXT_UNTRACKED
extensions don't even get a pointer to the index so don't have access to th=
e
cache entries.

CACHE_EXT_LINK only uses the index_state to initialize the split index.
CACHE_EXT_FSMONITOR only uses the index_state to save the fsmonitor last
update and dirty flags.

I used p0002-read-cache.sh to generate some performance data on the
cumulative impact:

100,000 entries

Test                                HEAD~3           HEAD~2
---------------------------------------------------------------------------
read_cache/discard_cache 1000 times 14.08(0.01+0.10) 9.72(0.03+0.06) -31.0%

1,000,000 entries

Test                                HEAD~3            HEAD~2
---------------------------------------------------------------------------=
---
read_cache/discard_cache 1000 times 202.95(0.01+0.07) 154.14(0.03+0.06) -24=
.1%

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 read-cache.c | 60 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c30346388a..f768004617 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1959,16 +1959,13 @@ struct load_cache_entries_thread_data
 	struct mem_pool *ce_mem_pool;
 	int offset, nr;
 	void *mmap;
+	size_t mmap_size;
 	unsigned long start_offset;
 	struct strbuf previous_name_buf;
 	struct strbuf *previous_name;
 	unsigned long consumed;	/* return # of bytes in index file processed */
 };
=20
-/*
-* A thread proc to run the load_cache_entries() computation
-* across multiple background threads.
-*/
 static void *load_cache_entries_thread(void *_data)
 {
 	struct load_cache_entries_thread_data *p =3D _data;
@@ -1978,6 +1975,36 @@ static void *load_cache_entries_thread(void *_data)
 	return NULL;
 }
=20
+static void *load_index_extensions_thread(void *_data)
+{
+	struct load_cache_entries_thread_data *p =3D _data;
+	unsigned long src_offset =3D p->start_offset;
+
+	while (src_offset <=3D p->mmap_size - the_hash_algo->rawsz - 8) {
+		/* After an array of active_nr index entries,
+		 * there can be arbitrary number of extended
+		 * sections, each of which is prefixed with
+		 * extension name (4-byte) and section length
+		 * in 4-byte network byte order.
+		 */
+		uint32_t extsize;
+		memcpy(&extsize, (char *)p->mmap + src_offset + 4, 4);
+		extsize =3D ntohl(extsize);
+		if (read_index_extension(p->istate,
+								(const char *)p->mmap + src_offset,
+								(char *)p->mmap + src_offset + 8,
+								extsize) < 0) {
+			munmap(p->mmap, p->mmap_size);
+			die("index file corrupt");
+		}
+		src_offset +=3D 8;
+		src_offset +=3D extsize;
+	}
+	p->consumed +=3D src_offset - p->start_offset;
+
+	return NULL;
+}
+
 static unsigned long load_cache_entries(struct index_state *istate,
 			void *mmap, size_t mmap_size, unsigned long src_offset)
 {
@@ -2012,16 +2039,16 @@ static unsigned long load_cache_entries(struct inde=
x_state *istate,
 	else
 		previous_name =3D NULL;
=20
+	/* allocate an extra thread for loading the index extensions */
 	ce_per_thread =3D DIV_ROUND_UP(istate->cache_nr, nr_threads);
-	data =3D xcalloc(nr_threads, sizeof(struct load_cache_entries_thread_data=
));
+	data =3D xcalloc(nr_threads + 1, sizeof(struct load_cache_entries_thread_=
data));
=20
 	/*
 	 * Loop through index entries starting a thread for every ce_per_thread
-	 * entries. Exit the loop when we've created the final thread (no need
-	 * to parse the remaining entries.
+	 * entries.
 	 */
 	consumed =3D thread =3D 0;
-	for (i =3D 0; ; i++) {
+	for (i =3D 0; i < istate->cache_nr; i++) {
 		struct ondisk_cache_entry *ondisk;
 		const char *name;
 		unsigned int flags;
@@ -2055,9 +2082,7 @@ static unsigned long load_cache_entries(struct index_=
state *istate,
 			if (pthread_create(&p->pthread, NULL, load_cache_entries_thread, p))
 				die("unable to create load_cache_entries_thread");
=20
-			/* exit the loop when we've created the last thread */
-			if (++thread =3D=3D nr_threads)
-				break;
+			++thread;
 		}
=20
 		ondisk =3D (struct ondisk_cache_entry *)((char *)mmap + src_offset);
@@ -2086,7 +2111,18 @@ static unsigned long load_cache_entries(struct index=
_state *istate,
 			src_offset +=3D (name - ((char *)ondisk)) + expand_name_field(previous_=
name, name);
 	}
=20
-	for (i =3D 0; i < nr_threads; i++) {
+	/* create a thread to load the index extensions */
+	struct load_cache_entries_thread_data *p =3D &data[thread];
+	p->istate =3D istate;
+	mem_pool_init(&p->ce_mem_pool, 0);
+	p->mmap =3D mmap;
+	p->mmap_size =3D mmap_size;
+	p->start_offset =3D src_offset;
+
+	if (pthread_create(&p->pthread, NULL, load_index_extensions_thread, p))
+		die("unable to create load_index_extensions_thread");
+
+	for (i =3D 0; i < nr_threads + 1; i++) {
 		struct load_cache_entries_thread_data *p =3D data + i;
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join load_cache_entries_thread");
--=20
2.18.0.windows.1

