Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCBA6208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 21:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753628AbdHUVRD (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 17:17:03 -0400
Received: from mail-dm3nam03on0130.outbound.protection.outlook.com ([104.47.41.130]:44988
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754102AbdHUVQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 17:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xbDEevVBrqPmPE4UL/AbOhbOATWmQdYTmGpW8Sce1gM=;
 b=OxVLz4Nh8a9l+P2oU4Zk5b0E9RBR+D7pfFvzVucYSVQ3DdPMyarJai1Kk7obCNcvIKyoAOpPIUetW7rTq4dAKlJUrqrXAMhMlAop3CQgGZcJZySX943x+XQNyQOqgSDQ/nu/+GhELfmIAX2qSXXwz5taz2JDEkeqFGXRIT7IV5g=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 SN1PR21MB0047.namprd21.prod.outlook.com (10.161.254.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.13.0; Mon, 21 Aug 2017 21:16:54 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, peartben@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 2/3] read-cache: fix memory leak in do_write_index
Date:   Mon, 21 Aug 2017 15:24:31 -0600
Message-Id: <20170821212432.47364-3-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.gvfs.1.1.g44deceb
In-Reply-To: <20170821212432.47364-1-kewillf@microsoft.com>
References: <20170821212432.47364-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: MWHPR20CA0017.namprd20.prod.outlook.com (10.171.151.155) To
 SN1PR21MB0047.namprd21.prod.outlook.com (10.161.254.145)
X-MS-Office365-Filtering-Correlation-Id: 006875ce-4e91-4fac-d633-08d4e8d9f348
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0047;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;3:D/0nYi1dheuJwawEJo6aIXFUIyUhxEjHlT2J9dFbg2eRBFi7OLUBJ18gDG9OHbGMqfjF0HHaFrq7Zu4cWWz3Jy1r1s1HCbhOkAcIzP0PqANXr1Dc/AVQ0oNFuLRTOW5pu2u34HjWxLEsX8dMrx7F9LdV28VwWo62A4DAeSzgtjF0m79Yu2FKgg0qrt2ny4R646a3W6ifg7Rd4OXit9D8rGKnIIrmQzchkUlqY/G35py6edEFUv/577FY3A+5m0Kb;25:kmEUZ6TLeVxA8Wha2JruxxN7Q7md+5Wg/mcFzQ9JFBR3Y8vTowZ6wc+R4sitZN6/H1NyqiMTpwKLnFbjc4rR8TnK8nZ6rJhrFV6Js7jBNWhRCPc6ACC8ezTu+jMA6CmdqQTzBdxbYgEZzP46meWInTA/aqxztIw5jwKagvJNIjkIwn1mlFhhs3y7+C3la37JPdlrL0hDsMypfqZlqSj6V/JCD55cUCie/WQS7ZmEadNNIdRHBav+MdjzAzc96vt/8LaZSknWLRZ+oClKJ/XQZqW9IFqAQgx4jWXmJ8PniWaWRmyw3EJCvKMG11WtM6NNsgxCIBHadrWTyIuw8h5d2A==;31:IleKe1R/IPDRSGmWU4p22Afmm1GzSf1+Sz9syymGglj7qD8Uq4rQCuh2swMMKPKWdlCyKEwRHUtk4X/ev0X+2gpsUMI+oq/tqZFeWE4OSHQUoI2sF9ZBKz0dQ7BJoxejTseybgo32yt3Z+SummbNQZH4KKIBgsNxL0sKsdMyLTQOhtOtSyEWd5w48UZRlRyxiDAnrvM4hhbxKxjRHd8yF1vcx1n01pZ5wVCTjz4d5hY=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR21MB0047:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;20:Mr8ad7CLSMktooXTiFXPdRN5hvC0oiOTdiZ97tlzxaIHUqJq8DuA7BpPgk244sDIWKB1ueuH1omsHmQPYnd5HfuCyIGQQdW2nnspKrVvMnJd6Ihu/rbMZcFDn5j8Y8FoFuWeQArrMyXh0LssD1MGuWi8Z70QZooySIzxbxB4PylZY6GGD0J/S9t1OXRWnfxFu0VdkCQD46VxSgSkSzRC13S6MoY3sYb+FHa9/B5tr3nd7rzqWa1dLLWK6ToGtFhzcgUddFrj0thtLD9PiKf3pcI/5vmwPyYlcBpnuE9zit/b8whcSQI7KK2wPdRaGYiR1bP1dJWB9LS57sJR3cqtVHtAHbGM7H8fYinWJ1v8MT1hvgSi1frORVZUu4nzEZ5zY7gaxzNfCj8Hb+xhXXT6+SYJa1Px5eea8T2cV+ByiLkVEuo4IdetV7XrrkWjBhF7JE/2eFFWkpi5Gltwr96MwjaBw2ZeSICeLtyWIM2r8U6yYAAEjTX+K1xBuNO0Xv3Y;4:cUY/ZbmnwDOM4JMvs6uafPHRwCddnuWwbqDTHv49yBAQpT90kY0KdytVjzKVUkFUxu687stiOb/vlRnHzHA49EDspI0zRQw4sfPq0ZUUP+wRXmELHXNQf3UIO+TX4fps+f8S2npCzDl5E/csDp0oPBPeuLUrhD7h/Wu0x1DNxZfCeJ1UO51h0FiQjNGf0zWuQJrhtpCr02CIiZa4b7aXr/U3yPKhg3oPyvW/koLdhkF2Rxc+20LN6a5h8ej6Qk59ZbvBRtclYe4h8fRZYjg1DRja/2qMbNRUeEnAJUJMEVQ=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN1PR21MB0047BFBD611B8513A0F64F01B7870@SN1PR21MB0047.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6055026)(6041248)(20161123564025)(20161123558100)(20161123560025)(20161123555025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0047;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0047;
X-Forefront-PRVS: 040655413E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(7370300001)(979002)(6009001)(39860400002)(47760400005)(189002)(199003)(6486002)(33646002)(5003940100001)(305945005)(7736002)(5005710100001)(53936002)(110136004)(107886003)(2950100002)(86612001)(6916009)(86362001)(81166006)(81156014)(8676002)(36756003)(6666003)(50226002)(4326008)(3846002)(6116002)(97736004)(5660300001)(25786009)(189998001)(47776003)(7350300001)(8656003)(66066001)(2906002)(48376002)(105586002)(50466002)(76176999)(50986999)(10290500003)(10090500001)(478600001)(101416001)(1076002)(106356001)(68736007)(2351001)(42186005)(2361001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0047;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR21MB0047;23:je4kPS1g6R/72j3YxvlE4jTKByIvbnZXK0EVJM3af?=
 =?us-ascii?Q?KtU3aocCu29Nv/t/fgRGXJHRI4mdMNyumZIHx/ahsMWxA4jpCtQ0tUlCAIMa?=
 =?us-ascii?Q?ibetyesOLZcyMeRiXAhifHu6M4IrhCGJaKfkzmp5FA+cZLysEYvZQhdp1eOh?=
 =?us-ascii?Q?ZKS1e2JZDDVwzNqfFrWV2ZbDLbX6CdiopSZc//ZHr5ttWFfyeS+l7XsM2Xb3?=
 =?us-ascii?Q?tX5Q0g7f7v11drUBlHHgh6CRlNx2AW1bC8dSPMlKz8aNrP1yuFCgIF4+mw0W?=
 =?us-ascii?Q?+bpCKaBBlp5RmjZ3hWfKGhOBi4tYioDCPQynyP+KUidyCKYIKfuuEJDTlr3Y?=
 =?us-ascii?Q?42KNVWa7dGHcsaemvGpu8g9/xjSCNppFpNmLKC56076t6w0gCKB/MHHk7iEt?=
 =?us-ascii?Q?9Q+hzbU/bmg+CkZHHOq9nWvNvjIfzZ9H8oZlBMxDhd2i4tVFSy6BRZ1zrQrC?=
 =?us-ascii?Q?ZGfamHTS6p9lnQS3hKnxzf3m4eH7dERreOanQfBr3TI73lODQm/8NhZRLfYs?=
 =?us-ascii?Q?uIOynRG6fdKWUh/ElMcxhQB99l9n0SJwKoJ9U3gvuCkv1+yLtt531InfmqCM?=
 =?us-ascii?Q?Zy6ce2sovRPfG8FEtLBtXl+jXkSqWmF+KqiiyuX6b3yNm1XTn4JKef7DnkrM?=
 =?us-ascii?Q?eCjdjWrXRIP8y0N+ixtAwzHyUKGBkLZEI0UlQ0nqR/0uO8lO8fqr31CDvEVU?=
 =?us-ascii?Q?nWoWNes3uZJFMYtuEaEpRH8H57HdMbhZHpX3gQF1gCT1izYEkJVxSVgLw14a?=
 =?us-ascii?Q?BzjYJwOpnagFsKVFmFNnRXF+RAwWNE96cWKAwP+urRROk/JAFBax3LGMHU1N?=
 =?us-ascii?Q?usOzP2HgtMxflf2TaHiFEb3XABZDknjffkNFnrmWlQCzO4CsUsmW8diScIOx?=
 =?us-ascii?Q?MRZ8IPcJHdg2kqLC0Pfw+lEQScqFhuWoFFCbccRzqaenxaVOoNEcPyJfaiPW?=
 =?us-ascii?Q?vG8NtGUUvMqtUX9kGm+RINBYR8M+ZUuazicSYhG9jOIMrnbVHRdUBBgA283H?=
 =?us-ascii?Q?D7MtaYJq/LtN2SIPsb7LLcIWCOehAw4oTobWfu5/bZ2Z4ikV0z7m4XIAcVfa?=
 =?us-ascii?Q?5JqTUuKD8RT24DLH4oWS5vyX+LU8DOwQ5ydFHoG4SFUDnX0JDS2sCFDhmj6t?=
 =?us-ascii?Q?ZSutFHNInTnlK6MQsXPyOXSG6BKfvN/4PxZtl7wJrf8UhxXDJpd5M1gGlJVo?=
 =?us-ascii?Q?djPhFQvlMpAHMTBvJ3InPiq7Y9KoRTKcMc4jeadJwOLvSMZYkIXtsgTU87E7?=
 =?us-ascii?Q?mRq+5rvqN01FinAhcQ7mkEohVm9he2OekXJPlNQSCRDgTj92M4LUNbhN05tV?=
 =?us-ascii?Q?9QmWGW/HK4jb9H24Ol42v6gNDv5i1rO2dOrSUFuPtv0yudF10hG/TL22n94T?=
 =?us-ascii?Q?UrAhyhCBsv0Om/6E72rhSRvt3pzUf1zI2uCK+40vZZ+Xe+f?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;6:w/2OEw+xFMIEUDVnN0HCqknfSinIhwlgEC0wy8eK3aTKpinRadv9gF+jD/2GbQUBoDxhTc3A81fDsE/znemkz/xI8AHQPljJ0ye/jn+PccsJ5rgOz4HRriQGXiFo5nmWvLEkta+o0DeuhdVp4hUPEb/hGcggMUe2JdkrJkFavqIcFfFSYw3xY5Avwej/sfUAFsQ3zimcB5kYmC4RuIMPL/3doLkH3K12t0ZgyVWr/Wt6UOJnksVkHn3/nLEZ2x3jI15nwLLU6306WS8UVRitj9Tbe4F/T0zJhrQ6SNVzIHszCGa1dzPvUEkSUS4Gt/5ysz9X6rH3CXMMxjyAF3qy7A==;5:jcZ4PVwCwmabsNLA6/vWQDpO6prHSfFeS5Zciidlz0SltXO+NWqn7S6d5ptXK89rLZ6dTewl/7ib7urRVm6ne9itKG7zLXOt7Yhe/t3ulGhahZB8UubO0lMIQeD0VqZ9HWR5RzYQFtTRkr0O0yXGrg==;24:PX0t7l7hPtz1/9SQUYFZK+U+tSWVU3mYckx+xj7xSOBo4CDmXqCnBaWujRZejx7Ek+KKg4pFmODaLcYgp5Vc2Vncj+rICU4wdxdC4pstQhs=;7:TFXbXKO24/pIbzMbnZ4Gms1Faky+NE1j0j6Q06a1PaFOX34pNrPLh5UVCRTz+RLeN9VGajbGKtqaksQz/9kqV18PhHOzDQaYCaoHKaqxP4S8w23GjhDbTAoDru1tLytEPvWBtiWLnYNyaZ0ywEoojcKMCwfufSyAepdNn0IxLsuMuGMAiTx8eMCQiuIJwKrLOnDv20qsW7INc7981PR40UkZXuo7bChAXZeKkQfYa/o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2017 21:16:54.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0047
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous_name_buf was never getting released when there
was an error in ce_write_entry or allow was false and execution
was returned to the caller.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 read-cache.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index acfb028f48..47220cc30d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2192,7 +2192,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int newfd = tempfile->fd;
 	git_SHA_CTX c;
 	struct cache_header hdr;
-	int i, err, removed, extended, hdr_version;
+	int i, err = 0, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
 	struct stat st;
@@ -2247,15 +2247,21 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			if (allow)
 				warning(msg, ce->name);
 			else
-				return error(msg, ce->name);
+				err = error(msg, ce->name);
 
 			drop_cache_tree = 1;
 		}
 		if (ce_write_entry(&c, newfd, ce, previous_name) < 0)
-			return -1;
+			err = -1;
+
+		if (err)
+			break;
 	}
 	strbuf_release(&previous_name_buf);
 
+	if (err)
+		return err;
+
 	/* Write extension data here */
 	if (!strip_extensions && istate->split_index) {
 		struct strbuf sb = STRBUF_INIT;
-- 
2.14.1.205.g2812f3410d

