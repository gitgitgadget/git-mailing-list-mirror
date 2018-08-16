Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6C9F1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeHPV1e (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:27:34 -0400
Received: from mail-sn1nam01on0136.outbound.protection.outlook.com ([104.47.32.136]:6073
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726470AbeHPV1e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxwGSuLYC9K5n3RCGJ6nbEYQkJXbIBWQjwFH4qyqrwA=;
 b=bUpRX7rXrNocHyeWT8bYEB2tt3ODx05/W0gVPIUjwDaYzzSfL/gz/TL0zJ+c+DRGd1ZhIBUXcYLyPUmCQN+jV0Kb/J3c89FizGpnQLHqIsRisNjZl/vJaxzQT8WRo+kIpXx+dOo0dltWg4QHlVYNv3Kkkas2nlHVC5BX/OIaElI=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1084.namprd21.prod.outlook.com (52.132.149.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.5; Thu, 16 Aug 2018 18:27:11 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf%3]) with mapi id 15.20.1080.009; Thu, 16 Aug 2018
 18:27:11 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
Thread-Topic: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
Thread-Index: AQHUNY6/QXdNsLrI2E2sdHtKGSGiNQ==
Date:   Thu, 16 Aug 2018 18:27:11 +0000
Message-ID: <20180816182653.15580-1-benpeart@microsoft.com>
References: <20180724180122.29212-1-benpeart@microsoft.com>
In-Reply-To: <20180724180122.29212-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY1PR07CA0032.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::42) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1084;6:hm/NSedIZXUm4ljF9qmo5yy+cro2f2A5RcpsD7l4kY6XKocxVQlC79kJxaqcUGNLwukvLmOHfS9qPMvlOAHC3IZc5Y3FFVH+VxbAT/5Zq2+tMGlQa/nAO4B9aaFxkCJGN4IiflB4cJEThJMP6LdSNgXB4qidT3KcXf76elgh8/T63pvm5wR3e4rkrmHsT5CtR8h1d41CSseXd+tzMFIgeEQ8ldvV0ZOcfGM+zjBuGKuISpznz2dd4Jq1iivPFM6CIwzpaJ2tsOuLh5AkOvoE5jaMVicqCsPfJuYnlo0sVMh+JDPHqQLtZNkK2h3M0sFZzmMmkm/170bJuvpSbdJ+Ii5fY2STLYjIEBIKwJLIAY69d6VP608BSAlSeSyrz/drdmVkWwhrpsFqZt2TLcBpxcsMgq2urmXGxhizKbzy4VWk+4FrFJywg5/HR+OmJa7Svcm6PnT0FUCW9QPCR8Eb5g==;5:Fyx7qiFmEEOVkJBkj8Bpoaw4sHCZF/s1AGjLkQ/2S5NQE1wmT17xa843BC9dY/pSiyhiAyEC69rt4SQ2/du4+LQV0iEr0Xcc6+k2si2iHiFmuC7tvClVMVuqSff0haaU4XWUjZAyeAOrvxV9REWXetiUCIZl7WCT9SVFXnsu4CA=;7:24SRQiiEhHZGPyUDbldNEzfAdpB56GdEi534+1KBlZBGTVqK5+Mn0RookRBOOkF8ctfQ0vgegVvg+mOfjngL3o5CSaKhOaK1LvEVAdwP1fBX8TYNoxSGnEI7Jrw/o1LEyYyDES0b5+X26gMUNNmhkBTdF4xwF37T6118sZMw3aVdKuPxHk8U9IUymQ/gggd4wE0ABzj17GsnjD8bAE68uoTwTwQVyQIGsUvLT4d5bfnmgDeuELYkjcSXXxJTxd4i
x-ms-office365-filtering-correlation-id: e6a53738-2068-4017-5c32-08d603a5e18f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1084;
x-ms-traffictypediagnostic: MW2PR2101MB1084:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1084FC21F14B2EDA567C73C2F43E0@MW2PR2101MB1084.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(3231336)(8210008)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:MW2PR2101MB1084;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1084;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(8676002)(6862004)(2906002)(4326008)(81156014)(81166006)(6116002)(1076002)(14444005)(3846002)(6486002)(76176011)(99286004)(7736002)(39060400002)(305945005)(52116002)(6306002)(107886003)(36756003)(6436002)(25786009)(97736004)(256004)(68736007)(6512007)(2900100001)(22452003)(446003)(50226002)(86612001)(316002)(476003)(5660300001)(478600001)(10290500003)(8936002)(6636002)(26005)(37006003)(54906003)(106356001)(11346002)(105586002)(1511001)(66066001)(486006)(53936002)(2616005)(102836004)(966005)(5250100002)(386003)(6506007)(72206003)(14454004)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1084;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CApZgKBq1uuBgtDbxVreB1JCr1V4Hlxpi4/jkJQpqxAD+QnpuzjT6n3oESUwJXFRW9C7tP52a8H9QoYz0zOaxbQXrvIZJbITG4n54Hhn/9QY8/+m5ujyC8Jk4TB5YQmUxkJbd8z8wr4ZULHimDt33zy2+W9PrdVCT9H9bSRpWjq0Fi9D6DrrTqXh7bARQxtUio7sixR93lKnepWXtqMpSA+MHTnBG8NV47ntd/a9ofwGzNQJe1cH5kAU5Sl5sGda/TcmOledWc+TUpyuJSsYEvsUyiAB0unqzumkKFCuEs5nO4L/iZSecdWr0rv/Kr5tP+hGY9PJ6hCwpkVZi45QsWU3nsSN8gK33qXsdP3NYR8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a53738-2068-4017-5c32-08d603a5e18f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 18:27:11.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1084
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <Ben.Peart@microsoft.com>

