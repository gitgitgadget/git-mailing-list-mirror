Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D55C01F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeGRVY6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:24:58 -0400
Received: from mail-sn1nam01on0112.outbound.protection.outlook.com ([104.47.32.112]:23886
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729863AbeGRVY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtSKp2ka5hRC13ReUciwvf4nEdR54m0dtMOR1vFoEfg=;
 b=ASrLMkrz29b6ihbO2RHbORAmkodKEDlGY4Ib3mXVimrarUtdfWsXFLFZGLJ0QiBwTycA8lOOh84m8BWqX1U6h1EdqB+Ob4ZPu5RUUFoijmh4sHOeJZXoTtrUMRIvgksLnwmFmHcaXKUZ6yp4cdYDcnVZ02E2QLzTv5qJlpwVumo=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0966.namprd21.prod.outlook.com (52.132.133.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Wed, 18 Jul 2018 20:45:16 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::65fa:bfcd:22b6:7861]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::65fa:bfcd:22b6:7861%4]) with mapi id 15.20.0995.008; Wed, 18 Jul 2018
 20:45:16 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 2/3] add performance tracing around traverse_trees() in
 unpack_trees()
Thread-Topic: [PATCH v1 2/3] add performance tracing around traverse_trees()
 in unpack_trees()
Thread-Index: AQHUHtg71luZTTecZUWZok21oirpEA==
Date:   Wed, 18 Jul 2018 20:45:16 +0000
Message-ID: <20180718204458.20936-3-benpeart@microsoft.com>
References: <20180718204458.20936-1-benpeart@microsoft.com>
In-Reply-To: <20180718204458.20936-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: DM5PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:3:12b::18) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;6:N6G+WIDoJ2w0pnWUnh6unTbhTssH7H/YCvfVwf268VubzkCYhsNeGX15O8QgPM3tcDhVssPxdvuwCR+p5LmmiJ4Tiu/qnEBobOVn55EvnUvynwnxaUVfRBODwnmbyJ1QijxrxPTZQ4WucBrsniVu3JRs5UQ6SIRRBOtvxt2pPucFcgQyEmSffenOl0jWMp058Ejysdecfl5RVfw44p00axuTJcw/Qqp/kg8twnzVSWDpWlnBqt5pnwO7X28jZhhNFrlSJjQmUWI5qtBklqPL6fGHCVbtu/Jv/UFSuGuaaCmQJYMZp2vxwV3fS539POaGdvOWEqyK2VJhmByIIwgKVFCKlN0YB/+OAZ72kOXAb/xqEgYfPPeMd4/raylcoKQn/k/+8POpnZpHpsO/EPPmeLujTsL0q5mepE3oSW0Fdu3ZLzAfblkkUJcaqJBOAk9DiZJ8I7HErwmXiMVmdtdvUg==;5:+9MLOjaQ3om/gfaDqukH2ncyUjxgzVoeTn6p5RqGyR/VOTB0GmH8x6dlxxh1ROPAngZqxktmK7OZH/x1d8lL/hpT4kC3cX5iytPhjXqWKl1PPAp+n6/z6oD5IDjoe0kqnFRKbQ4NKbiourSyiP1o/M/VrergnOkZdxDA3Vdga0I=;7:1vbt3W7+L3ceYvojCpWt+EtF1Fev8XohuOVXRw7nZMyputhedl2wRZ00kiVQfVY4G4z+HoeYyl6cAgyzzgOLGsekPIA3M8f3x+JZNUsS/fyLFqnZesLiIqElokZBQ2zV7guzC0r66pt4tulHw5uFQGKWv3YBlpkjM2UVchwkV/HXdBlOz5ETrpP//ti4TpwGLFPHOHRVTgivAF4j4XCZCPlErbjQaCLNEGMDG/1OB0zsvLAjaqL3BZkFWw6N1D2v
x-ms-office365-filtering-correlation-id: afa005a9-650c-485e-eaf7-08d5ecef5e07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB09668E03B4A9878DF2423EEAF4530@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(2351001)(5640700003)(105586002)(4326008)(6436002)(22452003)(106356001)(52116002)(5250100002)(76176011)(8936002)(1730700003)(8676002)(81166006)(81156014)(6486002)(478600001)(10290500003)(2616005)(72206003)(476003)(446003)(11346002)(486006)(66066001)(256004)(107886003)(6512007)(53936002)(86612001)(99286004)(305945005)(186003)(36756003)(2900100001)(14454004)(25786009)(7736002)(10090500001)(50226002)(1076002)(2501003)(2906002)(68736007)(97736004)(316002)(3846002)(6116002)(54906003)(5660300001)(6916009)(102836004)(26005)(386003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2TuP5Z8c3eG9ahaa0PVUt9JoXkLiqPoUhGAe2IXxN/ng12GI5RF6RQYNJaQNToqSIGTYIfeTsTeniGd98F4ONFu4bYg87pG/rp/MaHZBZijatC1pP4xHEnbEt+8wdYoPfvqdZcxG3eHoSiEmmGVxPmyqvWuYItG8t+wCy23NJUH307W/H/CRPI2KkYz9I6yHdQCJAaRde1u0vKPDocJJvBLGtmFEheRhfkJGOQ6NG9Jh5cTat9hUCo/rvpex748fJMVMysWu1imQuR8afjKJYAKmI7pG5Rzic14NOMItke+NyIo+8HkTq3IdfXaA82HZrrAXFy482rMw/yUv/XWqm5Hxa7KnDBFWQS+CjBh9xJk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa005a9-650c-485e-eaf7-08d5ecef5e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 20:45:16.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 unpack-trees.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a85a02a77..1f58efc6bb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1326,6 +1326,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, s=
truct unpack_trees_options
 	if (len) {
 		const char *prefix =3D o->prefix ? o->prefix : "";
 		struct traverse_info info;
+		uint64_t start;
=20
 		setup_traverse_info(&info, prefix);
 		info.fn =3D unpack_callback;
@@ -1350,8 +1351,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, =
struct unpack_trees_options
 			}
 		}
=20
+		start =3D getnanotime();
 		if (traverse_trees(len, t, &info) < 0)
 			goto return_failed;
+		trace_performance_since(start, "traverse_trees");
 	}
=20
 	/* Any left-over entries in the index? */
--=20
2.17.0.gvfs.1.123.g449c066

