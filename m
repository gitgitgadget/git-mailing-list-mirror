Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29271F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756482AbeDKUBr (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:01:47 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:6800
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756410AbeDKUBo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=u9f99qfc6HZS1cIdVKwmmJq337DLRGOn3zwjCSgj0kY=;
 b=Df3BNSPTHTLpKgQRARUKgCfcmVe1W3XfsvAmhKlwihxQ6bjOonN5jzIpp0gUxd4H4KJ46/x4cPOoyDKuZn2w+MHPk2I9AUej1h0rSXt01Id+vnZSxZLe2hgIejEiZrPTybKF4FU8iYfpZcW8u7G/6WJKLCyafzSwLd7ulf57N0o=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0984.namprd21.prod.outlook.com (52.132.133.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Wed, 11 Apr 2018 20:01:41 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0696.006; Wed, 11 Apr 2018
 20:01:41 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2 2/2] fsmonitor: switch to use new fsexcludes logic and
 remove unused untracked cache based logic
Thread-Topic: [PATCH v2 2/2] fsmonitor: switch to use new fsexcludes logic and
 remove unused untracked cache based logic
Thread-Index: AQHT0c/o/H0lUHGJE0698odSApqACQ==
Date:   Wed, 11 Apr 2018 20:01:41 +0000
Message-ID: <20180411200007.8612-3-benpeart@microsoft.com>
References: <20180410210408.13788-1-benpeart@microsoft.com>
 <20180411200007.8612-1-benpeart@microsoft.com>
In-Reply-To: <20180411200007.8612-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0062.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::22) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:5VR/uy/1g+TOIhStQNn+Erv8TeVcUm2JX7eLQ4PfT6XmzZJUy7kmbSNSS8/ztfEouOAGgEvSzT0Pq+hULfhCzWNA+rBr3J5UcCvTy/zjEzPRhGx3Ix+FvFkCH++HsJMOHUJjw605Ol5OVbrLenksUSr9TTYW6WZKcNNDNG24N9sgv5OAPzQjBQ6dNXH8QU+LSh0BM2i85SderrwnT9O4oCnCEeVNj+9pK5fL8N+SU8g65KGr8b4Q6YtrDcztohvS;20:A8vNhgvnjYhLODVs/DRRPtYiZL1C6GkCtTnE7+Q950HduLIYKn9xvJtGkTH7JT8+pzEKpqAQN9KtS++lBZWwQXLIiro23zOS5rbzDF9hFPjyDQLTOgYVYPbM4BwGsEue3MmYc7q+cMUqlBmbNnzlKDssc57MzqAjWSNuaooy9UM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0984CF9E8F4DF8B6CEF291D4F4BD0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501337)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6916009)(5250100002)(8666007)(105586002)(5640700003)(2900100001)(25786009)(39060400002)(1076002)(6116002)(3846002)(36756003)(6486002)(6436002)(4326008)(97736004)(7736002)(305945005)(5660300001)(10090500001)(2351001)(81166006)(81156014)(8676002)(8936002)(50226002)(106356001)(66066001)(478600001)(59450400001)(72206003)(52116002)(76176011)(10290500003)(575784001)(3280700002)(107886003)(1730700003)(186003)(3660700001)(386003)(53936002)(14454004)(54906003)(2906002)(99286004)(26005)(6506007)(8656006)(102836004)(2616005)(476003)(486006)(446003)(11346002)(86612001)(68736007)(22452003)(316002)(6512007)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 31qstXkXD8Q/tEh07qu0kBTvunaFufrBFEa3xLmuR+7IukenvkaKs8kk7majV7Ufp1xMB6JtQiAE9h/DQgwx5YDEGpYnea4GwmKLdPWqnANbZgweaM5aQ0sErBbhVFWbtDHj7X2IO3w2BTj6ZRg0KiFg87VUPHsEd6gw9FqmNKWABNA5tIEPE9MOp36bEGmy6zNFjKop42098ZHZtSYmD0dF2TOK6ipMym9vtLpvO1FQpOeZSDN2RDfSCpeAQXfPGou9Ri25FE+gh1A+dQS+eEKKvoeGbk5NCxzYyJoU0v6T1NzBV8va0S88K5NqvcWHikXFcIBixf35v7yBVBNN/O5rZRa3kNWVS7IFaxyTmGQXpsYS41wYIbDqeUbpOBwfs7ja2TQ6mbnBsKudhcQIu7rVX7e+77KxpBF7nQJaWpI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7b87adf7-6050-4e1c-d4fa-08d59fe70aa7
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b87adf7-6050-4e1c-d4fa-08d59fe70aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 20:01:41.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
 dir.c                       | 10 +++-------
 dir.h                       |  2 --
 fsmonitor.c                 | 21 ++-------------------
 fsmonitor.h                 | 10 +++-------
 t/t7519-status-fsmonitor.sh | 14 +++-----------
 5 files changed, 11 insertions(+), 46 deletions(-)

diff --git a/dir.c b/dir.c
index 1aa639b9f4..28c2c83f76 100644
--- a/dir.c
+++ b/dir.c
@@ -19,7 +19,6 @@
 #include "varint.h"
 #include "ewah/ewok.h"
 #include "fsexcludes.h"
-#include "fsmonitor.h"
=20
 /*
  * Tells read_directory_recursive how a file or directory should be treate=
d.
@@ -1827,12 +1826,9 @@ static int valid_cached_dir(struct dir_struct *dir,
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

