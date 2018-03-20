Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B731F404
	for <e@80x24.org>; Tue, 20 Mar 2018 20:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeCTUD5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 16:03:57 -0400
Received: from mail-sn1nam01on0128.outbound.protection.outlook.com ([104.47.32.128]:9536
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751269AbeCTUD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 16:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=26RHfMlouEE2kAdNv+Ah0PqGcepxK/y+gJI2YTbMqv8=;
 b=X9aMov0sClS0PPpiJXOteTgLMARPD3yN3xB53PZYMihIGHysf5WIZtSSMKwBvH9/8rRYTeCz6l+mc9+tHrTuUTHHuX9FYFI///8kvE/H+qhaeAVkMBacg3POvRYY7HCgZ8uVfyWLcSYWoHJXYUlDeyREBnk7pwt61W4hVlzUQPk=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 SN6PR2101MB1023.namprd21.prod.outlook.com (2603:10b6:805:a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.631.1; Tue, 20 Mar
 2018 20:03:54 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] sha1_name: use bsearch_hash() for abbreviations
Date:   Tue, 20 Mar 2018 16:03:25 -0400
Message-Id: <20180320200325.168147-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To SN6PR2101MB1023.namprd21.prod.outlook.com
 (2603:10b6:805:a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 704a0fca-9d5d-404f-b22a-08d58e9db533
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:SN6PR2101MB1023;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB1023;3:hxKYo84bQ1SJlyksl4f2AN2CtwgHWAQCHi2CBtdZEiCJ9dXdMVabFM9gqH6J8MYMcXXYaEV/rKHYs3E8JxvJaurZZn/jGGBE7ywANQZih+qKnE8e8gy7EVaFP5e+mx1iIJbS3MjTQKlUlZPW/Vvwoel2p6iE4k+kvSwPdOV1+nGPOtwJX0EK0XKBlBXSPDtQUpBQwplIgxwHdkfRQp+p2N+RSQlLuhpT/H+xDzNDvMJWfoIzzhwdN3hZmT2ZkP4Q;25:2bGvIxTNA4rO4/GoGfQUSxBhcmjq7tOq3BVEpt1gPNRZ2vHD2XQxIUMoMYhOWb5bucJc81KYOqD6d7E+kLp9CRpM/3XY+5xYJCSFNQSIqTW8CkIQOHjquhvxVdrxfcma125r3AO4Ze9AmNKU0d2dPp5bhMBzUiaqh5OvFBEMg1iHJAfPR7weRAHl/+roJ5bXg7augNYpPNQ9/lt+Fo08KqW2aa83w+y7li3J+njlOdDWsikmBFeVUdyhYfqtrjYAyIqUX42g/ElOvXH3ky+VzcZagwpDBqg83VJwZ06K8fB/3ttkkUzAHg7kUghv/zHdWTNWYNTYb/zV7HjkUl3Pug==;31:/Q+yD0zDRxt97o2wmM7+C1I14spOuts9cvFN9JRlRF53PFdDQYefMC6abuheSLaXvtBUPZwh6sVg25ctC8IXdYPus1t1p8ggX+kLCJEWn2TNTl3uAeVYVnAGH531CvW2GYnWMdLH8vlU78syXCBBY47ZeBcrJcbXPsqETi+UdR53lyBlhPldalJYcco3mSbUDvJLvVTUE9SEGyCv6tqI6DTdye/qrs1TGZ4HkMH/Oyc=
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1023:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB1023;20:TJ3m7MlRRDYXnlorg+h0BZ8/Y0KfTKPcQhjcX24oxz8XLICaGz4LioxGnKuv2omSW4mg4z0AhgkoPMxFKr6xB1HunnAbqvXzPckbeH10EKqryRltQlGwc+eOxvLalcsXcb5BbmPGMp0+JulcbL9YY4GY7qCzfMnnrzYl30eH4h86RyXkPQD4YyExNv4D/SVC3+kTpURWiRnUtnMMBK5d/lmYsPaLgB4gDuAHBRG0I1tCumUtg/TzbP56yHkOl0r3dCZiS9KDvA6qf2XPcY4chJsTWF9o4XpHOL/54F2faC5X68YsvhmCgCp2LeYw4cIv8sCncPwbYdpp+ucBAZJW5McyuVx2sk/raO9SC3f0vy8ptuXG4yhN1fqsxlpixoSYV7O+OYDZnxaT9yp9N5Jkk0sTk1y0uUkeLpNUwbSaZrKw0V8thJu0LFUwZR7CftoBGKp3UpLBHAjiNOrFKKTf3bq3eIiJJow5w/gTJtyZDKad2Wk0CABQ9XZ2iJDfzaYY;4:ZcIgOYVW8uO7rfWXWptqzdNUShlaEf/KZ/aUNwzBcs92g0kH5RsvEdX45qROVx4fl2uDx8DACVwMddhIYsK3w7tOG5G9gS3DLdc2xInSjnVxY/BuymUq5HCEyar7rrrZl/c41+SXNKTz8l4yGRLKexoGoSNVyL3gRpkzuVU0A6KbZwKnC5Xbj0adWTeF/zHVGKARCOqQo+eaxDVFQtYhwbuOZS31GdMUbmzWhIdjWgkl4BMXJ0Hgq+EBP+UMgGNcYDDz5VxpYPJoCUOQy6I60ayrV55jczdvzZ1LLcl4lNVylAUWnhtQrTVybCJSbshQDWYZ7crMjzRNVuZ91NGYtHlR0hq2TpthvWaQgagRjsSwuyJnxJ4UoJzJkXQHQFaO
X-Microsoft-Antispam-PRVS: <SN6PR2101MB10237791C3E9FA67DD733CF2A1AB0@SN6PR2101MB1023.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(211936372134217);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501314)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:SN6PR2101MB1023;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1023;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39860400002)(366004)(396003)(51414003)(199004)(189003)(16526019)(386003)(305945005)(7736002)(86362001)(575784001)(1857600001)(5660300001)(107886003)(86612001)(10290500003)(966005)(2906002)(68736007)(46003)(97736004)(51416003)(105586002)(7696005)(22452003)(52116002)(478600001)(186003)(52396003)(6916009)(6666003)(1076002)(6116002)(4326008)(8676002)(39060400002)(50226002)(6486002)(81156014)(10090500001)(53936002)(8936002)(6306002)(16586007)(2351001)(81166006)(50466002)(2361001)(48376002)(25786009)(47776003)(36756003)(316002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1023;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR2101MB1023;23:v/teO9mG87yqz4gv67PD5j1rux3ui2aX30Ske3S?=
 =?us-ascii?Q?4jZ681eoxMOan4DOO6BN7k65nN2jj0hpJgXxrxbPEsEbbICsxMx728rzT7v4?=
 =?us-ascii?Q?TlrlTn1fiasHFdl5Xbq0+VsNNM35fWSVF0Dy4eKa8pAhpIdhRPBvoVUXsAum?=
 =?us-ascii?Q?MB+7Nt4owFwLIJdyvdWKIQp9nZc3sefIhQf0OQfmO73RHDBUnKYhAE9CiRs4?=
 =?us-ascii?Q?voDdOEvisYmbpNZOjDHd9ndfXLHzpBzOk6YQPxhiMOSGZq2ueFzvN0msUCos?=
 =?us-ascii?Q?5p/Zy8k9jQtzN/npSFLTElW8QGGNY/vlnUjGPBQveOFdDqZcL9hkBNQHABr1?=
 =?us-ascii?Q?OTsEXHZBtAsioYy8CP7xQHZOOj/X88+LVDpE4p2+TCrHEzScGqMvZ8ID+2G/?=
 =?us-ascii?Q?TmKmqDKocXez33KDM6xYFOKjGpsWGy42/Y3dr0u36ltsUDSRGkellCwdBlcx?=
 =?us-ascii?Q?LUZjeADjbEVNG63BRqBZSPJi5rf0cIEvUxVsznM0yIIK0YSnhBzjdHK9GaqZ?=
 =?us-ascii?Q?YCRVQMizcukLqquM2Ma4ntS6fpIo2tZqv9m0bM/zdstJZ0yJP1oQaYXDuQ64?=
 =?us-ascii?Q?CFWOCOtOMhDOIMP7mKAhks5uEfUa87MWrkJPKnKyQP9ZkaIEhYV0+GkKpn8D?=
 =?us-ascii?Q?ECIMgSnDLAao4TZoQDaDJeT7Fdy1ygTTw6xcsYDumuQVf6rZxQxFTHwY1Ef5?=
 =?us-ascii?Q?qHtMVHiPkBcoBCUotGhmhIRBoolZKXgHFJLNJMqvhCzbEs4ShkAz20Vf+cSA?=
 =?us-ascii?Q?EZlRNP7bHHB/EWCDfdIY0Ek+YJpWrwQSdFkphTqn22FrCEHHDLadfIhF9Dcx?=
 =?us-ascii?Q?bQCJX3R4bq73VE3TEZISfblFEGgRxfU5chp24Id00pPfnxBoK/zCP6itizuW?=
 =?us-ascii?Q?du0TWzhv3dizTeJgDSBd4tsUB00nvbaHc1Vf6uupL5C8Wm0nxfY2NPqLE8by?=
 =?us-ascii?Q?OKvjbX+1ywBUl/oDd+6yL2IDP5xY7KgI4JPKRGr6TfRDKfWEEGsAYOOgWn15?=
 =?us-ascii?Q?yyxHQCUTP7k5PzSb6BGdGpKqJEesb1vK89bT4BmMmUcwlzkGoAOheNMqa+Dc?=
 =?us-ascii?Q?50oOFclbLepaTwn0bYen1dGp+f9maV4x41MJyiFpp29RWn9PB9/U21MXyAsH?=
 =?us-ascii?Q?uZngPyy2wYPVbAxE8q8JDe/jfmfIh6PWUTmQlLNAsfO8w/yBJz8ksF8G24w1?=
 =?us-ascii?Q?ZAisUsrIypozfu9rUxQxkvcndAvPLO19dtBd0mpEsn6ek7im6GoF+5SnPiRi?=
 =?us-ascii?Q?l3FU001YOTy7DqlKpKdMFGkH+aw8cAuJYRctOrKi+nnyFg4Frqu6qpSQqxvp?=
 =?us-ascii?Q?n2xx0qoLYF93JXl0D3zB2TFAVPHJQ4ch9YQkjcM7I27GU?=
X-Microsoft-Antispam-Message-Info: 566iFW81CTXdxgLWUlF4sY1c6leN8KhznwLOGi/OcVs6jW37QR+/RUAo4Qp3NoJUptsoHgB0Hw/dPr/WIAWBwKYnuQI8KtDYuqS4yDTSe/8VM+6pNnNrfikAQ8SnAsVFk4Hm4MHu/frfFQNQxuvyOJ6uS2D5A9ewjnULr6rHtCqEcGdHFAyKah2lXX/rdbxU
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB1023;6:Qk8VydvH9u8+w5eO3PuGhlVSUj1qAZTMssDYVa8nKEf/KrZrJenxcN/FZ7/Rx4NiA9ygCVO7WluOBjihSi4MLF2nZ0jCTEf3YbVgki/znBztXPUbcw2qtfyTFnkWVZ59jyBYIfAdI4715m7j6JUDpPJkG7ivSk/lkYguqazDfVN5qKzVHV/ab+gLd4f3hKa+VHcKKtkw65foV4us7bKia9HQY1ecVYgozGlJWAiJf/2qK2O9cD4jdG2m5s3uNEmtalOFqU3ia9SrEEn6naET6Uc1fmElMwy7sbJXkvv5jCe0ZbbY8DW3kPuxsi2K3GklXb58DtXwgAnm2KkkY2N35EL/Cc6VjnPQDPEvvPmiA1EtSkby6uBe9PdObKArDJBzE8AJh9Cw+jQNFpmaw1LgLoWrHV9az3rIS0juzaDOIHR8Wqczw5AWm5wFiFaq7+HYaOK/nFEADfu/nBJ0nek9HA==;5:rmBM+4EZJl9xgcLrgRMuZJfViuEBx+It+Lq7b+VTVKjHzekNwNY5nC2EENiZmQcm+6Pe4sreZwHIOlZB7S6tAAPfRsOxE76a86347nt7FWmw+vpEoPR5bcMfdXlS0EUxQW3eyrzvF42FebO0u63+2F1LYSBkjg/XntnHRzA0njM=;24:tQEf28afm6+tgeLZGJk38Mz7PedzuBPq8nYr9URs3VLNtwInjxdgjalrV6lRcikQiQlKiX2FZfuCew7t8vLXQx5N/kZORfjUHDE0FMb1hlg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR2101MB1023;7:BUeQnemzCEFIlFXBuH6WxXJXp90KPw2g9K1qjywGW00XeKAakjisquhC27Z50zkDB55jJCS1mw1sbbDiFPxdFjoPYXD9TGNJ0/rSXxqGVK5P+jkRAuifjSLFQzXE8Rs5g+LFpQYUbGzgifzpxAKkUpLaigbo2FNpP03azCLC9Bt7fCHC4GTxFl+8lmvike5V6rw+nm8FMCYJdbHo1ZhblsaQgFV8+HunXJs4Zy7OjzL4ye0UVTMmlgWib0Y6NwnY;20:IPl2AqHuHw8IM5BOLcgNpDM3sdYjVa+iLhc5aQrOtCCS4nMSJugOK2KG9a6LmY4tZZeFIQUp/06YZ5ytfcUvNqzMCXrspdfpjzVF9CRIVXbvwfsFmV1azGjrv5eiFJkcpea+Z/d+wvjmLsjRIdjBUGITLcWOrypfQHegYYSIb7A=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 20:03:54.0404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 704a0fca-9d5d-404f-b22a-08d58e9db533
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1023
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch updates the abbreviation code to use bsearch_hash() as defined
in [1]. It gets a nice speedup since the old implementation did not use
the fanout table at all.

One caveat about the patch: there is a place where I cast a sha1 hash
into a struct object_id pointer. This is because the abbreviation code
still uses 'const unsigned char *' instead of structs. I wanted to avoid
a hashcpy() in these calls, but perhaps that is not too heavy a cost.

I look forward to feedback on this.

Thanks,
-Stolee

[1] https://public-inbox.org/git/007f3a4c84cb1c07255404ad1ea9f797129c5cf0.1517609773.git.jonathantanmy@google.com/
    [PATCH 2/2] packfile: refactor hash search with fanout table

-- >8 --

When computing abbreviation lengths for an object ID against a single
packfile, the method find_abbrev_len_for_pack() currently implements
binary search. This is one of several implementations. One issue with
this implementation is that it ignores the fanout table in the pack-
index.

Translate this binary search to use the existing bsearch_hash() method
that correctly uses a fanout table. To keep the details about pack-
index version 1 or 2 out of sha1_name.c, create a bsearch_pack() method
in packfile.c.

Due to the use of the fanout table, the abbreviation computation is
slightly faster than before. For a fully-repacked copy of the Linux
repo, the following 'git log' commands improved:

* git log --oneline --parents --raw
  Before: 66.83s
  After:  64.85s
  Rel %:  -2.9%

* git log --oneline --parents
  Before: 7.85s
  After:  7.29s
  Rel %: -7.1%

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c  | 23 +++++++++++++++++++++++
 packfile.h  |  8 ++++++++
 sha1_name.c | 24 ++++--------------------
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/packfile.c b/packfile.c
index 7c1a2519fc..ea0388f6dd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1654,6 +1654,29 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	return data;
 }
 
