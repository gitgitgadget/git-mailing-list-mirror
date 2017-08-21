Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA55208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 21:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbdHUVRF (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 17:17:05 -0400
Received: from mail-dm3nam03on0130.outbound.protection.outlook.com ([104.47.41.130]:44988
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753548AbdHUVRA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 17:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sLVbcCYBr1kRtuhZQU+VhCgYZcdYXbWmYpkhd56Xt5I=;
 b=j2ODpeP6Lt6ErzoHkWIGsPtt3Ny0aTiuAbFKQoIP/pY5tU7YODovPghvusLDNtUXc9wjgP4eeZPI0ORUJ6QlrGRT2GnSAZbYpx0LewHLvIoD19fbmDyKxc8HpiZx08B1SOKVdY9W3oWgnnUu9FY66giZDom8SM+PpLTEiUtbPlM=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 SN1PR21MB0047.namprd21.prod.outlook.com (10.161.254.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.13.0; Mon, 21 Aug 2017 21:16:55 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, peartben@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 3/3] read-cache: avoid allocating every ondisk entry when writing
Date:   Mon, 21 Aug 2017 15:24:32 -0600
Message-Id: <20170821212432.47364-4-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.gvfs.1.1.g44deceb
In-Reply-To: <20170821212432.47364-1-kewillf@microsoft.com>
References: <20170821212432.47364-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: MWHPR20CA0017.namprd20.prod.outlook.com (10.171.151.155) To
 SN1PR21MB0047.namprd21.prod.outlook.com (10.161.254.145)
X-MS-Office365-Filtering-Correlation-Id: 269a9d99-3e99-4555-1f0e-08d4e8d9f3d3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0047;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;3:D6OfzTK4Kz7RvNjzqQZic+p50Jg6hJPQ3ZSkks0Y2gfLagdSZlrON2ltXKR+frDuXeUlmayhKjTRzDgde5xRcXeDKzpIK+CtAI9eqyDKdBz/j4w+bi5+KyLHaoZIthdcES1LsWbY7RDy98fVewYs0jOvGxgI2kNUoj2J3X/Lis4FdsIZ08GIlIdQeOZsZugB46bDv9iBHI7jmCsCWUkDxmYKaQurgXQ660PaY0EDxoQvJNYwIP4Xl9PnCZEjjd+Q;25:PTtRDJWRYz6ibb/NROqTS4ksqqQ57NfZyDjCp0h5scZq9kVzvOYU5v76kEhqcsL6SmcV22ILzU4e6yU4fF6hd7cDTVEPryyiPvcYWgmBxiXkPxCRsTF49nTVj+cSvNlRQG6nY1e+C5tlCUegyDDD0wa4WkrcyyOmwnCZYzU97ni5CluSz/5FEfw6zM7ATZGb7i5yBP3zBFMoQAVNBm3HVf5NWUuR5FKn/SGzVE6Qit1IVaDapRdwCnKgoGvx41c3YSNCI+ELXyYkP885ennl56qGztFwsc6xmrVkBrKozZDgDc+1AZq+6dTqVg/PpSpJmAK+zB2f5AqaoIUZjUSz7g==;31:yFuOAn6Y8uAb15bdNcN2K/RaCVx3hTRtTY0uJJ3tdaLMmSFafm9DaAFWru66EEUHXSftFQH4MKq8ku+khD56r1+5TcSKAY/TV9ogxwnFiw3+6hwF0M/0NkTSRLjDRAh3y6y8fM0l5U+aakKKZ7GvFT9RqOnJLsM+sFdWJD1UdubgjDGK5PqjKM7KmSPva6icv3oiHmaTZwsMTO6fCjjEPIKGqzHeiFgRjonFdu0LxQc=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR21MB0047:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;20:J2nr4ApiDFg/jCsMxlH1H9Or3mVGGKItl1Vo3zEhVtIAMYUsyL6WsFeVPfgGzLzTol++vy0JDBNXTwJCSXTvhkXIH0SZWh+2QON9Pvg+xOYiwQN4tPZAz5fMpBEE66mqrjtzyS8GqKO7OxS9mF9yCxaVANDXvGIpJnvpZRmrVPe5Tqcg4L0WhGDUZejO4Ft9M9CAlz28gmJC10qxqrNNexJNzsvDxf86Ks0BmlBzyvoghjF/yWYBJHy/4Fz3Ou9yDpCam8l3SLrULzZ+RidkX2R2/11Zb3wwvCJ6ynEWoGm9p/oBCP6FOlbmOg5573XqWwqCxwxJO6ssrRCYDDxfw0KxeTd5hGxZbZ0JZdTPR4sDPR/UZFdm8F9xHHygirKW1kSt7EJg6PjzbZ1H7l1KxJdMplGfZWz+uUWClyRO5KUlSM/NzdLWbMaDPDQnkf6ZSsibhpguKQrfZ5rbWXdjdehqI5AO3mv3YYUeGgl0QMcSlH+LETWwpYBC2738R85a;4:EqDXtJDeIEKEB00tmTNbUWRZXMVfcEXaLIZPc/2OSYcGsHJBKcP+Jsf70qr1e05F0W//mNqNJjWkiDQuELY3IV3FC0pu8XhvxhGiOhIqyh4oaBJyatj3c+LToAQ5vzawOgKn89nqjI13Lmq0RJI1RO31nkGxJljsbb8QDc+qyYCEpxnozgQEaPnZECyOrccDhOOjPJpy7GjaGVk4bBSwBxuljZLCwYiE75kyOQ2LsdsEdaq6lXFGjpDag8p6yRaj7c4hZn7mvBDmjHq8YrlMW2wQmhPd9Myd3OJBtXubdL8=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN1PR21MB0047B557B589E580AE7A7B78B7870@SN1PR21MB0047.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6055026)(6041248)(20161123564025)(20161123558100)(20161123560025)(20161123555025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0047;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0047;
X-Forefront-PRVS: 040655413E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(7370300001)(6009001)(39860400002)(47760400005)(189002)(199003)(6486002)(33646002)(5003940100001)(305945005)(7736002)(5005710100001)(53936002)(110136004)(107886003)(2950100002)(86612001)(6916009)(86362001)(81166006)(81156014)(8676002)(36756003)(6666003)(50226002)(4326008)(3846002)(6116002)(97736004)(5660300001)(25786009)(189998001)(47776003)(7350300001)(8656003)(66066001)(2906002)(48376002)(105586002)(50466002)(76176999)(50986999)(10290500003)(10090500001)(478600001)(101416001)(1076002)(106356001)(68736007)(2351001)(42186005)(2361001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0047;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR21MB0047;23:RefD2fODbtuK2ohD3HInM/BTDwoiRAIt2urAtQScv?=
 =?us-ascii?Q?6HflYnsxpqyB5k5MiI3RkpZPA5PyOEdf7y7P4QM/Cur1nx/MVvdYwxXbEQzY?=
 =?us-ascii?Q?ueQx9jrzhEYA25B65BbkLJY9SwbS3AuZmwfeR6oNbvYfu0jgwUUlGY9BVPFf?=
 =?us-ascii?Q?hBZvpVaqU+na3G46yvRk33fS3TqZvz94j8L+xQUVpkPJWpHkB/sXoM+Vh1Bn?=
 =?us-ascii?Q?sL2XSNEHNOZV3Xm153c44MFQBdtvB0EQmtMkE1QNjJgMZVbBuV5oM5DNS+DT?=
 =?us-ascii?Q?RNr4OqGhh39PalLYiKv3uU+JFSsTBZI1zqo+yw6HTIpxsJ7MR1Wn85IY2fPz?=
 =?us-ascii?Q?ZtGsIt+kk7yJOR0rHqFec8SI8ZvDM6oJOM2v+b+S5LZPAG8C1sHayPim4uLh?=
 =?us-ascii?Q?bjW6Yhb6INf4KmZ7S2JgQ+V2ivgWQS393tBWTotlqE/ZwOZeyjiB5A9XP6t0?=
 =?us-ascii?Q?QBA17zwekxzKq5hmgc7e3Gr1JHq4X6owt+8wEJ4qyqUyeamXKw7dsteEOU9x?=
 =?us-ascii?Q?zBh+6KKCWu3s5JCDOHULRH3lN/vAy7Jphowi8Ji/+RwFbdHEwjKdfdYr3hvI?=
 =?us-ascii?Q?5SgQlPPWH/lkW1YxHmWRrkxKxIYh2GCxoGS0cSF91Jq/uRTtT0o/tIi50oA3?=
 =?us-ascii?Q?weksi5VtVm8JioVT5QKyoJ/ZS+A/EBz/wA6VhESViI7K4CfDWuVIMrh4tC0+?=
 =?us-ascii?Q?K4KJbJB6YqqWf6C8Xv4FC8jRW+Ef4aincvZYQLwjQIq0RoY/poxLpqOd8x+b?=
 =?us-ascii?Q?cZHb13ujVVMtqFPSY6k2mF49KkcHzqxriVCQqVsBsBJJwiaWdawLSNKtGNYR?=
 =?us-ascii?Q?UEWwHyuY5xmmzSVZVIVNJ5FCHfX6EAev9I+HwymH0WhlM6W2D9XMNUlVMIw4?=
 =?us-ascii?Q?bUQOlUP/G9dte3e8Sjp4PxtdNsxQVjfXm3pVn2kyc7mUHQ1taGTX3Sqq7pt8?=
 =?us-ascii?Q?VBy8GP8PTeasyaN7B8QkSHfR3el98sVmS+hlUD9ueDLZcX2L3fzp27aB3GJS?=
 =?us-ascii?Q?Xln3VfSv3fQrYFDvB0qfUugDp9j7Vlr7X4WkL59ayrFvBhRFBRUzAXhSABNm?=
 =?us-ascii?Q?wPL8HOt5QZo0sd1WryJx7LWFe5wW6anTZ6n46lpYOAE6MsRGk1xmR/QZVNow?=
 =?us-ascii?Q?6IjumYYVCNxepkJpBe3JfttHq1c4pyI1s6QWx6tM1cLum6xkEeO/lduUrrVr?=
 =?us-ascii?Q?Wz8bEa7wvq+4TuxggRWcoiTsCivvBtEk5M18ZMyzMiqx0TLxRbdmRXcVXD9x?=
 =?us-ascii?Q?WkWgaevdq8Bg7xdW/kjhluzx4PFRq7ZuqD+0dRk7IBdqP//ocJRaMUOeIDmi?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;6:gFH5mVvOOJTaxxPeyp8L1bRWo+L5VqjymuAvljGMIz69151KFiPDfPj4zOYU0hYqN2ez4IJ5QqagFC4vLRhKLt3awClThzvWyAAXJwPonUMXeYb8hPP1CHzW0pihQ4zufLiQZLzP2WR001AQz5yPTFgrQTSvTmI3QbVyufbD6/gzW+RhDSW0XtsiUf4lwGxBNYc0ZNqy7xMm0I4uEIeVkPnCCR1sRD7IHHfn7OzJrLpMHnXjJiXAJlaD2epztK2dv0Lo1wcOfUo7ealA5izgLQjrxEav7tRPY+xYwRbSgDPEFsCGRY+83sLCLJ00C1zEWJrXzsGc209HnWRiykQ3DA==;5:b7FmDMCtfSCaydAiMR5cpOgAD51p01TwD+izNfAm4mp9TERz1vOBl/6f3WHoNEWkyEj/awjL2b6NLpq69Wyh79x+hoQDM1YaEFJFVx4rcKYcoeEWJem/zeZxiDen5Ph/KMqPiynaDHVnY7z463NWHA==;24:Th+Zo1oygVQFaIKGEhVhJpwcEYL059GvX/3fOylo0sdcaxnSsWMsPWgjW6a7Cr8oMgh+U3iY3aX+IsJjoFGNz2HHWhz5kUfPYpitrSR7/Dg=;7:zc0i+zx/oz+PN56xmK6UQfeTm7Go9U4ftll0ktXNzDKk0430LFGbRRtefkHQovkTpwiZrTlaIGo5Qz7C8qPhEd7MpfHcox0xKhPKEoBc5G7iV1F9CnMXCNUU1HamvdMUHJRh1RWD/wp9Uy8S5AXKjyx5MLy6ZpPr51yit/aSar93ylom42kdDF6qey83SPBrStplvKnPbqFotEsRTM7SJl4iRnTg/qQIXaFP/rY0zDo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2017 21:16:55.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0047
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing the index for each entry an ondisk struct will be
allocated and freed in ce_write_entry.  We can do better by
using a ondisk struct on the stack for each entry.

This is accomplished by using a stack ondisk_cache_entry_extended
outside looping through the entries in do_write_index.  Only the
fixed fields of this struct are used when writing and depending on
whether it is extended or not the flags2 field will be written.
The name field is not used and instead the cache_entry name field
is used directly when writing out the name.  Because ce_write is
using a buffer and memcpy to fill the buffer before flushing to disk,
we don't have to worry about doing multiple ce_write calls.

Running the p0007-write-cache.sh tests would save anywhere
between 3-7% when the index had over a million entries with no
performance degradation on small repos.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 read-cache.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 47220cc30d..694bed8d82 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1499,6 +1499,7 @@ struct ondisk_cache_entry_extended {
 };
 
 /* These are only used for v3 or lower */
+#define align_padding_size(size, len) ((size + (len) + 8) & ~7) - (size + len)
 #define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,name) + (len) + 8) & ~7)
 #define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)
 #define ondisk_cache_entry_extended_size(len) align_flex_name(ondisk_cache_entry_extended,len)
@@ -2032,7 +2033,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 }
 
 /* Copy miscellaneous fields but not the name */
-static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
+static void copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 				       struct cache_entry *ce)
 {
 	short flags;
@@ -2056,32 +2057,35 @@ static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 		struct ondisk_cache_entry_extended *ondisk2;
 		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
 		ondisk2->flags2 = htons((ce->ce_flags & CE_EXTENDED_FLAGS) >> 16);
-		return ondisk2->name;
-	}
-	else {
-		return ondisk->name;
 	}
 }
 
 static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
