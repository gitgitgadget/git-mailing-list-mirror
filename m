Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B75C208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 20:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdH1U3m (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 16:29:42 -0400
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:56768
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750841AbdH1U3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 16:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tEN90chmUbzFf6VczOrPzEjO9g0O1U1IDKUeiWGCzU4=;
 b=N2kooeUIf+vxk9bmEh5XMMClGxkWuM16Y2++z5SIToHkqNVVJzi4TG/N58IoiOwTP3e1GPXmlsnS7dPN2v1HXvjg4tAkIp/f+Nm8hLty81Psf2RRYm1Nqvaraytk+L+HzWxYpJ1VMElUiPFJhlbHmEht9k5Pl9upaHFOdhcPueQ=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 DM2PR21MB0043.namprd21.prod.outlook.com (2a01:111:e400:50c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.13.0; Mon, 28 Aug
 2017 20:29:36 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 1/3] merge-recursive: fix memory leak
Date:   Mon, 28 Aug 2017 14:28:27 -0600
Message-Id: <20170828202829.3056-2-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.gvfs.1.1.g44deceb
In-Reply-To: <20170828202829.3056-1-kewillf@microsoft.com>
References: <20170828202829.3056-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:910:14::24) To DM2PR21MB0043.namprd21.prod.outlook.com
 (2a01:111:e400:50c4::21)
