Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83A6E1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbeIGBlM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:41:12 -0400
Received: from mail-eopbgr720129.outbound.protection.outlook.com ([40.107.72.129]:59840
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729281AbeIGBlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJKScN529+c8IlmCp2dAYGhvU1VsZbkczKRVcM/bP1w=;
 b=QPnmO/lzXtD158f9ZSnO/XTYYik+ToVYnJaWUCnG0oX+faPGyaaHl5w0d05U8O6cuIKUTBSFGhGcDquJQShmtJacgDxcJRADZchmyEyc5wsv30wD2R0UL6YmaHJ4LaZ02jZ59+IFJHsH4jS5Gzc8B3E5mFOQ0DXOp9OmgAiuUPw=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0908.namprd21.prod.outlook.com (52.132.152.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Thu, 6 Sep 2018 21:03:53 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::d41c:2bea:5b2d:a858%4]) with mapi id 15.20.1143.008; Thu, 6 Sep 2018
 21:03:53 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 0/4] read-cache: speed up index load through
 parallelization
Thread-Topic: [PATCH v3 0/4] read-cache: speed up index load through
 parallelization
Thread-Index: AQHURiUeuqYsZcpx30WX9+14gyVQOA==
Date:   Thu, 6 Sep 2018 21:03:53 +0000
Message-ID: <20180906210227.54368-1-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
In-Reply-To: <20180823154053.20212-1-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0908;6:foDfm1/4Mc+6pjkfVi3Mw4FB1o4C/DZ5JcZhK0ZWiGKt0KirtISaf4RsY+2hTM13u4FR3Rh/p8V/ma9j6V2CKVot23C520ssfdPU+h+CYh+mP6C/79lRMSnpFkAoPJUmSiPujjScRORl8l4FCD1lq3PdLja5fMId8G12+mWklKv3kwz/8yUepXWkai6RlYy2BMHjPIeYAtiGdxQH/nxSyDRtH+0XVauvgLjta3w9wHF4zqxJEN1pR2DqifXdi2Hq4G6DHksN+Fu9nEE0kq/2PsHYPIJc4QYn3mJHuAEXgU2cPP67EZJPk3EAXNhxe1qsYM7O6aT5qgEXsX7A5j9cIhUTsxytE3ElZD6EZ5qFcONMdjns+qINDqzSvTn8nLcEWHbe+S2aGbauv7gXqCvM/a4pa8UM4/8FvrrdCI2uyi2dcwjCQ8wzsLllVJfzw5eC0HKc5dCAkTEcYZx70er+EQ==;5:MZl/JAaiVCBu3EO4tTslK4rKWFg74jMddRqBSpV2tfxPWYtMNuuCKcrRO/wXX/pc7AgeUkTKeRjtXBqA3CdWZPPyTjc06Gyde3zwXbs83rCw9uroYaLqqtslQltL8mEtlLm49FXhvEYJs48VEkUZABVUgdsmfjVnTNR+ak4IttQ=;7:F6G62kcg4Pvl/l1CzOzxn03RlekiKZCrAEwGeiHqa0dpHPgzrt3lJLDWLn0IaZPJGenFTJGTMWSNbx/d09TCLHbxHZwX0DZ2tevmLtrR616Ec+bdoVTCbkcsIu1SfzZPW8a189G257smjws+R/i+JVER1vlOzE3S71zywK0JYKZf9XLlQsj0z3GPcRcsdA5/w3/W5xHF7mCrPWdoOShbxg0Q6F2NqZbobcIwrHc0vRvjt4t1wRF6Nb96mWOuOoaB
x-ms-office365-filtering-correlation-id: b7cbb417-8d9b-45cd-1ece-08d6143c4011
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0908;
x-ms-traffictypediagnostic: MW2PR2101MB0908:
x-microsoft-antispam-prvs: <MW2PR2101MB0908CF282F0CADFAD344747DF4010@MW2PR2101MB0908.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(166708455590820)(211936372134217);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:MW2PR2101MB0908;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0908;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(68736007)(316002)(25786009)(72206003)(50226002)(97736004)(10290500003)(478600001)(14454004)(966005)(256004)(5640700003)(6306002)(99286004)(53936002)(486006)(52116002)(6486002)(54906003)(1076002)(8676002)(14444005)(76176011)(22452003)(305945005)(7736002)(5660300001)(6916009)(6512007)(26005)(6346003)(106356001)(575784001)(105586002)(86612001)(2616005)(6436002)(2351001)(102836004)(3846002)(6116002)(446003)(11346002)(186003)(10090500001)(476003)(36756003)(2906002)(81156014)(1730700003)(81166006)(66066001)(2900100001)(8936002)(386003)(561924002)(2501003)(5250100002)(107886003)(4326008)(6506007)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0908;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: fbBZjMQUS9WJ3SZDCE6fIp6mMl/r+FnQq2QwlJnWo9VmZyJ5PTI5GljAS1+We5rqFVNbkkLGa0ISQfAcGq5dwIaAEV7sWnnBfXzZ/6H+NnRd3MPBBwxodtfBFDJ3jrI7eQoSqJe0GyhuZdWz7/lT550Pp9ydbkWhH+JIu8ISUPa3xOhY1bDoA8Dk1KDi9fb9XQM2aZqDEZND4ji8k42ORkzsBH7FTNlngevitGRykZl3bYbnd2JSC30BwfIfjzrs7F8puhyv6VUftdtLb/2CcA1ziIhglIWUkX7mZcclAccvDNWEm4mpXtcw9NbVPS2oIloJopDZRq0zmijff191hcZ/GPIyulvT+5J23A4/0ZI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B8E2F74EB58CC44BDE55EC93C3955E5@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cbb417-8d9b-45cd-1ece-08d6143c4011
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 21:03:53.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0908
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gZnVydGhlciBpbnZlc3RpZ2F0aW9uIHdpdGggdGhlIHByZXZpb3VzIHBhdGNoLCBJIG5vdGlj
ZWQgdGhhdCBteSB0ZXN0DQpyZXBvcyBkaWRuJ3QgY29udGFpbiB0aGUgY2FjaGUgdHJlZSBleHRl
bnNpb24gaW4gdGhlaXIgaW5kZXguIEFmdGVyIGRvaW5nIGENCmNvbW1pdCB0byBlbnN1cmUgdGhl
eSBleGlzdGVkLCBJIHJlYWxpemVkIHRoYXQgaW4gc29tZSBpbnN0YW5jZXMsIHRoZSB0aW1lDQp0
byBsb2FkIHRoZSBjYWNoZSB0cmVlIGV4Y2VlZGVkIHRoZSB0aW1lIHRvIGxvYWQgYWxsIHRoZSBj
YWNoZSBlbnRyaWVzIGluDQpwYXJhbGxlbC4gIEJlY2F1c2UgdGhlIHRocmVhZCB0byByZWFkIHRo
ZSBjYWNoZSB0cmVlIHdhcyBzdGFydGVkIGxhc3QgKGR1ZQ0KdG8gaGF2aW5nIHRvIHBhcnNlIHRo
cm91Z2ggYWxsIHRoZSBjYWNoZSBlbnRyaWVzIGZpcnN0KSB3ZSB3ZXJlbid0IGFsd2F5cw0KZ2V0
dGluZyBvcHRpbWFsIHBlcmZvcm1hbmNlLg0KDQpUbyBiZXR0ZXIgb3B0aW1pemUgZm9yIHRoaXMg
Y2FzZSwgSSBkZWNpZGVkIHRvIHdyaXRlIHRoZSBFT0lFIGV4dGVuc2lvbg0KYXMgc3VnZ2VzdGVk
IGJ5IEp1bmlvIFsxXSBpbiByZXNwb25zZSB0byBteSBlYXJsaWVyIG11bHRpdGhyZWFkaW5nIHBh
dGNoDQpzZXJpZXMgWzJdLiAgVGhpcyBlbmFibGVzIG1lIHRvIHNwaW4gdXAgdGhlIHRocmVhZCB0
byBsb2FkIHRoZSBleHRlbnNpb25zDQplYXJsaWVyIGFzIGl0IG5vIGxvbmdlciBoYXMgdG8gcGFy
c2UgdGhyb3VnaCBhbGwgdGhlIGNhY2hlIGVudHJpZXMgZmlyc3QuDQoNClRoZSBiaWcgY2hhbmdl
cyBpbiB0aGlzIGl0ZXJhdGlvbiBhcmU6DQoNCi0gYWRkIHRoZSBFT0lFIGV4dGVuc2lvbg0KLSB1
cGRhdGUgdGhlIGluZGV4IGV4dGVuc2lvbiB3b3JrZXIgdGhyZWFkIHRvIHN0YXJ0IGZpcnN0DQoN
ClRoZSBhYnNvbHV0ZSBwZXJmIG51bWJlcnMgZG9uJ3QgbG9vayBhcyBnb29kIGFzIHRoZSBwcmV2
aW91cyBpdGVyYXRpb24NCmJlY2F1c2Ugbm90IGxvYWRpbmcgdGhlIGNhY2hlIHRyZWUgYXQgYWxs
IGlzIGEgbG90IGZhc3RlciB0aGFuIGxvYWRpbmcgaXQgaW4NCnBhcmFsbGVsLiBUaGVzZSB3ZXJl
IG1lYXN1cmVkIHdpdGggYSBWNCBpbmRleCB0aGF0IGluY2x1ZGVkIGEgY2FjaGUgdHJlZQ0KZXh0
ZW5zaW9uLg0KDQpJIHVzZWQgcDAwMDItcmVhZC1jYWNoZS5zaCB0byBnZW5lcmF0ZSBzb21lIHBl
cmZvcm1hbmNlIGRhdGEgb24gaG93IHRoZSB0aHJlZQ0KcGVyZm9ybWFuY2UgcGF0Y2hlcyBoZWxw
Og0KDQpwMDAwMi1yZWFkLWNhY2hlLnNoIHcvMTAwLDAwMCBmaWxlcyAgICAgICAgICAgICAgICAg
ICAgICAgIA0KQmFzZWxpbmUgICAgICAgICBleHBhbmRfbmFtZV9maWVsZCgpICAgIFRocmVhZCBl
eHRlbnNpb25zICAgICAgIFRocmVhZCBlbnRyaWVzDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCjIyLjM0KDAuMDErMC4xMikgMjEuMTQoMC4wMyswLjAxKSAtNS40JSAyMC43MSgwLjAz
KzAuMDMpIC03LjMlCTEzLjkzKDAuMDQrMC4wNCkgLTM3LjYlDQoNCnAwMDAyLXJlYWQtY2FjaGUu
c2ggdy8xLDAwMCwwMDAgZmlsZXMgICAgICAgICAgICAgICAgICAgICAgICANCkJhc2VsaW5lICAg
ICAgICAgIGV4cGFuZF9uYW1lX2ZpZWxkKCkgICAgIFRocmVhZCBleHRlbnNpb25zICAgICAgICBU
aHJlYWQgZW50cmllcw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KMzA2LjQ0
KDAuMDQrMC4wNykgMjk1LjQyKDAuMDErMC4wNykgLTMuNiUgMjE3LjYwKDAuMDMrMC4wNCkgLTI5
LjAlIDE5OS4wMCgwLjAwKzAuMTApIC0zNS4xJQ0KDQpUaGlzIHBhdGNoIGNvbmZsaWN0cyB3aXRo
IER1eSdzIHBhdGNoIHRvIHJlbW92ZSB0aGUgZG91YmxlIG1lbW9yeSBjb3B5IGFuZA0KcGFzcyBp
biB0aGUgcHJldmlvdXMgY2UgaW5zdGVhZC4gIFRoZSB0d28gd2lsbCBuZWVkIHRvIGJlIG1lcmdl
ZC9yZWNvbmNpbGVkDQpvbmNlIHRoZXkgc2V0dGxlIGRvd24gYSBiaXQuDQoNClsxXSBodHRwczov
L3B1YmxpYy1pbmJveC5vcmcvZ2l0L3htcXExc2wwMTdkdy5mc2ZAZ2l0c3Rlci5tdHYuY29ycC5n
b29nbGUuY29tLw0KWzJdIGh0dHBzOi8vcHVibGljLWluYm94Lm9yZy9naXQvMjAxNzExMDkxNDE3
MzcuNDc5NzYtMS1iZW5wZWFydEBtaWNyb3NvZnQuY29tLw0KDQoNCkJhc2UgUmVmOiBtYXN0ZXIN
CldlYi1EaWZmOiBodHRwczovL2dpdGh1Yi5jb20vYmVucGVhcnQvZ2l0L2NvbW1pdC8zMjVlYzY5
Mjk5DQpDaGVja291dDogZ2l0IGZldGNoIGh0dHBzOi8vZ2l0aHViLmNvbS9iZW5wZWFydC9naXQg
cmVhZC1pbmRleC1tdWx0aXRocmVhZC12MyAmJiBnaXQgY2hlY2tvdXQgMzI1ZWM2OTI5OQ0KDQoN
CiMjIyBQYXRjaGVzDQoNCkJlbiBQZWFydCAoNCk6DQogIHJlYWQtY2FjaGU6IG9wdGltaXplIGV4
cGFuZF9uYW1lX2ZpZWxkKCkgdG8gc3BlZWQgdXAgVjQgaW5kZXggcGFyc2luZy4NCiAgZW9pZTog
YWRkIEVuZCBvZiBJbmRleCBFbnRyeSAoRU9JRSkgZXh0ZW5zaW9uDQogIHJlYWQtY2FjaGU6IGxv
YWQgY2FjaGUgZXh0ZW5zaW9ucyBvbiBhIHdvcmtlciB0aHJlYWQNCiAgcmVhZC1jYWNoZTogc3Bl
ZWQgdXAgaW5kZXggbG9hZCB0aHJvdWdoIHBhcmFsbGVsaXphdGlvbg0KDQogRG9jdW1lbnRhdGlv
bi9jb25maWcudHh0ICAgICAgICAgICAgICAgICB8ICAgNiArDQogRG9jdW1lbnRhdGlvbi90ZWNo
bmljYWwvaW5kZXgtZm9ybWF0LnR4dCB8ICAyMyArKw0KIGNvbmZpZy5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMTggKw0KIGNvbmZpZy5oICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDEgKw0KIHJlYWQtY2FjaGUuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCA0NzYgKysrKysrKysrKysrKysrKysrKystLS0NCiB0L1JFQURNRSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDExICsNCiB0L3QxNzAwLXNwbGl0LWluZGV4LnNoICAg
ICAgICAgICAgICAgICAgIHwgICAxICsNCiA3IGZpbGVzIGNoYW5nZWQsIDQ4NyBpbnNlcnRpb25z
KCspLCA0OSBkZWxldGlvbnMoLSkNCg0KDQpiYXNlLWNvbW1pdDogMjlkOWUzZTJjNDdkZDRiNTA1
M2IwYTk4Yzg5MTg3OGQzOTg0NjNlMw0KLS0gDQoyLjE4LjAud2luZG93cy4xDQoNCg0K
