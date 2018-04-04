Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B60B1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeDDPqP (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 11:46:15 -0400
Received: from mail-cys01nam02on0096.outbound.protection.outlook.com ([104.47.37.96]:10976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751612AbeDDPqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 11:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fdMmh5qJijGAXnCc62EUocYPc4l1nRoYEGu/oOJUtpQ=;
 b=dnlZUdKqSQf9PmDwBfyJCxxyJHkLdcMR7PcDnpJeW2gsq1LrONXbzc4UjY5k93pNBqqKfVbITWWdTPf5C6WDT1ioTDVWvt7w97zQfuwqQSetMX0dR8hZXmH+a/QhyPz8s/M0XFcvrb6uP+LYdrEceAFJhoJxA9pfkKjoKGTJuzI=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Wed, 4 Apr 2018
 15:46:09 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, sbeller@gmail.com,
        larsxschneider@gmail.com, bmwill@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 8/6] commit: use generation numbers for in_merge_bases()
Date:   Wed,  4 Apr 2018 11:45:54 -0400
Message-Id: <20180404154554.140716-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180404154554.140716-1-dstolee@microsoft.com>
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BN6PR22CA0029.namprd22.prod.outlook.com
 (2603:10b6:404:37::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc49b73c-eac6-407f-6b79-08d59a433012
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:lNLoZpKD6Llxp9CuQxdEpiIGDXJl1H1M8WWxSSq6SyjppTu0ettbDFaAWrDHuuOt6mUrdj1O89GgBDZkg+fxEgE2lPTFulvXC4MlQghfpnFPtE47Ba++6GnqwjrkASMViOQTPEI2h355q3IgwxeD1H3ZR2JwIKdxtDpu5sSvrzrkdEa2U/C3raX10n/jJUsiNBrN1omaJFXAikRee4r0ktCouCRKQYsqVbthwfseEHOTgdoIoLJTIvQEiKjgYkJ2;25:PtYUf8jDgBq+9p7K8oCk4zZezM1AYCjHASXL3Rzqv5aJXJzezY8ceYjU7bp361Pc/uq8YJfRJP3RLg/h5Ui7TWoZmOSy+4b5GyOYodFYRUkjYlZ4L9efbL0aZrdfpzL+qa/jDZjsd1TwzXgwrKgVF9bCuenkq24VE/Kq99kzOb1hrp21oZICLtuqh9ZR/VRi9LvxjtjxLmGwWwdG/0GhEIXuOmIMdZ/QFQP335wCnkbDIN3+NMSVjJNtHdw28xmrnrsLyNsVj519u4J/puKLuUXgYt5FiscATYtXJoZVxTbmqcFD7HVoOeMAIunFlZ+RZmXhnsUqzjvolxXmIVbVrA==;31:kfSEx9aPerKigMhcp1n4JPCHYjqpscU9eZnHSbM77dSb+lxHm4Nuc4wfK2Oba1eqe1B8FTZPWh9aadJNF74RhEQmda/UcAy0vQyHO8HqSlPAq4tSyBNaU4LNWG0m/bZrrc0h+2lMAgbPhpCWhCZ4t4SO4ydfADg+gOw31jPOV1L4bRGQ9Kj3ZN0H4Jgc4/F7GqT/hjL3PiGNnP706QItj6mCLclZgVRN14GsGQT300I=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:YVhZaCA+IdpksbgscLQdeHao+nT5p7sfwIryOR2lrZMNpuVmwiXHR6Oww67AiwWmbjmrP7z7/AB1qcTnp/01yXDMOqA4tOOTAnDZDw7Sueg/ATq5HarUlEwv1DBU4/Z2LzhboJgVKuNuFo89R5sYqSrB0XdWTWqczyXmvFLGNWDK+6jdkJtnrxpGYoNJMx7zWlsbyYChCw7/Vk5scmMqIeC/MgBz8L95lJuJ30XQJUhV9l6Y8if5lUitsUU6JdsQRLD0Fi3aRiS/6KxhBubD3v1OTKtDctDs0hMKunp2bRGWJLoukv+MwBXPUczQDU9IFLkzMcEeigVTnFJisRX/MMxFe1+qWGNxXY0v4KLyiFxegFXEBaD0Z/i/GXcBQRHWbtYN/m2xs+1TSE7EhupVx5+63dUVrTPk0yNyfjE5rIgD8K5s1paQaU5haFIMdxxCDaRGyC16XxqkiaXJdC+imQh10zyO+quG5Sqlr/u7WbO5yFvuXO6H/Ldxy6opk4cH;4:GAKpeCt4jWwS9CLYRq8NiUhGzNt3CKYDKK8JycEjg89n2XKxlIXu/vKO+ZJdyqzbJlZDfLyBE/uu04I+uG3QlHYVn8Ez7uq8jGqKV9yWZ5P6IIwES82VKyB0c8nJMLH535VlRRbgA6/jbeGSGW7AvNDlRe7Mwazq3y6U2DgWamYLHOddnapyAyhaZB2W9w7eyQ/155F/xSmDay9+Mz1Kt9j4eRkOlZXTHIfkR63xLcYyYVXT9/nNpamxjQV3rciB5TNoEMhQ8siYLM0Ye/0pJ3cOCTDLIATUwggppJ5k/ULclPc3G7L/GQ/ilVpKPoeChUlaqJVRIkGy5D5wYAYaAuPek4VI8qna3Yc/QmB9E1c=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1011C3F3B931B7089A05254FA1A40@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(199004)(189003)(86612001)(53936002)(2361001)(478600001)(2351001)(105586002)(50466002)(46003)(10290500003)(97736004)(6486002)(2616005)(11346002)(39060400002)(16526019)(186003)(107886003)(5660300001)(48376002)(476003)(4326008)(47776003)(68736007)(1076002)(6666003)(10090500001)(446003)(25786009)(36756003)(7736002)(486006)(6116002)(305945005)(6916009)(106356001)(50226002)(8676002)(8936002)(2906002)(51416003)(7696005)(22452003)(52116002)(52396003)(81156014)(81166006)(86362001)(59450400001)(16586007)(386003)(76176011)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:+0T3dD2vwAhl0A1nmyfYG3lty4XnTuiKoLCCjJp?=
 =?us-ascii?Q?3GR3K6ULWecCLUiBaQu+lLuV7KccleiMRBJIejA3aT2t36mwJkqXJRpPyY/i?=
 =?us-ascii?Q?SWyAKUo8ncaDbba8a3bZcxcYOIQfSrB/2ixJm6qJ8QSCzQSUPyzVhdF/PnlK?=
 =?us-ascii?Q?6RAr332CCYlbc7vWPw9BLPKCEEL+pG2bqo5BIbvhrh5W2F4LU0JUVE+suzNv?=
 =?us-ascii?Q?eA3+BU1yCZj0iYLmq9e2wUq6b1evmaecaI/XBIzw9oCnwmY5UkJbpg6jYrDx?=
 =?us-ascii?Q?zG7L2iioVYtw5iuCvkDhbYzUE9Q82HiFDmC/vnFv1bHexIXibkwhrA6X8cgc?=
 =?us-ascii?Q?TgLHqvv1sdIJ4JSxmho0LLZHwymPQHnMWupFY8l6qizlQVtRfwnguj9nQ70X?=
 =?us-ascii?Q?IXvP/5usn3RQngUqOqW0A9YbL0VUsWjUVG4Wi65qODFKj61jNRUlXEWRB+S7?=
 =?us-ascii?Q?BYkv8AxL+nLCmF9HOycbrR9Ot8zovW7pMV0jmXH36xLzK3Bl1Sl1IpO9j/JI?=
 =?us-ascii?Q?LncIASis52llOikj5C9w3pyhqynQuW8Z6RRulx9k39kooS/ODFkvZ8znJQXP?=
 =?us-ascii?Q?s6mgAXKDjwBt+F4PnUms4o7uTFUw8dnmf/OuUaERryUXrfP05qUFmzSfm1lm?=
 =?us-ascii?Q?PDYxKjE5ykMmGL2EPmWvRpDHe2fcQhuDXE2FFziPImpd5MAj10Uufr0YX1j+?=
 =?us-ascii?Q?EYEfkGoSPUV9e1vBU/hMtZydLNLENzuFTot4QUhgLoPIrbicT8l5cYF9oTVW?=
 =?us-ascii?Q?RGS2Dtf48f3KLL4SVHZ1s7n2wvyHZe74EttZnvQlO2SaGC+98Tm+GqrmYHsf?=
 =?us-ascii?Q?OmsIEnAQjcdibmU5r+9LJAMYCmhCOtu+CGc6GUsMTruPQZ+1bIDTjqc8nbfJ?=
 =?us-ascii?Q?MF58WBfV2wpTvJRu5mtW9bVQfSpEtns62BDTGbf/Kc3+luAOFIuGJYoS5BBk?=
 =?us-ascii?Q?N9zUU3B7PaHhOBBrXE8xm/3a+t2iCkuJoRZbkhMdHzE48n2A43/LJ2Ko5XqC?=
 =?us-ascii?Q?efx/8K2TuMeXFtYu4Ai0KUZvYqubnQVhR8o5RNIn54UtuHljRXSm0SvKNak0?=
 =?us-ascii?Q?IcynieIHtsLDeGmKUuYUJ3VZlgzGS0rnNTsighLhCjvuvOXxaqojFtWQGse6?=
 =?us-ascii?Q?EjmkgfL7e8K2qWdD/yzUBBy5K5AGM1KoetxoWizneFDulXIrw/2E6fZFKUU4?=
 =?us-ascii?Q?CR5No6yM5k4CulkRuHlfphvf2egDm+DtZORHvMdgy0MA6OfL2dALngo4qrfj?=
 =?us-ascii?Q?D1LRBocvkQyhQ2aWoQwaZNz3ldPlXxoHzEs37Hc6H7eQo2678uiCpDicwyMK?=
 =?us-ascii?Q?OFpcFuvWMsUFCe7ezLiCpThoA+tbgH3er8PXlxvK/z9iBW1bL9+4APzzpwET?=
 =?us-ascii?Q?yxAAn8A=3D=3D?=
X-Microsoft-Antispam-Message-Info: yRB6pInjY+oyKcBqLsftrF76jZU1Bk0lqFA0VkfxZofospiUVzkH277vA4Hm1hAaxoS5Zq5JWsFEJNqkY47f5FMj1QRnGDmUN3ly0Wrjx/2GAZJL77pyY4J7ewuIaYOi0M60GIjSwX7O9dyhFybrNjHIiyxU4HDUF0vMaPLICebHCC57awYXXZGXAS/gBz01
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:Vfj/dBY0CfAgR4Ej82zwn8pByxVM19QWakEl/pFGMMD7Hq/q/WtxeHrubq8MOccaMkzlKnA5OQq9gKAW/HFxO+wkNXMyb3vYISwi4wTkA+q3lILYY4ZF09L27UjNbw47PJtuOhh1+o/tTLc1/n1YijBhNkca2MaxBnwnnk2aiApgbxa4mzl041XNKIEKj4R4dEFlck0jpfNLyGynSsfuGD6ei2kk2nHOGnqTOVa2LLJztsSD1icMKiaTRKU98x5LAX5ZpxXKOvTpiCglLcEzh7QhKqgA4IPQj35RBjgtQxO3E+cjOmUl9zElDqHXXIHBtJy3agW/N/IJS9VfPbzU+hC2eSsqvNHxTAxZvdHxuP+37MfRPG8dVDz7uKeQQwqDp5iR2pyBrkcGSruO9L0bfhgMIgJ9LwHT6FJNfs/wOHpxhxyVhYnbwjD1WkeF6a08uRunW75yWkw61xo/+9qgFg==;5:5o/ZxX1LDAB/QS6EhaTSoPjduMid7nMdmt/Qx1H0azN1c0nNRfzzNP9B5ERXLPsbmNroF54VAAsPgx38wTbW6XvnCi29JSjPj94va66WZjORT2iN4156UFfslezyzSK+ho6ayIztyTGuALotxrEy1jXIp553KlIlXHC3O4n/B0Q=;24:rcUwdlXAJJuIVzLShizrdnpmnLYywd4HZzsK1u3QmEvDF0XW2vDK3K7qI9avsgaPJbuQqIMY6nEeDW5fTtJdkvWhx9oaXT0VbP8mYVxu6xM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;7:5ySj/xh3N1mtKmuBhww9ejrzt/JjxxLwSm83qWLECBHVqq+IqNMixJcJ7JH5H89Fyrlyk30z3nfuAxAqMYLgIryiqr9LyAELBLoaqLP8R0C5+b99bKfhUPYOX5tcYONLje+qXYq6BPrIppS/AdPGilNNT6CZ8evn6X3oXHhPToOaPltoEw9QG1aTZ+L0B/LOT80KxGoiKZHwGqpJ0w6RhnuhTIhIeo67aBStZksnl4x1G+4AaA59YHakEUBl2TaE;20:TgD9yU49vk31osDdTZJnaD7S/VCeTM0x7uYj9iKAhd1J8EGJMn02JiQK9j6xFNhycGyFOf9NdyKY2ikdTzqrFZL53RcKLQt03m2JbqIbAXfxF4le/PL3us/pNSFj4M+1V3xb1swBJGN/qGL88fDtcXdAkkaV8+WI528iRECRj0s=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 15:46:09.8574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc49b73c-eac6-407f-6b79-08d59a433012
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The containment algorithm for 'git branch --contains' is different
from that for 'git tag --contains' in that it uses is_descendant_of()
instead of contains_tag_algo(). The expensive portion of the branch
algorithm is computing merge bases.

When a commit-graph file exists with generation numbers computed,
we can avoid this merge-base calculation when the target commit has
a larger generation number than the target commits.

Performance tests were run on a copy of the Linux repository where
HEAD is contained in v4.13 but no earlier tag. Also, all tags were
copied to branches and 'git branch --contains' was tested:

Before: 60.0s
After:   0.4s
Rel %: -99.3%

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 858f4fdbc9..2566cba79f 100644
--- a/commit.c
+++ b/commit.c
@@ -1059,12 +1059,19 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
 {
 	struct commit_list *bases;
 	int ret = 0, i;
+	uint32_t min_generation = GENERATION_NUMBER_UNDEF;
 
 	if (parse_commit(commit))
 		return ret;
-	for (i = 0; i < nr_reference; i++)
+	for (i = 0; i < nr_reference; i++) {
 		if (parse_commit(reference[i]))
 			return ret;
+		if (min_generation > reference[i]->generation)
+			min_generation = reference[i]->generation;
+	}
+
+	if (commit->generation > min_generation)
+		return 0;
 
 	bases = paint_down_to_common(commit, nr_reference, reference);
 	if (commit->object.flags & PARENT2)
-- 
2.17.0.rc0

