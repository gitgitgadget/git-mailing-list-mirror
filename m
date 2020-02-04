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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB54C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7725621741
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="i6faVX2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBDVOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:14:36 -0500
Received: from mout.web.de ([212.227.15.14]:51211 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgBDVOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580850872;
        bh=kpVDWAoHKHnAbsjWOFGCtP1EjH264+p+9rzGg/9a8bE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=i6faVX2U92R68zM9zvLTwAze+ZVoN2rXplRFvFdzBIDXo3mFeTtaPytAMgDrHudiI
         /5tUZWyfZWp03lfEd2AADVyUZWBV7nxu3Trfn8TQvQ7kACnHrM+My5xfAuxaUR86tP
         REvYdg12h8MWmXzWizMJGn6aKmZKYoyNPuuVews4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lzrwh-1jclnn0dUJ-0154sg; Tue, 04
 Feb 2020 22:14:32 +0100
Subject: [PATCH 01/10] name-rev: rewrite create_or_update_name()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <b8f6a47e-1cbe-b2c7-cdde-ff2dc28af2b2@web.de>
Date:   Tue, 4 Feb 2020 22:14:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bXRKHDZ27tjf1WWzhNq7SnLX+qbk8SK33wAp8ffQB5JFN8Vlz81
 s6TZZQCaQxFRB+kqViej1cyKJAYHY9pKE94OOwAThozE68m6e2/Hi01Ae6cTmjc7vdWAikE
 w/R2yZ0akR5OPdRvBIoK4Jqv110z4DqEqd36OgxA3by3T/oa6zsLBKQW7S1G9zOB4E8LQ2o
 CMilDBamezOMFaYYXcPzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qu8Bk1NCpgE=:45dAbP6DmbvLUXwbj1ITeq
 ly3SG9JmQf5UgdaaPPAeuTZOtrMrTP0efRxaC6r//s/B0KQJ7wBQ5wGLOh31V6K6WTsc9MIVq
 OoHuEhU0QRwp5iqKAG9GHlZpwKr9hKbreORYo/f/mn6upO07RZPrwb2ZqGnaIba9HmzyV7Ew/
 9CR3Ew827tDGp8wKCxusA6sr5MtGtvrKra9cbRaDn8Auz+PCBYAz0GN7Z7Sb8roWDRUOHz4xH
 CtcWKA247alCPW98f/H/3Tio72VkXHKXBxfkIIk9mWfBQW4rGfcap4LatQS9OVoBOgP+fkvyv
 NTUKe8lLb1kFFjRtQNh497+P25UIld8BccvKvd7Y+2scbQ4HZq8CCt1eD9L7YccpN/B2/hea8
 WF/2Ipfmh7raSg1gWOklrhd/KwsVHW8z2o8BMBb2PqrwyiMtWzqfyuMM0xrYAMQ/TaLjDp66O
 SEr9uKRbtHXiZJeD4mYrS0ZLLisaVlK05VgC2VooBLXwlU6QWoGvcWyC49fvMRdziVTIownsN
 rJ2TzbCdDz2MHpCMhr0S/xHUtI+wbZQSlaj+M8pyvVJIPQQb3YV4MXfSdObSxApvTEre4iA/t
 DPpyEfEXlBcyxQR1ytzX7MY3ROzhr2Vcksn+ayJtJ6NjfYdkhHOYSChFnWgN0LwJwGQSoiGpx
 6MPmVEjQDXrtetpBAauKlhSiv3roXc0LI/fWesuZBYfJxyWuBqUYS4Fv4tsl+5IlwkfQue8OP
 vPGTLn39ZuOw7U4INbRTnE8RSBgE/RWwimTR1nXs0LBu2qQfGV1lbYBE2e544SKhR+FUyjfqk
 VHndWLQAy+hVUpXlhT6/HB3BRXevso/fDuyk20tGB2McZS/r+LDh7J0cVZRTt9D3DnObG08pL
 1nkvZviJUJEX8FfT25+LciGcCUAA/NsLtIamY7xVQ2fkkgkgonLin2uYpBxKLmACQbbSSPDW3
 2Vnjpxhk+mmSFzItuZ6AJ3/yy0X3lbbAx/R+LbbguiAtkrRLK/p5xuUZymarIkAdyhR01GcAV
 pyd56lCdGKxqAhmKEypaeMPEPuas43isQPEWJ8+88mSEVWQMvslHpSOBl36FlxkZ9zsmAgJAX
 aC1eVPvcoeJ6zW9N6ED034hr4zEArhsqb6+uHLypQTEqutMJSIgxkhgbWWsx6OVTppibRem+6
 hHmcAYR/fJs/PDCW/ennNKoqVIfHRNp3yeyaGKWs6hbqN7VzAWuDF894GzqnbPJ31QTWveN0s
 Z9Gr98udFtWRt1bQ/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code was moved straight out of name_rev(). As such, we inherited
the "goto" to jump from an if into an else-if. We also inherited the
fact that "nothing to do -- return NULL" is handled last.

Rewrite the function to first handle the "nothing to do" case. Then we
can handle the conditional allocation early before going on to populate
the struct. No need for goto-ing.

Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
=2D--
Original submission:
https://lore.kernel.org/git/20190922081846.14452-1-martin.agren@gmail.com/

 builtin/name-rev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6b9e8c850b..c2239ac3f7 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -88,21 +88,21 @@ static struct rev_name *create_or_update_name(struct c=
ommit *commit,
 {
 	struct rev_name *name =3D get_commit_rev_name(commit);

+	if (name && !is_better_name(name, taggerdate, distance, from_tag))
+		return NULL;
+
 	if (name =3D=3D NULL) {
 		name =3D xmalloc(sizeof(*name));
 		set_commit_rev_name(commit, name);
-		goto copy_data;
-	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-copy_data:
-		name->tip_name =3D tip_name;
-		name->taggerdate =3D taggerdate;
-		name->generation =3D generation;
-		name->distance =3D distance;
-		name->from_tag =3D from_tag;
-
-		return name;
-	} else
-		return NULL;
+	}
+
+	name->tip_name =3D tip_name;
+	name->taggerdate =3D taggerdate;
+	name->generation =3D generation;
+	name->distance =3D distance;
+	name->from_tag =3D from_tag;
+
+	return name;
 }

 static void name_rev(struct commit *start_commit,
=2D-
2.25.0
