Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A0F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeIGBlN (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:41:13 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:53953
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728917AbeIGBlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YwKRuW3RcUWTUWrp12vsFV0IxSZeIZKnSwiQvffqIA=;
 b=A5k05tVGiyQXe/iyx1tJsNtx+uj94ZDLMv2UcOOEdfslEPhkj8V63K1UloWzx5C7tOtKIjoT8nP2tZsFzyjPpkIafa89Ur8ibtSZRorg8T3n+GAcvddpeHqtOknJ0AlmF2ie6sEp76saiQpPZLWynTnv4TtyESPhJPvOJSrDliE=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1033.namprd21.prod.outlook.com (52.132.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Thu, 6 Sep 2018 21:03:55 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858%4]) with mapi id 15.20.1143.008; Thu, 6 Sep 2018
 21:03:55 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 1/4] read-cache: optimize expand_name_field() to speed up
 V4 index parsing.
Thread-Topic: [PATCH v3 1/4] read-cache: optimize expand_name_field() to speed
 up V4 index parsing.
Thread-Index: AQHURiUfYGUy5wqKq0OHMmtAE99Jyw==
Date:   Thu, 6 Sep 2018 21:03:54 +0000
Message-ID: <20180906210227.54368-2-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;6:kyinST2JJ4PHHJF2WoGldmJ8cjS9bia7t+DvvpOVZlB/mGcm/NhOLDPbSOoG2GssuhdlgN+ogwREEGbh+BGUBzbE//I1g320jf+eFYYRwAjJtJG+sO1TahalRdPGGFJY8xeR73ceKhIvjepKvvlS+bE/m72XgZsp0YWTv/x1lu2+yRK7A1ej/3oVi4Z2vMwRgas/G6Yb8Ci8iP4dXWrGW4JHMTToF3xadnSt0HUo+8deJMw+qZ2BL9g95PJVWjbMDI+lzt6P3p9EZm8aqI4CuWAev+e4qd1UmG3Ww1FaHoZmLkM8o1Fknt3vnUHzIQKxxDVhBWoUcA8LoqQtX7tAxegIsY0y2spU+luBCIeDtZPH2meYlNlQaPOoLn0gjm3UFQSu71G+8FjVbo5Pm3PJOAgQGa+hsCJF9BGWYmSDqOSoksycq8uFyhFvgQ/iMTS4+w6OLlCloFe70HbwbLMtow==;5:lRvaudJjWtqfY+3JJ8IQYSA50646aHdohWUghNtlYPgvcnM92wnJH4C02o5p1xhzQxIuv+yMZm1/qyYgImTEqhNI4+lUnhtb4x5UzIew7ahkaHB+H9m8CYk2FzaoaumV0w3iFKc64wr42r+4oLZYrLEpMQ3798VAcJlf/n/ANFw=;7:OSBnPykKcZksNJXjpK7SM3tp5B9llDSgY1a+Py5LcQ6V7ZL6ExqwDOnB2wbyLCZ8T7EeEmpXLoeU2U2JjU/mlN228zhxjSvc/g5RregfdLWXDX6cg1jJJIaUWT0vafINicTIVpqQ6p7Eki+zL0oCK2xhnABC6aYantXvHILCgFgfBlNkdQlexD8vZ152TNnqEis/GJnMNs3jFNKFEop3W0NLuCFDfy2DNKf3VPrHfCLHdwr+t/up5DJ+NwfPlox2
x-ms-office365-filtering-correlation-id: 453a0fca-6441-463c-9cfb-08d6143c4131
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
x-microsoft-antispam-prvs: <MW2PR2101MB10338895C898ADE85E154CB4F4010@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(476003)(2616005)(446003)(22452003)(102836004)(486006)(68736007)(39060400002)(2501003)(5250100002)(2351001)(1076002)(3846002)(53936002)(6116002)(50226002)(36756003)(186003)(6346003)(26005)(52116002)(76176011)(107886003)(14444005)(25786009)(386003)(316002)(6506007)(54906003)(8936002)(99286004)(11346002)(4326008)(72206003)(86612001)(6916009)(10090500001)(7736002)(5660300001)(14454004)(10290500003)(478600001)(2906002)(256004)(105586002)(305945005)(8676002)(81156014)(81166006)(1730700003)(66066001)(2900100001)(561924002)(106356001)(6436002)(97736004)(6486002)(6512007)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: Mxro8ANuSlLiRKKsFLzt1qNtlGbe0mdAl0ARfk4IJ9eh2Beq16F6Upx/80qjobVlkstwg3XVRrCqvr7CAUtx0JWnIZCQSkQGDf+KmKcHJ89CX2nEjFNgeyhO1kvUiMHRlvOLt2J0epxG7x7cc4gMEVC76oy+MtIh8oO+/GWqY8phbvhPsaqMMjUDGIbQWnGhcRpUp2KJ3EJR7PeI5LkidVA0ho/H41MT07pvzondQF0R9sOntoSm3cKpmYpkNrhm1wK9IgKfpIuE708GFK0rTZOC4L3yMA90OQHWi9y+USVom6tgbY8MD6ciqCitr7FOXQuh7vFN6A1E1wEzIykRS0SB/YLekbL5PA2TVCaVvmM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F742AD47F161B4191B90349A08FB9AB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453a0fca-6441-463c-9cfb-08d6143c4131
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 21:03:55.2461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T3B0aW1pemUgZXhwYW5kX25hbWVfZmllbGQoKSB0byBzcGVlZCB1cCBWNCBpbmRleCBwYXJzaW5n
Lg0KDQogLSBzdHJidWZfcmVtb3ZlKCkgaW4gZXhwYW5kX25hbWVfZmllbGQoKSBpcyBub3QgZXhh
Y3RseSBhIGdvb2QgZml0DQogICBmb3Igc3RyaXBwaW5nIGEgcGFydCBhdCB0aGUgZW5kLCBfc2V0
bGVuKCkgd291bGQgZG8gdGhlIHNhbWUgam9iDQogICBhbmQgaXMgbXVjaCBjaGVhcGVyLg0KDQog
LSB0aGUgb3Blbi1jb2RlZCBsb29wIHRvIGZpbmQgdGhlIGVuZCBvZiB0aGUgc3RyaW5nIGluDQog
ICBleHBhbmRfbmFtZV9maWVsZCgpIGNhbid0IGJlYXQgYW4gb3B0aW1pemVkIHN0cmxlbigpDQoN
CkkgdXNlZCBwMDAwMi1yZWFkLWNhY2hlLnNoIHRvIGdlbmVyYXRlIHNvbWUgcGVyZm9ybWFuY2Ug
ZGF0YToNCg0KcDAwMDItcmVhZC1jYWNoZS5zaCB3LzEwMCwwMDAgZmlsZXMNCkJhc2VsaW5lICAg
ICAgICAgZXhwYW5kX25hbWVfZmllbGQoKQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQoyMi4zNCgwLjAxKzAuMTIpIDIxLjE0KDAuMDMrMC4wMSkgLTUuNCUNCg0KcDAw
MDItcmVhZC1jYWNoZS5zaCB3LzEsMDAwLDAwMCBmaWxlcw0KQmFzZWxpbmUgICAgICAgICAgZXhw
YW5kX25hbWVfZmllbGQoKQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCjMwNi40NCgwLjA0KzAuMDcpIDI5NS40MigwLjAxKzAuMDcpIC0zLjYlDQoNClN1Z2dlc3Rl
ZCBieTogTmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8cGNsb3Vkc0BnbWFpbC5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBCZW4gUGVhcnQgPEJlbi5QZWFydEBtaWNyb3NvZnQuY29tPg0KLS0tDQogcmVh
ZC1jYWNoZS5jIHwgNSArKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9yZWFkLWNhY2hlLmMgYi9yZWFkLWNhY2hlLmMN
CmluZGV4IDdiMTM1NGQ3NTkuLjM4MmNjMTZiZGMgMTAwNjQ0DQotLS0gYS9yZWFkLWNhY2hlLmMN
CisrKyBiL3JlYWQtY2FjaGUuYw0KQEAgLTE3NTQsOSArMTc1NCw4IEBAIHN0YXRpYyB1bnNpZ25l
ZCBsb25nIGV4cGFuZF9uYW1lX2ZpZWxkKHN0cnVjdCBzdHJidWYgKm5hbWUsIGNvbnN0IGNoYXIg
KmNwXykNCiANCiAJaWYgKG5hbWUtPmxlbiA8IGxlbikNCiAJCWRpZSgibWFsZm9ybWVkIG5hbWUg
ZmllbGQgaW4gdGhlIGluZGV4Iik7DQotCXN0cmJ1Zl9yZW1vdmUobmFtZSwgbmFtZS0+bGVuIC0g
bGVuLCBsZW4pOw0KLQlmb3IgKGVwID0gY3A7ICplcDsgZXArKykNCi0JCTsgLyogZmluZCB0aGUg
ZW5kICovDQorCXN0cmJ1Zl9zZXRsZW4obmFtZSwgbmFtZS0+bGVuIC0gbGVuKTsNCisJZXAgPSBj
cCArIHN0cmxlbigoY29uc3QgY2hhciAqKWNwKTsNCiAJc3RyYnVmX2FkZChuYW1lLCBjcCwgZXAg
LSBjcCk7DQogCXJldHVybiAoY29uc3QgY2hhciAqKWVwICsgMSAtIGNwXzsNCiB9DQotLSANCjIu
MTguMC53aW5kb3dzLjENCg0K
