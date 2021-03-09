Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E64DC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1292D65244
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhCIU7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:59:39 -0500
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:40939 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCIU72 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:59:28 -0500
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 15:59:28 EST
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 4Dw6rk5c2Mz8sfT
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twosigma.com;
        s=202008; t=1615323254;
        bh=D/U/RhYXy9irWBkP/8+lJ0Vu+uafSoI0rj3RNc2xtSc=;
        h=From:To:Subject:Date:From;
        b=Rsw4makD5LGjJMuZ2mdiYThoBLZF0Tg8pgV09+d6Ujv4hDRm91GhbAU9bsP4RtIku
         sMmeEn5g96iVcYZU4yO/eR3yC1XEpOyVeGHJOvo5VvfAHbzHI5XrCq2cnD7NXTipDt
         8K5vTu7wrFij1zsR+poZ9MGvMf7VorixYpetorLN11C4E8i5MNkYaPDCUJfUHcq7PK
         TQng8DtaTNwEFuzTKolH2sd0u6SS93CuNf2ZGgYKV4TGw7tIaFvYanbrsVRBaDjnea
         E1ZaDvImxj7KLNV13JPKW7NgG/vweg40LhM+qBARiHoH9oshgTLN0YFJbs/QUcSkXo
         BgO1BewTnzxTA==
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a_vz8szLHOKz for <git@vger.kernel.org>;
        Tue,  9 Mar 2021 20:54:14 +0000 (UTC)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 4Dw6rk4XXNz8sc2
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 20:54:14 +0000 (UTC)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 20:54:14 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1497.012; Tue, 9 Mar 2021 20:54:14 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: slow object packing during push
Thread-Topic: slow object packing during push
Thread-Index: AdcVJlVNhy4BoRPbT22BeCkXYnHixw==
Date:   Tue, 9 Mar 2021 20:54:14 +0000
Message-ID: <38b99459158a45b1bea09037f3dd092d@exmbdft7.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.185.79]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a large, funny repository that has very slow pushes unless I set pac=
k.usebitmaps=3Dfalse to false.

First, a description of the repo: it's about 175GB, and was created by comb=
ining about 40,000 smaller repositories.=A0 Historically, these repos were =
submodules of one meta repository[2].=A0 I have stitched together the submo=
dules, and this is the repository in which the stitching was done - that is=
, it contains all of the objects from the smaller repos, plus all of the ob=
jects from the meta repository, plus the newly-created trees & commits for =
the stitched repositories.=A0 As new commits come into the meta repository =
(which have gitlinks to new submodule commits), we fetch from the meta repo=
sitory (8s - it would be 2s if we were fetching into a normal clone without=
 all of the other stuff), and the submodules (up to 10s per and embarrassin=
gly parallel). Then we stitch (~0s), and push to the stitched "unity" repos=
itory (~2 minutes!!!).=A0 The entire repo fits in RAM (yes, all 175G) and i=
s in fact in the disk cache (I prewarmed the cache before testing anything)=
.=A0=20

The vast majority of the time appears to be spent in git pack-objects, and =
in particular in the stack trace in [1].=A0 If I set pack.usebitmaps=3Dfals=
e, the push only takes 10s. =A0=A0This seems like pack bitmaps are a severe=
 pessimization for my purposes.=A0 This is true even immediately after a re=
pack (that is, almost all of the objects are in one giant pack, except the =
newly-fetched ones).=A0 I also tried setting up pack islands - one for each=
 smaller repo, one for the stitched commits, and one for commits from the m=
eta repo.=A0 I'm not sure if this is necessary, but it's definitely not suf=
ficient (my current config has it turned on, because I didn't feel like rep=
acking again after testing it, and I tested it before testing pack.usebimap=
s).=20


[1]
#9=A0 0x000055d849183bfe in traverse_trees_and_blobs (ctx=3Dctx@entry=3D0x7=
fff2de42a80,=20
=A0=A0=A0=A0base=3Dbase@entry=3D0x7fff2de42a30) at list-objects.c:344
#10 0x000055d849183d2b in do_traverse (ctx=3Dctx@entry=3D0x7fff2de42a80) at=
 list-objects.c:388
#11 0x000055d84918408f in traverse_commit_list_filtered (
=A0=A0=A0 filter_options=3Dfilter_options@entry=3D0x55d849544e80 <filter_op=
tions>,=20
=A0=A0=A0=A0revs=3Drevs@entry=3D0x7fff2de43f00, show_commit=3Dshow_commit@e=
ntry=3D0x55d8491a7830 <show_commit>,=20
=A0=A0=A0=A0show_object=3Dshow_object@entry=3D0x55d8491ac920 <show_object>,=
=20
=A0=A0=A0=A0show_data=3Dshow_data@entry=3D0x7fff2de42b50, omitted=3Domitted=
@entry=3D0x0) at list-objects.c:421
#12 0x000055d8491a8c1a in find_objects (bitmap_git=3Dbitmap_git@entry=3D0x5=
5d84a41cd40,=20
=A0=A0=A0=A0revs=3Drevs@entry=3D0x7fff2de43f00, roots=3D0x0, seen=3Dseen@en=
try=3D0x0,=20
=A0=A0=A0=A0filter=3Dfilter@entry=3D0x55d849544e80 <filter_options>) at pac=
k-bitmap.c:603
#13 0x000055d8491af68d in prepare_bitmap_walk (revs=3Drevs@entry=3D0x7fff2d=
e43f00,=20
=A0=A0=A0=A0filter=3Dfilter@entry=3D0x55d849544e80 <filter_options>) at pac=
k-bitmap.c:1004
#14 0x000055d8490b1983 in get_object_list_from_bitmap (revs=3D0x7fff2de43f0=
0)
=A0=A0=A0 at builtin/pack-objects.c:3294
#15 get_object_list (av=3D<optimized out>, ac=3D<optimized out>) at builtin=
/pack-objects.c:3373
#16 cmd_pack_objects (argc=3D<optimized out>, argv=3D<optimized out>, prefi=
x=3D<optimized out>)
=A0=A0=A0 at builtin/pack-objects.c:3739
#17 0x000055d84903ed19 in run_builtin (argv=3D<optimized out>, argc=3D<opti=
mized out>,=20
=A0=A0=A0=A0p=3D<optimized out>) at git.c:450
#18 handle_builtin (argc=3D7, argv=3D0x7fff2de45320) at git.c:700
#19 0x000055d84903fd96 in run_argv (argv=3D0x7fff2de450a0, argcp=3D0x7fff2d=
e450ac) at git.c:767
#20 cmd_main (argc=3D<optimized out>, argv=3D<optimized out>) at git.c:898
#21 0x000055d84903e8ef in main (argc=3D8, argv=3D0x7fff2de45318) at common-=
main.c:52

[2] https://github.com/twosigma/git-meta

