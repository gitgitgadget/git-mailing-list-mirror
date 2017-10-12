Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DEBF20372
	for <e@80x24.org>; Thu, 12 Oct 2017 12:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756607AbdJLMCr (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 08:02:47 -0400
Received: from mail-by2nam03on0109.outbound.protection.outlook.com ([104.47.42.109]:35352
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756288AbdJLMCn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 08:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ktHp6PgOmoaNGQm6giN+HUwwLnMJvgt2Ar5JA3+GDqI=;
 b=Bv4khDyUUR4z+pXTAEfEP6TnZV6FnqTbcQzBtq4nlwcHOOW/v16xX3ZDlJmAZUkPGUc6yCdOW5QzbMkFBL0k6kT8yGeJj6QjZKKec6mZ6yYfSr2QFzPP+RCcqqHMTzLC1fVI3kIbobi1Nhc1a46xboR0mm0McTtY90nWvFudqA0=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0729.namprd21.prod.outlook.com (2603:10b6:301:76::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Thu, 12
 Oct 2017 12:02:40 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 3/4] sha1_name: parse less while finding common prefix
Date:   Thu, 12 Oct 2017 08:02:19 -0400
Message-Id: <20171012120220.226427-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
References: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:404:151::28) To MWHPR2101MB0729.namprd21.prod.outlook.com
 (2603:10b6:301:76::39)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a67697-2fba-4bb1-c815-08d511692413
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603210)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0729;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;3:oIOkT8ZZoqbx9kn1XRCn1dKJvBl/QgAkxRX7+UMCuS/rNTF+uzvhLijYjH3QJM6KcJMGY7/5Lt9vb/5K/iQ3ddacHBKuu50/txXlAf8XU3Ksz2tDo05FFn9PI7JX68oUK3J75h4K1UQVidShySx1QWc6qw/B7uYP37DYP1JaWdB9TTKLEAgZfC49pjxosNQjrLHByrxgI8x5Agd2pX8jkFIgaj7Ixn+97q9vg2kObjPvSuf/OT91SOE3WZYVpcpn;25:jY5LtfE8fPhmqJRo071XrNjVcH+0ZfAk6voX5+R+/FXh5xuSSu7sR+jRxEW1FkblUCHFxz37jaE9fQC2Xxs7im5SdvDzsubB2sCh54MYpNQbC7JKSR6SBmOzuTYYGTtePxlJ3AhT7gZp9i6OtmxA036NeSlwn7mFAqcLJIm85N5tv4ZbX425m3IPIJlXs4NGKNqPNLa5C462U9XkO84hh5Kvev9i+JVkeewywuGeSiswMykfPvbW+sTju6e0fb//qcNOO5aAzdRYNRkCyOAbJYQZMn2yDuKIcIpCTMgen433jiVRnp2PC3CrycuAC4Z+MMVdgOas9O9xh23qZnUujQ==;31:cWIUTPGTb1yTKu7GJpMRlRpCydsGs04rNoZPBU9Ks9Tw+brKE5j5HIPqHqhQVGSsA1ENZ/qQ+afyWC7wS+o0do/g/hcsuYH/ZdEcBnmfwhWKoMfEJ6am0cq7Ebz2QTrbSo0T2u/xuFhzpquJTw7gWzPr5cBoMH90DTaq1eemYZ3JpMWtVL9XGHSJsBLOA0ZwiBGjFc+s2D8RCsRysz+1zMYey69D01KZ/TQlBZRaYQ8=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0729:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;20:3OQcEzYbzLY6Z1AoYYm61dsDIbb19YWlfCo7geyHpqRF9KNMBK5jy1Glru8Qf960YrYYXSLQKZIOEGADAGsdE1Bch+HsVI50lxrh4lm1/2zF4q7ciWJ2m0zHDipJjc+hFXpX1KW69w+wjFz9cJvwCsPFPhoTkKidoCIuCyH1qcRqqTWslYzZvwW2iPrj3cmuNvpiHFjvRJ4cptSgyuwEJZb8d7BWSuLDw/cMb5kygwdSpN5o4kkBeZrMDS271J9WgowIkLj5QuM2pGHYBc3Ur0w8oqjPwY3GHgvZIjFA5ZBIknyZHdpcLvj+6qJkat2chohewzINQfVtHq2gpY3sqfjmSot2o4RNTrz3Z1OcBWGU7iEYy++plsrjtYzSfxS0sOlJUTg/rk8ZNuh2ZH3nUY7wLFQC+Zine3rJylX03vT9bMUaxRooIzYI6BNJGw7ShSA2HYR5rc6FB4Cp0T7SWAVAq4qtzNKqCPeqoEXn4ACgSrwF10kK3lvdn8ixWHU8;4:Z4Lbj1US+KMTYZsvWXWObb2oywyz8zsD7n23XsxkegH2UsiUpe91gsw8Yb6+U4Lc8d+5YDgXbCCAhC832vrfDsXx086FSFNe0Ucfsz99U83TTD5eHtGMS3W1hm6FgnEhrqsOFJBZQKic9VQCKw9tknV1QOS0G94oss/pZQS20gdAffHW8LA7xCQrL0CQF0+0lgrdVkE7IcctZ88Gw0Iay0KzLGx8k6Nk4P5qIkxbOZig8OGlkfNVmoi957G3onkSuBOPFeiS4efHFl6k8t6gpMnZoVBp4fOkGJEfTVy1zD0=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB072975F154A4BA7CC2833521A14B0@MWHPR2101MB0729.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(100000703101)(100105400095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123558100)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0729;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0729;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(76176999)(189998001)(1076002)(6116002)(2351001)(50986999)(105586002)(106356001)(53936002)(2361001)(10290500003)(6666003)(478600001)(25786009)(47776003)(33646002)(36756003)(305945005)(39060400002)(4326008)(101416001)(107886003)(6486002)(97736004)(22452003)(50226002)(48376002)(68736007)(7736002)(50466002)(16586007)(8656003)(5660300001)(2906002)(10090500001)(2950100002)(86612001)(81156014)(316002)(8936002)(6916009)(86362001)(81166006)(8676002)(5003940100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0729;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0729;23:IaDbMsepCJzLmCmh4tw98kXYcgrhxEnQgGKISz/?=
 =?us-ascii?Q?O3fw/IerWyZe+tTt+biQIblc40Vk3hsoRUSqCcBxrFfwGa/rJYTmBAtL7JCQ?=
 =?us-ascii?Q?gLODkKD6petAtlHaK8At95WMzY4VEYEmzmB+stn/jfm7lhW1tAv1tJel4kkm?=
 =?us-ascii?Q?q0cgw90eXr1wSZ14KAnCWT7yfD7T0PM/CWgf3zDXshoLne1b+j4swTgxiyxj?=
 =?us-ascii?Q?jPIg9ey5gbpSHsQkow97FdrSUuAY6uxMlK/R2ADt0Vs4kmZJw3zDQ5EGAjxC?=
 =?us-ascii?Q?YlyvuR6AWRltehYdgsj/K/PtCKqTzqDvkon9VGbCNomzdpBLl2LW4ybEN09J?=
 =?us-ascii?Q?2dUdSAOWoh5E02FXDnpzHAZesZIU9v+7g4DoM58cbFDrl3qLj3un3dnxgV2o?=
 =?us-ascii?Q?GizYHPB6MVBbLryjQ3ditqsV0dKLzZSKHVZyDQzM+gEdRXCnMVZ4IEZPtVXz?=
 =?us-ascii?Q?j1YglcQSGztru8gGVPTRZG/JzzzCLL4fidM9GxWQb+jhsPxskkLH4NA5R+7A?=
 =?us-ascii?Q?8TMvm943X1s9/mUImqhHYG04qhv5fTJwUBJpqoJNwMwyUqsNhQYNb/uAYnO/?=
 =?us-ascii?Q?IuTGVpYkkhZ6eec3tqsUDAyUWOhG3ctK+Oy/6h0x8mnddoFLVY9qobs+x0a/?=
 =?us-ascii?Q?EcGKW2ZofGHsYbXyZtf/j8iSzobTz2jPaSD7APFk86CDKOTJznJ/1gYKivjK?=
 =?us-ascii?Q?B6dDuTrRkpEzqmexmVwPIQ+54481/jCWzLjnjidwErpZonWuqoq2XpPapp4N?=
 =?us-ascii?Q?vainzMRBVli8DhL5RAkJI3XLNT5jOdJuO19r2qTiFtLJnIBWVvlWPbNxdWi7?=
 =?us-ascii?Q?x4H+GyriiddzRJwoydiVNIwc78oxL5UUMXNmO7XX4TKJKC4ZAi8/EqTnaIix?=
 =?us-ascii?Q?kbv2/rWzIY8hACi8L2dlU8ndGB8hFpyxAOxDZK+8QXIbRIeIjEYZqkPdrkij?=
 =?us-ascii?Q?tX9xxRKEfu0Vgw4zOqYx80MatVmKBQFf1YA8qmbWEaI6YcjvJnjy71FR+lcF?=
 =?us-ascii?Q?lSyGbSRT6FNFS+P9dkjAShMkWjvTCtQaa5+0X3mHsNr8LyvizgSMzXNuKqAT?=
 =?us-ascii?Q?Sj1Sf4DZ4xXANAmUylvTgOWx93FzQO/rLkGCPaNnYA2I5gI+24txHkYfgb8f?=
 =?us-ascii?Q?XV+AOynX52rd5Aq/XnjmWX/hDjPvHl+9Lg3gIzIvxJxp1gaqf8z9axmqXYZ8?=
 =?us-ascii?Q?SIvRCnAoulMzcWJyu9xqe8iZvyXp1f2Y+nFAaXggyShug4xG3Lpch8x40T2d?=
 =?us-ascii?Q?a9H78AUQEQTZipWtPMJE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0729;6:FRXtPotrAjiSj6IrR8ztnJKKdiC6lYOaezONTJ6uYHPm8WbUC5CroWjG6TuloTh/uuxEbhsPQYEbnDs6EZpsq8HSxbA73fq10PY3RsVnpL/bgOFni4L6CR1y4hIrhhoMyEucFDK19E/1JF4v1iQWfrr7uPaIjeGbF2LARAYISx65uVCXSw9eaTnWW+2wXimgqe47Quwd/bHXIQCG8GrKZbF709LDmK0fDiF7aL+mHZGpxl89Y4ysLnocSDh0mNtHkjBkSDBmt5AiI1AX9QjBgmyijxwvHY1eF3hv+bFMimahz8p96MAX7MqmFRvWtr7gF3uatv4EKFJZ6bFKKNby2g==;5:EJNBdkpAY6uk8oAxvw0uDZtbs5RdokiZ+CWoeHYXQE4wmKMHVijMpTc1n9eRRnE2b/U1CQt1L9ypE7Hfbcn8Nm09k3ZJPUivwXsst5rj+sc6iokKdNps0oFw4/BmVj9YoPilCxsqlzJ5hb02iQZdXr34Q9Mx5yEcl+Io83Lexdo=;24:AtSUw/Yf+4Q/ycrSReUHLdf8oen4OWjD7OFLMvMZi2/oGsrZm6d4RVd686ZHaB9M5R1Y5dlDkd8L2Vd2o3Wu+ly5VMToPREzWX67NTklQuM=;7:RhO6/yT+V4HKVBiIJPSIkkpeHMg+Zf8QvgIpt5xMxlaFhyZqUqZtffivFSti1DdnPo9awWMRb0UAyJQE2E3j9D3gDQLW/RDSFv7U0gFGB+NK8vWf+wifJoeHb1VGA7fq86uHSwLQ1p5qu4uK+XhDz8vD6ANZ8LNVIEkwqk7Ccyvdx9uS0g2X2iO1+TwbO7XaLSoAUAbaU/F5rec+kDghtfNb26FstPR4m0lE/A/Awcw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 12:02:40.9651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a67697-2fba-4bb1-c815-08d511692413
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0729
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create get_hex_char_from_oid() to parse oids one hex character at a
time. This prevents unnecessary copying of hex characters in
extend_abbrev_len() when finding the length of a common prefix.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 19603713f..fdd2711a6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -480,13 +480,23 @@ struct min_abbrev_data {
 	char *hex;
 };
 
+static inline char get_hex_char_from_oid(const struct object_id *oid,
+					 unsigned int pos)
+{
+	static const char hex[] = "0123456789abcdef";
+
+	if ((pos & 1) == 0)
+		return hex[oid->hash[pos >> 1] >> 4];
+	else
+		return hex[oid->hash[pos >> 1] & 0xf];
+}
+
 static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 {
 	struct min_abbrev_data *mad = cb_data;
 
-	char *hex = oid_to_hex(oid);
 	unsigned int i = mad->init_len;
-	while (mad->hex[i] && mad->hex[i] == hex[i])
+	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
 		i++;
 
 	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
-- 
2.14.1.538.g56ec8fc98.dirty

