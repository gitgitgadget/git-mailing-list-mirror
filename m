Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2003EC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 19:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJNTjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJNTi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 15:38:58 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254BB18A3CE
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1665776335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4yu0nQdtHuFAjcSkeD9MowB03TNCAG3X29Zga7Qvjo=;
        b=jqFmaUIXg3vnc3m64v/SOA/9/5kqX+nhx0gQQ5hDb/CatBcSrRcUyZV8vymGsOcs1oFkdK
        DYmxhnlwRutObhYRqCDcYvQpI3ziJ74ikTI0SF77x/vHyq2Tj2TDf0JpVwOBSYFZWbEvZh
        aBL37mtajJR8bzF7oHFsu1px4+5gsUI=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17011015.outbound.protection.outlook.com [40.93.11.15]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-_M3Cv2dlMYSsxelp-oRM9w-1; Fri, 14 Oct 2022 15:38:54 -0400
X-MC-Unique: _M3Cv2dlMYSsxelp-oRM9w-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by MWHPR05MB3293.namprd05.prod.outlook.com (2603:10b6:301:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20; Fri, 14 Oct
 2022 19:38:48 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::fde9:a6ac:96b0:a49]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::fde9:a6ac:96b0:a49%6]) with mapi id 15.20.5723.016; Fri, 14 Oct 2022
 19:38:47 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 08/12] fsmonitor: determine if filesystem is local or
 remote
Thread-Topic: [PATCH 08/12] fsmonitor: determine if filesystem is local or
 remote
Thread-Index: AQHY2+y2QfR5wga0nUyvyAygn3Y7Yq4HZ2SAgAbo9HA=
Date:   Fri, 14 Oct 2022 19:38:47 +0000
Message-ID: <BL0PR05MB557182AE46A91AD0CEF15CBDD9249@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <5ecbb3082f16956d049cfa98662f8e3384a6aea2.1665326258.git.gitgitgadget@gmail.com>
 <221010.86sfjwouqx.gmgdl@evledraar.gmail.com>
