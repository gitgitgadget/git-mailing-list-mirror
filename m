Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF9E1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeCVRkj (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:40:39 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:2404
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751798AbeCVRk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Bpcanp2kBESNDQBFXBGKhecShzY0SaKqvFo96E/+P3M=;
 b=FFimTvEfAOzejS9XGR5Fi9eXm3FE7t2YLfP4qAMmH6zM0bEhbHFz7w5tQRxABP6L9nbnPX51s0rqpxM6VqU80cVTft4VIY5iBjJlqZg94TZEK3qIZHrXjpQttdONNiAxM7nmyHUUpVrb+Xb+1IogZfzbGl/cNKgDatBwtCLYNpc=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (2603:10b6:4:a8::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.631.1; Thu, 22 Mar 2018 17:40:26 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 3/3] sha1_name: use bsearch_pack() for abbreviations
Date:   Thu, 22 Mar 2018 13:40:10 -0400
Message-Id: <20180322174010.120117-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180322174010.120117-1-dstolee@microsoft.com>
References: <20180321224226.GA74743@genre.crustytoothpaste.net>
 <20180322174010.120117-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BN4PR10CA0017.namprd10.prod.outlook.com (2603:10b6:403::27)
 To DM5PR2101MB1015.namprd21.prod.outlook.com (2603:10b6:4:a8::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7434661-87dc-49df-4764-08d5901bffe2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;3:dm8JWSwSS4iippgb/++eKYR0W/H4EQhai8cS6k2ZcapDiWSG1XK/ZM1xQIQDTxTRVb2hkfP9aSb0KaB7i/4MotQel8qPSknExwOdW7Zo3p8ueL/8T27CQlwvydOQ96knP6iMcAjZJ0heQ4tWWB6ReSvO+Al2/Ef5QXO/jMyzZGmKiXuCxanvFVhkqd63IKjXAn+0d2eravdKrEQuq5CoztId6AE7Gld5l68q6ag6XYh2NtMHPNTLNxqjZu84Jk/V;25:aENHC8ttkedN8Z1UoDjodn0/NZAz0hW8vk9fXCfxLOhONys3Yb2F+9rXqVv+HU0ZWZyr4gS3B41Y0pgW5TMrffR9E8zXwKfX1oLY/dG2uKxpKR1ikjWdigyC4sEOSa81jStTPaBkksB0vADwh2tWP4TzQimiBp5uzdDT7bSOAzub14dXWUJV9YeV6TmybkqnABj+GOJhh7wR6l/z74eTaL89GwLON+wJqhVSBEMMXsxSNslTXVUqoOIhD3RoFH8Wr/AV5kJi6IENsWtvnNC9/BEZVAeey1JMxpZYtPX0d6XBA60iL7Itc3UepLk32jPDg+MZ/lmxP9hpIjSMzz1zvA==;31:1E2clqtHt+wIG8xJHfFUU10IzPxduV0AttdFv8+ilFn+juiu4D7Mtc03CNIfRI2qo18BnQL3xwaKWrb3RyPZV+e9y/p7nA3GzCeD2PHlCBOiJPADCcGOaM5yMYq7RFEJBhdoQZBdmypDeg7iVt//VKHQxDi4WAbm9t29mljzwBcEXvCJleBDbbFbIHMPXGhViKxAkdQpZnCDEQo7foQ+nErXFbyvUpRrC7kn+ir2el0=
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1015:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;20:OSL24W3zyvgCcofwSY8+AKVRMNwRiIHvXdwYMcnMVfjoL79gTm3ZfaZxGiN8aBQnNpDiigPzLaOviPpfE4F4jaqxsl5t0wIrE4DpDs/rdiU/RDPYpNsbq4ynyefbx7SiM98WTWXyIgONca6jQE0g7sXA8uWyLFTrFvs1Q01vHgresPKanUGfA/fmvvNEA0E7k2sdTr9x/XHaYcaJSksynYQNWbkTNP87UUEDfcTbIwU6571s2YfDPw+eXouRkES+LNw3IlaIX07cvXhhBIrTK1HohL9qWDYSNLftQFnYA97hXvGDrDCZr34msnHa0OVBGKOToPnFZYSQJAcLEn2WH7d+ob0pJpeRx3ULLl3WNxVxx4EtToQgKyo1LDCNcFS0XO+7MIQRA8A0tjZcAmsr/NSH/Y1Dn5VR+hkdy79wgc/pWrBHlDKSwscuJZ8ndNP4pTcHT4vj/2yXMVQWLCFF+TS3St692NGKtIAkSiOCQY1dY855AkB12lbJ7bBCvXOj;4:EGgCp/bPArtYbcHJzkmMn8FOPRSVbJkJanpOaSOv9Ap+f+vZHffqSgGjJZBfWQAUzDK7HNXEutnA74ijH8qWA6gWfBzcvYL9is9rTfsO2Dv6i1xngqfPNoZbSPNPbpx2AO89APFWd6mgtqsAse9BgG0WFam653+3hrm1d4y/R5GBmqNa3NmslrdOvhTC5TtBgVn7CcYoqwCLJeIulQkPCMvUqvF0c0O+MhClAL3g/akop24DDk+WVoPM1CEvRHqqXzWyeWgA1tyX4zZcB7E/HbbVDx6aV0+1lxyuHGVzdffKGhHBR/k+Aq53uofmYjN5yAA4RKyf/1u6jTKol3GqIVldRASfC7X9D4AgRUZWlwc=
X-Microsoft-Antispam-PRVS: <DM5PR2101MB10158B435041CEE95ACA9CB7A1A90@DM5PR2101MB1015.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(199004)(189003)(68736007)(1076002)(10290500003)(6346003)(386003)(4326008)(76176011)(22452003)(305945005)(52396003)(51416003)(7696005)(52116002)(46003)(86362001)(25786009)(5660300001)(478600001)(53936002)(50466002)(6116002)(48376002)(36756003)(446003)(8936002)(2906002)(16526019)(16586007)(6916009)(81166006)(6486002)(97736004)(6666003)(81156014)(7736002)(316002)(10090500001)(107886003)(105586002)(106356001)(39060400002)(186003)(2351001)(50226002)(2361001)(86612001)(47776003)(11346002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR2101MB1015;23:RJGHsesZEHMbk6SjfZTI2ThawJo7RLvraR+xUvY?=
 =?us-ascii?Q?On5yJAUj58eiWLEweLtJmdVLwZxqzVwk5uvunvk8snXmhHN9rCRop/UvRXFv?=
 =?us-ascii?Q?aRyiXr9lzciLW6OI0ZfvLxFEfsUXCYg3j8jkLeDB8/Lp2wgmZ/23nCeNEfh2?=
 =?us-ascii?Q?eJkv3V02IplRP2ZwKuJG9n1mq93N8fWRBwyJR3WPjxTRQgpKinBDlKbcBMXs?=
 =?us-ascii?Q?9qd3eeV3gH8BJIszx8GtkgTv3YZoaiJ42wX6+BosGLKTpLsmmOnCYc+VqBeo?=
 =?us-ascii?Q?Enr0fGk+NuIjg2WpO3SBcRtT2TB010dcb+cbw7O+kVeSgXPLr8YvxKAw1XZ0?=
 =?us-ascii?Q?dHdWAPCj82Vp5t3bXqzjne5u5MWO6aNVX5zmeeEjP9bjq4zW7+eKkZXvnXHH?=
 =?us-ascii?Q?pafblmpNPv27czdDG3+ca8nmlrbiLicCWMJbP1blzSu2pPpCUEO1cuMFbdu3?=
 =?us-ascii?Q?Sg7TUltoz08Kv4ciV7FfADxqReUW/1psYxVbuZzdQbDUxZLfG4vkik6lec/1?=
 =?us-ascii?Q?Z3WwiVn56sgM4N5jQfqCEcnnhPkcio4UtSrCUQPFf9065+oGMccyoyWZ0zYB?=
 =?us-ascii?Q?2UuMvLK7pbwrbLF7JvTa3XraLTNdm+QBEoHzIvTv85QPhOYtpMVpDuE0dIuB?=
 =?us-ascii?Q?TMlhocP6HKSbQ8iM1TcislmhJvFLfS/rmBJ+bfGwqXnMS3TvKTxFAkIJzinP?=
 =?us-ascii?Q?IKgB+2Fwxat+uWd8HQOKpDFHB6+7AqCZM5lvMpcR8YR2qBt5fE1e9Oaotd/u?=
 =?us-ascii?Q?Et/+LcsVNzXDxJCszyLEUJus5gpNbmPI64FTVStbsj8EENa85vM/ONuiREiG?=
 =?us-ascii?Q?otWh4PcGGC2eC28XbPurymjaDHG4bTI5RW4EVL0UmsSzMDD1GewsrQGHQLky?=
 =?us-ascii?Q?DR2S+OxTSyPik/apQB+2FWQtxbSHrLa5bHNz5s09IyYDVJvQiIlEjl+ExA/e?=
 =?us-ascii?Q?Jlb87GUt9CirM9LrWlwujzjiE0H3c+T5nFqUdIiUlx6uhP4EpgVBELZLiGGP?=
 =?us-ascii?Q?0kSA41dtDmZyF2m4nW9JWt++HNXUYbHjp9qgfJW9ATw5YMoqi4U0f1/zHliT?=
 =?us-ascii?Q?DFpjR3qiPhAfMbsaGECZjOh6A26DiGvcMjcAp69EvZfOZXphpbD6maTKpJzP?=
 =?us-ascii?Q?IH39fPBiAKcxQCZ+P394zXIZ1vHCuEA1WfliXYbqIh59dE58pSEgedVF6v0m?=
 =?us-ascii?Q?ZG9TXk2SF1v4OvGL/aV5ZzLOoQaGZ8qfV/Wafz2SlGRczjMwUKGFKOjl/W5k?=
 =?us-ascii?Q?L5qMzLFsuPAxv3jf2zAixLXE6nencCvvaHxV0otQ5EmjrVRSG3w+5G7y2INl?=
 =?us-ascii?Q?76A=3D=3D?=
X-Microsoft-Antispam-Message-Info: miiHDxdHvWpKZpzv6843Ixs1JQj5LR2MnccFOAtWoxiVfL+2OKR57zfeDXg9fyfCKPjs/98o32wMyFbIElnjr4CwLyY5Vo+y1iyPLZFWfC/GRgSoF5RtmjXqgZUiB7NHCKJb72u9IdVnEO1b5w+G+CQSdTImeeArIJeYlT510zWr07Upp9Mr6uaKZZ4n0z+H
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;6:8z3cMcv2I+yuvkeTnaaZMqYs3n5kXrL57etouN4f7VWftRPwzWsKSNdeciruLG1TwgLxRFVBnxcCtuvLk2RXNidrPA2RtgOdXpPQaphVbq5KSl5H/SY3+ToeqVNptFMfetqvTx++EGayh3wjURlYP6ZPoybU7uovqpnW9DF0H2FA0wx6/b76DL3YR1r1i2vJkiDCLg+IWnMb5MaBXTx4kPg9YvQastitxIjCSazg+uQTLwob5yoOEIhEvKXEmdTFTdpqrRie+/IF6iKQV5sg88spzuEvmH/WA5HR39QflMNw6fIO0NVAUrvmMMKLSroxBhE29EFpcf64Db/VNRrMdb59jOlvIcYlU2CK+BnWzNFDOgayDL0k6d+R6JoR4+Bqn1PmANoHj4AVdUrA5Ji3DBMzJ/oNoDCimf92bHU+bDMxvfDXz6fb/xCzz62AoKLUV35bOo8kP+pAeAnCgnTghg==;5:yZS9nf2lFnUnVDdTAf359w/VNn0xkZiGUynJD2h08KJrYwktx8jsTwM5WkcF0DldBlSvh/ruR+HyY6CbOYzH2TTzcnZHRh4oNAtqHejVE5gYuy40HrZsHkp9BZvix3ADVhZYqroCW6cpVkRbmSar9u5mvLyjkZJOYgvD17+Uxsg=;24:34Vb+JciLt7keqHx0XyPprihtPHjB0yEuvCeQW++olWGvMOQSeqym7zBF974XryVIuuvkE+iFhbUQOjWLjyfQWbqO2TG3ogM9TElF1ErNXA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;7:5tloQh3kEH43MGc4+DgFKGMA/7eWSrkfSk62y7IYUBT6V1QFl/1e0e5jbxMKmjkOUQWWW/iIY/sFulaa/mjsXpcIaFG/Em4dfiefUQ+6XNNStZE9dpi6Z+mB0uhRxctYsHpaMiFmeK8oaMDg3v3SPnZy+SRcRmpEgRowskIVBM0AI5doEh6mOqn7tldCl0vvuF1OkjY713kWu5Ke9vA5OWceuyPC0pZH0ZwZ3SPH4H1j0OAMlpu+5RZj3Z4Sg9Wx;20:bmTzK4Aep+krvHjYqR074rXgwDXM87o2tYC5yvYDe+2j17uSLKVZQcZmjtax7v5OlxWVMnsgJtW5uWBgAiQHpr8aCXr2QkltQ5PfmxU1UEZK7P0yBTnwinSsTAjq4tGEO8FYaBMEOYtSjd6Xh88uZUexdZSg0BNEswQ8LSTMSgc=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 17:40:26.9486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7434661-87dc-49df-4764-08d5901bffe2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When computing abbreviation lengths for an object ID against a single
packfile, the method find_abbrev_len_for_pack() currently implements
binary search. This is one of several implementations. One issue with
this implementation is that it ignores the fanout table in the pack-
index.

Translate this binary search to use the existing bsearch_pack() method
that correctly uses a fanout table.

Due to the use of the fanout table, the abbreviation computation is
slightly faster than before. For a fully-repacked copy of the Linux
repo, the following 'git log' commands improved:

* git log --oneline --parents --raw
  Before: 59.2s
  After:  56.9s
  Rel %:  -3.8%

* git log --oneline --parents
  Before: 6.48s
  After:  5.91s
  Rel %: -8.9%

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 16e0003396..24894b3dbe 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -512,32 +512,16 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 				     struct min_abbrev_data *mad)
 {
 	int match = 0;
-	uint32_t num, last, first = 0;
+	uint32_t num, first = 0;
 	struct object_id oid;
+	const struct object_id *mad_oid;
 
 	if (open_pack_index(p) || !p->num_objects)
 		return;
 
 	num = p->num_objects;
-	last = num;
-	while (first < last) {
-		uint32_t mid = first + (last - first) / 2;
-		const unsigned char *current;
-		int cmp;
-
-		current = nth_packed_object_sha1(p, mid);
-		cmp = hashcmp(mad->oid->hash, current);
-		if (!cmp) {
-			match = 1;
-			first = mid;
-			break;
-		}
-		if (cmp > 0) {
-			first = mid + 1;
-			continue;
-		}
-		last = mid;
-	}
+	mad_oid = mad->oid;
+	match = bsearch_pack(mad_oid, p, &first);
 
 	/*
 	 * first is now the position in the packfile where we would insert
-- 
2.17.0.rc0

