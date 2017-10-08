Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6431FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 18:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbdJHSuH (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 14:50:07 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:22725
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753543AbdJHSuE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 14:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tFiP2ogzdjcBSCs0MjGOLZzA7LHuEdBJcecFKPdNTtQ=;
 b=bijRibkOko/vR1WDnNHOsNtkQkk/K5GctujWOqeN73p0e0aOhvp3j3aZVc18ifgOMNxpESQWN57lKpdfS8X0XFXHU+Ktz49XTUuAZnROCZghQLlFGsWb9o4V6OkCIkHgsBlOw836t1PcoZClpLwuSmRk1YGdgdWcvUfDmmiypQU=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 SN4PR2101MB0734.namprd21.prod.outlook.com (2603:10b6:803:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Sun, 8 Oct
 2017 18:50:00 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 4/4] sha1_name: minimize OID comparisons during disambiguation
Date:   Sun,  8 Oct 2017 14:49:42 -0400
Message-Id: <20171008184942.69444-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20171008184942.69444-1-dstolee@microsoft.com>
References: <20171008184942.69444-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:404:10a::20) To SN4PR2101MB0734.namprd21.prod.outlook.com
 (2603:10b6:803:51::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b6bab67-3b39-4060-3408-08d50e7d61b5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR2101MB0734;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;3:GiN4/J1asNRCXYF+jaAT8LwBLe2jvYQag0fNnXk/TJcQ4toJxYxFChYO+4/8Ld1xtb02q4g0yNDlBzc6X+xQI9XPMuUakESsQM0ayTEiEfVS/6ErxuOmbP87pdrtzhJurnulJPh3JhSTnY3tFa8BtKHGyVFZiPr70JcxS/X9+8/fYlcrJyIsvJDgmk3vvQ205wB/Ir8NMe2IUKYDNGi8dI2kctFvGkmmhm9dEue6c1oHjKemkef0/C9dKVAmg58G;25:lrvaCdcXrKtkDGA26Qjn/hPtYBnlWnVzhGUcpB1MOFpdpF4FzRt/YdZY2lQOYc+HBsnmPUpS2lBJZZF/GZ8WN3GLg7vvEguHhbuXq3KL21kGiHKMPNALLrDFNXx+z7zYu7iAXRDzmHpWE16Aua9hFjfMwwEDbkKgsV5pPPLJz2Eo1juOxjtNpRWcxAv25MD/s+w3FEtaLKoo1N2CXl+VHIT18qKPhFbIiCpIMX4OWkBDPcRhsWO91UXqs/iI5+1Dk3jHzh226KdEvk90sTFhqPl0Znrnv3cl4FckI8foxPS3dXB42CiftgITPbPpkelj99Wy0ii891/ije1MjThbvA==;31:mHjBGrGODuK+RY6+Bup3yi7PzFl2cyAAhf4VKPHTP0rO8eJWOkI/wYeY0NyCIKjtOPA4pq1L+kHksM1H+HGUhKSPHBSO3s3DW4ql4xniZFJYH6EX541VZ7+j4Gc4qSpiY/IBwnJVoTEaM/G5Kz3TEQiSLRJ7ds1T+Cz34vkrr1E88bFTcxcXA9NV1OAQfAVv32/G8WLO2xB+Z2YznspoIVJ9KBw2VjPig5yfR7CxMrc=
X-MS-TrafficTypeDiagnostic: SN4PR2101MB0734:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;20:V66XJGEtGtHgb/W4xPNf5v9s5E08dtXp9nEObrjqMvNpYuzbpouIobVSsJHNwK05kmZCS/qH+bwIgbTYz9M8Uy6UsVAAV7WV0HMyGA/7/NgfN3Mc3akrwC50SZjqOsS4Ynsen6teZF0oTkmiNal3aTyzAML9TaZNhKeL2pAYznwn0f+OAQ1WWZlb4Hf+j7Bxib7ucH2qoMQB3MTbq7oTr0ud306IlIUUyyiFRtpQsADn9cm1NGCfh2TYf5OpJxJVw2gAAH6T/kPxo/sAAEg6eDuR3iYPff4Rqw7WU/9Sq58BPTT1vuBAHgsv5/OVPgYIIkA0D/w6mEHo1pnFLWLDdb2HxeaR39QfKoJ6L5Jeqh6R/KHqaGa8PsiwrFycUx4lRmc+0L0qzpXNhUtGAyLy7qqWbVRh5oRLpf9TWmYDQbS5yw19FhdmMKSWogMY03YSJSBCFAv0+XxUr0YpfO4QThaursf51D2rRkOA1zVSumIALxt+aijY45nj9VMdJztI;4:nZF+QLYShbGikJFr3wRxHz9OBXgiqJFr9Wyl5zYzuHsdrIdhOBBSzH2Vcw0/2n2+HdRFMw6lPC4G0aePcurABchtGlfP69NbnqcEoLUt9ROgq4wgN47DNl0wpS92AwN6z80tVzVmXl3uV7RswJ82IZmUEqQDWrhOa/u7sSmr3mrLGJNT0Su3OIRmjIqd0+MNtarKaZZf3bp/C8AfEZJQ3Q6X+Jw3YHobMRqKmQQVftm7V1E92BKEtXub1+ab0zywbP717BDGsqDBxMcTnt82zioaDfYzXzdZQhDRd44JMdM=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN4PR2101MB0734271F4C7A77434ABAA9ECA1770@SN4PR2101MB0734.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(12181511122)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123562025)(20161123560025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR2101MB0734;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR2101MB0734;
X-Forefront-PRVS: 0454444834
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(346002)(39860400002)(47760400005)(199003)(43544003)(189002)(6116002)(6666003)(33646002)(2361001)(81166006)(81156014)(47776003)(6916009)(8936002)(2950100002)(50226002)(8676002)(97736004)(48376002)(50466002)(2351001)(1076002)(22452003)(10090500001)(189998001)(25786009)(16586007)(86612001)(53936002)(316002)(4326008)(5003940100001)(36756003)(39060400002)(107886003)(68736007)(6486002)(106356001)(10290500003)(5660300001)(76176999)(2906002)(8656003)(105586002)(86362001)(50986999)(478600001)(101416001)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0734;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR2101MB0734;23:pw5epxvbSMVdDvSM8WKJxfqz2Bf997ihNMSofYs?=
 =?us-ascii?Q?ZUqojnDPikCphVCircwzSezafTOvS54VKdYrC94+PwYFhb2TdHa71PeZ/EQ7?=
 =?us-ascii?Q?Z/x+MAIDFKW3pUuJmHWbYakvgyP1E+0h7T496aH/TDPkQaU3BFjly9oH8cj/?=
 =?us-ascii?Q?aCfIum6MJdMBNYi2eQ2RHl4ZuYr48ypj0wbYpsfQ1M+SIf5CN3EJFoSQG9kx?=
 =?us-ascii?Q?humOZ4SnQpykRtH1YTFHvCvsKd5VyjXbcITB5zjZirXsVqBoIy6qVuLl3Yrm?=
 =?us-ascii?Q?6y9GQQrR3Bk+VhIULsjdPRws8gJ64myWIxSi5WNIllN2af3PxMwfpCu3iSBx?=
 =?us-ascii?Q?sLsmjtJybTALUQ71lOZFsK+M+Szl7tTp+1YgCSoB3F/b4qmtRiImkk1X2kLz?=
 =?us-ascii?Q?F5ZWUHTyCrBVZTb+aTTcDJ5Y7AWi9cag0J8J5eod7fWeQX8n2zpjIvks4tq9?=
 =?us-ascii?Q?dFvXSFkB0pV1QuqOcGWW2wsa7e+PFOPwdlJGI8C7qOwNxxcOVonJvXOaJper?=
 =?us-ascii?Q?Py3fo2jLQBtn3p8SmhA8HMlodkmPdJlPsjOR/pB1dGo168r22zSTS22Vyf0D?=
 =?us-ascii?Q?fOd5lNEia7ZwIi+IsU9eYzt80JSfJ96cibOfmvMoaQVlPDXXBMKnmAGb4hYM?=
 =?us-ascii?Q?9dZMeP339oSaV8Oaou44Ib9R7mtNeNPqsv+kbi4J6NXpYxs6187lIGSkIVBJ?=
 =?us-ascii?Q?OZkP9xxzarPiIH+/uZOOOv0OUgt4bZHT6ZsYiRpY0TiHmoP9k0hHYOYwq+5V?=
 =?us-ascii?Q?noaNHxZliXWFIl6UTNGJaX2H0buZCcTahYFZyHYYgb9+kVOGZejnK3HfKZJW?=
 =?us-ascii?Q?kUANbTim9HhzadOCz5aHF4HjCiRh+edH2TNon6MpjABGuPQxRjK9flWxqVcI?=
 =?us-ascii?Q?/DsCWH90y1phSa9W1x3wtfOKZB9ntUJ3K4D8IW6GiTsaEWgfakQ96DQe49Ae?=
 =?us-ascii?Q?PRHVFKOVlY+E5rtcwXTGRPsNwyRYT/bWYPXAWBSs8a8iiDzJyxlc7+IauWhg?=
 =?us-ascii?Q?YKam5cdg6Go44llQgHFNbh9Oafp9SLvs8eQnK/TyoIcmGAjCDYeEBz9AMssj?=
 =?us-ascii?Q?coNomXy4XK9ytcPdNExgGzz6/ex7bPXTa7RwuQGfR5r3cwEcUkN7+bNoc50Y?=
 =?us-ascii?Q?R0za5geR6zDYV/61Rs9wBXYmRsLIUYjF15mO/LprMDrTVJcWbiYel4GiL3jt?=
 =?us-ascii?Q?Rm37P0pgr66nV/qiAHWQ0Ck3/N+BeYxtQnYKCJLLMRy1SL/TshHhAR7gGvIf?=
 =?us-ascii?Q?99Qw0eoQF7GwNdGexgtYGRvktBzMIqp+rdNyOxPH2?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;6:TAucHuq04CaDpR1w2APgXA7OspXSDIoY8O0Dy/RzzSL+SWs0j7Uk6lvaheq5deaBEhiIWKbC4hHjGWF4SztSBAYEgk+0QSq2odT6pO1oYcBqIJ+/VEYC+4OfzH1ZOYqBnba99ELpVus0DislmrxlArOguK7hdVGRa0bSEMOrioE6SftCCLEpLYErlNKtp4oN3/ZQSSGpxL+u9RiTxxIZouFn/sMxvVD7NnQov0iVflfyouUeLYLpcX7+BVDcMfQoORh9R8ORC/4CDgMGPv70WHTy/fisIIR/hul6cvHRaH0ZpsoLnBkt5xQXkgEpD77c1aA83PqD+kzNN0cds9CD6w==;5:RN30acGA9RlMf0XjpiuEoSqp8vFB7Sh85ZZzTwu5kzKQCV04RoHOMNFOB6x3UTl9my3E/MoC6AJw5GmAI9t9rC+1/JRXSV5Qm1WG4fs/xZh1PvSsH/6nK9O0fqn7idfz1TtACzuCkwMJmtw/OirO5A==;24:tViByAsx6aD7ca4XBFdcXhBMUCXeYOO2oBBSTTT7jJurM7Vy+bQVJVfIeYminAiwKhzJ5bDZKWh363Ln/R5gSPUJ3eW6yuNbWY+PVaNkV3Y=;7:MnlSLChvXMcophwQHGfMzG8qTgheXIjgGuNZKXPdgnNzxq40teW2JGIqCOcNk5mXTn9qyJIbotT1JsHJVtLonmYdnfDsuXASqhPfs2BNx56CCijO/WBlGmAqK2LVh4G+2rAyACPhDUpxxTQa0jL/hQAQhO6ygZJ52g82XX/n0huZc1zQiQIippwXC5MfYF2GIZgYGrNnI1QWJ+FkGogVYqWJ1CLpeyaWlOrIoSSsnV8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2017 18:50:00.9978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6bab67-3b39-4060-3408-08d50e7d61b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minimize OID comparisons during disambiguatiosn of packfile OIDs.

Teach git to use binary search with the full OID to find the object's
position (or insertion position, if not present) in the pack-index.
The object before and immediately after (or the one at the insertion
position) give the maximum common prefix.  No subsequent linear search
is required.

Take care of which two to inspect, in case the object id exists in the
packfile.

If the input to find_unique_abbrev_r() is a partial prefix, then the
OID used for the binary search is padded with zeroes so the object will
not exist in the repo (with high probability) and the same logic
applies.

This commit completes a series of three changes to OID abbreviation
code, and the overall change can be seen using standard commands for
large repos. Below we report performance statistics for perf test 4211.6
from p4211-line-log.sh using three copies of the Linux repo:

| Packs | Loose  | HEAD~3   | HEAD     | Rel%  |
|-------|--------|----------|----------|-------|
|  1    |      0 |  41.27 s |  38.93 s | -4.8% |
| 24    |      0 |  98.04 s |  91.35 s | -5.7% |
| 23    | 323952 | 117.78 s | 112.18 s | -4.8% |

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 5081aeb71..49ba67955 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -478,6 +478,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
+	const unsigned char *hash;
 };
 
 static inline char get_hex_char_from_oid(const struct object_id *oid,
@@ -505,6 +506,65 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static void find_abbrev_len_for_pack(struct packed_git *p,
+				     struct min_abbrev_data *mad)
+{
+	int match = 0;
+	uint32_t num, last, first = 0;
+	struct object_id oid;
+
+	open_pack_index(p);
+	num = p->num_objects;
+	last = num;
+	while (first < last) {
+		uint32_t mid = first + (last - first) / 2;
+		const unsigned char *current;
+		int cmp;
+
+		current = nth_packed_object_sha1(p, mid);
+		cmp = hashcmp(mad->hash, current);
+		if (!cmp) {
+			match = 1;
+			first = mid;
+			break;
+		}
+		if (cmp > 0) {
+			first = mid + 1;
+			continue;
+		}
+		last = mid;
+	}
+
+	/*
+	 * first is now the position in the packfile where we would insert
+	 * mad->hash if it does not exist (or the position of mad->hash if
+	 * it does exist). Hence, we consider a maximum of three objects
+	 * nearby for the abbreviation length.
+	 */
+	mad->init_len = 0;
+	if (!match) {
+		nth_packed_object_oid(&oid, p, first);
+		extend_abbrev_len(&oid, mad);
+	} else if (first < num - 1) {
+		nth_packed_object_oid(&oid, p, first + 1);
+		extend_abbrev_len(&oid, mad);
+	}
+	if (first > 0) {
+		nth_packed_object_oid(&oid, p, first - 1);
+		extend_abbrev_len(&oid, mad);
+	}
+	mad->init_len = mad->cur_len;
+}
+
+static void find_abbrev_len_packed(struct min_abbrev_data *mad)
+{
+	struct packed_git *p;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next)
+		find_abbrev_len_for_pack(p, mad);
+}
+
 int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 {
 	struct disambiguate_state ds;
@@ -536,19 +596,21 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
 
-	if (init_object_disambiguation(hex, len, &ds) < 0)
-		return -1;
-
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
+	mad.hash = sha1;
+
+	find_abbrev_len_packed(&mad);
+
+	if (init_object_disambiguation(hex, mad.cur_len, &ds) < 0)
+		return -1;
 
 	ds.fn = extend_abbrev_len;
 	ds.always_call_fn = 1;
 	ds.cb_data = (void*)&mad;
 
 	find_short_object_filename(&ds);
-	find_short_packed_object(&ds);
 	(void)finish_object_disambiguation(&ds, &oid_ret);
 
 	hex[mad.cur_len] = 0;
-- 
2.14.1.538.g56ec8fc98.dirty