In-Reply-To: <221010.86sfjwouqx.gmgdl@evledraar.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|MWHPR05MB3293:EE_
x-ms-office365-filtering-correlation-id: 4636ea47-1f60-4d70-9454-08daae1bb6b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: rW0jMgmg4bE0coyP27tovTWlqDu9ac8qvB+ch8vk9A0Kgz5TsgFivM6wXBMEsBKkMWgi8ntzh4uX+gkbpAY+gzSif98fkCiazmqTvfYlojrboUwtBZrI25c0k7T6bJ/MQcgCMrUeQu111t8deKqi9959df2fP1TSoboFpz1Y71dPCshBrIfLfJM+IO59chlBPc8VBubgkdMRAsh5PBZ9MsoIECat8istdaWbOmm9SiTEjPp/FQ9bFaTPIakpLDiUJI2KgCUxb54MVnNkGYokg0Weq1LhAUbuamt1yJV3uvJos644VKAIA1JTgf43CVLqkmxMb/gkewnXPG4hCWsfsa2n/JYxVc+kf5TIdSDBcuDPJbnsz5zY+4tG779EbfTJ7LnBYZte2//yLzBZIG7VDJWIi33k3NW9yr0d/PXWwCE+9xWP7mogF81nHSMaekbpcZKsb7zR6d7/AEci2hO8IXMGQnn4H/Bm9WL0Az+ethZRDMw7CPDUdaFZTT20sGYeEjsvEqGs1iwiWCNnk4dvi4Ga8dRHZbnJphDK1XKHKLs1IWfKAH9PV2mQrvy4mooxaSPb6D2FapP2bC0hCNw2bbWbBCcO7iLqs/lw676tLHpCddOiybyeaf0ln5ukd5zcQORywB05XHYhFYfj7hNxdm3cTJAXnf4rkOF8laFSY0GK0r0CUsbcZ0OW3hTr7Xb3lg0o41pIAU2fYD8mjsK1ZNDrGsFlD4jX8mWlc4XhMzokh32yMCrWCi0+Tq1LPHl/Dz3ipDb99tei+dfGG7d7rV+GG3mEHSFwdPE+gxKXJD33TWAZyGCY5Az/Fl6j/+K7YPUBajvAwvfr3fTX0aVTOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(66574015)(38070700005)(76116006)(66946007)(83380400001)(71200400001)(2906002)(8676002)(8936002)(66476007)(66556008)(53546011)(66446008)(64756008)(33656002)(26005)(7696005)(9686003)(5660300002)(41300700001)(38100700002)(86362001)(52536014)(6506007)(55016003)(4326008)(84970400001)(110136005)(122000001)(186003)(316002)(478600001)(966005);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xPdk1qFTMZvq16CAZ08Np6B8ybl69qqrWdU+q99k/aDOAvwxL3eLvYdvhM?=
 =?iso-8859-1?Q?MCz5PRcLA+iEHxNA+X7vjAuIKL/sIAdIDQW678sdLUJYo2440P0RZsfJZV?=
 =?iso-8859-1?Q?HBc3lWigiepFIwloIhfgwK/rTwgnD3r3kOToba6fQFdFmklXCQvEkp+buP?=
 =?iso-8859-1?Q?Qd1R4GWijsS1VaK4+PRBWLYDOAvKj1m5AewkkdpLjGNI1Yd3hMzc90+9T9?=
 =?iso-8859-1?Q?aJqRZ29QUhC7oNUJmEuuXO/2oSif+nr57/sIsz0b+kNj/UxIbONhg/Fr+z?=
 =?iso-8859-1?Q?bzzeTy9PCqSHXX20kEl4dMyy6HH+FzhOzTIOUvr8B+potvyZXBgeJjzPlP?=
 =?iso-8859-1?Q?2PsLuDTE+s/LK46+FAG4Idhz7S90MEfeBohzrmsz9xwCOhxAcgx37ZlZW6?=
 =?iso-8859-1?Q?j/T+6KUpOMoCMwPuq8Ca/svhaW5hzx3ld9jqjmYD5spWwiTJQJHbvfZwjm?=
 =?iso-8859-1?Q?bs/OJTXM65j/V7U2A2BUXmDb2CQugkNHOrYlDyVvk8e58/9lsR48FPAvh+?=
 =?iso-8859-1?Q?2DY2m9t8EagiQV62DlCtjjBKPBadsvcmhf8lY1l+zgoGvMoLDoSxUFC709?=
 =?iso-8859-1?Q?HOiRkHB92bGuP0T9VaMiJ4cso1IQ52K60IOxFWp4cmo51S/fQ1oQkNq6wo?=
 =?iso-8859-1?Q?1Du4qkHbErf2UT8bVLi30Yx1BcfzDbz6lpSbymnrGcm3nIxgW54MBfKZKq?=
 =?iso-8859-1?Q?iYuWDdmcEnBzRRPws/AdRB36kaBCzFlRloApq4bEcfKFfwD6PHt8Z4cZpE?=
 =?iso-8859-1?Q?s+LxCdZ1vgMbcwmc6gSghNOWMzblAq9LYtkmo9WxU7KqkP/7VWEpg3c9Wy?=
 =?iso-8859-1?Q?yRB41uFZaAZNFIgTpyatCeoPTenXLP8Z49AAr/mIeQqDAGzyDVdp4fmsw5?=
 =?iso-8859-1?Q?8l7JCqzuTOcsbR/ZyfIy27su7rUvNrBhJ0ejQyDgjygyTJD5cGm3DKT2d1?=
 =?iso-8859-1?Q?dhEkCVLd3zUV0vCVvn5azxhZgTxhXcshoNM4WEQKcLMXzxxjnU9YS5HvQ4?=
 =?iso-8859-1?Q?AGvOxTlg+TKv6zu2ugPv7nnu+AtZwBkJcH8LzK/FSSdKW47MvGfKn/LTAS?=
 =?iso-8859-1?Q?kUgHSWdskQflZg1MWTROEzpXnbugbPkZ2P9oL7Uo2sHfH4VlyDlPMBU+Be?=
 =?iso-8859-1?Q?GwOrDlzAaGvixRI7XUaVRHy3F9NF4VwTustgpG/37RerWTdoFhKZW3I30j?=
 =?iso-8859-1?Q?hYLwI76pYbSCL1CGH4MHnCS/HZXQ73KpeT+GOjLmqugO0jFjck7XoOlYUc?=
 =?iso-8859-1?Q?/kDnZE5LL61dqUzjVAM7si0MGoMkNuzWyB1/FVWDJXjeymfIxFZq1SmCVZ?=
 =?iso-8859-1?Q?V9QUfeXUZgsdQG2qH4xxcygmB2L3hNI/GWKp/cW351dUUa+ME6Om8BSvPf?=
 =?iso-8859-1?Q?wp2tR2KLoYtx1AxMzwwBNBdCh0nbax1qy+zNquiKDULtifrg34DDufHjyS?=
 =?iso-8859-1?Q?IlUaLa7NYsT+VTW6CSfq+Aye7Omo7cBWOmGEEO1oz3kBwrEG5umb6CpU4+?=
 =?iso-8859-1?Q?VQVSji3ivgrghCFfoydBabd7Ihya8ZxrBrOadCkuRoRsRSl1q9a8961pk6?=
 =?iso-8859-1?Q?V2yQ7yWGkshdBrhr1LNMtV+IM30hkoq2xHq5qwlqSognYZ0FaJOiaSHXFJ?=
 =?iso-8859-1?Q?E2Smfr4vw9TeYSVHXGT5g5eCaJdYNFJzlG?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4636ea47-1f60-4d70-9454-08daae1bb6b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 19:38:47.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WijrPAwhFQpyIipnV7PUaikD7Pw5ZuuqQee1L7bhmHSXmvGm8c02RIVBBTy+und07o+HKj0/6iTPFLkQiyiPZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3293
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> Sent: Monday, October 10, 2022 6:04 AM
> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
> Cc: git@vger.kernel.org; Eric DeCosta <edecosta@mathworks.com>
> Subject: Re: [PATCH 08/12] fsmonitor: determine if filesystem is local or
> remote
>=20
>=20
> On Sun, Oct 09 2022, Eric DeCosta via GitGitGadget wrote:
>=20
> > From: Eric DeCosta <edecosta@mathworks.com>
> >
> > Compare the given path to the mounted filesystems. Find the mount that
> > is the longest prefix of the path (if any) and determine if that mount
> > is on a local or remote filesystem.
> >
> > Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> > ---
> > compat/fsmonitor/fsm-path-utils-linux.c | 163
> ++++++++++++++++++++++++
> > 1 file changed, 163 insertions(+)
> > create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c
> >
> > diff --git a/compat/fsmonitor/fsm-path-utils-linux.c
> > b/compat/fsmonitor/fsm-path-utils-linux.c
> > new file mode 100644
> > index 00000000000..369692a788f
> > --- /dev/null
> > +++ b/compat/fsmonitor/fsm-path-utils-linux.c
> > @@ -0,0 +1,163 @@
> > +#include "fsmonitor.h"
> > +#include "fsmonitor-path-utils.h"
> > +#include <errno.h>
> > +#include <mntent.h>
> > +#include <sys/mount.h>
> > +#include <sys/statvfs.h>
> > +
> > +/*
> > + * https://github.com/coreutils/gnulib/blob/master/lib/mountlist.c
> > +<https://protect-
> us.mimecast.com/s/wKJsC9rj7lc3WKmYUOq9E9?domain=3Dgith
> > +ub.com>
> > + */
> > +#ifndef ME_REMOTE
> > +/* A file system is "remote" if its Fs_name contains a ':'
> > + or if (it is of type (smbfs or cifs) and its Fs_name starts with
> > +'//')  or if it is of any other of the listed types  or Fs_name is
> > +equal to "-hosts" (used by autofs to mount remote fs).
> > + "VM" file systems like prl_fs or vboxsf are not considered remote
> > +here. */ # define ME_REMOTE(Fs_name, Fs_type) \  (strchr (Fs_name,
> > +':') !=3D NULL \
> > + || ((Fs_name)[0] =3D=3D '/' \
> > + && (Fs_name)[1] =3D=3D '/' \
> > + && (strcmp (Fs_type, "smbfs") =3D=3D 0 \
> > + || strcmp (Fs_type, "smb3") =3D=3D 0 \
> > + || strcmp (Fs_type, "cifs") =3D=3D 0)) \ strcmp (Fs_type, "acfs") =3D=
=3D 0 \
> > + || strcmp (Fs_type, "afs") =3D=3D 0 \ strcmp (Fs_type, "coda") =3D=3D=
 0 \
