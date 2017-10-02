Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38FF20281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbdJBO5O (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:57:14 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:36389
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751526AbdJBO5K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hEHTl3XwTWIPVF4DkULY6vJeQzyQ95F87WpA+2QDxG0=;
 b=WayyLFT4jfJP9wWaE+zaM7hX6u6HsCNlKgapBXcpbI9XLml5tbysoHVMCQ39p9rPOmCilTR7DcZbrKJ1RnsA2yylg3p2xxPguJnOO2f4JKU4b73vqms0EUUnOUdR+UtLyUQSi6ELcVsHiCWAKHaHJxlmBmQESenes73beH5W5kI=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0731.namprd21.prod.outlook.com (2603:10b6:301:81::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.4; Mon, 2 Oct
 2017 14:57:07 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 4/5] sha1_name: Parse less while finding common prefix
Date:   Mon,  2 Oct 2017 10:56:50 -0400
Message-Id: <20171002145651.204984-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: MWHPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:300:115::27) To MWHPR2101MB0731.namprd21.prod.outlook.com
 (2603:10b6:301:81::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd2acbed-0951-4ea2-9bc4-08d509a5da72
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0731;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;3:gBx8W/F4+S8Nerq3z4u4JHE4mHStGHjPWetYt3nUPTHwKrwgzGQ5UpZ/6Zo2tFuE+3enLAb0kbc3+pwsbVAqz1rfYIIyA/GEPgC+xW3ozih2r6WLxx+a0sGq8L5c5MDkDQ1zdbwZHf+SUon69ZSCg6qpyd6hwoQorm12h62EkcXirPMpsnIyrCslfIBbR1PTvBeOW6EKNIb4tbS9yqCMY3LcMGWN7IO5BZRTdP50gP0VMEUjWyRBlf8EEyB5O33S;25:n8GBavYQQom8Ui+TylmPLDG/8CEfO7Xl4dJjIC//rbZwsgl56tObhb3jqKTZfYoeE2EsMdqY84B6Mri9focsRKFVp4+3PKJmSCiz5+GmqrN8S+8YiX4/S+FaRl4KBHmM/D4NfcRPWBKxVoB4ScvKZb4/SG3DSFAfFSRFZ9m+160XRN1sSvm4+B/lMUBHMJyiQJjGEV5UxkBcF0/j+w0YA2tse1SLVuO3tAtVu0GGyhLv2JIIUzvfHZTgihkWkaKDCwFeir7AfKJn5GJG1CSoKRLV0hlLF+sWdwgKf63qKyGar19JQJnd9Q5/KGgd21Y28C5NrZSANvqy1g3WpAq25A==;31:4EghWUwkUpXS9359taDvgvqW32DJMBGgb2mXn8CUQ50DSOEx03Z6DO8uTKm8P4WsAGt7iqKcSjr+xF6pqbO5X3ZHUwbvykAe0X4YanMC/YDgBh6gE77lXLQ1bYHEQD+ERJoH8K31dUaD8R59x7cBjItvnnYotc5OkN/D7o2zfPAbCzu1hawONUV2ZoEpsvZ+GiVIV/XMpyTgEd8ujk5Sq5Z26tMifiFkp/BbvjGL0uk=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0731:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;20:wbzQZ94GBQzPA052VoKEhb9g4zQpZWc9Nszevk51uXuiK4HqG/JWL0VezB6PShVi9SqePNBxzIC17Afl3Afjb3a4H7cixUT34asPrAzZRNZ/d8tv+ZvTSMabjBCmbqSK9I9pjwNn284+hwyek7JJmz89RtXfg40TO43BFqC4mVwbgK2oF5cgjA0qLoF/v4jP4Z0++0uxhnnrLTUP/n6XiZKt0VjesBAIVeksAV6z+2hSe/5cpfbKGpcI5DkSp7uHmlLyn4mvwhoo54+SWWdbI4qYGFZ3RgUnRnS1WZc9MGm2qnP4+Aqt3PL85P+rM8GRQfYgI/k2eWppKYjsjec6jgEjqWqkqXes82yD05uCVv/yqQ4VwwzSoziK+ZgJL2AawBFKoCJjFIyxJs3lhuwkLvy9xwHZxJmly3EyaV5/s8/dZGtT4XVCPmV8gfvhRUJwV35Y5aiudt4FaW6xUZtYi89cQnYBHTSUfCVvPDeTjx4VqwYMIwj6/bGTcF28QYYN;4:0u+RveX212kejWnxyVWuQdWoaOc3Y/JPYi2izIDVkwisxzr4G2eJcns0rKcV5kS8ku8TXnzXAsAB4aE/geYl0TWeulLkk7vbIcBY1M2dL9sPpiqIGAyRBKnXQIDd9uH32NsGEQcCykW8uWG29MY36sXFty2+xWEWntzkxptrcR7Ix73TE/QKozbjcCo9iOA07cpxUyitxXgZeG5HSb1L98naWibpjFVPfoTC3ANauOW88UxodCXYrGQnyJo+bkV52LWqNObXiZ/fa4w5oLiWUL+9tuNguhdzTi0/91mvMlI=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB0731460E4B8CBFD812EF9470A17D0@MWHPR2101MB0731.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(12181511122)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0731;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0731;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(39860400002)(376002)(47760400005)(199003)(189002)(36756003)(68736007)(81166006)(10290500003)(50466002)(8936002)(48376002)(5003940100001)(189998001)(25786009)(8676002)(81156014)(8656003)(50986999)(76176999)(1076002)(97736004)(50226002)(2906002)(6116002)(53936002)(2950100002)(105586002)(16586007)(5660300001)(10090500001)(107886003)(106356001)(86612001)(39060400002)(6916009)(316002)(2351001)(47776003)(7736002)(478600001)(2361001)(6486002)(22452003)(86362001)(305945005)(4326008)(33646002)(6666003)(101416001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0731;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0731;23:6eUN66Pb8IOHcZTg4Dijd9/oZi9D2WYwLjg4bTU?=
 =?us-ascii?Q?28ckGXa2xIcFrnWRdZGcbzrTmtAHHCgaicgEGObCQ717XNUSId1FYBYMRdev?=
 =?us-ascii?Q?PpDvrCo+afUrGxjDLTSVhbxniXQhnvoMHzfYqX9XoTpn3dkctOBj3e8jPwXi?=
 =?us-ascii?Q?5/UpVJ//B5kPs4Zvf6t6PCU4sCe4dkntOCmEQr27bcw4wmxVYaA/yfyfnSQ2?=
 =?us-ascii?Q?Vx956oSFqTWO2sHBRrfoe5iAOO+hywtOLBKSc96OYtMfaH8CcBp1DNGg8oVn?=
 =?us-ascii?Q?CCRNSNbXaKMQToKWFmK58bLaqCo0ZiUC1KfZW6MDVtAd9Cy0pP2IFIskHDhd?=
 =?us-ascii?Q?YwV8DFZqkRlJOLD9jZarnS9cL8esKieMw4c0kF3D5th3QvivaoUPHVK21Jcy?=
 =?us-ascii?Q?6ZNXdpHvxXsqtOcEPVOxFXmAWcMCE+F/bHH4dl8Zh9b7lXAwteziMCQ2A8A+?=
 =?us-ascii?Q?55MAIl7ZbpjsTypnkUNBJVKmtzYG7TsuksPF2uPvTe3HolO1dOC3AlD/A8CX?=
 =?us-ascii?Q?k9UB0PGT5WMuF0tDwLI+rKpILSIxOS66FRzlvuCXJf+ZnJe/6Wclyi3J1Q6b?=
 =?us-ascii?Q?MUnWmqFE2n7G99cLwLxheHwfV16+RyBOlgpLj/09lek2vA92jOik9pLtaixY?=
 =?us-ascii?Q?l3FURYPtf1qOlxqEAjazzgko8Jsn8pcMz9M+Ka0nLbnLlBtmMz8SS2EVic2j?=
 =?us-ascii?Q?goBXOV1Te9dt8vWXEou7n+lynM0tVGG6Hx3W8sFnKLSZBHSFZWbHH6pInKiW?=
 =?us-ascii?Q?up42SG5kJY7+X1lNzR3QOetDUKrf7IxykiF+p7uNIb6+dWQdibOQ2NHhm393?=
 =?us-ascii?Q?AOLIz06ODta8p8hS8b0mk+T6zGFzPQAXQOMeO/5g9UstVuEVglntuck9LcwE?=
 =?us-ascii?Q?0HnMoSRWqoAr5IQHtv2jXVKRuAtnoP11Hn81A9iMf3qf6zQEjYwfsS/xL/AS?=
 =?us-ascii?Q?6Np5k9rim1N3EemRjKNNMDJEHmsEQsLNuavnTVVlgLAKb8BQAMjoxW+GOv5e?=
 =?us-ascii?Q?b7yW3ebV9B11w5jUx7F7AqqpNCjUZSD9VTiKlyZMSveSbFe0d+MXKyfJeEhA?=
 =?us-ascii?Q?gJYvxOh/s11GOHTaqh0X+LbYbiHhrEhjE3693uTrqg/vxCRoK2OQLS4J1z5a?=
 =?us-ascii?Q?hSXfdSrRn/b9cvgMmQ2UsLwNiz9uPLVJtE1oUfCgY0l9TfcRiKvoPmSs5iEe?=
 =?us-ascii?Q?fJW0hK/voDbxjR/paoFZIyvKR/NAE41uqdvV8mwYVkhSUtgdTOHvUpjSHu7n?=
 =?us-ascii?Q?CPxAy6b5kU24nhlinq0o=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;6:zL9v9CfXzJw1gBxnzeos5kDHcoVvvSyQVFNV/uCP6VWhIy1Y1ddKC0zpIs3kHwdHWxLb9x4qFAb37CqKw2HqRbedK1WFYfcxfOaDipHa0U+CSXxsiq9e0/kkZ1u82Yz7ZN/1q2CCVsnNo2tn6Vww+xSA5cNg00r7K2smvL422wpkn0pdTwFdYRJu2/rDL4rhQJ3afvEe4I+Wd4VcIUBtHJRiaULG/2LKMrrkbFmCSFeWNh48SZEYoWIYI0uTduYPPpapxmcDTaTbfOAtCWHBlaox07o98uv+8qgXvOHJKdTt+yO/0U3sEGbG71gM1bCTHKC+T0YbHu3j+f0Jzu1MyA==;5:HHqVQ030yFdujcipWPnXHFelgSwVUm9rb4tuLCzSTXPYu/P3jY88BhCiXOAKLbOX6RGFnCHH/xuQ6+1MHkD+749BICz8zR59kQ5waqKXBxEECoPhJaEzvGiUaayAFrkO1oemg7VmXd0N4RxKp4xxNQ==;24:6KGYE60sXGVXxVSJ6gQz6ojTtf+hZOMUAZk8mBWXiTaervfAaCPu+5ReaTEFsBLlojwAwrRZUrcP5EqBeBGYjV7dfLOdssepvZVksxzvvCk=;7:RUAwe0LjJelgvBHflE7TpvRzhn5pgKeJaptMjd/8/BEmUcDhiTXEdJymqIGWNzWSMqSe1eMBGnYo4EGFiRNSu+rKQTGYhU9E4+dxwU6snu7NwjExN8mAwk6jjaGzyiUganPIUViP3FlqWG/XjZ9EkLlvT9u0uK0BkT/OJkhYjMWdrG9p7Ct0Y+P3AkiupVRKRgEDYiANfPzF8FZC+RgsXfCdFyZYLAw0ov3/c0eVues=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2017 14:57:07.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0731
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create get_hex_char_from_oid() to parse oids one hex character at a
time. This prevents unnecessary copying of hex characters in
extend_abbrev_len() when finding the length of a common prefix.

p0008.1: find_unique_abbrev() for existing objects
--------------------------------------------------

For 10 repeated tests, each checking 100,000 known objects, we find the
following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.06 s | 0.05 s | -16.7% |
| Git   |     5 |  230162 |      0 | 0.08 s | 0.08 s |   0.0% |
| Git   |     4 |  154310 |  75852 | 0.07 s | 0.06 s | -14.3% |
| Linux |     1 | 5606645 |      0 | 0.32 s | 0.14 s | -56.3% |
| Linux |    24 | 5606645 |      0 | 1.12 s | 0.94 s | -16.1% |
| Linux |    23 | 5283204 | 323441 | 1.05 s | 0.86 s | -18.1% |
| VSTS  |     1 | 4355923 |      0 | 0.23 s | 0.11 s | -52.2% |
| VSTS  |    32 | 4355923 |      0 | 1.08 s | 0.95 s | -12.0% |
| VSTS  |    31 | 4276829 |  79094 | 2.08 s | 1.82 s | -12.5% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 4.61 s
      New Time: 4.61 s
         Rel %: 0.0%

p0008.2: find_unique_abbrev() for missing objects
-------------------------------------------------

For 10 repeated tests, each checking 100,000 missing objects, we find
the following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.08 s | 0.07 s | -12.5% |
| Git   |     5 |  230162 |      0 | 0.13 s | 0.12 s | - 7.7% |
| Git   |     4 |  154310 |  75852 | 0.10 s | 0.09 s | -10.0% |
| Linux |     1 | 5606645 |      0 | 0.32 s | 0.13 s | -59.4% |
| Linux |    24 | 5606645 |      0 | 1.09 s | 0.89 s | -18.3% |
| Linux |    23 | 5283204 | 323441 | 0.99 s | 0.83 s | -16.2% |
| VSTS  |     1 | 4355923 |      0 | 0.25 s | 0.11 s | -56.0% |
| VSTS  |    32 | 4355923 |      0 | 1.15 s | 0.99 s | -13.9% |
| VSTS  |    31 | 4276829 |  79094 | 1.18 s | 1.02 s | -13.6% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 3.91 s
      New Time: 3.08 s
         Rel %: -21.1%

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

