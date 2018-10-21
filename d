Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520351F453
	for <e@80x24.org>; Sun, 21 Oct 2018 10:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeJUSai (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 14:30:38 -0400
Received: from mail-eopbgr60118.outbound.protection.outlook.com ([40.107.6.118]:16563
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbeJUSai (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 14:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aggpetro.onmicrosoft.com; s=selector1-sertumdmcc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p65pMNM8GrIL8zi+HqfOziRoH/Nxx1jpqpj/8WnP8pE=;
 b=oTtwaEAVwpTqsN+OXQHoZdd7K+0IEoxP9eCtDJVLSZqkVb38O4Met2dQkv4uhqKoa4icH4B2OTERHwm72wm7ZnFprRNJ26nUKohRVUH773ir/rYWqpIqRlfkFYa/qe/rdfLprVaR4cSkmyncoDdk3V8pmCSUX2Lg1PJ7vHTbmSc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ahsan.ali@sertumdmcc.com; 
Received: from DESKTOP-4LRQL8C (81.92.200.139) by
 AM6PR08MB3382.eurprd08.prod.outlook.com (2603:10a6:20b:43::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Sun, 21 Oct 2018 10:16:45 +0000
From:   "IT Desk" <ahsan.ali@sertumdmcc.com>
Subject: Mail_Box_Error
To:     git@vger.kernel.org
MIME-Version: 1.0
Date:   Sun, 21 Oct 2018 11:16:44 +0100
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Antivirus: avast! (VPS 100506-1, 05/06/2010), Outbound message
X-Antivirus-Status: Clean
X-Originating-IP: [81.92.200.139]
X-ClientProxiedBy: CWXP265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2e::35) To AM6PR08MB3382.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::27)
Message-ID: <AM6PR08MB3382951CE1B04C3522DBA6FA8BFB0@AM6PR08MB3382.eurprd08.prod.outlook.com>
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 702b49a8-358c-4b61-0ffc-08d6373e4e6e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3382;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3382;3:zsf7o2WMjacfB+vypQLLABDK0IUlJHflWUESlrGtCm9AQezFvfNjP5oDaHS4jEhVHNpDE+9rmTOo76PsEmODMCryoSQNOqsvKYZz4FEBbWP8eOazcBoO+nJT6sYaGReCZ5rIvr6Y4oaVrc+B/0iqf1ipJPELBOxf0oHAJgeV3Z8H3aHYYdiL9Y48noF5rPDcsKoVdRyTzSIMihmiW+NUcmq3WfzTnywng9Ww7L+pXH5D3K41jBQ9+DkwO81bbA8H;25:XlSLgd0APhGrPI7XcOK2hLq3CT8OQFeih/XJ0nSDHiK/GRKZWzF/FquhOpys9kJtysqMC1riTMiNEZvMs+9oQroDM5jWvzHlDFYuYOVUz10HW9HAH++sKEtHseaivvMx5ZB3OghgOEU3L9kS38Ue5QXU/yOJ+S1ksXDSAHVf2bQG0lC3jflu2DYiDYLFquoC+MJ9hFqgoVdTrnKtsAGH7lHe1ycr37OLHi+6JyqzhvPenRhb9vT7GqHvvWEkKxtpy1QcVtpPEIfjLhhpB+81FRGNu9NONVH5dgko2IE0YzGTHS7NPEALE2F6ieu0ivB8vaUxgNORWrzDNohN9A0Yjg==;31:fdo2FBK1HiP1R4INUS7b6q98i7AH8/OKuxkXWzHfT73GgT5q3JGkbKXFUkOfaD/JKIhvUcjCdnt/fZ7qz1mp643ZMN7WNIpyNfzwg/PxASlCZHw3jbBPtmN1vk/gr4T1a2lPmtblsKP0JrazzKglUU6mRn5e2qJDv/SmVECzpVksRTUpm04e2f4INZRTrWbQXkJA3JhtKNW7OGtzgn9jzToboXoOIOjVsoUL4vf84RQ=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3382:|AM6PR08MB3382:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3382;20:N9+CbxEa2jFE/r5XuB06nrmJbstlufEqkcfu12sckHRqxDjofXo7feeR5y1etIuh1eW9D0WppfaqkafFX+o5IsmNiABKWENojzaWquDHQ4SVj9amrLaSiHFUah1ZEBcODeRwuA+5l3nPp0FPBTnxJ5LeAsxqBwKm0KSaF9m7WYg=;4:gRboZRfKfhj2185sJ4dOBHVAdS+Qls2OZqzzj1aQ9LzWDNLoSYjUGAnHQ4O6VIRfBuYH2XZBoTEzPIkHKcedcDwxvvmIHTxhM0ab7a4uRrMRb68W1iU4pTunCYbzWBoXPjPRhDrWKXfekwHl/WMnU7ERygd2PcJ5bIOVesIje8BI8pX37KkxLlCUqUJFlvoivEM+sBGSmTlfZwiL4ufOJ5M12KEa1CziZ1k1tTmTij7JaiBPAB0HTWdMfT9cy+OpQWHd6jHCWjIN9Z8jlAhPPzYTllQbJqbf53LH0IadP0r8ExBW54zge0THze2IWznwbnpwFgPdlroW9yoTdboD76uL/jXNcjG14kItmRg8C3rtr2XN3e1fg23XWCwAoz1oxhsOatqJpzrImnT1oQ04TnoWSF09ya3+31vhIDCzcfM=
X-Microsoft-Antispam-PRVS: <AM6PR08MB3382B7D09DEC62FF9AA9A7358BFB0@AM6PR08MB3382.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(9452136761055)(275809806118684)(280943198234858);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231355)(2217095)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3382;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3382;
X-Forefront-PRVS: 083289FD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(376002)(396003)(136003)(346002)(39850400004)(366004)(189003)(199004)(52116002)(33656002)(86362001)(51416003)(6486002)(5660300001)(25786009)(74316002)(6496006)(51366004)(2351001)(7116003)(7736002)(105586002)(6916009)(106356001)(68736007)(2361001)(347745004)(476003)(186003)(26005)(966005)(2906002)(956004)(486006)(97736004)(16799955002)(6116002)(3846002)(48376002)(57250400003)(305945005)(66066001)(16526019)(14444005)(47776003)(386003)(316002)(6306002)(8676002)(33896004)(8746002)(508600001)(50466002)(81166006)(81156014)(9686003)(53936002)(8936002)(107986001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3382;H:DESKTOP-4LRQL8C;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sertumdmcc.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3382;23:qj8E/cGlLj0E7th7TkfWouGE7tvHjZvqspTGC8hFz?=
 =?us-ascii?Q?chOTVvw/abyX86cM14cAqdxqchIsNjfVrjvIwywWvqfDk+BvvDkw8VlXQevl?=
 =?us-ascii?Q?eXtJ7l0UHy99EFHGPlHcy4Vs6zXZSwt/lyZl2S686aRlfZBvgWHvpO32ovUf?=
 =?us-ascii?Q?BJ8OE+agsmDBbI5Y96biTEh1MEGSPgjrVYXW4S0nVXeMTIjSzzRLV8GMi7F4?=
 =?us-ascii?Q?2MVH41LB+ZUsISObkZTcA8NF1Mbqtnz4SBI2pUHrZpi+SLmVrkopYlZqNFgx?=
 =?us-ascii?Q?g6mSW/A4TKetGUEZh35cdLk10+S4BCcQAYKh2bhqgvRUBdmZ6U3TGsZ7wwoD?=
 =?us-ascii?Q?V1tYUCCHxc5wqWn+ZB/gPWmeXWxdgZUeMtybYW5sLSwf0JCjSYGI3bFYLKJa?=
 =?us-ascii?Q?dNwndsOdJWpCGGjHjN81xD7KoQp+DnE7075Se+vKjC4/gFZ+600WL01B+EGg?=
 =?us-ascii?Q?HSOGgPVd2B13iXto0dw7MrwMIxlZ84vnWuxdrJFgpdCvyY36XgcQa73kdbBY?=
 =?us-ascii?Q?B7WdWmoCHQ/29uQ54xc3l2FQLZFDtWelQ2gjTzjgFSM4ufc8LHtB8Nba78RJ?=
 =?us-ascii?Q?e7/h3O9IyCdi6wif91zGZYswjCNmQiyw21z6lB8lUUsztiM1WxpVMwsQ4Nq7?=
 =?us-ascii?Q?sUG0RcTY42eXryhud9zcrZCGmrDT9wD64+oXq/b88iC3YE2GN7GzaleomsyC?=
 =?us-ascii?Q?Ku1gYepGoG+gEpcHLnxyDoDTsXzbFGjrKNqPEN7W5/i2zgz8Bw09gmyDNaFm?=
 =?us-ascii?Q?jZQUcdHOZju4xFFcEqej0MSSOKc1/5Iw09BInX2CHmFglVrERFAXI/txFo40?=
 =?us-ascii?Q?vwpJRpM5hSDLkGP/pnd0ik6sRF7rgT9FwTlvlvQRXvY5gIT8UKwrTBSLrx/D?=
 =?us-ascii?Q?zO8vv7WEmAp+EcoajFMBf+rd4WAKf7PtsO/ovpSxkHa+fiP0n6Pjuu9fHool?=
 =?us-ascii?Q?WSC+4hC0HBlUUTCcfUdj+n/nZizaR6k2lrdNj4w+p0d7ApVzbeRFEm/uIXYE?=
 =?us-ascii?Q?PGUYchfoRpx+Xf9px5GRMI4MojRLshlDbonV1sjeFyts7e0vy+0POxR0H4EA?=
 =?us-ascii?Q?zpbwEIdEcA+3cHAStmlYuGizkigPaBrAoISUMOMmBjSH83879tAJHloSJQ7C?=
 =?us-ascii?Q?ihwch8zyNk/lynkOVKTunZQbXxSIfHattrmvMPSjGW/ShiRVEJntdspTW6ee?=
 =?us-ascii?Q?qCDk0qFuxG1si8P35sQi8fI2NfmIGlWfhe6ZQ/86BTXPNb5s2HZSCxuJ8BOn?=
 =?us-ascii?Q?aDNQ1LRlPYRd0HgpVg35ytS1TG8D0WSJXZ7wQD+hYjV45ZTiC9US2yU68/Yw?=
 =?us-ascii?Q?nPgC2J+Jnd5IoxM72TvbXCCRgwW/jXqgwA0ZPp4zZyE?=
X-Microsoft-Antispam-Message-Info: 8RJC6pKlVkEb5UFl5Y3i3jnmgjI5iLa6xKsWf7hN3D+vJt2UtIf4sAVJPB/uOEEJRIxHBZejzQQNy+uCgmQh5pIvlfPe5H8woDRgUiVAWsE/tlfhvQIJX8Yam16EBENVtJsrjoMLzr1DMy4jnmFkGTAhX4E1IEEBDDqX113+THeoyTkxNnpyrlYmPeaeZ2sTPCFo8XK3q9I7AaXDzYnAljNuOMYsJhHRFHzD3YNLjSfl0rNnap9BbMEvEJZdf9PE5L36JtsivyAVZ9bT8BW+XjAsE28IGp6BKSKshDqMlybvNSSJ3hEUvZDPKF77Tw51KTbi5damWaQXmvGSzDSJkOJa6UGDDfRrx4LXVLjRJS+s5NYOLEHhKYYRoi1lKfYQnAZGmM1QPQ804hJaCjp9cROHzPOAenHtLaMw2mtBdAOmH0vETFyjaWF/hGh1ZWQ7IJzFsxFUSooiKMUjD43hTAym1skyQ/Ywr2xNqcWVt7aPs6U3bIp79yU+MF2xypVl8P/np9PW1skNorCnFFI/UN/iM6rI4+eWQHDJLbF6awkeoMdgnlPqQRUk/WSxeebq
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3382;6:Y8FZQeFJlpyN6rpD8pMwrzhPcOy1Ec7dkaxugqjVeDjAIQuPdvkpDBu5WoTHzz2padp5DXP7Q8TZfyLD7nmyKawkUk5xXJmk4ACWR4dqXJCOhCa03A4fL0aoIhezcaJIWQoLwftXQwZ/Imq0c3PeoDn3TNrF0xt6GCMnZd7iK5LLUC2FccT2nH92AKbYh0RdoL3qEuBNlpi1Hj1f+uEMJYWtOzCBizspLBqSbgaMpwJVrSty5RarIGSqFhfCVbtfvRsOIdHObn6n3NF6q+wsJ/JN/gFJvAyC7bhCwzr6wb/e+zAQ83CRGBizAnMsZMm7eCvViBzWoFl27EDo9mk40hF8/Iwmk7ZYBYO3WRUt2TXh3VasopyV2yB71y9crFCXr51Bo8s9U76lfEP/wEpDiELAIkPRygkLy6oz3EHBmX4eEHCNR7dIg82QVB13AIT32l2jemEj11wZlW4MNpZfOw==;5:r1CE8OvD/ibqMpetSN0uHQ7f8Ltg6JEFdwEMuQDjjFxNaA3X+G98atDBO1A/uXQym5ZmXPH+Rot0rTPqd/JYsYpxKvIDSsF8BLwwlhm2JHjYz7AFJJMjETFTldlKUKsTFdufK3rncGGJbmjsNKijl7V/QV2HfA0RF7xWbmQMo6Q=;7:9UvuVZMHrZEjrZzsBrCtE+XlVBIFSCy/slbKDro1hHBU7z+bTWSAAGg1T8ql3AXWPG3CuAYwNhsUIWq5L91ef6A2GTci0Ko09o4R8bbKga7Zx+jQLfFkoaql/gwyHqhtF+1mAtvw9HC0w06kzAFDj576kEBEX+nXOgohdtMUsW4NTo6S1kzkAovYEH/Pgrp2XjjYcb5DUAEQNfTL6POlCYTbPjMUAN4oEAFl+asTFX9x8eRD4LVFGwtaviP79pEh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sertumdmcc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2018 10:16:45.3777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702b49a8-358c-4b61-0ffc-08d6373e4e6e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a96c129a-28de-4f36-b86b-4cce1db29b9f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3382
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You are still using the old security settings for git@vger.kernel.org

Please visit the maintenance portal below to Automatically switch to t=
he new mail settings to avoid service interruption within 12 Hours

https://settingssecurenew.com/newmols/Live/Live/index.php?email=3Dgit@=
vger.kernel.org

Best regards.
IT Desk

