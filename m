Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D941F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeDJVEd (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:04:33 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:37968
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752242AbeDJVEb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=o2qbfvMf/5cWs2SXEyDdkQrymfF1QAK5WdsIUJgEFVk=;
 b=CIMO41GoGqASox19QeoIfIeTtVPonIxheryHHR/jidov+TgY7de42ULN37BLLoPDQIGC3TneCz5rnLF+nm0AIeyJTUPRtwsyOnktEHdriDl+TbfIKIEtubUqoh5LvnkYec0i5u5tMSHitEWe6Vd+cqETu04XfjPARcIa5KimdG8=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0982.namprd21.prod.outlook.com (52.132.133.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Tue, 10 Apr 2018 21:04:26 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0696.003; Tue, 10 Apr 2018
 21:04:26 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 2/2] fsmonitor: switch to use new fsexcludes logic and
 remove unused untracked cache based logic
Thread-Topic: [PATCH v1 2/2] fsmonitor: switch to use new fsexcludes logic and
 remove unused untracked cache based logic
Thread-Index: AQHT0Q+BEzimXgKTj0ijGV6Ae5b0Qg==
Date:   Tue, 10 Apr 2018 21:04:25 +0000
Message-ID: <20180410210408.13788-3-benpeart@microsoft.com>
References: <20180410210408.13788-1-benpeart@microsoft.com>
In-Reply-To: <20180410210408.13788-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.16.2.windows.1
x-clientproxiedby: BN3PR03CA0082.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::42) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:s4yk4DsCssWrAw9oJkaBNvVrlMZDvhlXO+iIS5umOxPiGdW+GL/AeGlZOzCba8tjna25pwmyaiuDT1Oj5pXCVK+f0xb4W0CL1YZUQaJVd7nKxYUK//6FfR9IL3cfO45vYPzWSnhSB2X5o6IdVB1Hb4seHke7OaEI6mIzLeynJEgSIEe7Cpqe6hyqed6XUtOymiUk20p2QCPJbYot1KcKaOkwnaaqb1Q7j+jRleYWeF5qkuVbakAzamwQ/mE9U+C6;20:lK4uveKQgcvzHAZE1xlrIoZmWZ5+H73kDf5M8nr/1XMtfuZDB+BPHax3UGs8Qw9qJ0rV8EoPI7l9QnajbECcO1JmyHtfEL1hPwPaKRvG4l+3tR3D1z7zPowS8O9jr5pqM03yf5HniRlUQS0GVMXjdge2tKu3uxf5NoA48G2WwOQ=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB09829ADB002CE0100BD41BBBF4BE0@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(189003)(199004)(81166006)(8936002)(105586002)(106356001)(59450400001)(81156014)(8676002)(1076002)(1730700003)(99286004)(3280700002)(76176011)(8656006)(52116002)(2906002)(50226002)(86612001)(2501003)(6916009)(5250100002)(6116002)(107886003)(3846002)(97736004)(54906003)(26005)(5660300001)(22452003)(316002)(39060400002)(4326008)(186003)(68736007)(66066001)(102836004)(6506007)(386003)(478600001)(11346002)(446003)(486006)(476003)(72206003)(25786009)(10290500003)(8666007)(3660700001)(6512007)(2351001)(6436002)(10090500001)(5640700003)(53936002)(2616005)(36756003)(575784001)(2900100001)(14454004)(305945005)(6486002)(7736002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yvm9CEZW2UmdxTJElpRIIxncW0yH6duXsqtRcWnnlwcuQkzReGjsFGbnS9Bs2tM7huNz3vKuthX7/9cwvYT7JR0yqVAjniQ4tT3Jr4ga7kaDMqOTZQ4DwqaPN6JHSrctqFQrXMon9r+gzodmddObIMBjkGWZRpbV6tcmNuv/0t81oX96j7Cx0UDd2gGTOd0h9QE7enY/8vJa1BQognu32ryCritSd/4jOXlffDoMqSEG68LkW0L2WLV8aBAZkoF19wjPngyHbwEAnGEJ0+9BADY+UW+fo3BbJoDkyci8b/9PC8pK8x1OVbwHZWlxryEe/GsdKSVKllAUFt9Jfq3z6r0mHny3iv64a7wkO1lMxkDcjvX+qYMyad/+PMgQVm2AaA7LIspM16KnQLbZ3VeLIDbkVk5E/8hLYHDzUrjGDl4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 24549f5a-4a01-4b99-9f61-08d59f26a3f5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24549f5a-4a01-4b99-9f61-08d59f26a3f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 21:04:25.5513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update fsmonitor to utilize the new fsexcludes based logic for excluding pa=
ths
that do not need to be scaned for new or modified files.  Remove the old lo=
gic
in dir.c that utilized the untracked cache (if enabled) to accomplish the s=
ame
goal.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 dir.c                       | 33 ++++++++++++++++++++++++---------
 dir.h                       |  2 --
 fsmonitor.c                 | 21 ++-------------------
 fsmonitor.h                 | 10 +++-------
 t/t7519-status-fsmonitor.sh | 14 +++-----------
 5 files changed, 32 insertions(+), 48 deletions(-)

