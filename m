Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3451F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeGaSlF (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 14:41:05 -0400
Received: from mail-bn3nam01on0113.outbound.protection.outlook.com ([104.47.33.113]:12208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731272AbeGaSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 14:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDd5pHAyzUk3PvTY/mUnod1JPUIvOyJjoRuhMJaNvO4=;
 b=UVpUAWFO0+jycZ3oFTWWqWdaOIKZSNuK7v+cpbJKYqFmG9wusppQtqe54iQ5Tt7Vl95ItbkIlqbj+cuzUJmpr1304DPQHhxR5DIzx1m8VxAJJv846+2usPxYat3P9crCGxFFG4bW+JcxoT9NwudHvr9o0E8orYT6D5n3aoKNbxA=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0923.namprd21.prod.outlook.com (52.132.152.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.5; Tue, 31 Jul 2018 16:39:26 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf%2]) with mapi id 15.20.1038.003; Tue, 31 Jul 2018
 16:39:26 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2] checkout: optimize "git checkout -b <new_branch>"
Thread-Topic: [PATCH v2] checkout: optimize "git checkout -b <new_branch>"
Thread-Index: AQHUKO0L1ZpePSKj0UCIwv4kMAkm/A==
Date:   Tue, 31 Jul 2018 16:39:25 +0000
Message-ID: <20180731163909.19004-1-benpeart@microsoft.com>
References: <20180724180122.29212-1-benpeart@microsoft.com>
In-Reply-To: <20180724180122.29212-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: MWHPR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:301:74::24) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0923;6:1KNp3cSpVRRPdtMW6yjCqOCwX2lA5zAfbXGWdqebh8OdJjPbb69aTfNOeigJIOG2hWtgOV2tWC3WNPTsnJ7SqcWYe94CgyvgENPWTFkT4QAxnZDmP9QmIF/TIkDu74QHmpzhB5NxBEn2SBjOT1165oKPW+fMIcC7inON+62dWd2UeYdzReHhLYKeDn4KrtWmCudqb/bC8Hr+kJknaS/6mMiz6gSkmdYNRfGc65ieQmr6eDHC8me/4buNPxeBTYWkOm7WcONF/rjy++jho0dt0tq5DYTkWjjQ3RSob5AzThOfV9zP6eKMQ2Ig5RysMk2dl7Dd5IhW57bDe4Ceos1DjWYxtJl9w+FQqRE52aEL57vZcK1ioW0DvbLGsV7hQH8ws+9+/C7tWAyuF/RBZkO42d3+74W69THR3sXLouOb6AGDJsRbZ/NH2UceLoEsdG3lyFU5xum2Znu/FxC8/VWS4Q==;5:gKPc6WghojCbxpilvPNd9ZSCzdbOKwPuqjvDB8FGsJdBaNZLXUrRB/2oap9aX2qP6UnFH6+ycPpeH2BSbNe1KPPy5EwvseDShFkihJiAALc/jnvT5Vgg8bafmj09i0XXbl/eLIrgUloIb3pDA4ieIcRKu3VJ2DtsXnWtMm4gkCs=;7:1pZZgdPSP1vD5A5zBAFkqd41g8cCg0CSojF3K+b7u2d0sTY4myE6wNmd3+XXNRSYmtHhPkSMAuv2BaPYA8OA/6rYIm+0wdrMMCi7b8604OQBLNAXcVHFKDby5F9Wx/S3tIueh2IAtB+QuivHjiKaJEQ9+Ar1l4A4vfsUR3C7aWj8tJjXVj+hKpKXxD9R+jk9nxTlNFL0qgvjcfIH/OfF3YiEp1ZoiL3Bpu+4CzxvgByUffPbkPx7F/8veG/ZnUL2
x-ms-office365-filtering-correlation-id: cc8503b7-3aa7-4893-d0da-08d5f7042d37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0923;
x-ms-traffictypediagnostic: MW2PR2101MB0923:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB0923FF2172322771E42BF4A1F42E0@MW2PR2101MB0923.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0923;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0923;
x-forefront-prvs: 0750463DC9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39860400002)(136003)(189003)(199004)(10290500003)(10090500001)(966005)(72206003)(14454004)(105586002)(81156014)(81166006)(8676002)(6636002)(99286004)(1511001)(76176011)(7736002)(66066001)(22452003)(305945005)(5660300001)(316002)(478600001)(37006003)(54906003)(6486002)(52116002)(4326008)(107886003)(25786009)(6436002)(6306002)(6862004)(2906002)(1076002)(2900100001)(97736004)(6116002)(3846002)(36756003)(5250100002)(106356001)(68736007)(6512007)(50226002)(26005)(53936002)(86612001)(446003)(386003)(102836004)(11346002)(8936002)(486006)(256004)(476003)(575784001)(14444005)(6506007)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0923;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ycbf8STCCU9JgD+F/Wu5o34/fbIf81nEIQp/1WZxOpkcrE/swx1EKzxkKeSiuCiwA8IO+4VHFlwoljFFbxXR1MbfeweG40wUd618eSCu8yw+Xq4p4VQk0HVnTdR2FmECTvx0T6GMW1JBMN5rSEsryKX8LHrMV8/rhRa55qaK85aNcrjEMiwImIgP/Bt4UPPT4yMzC/cEmnSlr8iPw9BPw1pFrsMgPnYnPNKHxpKG/1JTad/8VJNaGpgFNkK6yRhzngWunsxCJTKlvwzCVNBKKCTQwL3S6sgCAjGNj+TLGbHJ3W+w6cLWyHtY3oL/npaSHQlJjc8o+Op+rNfCASgB/wWtgJp4hFY8DgWeq39a7kA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8503b7-3aa7-4893-d0da-08d5f7042d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 16:39:25.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0923
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <Ben.Peart@microsoft.com>

