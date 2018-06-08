Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F841F403
	for <e@80x24.org>; Fri,  8 Jun 2018 13:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeFHN4w (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 09:56:52 -0400
Received: from mail-eopbgr730133.outbound.protection.outlook.com ([40.107.73.133]:45030
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752349AbeFHN4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 09:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It2+tjYoG+Qu4bMopBBNXRoT9k7PLISf0hw/RTVd1gM=;
 b=HwNAg5aTTXU3vZtMQeXfh8Q0Dt+H0lm8qMKOVT1GDqJtFXZ/O4Vny4EbBJy9GH2tQ75WJfXK6ih0Zi6lvb1bTfqSreOJQAGfzXplI2zmRWMq2od/cy07qxStRHprEvOw6WM9gjfSe7nGpk7H7wMhYwiuHEFHSip+bSEmnjdnzA8=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1121.namprd21.prod.outlook.com (52.132.18.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Fri, 8 Jun 2018 13:56:30 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::d1f2:1d69:2567:e0a9%2]) with mapi id 15.20.0863.004; Fri, 8 Jun 2018
 13:56:30 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v6 20/21] gc: automatically write commit-graph files
Thread-Topic: [PATCH v6 20/21] gc: automatically write commit-graph files
Thread-Index: AQHT/zB/JU5mhHCiNky1rQOoSYfEQg==
Date:   Fri, 8 Jun 2018 13:56:29 +0000
Message-ID: <20180608135548.216405-21-dstolee@microsoft.com>
References: <20180606113611.87822-1-dstolee@microsoft.com>
 <20180608135548.216405-1-dstolee@microsoft.com>
