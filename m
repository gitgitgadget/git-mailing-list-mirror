Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE5620281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbdJBO5T (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:57:19 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:36389
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751250AbdJBO5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=37dQC405q+lYezL/5YE7Wge2FzdQgZGFDANeB7o6AhI=;
 b=XB4ZNV4XqkVyhGHJQlgxCuJNwxZdZcYRfdbHl2uY7s0ghAjOmTKZCQfcYOHizo/56muJf4Rp8zmGyWDeRnwZMPzTc8MSPLTCLXBeyaRCbrmHxDo4UCCDDe44OUopdwOWmHTCIXwJ7/qyUDRJnprOsYXLqd2rsA1I0mMh3sbTk4s=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0731.namprd21.prod.outlook.com (2603:10b6:301:81::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.4; Mon, 2 Oct
 2017 14:57:08 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 5/5] sha1_name: Minimize OID comparisons during disambiguation
Date:   Mon,  2 Oct 2017 10:56:51 -0400
Message-Id: <20171002145651.204984-6-dstolee@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45f99785-3b14-4337-45a6-08d509a5db1e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0731;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;3:OxHDN4a/nlXGTBzGhfK5WnGjo3Lxdo+vM30GJYnjxh6s2owIJ06y4LP3DjbHqlmnx45o4lsMLCL1Qeq9M+mZEH6S/ngMECyT/tTGz1qgIJTGpC5mfG16GzeKS+/ZLojivhBFe5YSzggJ0GhPGzwfzCCmogBYtfIk4srNuTqLSxur/zbtKE4A4KFstpzsF1j51P/p05zsKnT7gJ5HhZu/PyHXK+AiCBbk2yh0VdZPDlsfQZPJTjBSoVg6Q8po8i2w;25:ilUGHzi7xFcr2nBNGk0pBtnWKkVgXbfRzAr8XwiPtbNiSui++2ARaRVdU33hIhwqESIww2U1o6xhw8jYUgkNtYWygAw4FI4jtxMkLoHJ3TIONJLqCNZDVBHayAwHPvcuiq+GbVNiUQ7lBb6Qqqed6ANGGMMU116pj7Uwr6SaSLHwfMExKYdqsh9m4HGAH+v1ZFHgV2eNxUGHkNotM9/owts6Q75mhK3u2pT8mwbubDBPS2tfisKanzak4gL5vFblQ7TbiwEjjZ69X79me7Q9FKELQHzoibBPMd8lKlhwekoendbvS6i+lUMcExS5UR8L/y+RMRg+rE1N+R/8g/tHmg==;31:W4k3xO/W9zFOqdBvpsoQCT571ETJyuvI4TSqnxp5mznIEH0tG7A0yp2ooKPSQ7SP5AwFmo4jgHJnQdxt4i6gVC5OKc0zcjCB0hL0HAUChpan3LCHYLXamrwzyHKuMbX35xchyXzIHTko82+FvNl3c4azVGYQB5ux5bR0VwMyx1u0gjUWl/Y5XnX5xde6qFEnAwWAJ5SEGEkT1d6bXKYOKesiifLwlM6aeKs/tsnt/L8=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0731:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;20:uj8wJUIATVucV2yIWXvnq6b2dQnNzvI4XeK5aoJBtfwnpv61uy0tR8yTsxM+ouIbJGtfACkZ258pt653Y86GQChwUVrgvJsl6MQG7LrhgOC7Dcr/AZKOhPtgXZoS0gKzWGJQ3dPUnDexyTAdaCHUnkqfim/Osr68bTRTjd7ei1bkDIX7u1G0yJVuVQ+LN2RVrWo2/4sx/C2boOHdpVkwpUW0+bPtUb6CXCYQPCYfYaVqEmAKejfMFStJ8HMskVcoroFNQ5ZjVfM30m8iTaRP6/9BsYFMT4Nj8oSIEdSh/m/sLuTT3Unfoi4ZdNbydX7tPirb9G2bpYHNRUNcQzbeQKG1AN3bF2t+x/HMnFVhgQ4l5FUJDEwWmeTVghQnguVablFDWfp0V7EHHCEVKYK7p9Epf3VlvuCQR6gF/z/eJAip/pViooj/zIHxIwm8+YM9scZ5ae1+rleM14qVO45Nas+KOVH04wbE34uPFUjw+jrBtHpJOoDGqFdLNmyEJvn/;4:tq/S+J1cNW9pX8tbP+FN2nXpAHpAiABxKNpRTs/os+4yZXo4TOy2ttxKydhszB2/m0uB8rYbApkKLgqD6ygOY3LRhUJ5NjH42nNTTFcJF2b84bmXMHYBkalk2Gm6DXwj5Ez6mJwFe2etIP5VtxEtIegRhIlOoe+LrRGz2lCZD2E4lW64l8E/66WJU2N57BjzcO35ky0hKBbwTaAa6hQp7qL88Qll3zRWJYnKn3FQZxWtmEPx/UT2r6uHEhzn+haUyxyvbe62+GqlcMvXTY0171XUaR6mNnCR+7mKQ8s3N0w=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB0731FEFAAA6C722EE4CB8D77A17D0@MWHPR2101MB0731.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(12181511122)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0731;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0731;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(39860400002)(376002)(47760400005)(43544003)(199003)(189002)(36756003)(68736007)(81166006)(10290500003)(50466002)(8936002)(48376002)(5003940100001)(189998001)(25786009)(8676002)(81156014)(8656003)(50986999)(76176999)(1076002)(97736004)(50226002)(2906002)(6116002)(53936002)(2950100002)(105586002)(16586007)(5660300001)(10090500001)(107886003)(106356001)(86612001)(39060400002)(6916009)(316002)(2351001)(47776003)(7736002)(478600001)(2361001)(6486002)(22452003)(86362001)(305945005)(4326008)(33646002)(6666003)(101416001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0731;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0731;23:U9uf2dRK6asBIy9mxAN99gwWJWMUPF7vGleTYaR?=
 =?us-ascii?Q?8vghwwNPrZ63Tu1BdXprSlojUPNBleU6l/5QELDbrsEhmC3jTMiW2rMgpEi4?=
 =?us-ascii?Q?pQh6UAKVOsOZFoB2lTZHvd0Kn40max8d2HI/d0etnSbrtvSWYGyr9BIJIHnr?=
 =?us-ascii?Q?7mQpRsDE55ZH06Hrg+SL3LLJKtmgG8kJn+cyrNLIT+UL3oMmjy3ib/Rfwnfw?=
 =?us-ascii?Q?Rd8exfdnaQZvOPNQ8wD+qp19VRJ8KlOr5w2raknbqygkE9Ast+bRBxDxi/dF?=
 =?us-ascii?Q?EOTUifh3IiyMJK6hHeizLATM29llVneD+yQ/jRX5kFQB7zl4O2Ll/eI9by7/?=
 =?us-ascii?Q?xA3aVe0oPe3bQ2JmA1FU3mHcKD2XN3vO2kPIV9HWWPOyaJLEeTZEoCPyLMmZ?=
 =?us-ascii?Q?Zp4SAJttPIGO7Kr/Q7WCSNXfyailN17kHvg6MXOsdwYaH/5T/N5BZpMkIHwX?=
 =?us-ascii?Q?t+R5shbxfvz+TzG99Nptt9OCjnVN1jjohaHSMQVdCEcDDpnHyN4Mzoe0TMb6?=
 =?us-ascii?Q?00errmqiIfbEVt4gRkhfzLUh/0wqeO9k44WelBikW4obaFx4yxSmkTiFTF94?=
 =?us-ascii?Q?in8TKzgqnFgH+ccU+VrnAk+L0STH0B8Cj+UJEU9bTMcoKqzOQ6cQFf76oKJP?=
 =?us-ascii?Q?XtmA6pGkk+OdUDgH72vAma+Uui0fI+/W5ZOVSIQZ9ipBkJcHpd3cZp6Aicti?=
 =?us-ascii?Q?vHy0vrTQtfW+m7Ukpev1Ek3FVTpGF5XOgJkiyeBa4Y96loPvzJtjRkSDlKqc?=
 =?us-ascii?Q?Hraw7fHEEJlndCWKmxkQu/av+ayYY5ScraFdq8+n3datgaA8ENH6PPh/iIcC?=
 =?us-ascii?Q?8t5+tBYYZf2QYVw2mFQ4KAC6cnVGtt7WPyPtsqYpGX6Htu7V5TI86IMRbKmO?=
 =?us-ascii?Q?c5Yptqe4B1Do3fIQ9jQame8DHdaiwgdu7D5uBei723hXzpw/it2YR4b8ysyp?=
 =?us-ascii?Q?tH7MACbiYy6p+DDt1i/7NHG0vlNrjs3qmVULVgxt/6W4/yB/xWyNA2SiWERL?=
 =?us-ascii?Q?flPNS/22vIkHoITb0laegHAvubRVmLjsS/7WS4tOfRqRT5y16kLT58jSN+un?=
 =?us-ascii?Q?/ZHe/jK6mXwFI2e/0ikeW7VFXG7SfRKX6msZw3A8/YCVPLhHUyhNndU8DVPT?=
 =?us-ascii?Q?cR78sfzlXAayHCf7a77UJYMSazXhKK8ny2A2QaPn9y0Ov+Vv0IW4rOaVW+uS?=
 =?us-ascii?Q?nM6RhZ75Hv/5svUFK1F6uWjbiUCtXvXwBZ0uNjW0vymSe/Ff2aww6WuRGMcb?=
 =?us-ascii?Q?0J1BZbCXJ/5reBnQHcziq6c0gu+BRaeuoFEs2by/e?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;6:H651ChG/7Wtz64VfL8DsaCacZQ40eV9aRW6nGcfWliktji/IVav4K3ill74r7klhhkbm9458LjD0cv0zWWiwlK/CDVacT1kL6L8tYz1LUFJ0pMgEI0TWGfQHEk+vco+wCyFJZvkRpuXmArIFD6jNtoTZUsPTpTEWI4QXqgIb1iHZYL8bI8Qn3lAHhGT26p5ypv+IGUjXotSzQ/XUhuJdbum3AgDASXCWL2lY26RT2Q7Wzlj4PCVx0nu31jm1NWoXHAIPB+A0oF80A3QmGaKnDCkRpZrQXZMPSHJezpa/Sg8efpSsWGJZUJpI3+mL1pOiBygpUp969trCkhyaFmivVg==;5:QSQMHhhEti0JrHwk795JX+op5cq7SD6zYZO483Fdd7lga971uC+jZp7CqmuJvzkJcqEJAUosV63C9FTNSxP3fpHKmealW5G5eDrQQ1ozsDqHff+tuX9MZvZEhzg3g3VCqTyyTaLI8re67YUK4m4bLw==;24:YRSTAbm3zN4nfUQsnBHhD7GMHy8juQKRotG9Ae+HgQGzQMafQYyk7iPO4ZwgF/MAPiOT9obZZtcfjUpPYbTjnjU6rsO9ey2wOiLqg3o+9D0=;7:d9Fkxlj4ouimu6CVdt/zgRKBfa/LHcYZbwwRC1TB2LLwAj2H04Jqr/5vmw2s8xssV7cODaha2Q62NBY1DFRdt3c9xYPvOST63VsQnH/F+ETZlSqp/JyM0WLgP4tmmWNgHN1mfs2hXbVcEbpwM5BERkY1I+ZiVliUxgDIZqkNIsrECs+xXGoVXBxdwyf/7n+Qr5RPP+rpXo1jCz3p/s6tFzMPwueBC/zszU1iSFdO8dw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2017 14:57:08.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0731
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minimize OID comparisons during disambiguatiosn of packfile OIDs.

Teach git to use binary search with the full OID to find the object's
position (or insertion position, if not present) in the pack-index.
The object before and immediately after (or the one at the insertion
position) give the maximum common prefix.  No subsequent linear search
is required.

Take care of which two to inspect, in case the object id exists in the
packfile.

If the input to find_unique_abbrev_r() is a partial prefix, then the
OID used for the binary search is padded with zeroes so the object will
not exist in the repo (with high probability) and the same logic
applies.

p0008.1: find_unique_abbrev() for existing objects
--------------------------------------------------

For 10 repeated tests, each checking 100,000 known objects, we find the
following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.05 s | 0.05 s |   0.0% |
| Git   |     5 |  230162 |      0 | 0.08 s | 0.08 s |   0.0% |
| Git   |     4 |  154310 |  75852 | 0.06 s | 0.06 s |   0.0% |
| Linux |     1 | 5606645 |      0 | 0.14 s | 0.05 s | -64.3% |
| Linux |    24 | 5606645 |      0 | 0.94 s | 0.88 s | - 6.4% |
| Linux |    23 | 5283204 | 323441 | 0.86 s | 0.80 s | - 7.0% |
| VSTS  |     1 | 4355923 |      0 | 0.11 s | 0.05 s | -54.5% |
| VSTS  |    32 | 4355923 |      0 | 0.95 s | 0.95 s |   0.0% |
| VSTS  |    31 | 4276829 |  79094 | 1.82 s | 1.93 s | + 6.0% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 4.62 s
      New Time: 4.09 s
         Rel %: -11.5%

p0008.2: find_unique_abbrev() for missing objects
-------------------------------------------------

For 10 repeated tests, each checking 100,000 missing objects, we find
the following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.07 s | 0.07 s |   0.0% |
| Git   |     5 |  230162 |      0 | 0.12 s | 0.12 s |   0.0% |
| Git   |     4 |  154310 |  75852 | 0.09 s | 0.09 s |   0.0% |
| Linux |     1 | 5606645 |      0 | 0.13 s | 0.04 s | -69.2% |
| Linux |    24 | 5606645 |      0 | 0.89 s | 0.85 s | - 4.5% |
| Linux |    23 | 5283204 | 323441 | 0.83 s | 0.78 s | - 6.0% |
| VSTS  |     1 | 4355923 |      0 | 0.11 s | 0.04 s | -63.6% |
| VSTS  |    32 | 4355923 |      0 | 0.99 s | 0.98 s | - 1.0% |
| VSTS  |    31 | 4276829 |  79094 | 1.02 s | 1.04 s | + 2.0% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 3.08 s
      New Time: 2.72 s
         Rel %: -11.8

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_name.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 5081aeb71..54b3a37da 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -478,6 +478,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
+	const unsigned char *hash;
 };
 
 static inline char get_hex_char_from_oid(const struct object_id *oid,
@@ -505,6 +506,65 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	return 0;
 }
 
+static void find_abbrev_len_for_pack(struct packed_git *p,
+				     struct min_abbrev_data *mad)
+{
+	int match = 0;
+	uint32_t num, last, first = 0;
+	struct object_id oid;
+
+	open_pack_index(p);
+	num = p->num_objects;
+	last = num;
+	while (first < last) {
+		uint32_t mid = (first + last) / 2;
+		const unsigned char *current;
+		int cmp;
+
+		current = nth_packed_object_sha1(p, mid);
+		cmp = hashcmp(mad->hash, current);
+		if (!cmp) {
+			match = 1;
+			first = mid;
+			break;
+		}
+		if (cmp > 0) {
+			first = mid + 1;
+			continue;
+		}
+		last = mid;
+	}
+
+	/*
+	 * first is now the position in the packfile where we would insert
+	 * mad->hash if it does not exist (or the position of mad->hash if
+	 * it does exist). Hence, we consider a maximum of three objects
+	 * nearby for the abbreviation length.
+	 */
+	mad->init_len = 0;
+	if (!match) {
+		nth_packed_object_oid(&oid, p, first);
+		extend_abbrev_len(&oid, mad);
+	} else if (first < num - 1) {
+		nth_packed_object_oid(&oid, p, first + 1);
+		extend_abbrev_len(&oid, mad);
+	}
+	if (first > 0) {
+		nth_packed_object_oid(&oid, p, first - 1);
+		extend_abbrev_len(&oid, mad);
+	}
+	mad->init_len = mad->cur_len;
+}
+
+static void find_abbrev_len_packed(struct min_abbrev_data *mad)
+{
+	struct packed_git *p;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next)
+		find_abbrev_len_for_pack(p, mad);
+}
+
 int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 {
 	struct disambiguate_state ds;
@@ -536,19 +596,21 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
 
-	if (init_object_disambiguation(hex, len, &ds) < 0)
-		return -1;
-
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
+	mad.hash = sha1;
+
+	find_abbrev_len_packed(&mad);
+
+	if (init_object_disambiguation(hex, mad.cur_len, &ds) < 0)
+		return -1;
 
 	ds.fn = extend_abbrev_len;
 	ds.always_call_fn = 1;
 	ds.cb_data = (void*)&mad;
 
 	find_short_object_filename(&ds);
-	find_short_packed_object(&ds);
 	(void)finish_object_disambiguation(&ds, &oid_ret);
 
 	hex[mad.cur_len] = 0;
-- 
2.14.1.538.g56ec8fc98.dirty

