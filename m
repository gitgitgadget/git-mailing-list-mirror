Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A2B1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 15:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeH2TXH (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 15:23:07 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:6275
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728930AbeH2TXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 15:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aEumj0Lkuhn+TMqVdR3td5sQnIgrfk/AC0YJpa85Zw=;
 b=Gr/eY5zUnAG2MiKgHdjIUskbMo6zwEUBb7mPRlk/oww/7pxq3P5pHWziWhfZe2JbqXNgk70htBU9s4xkFfD0ppZL9GmYzQlM4XZz91iqIaifILzzDzATW39ohlFJ9UZDaisXizCcFvmybVUflgItlhHIh6445kLO8Su3so5zsUU=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1036.namprd21.prod.outlook.com (52.132.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Wed, 29 Aug 2018 15:25:21 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::bdbe:f40c:90b7:b4cf%3]) with mapi id 15.20.1122.000; Wed, 29 Aug 2018
 15:25:21 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v2 3/3] read-cache: micro-optimize expand_name_field() to
 speed up V4 index parsing.
Thread-Topic: [PATCH v2 3/3] read-cache: micro-optimize expand_name_field() to
 speed up V4 index parsing.
Thread-Index: AQHUP6yAkR3qs7QfYkaICd+4vXzFzg==
Date:   Wed, 29 Aug 2018 15:25:21 +0000
Message-ID: <20180829152500.46640-4-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180829152500.46640-1-benpeart@microsoft.com>
In-Reply-To: <20180829152500.46640-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: BN6PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:405:70::11) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;6:vi1mzP8NkmGnuzYvzszQ4dTurWLZD04L+9/5s/BC1H50VCLAKEh/zj239JcVwoICNKyUg5GnU3iT9RHqHOnW1vXbkks7zV4jdQZHQDOe34iXAMjrc469JQQmFBSlNxy/9HPrQsV3I8VBzr8k30B2N4RKsbybdG9YGNMaTLCZ92jCz7BmH+RW4f2aJvyaequeBk3imd8JjulnObMjWeyVCvcuXrgxoTg0nuGVYkKT0YT5KlNOAuyGHB4eav0onBD/lSCsgqUKdk7fzAnIr83pYhKrKbakRu9cK9Lb5w4jDTPelA2Zhl2cPtsHvjHzZT8WJRgfN95PYJP8ymzrcJVu8I4XX4SFDAmNjDFGvkNJlFdHa3gSan02HVAdAvBKMRwBQ6OCl+2RPsx9bgMOGQJORns6tKEHwyHrhNG20z1hExWHJIDp/QDFFhPik/wcKCSHT3H2zfR1s3Qia5Z2CzSyHA==;5:x+s8XE6rcknccOLL5V0RekhfsSAVALzgSH/7OkfVn17jnOgKelt8jHyhfV5qg1KpROHVtzdTkZb8YuCdg1YuoV0Fjbbpvru44JFco0yfR1m0aQGt60mQWiENDi8s4bZnIA5p7/Y6iraIa7Y/5G/HjHSQRBDYgOyyWGyf2q21u7c=;7:R0Hg4jUrZtNwsNIrsZeeG5/q8B4f2Dg6VgTS8xNfvgH/Y2OD5eBU3JQNjdTXQTe5IW2rKDC/hm+OnphJ308RGm2aHVVgUYDcOJc9p69BecQyjFx2jHHz8uh4N5xrlOzZQLWIbScHx4m/kLDVcWK+DB+AvEx9QEpluXCco+YC8GU+YFiA3r7Qc6sNpXwXcgRBZccxV7O1oDPwV8GtnOdITShokxEB0nO6eOhuUJlP/0vSq9NqpK93a7/6tMipi8Zo
x-ms-office365-filtering-correlation-id: cd2f52a9-d2d2-40bf-391a-08d60dc3a259
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
x-microsoft-antispam-prvs: <MW2PR2101MB10366C7C966B626E53B5EDD2F4090@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(6486002)(8936002)(36756003)(25786009)(50226002)(2501003)(446003)(5250100002)(97736004)(486006)(561924002)(72206003)(68736007)(10290500003)(11346002)(6916009)(476003)(5660300001)(2616005)(478600001)(107886003)(39060400002)(2351001)(4326008)(2900100001)(106356001)(105586002)(14454004)(86612001)(2906002)(1076002)(386003)(10090500001)(54906003)(99286004)(6512007)(5640700003)(6346003)(6506007)(53936002)(76176011)(305945005)(66066001)(8676002)(52116002)(6116002)(186003)(7736002)(102836004)(81156014)(26005)(14444005)(81166006)(256004)(316002)(6436002)(1730700003)(22452003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: 8f0MO3g8MirEg2JrnOEoS8H87yDT4VyjO0xDrHTd3HtI+zdo+Wz+SbpmHKcRGEJHmGT2sB+SOaiMsKKtnGzIHUWgz9nazFhOG3qVQmSsZ99YuZE5WlV9iO08sYsmBlG7YoMVoWVTUZEnGVQ4p5jk3b+uZsL98rszIyw4hdb4K/UYv+k1iIKuJmO97BxoJpgQ0SdszcnDY7qxcoxHGcQbnsWy3CqAMYI2n91eiWmu68lWdN+oPWohPBcGCFbqKtP9sueBbuF1BOknYrc9XEOsUE+VJCDs+/BWyA25h1m0sALNrZM6n/p/q+/f6QBEPi4d2leMtVjWRHUsLdAhlsWW6rtPAWcbhvyLqFMxvL3Ogcs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D5F6E63BE234648BD57074C181F2AF2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2f52a9-d2d2-40bf-391a-08d60dc3a259
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 15:25:21.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

IC0gc3RyYnVmX3JlbW92ZSgpIGluIGV4cGFuZF9uYW1lX2ZpZWxkKCkgaXMgbm90IGV4YWN0bHkg
YSBnb29kIGZpdA0KICAgZm9yIHN0cmlwcGluZyBhIHBhcnQgYXQgdGhlIGVuZCwgX3NldGxlbigp
IHdvdWxkIGRvIHRoZSBzYW1lIGpvYg0KICAgYW5kIGlzIG11Y2ggY2hlYXBlci4NCg0KIC0gdGhl
IG9wZW4tY29kZWQgbG9vcCB0byBmaW5kIHRoZSBlbmQgb2YgdGhlIHN0cmluZyBpbg0KICAgZXhw
YW5kX25hbWVfZmllbGQoKSBjYW4ndCBiZWF0IGFuIG9wdGltaXplZCBzdHJsZW4oKQ0KDQpJIHVz
ZWQgcDAwMDItcmVhZC1jYWNoZS5zaCB0byBnZW5lcmF0ZSBzb21lIHBlcmZvcm1hbmNlIGRhdGEg
b24gdGhlDQpjdW11bGF0aXZlIGltcGFjdDoNCg0KMTAwLDAwMCBmaWxlcw0KDQpUZXN0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBIRUFEfjMgICAgICAgICAgIEhFQUQNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KcmVhZF9jYWNoZS9kaXNjYXJkX2NhY2hlIDEwMDAgdGltZXMgMTQuMDgoMC4w
MyswLjA5KSA4LjcxKDAuMDErMC4wOSkgLTM4LjElDQoNCjEsMDAwLDAwMCBmaWxlcw0KDQpUZXN0
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIRUFEfjMgICAgICAgICAgICBIRUFEDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCnJlYWRfY2FjaGUvZGlzY2FyZF9jYWNoZSAxMDAwIHRpbWVz
IDIwMS43NygwLjAzKzAuMDcpIDE0OS42OCgwLjA0KzAuMDcpIC0yNS44JQ0KDQpTdWdnZXN0ZWQg
Ynk6IE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgPHBjbG91ZHNAZ21haWwuY29tPg0KU2lnbmVk
LW9mZi1ieTogQmVuIFBlYXJ0IDxCZW4uUGVhcnRAbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIHJlYWQt
Y2FjaGUuYyB8IDUgKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvcmVhZC1jYWNoZS5jIGIvcmVhZC1jYWNoZS5jDQpp
bmRleCBmNzY4MDA0NjE3Li5mNWU3Yzg2YzQyIDEwMDY0NA0KLS0tIGEvcmVhZC1jYWNoZS5jDQor
KysgYi9yZWFkLWNhY2hlLmMNCkBAIC0xNzU0LDkgKzE3NTQsOCBAQCBzdGF0aWMgdW5zaWduZWQg
bG9uZyBleHBhbmRfbmFtZV9maWVsZChzdHJ1Y3Qgc3RyYnVmICpuYW1lLCBjb25zdCBjaGFyICpj
cF8pDQogDQogCWlmIChuYW1lLT5sZW4gPCBsZW4pDQogCQlkaWUoIm1hbGZvcm1lZCBuYW1lIGZp
ZWxkIGluIHRoZSBpbmRleCIpOw0KLQlzdHJidWZfcmVtb3ZlKG5hbWUsIG5hbWUtPmxlbiAtIGxl
biwgbGVuKTsNCi0JZm9yIChlcCA9IGNwOyAqZXA7IGVwKyspDQotCQk7IC8qIGZpbmQgdGhlIGVu
ZCAqLw0KKwlzdHJidWZfc2V0bGVuKG5hbWUsIG5hbWUtPmxlbiAtIGxlbik7DQorCWVwID0gY3Ag
KyBzdHJsZW4oKGNvbnN0IGNoYXIgKiljcCk7DQogCXN0cmJ1Zl9hZGQobmFtZSwgY3AsIGVwIC0g
Y3ApOw0KIAlyZXR1cm4gKGNvbnN0IGNoYXIgKillcCArIDEgLSBjcF87DQogfQ0KLS0gDQoyLjE4
LjAud2luZG93cy4xDQoNCg==
