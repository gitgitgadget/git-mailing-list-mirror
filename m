Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF5D1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeIGBlU (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:41:20 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:53953
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728917AbeIGBlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qnjz0YpFBayT3MRhtSKS9se+jqdx3ip0w6a3VGwNesM=;
 b=GO/yeHKVYxg5RpYq1g8ewYkzk4UvOMtxqpdgohJLSZtd5Zb2u4zgrxztMeUNs9lKra8KqHWcWF58mgolE4IVQHuAdpsbbX3HiYLL3NVvf40NRBGcFV4g5iDAs9JbJqXd0yf38eXngQKlvtIGPD7NUc0ceS9lswQ9LWUSqAFMoGo=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1033.namprd21.prod.outlook.com (52.132.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Thu, 6 Sep 2018 21:03:58 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858%4]) with mapi id 15.20.1143.008; Thu, 6 Sep 2018
 21:03:58 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 3/4] read-cache: load cache extensions on a worker thread
Thread-Topic: [PATCH v3 3/4] read-cache: load cache extensions on a worker
 thread
Thread-Index: AQHURiUgLCx/h3Mwl0amz0biO1JazA==
Date:   Thu, 6 Sep 2018 21:03:58 +0000
Message-ID: <20180906210227.54368-4-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;6:tqoixW/QVIcVWBHmRWMeMFK0sr6cWprRytDZuzsuPO1hgSV2ZcXLNMSk6jWrGwXNOu5ejWUYmolH1kskCTQ4650ODsRNFebAR6gwrL/ZgBrf6MuuM08VCRn/vUxwTtXOtWF9btORjWE5Z4C6zCGaD1gFaDixROuPql7/qLq591c2yb6gjgbZW4DXTmwAV8h03IRPFjeIAc9k01CnO/YlDHq/Pk8ZgiVd5pD/vFxbwCkDxhivr+ePQQd2u+nuIPd1cW+1B1b9XLzhpIAJT3sPctnecNdzG/QYw7Skfvtzn7WsfPvSICEVDUTgRsl79nJapsYFW+2PpK7lJEi2HJxIqkGIBQzuL12RVchFrYMIBXUg46X2q5xPyLOPdd2S09MKJnfpb4H9pIhxnLAv60ySjA+sOeI5bNAH4xbshgWSK0dzhJSJ62/ORa187gl1S9/nB3T4RjRFWwnlfizjRisxTg==;5:6kbeVRpvNCadNUNZ7j7nO3JVejaUCzi7SBITz+Uy4Sc3vrWy6aBfExmjBNEdkq1ivGZP/XyU0AiaDIhrh9ywdut+hWu60es9bcTXEEu7yJ6BGDwHM7ibp+aQvQK80/T/YJ5YWON6Af2B9AB5aL+reIkg0JT8RDSOt76z6/nz3Qo=;7:2mFQ+SAwd1UF4nT6j8+P76N98yWfN6pI1gsUkl6AR3C8O+ExgQZYJzLdL3EPtXlQ1UAzQIopsKRH+zkgx4+ARYwE7kP1n+0EoXJVNNwDnv56CIerCC0v9xUx/x64t4Db0270CsonYhHn8uIovgdvPJwASZnRDNG1biVdJEO3UylVOld9if1A5sb+zIqBIcTVNytQwBcpmNPvzr0wVD0Nn4XFAw2iSTM4Xa+ZpA7Vw/rHsgqGLfSkoF6JY6s/fwOo
x-ms-office365-filtering-correlation-id: aee8c8b7-c42e-4927-b27a-08d6143c42ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
x-microsoft-antispam-prvs: <MW2PR2101MB1033F524E3C8304E40A4DAAFF4010@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(476003)(2616005)(446003)(22452003)(102836004)(486006)(68736007)(39060400002)(2501003)(5250100002)(2351001)(1076002)(3846002)(53936002)(6116002)(50226002)(36756003)(186003)(6346003)(26005)(52116002)(76176011)(107886003)(14444005)(575784001)(25786009)(386003)(316002)(6506007)(54906003)(8936002)(99286004)(11346002)(4326008)(72206003)(86612001)(6916009)(10090500001)(7736002)(5660300001)(14454004)(10290500003)(478600001)(2906002)(256004)(105586002)(305945005)(8676002)(81156014)(81166006)(1730700003)(66066001)(2900100001)(561924002)(106356001)(6436002)(97736004)(6486002)(6512007)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: YgxvFYqm4Zm06tNVl4KTL+7Nt77WIqJZt7Yg3VDrjSuncFqwAbkh0QQMzv0PiKD4JXpoIsqtW38tnK+kMae9dMU5Bxto4vCmn9ILlPJstb/OPIhmM2+U6HPOWMj0ZcDNSoJrgSOX7ZJzwCG7hkJxeMC28K3DF45P6n34mVu8e5cbEn5U72snrwD2y6kShFZI3Vw3O5YCQ2bG0QmslO8e8subCqnAHf8vCLBNaFqcrPCL1lvUJ8K9EBA90csBdMJX8/4vdGO/72nof5hagECU081CAo+LBe3x4GScjc7R34KggEGGi7R3DGPzA1gC8ZVu3e+WxZ5MJxkPXUlS+c8jmP3K95DBlYFasQgjsqG/axI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee8c8b7-c42e-4927-b27a-08d6143c42ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 21:03:58.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch helps address the CPU cost of loading the index by loading
the cache extensions on a worker thread in parallel with loading the cache
entries.