> > + || strcmp (Fs_type, "auristorfs") =3D=3D 0 \ strcmp (Fs_type, "fhgfs"=
)
> > + || =3D=3D 0 \ strcmp (Fs_type, "gpfs") =3D=3D 0 \ strcmp (Fs_type, "i=
brix")
> > + || =3D=3D 0 \ strcmp (Fs_type, "ocfs2") =3D=3D 0 \ strcmp (Fs_type, "=
vxfs")
> > + || =3D=3D 0 \ strcmp ("-hosts", Fs_name) =3D=3D 0)
> > +#endif
>=20
> So, this is just copy/pasted GPLv3 code into our GPLv2-only codebase?:
> https://github.com/coreutils/gnulib/blob/cd1fdabe8b66c102124b6a5b0c97d
> ded20246b46/lib/mountlist.c#L230-L247 <https://protect-
> us.mimecast.com/s/zxPbC0RMy1hoXW2rCOSXJD?domain=3Dgithub.com>
>=20
Yes. I was hoping for some guidance as to what to do with ME_REMOTE.

I also found it, verbatim,  here in midnight commander:
https://github.com/MidnightCommander/mc/blob/e48cd98ac13a9b4366bd88287f6324=
13766b967f/src/filemanager/mountlist.c#L258-L281

But that's just another GPLv3 code base.

> > +static struct mntent *find_mount(const char *path, const struct
> > +statvfs *fs) {  const char *const mounts =3D "/proc/mounts";  const
> > +char *rp =3D real_pathdup(path, 1);  struct mntent *ment =3D NULL;
> > +struct mntent *found =3D NULL;  struct statvfs mntfs;  FILE *fp;  int
> > +dlen, plen, flen =3D 0;
> > +
> > + fp =3D setmntent(mounts, "r");
> > + if (!fp) {
> > + error_errno(_("setmntent('%s') failed"), mounts); return NULL;
>=20
> This code would probably be nicer if you returned int, and passed a point=
er
> to a struct to populate as a paremeter. Then you could just "return error=
..."
> for this and the below cases.
>=20
> > + }
> > +
> > + plen =3D strlen(rp);
> > +
> > + /* read all the mount information and compare to path */ while
> > + ((ment =3D getmntent(fp)) !=3D NULL) { if (statvfs(ment->mnt_dir,
> > + &mntfs)) { switch (errno) { case EPERM:
> > + case ESRCH:
> > + case EACCES:
> > + continue;
> > + default:
> > + error_errno(_("statvfs('%s') failed"), ment->mnt_dir);
> > + endmntent(fp);is return NULL; } }
> > +
> > + /* is mount on the same filesystem and is a prefix of the path */ if
> > + ((fs->f_fsid =3D=3D mntfs.f_fsid) && !strncmp(ment->mnt_dir, rp,
> > + strlen(ment->mnt_dir))) { dlen =3D strlen(ment->mnt_dir); if (dlen >
> > + plen) continue;
> > + /*
> > + * root is always a potential match; otherwise look for
> > + * directory prefix
> > + */
> > + if ((dlen =3D=3D 1 && ment->mnt_dir[0] =3D=3D '/') || (dlen > flen &&
> > + (!rp[dlen] || rp[dlen] =3D=3D '/'))) { flen =3D dlen;
> > + /*
> > + * https://man7.org/linux/man-pages/man3/getmntent.3.html
> > + <https://protect-
> us.mimecast.com/s/aOmSCgJyVrT01WlYc76tSR?domain=3Dman
> > + 7.org>
> > + *
> > + * The pointer points to a static area of memory which is
> > + * overwritten by subsequent calls to getmntent().
> > + */
> > + if (!found)
> > + CALLOC_ARRAY(found, 1);
>=20
> It seems we never populate >1 of these, so don't you just want xmalloc().=
 Or
> actually...
>=20
> > + free(found->mnt_dir);
> > + free(found->mnt_type);
> > + free(found->mnt_fsname);
> > + found->mnt_dir =3D xmemdupz(ment->mnt_dir, strlen(ment->mnt_dir));
> > + found->mnt_type =3D xmemdupz(ment->mnt_type, strlen(ment-
> >mnt_type));
> > + found->mnt_fsname =3D xmemdupz(ment->mnt_fsname,
> > + found->strlen(ment->mnt_fsname));
>=20
> Don't mix mem*() and str*(). In this case we need the string to be '\0'
> delimited, so use xstrndup().
>=20
> And once we do that, we might wonder why we're explicitly finding the '\0=
',
> just to pass it to the xstrn*() function, when we can just do:
>=20
> found->mnt_dir =3D xstrdup(ment->mnt_dir);
> ...
>=20
> Which would AFAICT be equivalent to what you're doing here.
>=20
> > + }
> > + }
> > + }
> > + endmntent(fp);
> > +
> > + return found;
> > +}
> > +
> > +int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
> > +{  struct mntent *ment;
>=20
> ...make this (or above) a "struct mntent ment", then pass &ment down, so
> we can fill that struct? Dunno...
>=20
> > + struct statvfs fs;
> > +
> > + if (statvfs(path, &fs))
> > + return error_errno(_("statvfs('%s') failed"), path);
> > +
> > + ment =3D find_mount(path, &fs);
> > + if (!ment)
> > + return -1;
> > +
> > + trace_printf_key(&trace_fsmonitor,
> > + "statvfs('%s') [flags 0x%08lx] '%s' '%s'", path, fs.f_flag,
> > + ment->mnt_type, ment->mnt_fsname);
> > +
> > + if (ME_REMOTE(ment->mnt_fsname, ment->mnt_type)) fs_info-
> >is_remote
> > + =3D 1; else fs_info->is_remote =3D 0;
>=20
> Shorter:
>=20
> fs_info->is_remote =3D ME_REMOTE(ment->mnt_fsname, ment->mnt_type);

