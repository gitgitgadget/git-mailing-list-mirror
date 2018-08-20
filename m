Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC47F1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 16:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeHTUIf (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 16:08:35 -0400
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:59456
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbeHTUIe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 16:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDigVA/TzJEFVVB58Px9+W/f1v8FbGWEnsVmicB6fBY=;
 b=YAv8brkspYjuKGDCIozZkCgyFun0ZhEzTFy3ESY2cfGbaYNAcCfhzZBE42P46vq1Jvl+H4X/upSc6KV/iY4bn1Z6K1KjBzpnWqOGIjwftIblxEQtqJvOc1j2Ax4FaRhrH8UjULonCgFFVOKnep8WLO1xMiicGNwO3gIVtsBWjQ4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.3; Mon, 20 Aug 2018 16:52:00 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 16:52:00 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 5/9] midx: fix bug that skips midx with alternates
Thread-Topic: [PATCH 5/9] midx: fix bug that skips midx with alternates
Thread-Index: AQHUOKYdAGZTofFa1U6UNNwn6MPDYA==
Date:   Mon, 20 Aug 2018 16:52:00 +0000
Message-ID: <20180820165124.152146-6-dstolee@microsoft.com>
References: <20180820165124.152146-1-dstolee@microsoft.com>
In-Reply-To: <20180820165124.152146-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:903:103::30) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;6:fTKnCpguMTwes71QSlCucKU8YaG5VhampPJVnovEvGeMB4BX9FZeJXWpjTDgKJEycD/34x98H1umgGbHNL4X8N3J8zTvlfkvHKbddXuAHPBcSrOLKc5StG7E4aJKIBhfur028g5zIOholEpL+1ShRW/d9ZHVDRvsU/GPmmycgiUtTmTsLDITmTeFy32ImGJPly2As2tJTdxRhC4eCF07CeAd5ew5fYXvxKQSprO6U3/cjzTuWPZ2TJNGiL9VL1kCi83MCUHgIspE1SwR/eME5kJLiqDBpgF9skJjcqNwbeU1cy/UvKSkK1o77IWUv963iLf4PDIBErY/OPZZafo7RPcWtrymjszuUU/t3W+bujiKVr8XP9IKxNeCtacGlJy7LiCv7pe9zIDtxczXuSsGgONMxd2HMyrQXuH1SHlMnZmYpHDU+gYAV3tefJk4UtTDiBkyPWssUO+SwlBvtG5/mQ==;5:n9nI6F2tfPCyMIL5eyRQEjolkIb9c/cG0qgRen2KgwjMeT0fJhE94/sxh6Q8gt4v4b4yx4S6Tl9vFas+CgXlaPM0WMNMFa6Wm73hTQyR00uMZpJKiJGqyS+0I6RkwS1U5nvVzyShRD/M/X+ahOR0MCPg/pK0mJkxOfEYXhpJawY=;7:x3DKv9PAP2Tk+nKKR8MtXI1yC3JT0U3hpZAr0+pC1FHnn0F1+YCgPWQ4jnt9Zm+GU6i3PPQ9es2YgFUkHbHkNwiRoTHcaVpgec0C0tsGyiOlE/uTAHXab7ZSfZMA5oN8ZpTSuQ++iHhvdIXDvYmWgLlukRvFbd88yDgzvnw85F2Qu7yoIRUCjFjMQFnxu1XA5+GeDs3FDi6M3R1NGIyYdT330jH6NGFS7ZNDFsfacacjNbdbw6JvGnQRCy4N4nLl
x-ms-office365-filtering-correlation-id: ec80e478-7067-4b58-7e76-08d606bd3f6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
x-microsoft-antispam-prvs: <BL0PR2101MB0962161F4917E7EBE6C5A2A0A1320@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(8676002)(476003)(5640700003)(68736007)(2616005)(2906002)(81166006)(14454004)(81156014)(1730700003)(446003)(7736002)(2351001)(305945005)(22452003)(5660300001)(36756003)(6436002)(1076002)(6916009)(6486002)(46003)(316002)(25786009)(6116002)(53936002)(486006)(86362001)(76176011)(8936002)(6512007)(97736004)(256004)(86612001)(107886003)(478600001)(52116002)(10290500003)(6346003)(186003)(10090500001)(11346002)(2900100001)(386003)(102836004)(5250100002)(4326008)(99286004)(2501003)(106356001)(105586002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 5ZK8OeBNzTx4mUY59WdR49Li+hicwRvLguAN4XmS4wv9Hl6I6L4858gy9/4IZPlCPRFVnYhlnnvO8VXdevwS+5XDZNFkPFvX1Vrp2hdrEArnKiXUjEguOAG/DjN9UAJOyisZzLxFN1w4mIZpqeSbeCqr9wGHhraCQ07IIBnwzYSxAp1GaXfkMnIxPdA8RgNf2PMp8Es3FO+Nl/C5YMjCRB3yE/fwnCetJZx7tR6oLr4ZyNYlRSj0QVft432ZeR/l0M4qxJp6KmhJ/mzhK6/tFxIWBvmko2yKvpYDd6SWydsdjNV1dvJBTUvgLrLMo7h81srlbb72D2LNmWSBOw1VPc9+/e7ceCe1T1dpThcUp7Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec80e478-7067-4b58-7e76-08d606bd3f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 16:52:00.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The logic for constructing the linked list of multi-pack-indexes
in the object store is incorrect. If the local object store has
a multi-pack-index, but an alternate does not, then the list is
dropped.

Add tests that would have revealed this bug.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 11 ++++++-----
 t/t5319-multi-pack-index.sh | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index 7fa75a37a3..0710c4c175 100644
--- a/midx.c
+++ b/midx.c
@@ -331,7 +331,7 @@ int midx_contains_pack(struct multi_pack_index *m, cons=
t char *idx_name)
=20
 int prepare_multi_pack_index_one(struct repository *r, const char *object_=
dir, int local)
 {
-	struct multi_pack_index *m =3D r->objects->multi_pack_index;
+	struct multi_pack_index *m;
 	struct multi_pack_index *m_search;
 	int config_value;
=20
@@ -339,14 +339,15 @@ int prepare_multi_pack_index_one(struct repository *r=
, const char *object_dir, i
 	    !config_value)
 		return 0;
=20
-	for (m_search =3D m; m_search; m_search =3D m_search->next)
+	for (m_search =3D r->objects->multi_pack_index; m_search; m_search =3D m_=
search->next)
 		if (!strcmp(object_dir, m_search->object_dir))
 			return 1;
=20
-	r->objects->multi_pack_index =3D load_multi_pack_index(object_dir, local)=
;
+	m =3D load_multi_pack_index(object_dir, local);
=20
-	if (r->objects->multi_pack_index) {
-		r->objects->multi_pack_index->next =3D m;
+	if (m) {
+		m->next =3D r->objects->multi_pack_index;
+		r->objects->multi_pack_index =3D m;
 		return 1;
 	}
=20
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ae1d5d4592..4b6e2825a6 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -149,6 +149,23 @@ test_expect_success 'repack removes multi-pack-index' =
'
=20
 compare_results_with_midx "after repack"
=20
+test_expect_success 'multi-pack-index and alternates' '
+	git init --bare alt.git &&
+	echo $(pwd)/alt.git/objects >.git/objects/info/alternates &&
+	echo content1 >file1 &&
+	altblob=3D$(GIT_DIR=3Dalt.git git hash-object -w file1) &&
+	git cat-file blob $altblob &&
+	git rev-list --all
+'
+
+compare_results_with_midx "with alternate (local midx)"
+
+test_expect_success 'multi-pack-index in an alternate' '
+	mv .git/objects/pack/* alt.git/objects/pack
+'
+
+compare_results_with_midx "with alternate (remote midx)"
+
=20
 # usage: corrupt_data <file> <pos> [<data>]
 corrupt_data () {
--=20
2.18.0.118.gd4f65b8d14

