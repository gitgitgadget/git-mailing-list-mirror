Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CFDECAAD7
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbiHZVAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345010AbiHZVA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 17:00:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F46CE1908
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 14:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/RAiDOdAODSppak3U5Vtthx6DIxzdkFVL4RBR/Y2VP/Qi0BIPpS6etUkfuTxC7RCxsyxDenXxI2U12AYlFfkrtzbqrdiVKV9EiWOZxX9N6aPLlG5Xf5mfcVj5wwaW9pQ90kXLeR1ILlt/tTAJ3FwOIOG9VxNxlyflSmw9wFHYlV+x2aqlJzTnRsCcHGtgURDf7/Jwv/WmhT4kv5YsH3pF1j+Vf6t+zNwfni27t5g39m256mhqBRBWtpgv0k39XmdaYtD9FsYZwJdi7Y7zMuusNBnSYDsxdvdu8MTeTm6guLJ37WZArM9CMiBbsibMY0EaS+6xROGPiH12Z3phtJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBZgbzuwNzgxn5cLOZ0op/q1TVHgJrPykdtIs3ygW8s=;
 b=kmEygw+w7B8oofscdva+jwSvDjtnVOHv78F+EqfYfmUlUKPXPmx9T9j5pwZKnAQsKr9CJ+OZqCNpFzMb28mM4c67S4wh6teFLojTaXXi+kmAm6IlT9ueMIS3gO98bzwMBNysjgR3jE/ZvF6kcqL5GpDqZcg9CaCQ3cY7A0ekBZnkktlI1PLPZD/++YN9A8qRLQbZdXvStAwf1V/UosWvaZTODaCbqsP40OxpDEfNv7XiBBiceZ+25l7WnV7CAj70nPK6nhBx1jmEfPlArvvjh5u4KfIxJK7ICDUWH5ZPI/sjqB+ZXvhL52oGnDG/aYJlpc9umE2pp79mys1HlfsLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBZgbzuwNzgxn5cLOZ0op/q1TVHgJrPykdtIs3ygW8s=;
 b=OsQpjItL2flkGzx8LFR0I1nY/6MyYBP0AR7K6i9wpqvMkKfw0z0IAPPNSVgoDkrxC0KwWJwaeIQUrAGU35/qt6CDCBZMPmxegqF/kVkNj1tKmytRfdlYp0b8SnQRk7dFzlVorPw1UUeCHt3HL8H/dmZbo1vdfwqwpGvBJYFMRyM=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Fri, 26 Aug 2022 21:00:25 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::e43e:bec3:4746:37d]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::e43e:bec3:4746:37d%5]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 21:00:25 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Proposal] Pass additional metadata to sendemail-validate hook from
 git send-email
Thread-Topic: [Proposal] Pass additional metadata to sendemail-validate hook
 from git send-email
