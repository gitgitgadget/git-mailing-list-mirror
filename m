Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC64ECAAD3
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 15:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiINPrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiINPrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 11:47:09 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE5362A81
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1663170427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m17wwJ7fQ4E8m58c2+thXJxRGHx8NDgg2uXCbQg2vLc=;
        b=WZkL4r6tQW03xle1aCxR7t8lea8XITQ90rg0uwBkcMlAAEBkgv2XaPeFs7/+yYhWhGgx3x
        QrNB3bIx99BTJpCGHkKlR7HahKhXiClwP0BS62Dbf384DwgHb0nFYYUp6Lv3V/WhS2Luwe
        8ac4sjkz+CI359pB+Zer+TtxknvQ+mk=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17010009.outbound.protection.outlook.com [40.93.11.9]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-QvGMC4cNPB29mnNqnZMPEQ-2; Wed, 14 Sep 2022 11:47:05 -0400
X-MC-Unique: QvGMC4cNPB29mnNqnZMPEQ-2
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by CO6PR05MB7506.namprd05.prod.outlook.com (2603:10b6:5:350::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6; Wed, 14 Sep
 2022 15:47:03 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5632.011; Wed, 14 Sep 2022
 15:47:03 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v6 3/6] fsmonitor: relocate socket file if .git directory
 is remote
Thread-Topic: [PATCH v6 3/6] fsmonitor: relocate socket file if .git directory
 is remote
Thread-Index: AQHYx69LJfEHlHcOIESkrZdTmuFekq3eGAYVgAD4u/A=
Date:   Wed, 14 Sep 2022 15:47:03 +0000
Message-ID: <BL0PR05MB557111B64B71717EA2D5CC91D9469@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <edef029a298a44ba59d19db53c2f7ba07e93aec6.1663100859.git.gitgitgadget@gmail.com>
 <xmqqillq7pdi.fsf@gitster.g>
