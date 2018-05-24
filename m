Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4948A1F42D
	for <e@80x24.org>; Thu, 24 May 2018 16:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033600AbeEXQ0D (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 12:26:03 -0400
Received: from mail-by2nam01on0132.outbound.protection.outlook.com ([104.47.34.132]:51472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030515AbeEXQZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 12:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+wyabJQeD0+1xjwe3dsbHutsHM8sQ09O6J4t0zhGyQ=;
 b=kLGZ7PI3djYc4NO18bDec8DYwgeyaCn+5pTR9+XVEcmSMPB69/OwPJ+pK5zeCbQKr3v/V4ycglgcMhFyUdCZzaZjxPBhSOWbfJlLjATb+NZezIS2OeeB9E5+r7fa8nzrE7hVh+vqReYO+wfuAcgm8WybydNtlQ8WEj0jo1j9Zu8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 16:25:45 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::7037:b3ec:4240:9d19%5]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 16:25:45 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 09/20] commit-graph: verify corrupt OID fanout and lookup
Thread-Topic: [PATCH v3 09/20] commit-graph: verify corrupt OID fanout and
 lookup
Thread-Index: AQHT83vdE9g+nqcEE0iMQO8Jp1xtGQ==
Date:   Thu, 24 May 2018 16:25:45 +0000
Message-ID: <20180524162504.158394-10-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
In-Reply-To: <20180524162504.158394-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:404:f5::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:MhYuvQ7cW87wLZJmMYxTOQA0dddlYtktdH4nyQnEeTov5NEURAgtjaMaX2WHkHnCF0jy8KNZ20RB8W+XL8/EULVwiHvQez5Kw5/qS5er/79AuBDXNf4QNjgUgWSvloLRocHr8/xK8zV9l8wBBGNbG29TltTXMI1MdZ7/+lCFdjWdao4k40bibh77d2J7NDlUP5sh/Z7Tg0y60NxDhD6EXcIH7vNIy478eaBxjTFGSFpwPvQOXsp4iteL96EpW1W8;20:aBqlpQSfav62CqlvgLlUzWDYp1Cif2PLLPQ22cVlFPGjLoZErOyIpzFT31HETzg0ZxLDaLHFalEV9O0zrn21QGAjLqhihX3VbdKTG37sLLlFT559dMVbwi2aivqmX/Z7A3prV8MhYIm5Gw33f4ck3B1fjUIeBhrdkVx54G5Fi3g=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1091B96C8C14AB4F41215E02A16A0@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(376002)(39860400002)(189003)(199004)(1076002)(53936002)(97736004)(6512007)(86612001)(81166006)(59450400001)(6116002)(25786009)(107886003)(10090500001)(4326008)(3660700001)(2616005)(52116002)(11346002)(186003)(2906002)(446003)(76176011)(305945005)(7736002)(8656006)(54906003)(3280700002)(46003)(86362001)(99286004)(102836004)(1730700003)(81156014)(8936002)(386003)(6506007)(476003)(22452003)(8676002)(486006)(316002)(39060400002)(5250100002)(14454004)(5640700003)(5660300001)(106356001)(2501003)(68736007)(478600001)(10290500003)(2351001)(2900100001)(36756003)(15650500001)(6436002)(6486002)(105586002)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T4IjyQsUsa7U+75YUVj7pvZMzZhciJnQpPVW9CzMYaUe9F2+PbN4/z9ZkLEIAIlAmr6xIEE58NF3x2BVhDDp3lt2xZ0oGCruD4PoTZDX0phbUaw3ha1YpnW1MfNhd9LK8p4s9B+FzZ565OGGaDRFXM8GAGEQfjiZLSEnV/52dWWMsPPcAxUZ7mx/jq2reBqU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4c4831c0-89dd-4c25-d156-08d5c1930036
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4831c0-89dd-4c25-d156-08d5c1930036
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 16:25:45.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the commit-graph file, the OID fanout chunk provides an index into
the OID lookup. The 'verify' subcommand should find incorrect values
in the fanout.

