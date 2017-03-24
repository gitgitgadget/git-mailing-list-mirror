Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46191FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 12:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdCXMjM (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 08:39:12 -0400
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:4320
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751295AbdCXMjL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 08:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fSBnCxFuEbDVXlLK0f/gUrDXzCBCW5oB35pSG3SXrhc=;
 b=n5dnQcd9hSd0bcHSiAAzlJkppa6j46kSTR97R6dIFPzZLvuQNxG4zDp6Rp9ONlhdDP0D+AHqnEEdmjBezEsCkjjmf19C40M06/74aueSq/Hu5wD2CsSmMxADtzs68tfjGetjl7Wv3vKJGFg+dHKY1RpoBM5k6pHXMR8W0qie1g0=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB321.namprd03.prod.outlook.com (10.141.68.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Fri, 24 Mar 2017 12:39:08 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0991.017; Fri, 24 Mar 2017 12:39:08 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
Subject: RE: [PATCH v1 2/3] sub-process: refactor the filter process code into
 a reusable module
Thread-Topic: [PATCH v1 2/3] sub-process: refactor the filter process code
 into a reusable module
Thread-Index: AQHSoyzpU8K8fsRaT0qa2gB4ccvUfKGh87z3gAH74XA=
Date:   Fri, 24 Mar 2017 12:39:07 +0000
Message-ID: <BL2PR03MB32308D0F2BB1C7D6F04141BF43E0@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20170322165220.5660-1-benpeart@microsoft.com>
        <20170322165220.5660-3-benpeart@microsoft.com>
 <xmqqk27gfrga.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqk27gfrga.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [65.222.173.206]
x-microsoft-exchange-diagnostics: 1;BL2PR03MB321;7:FlJiDFeggi7SfNks4Tc/opDkqHzjg7m4SXFSFHIEjBmfBPGiefr0dBD4sf7wUVvfbVaNnx3DD9tswfPlVH65DGu4niQEo/qptzz3btcnYU9ZMA6J9vyhNF5farke+v57ae0mYaWphMqzIQXxSoHIW5GWDsgguzA/IualzEWIMICSK/TD6z6wO75dtmcrGLIxSCW4aCfU8f7/PNUAjdhyOZ2yz1rDM0Xuf4pnapep6R4s8mjhVaaJhby+cgCv4SSCILiKZ43lMO/qmRiYUqYszQF1RbH4yx7wdgFNnwpyeGXzStlxESVN0dAxKbqKGg4QbMuI9QN8XNrvFm/tmucMrbOwvz+PfgMJgwaMEY/wGok=
x-ms-office365-filtering-correlation-id: 4e878507-2db0-4f55-8081-08d472b2c3fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081);SRVR:BL2PR03MB321;
x-microsoft-antispam-prvs: <BL2PR03MB3214AEB1E184882BEA01BA6F43E0@BL2PR03MB321.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123558025)(20161123562025)(6072148);SRVR:BL2PR03MB321;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB321;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39840400002)(39860400002)(39450400003)(39850400002)(39410400002)(377424004)(377454003)(13464003)(8936002)(86362001)(74316002)(81166006)(8676002)(229853002)(76176999)(122556002)(2950100002)(3660700001)(66066001)(102836003)(8656002)(3280700002)(4001150100001)(99286003)(53936002)(50986999)(7736002)(9686003)(54906002)(3846002)(6116002)(7696004)(33656002)(86612001)(2906002)(55016002)(54356999)(305945005)(53546009)(39060400002)(25786009)(6246003)(6436002)(8990500004)(5005710100001)(10290500002)(10090500001)(6506006)(189998001)(4326008)(77096006)(5660300001)(38730400002)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB321;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2017 12:39:08.0669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB321
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Thursday, March 23, 2017 2:17 AM
> To: Ben Peart <peartben@gmail.com>
> Cc: git@vger.kernel.org; Ben Peart <Ben.Peart@microsoft.com>;
> christian.couder@gmail.com; larsxschneider@gmail.com
> Subject: Re: [PATCH v1 2/3] sub-process: refactor the filter process code=
 into
> a reusable module
>=20
> Ben Peart <peartben@gmail.com> writes:
>=20
> > This code is refactored from:
> >
> > 	Commit edcc85814c ("convert: add filter.<driver>.process option",
> 2016-10-16)
> > 	keeps the external process running and processes all commands
>=20
> I am afraid that this organization of the patch series is making it harde=
r than
> necessary to review, by duplicating the same code first _WITH_ renaming o=
f
> symbols, etc., in this step and then updaing the original callers while
> removing the now-stale original callee implementation in a separate next
> step.
>=20
> Would it perhaps make it clearer to understand what is going on if you
> instead started to update the code in convert.c in place to make it more
> suitable fro reuse as the patch title advertises, and then move the resul=
ting
> cleaned-up code to a separate file, I wonder.

I'm not entirely sure what you're asking for here but I think the
challenge may be that by splitting the refactoring into two separate
commits, it's hard to see the before and after when looking at the
commit in isolation.  By splitting them, it's more "a bunch of new code"
followed by "using new code" than it is a refactoring of existing code.

How about I squash the last two patches together so that its more
apparent that it's just a refactoring of existing code with the before
and after in a single patch?