Thread-Index: AQHYuY7dQt28v+tPjkSID7y+EecLrQ==
Date:   Fri, 26 Aug 2022 21:00:25 +0000
Message-ID: <87czcm7maf.fsf@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.7.0; emacs 28.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 138990c2-5f3e-4435-df33-08da87a5ffa8
x-ms-traffictypediagnostic: DM5PR1201MB0219:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rkkCQLZVIKApkAwkM0bej+iMHjzeORfVELBv8bpKDF+ElltBpYr6LcM/Fx1UO2hWOM1gwf3Ox5ppETWIgol3RGlpnBf+vSxJAbVQ0kpT0CQbBzl6xRwyF6bwmdRwk6ggHZifaw5rDfck/0fJS4NokPjSO8i/7DKXtZZpCWQxWKCPmG31MTbiiJVg+Zh/j2fCSf6h9mUNQPuHoBj/Kkvcj0rl697D779x0AkMYWdalRQ4qUDF9kF1DV5NHNjJIHAxbc7v/BoHUA+9Qp/d1LKZYbY5TVy6hGK7+KN+EFVN0BeZYjQ1Igp9kZxTXNBMdh58s1UKhc2lzvfBa2zRtaHAHLUUxcc33qMp7DLnAB/51WUSK/iM3CT9YIp5QGoY2B/6OIJG9bWUAMYojF/ZSYV4/XOD5XR1KEttthHwVYSd4H+xwQvhV7DjfclPpJzhPGPqy2VetmtYMk8imiaBxjQFCCmoo960XwQbiBAbLLyaAJIpJRc/sNCwehdChyQZ6W4u5oL72SlhlvrdLt9rVsgumG9IeJKVe4ytUiVztlbdms4IULQb46FoZwRYoVa3v+WweAShNhZaGHuiUZB77tn7lE3Lrnv99ZVRrhEAH2zfR+JQRZD930gjMsSJvmCx8RtJDVjXFVjRDGeAi892T1PZrKSopRb1Opeu4z+qf7z+5o7C2X+rWlQEk7CtSMBds6TAwPn7ibQSj3EGMDdGrbIq4tm3p2Dr/Pb71qeqjfZ+TZalGxzYDUVK14W9NYeLvAwxpOEduo+8Ysp/ST1jNdpnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(71200400001)(2906002)(83380400001)(66446008)(36756003)(2616005)(15650500001)(41300700001)(186003)(6512007)(478600001)(122000001)(6506007)(26005)(5660300002)(64756008)(4744005)(38100700002)(76116006)(6486002)(8936002)(316002)(86362001)(6916009)(91956017)(66946007)(66556008)(38070700005)(66476007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aXuBdhuMA99J41T7lXNeXlwQ5GWJEfxwy9ICM2kQClXpnBeX8T0MvRu401?=
 =?iso-8859-1?Q?XEzvmtC/b4GoMRopRRuJtOLiCLIwcMGI5pJa8Hw7nEaDyhMHDpYknlakEi?=
 =?iso-8859-1?Q?fua44HIXfomAJwrFQ1pAzETGff42KDJ3ht9up7Zs3hqczyJWe9ymVOQ7Hn?=
 =?iso-8859-1?Q?TkzYJ0SmeVp3dGrkmEPcDwKGn8ts4jLUfg/uqWl7QmejZeNOUSDC/0Cwg9?=
 =?iso-8859-1?Q?y+RYxdFFdfNw3y0IaqNgoScTr+LxjL0OfmatSkJgbET6rHqDDP4HGzG9wD?=
 =?iso-8859-1?Q?YoNiMothpJK037aK2zObCMmuX5oI/Xr8He0JyH0Njd5Mvji44slAgZN35l?=
 =?iso-8859-1?Q?sLNvEYvfrj1SITWabf9cM3hP5JhSo34T5VdL8hkFdgA+CPUwODCpYIXorX?=
 =?iso-8859-1?Q?coPJsQr0Eu3ph0c/0MLkUNNrrACiCG3r4iyxuu8GVO8Za3CDUp9n7ip3zu?=
 =?iso-8859-1?Q?56rzjj5MjaaRFbpMDvAE5sfwW21b6H+ijW6Yj10LErvQa4HlJYo6RIuyV5?=
 =?iso-8859-1?Q?RjmPXpUOimKPRwgGwRSMcf0Z/ggJGIoVvWJY9I8knykxVS3GAL4bGbgHll?=
 =?iso-8859-1?Q?crOTiSeT00SxoiBjkgPjl0U2m81kHlCgodyLZF7SN7n3GCVsN38OReV2Qu?=
 =?iso-8859-1?Q?BuiyVpliokufOzvJLLfOqC8p88emC4dvFpp51PYk/qHZ4xLS1Z8EfD8zoN?=
 =?iso-8859-1?Q?k7HDM/bgXaiG0DAM7Ib8a+13Cax41MAZckFUrkY/1S8EJlVcp+j1tUAEqw?=
 =?iso-8859-1?Q?yf7ZXWYz+0CH62/I+s7KwtIUp3WdK4wZP4yf5gXP042oHaimPDXUrpBrEo?=
 =?iso-8859-1?Q?4+P3DHKHSxdfQ0jsxrf+tWUmlhNxRX7S+fUua2NT0vb1AEBQ/0pk+Bxg0k?=
 =?iso-8859-1?Q?lfYyuQShWnsS5JcgYGG9Ue3bEoSpGjX7ku8X2SxH455HUouu66iEsda2Dr?=
 =?iso-8859-1?Q?xlF15kGjtS17O4R1/1HqnI2BgygyKiCxlRt4baesdybiM2JyLzWs3SxSBX?=
 =?iso-8859-1?Q?V5W80N0kq2Gh4BC2qszUJUII0WIPDOz7BHa4QTElmaoCa5S07P+5hNBO5y?=
 =?iso-8859-1?Q?lT358zw6zUOUEfgCrMl5lIn4ffhCS+xpnW6Z4xIQRsSakyvG4kd6KWIIDI?=
 =?iso-8859-1?Q?GHrVOKdk5gQROt42Gomf9fVeZovVM8Qet5j2OE2Q5y5TIsRQitlFUGOaYE?=
 =?iso-8859-1?Q?q5rL7Xreh4yHeSqJSvSZAMLaC0XfXSrViIGyQqtk+sASA4k0a5KiRly+C0?=
 =?iso-8859-1?Q?1Szjtfx4DvK+pgkFSP/b0mNL1conwKtrRCOqU5cnuHsmOhQiraIsJOC63h?=
 =?iso-8859-1?Q?kbw4Pa7qXvT0s2WT/HWUQgqxRp2gYoH49UFgNCJMEOWxnXtCz012ZQpWou?=
 =?iso-8859-1?Q?KS/JRgbBtnrIZBSEA1CPaKdsT5S5SQhrbt2+jDJd46PkUAKhi9VnhPDvsA?=
 =?iso-8859-1?Q?VN0NzjzLEs4RwE38AxBCAyBI64e00A3WrOkg+GNVyzipPtIJj5pF+gbYF1?=
 =?iso-8859-1?Q?SoIjO7peUsm6veUwd2Tc1QbQvZFnvg2rys9QHHi59Y6JkQ7MRWjB3I7Uo2?=
 =?iso-8859-1?Q?+On3UYpTcKgQFhALuJwV+eB+RZ+2YjaehYwiI1hxZhR57JXhKP/0V1lIUi?=
 =?iso-8859-1?Q?0BZ5HUrw/Si4fAwuZMPYGYWCaSsH4D00rw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138990c2-5f3e-4435-df33-08da87a5ffa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 21:00:25.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSSdUy6M5BxlFBc+xSauKVfzxp360JtcPOjcbCKQNCPUMflSjxsawl5D9dpNM1/1eZY3eryWV8lOjEZ7t0pvLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was hoping to put a feature proposal forward for git send-email.

For git send-email there is a git hook, sendemail-validate which=20
gets the body of the email that will be sent but is missing some=20
of the metadata that git send-email has access to.  I propose that=20
we also pass the extra metadata that gets presented to the user=20
later on via stdout such as: From, To, Cc, Subject, Date,=20
Message-Id, X-Mailer, MIME-Version, Content-Transfer-Encoding to=20
the git hook.

I'm willing to work on the patch but want to make sure the idea=20
would be accepted first.

Thank you,
Michael=