Similarly, the 'verify' subcommand should find out-of-order values in
the OID lookup.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 36 ++++++++++++++++++++++++++++++++++++
 t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 06e3e4f9ba..cbd1aae514 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -855,6 +855,9 @@ static void graph_report(const char *fmt, ...)
=20
 int verify_commit_graph(struct commit_graph *g)
 {
+	uint32_t i, cur_fanout_pos =3D 0;
+	struct object_id prev_oid, cur_oid;
+
 	if (!g) {
 		graph_report("no commit-graph file loaded");
 		return 1;
@@ -869,5 +872,38 @@ int verify_commit_graph(struct commit_graph *g)
 	if (!g->chunk_commit_data)
 		graph_report("commit-graph is missing the Commit Data chunk");
=20
+	if (verify_commit_graph_error)
+		return verify_commit_graph_error;
+
+	for (i =3D 0; i < g->num_commits; i++) {
+		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
+
+		if (i && oidcmp(&prev_oid, &cur_oid) >=3D 0)
+			graph_report("commit-graph has incorrect OID order: %s then %s",
+				     oid_to_hex(&prev_oid),
+				     oid_to_hex(&cur_oid));
+
+		oidcpy(&prev_oid, &cur_oid);
+
+		while (cur_oid.hash[0] > cur_fanout_pos) {
+			uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_pos=
);
+			if (i !=3D fanout_value)
+				graph_report("commit-graph has incorrect fanout value: fanout[%d] =3D =
%u !=3D %u",
+					     cur_fanout_pos, fanout_value, i);
+
+			cur_fanout_pos++;
+		}
+	}
+
+	while (cur_fanout_pos < 256) {
+		uint32_t fanout_value =3D get_be32(g->chunk_oid_fanout + cur_fanout_pos)=
;
+
+		if (g->num_commits !=3D fanout_value)
+			graph_report("commit-graph has incorrect fanout value: fanout[%d] =3D %=
u !=3D %u",
+				     cur_fanout_pos, fanout_value, i);
+
+		cur_fanout_pos++;
+	}
+
 	return verify_commit_graph_error;
 }
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4ef3fe3dc2..c050ef980b 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -247,6 +247,7 @@ test_expect_success 'git commit-graph verify' '
 	git commit-graph verify >output
 '
=20
+HASH_LEN=3D20
 GRAPH_BYTE_VERSION=3D4
 GRAPH_BYTE_HASH=3D5
 GRAPH_BYTE_CHUNK_COUNT=3D6
@@ -258,6 +259,12 @@ GRAPH_BYTE_OID_LOOKUP_ID=3D`expr $GRAPH_CHUNK_LOOKUP_O=
FFSET + \
 			      1 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
 GRAPH_BYTE_COMMIT_DATA_ID=3D`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
 				2 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
+GRAPH_FANOUT_OFFSET=3D`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
+			  $GRAPH_CHUNK_LOOKUP_WIDTH \* $GRAPH_CHUNK_LOOKUP_ROWS`
+GRAPH_BYTE_FANOUT1=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 4`
+GRAPH_BYTE_FANOUT2=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 255`
+GRAPH_OID_LOOKUP_OFFSET=3D`expr $GRAPH_FANOUT_OFFSET + 4 \* 256`
+GRAPH_BYTE_OID_LOOKUP_ORDER=3D`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \=
* 8`
=20
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -312,4 +319,19 @@ test_expect_success 'detect missing commit data chunk'=
 '
 		"missing the Commit Data chunk"
 '
=20
+test_expect_success 'detect incorrect fanout' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT1 "\01" \
+		"fanout value"
+'
+
+test_expect_success 'detect incorrect fanout' '
+	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
+		"fanout value"
+'
+
+test_expect_success 'detect incorrect OID order' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OID_LOOKUP_ORDER "\01" \
+		"incorrect OID order"
+'
+
 test_done
--=20
2.16.2.329.gfb62395de6

