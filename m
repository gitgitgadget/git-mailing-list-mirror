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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D1AC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37F821741
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YJL+DP3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBDVWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:22:43 -0500
Received: from mout.web.de ([212.227.15.3]:58699 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgBDVWn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580851356;
        bh=8JT4afp27C8mO92OF1egi7JO9F/1B7WdWcm0SouGrDY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=YJL+DP3s0STU8l4bsTEP4g9l8VQ7h4EwwIqQT0c56SMyTwoQ4wAPJWTEXsWNiElyP
         027NiDMOP1uqxfAHVbPOmVzhcTLo4Kn4ZNtRDOlVntZAfRen5tHBM/iz76GcLzn3bX
         jlFe5517PeSLlMV1UkYxjzuVHr5aQoyxNVEoqf2M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhNmy-1jKvwi2o88-00mceF; Tue, 04
 Feb 2020 22:22:36 +0100
Subject: [PATCH 06/10] name-rev: put struct rev_name into commit slab
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <c3e5751b-677e-98e6-2943-44289213e57c@web.de>
Date:   Tue, 4 Feb 2020 22:22:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5XxnMg4aEM/YN4BsbRLohtQtfc49hEKAaqEqiWAyGla0NHYypca
 mPp4MOxEdEttcIojRVUHLGGrsaWhgTkq3G2W/4upMxDLZe9jZqkZaFnp1DN+6VWJH9kKj05
 SlZ1+MqEFb7wg1pzeA2ttIdUo4IenQuffYD613wNb8b1t5g1lUyJSf0gADg204kOoEgHV7H
 JCOaESDZo+0Utq131KjMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SQmLENH48TA=:7ZRmjO4wvHBRLLlnCC/XcM
 bkXsdgd7tzi12rPyj2lvPZ1Mx/x5SZ5/EOYRmFR6nYelCTNejtbkVwLYV/wU92L+dN8f2pddL
 NXyXP1El08Np5+L0DHz57MkE++1uLSgfb8ILRdZZAFRNGUShlHTzWSTmabypEdCNmxXxzaHjh
 3FOB+/pXa2judeY56F/EV8Ic8LzTQdYp4G+FSffxfy5GJXWC1ozEh/xK5Q1JgoCMYNH6OJg0p
 mgcP56tuD8Hk0Z62adak791jH74gOharS5KVhb0eFGhXsRMvIlJ7A2h1d7u1ogj6gCXeu8uj0
 Qi6RWJIU3aBli8yeYEQ1w2XSj0PhmE6TEuiTCyl5aJqdu2J6qGI3hQHUGvIgb3tGm9sdzvjj7
 aQpWj2kCMYdAFAqDSbtfc2FYD/btBfB3ok4DLD6/dVg8l+z3zywbyiq95rvb1NE4d8lMK3LU2
 ItgBPmYmyVFBpgzWJSfR1RCj+wcJVrwJZWAdqmNXashe9NASMc5FQeVka0PHyDn8jgOzGAlQT
 4/tJPQtNr1orUHumYMgoavh8/2Lc3ZO9kwKd3fOzLtTd8nmFP5/+rqdv2KWO9frFz6S7XMCB2
 AqnE1eAz6WA/fbCcYNr5dBwJLBT+Lw87HLsFYa13tV4JmayRjfO9xKwZeQ+CMBJ06Eh3LjwZj
 b9b+5PD1X5npG1uOI7W2YIDLlUkl2YQr34+bL5lZ07Xuh9raZVG2otAkxqOCENEEK/WQJPlKI
 awcqje7QgWDzGKOUZBjnkqPug7tZdgW/KcrtCrMkSD5AcarjsD0wtIEyKE0lnc+/8zuV/O87F
 GDDSxQVMj6pXo2SaV6V4bChVouLoL4ZjfznQQgWvxBtGxrpZ3WLaDNHhXI+q59xvvmKXcFmDk
 IhZC4Zf0D4dBO08UrO2PVyXeWGoaEDbqwbv0C6Wdpy66TFHx5rtcWEgZI8YbFJE17OqQeMTFc
 4uk9C/nlXEbbYe3/VIeLuOYRztmKfNixCLO6b8PE55zu0RuM4LWvOlzoGC7J60gNmNi7AXFhy
 da+DOEvfNKwIq9dbX68x/pdze2oWbhiC9uCJKvZ+/ru1MlFlAOoVegPewbUwm4TRbxbyLQDYh
 I/weKPge0JEHjZktkYLDhkV0fBFg7ADO99D9w0B/d0DSfbQ6ff2wHf51XFuNK3AxeihrumV7D
 KAGv2TuyqZ+1jaAML89WmNaj7YhXdlLp227nnjACbT+7Hi0Nv2b/TU2ws0n3iph01C12/0vC/
 783qwgWNSXCwaDESA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit slab commit_rev_name contains a pointer to a struct rev_name,
and the actual struct is allocated separatly.  Avoid that allocation and
pointer indirection by storing the full struct in the commit slab.  Use
the tip_name member pointer to determine if the returned struct is
initialized.

Performance in the Linux repository measured with hyperfine before:

Benchmark #1: ./git -C ../linux/ name-rev --all
  Time (mean =C2=B1 =CF=83):     953.5 ms =C2=B1   6.3 ms    [User: 901.2 =
ms, System: 52.1 ms]
  Range (min =E2=80=A6 max):   945.2 ms =E2=80=A6 968.5 ms    10 runs

... and with this patch:

Benchmark #1: ./git -C ../linux/ name-rev --all
  Time (mean =C2=B1 =CF=83):     851.0 ms =C2=B1   3.1 ms    [User: 807.4 =
ms, System: 43.6 ms]
  Range (min =E2=80=A6 max):   846.7 ms =E2=80=A6 857.0 ms    10 runs

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 41aed436ca..14381a3c64 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -24,7 +24,7 @@ struct rev_name {
 	int from_tag;
 };

-define_commit_slab(commit_rev_name, struct rev_name *);
+define_commit_slab(commit_rev_name, struct rev_name);

 static timestamp_t cutoff =3D TIME_MAX;
 static struct commit_rev_name rev_names;
@@ -32,11 +32,16 @@ static struct commit_rev_name rev_names;
 /* How many generations are maximally preferred over _one_ merge traversa=
l? */
 #define MERGE_TRAVERSAL_WEIGHT 65535

+static int is_valid_rev_name(const struct rev_name *name)
+{
+	return name && name->tip_name;
+}
+
 static struct rev_name *get_commit_rev_name(const struct commit *commit)
 {
-	struct rev_name **slot =3D commit_rev_name_peek(&rev_names, commit);
+	struct rev_name *name =3D commit_rev_name_peek(&rev_names, commit);

-	return slot ? *slot : NULL;
+	return is_valid_rev_name(name) ? name : NULL;
 }

 static int is_better_name(struct rev_name *name,
@@ -81,15 +86,12 @@ static struct rev_name *create_or_update_name(struct c=
ommit *commit,
 					      int generation, int distance,
 					      int from_tag)
 {
-	struct rev_name **slot =3D commit_rev_name_at(&rev_names, commit);
-	struct rev_name *name =3D *slot;
+	struct rev_name *name =3D commit_rev_name_at(&rev_names, commit);

-	if (name && !is_better_name(name, taggerdate, distance, from_tag))
+	if (is_valid_rev_name(name) &&
+	    !is_better_name(name, taggerdate, distance, from_tag))
 		return NULL;

-	if (!name)
-		name =3D *slot =3D xmalloc(sizeof(*name));
-
 	name->tip_name =3D tip_name;
 	name->taggerdate =3D taggerdate;
 	name->generation =3D generation;
=2D-
2.25.0