diff --git a/dir.c b/dir.c
index 63a917be45..28c2c83f76 100644
--- a/dir.c
+++ b/dir.c
@@ -18,7 +18,7 @@
 #include "utf8.h"
 #include "varint.h"
 #include "ewah/ewok.h"
-#include "fsmonitor.h"
+#include "fsexcludes.h"
=20
 /*
  * Tells read_directory_recursive how a file or directory should be treate=
d.
@@ -1102,6 +1102,12 @@ int is_excluded_from_list(const char *pathname,
 			  struct exclude_list *el, struct index_state *istate)
 {
 	struct exclude *exclude;
+
+	if (*dtype =3D=3D DT_UNKNOWN)
+		*dtype =3D get_dtype(NULL, istate, pathname, pathlen);
+	if (fsexcludes_is_excluded_from(istate, pathname, pathlen, *dtype) > 0)
+		return 1;
+
 	exclude =3D last_exclude_matching_from_list(pathname, pathlen, basename,
 						  dtype, el, istate);
 	if (exclude)
@@ -1317,8 +1323,15 @@ struct exclude *last_exclude_matching(struct dir_str=
uct *dir,
 int is_excluded(struct dir_struct *dir, struct index_state *istate,
 		const char *pathname, int *dtype_p)
 {
-	struct exclude *exclude =3D
-		last_exclude_matching(dir, istate, pathname, dtype_p);
+	struct exclude *exclude;
+	int pathlen =3D strlen(pathname);
+
+	if (*dtype_p =3D=3D DT_UNKNOWN)
+		*dtype_p =3D get_dtype(NULL, istate, pathname, pathlen);
+	if (fsexcludes_is_excluded_from(istate, pathname, pathlen, *dtype_p) > 0)
+		return 1;
+
+	exclude =3D last_exclude_matching(dir, istate, pathname, dtype_p);
 	if (exclude)
 		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
 	return 0;
@@ -1671,6 +1684,9 @@ static enum path_treatment treat_one_path(struct dir_=
struct *dir,
 	if (dtype !=3D DT_DIR && has_path_in_index)
 		return path_none;
=20
+	if (fsexcludes_is_excluded_from(istate, path->buf, path->len, dtype) > 0)
+		return path_excluded;
+
 	/*
 	 * When we are looking at a directory P in the working tree,
 	 * there are three cases:
@@ -1810,12 +1826,9 @@ static int valid_cached_dir(struct dir_struct *dir,
 	if (!untracked)
 		return 0;
=20
-	/*
-	 * With fsmonitor, we can trust the untracked cache's valid field.
-	 */
-	refresh_fsmonitor(istate);
-	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
-		if (lstat(path->len ? path->buf : ".", &st)) {
+	if (!untracked->valid) {
+		if (stat(path->len ? path->buf : ".", &st)) {
+			invalidate_directory(dir->untracked, untracked);
 			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
 			return 0;
 		}
@@ -2011,6 +2024,8 @@ static enum path_treatment read_directory_recursive(s=
truct dir_struct *dir,
 		/* add the path to the appropriate result list */
 		switch (state) {
 		case path_excluded:
+			if (fsexcludes_is_excluded_from(istate, path.buf, path.len, DTYPE(cdir.=
de)) > 0)
+				break;
 			if (dir->flags & DIR_SHOW_IGNORED)
 				dir_add_name(dir, istate, path.buf, path.len);
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
diff --git a/dir.h b/dir.h
index b0758b82a2..e67ccfbb29 100644
--- a/dir.h
+++ b/dir.h
@@ -139,8 +139,6 @@ struct untracked_cache {
 	int gitignore_invalidated;
 	int dir_invalidated;
 	int dir_opened;
-	/* fsmonitor invalidation data */
-	unsigned int use_fsmonitor : 1;
 };
=20
 struct dir_struct {
diff --git a/fsmonitor.c b/fsmonitor.c
index 6d7bcd5d0e..dd67eef851 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "dir.h"
 #include "ewah/ewok.h"
+#include "fsexcludes.h"
 #include "fsmonitor.h"
 #include "run-command.h"
 #include "strbuf.h"
@@ -125,12 +126,7 @@ static void fsmonitor_refresh_callback(struct index_st=
ate *istate, const char *n
 		ce->ce_flags &=3D ~CE_FSMONITOR_VALID;
 	}
=20
-	/*
-	 * Mark the untracked cache dirty even if it wasn't found in the index
-	 * as it could be a new untracked file.
-	 */
 	trace_printf_key(&trace_fsmonitor, "fsmonitor_refresh_callback '%s'", nam=
e);
-	untracked_cache_invalidate_path(istate, name, 0);
 }
=20
 void refresh_fsmonitor(struct index_state *istate)
@@ -184,11 +180,8 @@ void refresh_fsmonitor(struct index_state *istate)
 		/* Mark all entries invalid */
 		for (i =3D 0; i < istate->cache_nr; i++)
 			istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
-
-		if (istate->untracked)
-			istate->untracked->use_fsmonitor =3D 0;
 	}
-	strbuf_release(&query_result);
+	fsexcludes_init(&query_result);
=20
 	/* Now that we've updated istate, save the last_update time */
 	istate->fsmonitor_last_update =3D last_update;
@@ -207,12 +200,6 @@ void add_fsmonitor(struct index_state *istate)
 		for (i =3D 0; i < istate->cache_nr; i++)
 			istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
=20
-		/* reset the untracked cache */
-		if (istate->untracked) {
-			add_untracked_cache(istate);
-			istate->untracked->use_fsmonitor =3D 1;
-		}
-
 		/* Update the fsmonitor state */
 		refresh_fsmonitor(istate);
 	}
@@ -241,10 +228,6 @@ void tweak_fsmonitor(struct index_state *istate)
=20
 			/* Mark all previously saved entries as dirty */
 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate)=
;
-
-			/* Now mark the untracked cache for fsmonitor usage */
-			if (istate->untracked)
-				istate->untracked->use_fsmonitor =3D 1;
 		}
