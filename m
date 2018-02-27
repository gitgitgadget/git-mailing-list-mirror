Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D3D1F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeB0LrV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:47:21 -0500
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:18381
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752056AbeB0LrT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Fv6pjfVOi+BFhbGlFjTUXEmi0AHmQyavXGvrsj6DkE8=;
 b=NIS/LJ5VY9lFTT2a6K+YCSYhS2jDl85JXGae8OwbpaGBW5lkLvVGqAoPxE15Z3Y1/1ShhMWUA19mZ3Z+DxGfJ12ZH2PeVTeSeHIDDi5UGESBLRLzh/ri24cAKu7VRaQEXubb93sjYdbR5myJYs9JHC5O6S+w9AUXBiZm2LhUaYA=
Received: from stolee-linux.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:7308) by
 MW2PR2101MB1018.namprd21.prod.outlook.com (2603:10b6:302:4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.567.2; Tue, 27 Feb
 2018 11:47:16 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, stolee@gmail.com, christian.couder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2] sha1_name: fix uninitialized memory errors
Date:   Tue, 27 Feb 2018 06:47:04 -0500
Message-Id: <20180227114704.193145-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.1.41.g005071e
In-Reply-To: <20180226204151.GA12598@sigill.intra.peff.net>
References: <20180226204151.GA12598@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:7308]
X-ClientProxiedBy: MWHPR19CA0050.namprd19.prod.outlook.com
 (2603:10b6:300:94::12) To MW2PR2101MB1018.namprd21.prod.outlook.com
 (2603:10b6:302:4::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45255993-1647-44e3-28e8-08d57dd7da09
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1018;3:o0vd+D76Y7bFtq3GJRgoYWJOrVJ8qnKoXTBOYTXchV+Cm/2fHctYk4D09OsFdb7KPJUjUFM/666Qg4VHJS8Uch0BTJceWNPLYKZG0dW6nRpnIuknX+3xp467g+b+ctTakVkFn3PIyTvRhZxIHFhjQ2l/YkhZP9N0uOzbXcxRtTv42HOOYesxKCeC1vv6dpWsZ2vfo/U++z9ejaX5DYd9CXvJL+syFriGdivZ5iDbg8PZp+pyoUpj5qcdvvmyErGd;25:SZl5aigP1fPTSgi4dl+lqn95tSxvVZdlZGYCAtrJseOTnKcU+Kak01Q77dvj/4ohdQHpoSeuiOGZmtP+kvseUoL6UTxSrrwp+7kJ6NDjGfLEGa82jWB/VS9FBOS6D2y3Tv798TsAddDZ07i7ov5SHbNcVKShDi9M5flo8ag6hZvz+9GRMdXsqFlj+6PkhuP3gZuz7MViYYlsAV8AomG06+f1zhxL/7UlTKaMkJ7kc3ed5FbdMtRsmYaC9IlLXmUFkMVjwKHJfHXtP0DbVdk3gxdL/BKFpNTh2D0SDhSTbKji5Dy7K6djbcZHEE0URp9GUc23Yye9uqr29t+cIaUtSQ==;31:kAf2Ebdaw3NZg+GPO5JBlCeekAsfMjIDa9jsSXHtAJB/msrCoRpqVnLMrClp21XVV5TBXCvT3Avk2wUV7c5pnfUr7pgHXCD2Mh1JcjTeZZW/amfmcx4AG1zXMyociGvMHzi5o5Nn8KmJVFauj+SJbpss9BjiL/SMizGY75bgY0/iGn0oKd2xQDgdnkfD1Zvg9HXiAsc8icX24IYuY4zLKiP+2hJHTzUSRmkCNJfQcU4=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1018:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1018;20:zXB6A1M2AeW2m0NdJZUdmaskATaieLr3MpMGQ3GwggS0c7QwUXqMkt/Uj2W41DBukdzx9GyWuixc5YQzjDrSrIdAnY6QOb01uaUAdhLlTm9Pgu4jx0R3xhOFhHci9nkoEOpnf+o0RuCJnFvNKK1Y4Dqvg9HECwXN3Hc9mWhrVhATzsVbhdY3FKh9IIpNnhNOd6lBA7bf3FGWod1kQAfvZ5+QfBlPFCXe8W1hmhChmy4sJH036BSlM/VffjUxhoUf5XNVkYupSFuElXtLreONVTtoxwGhOkgHVVb5Ol1+ElhFri2WOniQZPi+CtykR+ijNCvTAgbBFv+fViGRou3yz6aiTdYppuFR+8tUwuJXjivcC+xTZ6I0OSE6epSCBarrJqFXzIXOaxVPYR9+56mz6QVcgtadv8LXBqqS/X7lHQ4cttFh/orrR5WiZXJ5Esjw/CojxEp0U07Rc9zYKLnav+EniT41g0VUSCWlmLBuyUO5zEbNVjMAk32eOjM3k7MR;4:QAp32sWxT44W/aoC3zMN6B0OTC+mnYWgkwjNAqUDDXbY3O9Zg1WWx6QPlypUueZ6Yp+wpCV//CtDNrswqzldpEdeHV1QCpGu5IyynbMTOodrKK3JJpi6qq4H0m+DAnIC7dzq0hg8Cf8PiZH6bRI9SXKur+s3cORcoBXJNrHCKewUJR52HM9ocKk5enzMN2BEEc5a4xRXHDVyWjVHp1cfQHNE9+N3nFMx19i5q0o66VfgltE63+csFZLmjV4TKN8znHWoNge+Uxa/sNEFMHEhqN7fx4DirOyS1DIcs2gY7K6UjN/llK1rjAxpX2908oiJL8zYNbQKpFLv8gzYV90OQ3EzZ6TCKzumaVH+Lps6IfMKfW3SXKVz5UdWUksNYGN7
X-Microsoft-Antispam-PRVS: <MW2PR2101MB1018B0B8DD426F3C5C6C7ABDA1C00@MW2PR2101MB1018.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501198)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(189003)(199004)(53936002)(4326008)(22452003)(16586007)(316002)(86612001)(2361001)(6486002)(10090500001)(47776003)(106356001)(6666003)(2950100002)(6916009)(2351001)(105586002)(48376002)(36756003)(386003)(68736007)(52396003)(50466002)(50226002)(25786009)(5660300001)(186003)(39060400002)(107886003)(97736004)(81156014)(2906002)(81166006)(51416003)(86362001)(8676002)(575784001)(305945005)(6116002)(478600001)(7736002)(6346003)(52116002)(7696005)(8936002)(10290500003)(76176011)(1076002)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1018;23:kPVHSeXwIhsZMvQq1LwlaWq5W1Nmt6o0YyGuxwG?=
 =?us-ascii?Q?EFo963DUup0bm5LPeUPximsOq8SqLsKDCOS6MAAFSRp2QD7knaIh5Nrvp4DX?=
 =?us-ascii?Q?VhI+Yu0J9Yya7ba3bWChmVKNXMqMqWFF90mMbptYWvFcPZfGBOGWkZLGo1N8?=
 =?us-ascii?Q?l47nWy612syIDzSnxdL6lyTydwEFhwSJddZVkR8ERdr9scAuVWCrL8hySzSl?=
 =?us-ascii?Q?slMUO3kdTl3XZrhTekksz9EfRB3HH8eYMGj1ZPNqOfu0UDnM6VQ6jhi8Wr+x?=
 =?us-ascii?Q?Bt+k8VZLC9Onlv8QCNgCJH3xQHQi0PdbD/EnRqXnLVtfKEg/7MZ5AqNmb5lP?=
 =?us-ascii?Q?b2QnnrtM/pR1ZKwnbPIbqqZgJ700eHut8HRu8Ymvhdp5d1MtXqYV4IrXTWUX?=
 =?us-ascii?Q?HmVoziZxxZmz3JjBlCP0rD+NAKFV0Wq+nU+3dreUwDYbSA6qhtB3/A9IYbNX?=
 =?us-ascii?Q?N2Mh/5GOhG+rYaW2hq38t2rfoOQR2SFSpnG5AoHk2Az17D/1Fl33Ih5S41+G?=
 =?us-ascii?Q?p9+reJPBrFRu9rRMMa1io9WWqAjbNjai1QpBNSo9RXi6WUMtUawDzNBqi92w?=
 =?us-ascii?Q?+USKqLvja9UsavnMUFhMQfnBarq61FePdAJHAkFCF+sTVSZLRl0aL7hSAvYN?=
 =?us-ascii?Q?wPOnYtghjwxGj694dWzsTyDQvqyK0BRzosNDsaruIXHOaCDQVbkpcaRFMQMy?=
 =?us-ascii?Q?kb3r2y0Jprhedf0fLcxuIiY9AYabFXAtGEc3vU7t1G6113tcetax5arSWgc/?=
 =?us-ascii?Q?mm72BOnu6DqcRTlz0l5+dV7jiOOaVGZu1zu4decoHIRaU2lo8FwUIfEY03Fy?=
 =?us-ascii?Q?Y8Vdksm2FpiGtortwT76I7QFZITHLwQLMPNbSoeWsZABjW4PEghs+0iMNSgE?=
 =?us-ascii?Q?5TDGnRPcxlM5xqEzZFrbNXdK/RovFZKPPP40TlVDdtdLkc3IvjMCmgv1K4eI?=
 =?us-ascii?Q?9zRM/OuY+C8qtkV+FGwFwjmC+rt3xe9ZUE4toji3FtmVOtgELtp9Ko3XdjAC?=
 =?us-ascii?Q?qsLdi6eim8sDm1Uc2ZNrHabASZdrhl+Efl1tkkMCP2VpxIkAezPgi2eOgFvZ?=
 =?us-ascii?Q?sk/zfynViT5dRZGuT758cxmL3f+3XgL3yrgZbhzaz3dCkZF7Wh0KTgxccZBX?=
 =?us-ascii?Q?jYZS6lbj7gF6QOaYOJwGy6jdG/3jWHY/J8XHQN6cDlxcCbV9qwnIBtCw/Y8S?=
 =?us-ascii?Q?b0FLYOhLGN//WR32cnX044LLhvWTY7lda3FfgiOyL57ewnA5E/yxdpmJlh7H?=
 =?us-ascii?Q?rQVMUvnkpZHLP7LenxK6z2c2DATjhOMhmf4s1fTSMKosRbrGKDFeVc6ROOiz?=
 =?us-ascii?Q?9Fw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1018;6:f9OkQuBwmtaWQ+SPx1Ygyt/xLgwro5hELPN7qK15XOSoGZdM8TtE2oqphFXsrUMay6ly0hDHXl+0X4G9QPUrbhbKhzUmrxHoA6O2ljy37oufpV63Dng9/ZP2UC+jOP/yu+hn6EHmMLX9840nJag5C3DQxVpkNeggeo9eG8yVUkPS8TCnoQplRguIlL8a5aZM27eTBL6TpA1FZXDGoLB2WRXoGWXwefk8Wo8VaN0/T/WYGFuLGAP24ul9u3EiB3Yt+1TnzHW144w9PMGRdkzDdGQlb20NkeRrpw8bv3K13UPn6pTw0f5ciypCWMyuPCPjAQJd9YrIoaQ4PhYma2v78EuZcu7Q/9BS0mCI2ydgm8o=;5:0L8N9fcXkRi2CDDuRX7v53JYCSUVQVZwVI6ujukI87hv0gJu0LPOej7q+RpGuS5XXfLD+Du521i1dlZquHMpk6+uQosKJNldKe1KzieYKOebQ+06+H6ut0/q3LlVd/WMA4Jcpk3cKBN/pgSN/0hOVf1aNc8N/wi6wfSygObqCGo=;24:41X0BFKCF6356aYOK0pyURnMPCymrTISeo3kd3KCkkHQubkLgujPpB7Q6YTvmcdh9mx76lIzn3bdoTOoMTICgqwYcDGZrH/ykf6V+eM7QkM=;7:abL+Fe7QzYNcBTFP+rc4tuhSpnqL6mrC3nspATm43HvICdZYp8VX0mYtIfPGiEU2yLEehvmPpUlWoG2y9ln15Fh41064LcMIWBlllOSPYlInZMjWe3oOqXnEy5txrHqQLTOSxmSaH/YVh8Snf4xnqWFofIeEc3j9tCRawl5twQ0Q8ZZ3MJG7fAqlf+RDhmnFW/s7z+Gj82gIvu7JO6eJ0HZiRelASiFNwSnbUlpMB/YuRq+HfX2nAtCGe6mXPGx4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 11:47:16.5402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45255993-1647-44e3-28e8-08d57dd7da09
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff made an excellent point about the nested if statements. This
goes back to Christian's original recommendation.

-- >8 --

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
 sha1_name.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..a041d8d24f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -547,15 +547,15 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	 */
 	mad->init_len = 0;
 	if (!match) {
-		nth_packed_object_oid(&oid, p, first);
-		extend_abbrev_len(&oid, mad);
+		if (nth_packed_object_oid(&oid, p, first))
+			extend_abbrev_len(&oid, mad);
 	} else if (first < num - 1) {
-		nth_packed_object_oid(&oid, p, first + 1);
-		extend_abbrev_len(&oid, mad);
+		if (nth_packed_object_oid(&oid, p, first + 1))
+			extend_abbrev_len(&oid, mad);
 	}
 	if (first > 0) {
-		nth_packed_object_oid(&oid, p, first - 1);
-		extend_abbrev_len(&oid, mad);
+		if (nth_packed_object_oid(&oid, p, first - 1))
+			extend_abbrev_len(&oid, mad);
 	}
 	mad->init_len = mad->cur_len;
 }
-- 
2.16.2.265.g3d5930c0b9.dirty

