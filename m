Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2CBB1FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 18:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbdJHSuJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 14:50:09 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:22725
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753556AbdJHSuC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 14:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IxsDSs0TrfxAgkHjfvdp2WV8yjjpyMWsp+sPRgnYz7w=;
 b=CxOtBYMIjNabjVGqgZXwk5PoJHH3w23HJ28u4ttyJ2zmFFSlkZ3XR4ERcwb2q+sjDRcen2oaao4l95m3TpjfQ6AmGavyC7TkKO1hskGS5QySWJ4Cmj71mzm8eXWCAhHBB6okARTvG82MI3e/XpFNtCD9jgVzAyPL4ytZZXv7Vxc=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 SN4PR2101MB0734.namprd21.prod.outlook.com (2603:10b6:803:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.122.0; Sun, 8 Oct
 2017 18:49:59 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 2/4] sha1_name: unroll len loop in find_unique_abbrev_r
Date:   Sun,  8 Oct 2017 14:49:40 -0400
Message-Id: <20171008184942.69444-3-dstolee@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5dbcf25f-763d-4828-dd77-08d50e7d609b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR2101MB0734;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;3:o0IkhBiOlqUcSziJwXKi/UHj1Bh3vUqZHTSSm6gb3A6Gnhu9yFcDFzkRDx85YFBEdD+x0boxH6/z0GbCAvgAbxiG342d8ryywhEOBHLCIM0JkJ1ghfp7tp+mq4ARGBGlPeMpdnDyWxXJ2LlrP4+wwTyUmtzHuyVoHi3A113k9IbW6H1ORfhH6QAAaNsvA29udOgWiceZEGCB1zHK9XoPkLgWmtvZpBOImERuJt+F2e48dq9dAcvoG8NBRzO9QsAW;25:rI+UX8DLDdITMAcoCEPWvL8lSm7u8nq7/hNiyD8her5jmtFPT5/ifXJq4P/Zutm6nH/uXwL5A3D0m70iFeJMuqJm8m5Y19M9NLX2doLZpw+PI650f+aFdQiNh6CDTc+EWsrpe2TFFK2yK8MboaRgYoum51sYbZ00S3UxCASNWmZ7KJeFpJ3t6l/amm3fY8vTDn4WKDLv1+kE3zI/TCqORrZukOpohQU9O9oJ9fgmHNacVnECHYzJXYZ2gz4cmc40jhpplsWOrGbfocdxpTsdn/mVPbQwafXwGfF4G3US1FdhrRNIYiejNJUe9uUMw72p5Mtq6ljOPtT3XccdNvsWlw==;31:cWBX23+pUMD3ivN+VF2RdJBuWhcfEk8DRX3AT8wUxldm0hx48/fh2+AfAbyxBIy2AMhkeIgztgzHC+gpsNX8hdd3Hbecg1dWmEMFRh7bNlXAu1FfVMOtY8ueywp7n1jXHjTOsq+3w1vrPZ8pZCPlLlFjVhnb/BDVev6WxPxdqKcBpHHCBUQiPysrldn3UaHIpzrBPeO6Lx3hFDlG8I0pJs5QXgCUnUk93lv7NYS4WT4=
X-MS-TrafficTypeDiagnostic: SN4PR2101MB0734:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;20:CiSUE+kDdgCdCZnCVi8Tgc+ZcUOUjhi88Wve0XVZ00C0EmDADrJjYbGTlDvj0SArBTdOWSv7B3etXrrOFrgccGKjpovu41Fe7Tiy2MZC1f8IPvxXwfakUEbDk+mnhKiCYJAvoLN0bU6+6wxfMvuyvMY8czuauMiHLQrIbE8BO44/yd0snZEgaD5zVMeINBB2fBAKYOS7ebVWnSqHtqTwolSMJ0INjYFPjx0+/teGjAFDwsWun+AhR0RnLgIR7aMhRTO5W3lR65Zzvrm+HfOcz4XffE9BgIDHbCedE/rGhe3aAsFK6rAxf1NKwzsGsK8r6u/p919cNvYbRGNUxYhjZrb5F5fAd4MlyUYX3oaymasD2VRgLRVp4/+f4XYZo4MbOnd2mhkTi4cWOiKClK007QgjsEDk6nExnji6TLexxw/HZn2QJLyzUcetkGgdriRuQ3vdmyYrt8K7uDPzudtvF8NS1e01pCiCV7vWjgn8vO/uHr7bcK0Y8bhVF68VlVlL;4:q/yaqjiTUa3/JdGFbSTLqnBAonVg/MIa1iNJKizCstzaX4jFtH0Hv9Q5gbYqPC0PGzxBJmlI1jGWovV4W2OXjjWtiKi7SCy/gNLtrn6gat3fLhptVI4eN8EZoE+BzT+GQQH3bThls0CPhPgtxo/8/xhvXHfyW7x9x9X4iKl9SKKTFFJqbLFQV2UUD+uD6IvkYy/DzJ1vT/O2Q8xSrqesXslSckyORdaff1UYEHkoiRYtBEwlUqaQVaHO8dHlaWkSkj5wuU02c09fFOoUWxIWVh+yIeATevkvAQeHYp/6Jqz+NnZifoj2WAegREdD4117885ZW4JXRbh3zZDzHPvXAw==
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(17755550239193);
X-Microsoft-Antispam-PRVS: <SN4PR2101MB0734FA856C6BA3FA750160F1A1770@SN4PR2101MB0734.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(12181511122)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123562025)(20161123560025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR2101MB0734;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR2101MB0734;
X-Forefront-PRVS: 0454444834
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(346002)(39860400002)(47760400005)(199003)(189002)(6116002)(6666003)(33646002)(2361001)(81166006)(81156014)(47776003)(6916009)(8936002)(2950100002)(50226002)(8676002)(97736004)(48376002)(50466002)(2351001)(1076002)(22452003)(10090500001)(189998001)(25786009)(16586007)(86612001)(53936002)(316002)(4326008)(5003940100001)(36756003)(39060400002)(107886003)(68736007)(6486002)(106356001)(10290500003)(5660300001)(76176999)(2906002)(8656003)(105586002)(86362001)(50986999)(478600001)(101416001)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0734;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR2101MB0734;23:a7MV4lc5eShSdrhxIosk4SKVHNo7HT5gjBnnai1?=
 =?us-ascii?Q?fwPEOwFFDTNuCSoTMT3DEK6nmZwZ68rFa+2nl1WTfRprEB7gYvK1+LLYZCQ5?=
 =?us-ascii?Q?edoXiSjTHm2RFzTjEpGvNcp/f6jka9Mo7bDQ5vajrM70Ks92d07L2WnnWQA8?=
 =?us-ascii?Q?FA9/s1HCdBX8f/oT9EJDa6CGce2Z3d+IzUGxsU0LzYk+r2bq3oiFbsS7IV51?=
 =?us-ascii?Q?xBI4Fh9lz/isBLDHahQoEsvQ+lEhh9NmlRV8ebGCxywmf0ftJjeTk7gIBXQp?=
 =?us-ascii?Q?q82e31tFIjXFy2VPTGxZ+Z/Uj3XOMfs+niRHT4mA+cbOavrRMI53+vq8ardT?=
 =?us-ascii?Q?fiWuCzF3qT6Kcc0b+LeGJVwS4ZvV4KpC/Er8sdxwQIWQVhyUXep4EHydfA5j?=
 =?us-ascii?Q?6SZOCxbJCymMDkFXtXsa4k86sS2Uek7VCDAzPaw6lxMyTolapuQTIjTM7/md?=
 =?us-ascii?Q?lQBkCX/APBiiXVmjekPrRIgiO8ePrXGEK6hp6YpflIVaSPqvtbBnUN4JiXcu?=
 =?us-ascii?Q?dpSuz8oNLzj8H7gKufQ0P72zOvR3TIIq0mtP1n0NZtI+vBGb19RRKW425KXY?=
 =?us-ascii?Q?uxbg/LPh5/zrDIlJM+iIy+yqY2zvRYAz6IMaiRDFr5Z+VTmXOrDFIrGyoE/C?=
 =?us-ascii?Q?tvTfqjpvlCXmPLfZOrJJ85VZzybBw1Hzno7MqpgCuWDKsYdhv+mnYD2fWNJQ?=
 =?us-ascii?Q?jnJyCjRSKzXcai2ZjLgbA1NIYyNvf5WlWFFe73jJC86T8boo2l5QYAeW3USk?=
 =?us-ascii?Q?2Ki9fc2NEQrOOJJkZojnhjJhpG9/CrGOmqzeJLx/+4nvpr5j0N/0prrq5JTL?=
 =?us-ascii?Q?fyj0oEEwr47s/pElucYG/QKdDOitG2n0MH8fQejS2Bdbn0wN9Blc19ielbMt?=
 =?us-ascii?Q?Aucx7yfLArYv45mF7RZUxth400rpx6I9tm46gA7cF9Xh+L2PZIXYXtDubFaS?=
 =?us-ascii?Q?nJFKoN0zqHr9PAduq8+NEm4rl/NK/vpZ3UTC9GFsaOPT7/6qH9eyp9UObso+?=
 =?us-ascii?Q?ndqwYIIKtL0EFMN4dzUpBL4thDYxBfk7SE+W4++my0MY5ETen16MWCqFXYmi?=
 =?us-ascii?Q?Dnv7S3/iOPUmGHicVk1WFW76gEnscCxxcNTIaorhOWrxzlBOWMrfY3McvQJS?=
 =?us-ascii?Q?BOm7B/IqZrfbQ9EfXw+vLtifc/DZjAGeeClRH2UZO4nGy7wwGDKlqpAeJ6uK?=
 =?us-ascii?Q?MVVPDzXts5kA7SckxGjSItVabqbvQooh2rPnUriHN/Ts7hwfHdXhZVrOQjev?=
 =?us-ascii?Q?mtBxzCTyqwBjk4GJd+/w=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;6:RdorLEBWSjfX1ZfHiWuQBeFZjfsrHyYGsLA4pGSBZz8bxoN5s6m10Vbam9DO57cm2pmdH9d7DHsYHAq0lNV2yewK/NVKHhcmX23p+WHoQqL3Iuxml0CWybwisB/9MCi3ZB9t1uPfCaw9ePRZpBfQ4tNGmhCwt+YQmlqC+63aqoikXh00rU1eqczAUxw4IxFyma1Vl2UKvPXDoBRuCzg10I2MMvqHRXCriLxhr3imZ88ZAQNW/t88rin6Ei6vfGe7cQN4E7L+26kcBtHSqfoWixedX5paM9npnpdZ7XIH18bFlLwZEtJyPMuhpz9Xlk67U+UpX4vgNX82UwGfw6XPdQ==;5:43yIqk5xpOL/cHHWa5B/5+kbuRKbuAiSGWcrWo0BJQ7Q52pBxLGWBP8TCk2mFV3WzK/NuyGmAZ3JHvLU2xGQbUCx8eJ9ueZ4Kzm4pJ2mNRGPptilZxtWU4cQf9J5sXEgs5MCgZFl+pJ315GE+w+zxQ==;24:ocL6x/p51uWcqCo5c+cyigUGdHrrOs6xdaDwVhxNA9o28TMpzzIrub3Tng5lDYL+ppJxRKExPw+W0rQdF8ihdjcXIIOTjEs7lbF39vAHHCg=;7:qanES+N14mfPKYELRp0Rfm4VrXtiPgRxwwr7Mvk6zIvAe7XeQd1ig76j7swwGdvkVfgBl+m3w7d/A5IjXc86RlmO+aGiicxxtIVc7sIOw+SOAqKbNxrHcGvqk8kuvIpiHA44jI3fUp8bWQuMcXsXa9ch4cPdk9jPfRP6EZJsfoGg/TOpeL3T1mS2e+NFS/vE01GjV4hkt/zvLQLQu2LigG9aUw/PSBRDsfC44Knb3n4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2017 18:49:59.1384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbcf25f-763d-4828-dd77-08d50e7d609b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unroll the while loop inside find_unique_abbrev_r to avoid iterating
through all loose objects and packfiles multiple times when the short
name is longer than the predicted length.

Instead, inspect each object that collides with the estimated
abbreviation to find the longest common prefix.

The focus of this change is to refactor the existing method in a way
that clearly does not change the current behavior. In some cases, the
new method is slower than the previous method. Later changes will
correct all performance loss.

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

