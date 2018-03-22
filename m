Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AFA1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeCVRk1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:40:27 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:2404
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751594AbeCVRk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n8eUwloB0wjwvG57oeWXRXkZZD6UyNKMh/4D4rgO3xs=;
 b=dvWLPOZpPyG8cJ4u7ldngM63W0qkx0fQombdl/wrMUO+YFpFmwziGF5AAa/4XZ/wvZN9hBbh/R6sZfGZQTwRXm71/EnaAok7RbvHaBse1++IKc1fPAG8wvC0aT2AvJD6gM0uu37d/usAFSstfqvyKoodxR82iP1ix+0at6hdqOI=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (2603:10b6:4:a8::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.631.1; Thu, 22 Mar 2018 17:40:24 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 0/3] Use bsearch_hash() for abbreviations
Date:   Thu, 22 Mar 2018 13:40:07 -0400
Message-Id: <20180322174010.120117-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180321224226.GA74743@genre.crustytoothpaste.net>
References: <20180321224226.GA74743@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BN4PR10CA0017.namprd10.prod.outlook.com (2603:10b6:403::27)
 To DM5PR2101MB1015.namprd21.prod.outlook.com (2603:10b6:4:a8::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f843db12-ece3-4290-214c-08d5901bfe72
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;3:i/f6mfsSvoBchZquWSaCZ9BeRQWz41csEDtL14PivxvPI6+FoJpV1ASI4tZr3pNvDTBoDkL9dYmZpMrnxhZNybci0bP23eGYlOEJy+JP/9N7Kl/5bjXtYcO34Xlk8PenNA5+qPVXhouk9KPcGSKvrxZBWPkIF7S45rEapazuu2Kgm+fSvj40X47J5ONV7N8L7j6d25senmG5wBI6LQW4JaH/jx6R8PzlnGBoA3rJMTQ20+rDolbwWVnM7PmbHTpD;25:oit3YErz7ew/UBRphsjaXHuUi400SFFndpXH/appgXfCYlBbTcP2FtmaFCFz0FdLhBaKFWCNWlda8VXlrwqwSMN74lZ9xMcBcMzdccLxUQOSG907uCvHP8l/z544/6o+Bb5yb7TtBtVcXyJGLea2eYbWo0CoQV3h79iUV2e20tOfrXochoPf/zP67ozFlLWjg0SPSYDiqA4aUNfKMAL+gpwY3mfwF/fcUiVQUN8jc4SY6oNvRrG4YST6jof0MmAWOgy7lTPgMWALIq57WGDr+0tv3CJYC6q1AwYpTfwPJOPOqXfLrF5TjJorQYx47vjJ9ROcziBNTe1i7ce+jUfzXQ==;31:L2UF0SllEmF4zGSdkxnZmM8N7IV79JcIJCxGM+43uZzxEZfzqHzGVFzy8Nz+gMGDNx82HXzNBWtOd5MCIp1dAS6sH0wBlAklzIfXM2VXKk+iyD9JpVlth2tIQD3UX2+gRK1RwVPvIXINhU+E0pfu1/lV7Sckile8yEH4g6CkMGrNMKIs9HFA1AH6bu7PQF5Lp/TAEwVj91MrOCnj02NtrH41vL0tlPZLnlNAtqD4OE0=
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1015:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;20:1HJy0KNmHTmrxWRQiNqUIAIlwW+ydFwl6lkA0Bs4x8P8N1WQ6UZzNyC+e/DSsgNRYT1xXKSXGp9tmHoQmjPxztW/dNe4ovJFdHWrNqWFLBv/erYamaME2Nx3hWz1Sc7IHYCrrsjuqPrfSs1M/cSFmTuTMr4zSXDA/KTGOc0kk3z8QXFJiZl7pVZWnfNpVvoakIvsSPnCd7m2fWAr7rDBr9qKNhcLqJSM/kF9LJgVxz4xhAW5KbdN69sMC4fT82nyeSeWOTvJTW5JaXO+xMmQByCJPUdcwwwIe1gAZgeFEjZGxwgGWsDNBaO0HdkWfBoH3Qg33WRmYkZQYCSLBamMG3J/eBzWDtCRoOG+fdk9bUtHzoMlksUwjtAGU37HzSEe9Ce4jiSvTFHDYkeGJ1CG9AjL2tzQ2xzYJUvuYOlKykDnRE/vPnv2mQTMJCqmAv0YBuZuDvIGipatq4CjTztCimRDYJzuuWhRNhNI5hSOioS05mmNqZ6ugLbVYdo+EqVb;4:D3evcf17k2sJumVcL6KNVAglRWNOeDBNOalaC5Kv38koUl1q9O+WE6NqAASIRMgtv0tRL23/kfBu1O9jM7hx7f1X3hLusfcf16P7Q8ExXGK++3YpCibnclwXctZH3KAJE6XxX9+f9Jj1WzRIo7Krn41ItYiolhl6WKB1DYSTd0Kev5P1s6+cBx9DV/dklxgeJln2hDSxvwghUJKombAuHUEfL7hU4qS+ZPKDK5Pj0W9lMsnMYVyckID5kf7cKrhFV6sChfG9L9Z+z/Y4SXiSrA==
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1015C743D14D1D34106E0597A1A90@DM5PR2101MB1015.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(199004)(189003)(68736007)(1076002)(10290500003)(6346003)(386003)(4326008)(76176011)(22452003)(305945005)(52396003)(51416003)(7696005)(52116002)(46003)(86362001)(25786009)(5660300001)(478600001)(53936002)(50466002)(6116002)(48376002)(36756003)(446003)(8936002)(2906002)(16526019)(16586007)(6916009)(81166006)(6486002)(97736004)(6666003)(81156014)(7736002)(316002)(10090500001)(107886003)(105586002)(106356001)(39060400002)(186003)(2351001)(50226002)(2361001)(86612001)(47776003)(11346002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR2101MB1015;23:xq2ghO1XFPn4wYHGDPjtX2q+1BZJPY24u8dZwrz?=
 =?us-ascii?Q?J10hsSaVk3kbvu0dV2V6iuGn88ghSsM88FWNzlaI8SRnFW9efW9BgIJImJSh?=
 =?us-ascii?Q?Ese8xRtXCO21qhQnF0SxCo1wblBs0Pxc4hEUsn5UE1QFQc1Ih5bk7FHKhu2e?=
 =?us-ascii?Q?LIHHKV7rEumqQ44mQlkI40Qo8uE+np6jDFW8XPmlND/ZVGIupJ6oK7iZwA2R?=
 =?us-ascii?Q?FM2/x0MH3nZi20UxDeQD1QobMIEmHNxDHET4J8Pv+P9u6BUZYuxgAFWi6wjR?=
 =?us-ascii?Q?E61AM+7ErCYrdm6mPN/kETdQYkdXM7WdOIk1l0aHNJjweeZZAJHzYb8+DeFK?=
 =?us-ascii?Q?LUl+YQVzJj4geXus2e5d1RZEEMZo1tp+XjTDM7SIQjdU8YPbvIbcf/JyPIKs?=
 =?us-ascii?Q?thsDuWhlmvWFT7wVCUGMKgU6SQscM5Cg/HT2M1fYCke6CULbTuQK8iCLjBfi?=
 =?us-ascii?Q?d1OgtMzdqbAq+C53leh3u5TwQSH6ck/nubBLUak7goAxZVPAVv+DEr1Pdbns?=
 =?us-ascii?Q?v9KaS/lGpFXvQkHcB3Atik064rtk27KEMFruuLP9HVEtr4amgUXaMJ0naSZJ?=
 =?us-ascii?Q?FUuj9RWoe3cuNKDIjV3n5iB50SsRBfzSepMFo3ACp2FJEBy5/NG2Wt1bwoU5?=
 =?us-ascii?Q?7ZejhJQZ1Ue4cEd2Q4Mw28cSNEbsR0OUKDe9kDeyIVEGcVpDpCPt084yFDYZ?=
 =?us-ascii?Q?KRQ2NwsMwQXcZbCBNh46xilNWsYcLgX9kxC4vaE1LJdG0TnPLdZRkgnMuUNt?=
 =?us-ascii?Q?sIL4XY+0BuDYY8oAP3as6JemUcFDZ/at9wcO6jqQCP4RhkAPPkKMySPFrGGa?=
 =?us-ascii?Q?Ax4odI6OcYXt3xuc8X7Ox5+3BIIgKva7C9h/HMlqQoqhmGPfTTZtEe7heToS?=
 =?us-ascii?Q?sUtHQI8ihBKZ+ksMAqhGZIIAOqt7IY0g/P1A+Yl9c9bDxzaFkMgiXoapTe8n?=
 =?us-ascii?Q?g7fNeuUv2ipINtkv9oGTKPL36st5MhYPJo/6ApBJfIRiisnaoVDOjTYvWdAu?=
 =?us-ascii?Q?zcRdcL9Q6J0Zq8gqftU7rkwwqD2VZ83lpm13t8/aj/x7yVtYnF1z7Y+NJY3M?=
 =?us-ascii?Q?owk9Tex5VRWFh4tm0uejCeELMdI5e9lc/LOPMDpGVRBpYL3JWB0vSmtkn59E?=
 =?us-ascii?Q?DTK+Zz7yyxD0b8r7RSP1tWh5NSOk/7EJcgJsQCng20w3XFOxNqijhV785x2+?=
 =?us-ascii?Q?ZEj+2VBbl5Grjp9u+Pdc/lgk/+YtfYn31bumPN/VDnwEEnRRcfLmDK0Z4h4f?=
 =?us-ascii?Q?KpT085sTzI45Y3sLpWHa5kH5AL4O5x60B/XVaQiXM7y+sQWByHhnmcooFhqz?=
 =?us-ascii?Q?vRA=3D=3D?=
X-Microsoft-Antispam-Message-Info: oycKWP1QEJHzNDOBW6rXlIZVzyILKg8SEQMdxogXnDnCr8JSY7gpJvB58PUB5BcvaeYpiYlGsBXIl64tQ7E6sFXNhQipS9NPRORAX77Ao3TRkt1xwlFTqDq8JCz17YpvTFa9HeZyenmvUOX4V9xB+MGQBwk8VAsIZSoG3fOTtDwGPHtGr/pJjrvmh5Ldjy4t
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;6:Cfayrf8vJ2e9NzMb2/cUsYk8gIpttJ9Z2pr6CJqpMG4LHXzBlGseR076Dsv7qG0chkJjh2mOrs9OO1fwhNDRm4GW1pZQ2Pu88cVkIVVAlfRYoOUrav2T+yBez6mfgByiZNl6sazBXJRVxJ/cXaanRNccS0HW5nGQpWwwRlBnZ3kHhaI2WYJDpwNFsCyL+ENyc6ebMLUuVfHmfQWx+89o/NOuP6J98x0/RvAa7alNFlSuOZQa6ula+/FktZ/QPfgx23KC5eBBPM9JBs6f0umqBUJhbG7RL+UeE7ozhtzzSLlwBgXtnu60lFLO3PhR2o/jdf2qy2bL4eiDJ2dWTwkWqXMGKBNAwvEAAs1t1nj/7+5+mZFxIdOdM6YDAv6DwVdGeEbF6aSd89J2aT1WTCYRcty34prgpEl22HpUF9DrpKuOP3DsUCM69JKbkOSNdqB1eLghxo/0o5B41eFaUviXvg==;5:Wt5ikKINgNOXNkLSX228cZd+gNEZYL2Zf0UGxrrpp6tBK0Pao73a/1X+gbUhXha7sOi2rMyzLsIhTHf6R2hScwMPs1IJkJZ4IWxHf8QtG5y3EQswky1GDzVcX3f1qoMqX0p1VQML6pc/rKlQ/P542TEdz4Audp4AFiYdZ/cImwY=;24:FgODcjzzWZyRjYPTqG8mo883YW9rYKcns7nZlULTkqe/tGCPqK1CG5BUm1nitoBmMYaSo0SNEvtXkQdfQZQcouL9TXVwehxTpDcaQ6RUsEw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;7:9U9Qr2b9xlyAGROjzZQZKc5LVFl7LdTT7gH3ZpL2E1+SaCFukeIhocY5cAMDnmpVQANneT4NDihBZ1FG0RjypJIuWtyYCMhV/Rp43Ft0mondbCvsxegMtOzXHy2KBtitPLYAh2uM6+P+MkwEf1orhUiGaxN9Yj+KshBp4/kWs2vk4RHzznYdNbchLfbI/JSdbLH3xn4IrOx2fPssPX1uZ02qes7hkuuCNOqPpE3uhZ/BHG0pwF0rXiXkF6VN9wTi;20:fQkswa9+3BoD1rewEovRZy6klGCdqeIZjmRzSBEN0WLViSgkC6c4hU+QJG18iJ3c9Gofg1319nzAQAu0Zs+9tiG8z8J+P6xf4HAhwwwuMkqbVZwWGe5gAP7LfuUm+uA4Ot/4NUbIydJWCNKDFmLjQOcr6q5MnY5KLqqrBKyDuaw=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 17:40:24.5339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f843db12-ece3-4290-214c-08d5901bfe72
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Jonathan and Brian for the help with the proper way to handle
OIDs and existing callers to bsearch_hash(). This patch includes one
commit that Brian sent in the previous discussion (included again here
for completeness).

Derrick Stolee (2):
  packfile: define and use bsearch_pack()
  sha1_name: use bsearch_pack() for abbreviations

brian m. carlson (1):
  sha1_name: use bsearch_hash() for abbreviations

 packfile.c  | 42 ++++++++++++++++++++++++++----------------
 packfile.h  |  8 ++++++++
 sha1_name.c | 28 ++++++----------------------
 3 files changed, 40 insertions(+), 38 deletions(-)


base-commit: 1a750441a7360b29fff7a414649ece1d35acaca6
-- 
2.17.0.rc0

