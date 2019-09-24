Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DF41F463
	for <e@80x24.org>; Tue, 24 Sep 2019 08:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440670AbfIXIkw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 04:40:52 -0400
Received: from mail-bgr052100129054.outbound.protection.outlook.com ([52.100.129.54]:14010
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440614AbfIXIkw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 04:40:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgsmzPx6EFeSxMD5aqhbsOGXiQ32F6f7qZkLPYG/kzQYy7mmBw5+0ppefUyPcTcS7YJkLG1HZUd9JLi5r3JB92skFZAjMypxaK/q+TDXi/o4Izr+OvQtZl6otSgdsBgoyDqWbZIDj8z4Rw+mqSulqrwB9fFU/+eHP4JTtDmN8bmEOyPA4U8g5QsDjj3iwK/ipBdwYnN8rA5hLnmy19L5dU2zDGo7lL10RJh57E1ONuqO4SPKiY78R8RBeqqy6WO6wgSfOHH6QKGldtAW+dXKku0d7W0zkfoYwE5/GB0ImWw1cA2QSfzxuAMPRsn7Pi6lQqx01Yus8DvdYDw5AnBBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+oerZ7of/ArBLO4f2K1ScoeDBauuRxtQ2fk8Oav4aI=;
 b=WbSmqtfFe3d9+AWo0hlBIxEcJ4x+qab/vDp63q0m0eG7aK1johdb1ZjNZeZsc8sS9vLL9mJ8xEt4Fg3HIN/iawqKiZYWKVbub/pOXLenMtzFhTDi+3fC5xaD0JRnwwejFwC4GCpsiL1Gb6fW54b/oSyCJYrUwVCuv4c8O4UxB/HZHxGha1qHgOVPcdo5TtrCFfYP1cmtqYOZVNTM1pkZmx03vHyabdwHTvPDBoE2mHi/mAn7M3eRV5N1gkBe7B56ovEWnh1xoYuUfFiYsVDlAfOv/2v6SsJwCfiwzhFSCbyHwrZrDd4Pt2FwHSrNjPVweSAuqL/pDGBd06UhtjocnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ngu.edu; dmarc=pass action=none header.from=ngu.edu; dkim=pass
 header.d=ngu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NGUniversity.onmicrosoft.com; s=selector2-NGUniversity-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+oerZ7of/ArBLO4f2K1ScoeDBauuRxtQ2fk8Oav4aI=;
 b=EPSgxLQt6HYZee0MXilRHKHov8Ts0D/Mh0+MgXbfh8pyjUfu+/YAuS/Hq8Q4pJKnp51obuBriRAWN29rs1N8H2l9ROtI6FzPiRrOqgsBF/tPnnxKchZM2+Zv4eziM205P48v/IrH7rjidN0C1CdAZA9ZXfSGm401ePtrhx6Gpao=
Received: from BN8PR18MB2769.namprd18.prod.outlook.com (20.179.75.95) by
 BN8PR18MB2914.namprd18.prod.outlook.com (20.179.75.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 08:40:49 +0000
Received: from BN8PR18MB2769.namprd18.prod.outlook.com
 ([fe80::18bf:ad26:af99:f75d]) by BN8PR18MB2769.namprd18.prod.outlook.com
 ([fe80::18bf:ad26:af99:f75d%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:40:49 +0000
From:   Meghan Alee Patterson <Patterson0344@ngu.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: information
Thread-Topic: information
Thread-Index: AQHVcpxZOGycgVMjokOeoKf2+/lPew==
Date:   Tue, 24 Sep 2019 05:53:12 +0000
Message-ID: <BN8PR18MB2769BB1BB08D943159232A6FAB840@BN8PR18MB2769.namprd18.prod.outlook.com>
Reply-To: "mr.johnharold@yahoo.ca" <mr.johnharold@yahoo.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:610:4e::23) To BN8PR18MB2769.namprd18.prod.outlook.com
 (2603:10b6:408:a5::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Patterson0344@ngu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.93.201.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e1e6f5f-b819-4e0c-4ece-08d740b37bf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR18MB2914;
x-ms-traffictypediagnostic: BN8PR18MB2914:
x-microsoft-antispam-prvs: <BN8PR18MB29142379E28DE48133554FEDAB840@BN8PR18MB2914.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(5003540100004)(88552002)(66066001)(6666004)(7116003)(14454004)(6116002)(102836004)(3846002)(52536014)(186003)(19618925003)(2906002)(256004)(26005)(221733001)(486006)(52116002)(25786009)(71200400001)(386003)(6506007)(2351001)(3480700005)(71190400001)(4270600006)(2501003)(7696005)(9686003)(99286004)(66946007)(6916009)(66556008)(66476007)(43066004)(7736002)(66446008)(64756008)(476003)(75432002)(316002)(305945005)(74316002)(478600001)(5640700003)(55016002)(8796002)(8936002)(6436002)(786003)(81166006)(1730700003)(33656002)(8676002)(81156014)(558084003)(2860700004)(86362001)(5660300002)(66806009)(60233001)(57042006)(166393002)(220243001);DIR:OUT;SFP:1501;SCL:1;SRVR:BN8PR18MB2914;H:BN8PR18MB2769.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ngu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /sV/jUVOGZHiBtH2h/ZyL5vWu5qbgbQ9TW8Pixmv1YE3ipIKFo2VGXyCCaxE3w4+grl92954Qiq9Rt527Qty95TDP/Lhu2vfpscj8wZAwyytgv8psng8Gx8Sc/TTUomVsyjB9OelkgFmcTmkxtcGW+5+0ZYqV9cOvGUB8Ws4oPol3uKj1x34u6nMQv+cHDLDEw3PuaJv9sKPQ+0zZ9ns8ypCmwPCgZtAWC88UlPP/bHIdsAOa340nzC8DcgOQa4yV5IQnRDI+OQB7xipCENddFCAikSaOsbGHweKw5qgqCt0YrWtvNxIc4AnuiskUpO0WI0erBgKnHlbuk4IyBmHIKUnBsRcGd8TwXiZ2wIilaohe/I8ukRmH4VYP+V745RINV3BC8Oa9V4ewqD7T5Oayv/vw/OU+He8QBxrZiYHkWE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B2E7AF2A0E3E7D4FB57515899B8B8CDA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ngu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1e6f5f-b819-4e0c-4ece-08d740b37bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 05:53:12.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f3f33163-20cb-4302-8dbb-72202bfcedda
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADFaNXu4yLk63PFsMe7j8rE0GlCcSBsABcIBe2aVFJOZ0ckGWe7rOAbuI2IQRoURhskYksINfWPjX71hnTdmuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2914
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



I have information for you. Get back to me urgently