-			  struct strbuf *previous_name)
+			  struct strbuf *previous_name, struct ondisk_cache_entry *ondisk)
 {
 	int size;
-	struct ondisk_cache_entry *ondisk;
 	int saved_namelen = saved_namelen; /* compiler workaround */
-	char *name;
 	int result;
+	static unsigned char padding[8] = { 0x00 };
 
 	if (ce->ce_flags & CE_STRIP_NAME) {
 		saved_namelen = ce_namelen(ce);
 		ce->ce_namelen = 0;
 	}
 
+	if (ce->ce_flags & CE_EXTENDED)
+		size = offsetof(struct ondisk_cache_entry_extended, name);
+	else
+		size = offsetof(struct ondisk_cache_entry, name);
+
 	if (!previous_name) {
-		size = ondisk_ce_size(ce);
-		ondisk = xcalloc(1, size);
-		name = copy_cache_entry_to_ondisk(ondisk, ce);
-		memcpy(name, ce->name, ce_namelen(ce));
+		int len = ce_namelen(ce);
+		copy_cache_entry_to_ondisk(ondisk, ce);
+		result = ce_write(c, fd, ondisk, size);
+		if (!result)
+			result = ce_write(c, fd, ce->name, len);
+		if (!result)
+			result = ce_write(c, fd, padding, align_padding_size(size, len));
 	} else {
 		int common, to_remove, prefix_size;
 		unsigned char to_remove_vi[16];
@@ -2094,16 +2098,12 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 		to_remove = previous_name->len - common;
 		prefix_size = encode_varint(to_remove, to_remove_vi);
 
-		if (ce->ce_flags & CE_EXTENDED)
-			size = offsetof(struct ondisk_cache_entry_extended, name);
-		else
-			size = offsetof(struct ondisk_cache_entry, name);
-		size += prefix_size + (ce_namelen(ce) - common + 1);
-
-		ondisk = xcalloc(1, size);
-		name = copy_cache_entry_to_ondisk(ondisk, ce);
-		memcpy(name, to_remove_vi, prefix_size);
-		memcpy(name + prefix_size, ce->name + common, ce_namelen(ce) - common);
+		copy_cache_entry_to_ondisk(ondisk, ce);
+		result = ce_write(c, fd, ondisk, size);
+		if (!result)
+			result = ce_write(c, fd, to_remove_vi, prefix_size);
+		if (!result)
+			result = ce_write(c, fd, ce->name + common, ce_namelen(ce) - common + 1);
 
 		strbuf_splice(previous_name, common, to_remove,
 			      ce->name + common, ce_namelen(ce) - common);
@@ -2113,8 +2113,6 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 		ce->ce_flags &= ~CE_STRIP_NAME;
 	}
 
-	result = ce_write(c, fd, ondisk, size);
-	free(ondisk);
 	return result;
 }
 
@@ -2196,6 +2194,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
 	struct stat st;
+	struct ondisk_cache_entry_extended ondisk;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = 0;
 
@@ -2232,6 +2231,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return -1;
 
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
+
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
 		if (ce->ce_flags & CE_REMOVE)
@@ -2251,7 +2251,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 			drop_cache_tree = 1;
 		}
-		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
+		if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
 			err = -1;
 
 		if (err)
-- 
2.14.1.205.g2812f3410d

