Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4AE1F42D
	for <e@80x24.org>; Wed,  4 Apr 2018 15:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeDDPqK (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 11:46:10 -0400
Received: from mail-sn1nam01on0110.outbound.protection.outlook.com ([104.47.32.110]:55376
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751685AbeDDPqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 11:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oIDb6ZCaYA9kH25YRle/bUsPtYPvOBz04IAxINTWIxM=;
 b=Dtr5m+73/imp4FbiQN4fyplz3tY5YlSYpzt9LLTKJRCqIXw2DbFYy+po60g1i9x8XZ0Y2PQaeerREGUiahLgTj/LcXIL2uEgPwKinNqiTb/hOr7S0x5EeZKxihVDdJ5K/FGwypzAMPFdBH/y3x/sf5Zf2r+UcYmTMc4s8h+nnVg=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Wed, 4 Apr 2018
 15:46:06 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, sbeller@gmail.com,
        larsxschneider@gmail.com, bmwill@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 7/6] ref-filter: use generation number for --contains
Date:   Wed,  4 Apr 2018 11:45:53 -0400
Message-Id: <20180404154554.140716-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403190500.GA10930@sigill.intra.peff.net>
References: <20180403190500.GA10930@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BN6PR22CA0029.namprd22.prod.outlook.com
 (2603:10b6:404:37::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92b2d976-f7c0-40f4-93b9-08d59a432e35
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:UruaoPnLbjeHfIi1kAOWQbCGJxBKVLdOuMJRGs6S99g0hSRg+t+96DzTy7pPfJvbLD7JLUx39dG44FEQSAdj7Wltrjk33AdWOQL9x5+dieot+9E7xMy3TNmYxiwBFUmKH8oTk7WRGo607Me7h/Vwc8rz/ZlnXdYZnbp8bIQtHb18RqWxz2v7sT2UeU7krJqTgUWtHaXApo3A3fxQMhNy5L1HyDLn9nVF7YFIPsCuAVHLHUSBGMJOmZ2IwIrQN1g3;25:i+XE2M2uCtPiLVB6X6p1QtMXWpvy2AKD6FgBda0MWWWA0lrDwKsyxgrFW5Vgmv9H05M/wqKFn/jJaFulXnsghiSekGujJB1XItTf81NqQmSt+WQdz9zmgdpdNZK/cXCBRZX6APzyqSRTaqT/7VVommV4AY8IaivdMXB5EofnjzwuMls1otTDDlfT73FDSAPrH0xtFS/Ux6guq9hx+JZpxjWOwG//8ulhmfxkqCHNgTXQRCACzhKudjug6ZlE/fOx7tXvQr72CobqV94Y8N/6/s8APLwumAoXimJMMJR6TwUmwMrZqgmNT5Q8Si4cL0sVdJt6xFxQv4VTAUUHrkQdFA==;31:9IMAZ9AYew3pPuYLC2Wv27kKt24on7c+XnERATRmzVLet2V6gN5IoWHuocOPV26nMgM6i3wVY/oHK/jq2GbWOKLVrqK2Wvhny31dANFenHjstT51Lecoxsab+nSWzVBwZ/A0SG8LcKVQ0nTdFV7kHeIB0YT3NN3C5FNuKMRFM5SdzGc9PhwrS3u48K+esIgVjGf+JMv1HXTuBzvt3Oobre6DDk+3RePI+AwJmKBL4wk=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:jbQ4N/IvdVhgB/4LjYZOg3I42qNOJeR7ucGJCMZhU1O4w+7gdCZcqJv3wee4dETSSJvSVsjqBcmsLqmYVoySkZZKm+UPAiAfAc347w3NHFO1qvZTp2Gelss7ybX98mcgHLZHGdjAf1qKG63JmeA7Kul+cGYE+zLSNVlTqECmONb4j0ZAyZolyEoE8Oae9vxi00fq4bEcX+FNx5AvKE2Z2a5FE/9E3Mx3YIkLw72/kYjss8cjFkZqJtnSP6GBercFVjOzFpL7lHVomKlkTDLYQIqBGwZYWa7nlV51SCHsxG4wNbKUAQTsB5xspxGfFLXdb6xMr07utYiBLZcRwX1WHYonH2ksabMMFAAak5jOY6HazfuwsQhLInAB/1tytbizqAwpUMm5B+LbyVIkkWu3vRdjnXfMo2DLL/XeBtaXe+IZTrA/HUdVfbrexboBm9SqLYS9hHcxNyFpb1I2n+TUfW6rGWfl1rHmlwYC1iyfAkWdP6SANqa+pTzx7pG7p0cN;4:WXsU2O5O/6+esyplYw0jusARLZfv3zYWEAXI2sRXp2GVmHxA9psTywKzMN9mkmVPYVr74XiyO70gGbed6bF4k/UicPIE0Q40zpd/Pz9mU9Db3J2WUMOH6tpLCgaA8eW1YGuK7EZjnLZzAr5SjMX8R8KAgQ81/8TbZZgTCgggxY+f4nbPtPvsF+7LITO0uGCSb3aI1SMrTg3IZQzm/oe14QicYKhhnCBVQ2n5lL5kkC4RFuwAVaxZOPvddUJ7EYc21nr5sCb0+jm2hlBamqS9556QvyH+1sQ9ZxhMniUHK+JZecA5uDdClwpJgC8XCfdhnhcC9Ocv+iFpRYvvF2DAOHcDn1bP0bpV63cYNPO1xSA=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1011737278498907A85050B0A1A40@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(199004)(189003)(86612001)(53936002)(2361001)(478600001)(2351001)(105586002)(50466002)(46003)(10290500003)(97736004)(6486002)(2616005)(11346002)(39060400002)(16526019)(186003)(107886003)(5660300001)(48376002)(476003)(4326008)(47776003)(68736007)(1076002)(6666003)(10090500001)(446003)(25786009)(36756003)(7736002)(486006)(6116002)(305945005)(6916009)(106356001)(50226002)(8676002)(8936002)(2906002)(51416003)(7696005)(22452003)(52116002)(52396003)(81156014)(81166006)(86362001)(575784001)(16586007)(386003)(76176011)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:5cSelhZKYItBboIHv3FUP2pmtzz/OcXXLmar+m5?=
 =?us-ascii?Q?afK0hZQ8hayWq69w2xr73TRg4nA2tTv99D3O5+9dbdYpPuyfAids/3mVTGze?=
 =?us-ascii?Q?HZ5x9Rd8exYGP8Ed8gJP4+9Hne1zd0lStPcajhGOlXlrR77wFIFfjYdHnLSd?=
 =?us-ascii?Q?XgqfQe3Z5OPbo7QK/teX7botnRqDeZnTv63D+/SdZKKK8lOBcBcZJ7YSFutI?=
 =?us-ascii?Q?9QOC4gmRx7vPo0IvCsVDMqLsSkZ1p+puv6KOF79sniqQfoy59+9j4qFzw2VR?=
 =?us-ascii?Q?lk97t59515es1SGRYxgdbWAOSevMW/FFMvtN/x/7T4+KMZFz8rAQ1f/1FCAp?=
 =?us-ascii?Q?ncs+pny9zz6iLad8DbMtddPe+B/zYZJTA9/b91SRgcvRXChNRNg7h543X61t?=
 =?us-ascii?Q?HDT5mPtSGUb92E62DKFnDxIypsIbD/+/FAa6D3VUQT34oki0mnd8ke2lLe36?=
 =?us-ascii?Q?+GtF2yUnWInVNzX9Fd1kwfskCz2Av+6CpY35WnTg34XwdftNbifd2EMiRRvo?=
 =?us-ascii?Q?pn/prkzdK0IvJgLn1nxnSM3j8pm7/knRmARv8NaK6FHhw/QeBiT7LnOtDsmk?=
 =?us-ascii?Q?vbk5Wpo9KTy2B9nmKWuC1OHoSTzUbnckYJyY9meZISLc9jGEuAIp6YGV43Tl?=
 =?us-ascii?Q?0UHNY+UUQb3gj5hDLzLDolLJ4udLk7GPCvza7fHrvdHz3xGIw5InQRXtTMLW?=
 =?us-ascii?Q?WQvfSf1WEYuPE+0WApdajOJzAEgFkyTI+EVHWBVG11r8ekgRMPw/eBc+ixI1?=
 =?us-ascii?Q?Gu+UtFp+Ta+cvgKdmpwWbcnAJlISLztPToveV3oviwOS4mnIkwBHoXvag0pO?=
 =?us-ascii?Q?oTXu3TACoYGBMRVM5RlkYO4oigEreecUtjQJUFeUNBEy194Lejvn7oCNUq1o?=
 =?us-ascii?Q?zibNRvGq6J6Kb6jln7XTx8sfThrLtljg3wIQ0hi94kV9oLGuTktONZVmvGDP?=
 =?us-ascii?Q?tI/vUuuhSpodpPDT+bSo3xE31NJLDt+9b6FWY2AfCabU8tbgC3oCMvJKZUb3?=
 =?us-ascii?Q?K6t435pwgY7XH4BK/qRu69Fju18Ct9bndoeSnq5pUoz7lTb2oUtBRWItFBqY?=
 =?us-ascii?Q?p0nbANrRfKaj951jW1XaOoqu9GPOhQj/lqzSgwyveLDsGSFwOJnz2hR/UCT4?=
 =?us-ascii?Q?bKOc2Pl6kgz83sogdqlBeMn0RWGSYVbNzHx4By2ykHqaM9KgvyKQ4PHVHLyl?=
 =?us-ascii?Q?QElRHno3pNrPLlAFnJ8O7LDHlSPFMSl56ITLVLxEicpLkajSXBeF0Mkq27N0?=
 =?us-ascii?Q?6XH5rJyxRAJ05jb1g19RLB+xxxSegMVJn2Rwxshgobes4k4eAo8yxIDegwz0?=
 =?us-ascii?Q?Ma1w/qmeKGWorbZzHrmb0VRU1IlxJ1Ox500jou6XuxUat+dd3wVTNUIfcduU?=
 =?us-ascii?Q?p6d35gQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: ruIv4T79ckVJ5E9HX380w51o4e0BiYSlKn1TFgsDQSVm/oQJPi0P2Dk/HuVuRMFSH7qtsg5vXDUX9QvFfTN2KbRjbh9EI0f2km0xsbfbBpd9H9/1JcKZ4M10a1hcQqynqB4m+K0W8ntG7NOHqVisTTSjb3A36h2upKHAZCwqdldvTGaU8Fa7zehfq87b5wKe
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:INImiPTVWYAVy5WnYLNCLV23DULKZ3fYTM6RFCdkkrsBGtFQKv3cifZv4aMiEmeKHsYeB5Uf9t2XARrcO85MwbvIN7lDova3al6JmW4SGViDt/Z8xlds5jUmrHup66zC6qS3OSyP0M0konzf2kj5mhWOb001CokGMuLemxweZyNCUGdGjutgys12MFbCX15m6Qhbn2bzD3MRTPM6iYeLP9aVvD9aCKVJYXcdEpZM6Qh6qMMrAY3sdeGCsWN1LxuUNC0uCHmanDOsHsV988mQu/qbCg8kryu7Dl+pA6BbA/tJYGEl90zRLFOa4R6EG41YTv7fz+CVEXxeqXgsxpcVsSRprjkGH4id9n7Qp3jDkyLTSmCGLyS+G/H0evROR0hc5QEmIumshsy8NRnVYkEIP/E6BmCPgpNH792Im16pKC9rUqy1mFoHhEZ8bTu/WNTNH6cTEQz8Sk45GD0v8GexWA==;5:gnE+dnzUbgiD4+yllS280jDmtgCCNp7eJsxG+JpahKrGjfgyTg8ptDwT7JTxx+Lt/uM2g2zyUPb0s6Q+7sMnYkZ+WB/RB+hHXmzI/xiLMo0T5bFF5n/WaW1tbzShGRjHTOY77Yg7vPpEvKe99eDTA/iFgHsRTLFBPVpHzkK4Uko=;24:XseeBftPk4dstoelt9zwEo7+ew2Ys2gTsC/ngDevJYb/q9NshOBWvrNYf87k/LIokqBJslVWfOdgHlqhl++z/oCCSgnRKVuY9TTNrCHl0Hw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;7:HviFUdWX/KHvV/8NViOP7VLUhFU8ldeFqgsr+w+5/SmIqeGVC331mh5paATmB67BFBm8rJqexEExyL9qkQVXo2jze6d3kxZEglkFr1aouX21bkmei5t2dmarbrJXvFh5/hnF9+Bnl6/VD4mzJHZ9tiMiFijk11ifz2Sm/6LElsVabm71dPar7e7GqFQTfxAQATqOFafjZYrK1yzcrtSMs1M5U9g1l3y+wdfap7QiSZKluFx8vUe0YmjcoKXdQKr6;20:9YLN07ubDCoedswtMDxGM9t7jvISMRmkmAsQkkKkJOCRzhD9JaTH3W8Lxx0zr6b5aeRR3do9cZA6MF2clPiq2dshVUQUFYsCirkdTdWS+TJOP6ZyY+MN7tUQ/XcmtZX/tjWgCSTmJ7nS2V3Yd+EiNfOo/ogHrzqDHsmr8n4mgNI=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 15:46:06.8105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b2d976-f7c0-40f4-93b9-08d59a432e35
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A commit A can reach a commit B only if the generation number of A
is strictly larger than the generation number of B. This condition
allows significantly short-circuiting commit-graph walks.

Use generation number for '--contains' type queries.

On a copy of the Linux repository where HEAD is containd in v4.13
but no earlier tag, the command 'git tag --contains HEAD' had the
following peformance improvement:

Before: 0.81s
After:  0.04s
Rel %:  -95%

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 ref-filter.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216a..b147b1d0ee 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1584,7 +1584,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
  */
 static enum contains_result contains_test(struct commit *candidate,
 					  const struct commit_list *want,
-					  struct contains_cache *cache)
+					  struct contains_cache *cache,
+					  uint32_t cutoff)
 {
 	enum contains_result *cached = contains_cache_at(cache, candidate);
 
@@ -1598,8 +1599,11 @@ static enum contains_result contains_test(struct commit *candidate,
 		return CONTAINS_YES;
 	}
 
-	/* Otherwise, we don't know; prepare to recurse */
 	parse_commit_or_die(candidate);
+
+	if (candidate->generation < cutoff)
+		return CONTAINS_NO;
+
 	return CONTAINS_UNKNOWN;
 }
 
@@ -1615,8 +1619,20 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 					      struct contains_cache *cache)
 {
 	struct contains_stack contains_stack = { 0, 0, NULL };
-	enum contains_result result = contains_test(candidate, want, cache);
+	enum contains_result result;
+	uint32_t cutoff = GENERATION_NUMBER_UNDEF;
+	const struct commit_list *p;
+
+	for (p = want; p; p = p->next) {
+		struct commit *c = p->item;
+		parse_commit_or_die(c);
+		if (c->generation < cutoff)
+			cutoff = c->generation;
+	}
+	if (cutoff == GENERATION_NUMBER_UNDEF)
+		cutoff = GENERATION_NUMBER_NONE;
 
+	result = contains_test(candidate, want, cache, cutoff);
 	if (result != CONTAINS_UNKNOWN)
 		return result;
 
@@ -1634,7 +1650,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		 * If we just popped the stack, parents->item has been marked,
 		 * therefore contains_test will return a meaningful yes/no.
 		 */
-		else switch (contains_test(parents->item, want, cache)) {
+		else switch (contains_test(parents->item, want, cache, cutoff)) {
 		case CONTAINS_YES:
 			*contains_cache_at(cache, commit) = CONTAINS_YES;
 			contains_stack.nr--;
@@ -1648,7 +1664,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		}
 	}
 	free(contains_stack.contains_stack);
-	return contains_test(candidate, want, cache);
+	return contains_test(candidate, want, cache, cutoff);
 }
 
 static int commit_contains(struct ref_filter *filter, struct commit *commit,
-- 
2.17.0.rc0

