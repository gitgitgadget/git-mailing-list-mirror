Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9847B1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeILE2Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:28:16 -0400
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:1880
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725737AbeILE2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDAY+vujP/87Yg7sULgrPIwOx4FoeR5OuyuUBkXq0XA=;
 b=UNGxzpuqL5WGaFxZYfqYIQejm/tN8QJB24ZjfXYJ37xYEUdwQC2L78MDraikGSOvfRfmIyTh3XGlyl1k/+fPbIOd7vzf5FVosojjoOPfHtreur6pK05rZwCig0zUXxilmLkfbKXN0rGMJwMxrwC4CRdBSiyIgMScKmWkbPgE9kY=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Tue, 11 Sep 2018 23:26:37 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.006; Tue, 11 Sep 2018
 23:26:37 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v4 2/5] read-cache: load cache extensions on a worker thread
Thread-Topic: [PATCH v4 2/5] read-cache: load cache extensions on a worker
 thread
Thread-Index: AQHUSibi2/oyezhGckmuRFJ+5rKM5Q==
Date:   Tue, 11 Sep 2018 23:26:37 +0000
Message-ID: <20180911232615.35904-3-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:nmpbSoh8LbW5D7T997EwBcZVPjyIqeqTRrhVr9JP0QhwQeH9gdh5BgxVr96KWosAJxfyHQXSrD5e0TukOqFzQpkTmmsc3jWDrBJpftHZM4ZL2dT9z4A8xQFwjKjwC8TCQrj7VYccZUxga6/7VXJEvvhVMwOMus0tvy2rY6NdtHA8ap9GvxjhigXKitKBMNW8aI6Enjq7jrKIkI7uGDLr5F63W5DaMOZk4ji2fg7DJ9aoy0FaxnmzIfLOraVqnsAOrlAy9qUTQXVVghhnfjBxtg2HO/kXcDmSYvUceej6eivHcLdbmgOjYKCSDomKj1MLww+eS6QNyU/HMvSALLQXxZDVhXG+pAY1wQ30alayROTEaJLAGcihODYoguyEGTnSaPgE3MA3bn+vwlF+oS3XkY4vsOuHDxVS/xdpIC2Dk2U7YExvTY/YsBonJ2c6vysrrG1GUShWzxha0vAd26mF2A==;5:yQ2c1vd7X5F1HDUkUGmkQxfwUbsLq7O56DlHEYHpkRdy3w05ylnrQtaplUDDmI7f4sYbJivMj1cIUXLhjVUKKy778cQB3PpFqai8viSwMA9Fm08zqi3wwrQuh/+vH3Tn74RIAA7OEiKso5w/d5ZpQOwpFGZpD3NogPd59YqXpn8=;7:YMtesvrYF0Cf0XuzDYwUiuhUxLUCaudhMxEtvfGoMA54x8tYmaqX7gHKQDLr93P5jngFMZq1eIzyis6YpIRpCe5y6N9FahWIFm9BcMPXqlrAUIzlc4YiZL9oniWzzaLP7w398thLPHHrlfQycATiaF4BT5FZD2mfAwFgEbZ51IxKntlqFgaYAku8IDgWDdDlvytLRxpm/wP1XE5izeh5mq5QSgNvjV8ASlRYtngwubG9wpr0ZjDFUCFttNhZPc5W
x-ms-office365-filtering-correlation-id: c19fb6b8-19c1-4edb-88f1-08d6183e0516
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113776A77D4040D7F345FB3F4040@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699050)(76991037);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(386003)(6116002)(97736004)(6506007)(86612001)(7736002)(5640700003)(575784001)(81156014)(81166006)(26005)(2900100001)(102836004)(6436002)(1730700003)(6346003)(305945005)(561924002)(11346002)(14444005)(446003)(2616005)(476003)(486006)(3846002)(256004)(36756003)(10090500001)(66066001)(186003)(53936002)(1076002)(106356001)(105586002)(2351001)(6512007)(316002)(4326008)(54906003)(2906002)(52116002)(25786009)(5660300001)(107886003)(68736007)(22452003)(76176011)(39060400002)(6916009)(50226002)(478600001)(2501003)(99286004)(72206003)(14454004)(5250100002)(8936002)(8676002)(10290500003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: KYsvTMhfcsZJgHvTSlvpUZhcq7KRuRtVDi7MoRpWVlIqj0hakiSdtwuimglgzuTtWT4AIpIGVd16CqCE4NZz9IuIhKkvARk4WVlr0T7sk/6vOJ0ctZ0wwCXdMDQ1DGAS0pvr/yEjwEo+nVgbLPusWuafIcAhC0cGN96zs0KbQdOrHfOLUquL/NbWfa7z7lbEBO8J11GNevCRyvabfZ90WpIJpGNsbjBXXFbSkq49zpNnI0SZjqfzxY+4hZdluHYJNraB/WDxoAvqYYL69iR3/2EZrHJWaQdQy13/A9v3lG4rLjSm/f6fnZ3kyyt5Wg3R8Y/NvnVsUHb+lVfy5pRSPjDHnHXO5RS8a7F3Kh7BfvA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19fb6b8-19c1-4edb-88f1-08d6183e0516
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 23:26:37.5655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
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

Test w/100,000 files                Baseline         Parallel Extensions
---------------------------------------------------------------------------
read_cache/discard_cache 1000 times 14.08(0.01+0.10) 9.72(0.03+0.06) -31.0%

Test w/1,000,000 files              Baseline         Parallel Extensions
---------------------------------------------------------------------------=
---
read_cache/discard_cache 1000 times 202.95(0.01+0.07) 154.14(0.03+0.06) -24=
.1%

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 Documentation/config.txt |  6 +++
 config.c                 | 18 ++++++++
 config.h                 |  1 +
 read-cache.c             | 94 ++++++++++++++++++++++++++++++++--------
 4 files changed, 102 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index eb66a11975..d0d8075978 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2400,6 +2400,12 @@ imap::
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
index 3461993f0a..f7ebf149fc 100644
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
index 2abac0a7a2..9b97c29f5b 100644
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
@@ -1898,6 +1902,46 @@ static unsigned long read_eoie_extension(void *mmap_=
, size_t mmap_size);
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
+};
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
@@ -1908,6 +1952,11 @@ int do_read_index(struct index_state *istate, const =
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
@@ -1944,6 +1993,26 @@ int do_read_index(struct index_state *istate, const =
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
@@ -1970,23 +2039,14 @@ int do_read_index(struct index_state *istate, const=
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

