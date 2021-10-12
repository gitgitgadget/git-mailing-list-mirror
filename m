Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79186C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5752360EE5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 09:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhJLJ7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:59:23 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:12738
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232891AbhJLJ7W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 05:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvfxWKvQGtBlw8QlDhxfS4qN1Dp1LsDvFdMj58oB2IJEi7s4xNetrBCIMk3+kMtg20WTlvhGBfMy9ZxBU54cAVaIJu6WOREamnTtzI1KuqvwYnLR/0dmDLKw+Azhu16/sJ6DhTWcpSVjhLAB7UBUHSbUlbgDRe9Bi8S+uNkxTj6fdyy0J4bY9VXiH+1bDzfK1PvSzQUTBGQ3RogatuwplYEfrzteHgiDh88BZDYgtIzq1F89SAg4lOvorz823O+cJm5Q1Utc/D3mCqyNtRGKTDqa2uNcwbVsOUijPb12U9t/hS6ZEw1IJDiam3ueZPUZLg+4Jsk42pNtadW2WKHEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwVSBJlNM2Hr4YXiBYRQhEQW7ga26l9CbdTFpdQVHdU=;
 b=YUoaaNQIi5D3PRf7c06kbsecwAnbmiLAekMN7pemQD+1BNmhP7ECh4hjjp7BgrHrWBWqaLAr4jhwL7uI3rEIW2gUJWL2NGQj+W+cciHRENAIPeoWcGWTiFN+5zl/TlssMB5QkYm7jX8dq4MM5CvZYFmUQrJU0PFNayDHceKZa9KWe1pnWSFcnFIX5PbeRgpQqZqUVoujw0YMjz0lMeV9mCFM4FrkqbpxdpIV9+ogSNWY5qPUC42dzBMnjOKqgejrhEoGWRm+vF6aAn1rsIzraXlSI7iH+7RUpVVYxwz3F1A3zXNjrBpfxcjsB9VySGc9M9R1Gd12wRi0P0WQKcxgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bmsystem.se; dmarc=pass action=none header.from=bmsystem.se;
 dkim=pass header.d=bmsystem.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bmsystemseupp.onmicrosoft.com; s=selector1-bmsystemseupp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwVSBJlNM2Hr4YXiBYRQhEQW7ga26l9CbdTFpdQVHdU=;
 b=O1BbwWj46irR43mF7nKoJAO0zDTp+Z7jMsQrvpvUGn4UCgdFah3n7K/FQVI5ctIA/7NFDtdvHl0enPfYLU9JNa/KyF5FvUtxjHjCqRfYUXzbkPQb0n5tCVACJc7GZ1diltN76sIZgYaxbmbtbOuOAa7hg5LOjLqjyqY+bSH0ils=
