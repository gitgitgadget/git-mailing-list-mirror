Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F4A41F404
	for <e@80x24.org>; Mon, 26 Feb 2018 14:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbeBZO5L (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 09:57:11 -0500
Received: from mail-cys01nam02on0139.outbound.protection.outlook.com ([104.47.37.139]:18124
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753379AbeBZO5D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 09:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oQLtLbI623OfwR+RXcvgLsu0No+I4m9rbvcNCKS5k1Q=;
 b=dFbSZoEeYTfmf46nULcy3OaPUKdOe6Q4Wr0vnmc+KlYf8j0yTHVBkWkbF4c0upd2eSDZNr5h3Zk0sFRBAPuZ+ZJfauOeEjMmYbgkhYO7dUI9scEVe7Qbm9eCKzpfpr0IqHlaq9qBLnwxSFbRV7oiJ+h8TEhZT2fGqVfBFkBLGKo=
Received: from stolee-linux.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:7308) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (2603:10b6:4:a8::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.567.2; Mon, 26 Feb 2018 14:57:00 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] sha1_name: fix uninitialized memory errors
Date:   Mon, 26 Feb 2018 09:56:47 -0500
Message-Id: <1519657007-215623-1-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAP8UFD0CesVk8FjX-=unwSO6u0pi1-Usm1yVW5hs5FHi=8Timg@mail.gmail.com>
References: <CAP8UFD0CesVk8FjX-=unwSO6u0pi1-Usm1yVW5hs5FHi=8Timg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:7308]
X-ClientProxiedBy: BN6PR16CA0017.namprd16.prod.outlook.com
 (2603:10b6:404:f5::27) To DM5PR2101MB1015.namprd21.prod.outlook.com
 (2603:10b6:4:a8::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e33b16c-ce78-4f61-4c70-08d57d2930a2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7193020);SRVR:DM5PR2101MB1015;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;3:8bctHdBKb1gWMF6RohWoCmTOrZsr/FinuhzlEiDolfMKriS2km3krTKpJVu9HcDLqdNaUEGtDiEboqBH52vlkaSixdEmWi2KdjNXgfh025MOFrh3JJ/+t28gSzY69AVivQ8m7UoYJNJWI/Vk8jv1SiVCV2YQAIUJtqvvJ35t57wGVNWhdB6J0yYhOwWJf8UVKNT/VnGn2NMUI7kJvQS47PPymdJk/fJ8foSPEvBKnmwu2T8pHnSrhw9twW2/hvNe;25:Wy2/6F94z5KOfin8BTGHmU4loUBVducY9VxH21Vp1vr4e5U/jZWIeFoulPS+ZSbMpoZ1Ie+z3pvS1+dO5hHa1QehfXhjqMbfZzCZDbu9UcoxCSRqdG+DgvvU1suVGVo07sr6EGjvBs1/5t9jbPFiidc0iJxe/JzFYPH5T3cDJ11um8FXymRdUcM3NKtHPlgnZoV9ri7qwaFVGL5ypeCSGyJQEaleqJzop9kOjhSgocUftzfyMoj9+XkcZVpTj5BgL18oYw3WbaD3aNK2EgVc3nNwHbt8FUw6Fzg9n0GECiy9RSdxeJcfCMhrOWh5iSE2u7OtInIiLhGzK4cpLom3Xg==;31:5d9dtA7CQodkPkps5S9mGehjw+UsYh0e4PMJy40gtAekvxLrqQdgmfg5hrcah/zTmRvIHlA/CbjjE8zXmGbH2xx6PMm6VtcdhqZIoUNTai4A+fR6t/CIlydkxYGOh2buOc98YEbaShH7Ra8kgkacQxwxZwU/gY175sVUjseuRAbcox5b3x+YCHubzi7QbPk5Pl/74CnKiOdG+DmIHZjpAqK5QkW94dKXveoq0tlaRKY=
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1015:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;20:szfTpONagsYAf8YiCWJBn6O23XtITSXHiOn8npC1rM1m5eoFp6i+tAfNdRUt2g0tVTv3GRC6exoGQjuVfnoXG1qohKb1FcxgKMz1LouDZavxqfCSXSDd/vcdpficg0Gx6tAfI1aC3mNOYYZjyQ+U9aHWYikjKpn95NvjQP5jjqT6iOFekdPyXEW1vR4D32ZJgHRHhm/ki7ho8RMUVxCro2FuR333UEDS3e/noUWfwOwuaYmiYH/wQht4ZQ6fyMhVlJt3XIGGLz9GD6coxgqCnUDkaduRQPd2sFJPJp+bjJN1YpHq1zh5cfWt+KH/9wEGB0Of34lCMq4NpxCHX8sPnbxOs7bFl+Q8VfmU6zYMEY3AEuiDoGeImLLym2dOZRpQR/YMKk87MJ/ASLIZcUmEgroFNSyQyMQM9IXb8zWzRPiTNS8k9f/Ysg6MR1MQ7Jo5iHIHEUIasg8+DvtdckgIfdV7C/I5m0xLxWAXg20gANn6afwZYtYQOV1yBvgWf3ij;4:Je7+yyEHJU6Uhkfgb2wIobWDvwnjgQQukNcbBm/Q1W3bQyF1k02YkjaDLZkfoBLwEhyLRsignBrz8WFkw4ExN6QU9cyRkYQ4KZ7cXbJjqmmjgJSio1EBY0ipXLQUOo9SmFMsauQdK09DGwfCX+Zs1mjhEwqbpRgTBeeqSid3kxgWXT+LMglaAPvJYrspbqlxDM1tBYjsvyu8sjeReJnMXSSc+1aDcMJN5mdnCj4UxmEAFO5k3Ri+u/SUgq4fLOI3s26TZuVRtvSYxfShRIA/bO9ajITXjnMcFau8qdgm0cyGGgCUnoV20+t/1OJeae1FlI9tg/to0lERE/2Dnoru0gPZ2oTsvTUeyQX8Nlqg4vf2GDjx33mlyNaF5E2nByQj
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1015A1090850464B4CC1BC01A1C10@DM5PR2101MB1015.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501187)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(189003)(199004)(106356001)(86362001)(10090500001)(105586002)(1857600001)(50466002)(47776003)(16526019)(186003)(6346003)(48376002)(86612001)(36756003)(2351001)(2361001)(107886003)(6116002)(6916009)(316002)(97736004)(50226002)(16586007)(386003)(8936002)(8676002)(81156014)(81166006)(68736007)(53936002)(22452003)(76176011)(51416003)(52116002)(7696005)(39060400002)(52396003)(2950100002)(25786009)(5660300001)(4326008)(6486002)(10290500003)(6666003)(478600001)(2906002)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR2101MB1015;23:kMFHCya2cpcfbcGzActEXhcjjps47S8xWVfB3uP?=
 =?us-ascii?Q?CoR/emavA++/YY4YY/LhksQgzIHqj14i5fT7FxFvPAjeuCqidzrLmlQHravT?=
 =?us-ascii?Q?kRhJvIEXMi8pH0+jQOT8DT0aMFX3kr2tGG+VdDt926SJXpzI0P3ZNrq+aPRD?=
 =?us-ascii?Q?/P87JBYd759VmvjTs/76wBFY9wjGg8+S7huZZidZLzlmZcbg2GNG6Mg7mKGX?=
 =?us-ascii?Q?zLS20Ffo5SxHc6nk80y5kHx8oDNxUV2QdQcY6MFxq/a6m04BEZP8CDjHOvK6?=
 =?us-ascii?Q?YqiOMwk47lzLXNv8kNvbLqskNiXyzc+PIqrG+F1kv3dqf7xdH0WZZZmK/z55?=
 =?us-ascii?Q?HJOUqNHlU0VFPoizLRf7E5D6jnPiRcEiEu8B/YXoj8XtkRcShSFxvJDi8Hqg?=
 =?us-ascii?Q?2zUvQCSW9wJOJWCqIt+zS8eXE1ksVdBfN2P4ye+KuLiV72GChC74/upaSpvP?=
 =?us-ascii?Q?EQnNZ6BgiMXRf9hwRyRYQ8hu1xdObPGEP9a6xgtbabl5NJZSSRVQ14ZeftxH?=
 =?us-ascii?Q?plZIqOFiEbmOthXRJ4OSYE1WuZ76qZ+QW6YWRhew2bthnuRWENLwnbzWTw6E?=
 =?us-ascii?Q?yRAAwOHJJz9AZTBU71ZlmnfwFUHfwaBS/+PktOc5m9jWcT7KEHiu5X4UkQbe?=
 =?us-ascii?Q?YYtujQzSIsqF8Dlaa0nS/1tmeMpG4AM6LChsi+rtsts5kz+2vQxxJQo47bK/?=
 =?us-ascii?Q?NWLJHuzuvotwHUcifV41EehEkIS0QyFgZtPuZzaAt41SyCqXwXZwIBCarDq7?=
 =?us-ascii?Q?5E9UKlsL+3WZClIF3nPnD+hD6vHXnGT2mTGqH/onF59M2j/wtCG0JkF5ADVL?=
 =?us-ascii?Q?MWEEGruHLKBJuKLgdo1LiCwgKwFLPd3LyPLA1SQuvO9G+CMhVN1hE0wkdGAI?=
 =?us-ascii?Q?LHPB8Re5ffIgb2zhR5xvr04SuAgAgUi5Y5c8CZEOVxluB9uU/t/YwHZ7x+8W?=
 =?us-ascii?Q?aofu6kRPuvfN9Wla+hAd+ARRL1wL+yPyKdgMSsJDAzXANSh7FWHnsv6hSBpA?=
 =?us-ascii?Q?j2zGhkVnSLZLLBwhAs+xMKJZWgcUd8q5vikiszYVOcFMCCuEXULtX4MXt2bf?=
 =?us-ascii?Q?i0KvYsTp5oWx0FssFeTdrUQmsYBOH3pDn6hDhOu0biy77WjmuYjjeWanLAsm?=
 =?us-ascii?Q?BVnXNnDUM3DaTMBrpRNvRxW8bTv9AHusFCtVtAYgtqcObVgAqh5qVbZJkqoc?=
 =?us-ascii?Q?2gOblFdRDXrgYN1/jdfGFukmu8y3BkMjezSm1sqoXUoVqGf5n2dmr7F2tfRN?=
 =?us-ascii?Q?2RUUlFjrJc4YXillY2+aK3OSsq4SSFGlX5tlV2kzw?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;6:XKyHxFjAhqG0JqBVX4rjhTq1XP5VL2QIfPwQsG3RtrrFc61BD4P6jjNGRNQt/C8jjj52Inxib1kFNOqR4FbFLf4h128fic7nhYvuD79kzJ6wEEowHqpTK9whaH3CQzMeVel4xHZNocfc3bYHspqJjGjd+k6U/fhVT+0h7EIL3R/7GV+1VYOJB66Q7ABEim+WDylhtBz/Tm3gUij2vEYilqDNlErV2kSRz5OtpwaIPXuPDjDlVL6cB9uURJTsScdt9AQQ4P22upWnOjCJUIPJNHffIvHL/g6NNj9e6opNRPGirGYr7KsIZxJy63pnz737OVWCXLLCrgtiS8Ak3wHbDzmmu1rngkj/KAUyCLyblpA=;5:K7vwrrlSgoYBgh8XgMvvhOMWU+bhw0AxyISOBbN1bnE07vazCfbV2Zc8wKV1RSBUn6lYV8WBAEeCN1PHNGrIsidEhop9ioPJ0tUNeUHnfWxfp/OXd6LA1/paTK3CHaWMHL1OFcmBBcZoFkx1X+FXss2F+1ts8YYjFlGby9skixI=;24:E0PgCAjIz6qg7OnUwOZY+KxU31Zv6jQ/bsIRfg2JaNWDUgBCbUYcifZGc2ASWxQkR5Ts4x825vl4QSmm00yQPbU05IXNERAjxFuliiXmUsM=;7:XXYdWVhKYJm3AfFzKe2Rr81DfV7uJf+JoPkseds+thV1nSe1NCvi70XobsnYcKB+m9+tJU8Lto9BbIAgVrAlZu/ntjAJQozMnEmBScuDwG8TxLjh4XD+9QhVJPHtDRz+CsaQ26S37i0VagCbw142CeEyEXxyInMbIB+Pv1Z0dkP4ajmrIF2xveUgWLHZw2Seo1KqHZhpY6WfD4ttPN/rz5ke7u0QhkxNVpqJnE9msCN9lPg+GdW69JmCHrpoRZvy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 14:57:00.0863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e33b16c-ce78-4f61-4c70-08d57d2930a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During abbreviation checks, we navigate to the position within a
pack-index that an OID would be inserted and check surrounding OIDs
for the maximum matching prefix. This position may be beyond the
last position, because the given OID is lexicographically larger
than every OID in the pack. Then nth_packed_object_oid() does not
initialize "oid".

Use the return value of nth_packed_object_oid() to prevent these
errors.

Reported-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 611c7d2..44dd595 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -546,17 +546,12 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	 * nearby for the abbreviation length.
 	 */
 	mad->init_len = 0;
-	if (!match) {
-		nth_packed_object_oid(&oid, p, first);
+	if (!match && nth_packed_object_oid(&oid, p, first))
 		extend_abbrev_len(&oid, mad);
-	} else if (first < num - 1) {
-		nth_packed_object_oid(&oid, p, first + 1);
+	else if (first < num - 1 && nth_packed_object_oid(&oid, p, first + 1))
 		extend_abbrev_len(&oid, mad);
-	}
-	if (first > 0) {
-		nth_packed_object_oid(&oid, p, first - 1);
+	if (first > 0 && nth_packed_object_oid(&oid, p, first - 1))
 		extend_abbrev_len(&oid, mad);
-	}
 	mad->init_len = mad->cur_len;
 }
 
-- 
2.7.4