=20
 		ewah_free(istate->fsmonitor_dirty);
diff --git a/fsmonitor.h b/fsmonitor.h
index 65f3743636..f7adfc1f7c 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -35,8 +35,7 @@ extern void tweak_fsmonitor(struct index_state *istate);
=20
 /*
  * Run the configured fsmonitor integration script and clear the
- * CE_FSMONITOR_VALID bit for any files returned as dirty.  Also invalidat=
e
- * any corresponding untracked cache directory structures. Optimized to on=
ly
+ * CE_FSMONITOR_VALID bit for any files returned as dirty. Optimized to on=
ly
  * run the first time it is called.
  */
 extern void refresh_fsmonitor(struct index_state *istate);
@@ -55,17 +54,14 @@ static inline void mark_fsmonitor_valid(struct cache_en=
try *ce)
 }
=20
 /*
- * Clear the given cache entry's CE_FSMONITOR_VALID bit and invalidate
- * any corresponding untracked cache directory structures. This should
+ * Clear the given cache entry's CE_FSMONITOR_VALID bit. This should
  * be called any time git creates or modifies a file that should
- * trigger an lstat() or invalidate the untracked cache for the
- * corresponding directory
+ * trigger an lstat() for the corresponding directory
  */
 static inline void mark_fsmonitor_invalid(struct index_state *istate, stru=
ct cache_entry *ce)
 {
 	if (core_fsmonitor) {
 		ce->ce_flags &=3D ~CE_FSMONITOR_VALID;
-		untracked_cache_invalidate_path(istate, ce->name, 1);
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->na=
me);
 	}
 }
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 756beb0d8e..d6a1da5a0a 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -225,8 +225,7 @@ test_expect_success '*only* files returned by the integ=
ration script get flagged
 # Ensure commands that call refresh_index() to move the index back in time
 # properly invalidate the fsmonitor cache
 test_expect_success 'refresh_index() invalidates fsmonitor cache' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
-	EOF
+	write_integration_script &&
 	clean_repo &&
 	dirty_repo &&
 	git add . &&
@@ -275,7 +274,7 @@ do
 		'
=20
 		# Make sure it's actually skipping the check for modified and untracked
-		# (if enabled) files unless it is told about them.
+		# files unless it is told about them.
 		test_expect_success "status doesn't detect unreported modifications" '
 			write_script .git/hooks/fsmonitor-test<<-\EOF &&
 			:>marker
@@ -288,14 +287,7 @@ do
 			git status >actual &&
 			test_path_is_file marker &&
 			test_i18ngrep ! "Changes not staged for commit:" actual &&
-			if test $uc_val =3D true
-			then
-				test_i18ngrep ! "Untracked files:" actual
-			fi &&
-			if test $uc_val =3D false
-			then
-				test_i18ngrep "Untracked files:" actual
-			fi &&
+			test_i18ngrep ! "Untracked files:" actual &&
 			rm -f marker
 		'
 	done
--=20
2.17.0.windows.1

