Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CFE01FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 18:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbdJHSuF (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 14:50:05 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:22725
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753298AbdJHSuD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 14:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oPwhbowh5HRfTqfnoNHfLBioit2SQ53y449XnObYgE8=;
 b=MR688LYSRLChgzldLAcaV2e4hKYE4pnJMafbXrQNinGaZbkyHXbt75LaAxoOL0bm4iHm3IxqeCpz1Sea3uJS425ivWEgOinOZVxW68PViiveDrPvu2ToK4tpGy9krlnmO+TDHfxzEuK1LLgjNTKLht86Yexpv/7diQ2fKXCCitc=
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
Subject: [PATCH v4 3/4] sha1_name: parse less while finding common prefix
Date:   Sun,  8 Oct 2017 14:49:41 -0400
Message-Id: <20171008184942.69444-4-dstolee@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea38ce16-d259-4bc8-ff45-08d50e7d611e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR2101MB0734;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;3:AurhbaUtPk/emLLvLUzJaQutT+DnHPvHvDY+Lo6c9SLBG9HiWrKFNvoSNFoi3B3ROVcyq7lG0QDzls33QD9da+KQlN60bPHbZC8pVHBZYX7aOS9WSwK24UngOvGKMhv2yl/IvEnuGBY/oBUiMCxJwhoq4451kjwpunzsx5QXCXzYWdQmIlwDx09YV7iox39a1aFVdgzIkcUrvwHlV8lBpI/MZcVnwCow1KYJmHuOS+sHOPfNwtAYIFVn1liKYXg8;25:yJom+r+QSz6JnXvW8emW9V+TcRQUT0+Xkgg7cnsqAesdzNLHisY8/cV9EfAIDwgVttwmqY7tswpHvoha05S9S8veaQiRWenLF4Yt3XsVuP3ir0SomTbUBY8PjgJifXJKHw5G6/iasSrJru1q/q1C5++6oDjHo5J1EabKctWT720VJn1rzRTGB1A35jTm5A7Uq9gpH7RO6qKjJfF1wxkT5RYhyjE1bsqc06Gq6srt0/4mmuZjsAZzWYEDSIVKLR12YRQZegVxQf36fU1ig/UYP7u/4DX7XLmeH2VIxAHAR0w5i3BKUIVJxVddsFh8CY/uPItP8svrAbD6VWQWnPfneA==;31:OYju67Zcemr55D6D1I9neFRlwuA5NBj59LELBTcpg9IEm03PpyC4bT2cH1xetuVm7sF223Uxa5PI9zq32PEKTVS22j6VY0PYyONmvhkGCcUzb293Z2csQtB33vvXSAeTUd0jFiKW0UNw08vvzuXBGxXcwLNy9oPw2gQeGrnahTumVYurqksehWH5Do1opcoCOVFlk7wQxOMpdcy2AgNSZVIQVD8Mno+g235jDm/+0+Q=
X-MS-TrafficTypeDiagnostic: SN4PR2101MB0734:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;20:6wqs4iP5mvviasFo07x9V7ha0sAuE+xzMowT+XkGHZqHUEy247vo3ZcwyOaHxhe66AQWeWIDuf03cC2BzROmmn1XYgtK33BP+KFa/x72d4eLqz5ybdcYzUOtxyyRB3mLoyEcseSJgfsxpLzc285KernwX0oObaeY3Nz5CqKHyzYuyGcmdmMgFkKsAls5ZbvWS5fquTpGb80zY1Hf1IxxEDHZuo88OqaamABU20XimHWYEK9izTIq94RXqzV8rMYg0FL87+dDqhgqTKhzBryHFkEDZsHyNUYdqFNwVLuKivOHfVowB7hlMzyFkNKkIQume4BjAhvCnOwrK3uRmt0eY2dVJS06l3hvC7soPS95AlYtmag2UjkG1OUAfgzdz1JWkDMoxtZaSk9roB5H+3n1qRu/FyeojxUcvjgdYzbi+2brcMQeE5Sjf9Ou9FlC3U9R6yVJnoVed1HK+IgXge+x7sLbsoIlHSxCfgbaln7/XF+JjUjZp7xAc5a3X5ycOeAr;4:9Dt+cBYxslGU6HpB081LqVYRCupWMJF5zOar04BWhOc0qqAgb+jCEUjmYb8gKRuPz6EjHBd+1Z95nd/PaV9weNx9Z54wQsOM1kOH9zkyCMc2YwnqRpx6GiSCGm3ZkoWbZGeSiZUuEPVNGSdk0X4IT33nJ9m6LVG2DN2iHBdfC+e4QNwJeNeZFPAoG3GfQR5zx1MCglPBd0BnLxADunzp0kOxh1LAbu4N2rUz3U1DH5Z39CyNfq92/GaUq+vyUGofh1Zpc+SUWDfwI0+PIDOk41rmOLbzZZKO1+liBG4pvy0=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN4PR2101MB073474C15902ABBE2CBB8283A1770@SN4PR2101MB0734.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(12181511122)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123562025)(20161123560025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR2101MB0734;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR2101MB0734;
X-Forefront-PRVS: 0454444834
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(346002)(39860400002)(47760400005)(199003)(189002)(6116002)(6666003)(33646002)(2361001)(81166006)(81156014)(47776003)(6916009)(8936002)(2950100002)(50226002)(8676002)(97736004)(48376002)(50466002)(2351001)(1076002)(22452003)(10090500001)(189998001)(25786009)(16586007)(86612001)(53936002)(316002)(4326008)(5003940100001)(36756003)(39060400002)(107886003)(68736007)(6486002)(106356001)(10290500003)(5660300001)(76176999)(2906002)(8656003)(105586002)(86362001)(50986999)(478600001)(101416001)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0734;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR2101MB0734;23:m/xwQaPQ78plG25ucjawpHqR8b5GZ/KqAgtAIYC?=
 =?us-ascii?Q?A0TGqJBf9vd9fPywTThmetg2h+tljZq4dQdwZtBr2jHFEmAwWviEQSuLEXbl?=
 =?us-ascii?Q?QQxZHuRGVGSeKYE+g3FPDVXDM7keCbdi1l7TpnQZNy7BZwmauqm0OlQ7XBzW?=
 =?us-ascii?Q?81FpsdnMf8v5pfiuylM7pSw9mKJSX28iHfxArp9o7kOu/e9scz2UNQ46xqPD?=
 =?us-ascii?Q?bT/z1dFWpyePIt0/8kz9+pNWGaneX9eEzugq8j6LW0jkXBkW2iazEnc7o/jG?=
 =?us-ascii?Q?JEbGMd+3HwXYjRIOpJoYSk87LCJa5fIHWF9+iKQya6D5npl95PwA8ENGY8If?=
 =?us-ascii?Q?buKt+JzAZtGqcLvwTC6k8KeQ46ydEumFEqgO+YuVBOcqB9S2ELZxemHnWxIU?=
 =?us-ascii?Q?O6cxPZyPzNQcU9KgBqlwXZzDrybx71bosSryPdmUiSsOWgb7jGW3NcGEb1SV?=
 =?us-ascii?Q?XLMmlvfp4MhqoDTBVocRLJScv27SUFyVEMC7xd67j2cL/MRBYVGaEzG5NA8l?=
 =?us-ascii?Q?ZL2aH+OsTiZmpDkUK+YJzwezU739VfX3qL1UBWMXbaS1F+Ga34L6f7uSNE2h?=
 =?us-ascii?Q?l4XceHXvxfErMp/95Mch9QSOc59HpRP/nddcuYtnr1LkNvrGUNUWLZUll85L?=
 =?us-ascii?Q?66J/Ix4qyFRtcZWKdH7Fp7aCrBW+9K6Q+d2/HsZvDGZfNC0eyX2/ccFJi7RK?=
 =?us-ascii?Q?oj+x7mZYEKGx2rlUqxORlvFwczhFs3RYX82yW/fs8Y6hKwLBjSYvFrgDyLfE?=
 =?us-ascii?Q?4kOdN1ZbML4DkGUyzxv3d6oU17n1WftzJFhONu928ZlaFXqPHOkVW2biFmE4?=
 =?us-ascii?Q?hl1hPkk0RSa9uw6XWrg48olxTvRiRZ1ybAwWUyCq4HHYNPtg57KQLsGXpQ/P?=
 =?us-ascii?Q?uFz8W60Boj1dajOH2C7OWm0ETNJwO02w4ZKUvZ9ecJZlj9EU9vZXR1BJhG3R?=
 =?us-ascii?Q?teR8dPELnCfuBYDWUlH/5ehiVo5Rpxr00ePOJQJ6Jf64iJ5PvGPU+YgDN3zY?=
 =?us-ascii?Q?sUM1V2iNXCyYlKlpx4HhNejn81Z/C/3FOKX+uZLYx6YbY/oBBI9bSgNfP40o?=
 =?us-ascii?Q?gN4iI1aJw9aQ8eJ+46ec/MCF8oRYEExt1LVAUYytdmUJAqnYT+vBd5nOu8aN?=
 =?us-ascii?Q?XsDtcZeFJxEY7lmRxTEhOeJTJxc9JDfXdt9xPUOlEK5iMzso/7/9+53IHJ+Z?=
 =?us-ascii?Q?HNNCPyTKSW0NDUjwKD/cRVEU7J71BkTzaIaIH6GWWK/X7i9w0A1uI9sZrSW4?=
 =?us-ascii?Q?ZBdZqI8XEp6CpPEi8Vfg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;6:0yEuwhhQweMYeINM8gprTQOBwVzCb2QYZI+UD5Ef2op/3Qlee+y/dPUzGr88vey0eA5s7uaJEC8qK7sGR1jF0KpHPzXa/pIdzXylTBajMWB7Dgkux4rIYBNUiVawfU4e+awb/yJGxUq2jhr7fViZ3LF0Zlx1r7bn0MNbNi/R/eZ15mp7bxqXMjHRt1eBEiVuxoRu8jtNBw+UX//rA15pykwS3+30+kve2EASGf/h5jmmyaP0tnnHm6F4bo9OETRhh4SEN/cJj+tNCr+3a58Io1+B4lF4WeZkGNDKhOVfJVuDoDAjw/EfwG4lzRgMw3zNdq5fcHQQzL4cG+3nzfPDfg==;5:AALrmWN1ahTC/EJWz51GwOEtCnmyTOv3Qa6XS+0o7KOTY7TIvDQFSmrTatV4lrb4jIs8ptsYglM303i/wB/EOkwWZhc5ufoS4iA8/p15tSpwiNqGE3CzYTCtGeD2g/lRUAWOn6vHBzDvlrvCgPAJeg==;24:mH8Vcpng2t1wEv497avwLytORPJ662s73Y/EUzcpwQiuLfi3FUrspkQTwNUKT9wmwYrQmxh6IXCPzX1jae8mIw0YQOJHzm+amnFNHcKUBVY=;7:uyoW4bJZbErvO/RZ6xOr4ovu8B5eEQZb9DFXb7EQcMV2nIpi+VdYBi9uzTgQV1EJ9/upLRAUGCutZSSCYNT7vULK3k0YZCRwIL14Si3zCTyTTAfOu59bE9Kl5uiD9Epld+7H4n6MBhbSFfRcmiqiD9fEh/jLGbY2lR2S6n8r7//ZaDpCtVE/y4SVaQ/JV0QYNfN8XLcMQ+KifevjXB4P1vJFa67aCYvnZDIIkeqYyzI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2017 18:50:00.0134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea38ce16-d259-4bc8-ff45-08d50e7d611e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
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
index f2a1ebe49..5081aeb71 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -480,13 +480,23 @@ struct min_abbrev_data {
 	char *hex;
 };
 
+static inline char get_hex_char_from_oid(const struct object_id *oid,
+					 int pos)
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