In-Reply-To: <20180608135548.216405-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:404:f7::33) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1121;7:qzNrw+7vlKwJXFHdpPemVDZ9oJsFNwbeZ1NzUuE9XfwjWQzaLSvAvdlJriUyqkPdwGTWlTR7ZtRRl/QdilJ7/EWZ2z0AMI2TA3gRPcS5fRN0b8EgdQsuchqQqLNpJL2PlHDiFAAc3aBfiR9hfYnX2/MgQK7UvQKDVpdRIQmmukHsd2PNQ7+KvY7VsP8NBgOohy5pfbMKjkHe/afx0zVadG0+KVRb9tcrg9zQyyunaP8a1Hjk62jy2QJcv79yDZHX
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1121;
x-ms-traffictypediagnostic: BL0PR2101MB1121:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1121DBAB7CF645FBCC057C1EA17B0@BL0PR2101MB1121.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1121;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1121;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39380400002)(39860400002)(189003)(199004)(2900100001)(1076002)(4326008)(2906002)(86362001)(6116002)(1730700003)(8936002)(14454004)(25786009)(3660700001)(105586002)(6506007)(386003)(59450400001)(10090500001)(478600001)(107886003)(6512007)(68736007)(86612001)(76176011)(305945005)(8676002)(81156014)(39060400002)(3280700002)(53936002)(186003)(46003)(6916009)(6486002)(446003)(5250100002)(11346002)(6436002)(5640700003)(2501003)(99286004)(8656006)(316002)(22452003)(106356001)(54906003)(102836004)(36756003)(2351001)(5660300001)(7736002)(97736004)(10290500003)(81166006)(52116002)(476003)(486006)(2616005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1121;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m0v2DLMp+UE1dX+GqcRSswUj6kWrCrcYprTBVYcfzP9qE5PTK9PtHMj+S/VhLfOCoSeuGQeOJTpBBIc/n27vsoHA6v7w6/WWalrQJqXKGYOcsS+3Cz8aJ9lgbsDkt8eJr4AIsAEvyT92ueNLthT51qW7Ekh51NY5PYUS9gTE0z7nmBciawLnyGGj0fQN+a3F
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <07F2E4287F4C03468523BF5F22F44F1C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 41b59105-907b-4096-0316-08d5cd47a264
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b59105-907b-4096-0316-08d5cd47a264
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 13:56:29.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1121
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhlIGNvbW1pdC1ncmFwaCBmaWxlIGlzIGEgdmVyeSBoZWxwZnVsIGZlYXR1cmUgZm9yIHNwZWVk
aW5nIHVwIGdpdA0Kb3BlcmF0aW9ucy4gSW4gb3JkZXIgdG8gbWFrZSBpdCBtb3JlIHVzZWZ1bCwg
bWFrZSBpdCBwb3NzaWJsZSB0bw0Kd3JpdGUgdGhlIGNvbW1pdC1ncmFwaCBmaWxlIGR1cmluZyBz
dGFuZGFyZCBnYXJiYWdlIGNvbGxlY3Rpb24NCm9wZXJhdGlvbnMuDQoNCkFkZCBhICdnYy5jb21t
aXRHcmFwaCcgY29uZmlnIHNldHRpbmcgdGhhdCB0cmlnZ2VycyB3cml0aW5nIGENCmNvbW1pdC1n
cmFwaCBmaWxlIGFmdGVyIGFueSBub24tdHJpdmlhbCAnZ2l0IGdjJyBjb21tYW5kLiBEZWZhdWx0
cyB0bw0KZmFsc2Ugd2hpbGUgdGhlIGNvbW1pdC1ncmFwaCBmZWF0dXJlIG1hdHVyZXMuIFdlIHNw
ZWNpZmljYWxseSBkbyBub3QNCndhbnQgdG8gaGF2ZSB0aGlzIG9uIGJ5IGRlZmF1bHQgdW50aWwg
dGhlIGNvbW1pdC1ncmFwaCBmZWF0dXJlIGlzIGZ1bGx5DQppbnRlZ3JhdGVkIHdpdGggaGlzdG9y
eS1tb2RpZnlpbmcgZmVhdHVyZXMgbGlrZSBzaGFsbG93IGNsb25lcy4NCg0KSGVscGVkLWJ5OiDD
hnZhciBBcm5masO2csOwIEJqYXJtYXNvbiA8YXZhcmFiQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IERlcnJpY2sgU3RvbGVlIDxkc3RvbGVlQG1pY3Jvc29mdC5jb20+DQotLS0NCiBEb2N1bWVu
dGF0aW9uL2NvbmZpZy50eHQgfCAxMCArKysrKysrKystDQogRG9jdW1lbnRhdGlvbi9naXQtZ2Mu
dHh0IHwgIDQgKysrKw0KIGJ1aWx0aW4vZ2MuYyAgICAgICAgICAgICB8ICA2ICsrKysrKw0KIHQv
dDUzMTgtY29tbWl0LWdyYXBoLnNoICB8IDE0ICsrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFu
Z2VkLCAzMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2NvbmZpZy50eHQgYi9Eb2N1bWVudGF0aW9uL2NvbmZpZy50eHQNCmluZGV4IGFi
NjQxYmY1YTkuLmYyYjVlZDE3YzggMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2NvbmZpZy50
eHQNCisrKyBiL0RvY3VtZW50YXRpb24vY29uZmlnLnR4dA0KQEAgLTkwNiw3ICs5MDYsOCBAQCB0
aGUgYEdJVF9OT1RFU19SRUZgIGVudmlyb25tZW50IHZhcmlhYmxlLiAgU2VlIGxpbmtnaXQ6Z2l0
LW5vdGVzWzFdLg0KIA0KIGNvcmUuY29tbWl0R3JhcGg6Og0KIAlFbmFibGUgZ2l0IGNvbW1pdCBn
cmFwaCBmZWF0dXJlLiBBbGxvd3MgcmVhZGluZyBmcm9tIHRoZQ0KLQljb21taXQtZ3JhcGggZmls
ZS4NCisJY29tbWl0LWdyYXBoIGZpbGUuIFNlZSBgZ2MuY29tbWl0R3JhcGhgIGZvciBhdXRvbWF0
aWNhbGx5DQorCW1haW50YWluaW5nIHRoZSBmaWxlLg0KIA0KIGNvcmUuc3BhcnNlQ2hlY2tvdXQ6
Og0KIAlFbmFibGUgInNwYXJzZSBjaGVja291dCIgZmVhdHVyZS4gU2VlIHNlY3Rpb24gIlNwYXJz
ZSBjaGVja291dCIgaW4NCkBAIC0xNjQ3LDYgKzE2NDgsMTMgQEAgdGhpcyBjb25maWd1cmF0aW9u
IHZhcmlhYmxlIGlzIGlnbm9yZWQsIGFsbCBwYWNrcyBleGNlcHQgdGhlIGJhc2UgcGFjaw0KIHdp
bGwgYmUgcmVwYWNrZWQuIEFmdGVyIHRoaXMgdGhlIG51bWJlciBvZiBwYWNrcyBzaG91bGQgZ28g
YmVsb3cNCiBnYy5hdXRvUGFja0xpbWl0IGFuZCBnYy5iaWdQYWNrVGhyZXNob2xkIHNob3VsZCBi
ZSByZXNwZWN0ZWQgYWdhaW4uDQogDQorZ2MuY29tbWl0R3JhcGg6Og0KKwlJZiB0cnVlLCB0aGVu
IGdjIHdpbGwgcmV3cml0ZSB0aGUgY29tbWl0LWdyYXBoIGZpbGUgd2hlbg0KKwlsaW5rZ2l0Omdp
dC1nY1sxXSBpcyBydW4uIFdoZW4gdXNpbmcgbGlua2dpdDpnaXQtZ2NbMV0NCisJJy0tYXV0bycg
dGhlIGNvbW1pdC1ncmFwaCB3aWxsIGJlIHVwZGF0ZWQgaWYgaG91c2VrZWVwaW5nIGlzDQorCXJl
cXVpcmVkLiBEZWZhdWx0IGlzIGZhbHNlLiBTZWUgbGlua2dpdDpnaXQtY29tbWl0LWdyYXBoWzFd
DQorCWZvciBkZXRhaWxzLg0KKw0KIGdjLmxvZ0V4cGlyeTo6DQogCUlmIHRoZSBmaWxlIGdjLmxv
ZyBleGlzdHMsIHRoZW4gYGdpdCBnYyAtLWF1dG9gIHdvbid0IHJ1bg0KIAl1bmxlc3MgdGhhdCBm
aWxlIGlzIG1vcmUgdGhhbiAnZ2MubG9nRXhwaXJ5JyBvbGQuICBEZWZhdWx0IGlzDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9naXQtZ2MudHh0IGIvRG9jdW1lbnRhdGlvbi9naXQtZ2MudHh0
DQppbmRleCAyNGIyZGQ0NGZlLi5mNWJjOThjY2IzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlv
bi9naXQtZ2MudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2dpdC1nYy50eHQNCkBAIC0xMzYsNiAr
MTM2LDEwIEBAIFRoZSBvcHRpb25hbCBjb25maWd1cmF0aW9uIHZhcmlhYmxlIGBnYy5wYWNrUmVm
c2AgZGV0ZXJtaW5lcyBpZg0KIGl0IHdpdGhpbiBhbGwgbm9uLWJhcmUgcmVwb3Mgb3IgaXQgY2Fu
IGJlIHNldCB0byBhIGJvb2xlYW4gdmFsdWUuDQogVGhpcyBkZWZhdWx0cyB0byB0cnVlLg0KIA0K
K1RoZSBvcHRpb25hbCBjb25maWd1cmF0aW9uIHZhcmlhYmxlIGBnYy5jb21taXRHcmFwaGAgZGV0
ZXJtaW5lcyBpZg0KKydnaXQgZ2MnIHNob3VsZCBydW4gJ2dpdCBjb21taXQtZ3JhcGggd3JpdGUn
LiBUaGlzIGNhbiBiZSBzZXQgdG8gYQ0KK2Jvb2xlYW4gdmFsdWUuIFRoaXMgZGVmYXVsdHMgdG8g
ZmFsc2UuDQorDQogVGhlIG9wdGlvbmFsIGNvbmZpZ3VyYXRpb24gdmFyaWFibGUgYGdjLmFnZ3Jl
c3NpdmVXaW5kb3dgIGNvbnRyb2xzIGhvdw0KIG11Y2ggdGltZSBpcyBzcGVudCBvcHRpbWl6aW5n
IHRoZSBkZWx0YSBjb21wcmVzc2lvbiBvZiB0aGUgb2JqZWN0cyBpbg0KIHRoZSByZXBvc2l0b3J5
IHdoZW4gdGhlIC0tYWdncmVzc2l2ZSBvcHRpb24gaXMgc3BlY2lmaWVkLiAgVGhlIGxhcmdlcg0K
ZGlmZiAtLWdpdCBhL2J1aWx0aW4vZ2MuYyBiL2J1aWx0aW4vZ2MuYw0KaW5kZXggY2NmYjFjZWFl
Yi4uNGUwNmU4MzcyZCAxMDA2NDQNCi0tLSBhL2J1aWx0aW4vZ2MuYw0KKysrIGIvYnVpbHRpbi9n
Yy5jDQpAQCAtMjAsNiArMjAsNyBAQA0KICNpbmNsdWRlICJzaWdjaGFpbi5oIg0KICNpbmNsdWRl
ICJhcmd2LWFycmF5LmgiDQogI2luY2x1ZGUgImNvbW1pdC5oIg0KKyNpbmNsdWRlICJjb21taXQt
Z3JhcGguaCINCiAjaW5jbHVkZSAicGFja2ZpbGUuaCINCiAjaW5jbHVkZSAib2JqZWN0LXN0b3Jl
LmgiDQogI2luY2x1ZGUgInBhY2suaCINCkBAIC00MCw2ICs0MSw3IEBAIHN0YXRpYyBpbnQgYWdn
cmVzc2l2ZV9kZXB0aCA9IDUwOw0KIHN0YXRpYyBpbnQgYWdncmVzc2l2ZV93aW5kb3cgPSAyNTA7
DQogc3RhdGljIGludCBnY19hdXRvX3RocmVzaG9sZCA9IDY3MDA7DQogc3RhdGljIGludCBnY19h
dXRvX3BhY2tfbGltaXQgPSA1MDsNCitzdGF0aWMgaW50IGdjX2NvbW1pdF9ncmFwaCA9IDA7DQog
c3RhdGljIGludCBkZXRhY2hfYXV0byA9IDE7DQogc3RhdGljIHRpbWVzdGFtcF90IGdjX2xvZ19l
eHBpcmVfdGltZTsNCiBzdGF0aWMgY29uc3QgY2hhciAqZ2NfbG9nX2V4cGlyZSA9ICIxLmRheS5h
Z28iOw0KQEAgLTEyOSw2ICsxMzEsNyBAQCBzdGF0aWMgdm9pZCBnY19jb25maWcodm9pZCkNCiAJ
Z2l0X2NvbmZpZ19nZXRfaW50KCJnYy5hZ2dyZXNzaXZlZGVwdGgiLCAmYWdncmVzc2l2ZV9kZXB0
aCk7DQogCWdpdF9jb25maWdfZ2V0X2ludCgiZ2MuYXV0byIsICZnY19hdXRvX3RocmVzaG9sZCk7
DQogCWdpdF9jb25maWdfZ2V0X2ludCgiZ2MuYXV0b3BhY2tsaW1pdCIsICZnY19hdXRvX3BhY2tf
bGltaXQpOw0KKwlnaXRfY29uZmlnX2dldF9ib29sKCJnYy5jb21taXRncmFwaCIsICZnY19jb21t
aXRfZ3JhcGgpOw0KIAlnaXRfY29uZmlnX2dldF9ib29sKCJnYy5hdXRvZGV0YWNoIiwgJmRldGFj
aF9hdXRvKTsNCiAJZ2l0X2NvbmZpZ19nZXRfZXhwaXJ5KCJnYy5wcnVuZWV4cGlyZSIsICZwcnVu
ZV9leHBpcmUpOw0KIAlnaXRfY29uZmlnX2dldF9leHBpcnkoImdjLndvcmt0cmVlcHJ1bmVleHBp
cmUiLCAmcHJ1bmVfd29ya3RyZWVzX2V4cGlyZSk7DQpAQCAtNjQxLDYgKzY0NCw5IEBAIGludCBj
bWRfZ2MoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpwcmVmaXgpDQog
CWlmIChwYWNrX2dhcmJhZ2UubnIgPiAwKQ0KIAkJY2xlYW5fcGFja19nYXJiYWdlKCk7DQogDQor
CWlmIChnY19jb21taXRfZ3JhcGgpDQorCQl3cml0ZV9jb21taXRfZ3JhcGhfcmVhY2hhYmxlKGdl
dF9vYmplY3RfZGlyZWN0b3J5KCksIDApOw0KKw0KIAlpZiAoYXV0b19nYyAmJiB0b29fbWFueV9s
b29zZV9vYmplY3RzKCkpDQogCQl3YXJuaW5nKF8oIlRoZXJlIGFyZSB0b28gbWFueSB1bnJlYWNo
YWJsZSBsb29zZSBvYmplY3RzOyAiDQogCQkJInJ1biAnZ2l0IHBydW5lJyB0byByZW1vdmUgdGhl
bS4iKSk7DQpkaWZmIC0tZ2l0IGEvdC90NTMxOC1jb21taXQtZ3JhcGguc2ggYi90L3Q1MzE4LWNv
bW1pdC1ncmFwaC5zaA0KaW5kZXggMDZlY2JiM2Y0YS4uOWEwNjYxOTgzYyAxMDA3NTUNCi0tLSBh
L3QvdDUzMTgtY29tbWl0LWdyYXBoLnNoDQorKysgYi90L3Q1MzE4LWNvbW1pdC1ncmFwaC5zaA0K
QEAgLTI0NSw2ICsyNDUsMjAgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyAncGVyZm9ybSBmYXN0LWZv
cndhcmQgbWVyZ2UgaW4gZnVsbCByZXBvJyAnDQogCXRlc3RfY21wIGV4cGVjdCBvdXRwdXQNCiAn
DQogDQordGVzdF9leHBlY3Rfc3VjY2VzcyAnY2hlY2sgdGhhdCBnYyBjb21wdXRlcyBjb21taXQt
Z3JhcGgnICcNCisJY2QgIiRUUkFTSF9ESVJFQ1RPUlkvZnVsbCIgJiYNCisJZ2l0IGNvbW1pdCAt
LWFsbG93LWVtcHR5IC1tICJibGFuayIgJiYNCisJZ2l0IGNvbW1pdC1ncmFwaCB3cml0ZSAtLXJl
YWNoYWJsZSAmJg0KKwljcCAkb2JqZGlyL2luZm8vY29tbWl0LWdyYXBoIGNvbW1pdC1ncmFwaC1i
ZWZvcmUtZ2MgJiYNCisJZ2l0IHJlc2V0IC0taGFyZCBIRUFEfjEgJiYNCisJZ2l0IGNvbmZpZyBn
Yy5jb21taXRHcmFwaCB0cnVlICYmDQorCWdpdCBnYyAmJg0KKwljcCAkb2JqZGlyL2luZm8vY29t
bWl0LWdyYXBoIGNvbW1pdC1ncmFwaC1hZnRlci1nYyAmJg0KKwkhIHRlc3RfY21wIGNvbW1pdC1n
cmFwaC1iZWZvcmUtZ2MgY29tbWl0LWdyYXBoLWFmdGVyLWdjICYmDQorCWdpdCBjb21taXQtZ3Jh
cGggd3JpdGUgLS1yZWFjaGFibGUgJiYNCisJdGVzdF9jbXAgY29tbWl0LWdyYXBoLWFmdGVyLWdj
ICRvYmpkaXIvaW5mby9jb21taXQtZ3JhcGgNCisnDQorDQogIyB0aGUgdmVyaWZ5IHRlc3RzIGJl
bG93IGV4cGVjdCB0aGUgY29tbWl0LWdyYXBoIHRvIGNvbnRhaW4NCiAjIGV4YWN0bHkgdGhlIGNv
bW1pdHMgcmVhY2hhYmxlIGZyb20gdGhlIGNvbW1pdHMvOCBicmFuY2guDQogIyBJZiB0aGUgZmls
ZSBjaGFuZ2VzIHRoZSBzZXQgb2YgY29tbWl0cyBpbiB0aGUgbGlzdCwgdGhlbiB0aGUNCi0tIA0K
Mi4xOC4wLnJjMQ0KDQo=
