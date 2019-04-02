Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ADD920248
	for <e@80x24.org>; Tue,  2 Apr 2019 00:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDBANv (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 20:13:51 -0400
Received: from mail-eopbgr730134.outbound.protection.outlook.com ([40.107.73.134]:18496
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbfDBANu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 20:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEUQeyDIfdLBZSW2K+rjSu9yDjxDcNMs+4z1tl31gKY=;
 b=lH2o3j2aiTtehMYYsrgiONiPaGqhzfd0YPXcv1SiamCCTkfDH5Znj74Hc5GPtNeEd8KvSYLYNAIvnl/AcsxwGLxIsYxLyU0lZ5qOnVqeu7RA3BIR8asnoRICuSxJqg2Qt/btVATSatNiyBEx4ckdU5z1NWnCSOtCkg07iMyslzQ=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4827.namprd08.prod.outlook.com (20.176.115.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Tue, 2 Apr 2019 00:13:43 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Tue, 2 Apr 2019
 00:13:43 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Andrew Oakley <aoakley@roku.com>,
        =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Andrey Mazo <ahippo@yandex.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 1/2] git-p4: inexact label detection
Thread-Topic: [RFC PATCH v2 1/2] git-p4: inexact label detection
Thread-Index: AQHU6OjuTG4GXfq3D0C5mRAd1reYXA==
Date:   Tue, 2 Apr 2019 00:13:43 +0000
Message-ID: <54ef897fcf645d241690ce3be6867cb60d829552.1554162242.git.amazo@checkvideo.com>
References: <cover.1554141338.git.amazo@checkvideo.com>
 <cover.1554162242.git.amazo@checkvideo.com>
In-Reply-To: <cover.1554162242.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cde3896-0fa6-4417-be53-08d6b70010f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB4827;
x-ms-traffictypediagnostic: DM6PR08MB4827:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR08MB48274D7AD8E4E81E47576E2FDA560@DM6PR08MB4827.namprd08.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(71200400001)(11346002)(6436002)(476003)(446003)(486006)(14444005)(19627235002)(102836004)(305945005)(6506007)(386003)(97736004)(186003)(7736002)(256004)(26005)(71190400001)(86362001)(2501003)(76176011)(4326008)(52116002)(66066001)(68736007)(478600001)(966005)(105586002)(106356001)(2616005)(50226002)(8936002)(36756003)(25786009)(6512007)(6306002)(8676002)(5640700003)(81156014)(118296001)(7416002)(81166006)(1730700003)(2906002)(53936002)(316002)(6486002)(6916009)(54906003)(14454004)(3846002)(6116002)(5660300002)(2351001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4827;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IwP7Mol6Dqt5YL/UVojyIlLe60CpY7pzjYcenM9a6ODtOu3WGpnyuKMJpRRXV7azsEiY9emx34Xnpx0iguZn1aazkZKirK4fVlGOGXWsisItP2AfnKD4DsoH9rwER6uTtspubhAdsFhbsdykgv63pWKj6emz5uEk/jQstsyMmGNqUWKWpeFIVIqiJe5zkG+FSabeH/8+X7GKcnlldKhz6IlBSlDPMpykp2MY1DjPF804rRqG/R105dsEEyCiWzi9eoNEyecNBmBB0c5R1vV9vGjny6HksFYZsgkDbw9KMAgigfoUrEq5OuoaKT/8y+XKrv8JrEinVzhZ3CnN3e9vUGND13SMmGrVGSZLJdjjN3PQ/mFobNck2E7LVPf19SGo+Mn0Ibyg5M573BBQX/HwgGUpoZO9NJyi2MlDR+9Timc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cde3896-0fa6-4417-be53-08d6b70010f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 00:13:43.3906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4827
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Labels in Perforce are not global, but can be placed on a particular view/s=
ubdirectory.
This might pose difficulties when importing only parts of Perforce depot in=
to a git repository.
For example:
 1. Depot layout is as follows:
    //depot/metaproject/branch1/subprojectA/...
    //depot/metaproject/branch1/subprojectB/...
    //depot/metaproject/branch2/subprojectA/...
    //depot/metaproject/branch2/subprojectB/...
 2. Labels are placed as follows:
    * label 1A on //depot/metaproject/branch1/subprojectA/...
    * label 1B on //depot/metaproject/branch1/subprojectB/...
    * label 2A on //depot/metaproject/branch2/subprojectA/...
    * label 2B on //depot/metaproject/branch2/subprojectB/...
 3. The goal is to import
    subprojectA into subprojectA.git and
    subprojectB into subprojectB.git
    preserving all the branches and labels.
 4. Importing subprojectA.
    Label 1A is imported fine because it's placed on certain commit on bran=
ch1.
    However, label 1B is not imported because it's placed on a commit in an=
other subproject:
    git-p4 says: "importing label 1B: could not find git commit for changel=
ist ..."
    The same is with label 2A, which is imported; and 2B, which is not.

Currently, there is no easy way (that I'm aware of) to tell git-p4 to
import an empty commit into a desired branch,
so that a label placed on that changelist could be imported as well,
It might be possible to get a similar effect by importing both subprojectA =
and B in a single git repo,
and then running `git filter-branch --subdirectory-filter subprojectA`,
but this might produce way more irrelevant empty commits, than needed for l=
abels.
(although imported changelists can be limited with git-p4 --changesfile opt=
ion)
Also, `git filter-branch` is harder to use for incremental imports
or when changes are submitted from git back to Perforce.

As suggested by Luke,
instead of creating an empty commit for the sole purpose of being tagged la=
ter,
teach git-p4 to search harder for the next lower changelist,
corresponding to the label in question.

Do this by finding the highest changelist up to the label under all known b=
ranches,
(branches are finalized by the time importP4Labels() runs)
and using it instead of a depot-wide changelist corresponding to the label.

This new behavior may not be desired for people,
who want exact label <-> changelist relationship.
So, add a new boolean config parameter git-p4.allowInexactLabels (defaults =
to false)
to explicitly enable it if needed.
Also, this behavior only appears to be useful in case of multiple branches,
(otherwise, every Perforce changelist should appear in git)
so it's not engaged when running without branch detection.

Detect and report (--verbose) "inexact" tags,
i.e. tags placed on a lower changelist than was in Perforce.
Implement this by comparing a changelist for which a commit was found
with a changelist corresponding to the label on the whole depot.

Note, that the new "inexact" logic works slower
than the original code in case of numerous branches,
because p4 needs to calculate the most recent change for each branch path i=
nstead of just one.

This is an alternative solution to "alien" branches concept proposed earlie=
r:
https://public-inbox.org/git/b02df749b9266ac8c73707617a171122156621ab.15532=
83214.git.amazo@checkvideo.com/

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
Suggested-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt | 14 ++++++++++++
 git-p4.py                | 48 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3494a1db3e..ceabab8b86 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -582,10 +582,24 @@ git-p4.importLabels::
=20
 git-p4.labelImportRegexp::
 	Only p4 labels matching this regular expression will be imported. The
 	default value is '[a-zA-Z0-9_\-.]+$'.
=20
+git-p4.allowInexactLabels::
+	Only has an effect if run with `--detect-branches`.
+	By default, when performing p4 label import,
+	'git p4' finds a changelist number of every label,
+	then finds a git commit corresponding to the found changelist number,
+	and then places an annotated tag on the found git commit.
+	If a git commit is not found, the label is considered unimportable
+	and is added to 'ignoredP4Labels' list.
+	If 'allowInexactLabels' is set to true,
+	'git p4' only considers changelists under branches being imported.
+	This has an effect that a tag in git might be placed on a lower changelis=
t compared to p4.
+	This might be useful when importing just a subset of the depot into git,
+	if a label would be discarded otherwise.
+
 git-p4.useClientSpec::
 	Specify that the p4 client spec should be used to identify p4
 	depot paths of interest.  This is equivalent to specifying the
 	option `--use-client-spec`.  See the "CLIENT SPEC" section above.
 	This variable is a boolean, not the name of a p4 client.
diff --git a/git-p4.py b/git-p4.py
index 96c4b78dc7..98b2b7bbca 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3162,17 +3162,43 @@ def importP4Labels(self, stream, p4Labels):
             if name in ignoredP4Labels:
                 continue
=20
             labelDetails =3D p4CmdList(['label', "-o", name])[0]
=20
-            # get the most recent changelist for each file in this label
-            change =3D p4Cmd(["changes", "-m", "1"] + ["%s...@%s" % (p, na=
me)
+            if self.detectBranches and gitConfigBool("git-p4.allowInexactL=
abels"):
+                doInexactLabels =3D True
+            else:
+                doInexactLabels =3D False
+
+            # get the most recent changelist in this label for the whole d=
epot
+            depot_wide_changelist =3D p4Cmd(["changes", "-m", "1"] + ["%s.=
..@%s" % (p, name)
                                 for p in self.depotPaths])
+            if 'change' in depot_wide_changelist:
+                depot_wide_changelist =3D int(depot_wide_changelist['chang=
e'])
+            else:
+                depot_wide_changelist =3D None
=20
-            if 'change' in change:
+            # get the most recent changelist for each file under branches =
of interest in this label
+            if doInexactLabels:
+                if self.useClientSpec:
+                    paths =3D ["%s...@%s" % (self.clientSpecDirs.client_pr=
efix + p + '/', name) for p in self.knownBranches]
+                else:
+                    paths =3D ["%s...@%s" % (self.depotPaths[0] + p + '/',=
 name) for p in self.knownBranches]
+                changes =3D p4CmdList(["changes", "-m", "1"] + paths)
+                changes =3D [int(c['change']) for c in changes if 'change'=
 in c]
+
+                # there may be different "most recent" changelists for dif=
ferent paths.
+                # take the newest since some paths were just modified late=
r than others.
+                if changes:
+                    changelist =3D max(changes)
+                else:
+                    changelist =3D None
+            else:
+                changelist =3D depot_wide_changelist
+
+            if changelist:
                 # find the corresponding git commit; take the oldest commi=
t
-                changelist =3D int(change['change'])
                 if changelist in self.committedChanges:
                     gitCommit =3D ":%d" % changelist       # use a fast-im=
port mark
                     commitFound =3D True
                 else:
                     gitCommit =3D read_pipe(["git", "rev-list", "--max-cou=
nt=3D1",
@@ -3192,14 +3218,24 @@ def importP4Labels(self, stream, p4Labels):
                         tmwhen =3D 1
=20
                     when =3D int(time.mktime(tmwhen))
                     self.streamTag(stream, name, labelDetails, gitCommit, =
when)
                     if verbose:
-                        print("p4 label %s mapped to git commit %s" % (nam=
e, gitCommit))
+                        if depot_wide_changelist =3D=3D changelist:
+                            isExact =3D ""
+                        else:
+                            isExact =3D " inexactly"
+                        print("p4 label %s mapped%s to git commit %s" % (n=
ame, isExact, gitCommit))
             else:
                 if verbose:
-                    print("Label %s has no changelists - possibly deleted?=
" % name)
+                    if depot_wide_changelist:
+                        # there is a changelist corresponding to this labe=
l,
+                        # but it's not under any branches of interest.
+                        print("Label %s has no changelists under detected =
branches -- ignoring" % name)
+                    else:
+                        # there is no changelist corresponding to this lab=
el in the whole depot
+                        print("Label %s has no changelists - possibly dele=
ted?" % name)
=20
             if not commitFound:
                 # We can't import this label; don't try again as it will g=
et very
                 # expensive repeatedly fetching all the files for labels t=
hat will
                 # never be imported. If the label is moved in the future, =
the
--=20
2.19.2

