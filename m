Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4236B1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeCWOov (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:44:51 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:37727
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751657AbeCWOot (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0pjkfoK3jql49X3imDsOjI1XeJVmR40H0rZp9UkLWAY=;
 b=BLYBSnAptz0ykChHSpWwOGiZ3GKUgT6ExGF/AZUMnopQaq9d7B2r6GYSEJ86aDs8jiNU7MitvsWQh/Tfmjo2AtcWGkZKtf5Q0MBbTZtM8H0Jw03e0e/vm2eM0/oewRc6pG4SPG0nShdMTc+QQ3bKCzYWyQwQZtC7rxGKUoWmO0c=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 BL0PR2101MB1105.namprd21.prod.outlook.com (2603:10b6:207:37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.631.2; Fri, 23 Mar
 2018 14:44:46 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 0/3] Extract memory pool logic into reusable component
Date:   Fri, 23 Mar 2018 10:44:03 -0400
Message-Id: <20180323144408.213145-1-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1:1060:bd2c:4297:50e]
X-ClientProxiedBy: DM5PR0102CA0021.prod.exchangelabs.com (2603:10b6:4:9c::34)
 To BL0PR2101MB1105.namprd21.prod.outlook.com (2603:10b6:207:37::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1270dbeb-b861-4ea6-884b-08d590cc9ff0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1105;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;3:f3XaPosdlsJAJ7VY94Ipsk0iMDagoeO9bw0veq4sUAs4JNjTkD8JSdz7yGJNEkN2jLL6j5tStR+IW8m6r7L8pUGQ9KGnW1YyaBjNDrVScRNOk3Qz4fGclQ5UlDNl5s1Q+PK3rba7LRWxrM6yFllTuLj/V6gNxsBIuQodgRCYOT49Lwdv9DTMvz0jTwR1JG71mYJbFLgqkwF8iJT0la9U61AAhRdAs4Bo30OhB/SGgUHH+6++wukQp9sIrVypQ9l9;25:RoFB2aYLNp+KWHurB745xW6hwkvEs9aRsq3jZhxj10IkVqKEtZmJFd3vfHgwfg0QBF3pUNiDA12SXec5bYtm3AmUGCEDqFHUxmV6RDRQNKhPekhcqZKtGaNyDPBs8siq4RE+Z77yBdCB+aHCuehlJbpWu6k4x1lur8yBZlmrYztdRQ3fWfC8z/tYPxrcnlQBLPdXxuQ5/LcUsSXe+ILyHF7GJ5/NEol8i071SCzhgzXUV8xhZnDBeRKrmKAKxgUrLQTPEaJQkbsqRsEy49vc6k3V2LPbjlhCAqTEFBKDsfNprrpRBpxWbtH7Yg2YraGZTBTAzEzO7j1w1Ba+E/TBVg==;31:0/zqUwzj2R3LtNZW0ncxH7D+K9amh3cIy16DRniKFcT0ZmJ0UgPdP1cWHTJItnxh1SRhem5Wdnll0FJQokTkAhvuL+paxc0OeCZxwhv5AuaSTSdGdo9CKyleM0lE3duTS5AgDgrKnFDjXKlPU5dCht4EvdwuUoS3DapTxkvSg8KbXZHhBxAItg/untZkha3ztSuTXzCJG+X/gb+yONZny+2Gga7wb46zzPjb4UeoJx4=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1105:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;20:NgGOQ45w+yA1fXopSTAEw3XpaKkfDUuP9xrtEG8D6u3WPtd3Pi6w39hzFIyE76xutjslArOraPghaEXQYHSw5xFmdXW1orz78xF1DioAD/6xXVOncP93uoS02lnVjWJ6/tpQFtjNCLYx27+8MXfMgQgvJf3IT0NSx/rxweLA94QawYnbOkR9lD1R2ZHvnY1m5dyGYQ/2qhcsiT1mCL9zgQ27Tx0MquT3hfdZnpX1rXg1zu9dwW5+urj1LNRDjYkjiugEKwFSbky17eWsM0bHBpdVDE9YMkmS9nl/EMYcWntxD8yNbxY7ax7x1KqfsMkXSSFd6FilNr7Df/ZhwNVzQMILSgiTsBy1tiqOdoVxDqvnIXp8fSvbxmF1QKxzeYYn4wsPLH3c4ADCFRfTPQJ9LPscdmTFdiJWGKikFAKwYENt8ySqzuxSCr0/6mqfAYdCOBS1cbvUZV6pxnEKD1BY1WeN80wmcb8BPvHwXC3cLIT2XVcyBCApVbqDFkueg0s2;4:kU8PtStcZwOBd1WAwPy0QSgDHah3BXHwlLEHP+tnfv2uOsyKdfR0VjMl4kh2pWbRdpuwGLDlj2eaQA7AFwtP3SXB0avo3sPFAOYgFbmhvaQ0uaOdbcCW1JS9HDTHXa/f7zy4ukjU8e9xqPtxGvEZE3PBSfpQ81ofwBcWkVuw6oJ6RVvh+f2H9rhs/BSZ+W4C05Ez/7fAlgjnPxgvfiuD2Wgzo/htyKbjdUXpv5CCFs2GZ9lvobpQ3CWM2NNIrdBTQKpKGv8xRjtMCybS23Eboq5h3Q7sHM84Wqq26F017DBqYA+VpxnPeRivjR3oRs4j
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1105DFE067F50BBC2A5A4264CEA80@BL0PR2101MB1105.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(305945005)(446003)(46003)(11346002)(36756003)(6916009)(6666003)(4326008)(5660300001)(2906002)(186003)(6306002)(68736007)(10290500003)(25786009)(7736002)(107886003)(16526019)(86362001)(2351001)(8936002)(8656006)(22452003)(76506005)(478600001)(50226002)(966005)(47776003)(52116002)(6346003)(316002)(52396003)(97736004)(48376002)(86612001)(8676002)(81156014)(81166006)(51416003)(7696005)(1076002)(105586002)(106356001)(76176011)(16586007)(386003)(50466002)(2361001)(53936002)(10090500001)(6486002)(6116002)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1105;23:OFpJPaUGuJWw/fKVO3qZQN7AJH5Q2/V7vIYrunc?=
 =?us-ascii?Q?EOylboBfnePwQqhAwRXUN9jK1q/sUkD5CPpb+fHKQVrny/jYreWYjQ8b3+7o?=
 =?us-ascii?Q?qYOAs4BP65YvhB6p/hgj8U/IMt6hSeIc7bVkuXT5OVLtMG3OhrFW0w1p4G9q?=
 =?us-ascii?Q?bETHzAkAMlU7B0i77s0x6AM1SxqDi9M68z54ZP07oCcPaRLVBt7FCkNjXjnx?=
 =?us-ascii?Q?tYtU/9owl39f0SQpMOcAFAFpWVLe8pECfwiEzcM/xgtXwXFOCyrL22nVGxxI?=
 =?us-ascii?Q?gFViwPYVJWN9ptkLPwW+38oEZXFnTTkxyf/BazsFnoK0OpjH4juhqJt9+E1R?=
 =?us-ascii?Q?Ai61PIy4HSVxyBh81Av8oq7QpHm1h6ZNLVjSbPFfc6QtbYJtkn8iFGmn173N?=
 =?us-ascii?Q?3WNMjX3i/aD11yDsQC3BauSb5BJ2aZDc5OQBT1T60MQohNOm9dfzjkqLa/IE?=
 =?us-ascii?Q?Hr8HDBq7wdV/9CjIDkH9HkFT6VOoXUm9DlhKXFboE5mTh8H/Qyy9PR0bLMH3?=
 =?us-ascii?Q?AXg0WgeWVdjM5k/+mCvz1S13A7o5slNMme65RM0Bj+CzFw4La23oCxqtHbK2?=
 =?us-ascii?Q?RUQIWqfxUfksSZrWWzxUY1l1mRGuBG8Z63BheO7MWBx6N4cAsJlLPBhjp6V7?=
 =?us-ascii?Q?rL58x6+iSsnENJlhfbeCnl8hnamcUnhmfp24yrmGh5Vk9K5AY+uuBsnGerE1?=
 =?us-ascii?Q?NQbCuwJZ60fV3DStWth9W25W/3HTFkJAMwF7G4Za9mEY65MQieUz+IeMgU/d?=
 =?us-ascii?Q?f4tT65glFLE97I0AwAESrPBhEbpQL/qdQqWwWUmsOFbRkOX0NsKWVTJFy8MU?=
 =?us-ascii?Q?ygtO2R0bIJtse/cTgr3GJavcbKdJrm+Q2Ybcqh9Q2gaMapXHRqQ2Kg2wDJcd?=
 =?us-ascii?Q?iGeSimoTzMXLxjD/v4JY6cifYVtmBdPK/VJ+SrQ+Wfs7N/AwGt9Om1gXoZbN?=
 =?us-ascii?Q?ghGGsczAXtDS5km/OyfLOeW5YMi62/6iwVb1k5Vm5OWS6ToWrVLNpIaODu+/?=
 =?us-ascii?Q?+KC1o2vF0pL033r37XmcozulnyGiWanjq++55HzQtE4d0TC7KEiFyPfb7LZj?=
 =?us-ascii?Q?dt9w3ETNKmkOEasiAkCJX7xTRSv/vikah2VI3IVZZUFl5kRptYjTU1bFhJF3?=
 =?us-ascii?Q?BhDtqU1h0rGf/IJP2svzgZWAteGztG/8sZ4Zk2494lxRfQW6V0zVHbjBzxsY?=
 =?us-ascii?Q?k4L56bK7W2M4H03Tw+/hFyPf6pOGiGsT1dq7KfCqt9VmJOzMHhWqXtPzFf/m?=
 =?us-ascii?Q?xwdvbqj1nDOAfqoLhdgWVDidjkN0T26jPJd/+/8czpglHojcDhIp4qoWOjVR?=
 =?us-ascii?Q?fofj5XxpB5HBCSmnJiAAMJ7jp/q8WyG6cePgxQJkbiceB/JZ3oUfIoVdidkn?=
 =?us-ascii?Q?C6kAKcwGBmqQNqwzhctSiVl9diY0=3D?=
X-Microsoft-Antispam-Message-Info: KKm/85EoesCCv/72p6dDsSAKHJYAGb7iHjQWcZltcR7AJI7ffrnjjjNMcL0pWvKZUqstfh1FM+6qwLqEFGuez5Rz5LQ/ieaasxnQPTAX3WuVY1F5vHYVLgAjXjYoPVOiGiqCsnfvyBxxXSH6KPp6D31pnJZs3WiTmwfXLulE9JBhDaxCUtPBjPvK+YmaZYPt
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;6:Na+znF/47wK8WazzVKkcEudCw5ExHHfaYjfs3xpVu+cwBvLQ6a607nkmAe8DN433ePBxRpyHoIztuKH4aUpCPbYUHlwn7UFmNCOOmBbcQdu2CPWgGd9CvZbzPdgKMBkmiP7IiXsGWO9lxw17CssMnh120B7oWTFfrggvlT1m7EM6eCjC0J03JDNFeXgyvQmz5wGHie7Ko5O16JN/1EdvejKn6159iGxCvDszRS8uINrSPhUXy8PA/T2siC9UNoe5srg/aNucQ87XfIGQA40M6X4wth64usKYtCYimRUBswDmoRFNR8963dw25kQBYhmB4ZLI8ERqIqOamzspp+QVGF2RyRbVD2z0DLu9vbaA1jjJJpHrXWZmjKYpyyeelNJfR3U1citKT2vzdahTNmMvw16rGsWZX/UeDGzld7aZ2d9SGy3OkZRCFKTpQ0UPX1CZBwikKlEnPmPbsouCBxUv4g==;5:6Sg4tgmikvmW/CYiYJH6zNigSRUFkhz9c2dg8ntIWiH74CXYRFseyU9H1ys0rVRUT5ySHGCCR5LbLqF9IprJwh1sCX+w6xfw0pGoFb8RliVZxIWu8utgZ3mkAnajYgrzTFt2+/ygU787a4ss/bOej+mtQDMwPmDNBHrPIjS+rU8=;24:YNJimus+kW31+wzw35SmxiZVD99XlaujPal+IAGV+AUgmkStWz8ChZSKlLe/3O7CrjTU5VMQR2UWup7IsoT6ZeGfLTqQtBAhli5rr85FafI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;7:bymGINhQ5ojPILAlyDpP1fijn+cuoRhe4nIYkCdWyRWfTMZcXaVmf5bCNn6ddQgSlfUITtxegTHis5OjClVlZNSIZJ0o6bZpGjGme0j5ga0Rlps/t7asFqHuequ30TNRFFkkTbBS4IAO7YQgDXF5LNMC8ZXHang/R+Q20zPbU7BgC2TU7LoD5M+8rCUjOu3UJTIcrFDSNaCNRlP3qmckoswnXgiaNM2ucUCd0NXC0HZxwwltu4Q/VlCvEoU4LkuD;20:1q7kEvaHc2lPcKY0ii/3wpHUgluRETcJ41IGHhgocv648cTx8l+anuNk41ntgIk0li6UicfWyOVix+ptvm36vPyca/deqbgFf8UOmNANyKdgELqncU+ig/7di9525zPjO+6VYAEEHqQhWzikh0Tld8LtqS/UYKds+mqqLwup7/A=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 14:44:46.8038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1270dbeb-b861-4ea6-884b-08d590cc9ff0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v1:
  - Rework the structure of commits to be more reviewer friendly.

This patch series extracts the memory pool implementation, currently
used by fast-import, into a generalized component. This memory pool
can then be generally used by any component that needs a pool of
memory.

This patch is in preparation for a change to speed up the loading of
indexes with a large number of cache entries by reducing the number of
malloc() calls. For a rough example of how this component will be used
in this capacity, please see [1].

The last commit in this series includes changes to fill out the
mem_pool type into a more complete implementation. These functions are
not used in this change, but we will be used in an upcoming patch
series. I can remove this commit if it is desired.

[1] https://github.com/jamill/git/compare/block_allocation_base...jamill:block_allocation

Jameson Miller (5):
  fast-import: rename mem_pool type to mp_block
  fast-import: introduce mem_pool type
  fast-import: update pool_* functions to work on local pool
  Move the reusable parts of memory pool into its own file
  Expand implementation of mem-pool type

 Makefile      |   1 +
 fast-import.c |  74 +++++----------------------
 mem-pool.c    | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h    |  58 +++++++++++++++++++++
 4 files changed, 234 insertions(+), 60 deletions(-)
 create mode 100644 mem-pool.c
 create mode 100644 mem-pool.h

-- 
2.14.3