In-Reply-To: <xmqqillq7pdi.fsf@gitster.g>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|CO6PR05MB7506:EE_
x-ms-office365-filtering-correlation-id: 6376b46e-01e1-48c0-d783-08da96685e6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: yl94oXHy60FilQN//n7PMCo2n4YhBu2U0SRc2bC9shar+Mo5QL6q/ulhAhSS7J99BkvnZxHreqm+7I9wq91XZou9bh42k3yNTBNL06ELJ3qrn5207l0bRLKGWz5O7mAIfGFFq2DrYuQqwh+zO8kOTwghOR+VHmwhkH/eRlIBWXM2dmb7kNMWa9rhQ1eHvADvhuyOFRcDODita/IDxHN8hGe+IGUpA9Vdcf+OOOTH1jrqiOxsJoZQHD0XxPyRf0nu+pevbf25f8JiY434tJNLlAFLeXDzQ1mpION1breJ1TaPt4BV8inyXpcLynHwx0AYFP0eChfUJPvd/iP9A8XLMZgpXkEgmHBQYE+CnCEhqv/NkOtjbcu/vKALitPmTVWBS2ZcSJFBJKjM77iloDkqxW22Ym2Yah877Y2PhmLhsftc3QLtfQR4bO0namsJez16tWJZBszAyq/vI0K4dMGJshdwrr6bDJX/PF5Hi+AvT/VOij+JHHHI7ME65Mc4N4t/R++pSk1tL6ImCXe7i3OFyf/ZNIZ355Dizaz1zP4I2udc4npfFuH12HcZbqZFaMWeGqrbCkzDQK8sJcwocmyqV+aKFis/7Agq/S39qPL6ROoodUGc96sBrX5fqu06hJoPtNuD3UeVN67uoq27C0NPhkEfqk/XktlbpvioNB4X+lkHILeyoS0qY6nO+3JEwzITpklhXW3nWFh8DPVA2Qx0iZzdEUPUY1qz1i7j2xp/zWB0p9trxoFk4J/HGzetlK6b3wQDXvwK/zJ0nUpfYlx9p6KQfK11QjW3/8YdhlsRPfAltD/MsNOT7xPOTN/a+csxL0YAg6RXd1I5M439qS4mRPe86C0yOmZ9o8wFw2QEtCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(38100700002)(122000001)(478600001)(53546011)(2906002)(86362001)(6506007)(52536014)(55016003)(71200400001)(54906003)(64756008)(38070700005)(4326008)(76116006)(66946007)(41300700001)(33656002)(66446008)(26005)(66476007)(66556008)(5660300002)(83380400001)(66574015)(7696005)(186003)(9686003)(8676002)(8936002)(110136005)(316002)(142923001)(473944003)(414714003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ltf4UA0xkbmh1o9c2IH+C7+MzsC6xenyMsHbS1n/HIO7stjwE5yoSV6gA5?=
 =?iso-8859-1?Q?en0mtI+dCz8mQm/enULw8coFY687RiU6Zo6yzxMkTYEZO6rzEn25sof0Bm?=
 =?iso-8859-1?Q?cL7RGymZoCKLTGcggvmys+L1qoAzJnYUIhE6Ry4SxdikEnKBGUvvtmqyZs?=
 =?iso-8859-1?Q?XL3ElMAze7olEysGrSHx6YHmldVBXN14ftp0PMaKF0nZTLW0v+ixaA1eZp?=
 =?iso-8859-1?Q?smwGOWqhnys7mSq7Nire1AyAuVPYn0O2lBzqb88T0jKVpYO6HeEikgnUzz?=
 =?iso-8859-1?Q?tGCNkRwmb2WabHhDelWd8xff9fWcRz///vFXv7Buyw7A/Vm1rIe7cB8zVV?=
 =?iso-8859-1?Q?BvMSaunOvampYA+7ym/ggHGT6kP+EsgujkdfoXbWnboQFwd52fKlSMIg8K?=
 =?iso-8859-1?Q?LcnGhwXJxc26CeWNDix5XKTr6FoLq9jx1ERChWAx/msRlc4y5U5Vxp/e0i?=
 =?iso-8859-1?Q?RMqdPDpY9oYGSU9GodYloFPXU4LzJ256dtAiUh/SIK1QrfhuA5r0DSKKHl?=
 =?iso-8859-1?Q?gIgNznHlkeIw1RoWZ4hmUYKNMWeEkLKiJQlIVEGvQYRV7q31oPmn2r1lQS?=
 =?iso-8859-1?Q?cxqLoTi64geDpruvlINa+hieEFy+qKaCkX612CHH3FAZ/CeaGJzTih85PR?=
 =?iso-8859-1?Q?LvuYN5x9X8W52MLhOp1+S2beaogV57IIfkpTSsHXzJqWN7M/qp5mx+7gkt?=
 =?iso-8859-1?Q?JoOnw2Xkyd5deC2ArqIsOyW66ViRCu0nYMvA60abBlPVAOD5bh59OyPRfN?=
 =?iso-8859-1?Q?yfTST+KocF2WpOpsP+RECJHBiwAQaiRVwo8rXg9Hz7tScvu6kXG45jTKnI?=
 =?iso-8859-1?Q?tVr4KrlNDprGGKijxhpdLksC4lEDK0bN7K/2cOc1+gSGIKkp+fw+sP5o0p?=
 =?iso-8859-1?Q?53INfY2EZgRBN9B4Xt6No6F9CZYVFB6+YucQMmmFe7Dnnnhx5qSM4/xvPr?=
 =?iso-8859-1?Q?Ubw/9EOsZk/IcJn2ZrTxOc6KR8j5t+buGDb4HSDqqQTGt8rpRuC1Qxza0y?=
 =?iso-8859-1?Q?oECJNhMKDYwX/GX+gipMxDQpkvO9sPBt3+IOFwOPBZDu5+Iz1hU+UJMGFZ?=
 =?iso-8859-1?Q?4TCZegZ61gR6qXk3VsUxnBQMuT9PLM1830SAkGFxAtoLkCY3ilGf30dG5e?=
 =?iso-8859-1?Q?bktA70hxUZOzxj236mlO7J1XVnbUGEeykTfMOcUFntVH7N2Ispne/jQdCp?=
 =?iso-8859-1?Q?IwwIZOGwItJke5ha+y9JW0FuWTgcM/r3S3nEpZW1K0Qt8zct9TBCaaVsSr?=
 =?iso-8859-1?Q?XtCQxb8QTv6TbhtOqy6XsOZSC1xr4zhhDt6mcHavgRT8DwmIaUPzhNa9Mb?=
 =?iso-8859-1?Q?l8tImZ/R6+Dj1utN90tuJkckKUjSvTxFJSSm1CBKsaKB9r9PllfiArQOtA?=
 =?iso-8859-1?Q?i0ea32ZoJUWOBjfuCyia9Yr+gZ8svezutSGXfEbippz+u2w+cD9eWzL7pl?=
 =?iso-8859-1?Q?TXTPgdZHxHZgtOM69FjRUzhuFz/gtINthxycMUGWXY/2inrslLGl+N1FBS?=
 =?iso-8859-1?Q?XeTFMNKGDr3BK+78TQPmeuVU2OLQE75Zzy2NYq+HxU3b26/3Q8ZMTCApEV?=
 =?iso-8859-1?Q?pZ8MZBWxXmanGLRRoLbd1zSNhhT24LPeEalyoiMFcn0S7tItzobEh18PIN?=
 =?iso-8859-1?Q?74SOhGbeKIc/9EY9Y2YqC1x3cqyG+f/85h?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7506
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Tuesday, September 13, 2022 8:48 PM
> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
> Cc: git@vger.kernel.org; Jeff Hostetler <git@jeffhostetler.com>; Eric Sun=
shine
> <sunshine@sunshineco.com>; Torsten B=F6gershausen <tboegi@web.de>;
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>; Ramsay Jones
> <ramsay@ramsayjones.plus.com>; Johannes Schindelin
> <Johannes.Schindelin@gmx.de>; Eric DeCosta <edecosta@mathworks.com>
> Subject: Re: [PATCH v6 3/6] fsmonitor: relocate socket file if .git direc=
tory is
> remote
>=20
> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > +const char *fsmonitor_ipc__get_path(void) {
>=20
> Looks like a bit klunky API.  I would have expected it to take at least t=
he path
> to the worktree or a pointer to struct repository.
>=20
OK, I'll change it to take a pointer to struct repository.

> > +=09static const char *ipc_path;
> > +=09SHA_CTX sha1ctx;
> > +=09char *sock_dir;
> > +=09struct strbuf ipc_file =3D STRBUF_INIT;
> > +=09unsigned char hash[SHA_DIGEST_LENGTH];
> > +
> > +=09if (ipc_path)
> > +=09=09return ipc_path;
> > +
> > +=09ipc_path =3D fsmonitor_ipc__get_default_path();
> > +
> > +=09/* By default the socket file is created in the .git directory */
> > +=09if (fsmonitor__is_fs_remote(ipc_path) < 1)
> > +=09=09return ipc_path;
> > +
> > +=09SHA1_Init(&sha1ctx);
> > +=09SHA1_Update(&sha1ctx, the_repository->worktree,
> strlen(the_repository->worktree));
> > +=09SHA1_Final(hash, &sha1ctx);
>=20
> I would not worry about SHA-1 hash collision for this use case, but would
> worry more about .worktree possible being unique.
>=20
> Can the .worktree string be aliased for the same directory in some way (e=
.g.
> depending on the initialization sequence, can it be a full pathname, a re=
lative
> pathname, or can a pathname that looks like a full-pathname have symbolic
> link component in it?) that ends up creating two or more socket for the s=
ame
> worktree?
>=20

.worktree is set to the real path and since hardlinks are not allowed acros=
s file systems, I think we are OK.

> > +=09repo_config_get_string(the_repository, "fsmonitor.socketdir",
> > +&sock_dir);
> > +
> > +=09/* Create the socket file in either socketDir or $HOME */
> > +=09if (sock_dir && *sock_dir)
> > +=09=09strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
> > +=09=09=09=09=09sock_dir, hash_to_hex(hash));
> > +=09else
> > +=09=09strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s",
> hash_to_hex(hash));
> > +
> > +=09ipc_path =3D interpolate_path(ipc_file.buf, 1);
> > +=09if (!ipc_path)
> > +=09=09die(_("Invalid path: %s"), ipc_file.buf);
> > +
> > +=09strbuf_release(&ipc_file);
> > +=09return ipc_path;
> > +}

