Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5FA20281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbdJBO5U (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:57:20 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:36389
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751913AbdJBO5J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=71E8TfPVsGoKtOn3/ZoEX9PGUyHy8ouvzZDu6GdcFmQ=;
 b=F3pvNcAwntlz80LLfK0aca1ZoP/h0NyR8UG1VR4U556FtnI8pRcGBi/IBLOGhlgNdLhKELlVst4F1YuuV0VD0op4U+JN+uvY2RC1I1L9sq2L/PbaQ5flAr4za6EOTrrDUyv/97NEF/UnT8kotrVzvEDAPienp9ojlV2RcGqYbA8=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0731.namprd21.prod.outlook.com (2603:10b6:301:81::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.4; Mon, 2 Oct
 2017 14:57:04 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
Date:   Mon,  2 Oct 2017 10:56:49 -0400
Message-Id: <20171002145651.204984-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: MWHPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:300:115::27) To MWHPR2101MB0731.namprd21.prod.outlook.com
 (2603:10b6:301:81::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f78a6f3-90b1-441c-e6fc-08d509a5d8f9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0731;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;3:Dicj6Oklxyk7KjuTAhdE+whQ0puWRLqkgtQmrW9qrgSuLHsF3ApTTVdfDBeiUO3YzIE7KfIwG5XjMtjvaNKkl9WlssxpyYAR8vjV7/6NfzzrOEVXM3iMRuVfl1JBAJ0T/XF1/ckBUsspOMWv7BBSIr6cS2/+LgMQRqeUV1qrECk6Mpab8EXYdeaKQX9oF12bBanliQpBdK35INCv5/gHq2cxSPIWTM1nFJ5cX9mUm8TjbRKQGMmvPw1vc8UDJOa3;25:O+VKkry73DddTCQhUa6JfDs+2ht3PGVaEoh3ttq9lpXBYq9dobwaNn4g6biRuYEg30CCVMplHlXPhLla+zg9DqHaBy8HN6cpQytZAchNUEPO0NTU8MnXdPctT8UvP4PKbzfMBP2QBy8QX38SL5NNO44MmHq4ladcRp8vQoi/5Agt6/UunEu+CcJwXCRGfVO8uOEuNljh0lFYidL7z5lSh4HFEDzZguie58l3S5OzVRt0aIb1ypX15z2VQ8PI+WaZhbHLf83drfAw9A5aMxgAdfasskkEfP7dlYeIjWyTLh7SiNtor/1EWvuiX9d+LuymdM4B/UWc7EC+PQAEU5yELg==;31:J11DxmYPn6fo916kkq5GhpjuSZOqlYSAtvP1LTDoaHso2odJw/GPPJtHmhkNuufYqo+RNBPBEjSEGHNUKk14toMxHyry+BujD4/f4+YT0aK12nVynBQB9qirCAaP8YsiSa1qRuA0eGp7Zq7RMiIokbpMJ+smIlFMbp5JC+Ugxn1D8c7n4abdtD93AkWXjTakVKSu0fUEIxN52kcGJEv7h+qxzCE4rCNbM5NjO1oC2eE=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0731:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;20:UvXyqh8KKYaC6P2h9rH+TI6owH0yVnlEvlE50jmEkf1+RrGMeIM5Jaeqs8usqb38zOFX9VhJowYBke8gMzi9FhjcGynCPAnyBMthHmJzR8w+fx8SkcANwJu5YOT1DY1fJlLOWCFhHuWJsZEvntMr3Q0NicTbJD4uBW6gqGw/7ie1wDgEDy7diV7B6eMdSxXLa2CXYSCyJHPGC2YOZQW64060Lso6hORqP3Low+4NxN7OqXLKPE2gKpTbfyOliNrvq2zxxJCGHkP8RsHmi5U8F9YQwwdD70CIeQKO6xYUk+ICx1dze5FOccfnTGIX33PEM+7dGdDG2kDYUubl9C+XM0b3//5Zp2VV6juQHEpGxLehGLaXbh1PyWtCFAq6EVHnJHLHxRQTD4KUgVh+xOGHx7MftwmIUaGu6jUU25gUfsCnoswd9LYXrWq4FH+ksdiB30z+XwPDQ5MqVIOI+u+shZf0L+295YTJ98g21lFci2U3a6NDxPtQ+nHLRDA/ix1i;4:FN7qLaWmRexjrQitScPyiRI1fT8TPErG16mucsnow7LOBUvcd3ggeNphauPywHCWcrm9FQFyCSesuMQtOODa1AHaCNvswlqKWGg4rUyiGeIYCr6Lxh4DGso7dFG3fjZRKxIQ7Vyqy7/3wGUWMyex2If1lAuxdhpcoXKp1SFAD9EE/pvSHKyNVZWXQgd0BdxQ0tUcmJwNGn/Lyc11qJ7J5U0SOXUuaVAp+idX1/pCXCCIbXhRPG9N+vGJOUY5s1Jn8+lQ8DpMTR3hmEKSB4l8JEScmwOneg25Nj6zJlz3C/l1A5CQlt0zlzJVCYnxV2NvK3bcTBzZA8y6qKs0LdolAg==
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(17755550239193);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB0731C69A45A73D09BE0E9F85A17D0@MWHPR2101MB0731.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(12181511122)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0731;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0731;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(39860400002)(376002)(47760400005)(199003)(189002)(36756003)(68736007)(81166006)(10290500003)(50466002)(8936002)(48376002)(5003940100001)(189998001)(25786009)(8676002)(81156014)(8656003)(50986999)(76176999)(1076002)(97736004)(50226002)(2906002)(6116002)(53936002)(2950100002)(105586002)(16586007)(5660300001)(10090500001)(107886003)(106356001)(86612001)(39060400002)(6916009)(316002)(2351001)(47776003)(7736002)(478600001)(2361001)(6486002)(22452003)(86362001)(305945005)(4326008)(33646002)(6666003)(101416001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0731;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0731;23:vVtbsbgJyFYa/ezZWw2LUgagxrYST457jO+hlkw?=
 =?us-ascii?Q?uvOR4uM0D5oqhXgUjX1S/nEF0a7T6KZ4v2WeTXh9QGBK9y2fGBWy6sj1LbFG?=
 =?us-ascii?Q?TC8Dt1XUYaCxjZ82oRWYvoHW5CCUfr9jUYKDhQiaTYJqmYygLSAJouG9phES?=
 =?us-ascii?Q?KZNfW7+hOViPSmMToGHJVnW518CLQKsOnNm2GKCyd1ZoFsOibymFU9Xo/Xnx?=
 =?us-ascii?Q?D0C4jsrdmRioQ/SULY15sToxzTcghhSeTeyaxSDfPOeQO19sWaLC9e0XrQQd?=
 =?us-ascii?Q?Ywcoav4eI13FeIxVbc1DZIlKzWyzaN5zbmJkMEVsMrF8t52gzLebEDXynG9I?=
 =?us-ascii?Q?+lMQA51QDuanQQq/Mqa/C33SuAgxW7zXGEN05fpQ+dcvE9eYBqYw8826Lsou?=
 =?us-ascii?Q?wGBGSJucTcYSzRP9WIQgCl9h9EWNBzEsMYbL4KrxBRSvhdmjA9oDQCZlqP2S?=
 =?us-ascii?Q?rtSnVouK0u9uyMEX16MPHL8MorUWH76E5NGm4MnqzfgKJvelRvI8oiAU97wB?=
 =?us-ascii?Q?Ca9IfdMHgJi7irtz55NZb2qMgJYiCL2XdwsI62rQkPlPCnX50BJdh6t0uZyx?=
 =?us-ascii?Q?7oZY11akVTd1eGVquqs0ES/kQF8RMssScRRSRLBmlq6F+AV+thaSLMsl3H0g?=
 =?us-ascii?Q?J68OGiK46ctRI/Ei7G8OyfWa4kNTfr/HU7pde4jxqgLXtb0chAV3hIuIaDI9?=
 =?us-ascii?Q?RpIEpjkQ2gCklz2jOkO/8exEn5eOIx/3BXwe5wiHIP+zQyO6y1zx6lW+ZUv2?=
 =?us-ascii?Q?Zds2iQFjFNlkpI/hk84PeUl7Zk1j5RigIsDUMakKCVhwFiBEZu4m1pdt4C3y?=
 =?us-ascii?Q?vocyyQw7qU1Ka6wQtFqPXnUp1U8h8MvFhhnio7Aq/fkflB30duC6ePQxVhZm?=
 =?us-ascii?Q?oviEVnlDv2yL+SsQi9uVLbTVZRwFsfakTFNiy9MGH9COwuL+lKyjtbDqBIM2?=
 =?us-ascii?Q?eCcfVHPqFuCkeFM6j3tpxNtU5a0qOfBrb8Y2EvELAcVPHF1buywn+jBtRksD?=
 =?us-ascii?Q?vIlalmPIksNNqIItMqEZP6P53zwrdcCVWkCUsBAYnXUNKCxvgo+Xefe5H1Yp?=
 =?us-ascii?Q?cfUA8vnFIyXNfbZpFhPNGjI6t3vTyIHi3+6d/hw3rDNeBMRtBAHeEl1FoBnI?=
 =?us-ascii?Q?5OoTBMjMtmvWqjP5u4LL0Ck9uL3lTIrlZsjMwP3QSNsWWMhnNJPffSpSgx+K?=
 =?us-ascii?Q?qA4M/nB0t4F3qJPH8c5j1OJV60mFBoexAr/6F7ei3/TJOCkCJHQVedAojcr7?=
 =?us-ascii?Q?D8VVEzWnJMv0StHiQLlg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;6:k8jVBN9ULRgwcfFeLE06zctc4GPtld+ZpufZWVxYlGCtM1Ko6kv7I3w1j0UMaxgZhAir6LGSo4bJgT2hOHc/Zf+CRZ4OBxkEU8BpDCL8SqNTw1XPwH2UcNUl3g0Y51khzf4JvPSX8ilP7Z5ZHOzfhs58zDunR/Tzhfpn+NdZu4T4a2rErm+podZ1S/pyPLUe90PM0Wb0vjtYrStvom3P6UtMLvRRAw6vBsLPAiTehG8ymJ2hP3UoPVaqEFUWHNeWJVGD9AW+O8BmUO66cA5bzdeezwQn2wE6ckkbeGDFbj+e0RsAnCEg1VQNifGOs1gede4zjzVLrEU96/8sgEFB2w==;5:M8V4l18//hy5Ky4HlqzC05ukB+oi1WBl5m2eXFGGwI5RMxbgZgT5I6HWuYstVoFvA6snOCW2dlvY2wkGmAjKMn19dMYNYApxaASXVWtegnb76t04ja/lPUjls7No7m3q8RnZGoj/echD66aeiOI4Jg==;24:ua1Rh9HTvKooXBX5Bjq05IGlO95I2CuTnSOgPjhO69LQWoHUEoZYIOcqL++KbwSlgsgJnuhKm1o6zADlzNfcs/XU4yliGvUkv3DeYZmaads=;7:XzjFv2wnJt9RH5yVVXKL2/UC8UfqdZd2L8VC4RuZQIpTS29H/LSAZoRucAVYSmbjv8H3Kal3pTHUY/Dzs5QfGtF8m1W0OsNrUiWouVZ/fsRs3SeqRq8kpWgHJkT/KV4kAha1jJZggU6tXZyfvYaWYuMIec3jQ7gXUrOMVYQIMHdpq6B6ag8A7yASrYQGdBKr8BF33LcMiQMZTJc3jFpRVWkFQXIL8Ckn+N+1TnikyPw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2017 14:57:04.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0731
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unroll the while loop inside find_unique_abbrev_r to avoid iterating
through all loose objects and packfiles multiple times when the short
name is longer than the predicted length.

Instead, inspect each object that collides with the estimated
abbreviation to find the longest common prefix.

p0008.1: find_unique_abbrev() for existing objects
--------------------------------------------------

For 10 repeated tests, each checking 100,000 known objects, we find the
following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |         |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%    |
|-------|-------|---------|--------|--------|--------|---------|
| Git   |     1 |  230078 |      0 | 0.09 s | 0.06 s | - 33.3% |
| Git   |     5 |  230162 |      0 | 0.11 s | 0.08 s | - 27.3% |
| Git   |     4 |  154310 |  75852 | 0.09 s | 0.07 s | - 22.2% |
| Linux |     1 | 5606645 |      0 | 0.12 s | 0.32 s | +146.2% |
| Linux |    24 | 5606645 |      0 | 1.12 s | 1.12 s | -  0.9% |
| Linux |    23 | 5283204 | 323441 | 1.08 s | 1.05 s | -  2.8% |
| VSTS  |     1 | 4355923 |      0 | 0.12 s | 0.23 s | + 91.7% |
| VSTS  |    32 | 4355923 |      0 | 1.02 s | 1.08 s | +  5.9% |
| VSTS  |    31 | 4276829 |  79094 | 2.25 s | 2.08 s | -  7.6% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 5.69 s
      New Time: 4.62 s
         Rel %: -18.9%

p0008.2: find_unique_abbrev() for missing objects
-------------------------------------------------

For 10 repeated tests, each checking 100,000 missing objects, we find
the following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.66 s | 0.08 s | -87.9% |
| Git   |     5 |  230162 |      0 | 0.90 s | 0.13 s | -85.6% |
| Git   |     4 |  154310 |  75852 | 0.79 s | 0.10 s | -87.3% |
| Linux |     1 | 5606645 |      0 | 0.48 s | 0.32 s | -33.3% |
| Linux |    24 | 5606645 |      0 | 4.41 s | 1.09 s | -75.3% |
| Linux |    23 | 5283204 | 323441 | 4.11 s | 0.99 s | -75.9% |
| VSTS  |     1 | 4355923 |      0 | 0.46 s | 0.25 s | -45.7% |
| VSTS  |    32 | 4355923 |      0 | 5.40 s | 1.15 s | -78.7% |
| VSTS  |    31 | 4276829 |  79094 | 5.88 s | 1.18 s | -79.9% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 39.0 s
      New Time:  3.9 s
         Rel %: -90.0%

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 57 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 134ac9742..f2a1ebe49 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -474,10 +474,32 @@ static unsigned msb(unsigned long val)
 	return r;
 }
 
-int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
+struct min_abbrev_data {
+	unsigned int init_len;
+	unsigned int cur_len;
+	char *hex;
+};
+
+static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 {
-	int status, exists;
+	struct min_abbrev_data *mad = cb_data;
+
+	char *hex = oid_to_hex(oid);
+	unsigned int i = mad->init_len;
+	while (mad->hex[i] && mad->hex[i] == hex[i])
+		i++;
+
+	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
+		mad->cur_len = i + 1;
+
+	return 0;
+}
 
+int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
+{
+	struct disambiguate_state ds;
+	struct min_abbrev_data mad;
+	struct object_id oid_ret;
 	if (len < 0) {
 		unsigned long count = approximate_object_count();
 		/*
@@ -503,19 +525,24 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	sha1_to_hex_r(hex, sha1);
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
-	exists = has_sha1_file(sha1);
-	while (len < GIT_SHA1_HEXSZ) {
-		struct object_id oid_ret;
-		status = get_short_oid(hex, len, &oid_ret, GET_OID_QUIETLY);
-		if (exists
-		    ? !status
-		    : status == SHORT_NAME_NOT_FOUND) {
-			hex[len] = 0;
-			return len;
-		}
-		len++;
-	}
-	return len;
+
+	if (init_object_disambiguation(hex, len, &ds) < 0)
+		return -1;
+
+	mad.init_len = len;
+	mad.cur_len = len;
+	mad.hex = hex;
+
+	ds.fn = extend_abbrev_len;
+	ds.always_call_fn = 1;
+	ds.cb_data = (void*)&mad;
+
+	find_short_object_filename(&ds);
+	find_short_packed_object(&ds);
+	(void)finish_object_disambiguation(&ds, &oid_ret);
+
+	hex[mad.cur_len] = 0;
+	return mad.cur_len;
 }
 
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
-- 
2.14.1.538.g56ec8fc98.dirty

