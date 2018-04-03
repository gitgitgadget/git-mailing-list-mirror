Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24E51F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeDCQwU (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:52:20 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:45952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752641AbeDCQwO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=a8niD+8DQWd5oYzOF2e+w0d+HV7osL25J8DIycv1Mac=;
 b=mOiM2EFX2KtCESalTOdPwTBHCBOQEBGcrjjtYjHPTNvbhMVSoZfKFrJR+CW37qZOWEKUKrqZJ8b7QMBDeCisH7RZdq2OIJjOkVXN26Iv6X3fYdR68MyFq0ILskX4soVU7KL6gCUaF/UkzBvhunXO7DsllMWuJBbDqo9OK738vAU=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 16:52:09 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 5/6] commit.c: use generation to halt paint walk
Date:   Tue,  3 Apr 2018 12:51:42 -0400
Message-Id: <20180403165143.80661-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03df94ad-9a2e-489b-0a08-08d599833ddf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:q5KEackNuyUByn1cdP3sKx0iMGsyP6IfYMAl8HYxTTzCk4AOH4hJOFHWMdOGcET7M7kW3mqB/As8TVsbXISi2UtSpNERqtL58lihDusujXf6qfJNXyaVrUCftcuQm2uLFalZ/3AS+r+q3qEa7/r6jpzPhjLGRjEVWeRrPRmxejFkLEh3cDzvbT9KO1+5mJCjumj0B+AfYGQXowgUa02IQGhvAUeew7UCwq0v+ixd3F3m4XwbBdY6vdiFlJXg5W9a;25:JYA31pw5UC9qatWLwXAhB6EyxzK6G0oMTTkZU7dd5j9znbqcJ3rPQGG1cB/JdsH++LIF3EJn0N6Py0I95iqfePy1OyfwtnIkse6Q7VE9NwYxoZMkL3A5LfrACLdy4f3S/XlwQ2rJNAfpxvRTsSMqsM1Ok3Y/abZZO55LrDhkp/ZQFsswrZVnnRVcSCkys4lyQ6LN4xTwIQEbIWTwfu3XHXIa7mlEng4A3IG9a9wkGFDRMVwlgZDqhheZR6se8K+U2DYAsm/+5Q//nz5nSDDd4YUqQnViGSxGvQavf3L6VJe00ef+aGcccTrSdd7Derkql0naUpftw4zmKiCDU5Y0Zw==;31:5WqDeu2dtftVYC77iLXSowxqrb61AaLZEACF2VG1XXA1k86Lf8fIRL9nrxLOaxv2SERleroGN1OXrR2BSl+vQefllSB2MrFrfwPIMvO9W6apr3cFxRBh5ktNdNKWfDy1uBEVGc4ek4wwAB0G4i5ljs2D8Bntxw6cEqY4VDmHM0WcCmCgvbISHDUgq9K3IraBl5zWsVZSbO9dZDg2pTOlSn2xoaTAtSR9d5NHS9crqXY=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:iV4l2AppAp4LlqimQ0Asp/j868qKxLvRy9adeyhqSG76n1tkZKqpqmAUjxiGFSjMW5+YJ9/T9hKRuLWD8/nCU6hpirsK/hayXU5kqxDHxfwwuw/ag1PB3EVL4xf6zVkRXe/SxJ42IiuL/kKKkYHMphWD2YjwjWsyb/JY7BWGt2uDKA3/8d9D1UCA5VqtwWEn+rmz4KPZArn03VbZnXJ988iS6mrEP4cw7erYIb8FT1iIvseO4GohipEr0pOzfQfUG5ouQxkj2MF9vEX9vpnFAqa4Bp985K1igjVkLs4VcVWo3iHTWUGkX2a60stnZRuCgsValQoj+uKnum2hAZyh4zahxy3C4rU+ZJ89684eeR3xYVCR+SC0+7ngMfsyjB9qaz9z31p31uoMxb3R6rRHdzcVJgGxhb/rJSzjYAh64uzYJMBOv0KmUjX7stNOZCKd3w7rMYgE0RqZk1bBhHNkc5NdE9Kyn9JTGRF6XnyNMI9fcmIq//lWJOBB9M827bv1;4:k3D/gg9aO8repYt7KpwJGa9YmZJXgQKotumzlMQMEUj7/wArDj03SZxTATiSGVLjYVeGKsw0STq3LSCEZPSjsSEfBaLhAUmMzQQDjyyKOimsJvxQFAAfrotRABX3Ey9NfyeldtwUT4yc1pvveMbURWYUSQnf4eiaKYTduxTariHhpNvop/edi0VhVt7xAWS/bOvKXsNb9zRqaYAVooKTo7TP3UbsNCvoMlsNtDYCFrXYFx/NLyCSfeO4x8auFtpPhpbrR5y3+xMUmEOel108Q2S1dKXuixIggo8LKeMa/l4e4HYPVwB1j6RqR9d7JynEMeapLJ/RxpYYKOi9K9aFHVpBu0rsFhJh94uvxUGVDaMWYhy446s6fF2fZzAgyWt6
X-Microsoft-Antispam-PRVS: <BL0PR2101MB101100385487C1FD181288DEA1A50@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(6666003)(6916009)(105586002)(53936002)(7696005)(52116002)(68736007)(51416003)(76176011)(4326008)(52396003)(1076002)(107886003)(86362001)(386003)(106356001)(59450400001)(39060400002)(6116002)(22452003)(478600001)(86612001)(2906002)(16586007)(316002)(50466002)(2616005)(5660300001)(25786009)(97736004)(81156014)(486005)(486005)(50226002)(186003)(476003)(16526019)(305945005)(81166006)(48376002)(11346002)(8676002)(7736002)(47776003)(46003)(6486002)(446003)(2351001)(2361001)(10290500003)(10090500001)(36756003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:JP2sq9uOB/DVWerWtkCMG67EzCe2yl76LQGnxPp?=
 =?us-ascii?Q?M6yuXJvlbchCdxlqmqXryC2ViT1nkZlamkiJE6V7Iz0bpRmfLAbgz6zwFC3D?=
 =?us-ascii?Q?ksjwghXLgyO5GnbjriCbzfMNtR/NL7zBwgDldnwRSFYiYWfLnZgb+dESXfQZ?=
 =?us-ascii?Q?gRxGTF6Tjn8sc5yc2wzCh8LxdMEg4FErfYWBxS2rw6WZwshqRisyHYON0Dq/?=
 =?us-ascii?Q?VImQkrbfIsevhBHP+u+FWQwLzyCqQDvU6JaAUJVRZczdnysrZzxx5GUgHzsB?=
 =?us-ascii?Q?M3vc93XqtzIO37/wLSda94vh1DexQ6Gj4eP+1iUoAPgyjNOrUJVYOehgd+fu?=
 =?us-ascii?Q?yKOdpirT6mSk59x5WFmznWUtGCdricmpzODfbyGruQmsW8HSRnjLsi/fUB2V?=
 =?us-ascii?Q?vVq/r1Hn4o0BCoahJL4nZkD6Mt8asq4Dvis1GxsTFLDllUWchf6R/PFw75yf?=
 =?us-ascii?Q?iZBJuWvWRbgWrZEomtVrqiR8HLVJooKTW14CYAA+n4QlFM9dXy5eG12XHoxF?=
 =?us-ascii?Q?oCMHmXAN5KuzpHbELd82zYimth86lcYGOlJ72H6Dyr8s14ESNo0etfHRvTMb?=
 =?us-ascii?Q?KbnAFaYwJzssTGGwSNyC/s6y5v08si/Z3SMOKGc4FQGrWmW0qihNW0heAiWT?=
 =?us-ascii?Q?we9z+kOB7P/asTnlnPzesBI59w5g99qHjKKPk2Ke4NnP2AGpKpOgyZggu6rk?=
 =?us-ascii?Q?vYlShFJ5gqnJWRJpCPYqy7KKMU56kwpQdTC5N0wAAoF9CwD3lDyEvx1WNuo4?=
 =?us-ascii?Q?KJ0fjRetgul0LcusnRKlwJxJDFrsO5XHfgQLxUZPgsudpkQEDqPwuiT1qb11?=
 =?us-ascii?Q?PUWq4evoWEyICAKhKQrF560om3sSlv+Q9vpryclqz2B9FnnLHBxG63ZhBdeh?=
 =?us-ascii?Q?3vGIiB3PM66zBvTFzKLEEhI9u2tt7GKH0+Y4n1Ib8tPIcl9cz/lj3nV32P+D?=
 =?us-ascii?Q?Im0eTgcOHLNleH5smFelHG2+DvXd9X1ShsxW02S/FUwRX5RBDK6iajg5czo4?=
 =?us-ascii?Q?3KrhZ+TAkVacjMwjNvQdb6qyGuCYEl2dTEARGE9y2Mk2FqSy6Xg/oMIsYCzx?=
 =?us-ascii?Q?ty9451IZuUVmPbxP5uWxWnlR/MA69n+Ov8A7ZeRktcLLXNGL8XtL7cjK5MG4?=
 =?us-ascii?Q?B4LOIQWj8SJZN1t6rA0kO9/3oqMjTRKEFFUPGOuGxYYQvV98LihaJAPlxbBL?=
 =?us-ascii?Q?AOQYKwvYtIjWrKKJExApsIqeK7G3ewlLDQicmkI7Ftw+2VP6ptFXpcNoDlzq?=
 =?us-ascii?Q?JY2YbJyErKkAE+JFQye8QBMEe2Gaf2lriTQIF0YEtly46fQFB2+g768byleQ?=
 =?us-ascii?Q?tpktLcRA59BccTvnrRFrUuW9GfZoboagZhHTBCMNlhl+5MgsQteBxICnlMj4?=
 =?us-ascii?Q?OtuegPz/4ksfZfzXw4r5Z/IH1h4A=3D?=
X-Microsoft-Antispam-Message-Info: UDjgcBu9ih3s9QyW6eBhhAUEcA2/tRxCd4d5mtSgvOkmsCRBDdkqXCHlODelfACDJodL61PlGyYkTrcL1rRwJxOjpwi+dE03d6t3Zfo55BV8+78L1ipzrVRRbuQcyL/fDaWScKWgP/Q7ju26BqxxLJdTmWcCBuKRfDXXtfYMCZmo/6+LPoR10xgkwwmtxRV5
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:G7Z80qXIUFRjC/7dXv/X7mkLBTNlpqkCUrZJs3ZEiGRc23noGj0xGznt8XzME9sThImvnYa/nLP8MVvo3ldokY98ZapwoH+rKsHjhLH31E1vo6MxsDPO39e7nj0RKS/5JLhTTcSnSr4f3P1EU2Ux1w268S43BOrKXhRZSgma9KlFlhtriHUKLC/cuBAXkeT1yQ3jdeK6PaIg46eAks2nj/y/4el24s9IsKMrT4/5a0qG5IgoS/aFSW1fr8LOo4u1xbVoSdeyqxSmDafLBssP5B7e4480d4q0HhEpqrfxOhACtC0I5Vb638uJFaa2dk52QnlsVbfjZVKprg6gJ2i2cJ3TGMdpgdhqPXK0E9iMPiTb23Kq3/jDOTJ1QxpgMKW+1RtIcUt0MQYt8RVjPS/w3azCJiGZNWj1HdHpHbPKplzdJJINVjCuKQKTVXk1HwX1iC7LtlP/j+dN63KiVzn6Gg==;5:FKD1sWQfgVFPxzpsm4D7V6eDWvCIBK6cPnJdeXv2On0VNfL80I1QeZchxSyrndtXMR1AH7J14e0nKvlafWGK096ccFyUg+RD/wqw4EPlnd7Nr2B2hwNywkCSNQsmQrogGK4q50OUzlI8d8Q6/5l8570yKP37dtD8AuGkR3kF088=;24:jc4rmStqgrUn8o1FbnVKE71d14UK/JF3/7F5uao32eVN4mNKMy0XANaAtJeaeBVmt/0kAmwtIPr/I00KeI/7meNlWs/CdrrzMsdLCmfhuUM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;7:mLylbaRvSYQ57C2RC82rnjBwpmjcVvIMbStwqEPNmSmq5WjsClaXPCp1vX6UW3Ak5Fxta6Ga1AyDpf2YbwIiARhXTWvDulzuWRYZnnwvlGKVNW+5tuK0NWoKUH3HiiE5/B+w37X+fkdanWKFri5mvwNp1aRZp42q0+pZB1TSLDzRlctLN0C5iOU3GxQnLanAjGUMP2uoqfeskWwxC98BwzBowgkEKnrshjQniOXYVcxPH+4hiWAUPYQyAnV4tvjw;20:ZHvst1irWbeboIUMbrSRHD/S6yEwSD5JNHY/jfOWW4oZfiJ4JSDWhzyThJVUVmS+DOlyt7ZY3r7AcxtpOfIRR3dnDsTHwstqi6hed8KGAnNGbiETknNGqp0IhZSB7YkFp0k26464VccFp96exzYQQOEanT5TqGNdiCG/D/nD340=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 16:52:09.8086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03df94ad-9a2e-489b-0a08-08d599833ddf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In paint_down_to_common(), the walk is halted when the queue contains
only stale commits. The queue_has_nonstale() method iterates over the
entire queue looking for a nonstale commit. In a wide commit graph where
the two sides share many commits in common, but have deep sets of
different commits, this method may inspect many elements before finding
a nonstale commit. In the worst case, this can give quadratic
performance in paint_down_to_common().

Convert queue_has_nonstale() to use generation numbers for an O(1)
termination condition. To properly take advantage of this condition,
track the minimum generation number of a commit that enters the queue
with nonstale status.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 95ae7e13a3..858f4fdbc9 100644
--- a/commit.c
+++ b/commit.c
@@ -776,14 +776,22 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 
 static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
 
-static int queue_has_nonstale(struct prio_queue *queue)
+static int queue_has_nonstale(struct prio_queue *queue, uint32_t min_gen)
 {
-	int i;
-	for (i = 0; i < queue->nr; i++) {
-		struct commit *commit = queue->array[i].data;
-		if (!(commit->object.flags & STALE))
-			return 1;
+	if (min_gen != GENERATION_NUMBER_UNDEF) {
+		if (queue->nr > 0) {
+			struct commit *commit = queue->array[0].data;
+			return commit->generation >= min_gen;
+		}
+	} else {
+		int i;
+		for (i = 0; i < queue->nr; i++) {
+			struct commit *commit = queue->array[i].data;
+			if (!(commit->object.flags & STALE))
+				return 1;
+		}
 	}
+
 	return 0;
 }
 
@@ -793,6 +801,8 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result = NULL;
 	int i;
+	uint32_t last_gen = GENERATION_NUMBER_UNDEF;
+	uint32_t min_nonstale_gen = GENERATION_NUMBER_UNDEF;
 
 	one->object.flags |= PARENT1;
 	if (!n) {
@@ -800,17 +810,26 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 		return result;
 	}
 	prio_queue_put(&queue, one);
+	if (one->generation < min_nonstale_gen)
+		min_nonstale_gen = one->generation;
 
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
 		prio_queue_put(&queue, twos[i]);
+		if (twos[i]->generation < min_nonstale_gen)
+			min_nonstale_gen = twos[i]->generation;
 	}
 
-	while (queue_has_nonstale(&queue)) {
+	while (queue_has_nonstale(&queue, min_nonstale_gen)) {
 		struct commit *commit = prio_queue_get(&queue);
 		struct commit_list *parents;
 		int flags;
 
+		if (commit->generation > last_gen)
+			BUG("bad generation skip");
+
+		last_gen = commit->generation;
+
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags == (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
@@ -830,6 +849,10 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
 				return NULL;
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
+
+			if (!(flags & STALE) &&
+			    p->generation < min_nonstale_gen)
+				min_nonstale_gen = p->generation;
 		}
 	}
 
-- 
2.17.0.rc0

