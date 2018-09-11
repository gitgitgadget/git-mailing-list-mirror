Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCEC1F428
	for <e@80x24.org>; Tue, 11 Sep 2018 23:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbeILE2M (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:28:12 -0400
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:1880
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725738AbeILE2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnVk6g3HiLrASn303uQqvW0NKVN98EV3fRbcQvlY47Q=;
 b=AlBkFCnpyMJjmZ6NiHA16VUf7u1RVSHMtml4N1p58O3UA46FoAqD5qaUK2Hdfy2p/AF/k/rkUmSJvt3eapbsBIOI+O4HcyR2n1oQKyJNZLEvAgeZ+hyHCK9nwKgWrTHOKnduGYU6nuNWtpC07YNVT5cpjBbyheK536X9KWumvYk=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Tue, 11 Sep 2018 23:26:35 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.006; Tue, 11 Sep 2018
 23:26:35 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v4 0/5] read-cache: speed up index load through
 parallelization
Thread-Topic: [PATCH v4 0/5] read-cache: speed up index load through
 parallelization
Thread-Index: AQHUSibhK8DrV+M9102h/PlbodlddQ==
Date:   Tue, 11 Sep 2018 23:26:34 +0000
Message-ID: <20180911232615.35904-1-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
In-Reply-To: <20180823154053.20212-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY4PR1601CA0021.namprd16.prod.outlook.com
 (2603:10b6:910:72::34) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:C4f847tC45FN6j/z/bhK+HMY9nVDo+MEka5s64eDZgIyWwQtgwLBgQV4RRZvTResM+DdpfH0akwQmnn7DaZG8P3Y78hU+PRq20R4maUJF/n9q1OWiOUG6p29hdK8CawKSNPLviArY+jSl7NUswH4ogo7PVEfR4l+hRgnsxI+eY4ZIciHSGJVJH6OocW8Yj8RpfR1OyC5vYCAiFr/ijrsG/OnJ3me7tVU1cdmqG0ztuXulQZ3X/zCPTIEp6an+sv1l+eI5Uj9/XcsYHceLEHBFRuYTJ5RMhbD9rnjadXQjrUr5CFRawcjJHqAylCCvZKnjCMXFABYFivDa+OZIsHqxVbHomS01xQF4nlOr/gvWp7Gb/VJQpcTFoUOa4uDDI6ni4/bfo2TsyI0JNXRIS1TqYx8hmpMG4HLqlJNiqVGc7V2iD/BN+vnzIraEqWbS4xF3TumV8mSVeDVw5LkLbzsvQ==;5:Lu4JleDq9AYSKtX2jcN7EUXg4IlD6iZ17LDHstaTjMGsnuqy7npLv3xd134ZJpLvvGDivJlj0Ed2LMDdL+d8mGnFIaNjiVYll+FtYvqlccvQY2XVvnnSZAOylvlW4W4IBGirFpbSzidNlQGAX7XF3f9+StJe/ZOJBhaRxdU18rM=;7:1JvJnYmHd29EiA5tz1nlMe5gEdX+qoB/2Y+YciCytuEtbwHyy9/0aAvFFCjSnZK+NA6l9Ibragdt8Jrxd/zdXlrl4XGIqqrdkw7GrXJDKLw97SrkshBIM4Dfo+FcwXLwnIymETIRWBbOJaZMVzBqIRZ0QHbzFPAXqwCb/8/L7PbM/FR7r8Z9KBFeX32dDzzWku21c5bH+/HNEDvc+hmpLjQfg50JMR8KUz76RB8BFnhOyBYLn9MkAT1noN2XaJJ6
