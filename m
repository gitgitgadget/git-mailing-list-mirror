Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69FAF20A26
	for <e@80x24.org>; Mon, 25 Sep 2017 09:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934515AbdIYJzu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 05:55:50 -0400
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:37136
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934481AbdIYJzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 05:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TjknlgXBqacf312rP0WeAXonxcI7nTSjiyPtioscDZs=;
 b=fkq9hVkGEM6gjXiDBSAbbmgjEvAZz2lyivH3JJZbaF2vtvR1TKiyXQLWd+exjccAtLnDKr3AyekZD6K2nfcJ+/aobjFewI/1q+eGs85/qz2l02KQYTRLRATi3lGvtkBvGmZpa54hC09aGLILJx1dno1bOnWrV1SHcCwHjTIIG5w=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 DM2PR21MB0092.namprd21.prod.outlook.com (2a01:111:e400:50c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.98.3; Mon, 25 Sep
 2017 09:55:19 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 3/5] sha1_name: Unroll len loop in find_unique_abbrev_r
Date:   Mon, 25 Sep 2017 05:54:50 -0400
Message-Id: <20170925095452.66833-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:404:b9::17) To DM2PR21MB0092.namprd21.prod.outlook.com
 (2a01:111:e400:50c7::12)
X-MS-Office365-Filtering-Correlation-Id: cfc33264-d9c4-4180-140d-08d503fb8839
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:DM2PR21MB0092;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;3:TJ336P/8iPqH4yEknhobmfLC6F+kGyu1d4WlxrSw+9iH+zT4gjxIoTrFHiu7ew2qrNW/kkuINzEpAhJ/cNJmeEe6Y8dM1AgHu9RC4oxqwM77qhomfzVHUOHMwRLyNmgd1B4uJ1Ehrp/U8uRM66njgOUkHQXIeFQCJsGO9XMyCK02yTuInDR2nB9ji0ah9x56MN+DD1Hyb7878exfTXy7S3Ui39UAF/hPNru9hstDY/50fgOJt1/a8l0riw1LbVf3;25:zD8aJzuK/O0t8diXiqeGdnZztX8F8NMNQJwpxUL9O2ZOoTpEXMX3WSi2AVMGi4ekryxaR6t5rSUM8wZPdKXvtwxFLYxnIyi5gZay3gPs8Qo++sM/ZaIxuumZKIPYYBjzJtY3l/oGgj6JlR4PvoYqvqa/r4GrUxJc8uaRmuMkWwFLPhz42MmLK4Pd91C88zfnNdhdUX0FpTbXGdBOif88F0+JOZgOmIInD2+RvdlwDwKvoz42039mkffRiGx1PPcEgLtLk3SPEJDwUVyuZGdNjQV62XX9At7eT1XdfQgUIrpGyAyipUCF85o0JJ5VcBzMFTQGf/5Kcpl5G2oU6JyD5A==;31:hw4ZYt408YhC9diVRNHoJEGRIKL+KsPl0ec9yRNAWrcBVR7xMC08MrOhx+VLV8vxqxXKXh4CeBehL5+pvrCUMDOvwpnOhP0NRHG8KbJZ+hHb0yZmgPJiG8YzdWshMbk8YOioI0ndyyVhrqkZzloPMk37w+e+kXkD5atDjUmPQiPIwroGiOIhCJT8aLBk96DCC1XsK0pt11OkKNj7eVk7sNOZWVHVhPDluy2y4DMFSBw=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0092:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;20:oazIqlmW8PU6EPxbG6yO987hsbI/ZHcDzCEzfDTUn7GQLzTR5Nw8EazNexv6AAgrW37QHN6Xw3zZhL0pVTylygX7le0Iu6hJ3kIk3x9KKN7OgNe0ZsO2+dLVT/u8FFxrPBGPUjFwFbuveGi3iYoZkL912OWiUxqUDBktUbE4YnzA+fNhj1rzCE4ChZN+GN8DQqC5CIWXOiQUmrh3YrspAvRWV9vn1XxNTI5qbDNefjQXmwoiAr0X2kP3xLuoScS53Lhnqn2x4mD7VU9BMdu1eTqZaM91zzQ88GjYsVGwgTobtv0cF9GXjgEr+03g5TGZNWgzvZU2kKS5d+PKFdt0Afau2qZQnLvxXOMuStncg+cliGqfP/TBfEyDK5sQer61tZ7a9P66Ye9QOpZbp883IcIS1RVFKY3MYSYjYDtolPoOOrtNyFSe4rlfErAtcQqWoWPXIVdWNbTf7Flg5hclEnisdHtot6xXGuQTjYcZhPtfcfZoLlYCVB4u5oAvl/Gb;4:sMp8uHELh/tbBiD9lvvmO1YKMqZrv6RIT27prlcgYPfX8gyyvy7vNr6JwCOPjVi2/ljBB1Q7uYzUnz28XJhh3Hs7KzsCTSxa4wQ3dCvWqYKKqx9BWZ2Hihe7vNDftYF2jFKmMQZFkIZdqwGUFKJ8j+h2QkT4q237k4WghvTxaGSODnMdMsgbPFGkgSwFj/mqq8Ixdqz2QLkTOmLraXbhW0mBcp4xIYEcweA4uYGJXFyIg47lSQuhvcEDVxrD9e1coRQKvdKhSRx4NWUYS3qRjyGUvD2gtdBoacHkuT3mrLBlB9XNsT7ot5eWPoMveVxWINT0nbLmvaUOjgzOg5ru+A==
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(17755550239193);
X-Microsoft-Antispam-PRVS: <DM2PR21MB00923CB57D26E094C633175FA17A0@DM2PR21MB0092.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123555025)(20161123562025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0092;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0092;
X-Forefront-PRVS: 04410E544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(189002)(199003)(316002)(305945005)(68736007)(86362001)(10290500003)(101416001)(6666003)(7736002)(478600001)(2950100002)(105586002)(53936002)(6916009)(2351001)(86612001)(4326008)(2361001)(1076002)(48376002)(10090500001)(6116002)(189998001)(81166006)(5660300001)(25786009)(8676002)(97736004)(106356001)(39060400002)(107886003)(81156014)(36756003)(50986999)(22452003)(6486002)(8936002)(2906002)(47776003)(5003940100001)(50466002)(16586007)(33646002)(76176999)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0092;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0092;23:+0EGqQVMJFBngJgH9QN0RkhXSWRl1Z4j/+M53S4LK?=
 =?us-ascii?Q?iQlkAq1A4zBhxBxZucF3xUx1DkPVyjf06hJchHO60avOBb5iz4SO9PvYP/Z6?=
 =?us-ascii?Q?DFybXnCZYdNFBUjLfJsf3KHuSTUP/ANxnCYrDLoXWFzAtGZqxCRzFao8eDTc?=
 =?us-ascii?Q?ZaAoDfFpl8nFJQJdPkFA6jrOkkcfSs/i1DzUoDno7mlFEnfBuXgmGugnXPGx?=
 =?us-ascii?Q?08UXwymqPCePL0t0wIPXZVyAjAo6ejyhVGon2wC2No3jAZI6cuaaT0+cTLeJ?=
 =?us-ascii?Q?9a3giMgjSWLoDjs2a03e5Wi5zkJOXpgY8GoAhxGunhoLuwOS7P5F1UAHmG92?=
 =?us-ascii?Q?cYsymXkIKud2iQeU/e2d8fgX5ByhH9/mBiHJSUTuRVukAa7O5EVfekDduokR?=
 =?us-ascii?Q?TzhEoFE52vOCnL3QZlPb4/Vb8u3JZ1gZ3oVNVrlDzBP+uKrxxV9vi0LE/O1I?=
 =?us-ascii?Q?DpVJYcDAePJFpq7t2DRpbwDIBvlsU7/j7cJX9IGnfpRpSQXl1c/hqmgpoDzw?=
 =?us-ascii?Q?wUYGEe1kXra9b2h4nP6t4tyv8Rt6U7cQJWgrr+lCP7pqrk3ze0PmKN+Q3YQq?=
 =?us-ascii?Q?F7zPgrGK8lIv2eYPjaP/IRiOU9cmD4TVrpDGlQSPaghqQIuYQPJjOMGc6Edq?=
 =?us-ascii?Q?KVBrZWRaK11qAwaBG23AdnJ0v0WoyozwyEMGQ300b/AtvN+zYZKmooFhu6jJ?=
 =?us-ascii?Q?KsHPalx2SJD5nAkzRNwr7vITnpUozmMkiSie56TweuAL7v8Xijo5cfpCyISs?=
 =?us-ascii?Q?3wVWCtaKtWxQjQps+bxBExrjmS6QA8HZDwOJNfHgFRI1/li1K7RyX2MxnDiM?=
 =?us-ascii?Q?W6y3oAsknIoagER2nxzHaQU6TQjLAVoQJsHGo/z+870Kmhyho6UZvWhE93AT?=
 =?us-ascii?Q?aJk7ceNFNHpr074dNKr5bildSCR6OYuVdnt2qLTTr92ciUtak9LLtGUqs4dI?=
 =?us-ascii?Q?fFRuPWr9lh4f4HGEYJUaL2Dbu0OjE93ldTMOUiJJU53HhUwXjSCeBEyck+uN?=
 =?us-ascii?Q?xzPoC+4Q3NGsN2ifx1A5MSWdrUOWi2SInRRsjJbqF0hnuLx6SH4uk1Kw3k6O?=
 =?us-ascii?Q?mLJZgljtz7NFRe9QShvZoREu6Q3G7xpkA9H9LTKctKZdngrjQqV4zAFFLskT?=
 =?us-ascii?Q?qRHJA0z/XSOWT7KFXaNG0bIA9SeJcMG94TyTaKeh+R5OHsTFmFKy/4I2mAon?=
 =?us-ascii?Q?Djgq9ltgvxjNZebedfUUWjq6CJ0N8rGo+afkB0TPcQzole2lRezqMnF6A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;6:j1aPpHPNwagutcHYiMN+9p69Fnutv29ycnxE0QVVQmCrWyOuXRwkRrYW6KMS9HipQWg5ihAlypEzKzB6Pcm+y01o+CNKjKeWxgQgGWulJvocHECLYfKCwB7szRQR7bY3owAksK9shSR00Fm/H4+7ebZM/4zQQCxQ/LX7NjkYdUr9uFybj7EIcP52dCtthoee7+16S38A/1LCq4VoHes0hEEL0/U2MiBrkFoF2pBVd03QKHmqzvPHkHB9kLvpsAsGDptmEptEekGuYzwqdB1sS2RaAMJugdCwOmoRYgTpiOVPz8+pCVN95lkBXjK/o1MkrMv1vcvFqEzVn+YkadA9iw==;5:3JwSA4MKVqcA21kwTdJtfmjqln+qZRA8xXYIKyzIzAe49gI6HBs7yHiIG5qc44lHK86Wl/Fffe9uxAGwjrzhMmJIb1bWCfc/RvwrzDtYgb8RePKLMg3bEq6NQGzUkRWjR65db8Y8BYnmxQAwoAMqQQ==;24:a1A2W97CrEs+SKqot4211D0z1qS0Fyv7RaOoC6YQ218JIddyyTfh3SVhdBI5MT4ieJS9yE33H5oXJeErE8HevVIWcMVx9vzbLn15LHYAiWY=;7:UqFOe+1SY8S4fHXsyYqD5p8Wu8nLyCYmDCl5Ry+Z4mfw75N8TzN0khbnqInQCUkMthhzt/H3WzIg2yE1t30HPsapVI0V5DAgjIgA/2nMK/0baPalv/fNb86oqUUjpP42g0ZGtlpvM7SMT4cW9wvoz0IAyp6J6e3EpL8qVNiVu6b149cQ1fRlbTJw0JIhI6JFTNpXPWrGf73eTx1TyZjIwf9C94OekgC8NQo28KBcWOY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2017 09:55:19.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0092
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

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.12 s | 0.08 s | -33.3% |
| Git   |     5 |  230162 |      0 | 0.25 s | 0.17 s | -32.0% |
| Git   |     4 |  154310 |  75852 | 0.18 s | 0.14 s | -22.2% |
| Linux |     1 | 5606645 |      0 | 0.32 s | 0.50 s | +56.2% |
| Linux |    24 | 5606645 |      0 | 2.77 s | 2.41 s | -13.0% |
| Linux |    23 | 5283204 | 323441 | 2.86 s | 1.99 s | -30.4% |
| VSTS  |     1 | 4355923 |      0 | 0.27 s | 0.40 s | +48.1% |
| VSTS  |    32 | 4355923 |      0 | 2.41 s | 2.09 s | -13.3% |
| VSTS  |    31 | 4276829 |  79094 | 4.22 s | 3.60 s | -14.7% |

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
| Git   |     1 |  230078 |      0 | 0.61 s | 0.06 s | -90.2% |
| Git   |     5 |  230162 |      0 | 1.30 s | 0.14 s | -89.2% |
| Git   |     4 |  154310 |  75852 | 1.07 s | 0.12 s | -88.8% |
| Linux |     1 | 5606645 |      0 | 0.65 s | 0.40 s | -38.5% |
| Linux |    24 | 5606645 |      0 | 7.12 s | 1.59 s | -77.7% |
| Linux |    23 | 5283204 | 323441 | 6.33 s | 1.23 s | -80.6% |
| VSTS  |     1 | 4355923 |      0 | 0.64 s | 0.25 s | -60.9% |
| VSTS  |    32 | 4355923 |      0 | 7.77 s | 1.45 s | -81.3% |
| VSTS  |    31 | 4276829 |  79094 | 7.76 s | 1.59 s | -79.5% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 39.0 s
      New Time:  3.9 s
         Rel %: -90.0%

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

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