Skip merging the commit, updating the index and working directory if and
only if we are creating a new branch via "git checkout -b <new_branch>."
Any other checkout options will still go through the former code path.=20

If sparse_checkout is on, require the user to manually opt in to this
optimzed behavior by setting the config setting checkout.optimizeNewBranch
to true as we will no longer update the skip-worktree bit in the index, nor
add/remove files in the working directory to reflect the current sparse
checkout settings.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

The biggest change in this version was suggested in feedback to the last
patch.  I have turned on the optimzation by default if sparse-checkout is
not on so that most users do not have to set anything and they will get the
benefit of the optimization.

Because users that use sparse checkout are probably doing so because they
have a large working directory, they stand to benefit the most from this
optimization.  To enable them to benefit, I added a "checkout.optimizeNewBr=
anch"
config setting that allows them to opt-in to this optimization if they are
willing to accept the change in behavior.  I updated the documentation whic=
h
should make it clear exactly what the change in behavior is.

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/5ea167fe90
    Checkout: git fetch https://github.com/benpeart/git checkout-b-v2 && gi=
t checkout 5ea167fe90
   =20
    ### Patches

 Documentation/config.txt         |   5 ++
 builtin/checkout.c               | 113 +++++++++++++++++++++++++++++--
 t/t1090-sparse-checkout-scope.sh |  14 ++++
 3 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43b2de7b5f..acf81143d4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1101,6 +1101,11 @@ browser.<tool>.path::
 	browse HTML help (see `-w` option in linkgit:git-help[1]) or a
 	working repository in gitweb (see linkgit:git-instaweb[1]).
=20
+checkout.optimizeNewBranch
+	When set to true, "git checkout -b <new_branch>" will not update the
+	skip-worktree bit in the index nor add/remove files in the working
+	directory to reflect the current sparse checkout settings.
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
 	-i or -n.   Defaults to true.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 28627650cd..991b71a341 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -24,6 +24,8 @@
 #include "submodule-config.h"
 #include "submodule.h"
=20
+static int checkout_optimize_new_branch;
+
 static const char * const checkout_usage[] =3D {
 	N_("git checkout [<options>] <branch>"),
 	N_("git checkout [<options>] [<branch>] -- <file>..."),
@@ -41,6 +43,10 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	/*
+	 * If new checkout options are added, skip_merge_working_tree
+	 * should be updated accordingly.
+	 */
=20
 	const char *new_branch;
 	const char *new_branch_force;
@@ -471,6 +477,98 @@ static void setup_branch_path(struct branch_info *bran=
ch)
 	branch->path =3D strbuf_detach(&buf, NULL);
 }