x-ms-office365-filtering-correlation-id: 945795c7-be51-4fd8-9d34-08d6183e0345
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB11133C74D5BD3B732D6D6AD2F4040@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699050)(76991037);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(386003)(6116002)(97736004)(6506007)(86612001)(7736002)(5640700003)(575784001)(81156014)(81166006)(26005)(2900100001)(102836004)(6436002)(1730700003)(6346003)(305945005)(11346002)(446003)(2616005)(476003)(486006)(3846002)(256004)(36756003)(10090500001)(66066001)(186003)(53936002)(1076002)(106356001)(105586002)(2351001)(6512007)(316002)(4326008)(54906003)(2906002)(52116002)(25786009)(6306002)(5660300001)(107886003)(68736007)(22452003)(76176011)(39060400002)(6916009)(50226002)(478600001)(2501003)(99286004)(72206003)(14454004)(5250100002)(8936002)(8676002)(10290500003)(6486002)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: xi0DSKDBQmjPn0SkzriYm00p3budSBBPFTNK1ZKfK70T++xKemA17t+T7L1TkqBmRIsss38nVD7f7iDSn4iNBHoN1G9gKLPVhq+BdcUpbSs96jhJ9sAS1gchWs+esnyJqtOwY4mUkftc/MX8aCqnfYgKB6wFWEcXRz9iVXVxrxgIhO1C3TJXgFuIzUhNAdD4EEgEyQluDyz++sM+EIjuKlcKOgpSf5PT7hCdpVNTIZanIEe3OtBXhshw6IOD3Ttxrg8x1WdOPPAIijiYtxQBfeQ1uzeBiMnMNUsmpqG85VU01kuoYgV/vdWkzAYKtkl1UTbu1SiyMiBICGaPV+BI54rIU3KIhPNayYcpifumLNc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9D081908E3EA64C905352A1757B3910@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945795c7-be51-4fd8-9d34-08d6183e0345
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 23:26:34.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhpcyB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBtZXJnZXMgaW4gRHV5J3Mgd29yayB0byBzcGVlZCB1
cCBpbmRleCB2NCBkZWNvZGluZy4NCkkgaGFkIHRvIG1hc3NhZ2UgaXQgYSBiaXQgdG8gZ2V0IGl0
IHRvIHdvcmsgd2l0aCB0aGUgbXVsdGktdGhyZWFkaW5nIGJ1dCBpdHMNCnN0aWxsIGxhcmdlbHkg
aGlzIGNvZGUuIEl0IGhlbHBzIGEgbGl0dGxlICgzJS00JSkgd2hlbiB0aGUgY2FjaGUgZW50cnkg
dGhyZWFkKHMpDQp0YWtlIHRoZSBsb25nZXN0IGFuZCBub3Qgd2hlbiB0aGUgaW5kZXggZXh0ZW5z
aW9ucyBsb2FkaW5nIGlzIHRoZSBsb25nIHRocmVhZC4NCg0KSSBhbHNvIGFkZGVkIGEgbWlub3Ig
Y2xlYW51cCBwYXRjaCB0byBtaW5pbWl6ZSB0aGUgY2FzdGluZyByZXF1aXJlZCB3aGVuDQp3b3Jr
aW5nIHdpdGggdGhlIG1lbW9yeSBtYXBwZWQgaW5kZXggYW5kIG90aGVyIG1pbm9yIGNoYW5nZXMg
YmFzZWQgb24gdGhlDQpmZWVkYmFjayByZWNlaXZlZC4NCg0KQmFzZSBSZWY6IHYyLjE5LjANCldl
Yi1EaWZmOiBodHRwczovL2dpdGh1Yi5jb20vYmVucGVhcnQvZ2l0L2NvbW1pdC85ZDMxZDVmYjIw
DQpDaGVja291dDogZ2l0IGZldGNoIGh0dHBzOi8vZ2l0aHViLmNvbS9iZW5wZWFydC9naXQgcmVh
ZC1pbmRleC1tdWx0aXRocmVhZC12NCAmJiBnaXQgY2hlY2tvdXQgOWQzMWQ1ZmIyMA0KDQoNCiMj
IyBQYXRjaGVzDQoNCkJlbiBQZWFydCAoNCk6DQogIGVvaWU6IGFkZCBFbmQgb2YgSW5kZXggRW50
cnkgKEVPSUUpIGV4dGVuc2lvbg0KICByZWFkLWNhY2hlOiBsb2FkIGNhY2hlIGV4dGVuc2lvbnMg
b24gYSB3b3JrZXIgdGhyZWFkDQogIHJlYWQtY2FjaGU6IHNwZWVkIHVwIGluZGV4IGxvYWQgdGhy
b3VnaCBwYXJhbGxlbGl6YXRpb24NCiAgcmVhZC1jYWNoZTogY2xlYW4gdXAgY2FzdGluZyBhbmQg
Ynl0ZSBkZWNvZGluZw0KDQpOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5ICgxKToNCiAgcmVhZC1j
YWNoZS5jOiBvcHRpbWl6ZSByZWFkaW5nIGluZGV4IGZvcm1hdCB2NA0KDQogRG9jdW1lbnRhdGlv
bi9jb25maWcudHh0ICAgICAgICAgICAgICAgICB8ICAgNiArDQogRG9jdW1lbnRhdGlvbi90ZWNo
bmljYWwvaW5kZXgtZm9ybWF0LnR4dCB8ICAyMyArDQogY29uZmlnLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxOCArDQogY29uZmlnLmggICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMSArDQogcmVhZC1jYWNoZS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDU4MSArKysrKysrKysrKysrKysrKysrLS0tLQ0KIDUgZmlsZXMgY2hhbmdlZCwgNTMx
IGluc2VydGlvbnMoKyksIDk4IGRlbGV0aW9ucygtKQ0KDQoNCmJhc2UtY29tbWl0OiAxZDQzNjFi
MGYzNDQxODhhYjVlZWM2ZGNlYTAxZjYxYTNhM2ExNjcwDQotLSANCjIuMTguMC53aW5kb3dzLjEN
Cg0KDQo=
