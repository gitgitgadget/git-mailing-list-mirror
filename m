Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E742047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbdIST3H (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:29:07 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:8672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751416AbdIST2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vV9kFRds0BAqiSVCyg9qufN9ZhqaL5BtWesMXC+PIFY=;
 b=Nr+rPT7hNN2yulQwPteY3SeAZRdKJzK3uNm46/17ZRc/O7IlaLQkIltLGkuFSXbEJngE9Q0roroMBhsUcD9r7/dAGn7TNB3Dyro6FDqQuErA+nz1vHkihouM6k0+2vyTPYAe9Dx6/UgZ01K9btAJoqIl8+cThVx/S7de0BknSR0=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:33 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 06/12] ls-files: Add support in ls-files to display the fsmonitor valid bit
Date:   Tue, 19 Sep 2017 15:27:38 -0400
Message-Id: <20170919192744.19224-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6584e9b6-0a29-4e1f-f967-08d4ff949e56
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:sCiVaL6DnzmB+vqOhwFDWJNQbNzu+bjU+3uP0o/TsvP0dfFUQJiiElCOYzGHfqwYstOyBWvvxe+4jBlzq/nGcCLiOtXFifXagV0h8AbfMyH2+Qja3CLAHkTlLRBTeJ3ojwAKYskkDPaZTniUbNJbeNPqC6H8vTvF7yfsF8LlkZwEgYwK2DYqhLab53VQLpnmIqhE4RqFEeZKQtNkWiTSg9UrtWYJwwQBgBt2JDuHPkGw+3Oa6ih5DiXc4fmZk9vl;25:vtTF9yYDSmk8rGZvz2yDKeqQXlKkWfncaMV7faYw2VXRDtvKTHzloFuXW38GbJJ1VjfQOcQOcazFYyUByOSys3fFxMY8edFEl0gm/sU/153U/B0OlLGcbF3/n9/1Nwcroi8vDCsxhaXWW7S3JI5F2qnz/0K9kBIorw8It4q/3hdNuIUpHYJ+/lZnjJzjdbGdJVRb06I/xI+NcH3020zcbiiktbZeJUr9+LgqR9PN9fkWcR9AMepTjKU2J2FEshsKBuslXuPf+9tUp0uH4izQAsQX4tbT/8m8vbW537pytV1+RlPUY4IfxUAoCidqq7F4E7aJSV4CK/FNT0ZIa2qR6w==;31:5U00bSY6hNk0iPQVshD+bG/YGtVcpNrstUmTODrQ2tK6qv3tHP5bRYYy96JOaBpJyOs3k1IObH8taSwRBVL6xGy1aWQ2H0+cyT/JIO2OnC1htM1SLL+UXltJwDSPk7Q558d+IZ7g9OvwavG7/My/1Z8mVQyf02K62VTIcpKxuZkkKufhYl/jBZ9dp9luD6EwJcjPnF1LpThoHebV1I8n/xi8G6zglOAXeoWS7daAU7w=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:DuXPDpZF+mLnfqswbLjpPN5J1A99F+HBHoyYwryeZvs4whi63OoIWWwwU79X73fyU/JMKIwnRCC2xDqHA36mHPZsCnhkJR+uK88loF7Na7C72qCqMAUPkjAUvpG/uZpo/Tqa50a5lDh2I9gsczaAF4Wh17tqonXzFshKf/yNtbbRW07X1WdwDNSFOZ/HbbJksFdeIED0IS2SumkzZYY9/oHHtZmjT/SwK0eRCSNM40RkecfEzBN6pAyM+bLqF2y7OzjA5dOIqd4C8PKyq3cCSa6XiXT7sA9dqwOhzfHmiHmSWe1n/L880ZmszlmnZqFlDlPk0ckyS5hdTYYpNTBMRSqLW8RtMuV9v6/8LYMVy7jQjClyDYvv0ybr375e3OjdP6Lt222g3iiQCqHQ8MrPIGfhHH1cMwqGUHiU27joeAXqpFt137tf4qEi5ms/zQUb3wKXa0d4bxhs0+W8c8Vp1Pl5hyK7ssflgEK0U3Ypx4H3OAkvj37RXM5Hj8SaKZKL;4:i53LWugstONNEJ4x/PtLZP3NoYHuXNZI2u6O7JGWPkwKfMMV9wzpPvqNWBbyLdYmMl1thz9IXQdVbr+NdHCkX7rJBQbw/oQ8oNSEg4iHAYYd2poVlVZElfnvdRrutjq3wnQU21wOhJLwi0yGW7hoKH40mf3oXQn9bIdFueknqWhhlcm9mJ2TVbjCIY+DVvD4z1DrWeGn9p3ktnF5BA8mupBu72MOeFC5nGDqRZSaeejF4tacgfg2T6bgAgiV2PE2ssuBVxKJEwuNLqEdGqFODhSYp2CAFGzx8lcfODBTEd8=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04718EB1804A50360F2AE10DF4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(5660300001)(33646002)(48376002)(50466002)(36756003)(8676002)(16526017)(10290500003)(316002)(16586007)(37006003)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(575784001)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(5003940100001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:23A4y6t03n6rxkn3Y5K7ChJHoVVwOBz8Nas7JXZpj?=
 =?us-ascii?Q?AlxSQZlJosy74lsjP3o2Y0OJ3By+6OrmTtyguhxcwDqssnTWskYX8Uv0fQ4Q?=
 =?us-ascii?Q?MOBlPzFG/J9Uv1sOeLqmUjPdPFqw+vK4tpn2WgMSd7bzgL0Y7RRcAYhXPYx3?=
 =?us-ascii?Q?/oIBMncTw2e/5GDCNTAvnlEF+ZWki8yc6cFhJfdknr4kFuzZc/tLHjqfFe2m?=
 =?us-ascii?Q?P8ttTH25dzxZEBYi6Vtv/+ro2iBg5DwhMq5w4UNJTLxDxgNP2glKLo09GKwS?=
 =?us-ascii?Q?4R36GkOnMz4QezZ8tl3hlHXX9y5UinBQvQxbwjnqGf6Z/tVSOTcnewL4sgao?=
 =?us-ascii?Q?eO9UDnVWdktkzEFLIZtC5tRdnTrD2TiJWYth7n0Voy2AK7pV/3ktRIFtZcf9?=
 =?us-ascii?Q?5rV0DD5TUX23ckArHnpmduauzN9VAjNVijjC7cJ31rMtmIHq66Mutq699svq?=
 =?us-ascii?Q?fbyVFpkvnURAOlmB6ZCNOeDVLJTWAEpmfeuz70iW5jc+FJw7LK33FWa91Ea4?=
 =?us-ascii?Q?xEY1ZTFwMhxaNRo5Z+cNNC+CQoxuLpOXJjoSxc7Y4vg3vgI0LQB/bDJX5YL4?=
 =?us-ascii?Q?wdesRjVILNNfEzWNhPUtLCodEbZAESo88C0CMUZVF0Ftt0l3qj1tU/3Rrfz5?=
 =?us-ascii?Q?k+xO8/H1E7lvftPDzhVp+hrbQCsVS1f8+koVnIIm4CqadUSGqwBzI8D1Tq8R?=
 =?us-ascii?Q?jNEkIYdugouzjVM5xIkpQ1FBI1eLsrxoPakADOB5pnkCnEtwKHTi3VXZZH/O?=
 =?us-ascii?Q?pvX5POuKEiburD9igqdhH1LCdKC6M21iq+nyMllO84ZNdG5foKsLvOfsWADY?=
 =?us-ascii?Q?lUq29mn9OQKlXf6o2IQ+ilUHSLOIg/JasYPBjm/ObMVy4IhkHDLuCnG8HnpF?=
 =?us-ascii?Q?t3ps1kRvTx67xuraJaUYYFuJ/RMBc5NnjHeV7AN68thVomB+Bo2rA+r8RbjL?=
 =?us-ascii?Q?u3nt69J1eKRVvM82Z9ZkkJKPWaUWK6itV+L8u7lxikJLiTNvHbrI9S/nFL3t?=
 =?us-ascii?Q?q4tll81U+n0AXPUSxihCR/qHhCNh2mQDMkrnejK8HKdzIoK2TyMUN1jH/xnE?=
 =?us-ascii?Q?ZqI4C5dWVGE9SqQrxKtO5H2HOvvchMWE/q8o6RDAH0dUuP3IPRoHcpgri/rt?=
 =?us-ascii?Q?lfrlpV07hOlhO/L5FF2f2iKCyRHDRYPGP84pA4RBHeFnmT601Kf4wcF/ZRDf?=
 =?us-ascii?Q?QYgvGjFbBjZzgjn3pKxG5Atd3k7c2XJEEESFjsXk6diBdoMmFQCmNnn0Z0gB?=
 =?us-ascii?Q?UfAdiqbP0Xm8VDUlLbJKTvKOAR1py2hGU1H6vY1vHZRSqI/KqbganV04So61?=
 =?us-ascii?Q?zAcixVbEQE7geCjo4QPwhQkh4rAEpjlP29gwIG/cFjSVxFE+CoRfxG623Ite?=
 =?us-ascii?Q?OOqSobiJG71sYWs4ZtOqJJcLmQQQOSmrnLr0Usm48A2ucJW1Q5isNLOABKXV?=
 =?us-ascii?Q?NzhQnsBbJp6t6s5v8GgveIlSpxKucE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:2cDNloV08ag2hA7X4GxnWJressawt9APDq58MZ0ImAEPzQQxTqNw7V5aXRf027faeMTjhhC8rg2um4TI/c3dj2JG800TXK3CTaAZiPMy/et/Ey/ljfMGD+5c+kr9kCA/qLbMwGC6KfgYGm4J5wAzUwiB/2h0gMqvCJnb/GXGdVIw0mtATXwaIYQFb7qGRUkdtqlR0UsDdTekBIx2RbYEKtOByxjs6mRzR+hB7P5A9yNYIiQzhizTqHpBNVL7FWUCdZa+jDI8rGWuYpqROUMSDk+FPZoU8C7TZUXe962xKyQzDDIHIIlwVA2JfCRG6/LtPNyN6mTM1MCRDya+Z2Pv0Q==;5:ODp5EfSq5VHKVdBdlax2xgXzCDxd0zEX7AxsJLmAYWj1ceRJvHBYJGhLKmPil5z0djQbYKrszfoyHc4/vtDQ09xVH6q/UUBsv9PSptS5UmiyHpxiM57HAZ5ebd/L9DbTgiVf2krF/Vw4spyJ7wpZiA==;24:11qsBSDmekImxH/JaawItd4/QPlvpgVKP45g3/83x+JRPr3pz3rEezIBt2yMlC+4TjAU5wqnrbrY+flKSPg+UR0xdjpGHklbN1qWsU8iLHA=;7:LreS5dFffuANopx8ec5IxF7iPX/zZlSLgnHuafkXnb0J4ICaGmUTgOm7G3ayPaFaykuc50hPpGB8Kabba9GE+xH+auv08nIfTg0OLJfjc9x2eznuFLtD/ZxzFASU1EjXU1zScgh+fPUHbtDPvkLZV1v1Ua1dQhX9lvVXpmbk+0elaNnUz0BBqEt+EXZmXXxKxz8kjJ0Db8WlPtEOEjWSItLldvGrTKeg+DfFcCMtqpM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:33.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new command line option (-f) to ls-files to have it use lowercase
letters for 'fsmonitor valid' files

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/ls-files.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1339e6d17..313962a0c1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -31,6 +31,7 @@ static int show_resolve_undo;
 static int show_modified;
 static int show_killed;
 static int show_valid_bit;
+static int show_fsmonitor_bit;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
@@ -86,7 +87,8 @@ static const char *get_tag(const struct cache_entry *ce, const char *tag)
 {
 	static char alttag[4];
 
-	if (tag && *tag && show_valid_bit && (ce->ce_flags & CE_VALID)) {
+	if (tag && *tag && ((show_valid_bit && (ce->ce_flags & CE_VALID)) ||
+		(show_fsmonitor_bit && (ce->ce_flags & CE_FSMONITOR_VALID)))) {
 		memcpy(alttag, tag, 3);
 
 		if (isalpha(tag[0])) {
@@ -515,6 +517,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("identify the file status with tags")),
 		OPT_BOOL('v', NULL, &show_valid_bit,
 			N_("use lowercase letters for 'assume unchanged' files")),
+		OPT_BOOL('f', NULL, &show_fsmonitor_bit,
+			N_("use lowercase letters for 'fsmonitor clean' files")),
 		OPT_BOOL('c', "cached", &show_cached,
 			N_("show cached files in the output (default)")),
 		OPT_BOOL('d', "deleted", &show_deleted,
@@ -584,7 +588,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	for (i = 0; i < exclude_list.nr; i++) {
 		add_exclude(exclude_list.items[i].string, "", 0, el, --exclude_args);
 	}
-	if (show_tag || show_valid_bit) {
+	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
 		tag_removed = "R ";
-- 
2.14.1.windows.1

