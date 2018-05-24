Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30CD1F42D
	for <e@80x24.org>; Thu, 24 May 2018 14:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970473AbeEXOoR (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 10:44:17 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:10910
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S970469AbeEXOoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 10:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlkAGvgIsdY05ceotM1vyW93iS/gkwZRlDxgWnxGfUs=;
 b=anIbcY3B1TnWGc/r6kG89NOFmupeZZ/GhIZfYUz1ULWD90u4srPcNInVpq7/CDyNEYJ2ShLhPOJe9YskicsYuBgV1xUmBWenMf+vIbct/hHrjkCsFdQxHUURa3TXJ9GX7n9Tx5i8+JKLcuScro0IFPRK6yQ2ypE8JLHckH/2rK0=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0897.namprd21.prod.outlook.com (52.132.23.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Thu, 24 May 2018 14:44:14 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0820.001; Thu, 24 May 2018
 14:44:14 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>
Subject: RE: [PATCH v3 0/7] allocate cache entries from memory pool
Thread-Topic: [PATCH v3 0/7] allocate cache entries from memory pool
Thread-Index: AQHT8qT4yabJZ/7WG0WRtFmcJ5diXaQ+UY/CgACLHlA=
Date:   Thu, 24 May 2018 14:44:14 +0000
Message-ID: <BL0PR2101MB11068051AD589871D4D707CBCE6A0@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
        <20180523144637.153551-1-jamill@microsoft.com>
 <xmqqa7spsle1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7spsle1.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-24T14:44:12.5603879Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:b15b:d177:caa9:26d9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0897;7:u7l5C3o+HqlsWoAH4kqArq5Abge/LqW7YeNSCbEdH76Uiud1aJAnwWHbGUa3VZBFStKsNcVJIs/01uVPRnYr1RaRN6QIP62E65HRK9kDvGs7/xzuDAPL3hU7yMBQgEtDrtot16Uup9hAt6bM8FTFT2UUyvIpjj1Seh4SGsczh06dLg0W9E1f9BTKtqlDWlnYswFKAGa8OrYeTomPZpAjm2ECfW0xFr5oSsrF78Wc0yidMHlVgxXVUmYH9MMeiewt;20:uJ6mUu6iIOEu25U00y36R3LyISAA8GmASypwQ2ztESK3U3Rx9h5ClVPypieMOF9f5G8pExoYFzkW0BqmqiI1zL3+oMWzwPdRfFTEI7oomTgds3COG3J6guayyRTXP8CIykyl3Hb4cjZiI7eLmUKdaxz2bEopqfvj1dxdqkFNNPQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0897;
x-ms-traffictypediagnostic: BL0PR2101MB0897:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0897C5D66E9102147FCB6F83CE6A0@BL0PR2101MB0897.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(788757137089)(211936372134217);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0897;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0897;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(39380400002)(13464003)(189003)(199004)(186003)(53936002)(86612001)(9686003)(97736004)(10090500001)(6436002)(99286004)(486006)(25786009)(14454004)(3280700002)(2900100001)(74316002)(6916009)(81166006)(6246003)(81156014)(5250100002)(478600001)(86362001)(6116002)(8676002)(46003)(55016002)(8656006)(106356001)(8936002)(68736007)(53546011)(102836004)(6506007)(476003)(7696005)(7736002)(54906003)(4326008)(305945005)(22452003)(10290500003)(2906002)(39060400002)(59450400001)(33656002)(229853002)(105586002)(8990500004)(11346002)(76176011)(316002)(446003)(5660300001)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0897;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OpmIzAO52mEC7KuebR+oCo6zwrXxaomsRmGAWR25fRvXLuP1nfd32dcVbGjM4SDibayBw+pkwxMyozmuh5YB7sPwBLSom3fJqb6qW1/9LTmnbO4TyTqcWwH0fX/CDlboCSvMYxaIrmDDGks0mcgWahYherm33g8siPFvsX1rFtaT6gaZrYmVGW8doB9GnbRq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 24deadbd-c908-4a2a-64f9-08d5c184d1f0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24deadbd-c908-4a2a-64f9-08d5c184d1f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 14:44:14.3558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0897
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
> Sent: Thursday, May 24, 2018 12:55 AM
> To: Jameson Miller <jamill@microsoft.com>
> Cc: git@vger.kernel.org; pclouds@gmail.com; jonathantanmy@google.com;
> sbeller@google.com; peartben@gmail.com
> Subject: Re: [PATCH v3 0/7] allocate cache entries from memory pool
>=20
> Jameson Miller <jamill@microsoft.com> writes:
>=20
> > Changes from V2:
> >
> > 	- Tweak logic of finding available memory block for memory
> >           allocation
> >
> > 	  - Only search head block
>=20
> Hmph.  Is that because we generally do not free() a lot so once a block i=
s filled,
> there is not much chance that we have reclaimed space in the block later?
>=20

The design of the memory pool is that once the memory is
claimed from the pool, it is not reused until the
containing pool is discarded. Individual entries are not
freed, only the entire memory pool is freed, and only after we
are sure that there are no references to any of the entries in the
pool.

The memory pool design makes some tradeoffs. It is not meant to
be completely replace malloc / free as a general purpose
allocator, but rather used in scenarios where the benefit (faster
allocations, lower bookkeeping overhead) is worth the
tradeoffs (not able to free individual allocations). The access
patterns around cache entries are well matched with the memory
pool to get the benefits - the majority of cache entries are
allocated up front when reading the index from disk, and are then
discarded in bulk when the index is freed (if the index is freed
at all (rather than just existing)).

> > 	- Tweaked handling of large memory allocations.
> >
> > 	  - Large blocks now tracked in same manner as "regular"
> >             blocks
> >
> > 	  - Large blocks are placed at end of linked list of memory
> >             blocks
>=20
> If we are only carving out of the most recently allocated block, it seems=
 that
> there is no point looking for "the end", no?

Right. If we are not searching the list, then there isn't any point in
Appending odd large items to the end vs sticking it immediately past
the head block. I will remove the usage of the tail pointer in the
next version.

Yes, this is true. I can remove the usage of the tail pointer here,
as it is not really leveraged. I will make this change in the next version.

>=20
>=20
> > 	- Cache_entry type gains notion of whether it was allocated
> >           from memory pool or not
> >
> > 	  - Collapsed cache_entry discard logic into single
> >             function. This should make code easier to maintain
>=20
> That certainly should be safer to have a back-pointer pointing to which p=
ool
> each entry came from, but doesn't it result in memory bloat?

Currently, entries claimed from a memory pool are not freed, so we only nee=
d
to know whether the entry came from a memory pool or not. This has less mem=
ory=20
impact than a full pointer but is also a bit more restrictive.

We debated several approaches for what to do here and landed on using a sim=
ple bit
for this rather than the full pointer. In the current code we use a full in=
teger field for this, but
we can convert this into a bit or bit field. The current flags word is full=
, so this would require
a second flags field.