Received: from AM0PR07MB6145.eurprd07.prod.outlook.com (2603:10a6:208:110::33)
 by AM0PR07MB5428.eurprd07.prod.outlook.com (2603:10a6:208:ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.12; Tue, 12 Oct
 2021 09:57:18 +0000
Received: from AM0PR07MB6145.eurprd07.prod.outlook.com
 ([fe80::74f5:140f:b15c:4b42]) by AM0PR07MB6145.eurprd07.prod.outlook.com
 ([fe80::74f5:140f:b15c:4b42%6]) with mapi id 15.20.4608.014; Tue, 12 Oct 2021
 09:57:18 +0000
From:   Erik Cervin Edin <ErikCE@bmsystem.se>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug: git stash -p considers non sparsely checked-out paths deletions
Thread-Topic: bug: git stash -p considers non sparsely checked-out paths
 deletions
Thread-Index: Ade/TzKw8PRdIGprRmmSzz5/Bj1oPQ==
Date:   Tue, 12 Oct 2021 09:57:18 +0000
Message-ID: <AM0PR07MB6145BB2040DE0DA9280B8B90DBB69@AM0PR07MB6145.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 5428616b-badd-4d0b-8784-04e42c59b82b
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=bmsystem.se;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c93b34e2-2614-4047-9582-08d98d66ad92
x-ms-traffictypediagnostic: AM0PR07MB5428:
x-microsoft-antispam-prvs: <AM0PR07MB5428E8CC746C1A556E38AD46DBB69@AM0PR07MB5428.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gOqDp+8f5qkLXBPUwgw7ARiGhvGHMOBGlXadlMXH4zAPcoIzniIbZKW0zilGBQDb8FjYa20N8EvKuWpj/sgRCzigCMk+72WrG+BJRiM6VEqV+xuU0lW6WgSGLKpgUBJan/NYJQYNWJcw+kityRNbXdPG4j/oH/QDZYEkbbSoFpz45tHDZocdnR3+C50mqq3/VvuQDkYgUXPXFE26I5QyJz++G/g4jEebEfIvk+fbmhVb8BZ+M3NXBea8lBgYXB5pn/SoTpaEeWfJuqre0axLEkxyWWN7aVpw5RaS7pfS16sFVV05jHqnwQDyCSHj5XwSozx2fAIEbLUKm8WiGcSipUbkY5eKbxtYPEWpit9aceqNrhgH9G2AI841Mc1FNQ1i+K2IXSd/R5jjr5hZAqldau3It3FavcIlvM79kPQVjYC+NSJ3597S4NCWuNRhm6i1X25vIWS/Qz0ZnkQHspcJLmT1BJRnp0deGcs5NkYRSMUmVMaBdqQ9Jjjcgd/UyZ3MvkKLs4QQVddFQZOKFAg7YoTUQX3vPv2ZPqnony1/KpiNMbGGMaJdk/6yIpM42XdlolJMDmRSZTk/eN+foWsSoXJTe+eXO4VLWJoC602hEeqihYMrc2oSQzeQSsnWINCn72L0XEi7xL1sfYfXeCpb7kB5QTutXEhWJm6pckOC3Er4MUUM8JDbYzxiKczGIIyYgwjdMnM+SmWlVqohcQb5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB6145.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(366004)(136003)(376002)(346002)(71200400001)(33656002)(66446008)(7696005)(8676002)(186003)(76116006)(9686003)(122000001)(66556008)(26005)(66476007)(8936002)(66946007)(508600001)(6506007)(64756008)(83380400001)(38070700005)(55016002)(6916009)(52536014)(558084003)(2906002)(38100700002)(86362001)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnpJVnlRR1MxcXRkdzAxK0lQbCt5OGJtcEU5ajdES2JUbGxuMldUUEREbkNX?=
 =?utf-8?B?L3JlK3lEK3JyS1pzT3pVbmo5My9VUVdkZmFGMWlyQXg2MXc1Q1F5L2pGVUk2?=
 =?utf-8?B?SEF6QlRsZlczVitEQmRVMGlTYWpaSHhOaU9PcWtqR25mR21XaXFYMk1TNDli?=
 =?utf-8?B?bW5JRDZEcWRISVR0MVlPckphUjRPU1gwVmMzbldOdHNRY0dxN01BV1FOYllB?=
 =?utf-8?B?bzI2bXNFQkpCSFZ5ZU5vVzB2elBtRWZWU2REVEdPNG95dW44dE5oMDQ0Q1or?=
 =?utf-8?B?bW41ZzBQMFB5ZmVvcXVSL0ZpS1VodDJzRTlLbDMwSW01WVNVSmtQYm96eHpa?=
 =?utf-8?B?ZmJjSlB4cXhIcVpGWHk1UDZSaklvQlI0R09mYTdYQ05GeExTTGM0UGV5MXAw?=
 =?utf-8?B?TVNGRHUya2RRMThwUVQ4VFJ4UFVNVnZWakQzaGtMbkRXNUpsZzBiZHVVL25r?=
 =?utf-8?B?UVQrcmk2OHdJWjdqRnJiRGZ6Wk92TCt4R3lJbldPNGg1VUhEQUZEdHIvMWVx?=
 =?utf-8?B?YkFxYVFnZjlUbXo2aFdCUDZOd0Fzb2pLNitoaGNLWG9EQ3JueTN6K0l3U0Qy?=
 =?utf-8?B?NWc0RmJDWWdmZmhrd0ltREZRYW5DeHc0WlJ2YXRuN1VVWmVNRy9uM2laNlpW?=
 =?utf-8?B?U3kwd2oyTldORERSTEdpdTJZYkhFWnZqUkYwdEl5NzJNaXV2UG1LcFpaSEdN?=
 =?utf-8?B?RExYOHFrQkt4VmpxcW1OUlM1TU54T3VodE05N0psSDZjUzdYTXJ6MlVwam40?=
 =?utf-8?B?ZGhXMHNRZDYzb3VxTTlsaWxDdUNiUlViOWlsVkdaSEo4NC9qQldiMDhRNDRI?=
 =?utf-8?B?WVErTEhWaTRldi92UHpvR0NabDRqcWNTcVU3N2YxZUJlM2FoOVlPL3kvQWhj?=
 =?utf-8?B?V3UvZGZ2Zzdyd2p2TzZkcmtmRFJRZmZyK2dKeEN2a0tPU3dvQkJrNXhrN0Zl?=
 =?utf-8?B?bmZIa3dNYkw0VnlURjZBVWJyaTU3LzczejB5Y3F0dmpPVFY3bDQ3OEhzb0Vp?=
 =?utf-8?B?UjdRVkswdFBwZE9lLytadllBT1gxWGFVaWZEOWFCUUpnQjVqVXUreUt2Sm9N?=
 =?utf-8?B?NjBlVCs3enlKWnNCRVAvSHpVMU1ocVhCc3dOeWJzRkZkb1lTcWhieEhBUjla?=
 =?utf-8?B?VVhSRmZXRjE5ZlM2cHd3NEpydVpGUE1veGNjbDYvZFZqMmZoemZpTDdhUDdQ?=
 =?utf-8?B?U3NaNDVveHNodURKQndFUkFrSFZLMCsrYnhMYm9SbWdJYzVra21XT1BBSVRM?=
 =?utf-8?B?by9TeFNXSWNzc0dLZ1VIWVI4TGkzVHQzdVhTcEZad1ArRVpMQXYvL0R2Zk9s?=
 =?utf-8?B?b0d1UkRyb0pYQ1RTOGJkNEg4emZ3QmNWRE05eUJaYzdOZW00VXhjR1c4Nk9E?=
 =?utf-8?B?d3AwZm42eURuSmd6YkpzQ1Q0VUI3WW0xOE01T0N2dC9ka2FjWXNkbytxaTR3?=
 =?utf-8?B?Q2lwVCttMldHUVEzUHNyeHNJMnphQUtPYmRYS0FOVzh0VDBjWjFmaFVNSGh6?=
 =?utf-8?B?cWxPcnNrcjdwbDFnRWRrcUU0TnBtOCtVRkFkUmFNOUpwUzNLME84SVFzclRE?=
 =?utf-8?B?SDczSC9paGtkZEJscUdaenA1cy84NklhV1c5bXpTc1hlRHFYR2taZ1ZpQk50?=
 =?utf-8?B?YUdha3IrWjVzaEVaV3lVV0NkaklpU05yZ08xMG9JaU1qdXMrVWRwdElSOEZy?=
 =?utf-8?B?cElWT3BXWkVRdlFzd0dVTHczbExKOVRhUnlFRjdla1NNV1FHYyszcmEvZnVH?=
 =?utf-8?Q?+RRjZdzeT5u9wKC5qPCfd4jKr28IwDlylwP6tPn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bmsystem.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB6145.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93b34e2-2614-4047-9582-08d98d66ad92
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 09:57:18.6622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 74d26bfc-6e2c-4826-8f89-72b097ffd103
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDe07qIOVGaaZ0jY1pdenHig10ONRjX+JQofd9mEVFReqhKvTuou1r3wUHCIsSBB7u7V6+sXqK6z3o2UxLanfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5428
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2hlbiB1c2luZyBhIHJlcG9zaXRvcnkgd2l0aCBzcGFyc2UgY2hlY2tvdXQsIHJ1bm5pbmcgZ2l0
IHN0YXNoIC1wIHdpbGwgY29uc2lkZXIgcGF0aHMgdGhhdCBhcmUgbm90IHNwYXJzZWx5IGNoZWNr
ZWQtb3V0IGFzIGRlbGV0ZWQuDQpUaGlzIGJlaGF2aW9yIHdhcyBzZWVuIGluIGdpdCB2ZXJzaW9u
IDIuMzMuMC53aW5kb3dzLjINCg==