+int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32_t *result)
+{
+	const unsigned char *index_fanout = p->index_data;
+	const unsigned char *index_lookup;
+	int index_lookup_width;
+
+	if (!index_fanout)
+		BUG("bsearch_pack called without a valid pack-index");
+
+	index_lookup = index_fanout + 4 * 256;
+	if (p->index_version == 1) {
+		index_lookup_width = 24;
+		index_lookup += 4;
+	} else {
+		index_lookup_width = 20;
+		index_fanout += 8;
+		index_lookup += 8;
+	}
+
+	return bsearch_hash(oid->hash, (const uint32_t*)index_fanout,
+			    index_lookup, index_lookup_width, result);
+}
+
 const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 					    uint32_t n)
 {
diff --git a/packfile.h b/packfile.h
index a7fca598d6..ec08cb2bb0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -78,6 +78,14 @@ extern struct packed_git *add_packed_git(const char *path, size_t path_len, int
  */
 extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
 
+/*
+ * Perform binary search on a pack-index for a given oid. Packfile is expected to
+ * have a valid pack-index.
+ *
+ * See 'bsearch_hash' for more information.
+ */
+int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32_t *result);
+
 /*
  * Return the SHA-1 of the nth object within the specified packfile.
  * Open the index if it is not already open.  The return value points
diff --git a/sha1_name.c b/sha1_name.c
index 735c1c0b8e..be3627b915 100644
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
-		cmp = hashcmp(mad->hash, current);
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
+	mad_oid = (const struct object_id *)mad->hash;
+	match = bsearch_pack(mad_oid, p, &first);
 
 	/*
 	 * first is now the position in the packfile where we would insert
-- 
2.17.0.rc0