In some cases, loading the extensions takes longer than loading the
cache entries so this patch utilizes the new EOIE to start the thread to
load the extensions before loading all the cache entries in parallel.

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

I used p0002-read-cache.sh to generate some performance data:

p0002-read-cache.sh w/100,000 files
Baseline         Thread extensions
---------------------------------------
21.14(0.03+0.01) 20.71(0.03+0.03) -2.0%

p0002-read-cache.sh w/1,000,000 files
Baseline          Thread extensions
------------------------------------------
295.42(0.01+0.07) 217.60(0.03+0.04) -26.3%

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 Documentation/config.txt |  6 +++
 config.c                 | 18 ++++++++
 config.h                 |  1 +
 read-cache.c             | 94 ++++++++++++++++++++++++++++++++--------
 4 files changed, 102 insertions(+), 17 deletions(-)

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
index 9a0b10d4bc..9bd79fb165 100644
--- a/config.c
+++ b/config.c
@@ -2289,6 +2289,24 @@ int git_config_get_fsmonitor(void)
 	return 0;
 }
=20
+/*
+ * You can disable multi-threaded code by setting index.threads
+ * to 'false' (or 1)
+ */
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
index d0d2793780..fcc776aaf0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,6 +23,10 @@
 #include "split-index.h"
 #include "utf8.h"
 #include "fsmonitor.h"
+#ifndef NO_PTHREADS
+#include <pthread.h>
+#include <thread-utils.h>
+#endif
=20
 /* Mask for the name length in ce_flags in the on-disk index */
=20
@@ -1897,6 +1901,46 @@ static unsigned long read_eoie_extension(void *mmap,=
 size_t mmap_size);
 #endif
 static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_con=
text, unsigned long offset);
=20
+struct load_index_extensions
+{
+#ifndef NO_PTHREADS
+	pthread_t pthread;
+#endif
+	struct index_state *istate;
+	void *mmap;
+	size_t mmap_size;
+	unsigned long src_offset;
+ };
+
+static void *load_index_extensions(void *_data)
+{
+	struct load_index_extensions *p =3D _data;
+	unsigned long src_offset =3D p->src_offset;
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
+			(const char *)p->mmap + src_offset,
+			(char *)p->mmap + src_offset + 8,
+			extsize) < 0) {
+			munmap(p->mmap, p->mmap_size);
+			die("index file corrupt");
+		}
+		src_offset +=3D 8;
+		src_offset +=3D extsize;
+	}
+
+	return NULL;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_e=
xist)
 {
@@ -1907,6 +1951,11 @@ int do_read_index(struct index_state *istate, const =
char *path, int must_exist)
 	void *mmap;
 	size_t mmap_size;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
+	struct load_index_extensions p =3D { 0 };
+	unsigned long extension_offset =3D 0;
+#ifndef NO_PTHREADS
+	int nr_threads;
+#endif
=20
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1943,6 +1992,26 @@ int do_read_index(struct index_state *istate, const =
char *path, int must_exist)
 	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(*istate->cache));
 	istate->initialized =3D 1;
=20
+	p.istate =3D istate;
+	p.mmap =3D mmap;
+	p.mmap_size =3D mmap_size;
+
+#ifndef NO_PTHREADS
+	nr_threads =3D git_config_get_index_threads();
+	if (!nr_threads)
+		nr_threads =3D online_cpus();
+
+	if (nr_threads >=3D 2) {
+		extension_offset =3D read_eoie_extension(mmap, mmap_size);
+		if (extension_offset) {
+			/* create a thread to load the index extensions */
+			p.src_offset =3D extension_offset;
+			if (pthread_create(&p.pthread, NULL, load_index_extensions, &p))
+				die(_("unable to create load_index_extensions_thread"));
+		}
+	}
+#endif
+
 	if (istate->version =3D=3D 4) {
 		previous_name =3D &previous_name_buf;
 		mem_pool_init(&istate->ce_mem_pool,
@@ -1969,23 +2038,14 @@ int do_read_index(struct index_state *istate, const=
 char *path, int must_exist)
 	istate->timestamp.sec =3D st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
=20
-	while (src_offset <=3D mmap_size - the_hash_algo->rawsz - 8) {
-		/* After an array of active_nr index entries,
-		 * there can be arbitrary number of extended
-		 * sections, each of which is prefixed with
-		 * extension name (4-byte) and section length
-		 * in 4-byte network byte order.
-		 */
-		uint32_t extsize;
-		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
-		extsize =3D ntohl(extsize);
-		if (read_index_extension(istate,
-					 (const char *) mmap + src_offset,
-					 (char *) mmap + src_offset + 8,
-					 extsize) < 0)
-			goto unmap;
-		src_offset +=3D 8;
-		src_offset +=3D extsize;
+	/* if we created a thread, join it otherwise load the extensions on the p=
rimary thread */
+#ifndef NO_PTHREADS
+	if (extension_offset && pthread_join(p.pthread, NULL))
+		die(_("unable to join load_index_extensions_thread"));
+#endif
+	if (!extension_offset) {
+		p.src_offset =3D src_offset;
+		load_index_extensions(&p);
 	}
 	munmap(mmap, mmap_size);
 	return istate->cache_nr;
--=20
2.18.0.windows.1