Skip merging the commit, updating the index and working directory if and
only if we are creating a new branch via "git checkout -b <new_branch>."
Any other checkout options will still go through the former code path.

If sparse_checkout is on, require the user to manually opt in to this
optimzed behavior by setting the config setting checkout.optimizeNewBranch
to true as we will no longer update the skip-worktree bit in the index, nor
add/remove files in the working directory to reflect the current sparse
checkout settings.

For comparison, running "git checkout -b <new_branch>" on a large repo take=
s:

14.6 seconds - without this patch
0.3 seconds - with this patch

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

The biggest change in this version is that I have added the logic to call
show_local_changes() on the optimized path.  Since this can be expensive on
large repos (see below) this behavior is turned off if the user sets the
"checkout.optimizeNewBranch" setting.

$ git checkout -b newbranch
read-cache.c:2006       performance: 0.517875500 s: read cache .git/index
name-hash.c:605         performance: 0.277765000 s: initialize name hash
preload-index.c:111     performance: 0.019401300 s: preload index
diff-lib.c:527          performance: 3.807563700 s: diff-index
Switched to a new branch 'newbranch'
trace.c:420             performance: 5.044219600 s: git command: c:git chec=
kout -b newbranch


$ git checkout -b newbranch1
Switched to a new branch 'newbranch1'
trace.c:420             performance: 0.332873600 s: git command: c:git chec=
kout -b newbranch111

Notes:
    Base Ref: master
    Web-Diff: https://github.com/benpeart/git/commit/aebe02c966
    Checkout: git fetch https://github.com/benpeart/git checkout-b-v3 && gi=
t checkout aebe02c966
   =20
    ### Patches

 Documentation/config.txt         |   8 +++
 builtin/checkout.c               | 120 +++++++++++++++++++++++++++++--
 t/t1090-sparse-checkout-scope.sh |  14 ++++
 3 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fd8d27e761..2298ecd753 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1135,6 +1135,14 @@ and by linkgit:git-worktree[1] when 'git worktree ad=
d' refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
=20
+checkout.optimizeNewBranch
+	Optimizes the performance of "git checkout -b <new_branch>" when
+	using sparse-checkout.  When set to true, git will not update the
+	repo based on the current sparse-checkout settings.  This means it
+	will not update the skip-worktree bit in the index nor add/remove
+	files in the working directory to reflect the current sparse checkout
+	settings nor will it show the local changes.
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
 	-i or -n.   Defaults to true.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cb6bb76312..26b1a5053a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -25,6 +25,8 @@
 #include "submodule.h"
 #include "advice.h"
=20
+static int checkout_optimize_new_branch;
+
 static const char * const checkout_usage[] =3D {
 	N_("git checkout [<options>] <branch>"),
 	N_("git checkout [<options>] [<branch>] -- <file>..."),
@@ -42,6 +44,10 @@ struct checkout_opts {
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
@@ -472,6 +478,98 @@ static void setup_branch_path(struct branch_info *bran=
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
@@ -846,10 +944,19 @@ static int switch_branches(const struct checkout_opts=
 *opts,
 		parse_commit_or_die(new_branch_info->commit);
 	}
=20
-	ret =3D merge_working_tree(opts, &old_branch_info, new_branch_info, &writ=
eout_error);
-	if (ret) {
-		free(path_to_free);
-		return ret;
+	/* optimize the "checkout -b <new_branch> path */
+	if (skip_merge_working_tree(opts, &old_branch_info, new_branch_info)) {
+		if (!checkout_optimize_new_branch && !opts->quiet) {
+			if (read_cache_preload(NULL) < 0)
+				return error(_("index file corrupt"));
+			show_local_changes(&new_branch_info->commit->object, &opts->diff_option=
s);
+		}
+	} else {
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
@@ -864,6 +971,11 @@ static int switch_branches(const struct checkout_opts =
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

base-commit: 63749b2dea5d1501ff85bab7b8a7f64911d21dea
--=20
2.18.0.windows.1

