Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6456C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CC021744
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="J/i3Jiu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgBDVRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:17:08 -0500
Received: from mout.web.de ([212.227.15.4]:50387 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgBDVRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580851022;
        bh=xCa/Kt7YUUS3xzi6O3tgpqwkGEMIuv4RXsD0SZrMh58=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=J/i3Jiu+cRzgOv99zzfJwaIzJXJTTS4mZOD/CrEb+zcb4dBWaupny2lVA18GVKTdT
         d7uwJcv1ZqsUe9T8WGJYWnAZK1Vwx25FnZa+ipay3O7FAEPqJNueO2gya9IzaktJ/O
         7bGVF3/FVzYkf13wgqyt0Xe9h2ALGjtc0HhUaZSY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfAfQ-1jIl8g1mfI-00ooJi; Tue, 04
 Feb 2020 22:17:02 +0100
Subject: [PATCH 04/10] name-rev: don't leak path copy in name_ref()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <32a0a2d6-3237-24e9-c647-6624cc2a1e89@web.de>
Date:   Tue, 4 Feb 2020 22:17:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/HMtlztfJqEhAHMiTORttagDJQPZp+u0Mp3oribW9NPuEK1L/hn
 Vsahs9OmYZZYRrXi+FFl1tXGZFMGd/vI6OQ/DLsUyZrH/HrrL7R9QLn9b8NHb5MJ5IVlqcr
 LPfozn9WA0ZBpDBy88u1r8dO/jaaHp+tn1vZMSgYYf2EsrGaPGAmyjK1OAuboSeogkuQoY0
 idZXusDDqX+0Xp7pttQnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3R95lme07b8=:qdjqXsLD8veaagp2X9+QHr
 0+EZ7GeG9+TXS9/QX4vTj0TZTurwr+djDc22DtMlMPpiMePxxOOnM5WffjWnL4WDWQRDCgCqG
 me3JWkN/uUxH7vweXxOzAg8Pu0vayzT0+w+3aLNM3xwWMd2NQh238NmrXzSeJbV3R1Vb/aQM9
 XfJw4blncMN0x92txFh800Bpzt6t13yUO8FZ14JxJFm9GF0EcsDqcsk4hHlXf9nBG6NgWZju3
 VG6GelbIj3EgCFxV/t2v7Hy50EEUTHHhyxWXxYW8z+3+S5ogsx1xOYNchV/uRydr+YEXYWyfs
 wpn3qw/LOnf3xzG/JxjJkptOv4AMil1A0phNhf7UioirlpXiAIJAsZXv66ohhgd1+eNclWPJC
 i+x6KublKcHjUul/UaNea1/gUI/KerNSl1YrkM9a4cMAOnlQYawDtTj+pOuXQ7n7cABPx+k8i
 xXnxXrHkBTBOc6dgnxgC596OANPKnShBLqcuauEk014VYiIxRcZdNk4VACd46VEBLgdyI0Z0f
 nHRbD6iWSe+OtMQdbOzemOFtSkqGP/4o6ZgvSnRy0dnY7mIHqzWQW9fxAKoeW6U+zj9qjI3wY
 VfLnDkJgbY/S7uB/wuLYJvYVSeWw2Xy+AVr2NcO63UPHdWbD0N996/dMmi84iuZdMckoVJVEn
 ULKIokU9Gv2OMHcGIOl8Iy4NWAdH071vvprWhnrVWd3cSkm/hCYCDZHgwTOpGYMH8FonVY/rR
 AnGASL5a0QufoZBSShpNqz20BbptNbxfVTPCGMrqAlIZsj+zeOIgSsmkrRE0cpzQQkHp84dLz
 WNCPTxGp2wEIEzrebP5lWoa3McQKiVrfrnQBBzNt34UJnA/t4JTtb11lN2QL82nLwriyTSt5E
 xJ66SZOqv4eW3Br30VEku3+c7v5FF/tZjM4pwQ+ztLqkLu0rRrE1wg41VnrV8rynK1AxgOjs/
 KSlKWYiv+9ZMwa+sMDOsfAd2BZZ5EtIdzdUfgpZAsjHLKzC/uPZwMghXwKVijeI+TWk/hj8pZ
 0Ug9VkRpoQFPFgHFcdU4FxMNjQfBNTYUNtJByxlWKs2nEadT6r3OnG+3aT/5hN0qOHH09c7SV
 qLZjDWCVLD5o5A/rxV2csWIM9NVIEZS8haTZWx7EQG4M3Vssza96wKsUzbZQ0kRSFcbA4tJr4
 yCbZ5Hq34ElEH8hynczoYZ+MboiGjUF/iFWaXUAOAajvvA+2GqhPX/kKB/BKIApbNatzk1aDn
 bxoByJfM2Ghj3NLR2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

name_ref() duplicates the path string and passes it to name_rev(), which
either puts it into a commit slab or ignores it if there is already a
better name, leaking it.  Move the duplication to name_rev() and release
the copy in the latter case.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 2e6820bd5b..3e22a0503e 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -121,6 +121,8 @@ static void name_rev(struct commit *start_commit,

 	if (deref)
 		tip_name =3D to_free =3D xstrfmt("%s^0", tip_name);
+	else
+		tip_name =3D to_free =3D xstrdup(tip_name);

 	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
 				   from_tag)) {
@@ -323,7 +325,7 @@ static int name_ref(const char *path, const struct obj=
ect_id *oid, int flags, vo
 		if (taggerdate =3D=3D TIME_MAX)
 			taggerdate =3D commit->date;
 		path =3D name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), taggerdate, from_tag, deref);
+		name_rev(commit, path, taggerdate, from_tag, deref);
 	}
 	return 0;
 }
=2D-
2.25.0
