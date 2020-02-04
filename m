Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B7BC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337212082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="lbUtdlFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBDVUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:20:48 -0500
Received: from mout.web.de ([212.227.15.4]:57587 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgBDVUs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580851243;
        bh=Ugs9xT4jmJSyATxd70N7c0TlN6kCg3oJOj9irJvZLPA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=lbUtdlFNgyRqkKNnRyozYrs88PfhYOIdlpv/yLWEzPSw7GhEuUtHOhv/TRgAdqvBM
         3B2oPemn+VLtoqhARfU9XVR7xoqyX/ieDIiKKGNaaEZxMVENLg6rerFlh3kVGMzZPV
         cPzZVtA0tUYddbbI6dSNR5h9YRo5Fb6D85X9LILI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhvUI-1jLUCn2OQM-00nCSP; Tue, 04
 Feb 2020 22:20:43 +0100
Subject: [PATCH 05/10] name-rev: don't _peek() in create_or_update_name()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <ef102af8-7369-212e-f782-2c1e75c7b946@web.de>
Date:   Tue, 4 Feb 2020 22:20:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O5ID67PRVuvNsPCY5GY+b3PWZ1uSVppRvyP4TGDEZA7IEgoDptS
 bMlR6HsQxpOb1f3a1DiyHbGepFhyW20qldolNtH1cMOqrkDNQNcB5TQ1XudqhiNI+FBKsMA
 6oCmVDheiCjflnIAWwtsau1X4NbM4WUbwzCt4qShXY1ARBUIkPHH3Am4Ey2uu3+rJ6ep55F
 A1+LWy62u5ZYdCIlBd/QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v9SsAehv8OM=:G6TBts6XSDHG0vRiRSG/fX
 pb0eK1jMmPxuDAuxVghTWciJMM9RAIzmAydKhKjOGaFMUIACcCI+thLaJ/inEDbeOWv968KJf
 epIwvjiGeESygG1Qzpk/reLW+h2LZF5+shqO4J26b8FKoKny+zOGa+mQfFxW6PoDJwwX5B2MY
 Qy/oYohPsmMO5wSk1ajOrdBQ6wqJUiT+hWL67zFkq2PWPflY0i8IuhmxFQ2cEkyypdZADyNn1
 79s2NkXYCI7kRM+STMGEPfuZs6lokeGfIG4iQ5ielPq1luvYIyL0x+iq3/KQWRtqJSe/hFSLf
 0K+GSYLahvTd6wM5juonhXrWCBA6ojPzgB3f/nYega5CHovtKRcvhXu/9Zil7ksEmFJeJl1z7
 QX5LD25zrsOw2DtEBXtiZ0KTi7NncT8HamhGKarfhcly2iLeSXFYRLUYB4jLhdYxyvYxunQEo
 4+bPHvp1qu6qkEQq6VuRp6cEIPeVq1W7XyxXmf4d4+A5qabdQjfZnTZYl7v/921XMK0l82UyG
 s+Dpw0IIbgIjwPoWRphs1LOuC3mo+OMfG9k+eZJ75+pR5FTsKEstrbEBo+54ZuF9CH0R6PH9O
 OYNg2Rzqc0MR6S9kc3gso8cl2j3XkP5WEcljHa7djb5XfAL8cMvabGu7VEYmIVUcUDew5CnPo
 DA9zn2AwEoEtWYwwrw6I2upibQ/mvHfzVR+y1xwAfxjnEIxALTkRw4uAzgC8TBJ9FKEt33Lli
 gRrdz+CT9FP1HEbHUaByo5pyJS/0uwgNahsKxZ7W8EmS/zp3i3QVYuBa92Bn8vMUmz1fOHf10
 yhdaZahnnGRsQPkPaIC0dFJdJyhCkpBziy/ZTa33pVh5w2Sj0Hp1y5YOQtbgb6vDai/AH42eN
 D9cAtl29ueWlnL7Z8y/bHKOmVJVL8j+cZOoZafjcN6jHcArqrJp9FFCpJhsBgw2N83hC54pMg
 YTmWLhHnUxw/zceCWjKM2jJQVKFMPmBEyO97CWniRFy0VpbShDCwcV7mbD5pamXpEkq2IBrAs
 SXTj82OaktSNmCRdGYuCsxseAof3Xi0HXk20hiRgCR/cHOKWI4t1zuFlqo8DEfPBcDsugNy5I
 o/+S+2I4WaJ/wm16f85NRm8NhTK7JJy0Z23eZMGLxCfhdHovc4CQ3OqCGEuTb0cCiLQujtqr+
 AadYkA3j8vApd+mjBpjrSA9xQP2yYIUtDQU9UbEzAjmqGcGqnjzcVqHuh/4Luv9OFZJL4En4B
 wJbPxn4iyFyieY2fW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Look up the commit slab slot for the commit once using
commit_rev_name_at() and populate it in case it is empty, instead of
checking for emptiness in a separate step using commit_rev_name_peek()
via get_commit_rev_name().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 3e22a0503e..41aed436ca 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -39,11 +39,6 @@ static struct rev_name *get_commit_rev_name(const struc=
t commit *commit)
 	return slot ? *slot : NULL;
 }

-static void set_commit_rev_name(struct commit *commit, struct rev_name *n=
ame)
-{
-	*commit_rev_name_at(&rev_names, commit) =3D name;
-}
-
 static int is_better_name(struct rev_name *name,
 			  timestamp_t taggerdate,
 			  int distance,
@@ -86,15 +81,14 @@ static struct rev_name *create_or_update_name(struct c=
ommit *commit,
 					      int generation, int distance,
 					      int from_tag)
 {
-	struct rev_name *name =3D get_commit_rev_name(commit);
+	struct rev_name **slot =3D commit_rev_name_at(&rev_names, commit);
+	struct rev_name *name =3D *slot;

 	if (name && !is_better_name(name, taggerdate, distance, from_tag))
 		return NULL;

-	if (name =3D=3D NULL) {
-		name =3D xmalloc(sizeof(*name));
-		set_commit_rev_name(commit, name);
-	}
+	if (!name)
+		name =3D *slot =3D xmalloc(sizeof(*name));

 	name->tip_name =3D tip_name;
 	name->taggerdate =3D taggerdate;
=2D-
2.25.0