=20
+/*
+ * Skip merging the trees, updating the index and working directory if and
+ * only if we are creating a new branch via "git checkout -b <new_branch>.=
"
+ */
+static int skip_merge_working_tree(const struct checkout_opts *opts,
+	const struct branch_info *old_branch_info,
+	const struct branch_info *new_branch_info)
+{
+	/*
+	 * Do the merge if sparse checkout is on and the user has not opted in
+	 * to the optimized behavior
+	 */
+	if (core_apply_sparse_checkout && !checkout_optimize_new_branch)
+		return 0;
+
+	/*
+	 * We must do the merge if we are actually moving to a new commit.
+	 */
+	if (!old_branch_info->commit || !new_branch_info->commit ||
+		oidcmp(&old_branch_info->commit->object.oid, &new_branch_info->commit->o=
bject.oid))
+		return 0;
+
+	/*
+	 * opts->patch_mode cannot be used with switching branches so is
+	 * not tested here
+	 */
+
+	/*
+	 * opts->quiet only impacts output so doesn't require a merge
+	 */
+
+	/*
+	 * Honor the explicit request for a three-way merge or to throw away
+	 * local changes
+	 */
+	if (opts->merge || opts->force)
+		return 0;
+
+	/*
+	 * --detach is documented as "updating the index and the files in the
+	 * working tree" but this optimization skips those steps so fall through
+	 * to the regular code path.
+	 */
+	if (opts->force_detach)
+		return 0;
+
+	/*
+	 * opts->writeout_stage cannot be used with switching branches so is
+	 * not tested here
+	 */
+
+	/*
+	 * Honor the explicit ignore requests
+	 */
+	if (!opts->overwrite_ignore || opts->ignore_skipworktree ||
+		opts->ignore_other_worktrees)
+		return 0;
+
+	/*
+	 * opts->show_progress only impacts output so doesn't require a merge
+	 */
+
+	/*
+	 * If we aren't creating a new branch any changes or updates will
+	 * happen in the existing branch.  Since that could only be updating
+	 * the index and working directory, we don't want to skip those steps
+	 * or we've defeated any purpose in running the command.
+	 */
+	if (!opts->new_branch)
+		return 0;
+
+	/*
+	 * new_branch_force is defined to "create/reset and checkout a branch"
+	 * so needs to go through the merge to do the reset
+	 */
+	if (opts->new_branch_force)
+		return 0;
+
+	/*
+	 * A new orphaned branch requrires the index and the working tree to be
+	 * adjusted to <start_point>
+	 */
+	if (opts->new_orphan_branch)
+		return 0;
+
+	/*
+	 * Remaining variables are not checkout options but used to track state
+	 */
+
+	return 1;
+}
+
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old_branch_info,
 			      struct branch_info *new_branch_info,
@@ -845,10 +943,12 @@ static int switch_branches(const struct checkout_opts=
 *opts,
 		parse_commit_or_die(new_branch_info->commit);
 	}
=20
-	ret =3D merge_working_tree(opts, &old_branch_info, new_branch_info, &writ=
eout_error);
-	if (ret) {
-		free(path_to_free);
-		return ret;
+	if (!skip_merge_working_tree(opts, &old_branch_info, new_branch_info)) {
+		ret =3D merge_working_tree(opts, &old_branch_info, new_branch_info, &wri=
teout_error);
+		if (ret) {
+			free(path_to_free);
+			return ret;
+		}
 	}
=20
 	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && ne=
w_branch_info->commit !=3D old_branch_info.commit)
@@ -863,6 +963,11 @@ static int switch_branches(const struct checkout_opts =
*opts,
=20
 static int git_checkout_config(const char *var, const char *value, void *c=
b)
 {
+	if (!strcmp(var, "checkout.optimizenewbranch")) {
+		checkout_optimize_new_branch =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "diff.ignoresubmodules")) {
 		struct checkout_opts *opts =3D cb;
 		handle_ignore_submodules_arg(&opts->diff_options, value);
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-sco=
pe.sh
index 1f61eb3e88..25d7c700f6 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -31,6 +31,20 @@ test_expect_success 'perform sparse checkout of master' =
'
 	test_path_is_file c
 '
=20
+test_expect_success 'checkout -b checkout.optimizeNewBranch interaction' '
+	cp .git/info/sparse-checkout .git/info/sparse-checkout.bak &&
+	test_when_finished "
+		mv -f .git/info/sparse-checkout.bak .git/info/sparse-checkout
+		git checkout master
+	" &&
+	echo "/b" >>.git/info/sparse-checkout &&
+	test "$(git ls-files -t b)" =3D "S b" &&
+	git -c checkout.optimizeNewBranch=3Dtrue checkout -b fast &&
+	test "$(git ls-files -t b)" =3D "S b" &&
+	git checkout -b slow &&
+	test "$(git ls-files -t b)" =3D "H b"
+'
+
 test_expect_success 'merge feature branch into sparse checkout of master' =
'
 	git merge feature &&
 	test_path_is_file a &&

base-commit: ffc6fa0e396238de3a30623912980263b4f283ab
--=20
2.17.0.gvfs.1.123.g449c066

