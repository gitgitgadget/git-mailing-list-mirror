Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3EA1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeCVRkc (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:40:32 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:2404
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751594AbeCVRk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=F2rLU3NWUS0k/ycQp7ZTj9w/9mnvGsllGvPyMVX+510=;
 b=XE/jR1Q69bzgaxQpyBLeK/c9VcFkX0YozaJ4BD0TuMr4a0Kr65WdcU3HtNRn//qCA1D28f3woR204NAyt4r/JiZsUuF8F9SWCfym6AklwONKkCx78bAKDYPMm2IJ/d1f8Y+BEOI58BtPyKTEV8EPXCspZZW4xV/ggwcpiaFeOGM=
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
Subject: [PATCH v2 2/3] packfile: define and use bsearch_pack()
Date:   Thu, 22 Mar 2018 13:40:09 -0400
Message-Id: <20180322174010.120117-3-dstolee@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: f086f987-1393-4ae5-c976-08d5901bff6b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;3:CMcvCc0JX7O0RI91/9bpb+MbFh3Fwytrrlo1TKtZusdsZzD1+2kI7lxOFJSlRaH1Ky4py7bcrJMPOgCA+5iSHRcc3xsOWcJgB/+ou9oN43xdCCOO6d3ubYO4EAaJeZqdomCLsSCDwQ2i9simXRyE1uMuH5hCdutfiy8CxD3aKxMjt8Lvti/Xb2N8Es8zMmJzuc198q1gz3rjP3CGmqKvkTYFxwJ+SD9E+IZWIUJ94YVb6ua8Hjjevz69EJPrNaSR;25:UNjaO4ZrYI6TBM7aZtIFajav4gHexZYolGpH6sAv5O8nWfDp9n7vxNAFvNua9h6ZkqGX0Anv8QkDdfTkuZbLNPE2g73YyxthbT7JSfxfzIxUp7JlClLt7cpPGdWJhup4C8hHq3xMuuSLKtoqBJmr/BIZhhqNortjqIx2R/ylQmhcHzR7bzKI/b0M56j8emEWSzNdNkF7/2KigVBOsXorzLTM70wacxkRJTS7kP+zE+MPN9lPvQwpJ/eh6myyZdExbGL/PMzjw1skrkgPDeIz1yHwJRDTcZ9PIybxi1ojZvk18KzfoZsGvOIUfg5EPkhKIwqZfQDlFHJI9doTMnQftA==;31:sdQZrDFGr/CJ5ivQWC5j2wke7KUJ0BRkOEL1WkHoCupMNXsTgh2e/Tn47HV+NYZrccNObyZz33me7XK14avvmg/Qoixs2qfhGVQ43vwUVk7qNOMnZld6Qz0PMPiSm68XnsCUqpTiaBUrk4pxSma4AxlJOFUGSNUVbWy4VN+/LqxFD4sL6YXD9xpAh7UBISB2xb2ZlZGodmbOW6/2xULLmZShuLiS+J+HQbfY908Ib6Y=
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1015:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;20:5EkMKxltdA1HV4w1dZz873NGMeE7P/M7ZYFWrrzuCLNpw4WbytcQrr+I14mynjv0VFGqBcHpa01TiblxDT1+wnvfYcCpODKS+dPmTJstWR0HwD9JtxgBR3JMvMaldkB40s6loWD1nPEArnjO1a4NzcGlDDi4nR5s5aVavsyCPnYJX01jug3YkJMqmNOuO5ZMH1egTsbM7aqEf9z9UaOfIE/m4bw2VkvfstKaRUJeC2Q+jr/Qrpyg75NQFq2ZJY4x5p9Pk8CNOkSCKvf9vpHvA1glfBkQK5HjusuyAMENySadztFVoN8AvGlp4Xol/91/ZAN0bmiPM1prlZQ3oJaBJKf0EC1fAJtmLs1oBU61TQ8YeFJfs2wN7vyilUnXMJnaAO5EkUe5TypaTheh+NmgqI4F5A96Qm9o5CDOp36+jsFffroujPbp4wh/14O9B3d/ev3mak9+PsFM0Z4bPJoGgN3/X6CgeOYsg8yrOi/Y1Gtze4iouAqJB8OfSLcO7+7a;4:fFkGa3gk5ldBt8u0qeuUSAWNXlZzfGkJJ8GOR5bEzFoEard/Z1NgyqLeBAzKApqOGH3iXXW7GQvCSlEayab2c5bg8R6aDfEOXjMG+qLGscoPUKoMasfjwbzxuKOJWwpXw745sfhP8VH/gAmC0etcReIJLmidV/nQfVkmrcF5qbNMZ6Fb1yMnTn54AJpjU+hl0bXEzkKYa5+GHVFqba6L+qnG/MfOMo0ioFew9OhGl6Y2NML2QEIxqdA4GcGLYToGzvec0tbo8NLP4udMTEpirxvpfXL8xuQlVzdMkcMNzqqUCkOEGHKAj5yPwjN23W6t+Mv7qAfA1T4hFu0iCAfZx9T6AYQkZQycXXoPjCTbr1o=
X-Microsoft-Antispam-PRVS: <DM5PR2101MB10153C2B616CB139EFE2190DA1A90@DM5PR2101MB1015.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(199004)(189003)(68736007)(1076002)(10290500003)(6346003)(386003)(4326008)(76176011)(22452003)(305945005)(52396003)(51416003)(7696005)(52116002)(46003)(86362001)(25786009)(5660300001)(478600001)(53936002)(50466002)(6116002)(48376002)(36756003)(446003)(8936002)(2906002)(16526019)(16586007)(6916009)(81166006)(6486002)(97736004)(6666003)(81156014)(7736002)(316002)(10090500001)(107886003)(105586002)(106356001)(39060400002)(186003)(2351001)(50226002)(2361001)(86612001)(47776003)(11346002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR2101MB1015;23:2btdGoMBrQECcAl21KLv3tdtzVwr+Sh5ANJWJnq?=
 =?us-ascii?Q?82IbPTsEkVG+ptBCY8W+AiT/5eGhM39CVRHkFeyvgsa35CA1ikK0B9IrhhCR?=
 =?us-ascii?Q?38Y5tijLJ/VHI0j3xgrdV1JRmEAZpvgQqASXYIbeuDrE7bJjgyPcau0ARlor?=
 =?us-ascii?Q?O3Yte9C2dEavYdDVlcd8JR2If/321MSvp/jvkF8tPXIrfzDAwt3GAj6GlL3P?=
 =?us-ascii?Q?0VKGWKf4fsTmdagK9XSnC0OndiZFqpJ7kAw2TNv4l/BuC45GdC9Bt5Zh2y0Q?=
 =?us-ascii?Q?3gnLgNQjElmP7gbcbUarPhmXBfHQW81SixuMrj7QLxaQq/naEDs6do3s9Gah?=
 =?us-ascii?Q?zEOCvPheCfuY6/AiG2aa05EctdClDYAyHs+ffsg8MVExQKZVbRIDR8to1xDU?=
 =?us-ascii?Q?9kbA4YaWT7uvIJgcfJxKn77XgHncak7waWDiLCIN/FY0GkTnki7tKcBzkYhL?=
 =?us-ascii?Q?/CDNvQsVcwTChetOdcQvUp64MwKEktzACjeAmkaHFBKXEdR9WEelFiOFfcxY?=
 =?us-ascii?Q?aZqkDwRyGid/TxLcrzt80AdLDHbH/VGZoZ6d/cnd75JbYS0c7HeVxYmzfsp5?=
 =?us-ascii?Q?cWqUo2iVGeYESkMwO83+2sk+MN4rh45+pgjHO3uM6CdkMxzFBWp199vkuLsy?=
 =?us-ascii?Q?C3791jDqAcNA3XbrrSUyFWtD33ixib1pGZngoNR31/oBuwTzUBFuXyexRp9J?=
 =?us-ascii?Q?PLnugw8i+N37bRk7vjlwrGIQOzx1yctKAdN1v81xLJJKS7NhHjO9JNwB2Vsu?=
 =?us-ascii?Q?d33KogmLb5tWoX2UWijjvMfFFFQxE0krdToWCw1XJw1zvoPVgXZG4L3SgeGu?=
 =?us-ascii?Q?gS6kj0ISycjREukLLsCBR2GfpDMcXQJn73nQ53AgqMQo5xUAqEj5rVFmZQoD?=
 =?us-ascii?Q?8yEC4ssB+kjudVQNepBmNe8iA6u/NcIPmE/spebQtutUyDqFFnGvZJJhuJZn?=
 =?us-ascii?Q?hJPU0xxFztKoEF/RmyqrOotV50z7yJjQ/S1t35O9l5nI/tFtEol9BawzgoQd?=
 =?us-ascii?Q?nu+gCnyfUIAusvqw1XxUoExz7lZXNsNevaVADEToOolcILKc/b3dhogvIqk3?=
 =?us-ascii?Q?m4mgeuq+ePa7HoQlLftfUiU5dmdcc9WH3SeuK9SvDaoynYYpCjfKOPCDUHB1?=
 =?us-ascii?Q?gheM7PN+d514spFPjBTeKX1GB+Zc0iY4Ia5UiPONyzh0WFsvHRyYJAuRKtme?=
 =?us-ascii?Q?9vSYOP+/Eztc2pI/8VfVm/YbLqqurs9uuAjWmOsKYmUk3BgyEyPYOtIib2kI?=
 =?us-ascii?Q?7Q5Wws/KnmxOhibVSntK9t3UciExIUprULbB8wop6CGfx0TNO2a9UBxbBQRC?=
 =?us-ascii?Q?FEA=3D=3D?=
X-Microsoft-Antispam-Message-Info: k4v50gc6//oc5+jjBHXf7hWHXNr8gr3mqVRGW+1nMs1wmTbhXan0kVb2oTjyKfCdsl+BaIqcl+W7i4oRanFjPdfCG2/xtgzMErlIF9Wjvwziyko+gu1A+IuHrbDXqaeZnE9MdL1azDHQTVbIpXE8jZF997lWkfZ+6Fl5oeytwqc1ATi/FnUcwfFqLKO9YExD
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;6:DRN39BcoUoqvnif4YWtFiqT0SzAg4raWtDdOK2tWPANnennT7z7K4YjXrULjgcpvzeixcfm38xcrOCNr4sYDqQPFUUeZDbwCHr1B/T9AJnF4JibqQaFGxOlg9cicLx2HbgNMC8e+nQ2zb5zqMRNQHp1Qd3nlVgGSi98HKrocHt/cAhbpZdytzPjJ3qx8/vETbB/T+kBAExZT2Eb4zNgNfA7We3cBw56A3mfuSWj6/RRkwTmQ1k3y3Ls8tHzVfSJ9Wj4AJXbUxfNRs0OcjI1vJ+uNd4yPqDC88XvjxTCew1bnI7D1ystc6NKw9nJ1SR7qDGnTSmclSkvEFzLG5+avE6tchYeMnVQx391PzQARKhBkFmEEclXkwEuWiB250rUN/1a51H7U/JVRSpD91Tv2Wy7efASc4H8AkX76MrofBXsn3NFFD+OQ37J0P93z4IUJZuL8oZ6t3AI4EYnDmXLogg==;5:f8sSPcbZKj/ErYRFRzmew+imG3waStUJ5/dm72KhDC4jLGWtipSd7y4pjH19+S0nSMcnNtbDOxz8SgW4tg1e+AC2AGyvBNa2hde2pB8VC89WyLiOPkVk2dHlf1kjUfFW+AC55S0DK2GvpJcwswhdEAguN9ThRrX0mzjzzaZciLM=;24:gIBkCNaBl+5qKHsi3+Rl6gEUfy3yWyyMz8NEt6HVblS6GEAmfbx9BGifHrvD8CLMTEx8CCMPAThDUspg7SoN5hwPJDakrUhOx6/ikv2Lmkk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;7:Clhd4ycVbXX7mfe4xCkLWN3OpI4Ncpnrbv+QoQqWHwrIp+0U0xfC60e9JxHFI4Li74CGPnXRC5aSuC3uVhNYIHazp40HQuxwi95purg0vW+2rrJrVmOw0TtYozrdlPYIqeTfB3PQi2yCpMq76GmOAwDPGIc/M94lrdyoQw2mZkci3VgVEqEGDjCzHIypfKLxe2ZjbFFasx3GWwhJyvOZdC4NcQWRSoDEnLF0qnbni55qR9b4NM1AmeY1ueRmK6uF;20:4alBOWHcq5Ke4L3hRf503y83mPSzP22USMuaOweGBFiojMh/FWX4NpBWsJSndspMCR/CthH4OcB+rwqbMiGK/UCC85Tva7HBV4kt5SdrvGx8xt0AK/nnpy6+Ki5kM2nVtG54nZtmeDnAanRSQ5zdnMjmmNTD8ypYP2etoXfsO0c=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 17:40:26.1780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f086f987-1393-4ae5-c976-08d5901bff6b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The method bsearch_hash() generalizes binary searches using a
fanout table. The only consumer is currently find_pack_entry_one().
It requires a bit of pointer arithmetic to align the fanout table
and the lookup table depending on the pack-index version.

Extract the pack-index pointer arithmetic to a new method,
bsearch_pack(), so this can be re-used in other code paths.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 42 ++++++++++++++++++++++++++----------------
 packfile.h |  8 ++++++++
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/packfile.c b/packfile.c
index f26395ecab..69d3afda6c 100644
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
@@ -1720,30 +1743,17 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 off_t find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
-	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
-	unsigned stride;
+	struct object_id oid;
 	uint32_t result;
 
 	if (!index) {
 		if (open_pack_index(p))
 			return 0;
-		level1_ofs = p->index_data;
-		index = p->index_data;
-	}
-	if (p->index_version > 1) {
-		level1_ofs += 2;
-		index += 8;
-	}
-	index += 4 * 256;
-	if (p->index_version > 1) {
-		stride = 20;
-	} else {
-		stride = 24;
-		index += 4;
 	}
 
-	if (bsearch_hash(sha1, level1_ofs, index, stride, &result))
+	hashcpy(oid.hash, sha1);
+	if (bsearch_pack(&oid, p, &result))
 		return nth_packed_object_offset(p, result);
 	return 0;
 }
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
-- 
2.17.0.rc0