X-MS-Office365-Filtering-Correlation-Id: 825be606-d341-45d8-26ae-08d4ee53802c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM2PR21MB0043;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;3:conS2uwPFndeToMaUOmeJ3E+LW7QiMiyOXiZYrsvbHJdwDvcjUFAdiYIYE8E1Zfp293EMUBXTzrIrIhcu7OwAJ/+JFtot6l9gAEEb3u/5UUn0Rx2nmW2TZAMxCd+XgyThleZ3Py9GnRJV3+bNwOSofArFL41PnCU66Pz8U2BpEEpxHUEoCkvpkxAjbzcaobX7N2LGyTkSC+iT8aObrh6U/JhWyZ4F+eUmfxsBxfHD51KLl8zTrXy58fQqREvzI2C;25:00i1gwFd8yIMUlVMZbNu5TPlLP1o6IFHZDcKXaCmVyoXPMDW+ZDxh+1sjGX9AXMrzjDXuxpPyKYfcjZRgn71LSB9l+Z70rIbVeMwJ9G9lg5ImDuqiDOupA+H4G3m6eGCDHN+CuCrErtt8xcRc1H4K7KJZ/se6rMBQCHFLb8C9EltabIockzRElOmosalL8VqNGH059XHmTu8g11Lpr5+20GUK9qvbMBWizc+/ZHhq/zK+kbFEs3tCCwnVi1U6FaEtLwTdPw0ZZjrGop2iLfacCSrhlixi/k/dfGomdENVgEchhG1SMiTa69Mkn/Eiw+OcD/thnFujShNutWSddNKUQ==;31:Wt6N8MZhf/1xn1r5puzkUfs1j1v5pK99dUd43OXWNeraYnChPdxEjJQHKEjX27HJXCc2zxPnU6JAIAd240o3AnXcBGjHCGwIvcw0AQSplhkU62pIEzsVgD/aa9zYg37uiTSU/SaaxoMDsBhNiPVZ0wzvfW4TtYY7iZz5Hieg6NRa/0FhPNvriRmiorrgsgAdfH4VBXAJcSQVINhqRjY0x3rVzYMpWE/LC6td+VO4iV0=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0043:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;20:OECDvAal05wDCJVfY+MgbBYfYd9VlFxqZWcdXbwfNoVzsWJ1HxzrG1NeDbst+kAFFa8DRiKrR69hnlPPvV+Dxju3q0qGqG3A49RoEybW0ZQ+B48ZSSvM7wyGjw49Qfrbt3CumhoE0EsOFBz0GhMK0KmI2H6yBJrVNSH6UP2Tg9HbP/02MM4GURx9crogfu4/E2xPkp6VRGbT3uGGYn/RHQ5hlYeRdPGzqpnnQlOehkAalSPZAe3y2HztBKPgL1ZfULvo6rMm3FujwFwGaKftZguGRtvhnOR5mxIFJN6Cx/CoHh+qVIy1YE4qTg1E4ah9jpgTni0me+HvdXt+Jo5o2Ev3kXiyessUeu6UTKMJFjOtiArUJ5sH+eXvdXD3i5FBFY7MS2nLIgMwi9rQtUGAtNwUDD1rsh4srVOYKyPgk0LaU82h5hGj/gQ/OKNbER2RZ55oHf6keAGnjoyS3H4fppvUggdghz4IkZ5GXD8fmqUYqQS0K2CJweZ3iWaK+hJY;4:8GB3+3wvlrNsF2nUamQMe36DrfAhIlwPrBxLkEDeOUt5Dg4igs79ICxDTfQQw8wIilOfn7rOExXIxVV2re5j49wx+xkPyos8DkpmK+DYVIKP59KgsPsl8gRpTy+j+WsR4+XOgcCkP+RdaCmg9oj9Duzy7+KCFDKGQjWNfsvoSN22kG+mWSHw1QDBtRrnUSf6LCbwOp3V8MO8KV928tLIeY0JCu4Ot/xXrqfgJvSZUxbdBmUTKTjDPsIbvDySrpikKi6RcHwg0aLE9AXoKUm66DKOgSE0iG48XYSIrd0+zlk=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <DM2PR21MB0043A26CF38FFDDA7A3E6D44B79E0@DM2PR21MB0043.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6055026)(6041248)(20161123555025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0043;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0043;
X-Forefront-PRVS: 0413C9F1ED
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(7370300001)(4630300001)(6009001)(39860400002)(47760400005)(189002)(199003)(36756003)(10090500001)(8656003)(68736007)(53936002)(101416001)(48376002)(50466002)(6486002)(5003940100001)(106356001)(33646002)(2351001)(5660300001)(10290500003)(42186005)(189998001)(105586002)(2906002)(2361001)(478600001)(5005710100001)(7350300001)(4326008)(47776003)(6666003)(66066001)(1076002)(110136004)(6916009)(107886003)(3846002)(6116002)(2950100002)(305945005)(25786009)(575784001)(76176999)(50986999)(8676002)(50226002)(86362001)(97736004)(7736002)(81156014)(81166006)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0043;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0043;23:9lOZOEvwIg+keCwZkIGz+C5PF4JWhJI0jOEZuZZ/e?=
 =?us-ascii?Q?jqr42/4zmYkqNb72wDeoWDMHvCmuvg4/1NDUBXQ2xRuRKbethAHRdBt+0Xut?=
 =?us-ascii?Q?kYUvsOJ+BeWi3Xb3UrdyFGQEd/pOQikGZtk1B12zqMn2grWw8OJL7HVtv5XR?=
 =?us-ascii?Q?yRocTtSlYb3OVU6sM+HBxdCvEWDCiUYxinnKNtd7eJkgSg/PHC2VwNpA7Wic?=
 =?us-ascii?Q?QG4rerHVEHzMaXiYiib41Z1VLVR7RmaulAGSx+h3lgHT36vV8HZDTH32Au7n?=
 =?us-ascii?Q?zXOBkE2J1Kk9oCGwrsqHvdz8+SWUDpjbf7JOaVOiserBnjXIyax+BDEAVUBW?=
 =?us-ascii?Q?pGr9/vT+7rOnM9TaZcUgFqIShmssWwxtN3eZefc5i+pwOGiOEV2lxp0489Qt?=
 =?us-ascii?Q?l5nOecGJWPXkwtjy1ck3DmE6H4xbSRep7t2oOF1+iSE1NdPANaahW3Xr/k84?=
 =?us-ascii?Q?VXXzTYftm8b3+6ZeKVtpZ9hN2R5mIQAPfprfYQNbk4r8oJbos0leVPncduAg?=
 =?us-ascii?Q?RIQGQNO46PRzAbDDF9HnXuYxALaHKA88EtrFOKi2iMXPfwGIxYNFqXGgMN9Y?=
 =?us-ascii?Q?0azIWci47zxSwOZr8cPs1bCJoTF+72jRRjASb+JGEbQNgVyZwcaWRJW5QyzY?=
 =?us-ascii?Q?oxbBFyHaz/HHQ9LS1VCQ5jiixOaNOiG7BHm9dc832udeqibyN7yUp3NnOlQG?=
 =?us-ascii?Q?bY/mSl/WFJekE8iE1VPEAPUMFC2CddHyaXcj8rq/xdMnrz6B3FGidrFBKtJs?=
 =?us-ascii?Q?gZqD3qQuUDv3x3AC9o0sQZGUboVAKlBDKTI193OcUhKv8t626uhZAZucDO3i?=
 =?us-ascii?Q?+dCeb8rjIti/anIecxw3gtuXzfZEQs0kFIp0Ry/ZtP1ktFQnpoFjvvkRGt8d?=
 =?us-ascii?Q?PYOCxasYqUBGMfuQD4vpFAYAQZRu8pqpYAekCXvyeYHWS5K0rBrWaVoy4pVc?=
 =?us-ascii?Q?Kj1ik2rcb1UjfVfC+4AK5iuD+vMPhAboJE6wcJqwfRPClX6cQ/Oul2ffHUQH?=
 =?us-ascii?Q?DS3AI7Rvhyp4BKfQNsmWgi7dRB14R/f5yeUUiu/Hjukor6cqGY5cBTe65e/c?=
 =?us-ascii?Q?C/gS6npJ+6jzlWiCMH9nkwy2ZcDYJzcL0Q2ABDgs8aTUpu97nyBqWwhz3tOn?=
 =?us-ascii?Q?79ZsRvpS3uz8Vo+ZDpaUSNI8jWYSHzpuTfl5XK9VDd0L7Z7lhBPc5Iyp55Ph?=
 =?us-ascii?Q?JiHoH9+mPKGuMMqrw6ut/gpoy0c9EGG5CE7DUR1rSjh5pVnc5in0XEu6UKZh?=
 =?us-ascii?Q?OYtXYRI2tocO7ltqEn5ulv/cY5G6L+GePSSJwJtAX//ejSLN4/SkF7VSdeLd?=
 =?us-ascii?Q?ogFkK1C7odWyR8isA+tpbTHk5kYv4kpMJkPbN4wOQtD?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;6:JHsoNfx2Wn1KEk4QShYwmMLBqkwrosYiuQqqz2BqWfbNZ0Z4q2N1fc1L94t0vlIuu4Qo1z8K6SyCfaGbP9zpqoIEIgY4/TOvj6RMfLDR+9Dao7eF+zXrIwU7Q5tEZg9pLLo85Bl20HXt2OICKwiPwuwl9gMrX2sBBjbkCedBe4e47MLBS3uJb+ecDBjrZrk42WNq5drbjFn9UNZh5aovrps2p28ZfMU0BOOAyZL+5d28+uw6+lA72oy+naiNWTAP8HTMO+TQ9QRkXNTnx1ZAwe8YHzk5Icptn9dE39WUQxZ2MgwQnMqtzNhBWw/l49n413sC1ZV03hboWod8G4xG9w==;5:772AIOwAvnFb/QYU7doibo3yiYTMsOPQJ52ON0wXeo8TIgjEOOqunihva1cUYjWsxPM0Qvm2MIbHBAe3ua8NjIAa0S1wrrj3IPX3AjkIkCiGDOuj5+6jfQERqSjYwcQL3j3WSKQYpfNKT+PGGRDvCg==;24:crflAxrHXmd8nnW1XO+5f2iZThyUK6aSHVW6Dw7B0m1M50JWAVb1xBRtYyOD0xlWSNwNUzplqfShEn5KliWr6AeYr/WFRRb9nqV8Ylj7CZ4=;7:EkHKA3xeVjO+jf0wuXhlBwrG3lmXoUk7V68esuJ2WwAJbvGLjz+kzuq391C7FKrvI4ou0Th8bFA1wnxsVL4HBixG/uEuyMIZqtNhkBzGBVmJ1koMBVcNvUGrJ/Tn2HDiKq6BxlOdWhoD2FbjxCAOAnJBprrX88VI6ZVra2sEgWG0qJxxYl0kdIZuqlO5bX2h/D8kUa6zYEwvgqGPvwJYTFoQ7qtHNCT9sxNAckJ7+k0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2017 20:29:36.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0043
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In merge_trees if process_renames or process_entry returns less
than zero, the method will just return and not free re_merge,
re_head, or entries.

This change cleans up the allocated variables before returning
to the caller.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 merge-recursive.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1494ffdb82..033d7cd406 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1956,7 +1956,7 @@ int merge_trees(struct merge_options *o,
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
 		if (clean < 0)
-			return clean;
+			goto cleanup;
 		for (i = entries->nr-1; 0 <= i; i--) {
 			const char *path = entries->items[i].string;
 			struct stage_data *e = entries->items[i].util;
@@ -1964,8 +1964,10 @@ int merge_trees(struct merge_options *o,
 				int ret = process_entry(o, path, e);
 				if (!ret)
 					clean = 0;
-				else if (ret < 0)
-					return ret;
+				else if (ret < 0) {
+					clean = ret;
+					goto cleanup;
+				}
 			}
 		}
 		for (i = 0; i < entries->nr; i++) {
@@ -1975,6 +1977,7 @@ int merge_trees(struct merge_options *o,
 				    entries->items[i].string);
 		}
 
+cleanup:
 		string_list_clear(re_merge, 0);
 		string_list_clear(re_head, 0);
 		string_list_clear(entries, 1);
@@ -1982,6 +1985,9 @@ int merge_trees(struct merge_options *o,
 		free(re_merge);
 		free(re_head);
 		free(entries);
+
+		if (clean < 0)
+			return clean;
 	}
 	else
 		clean = 1;
-- 
2.14.1.329.g6edf0add19

