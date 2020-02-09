Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3ADC35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CA320715
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="R5Y4ZAxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBIP4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 10:56:52 -0500
Received: from mout.web.de ([212.227.15.3]:58849 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbgBIP4v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 10:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581263807;
        bh=PLLREJ2uoKTHEwtgE+SGhGnVKQ3uxEHF5V+j7XsngAA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=R5Y4ZAxnOTojNnpxb8zCjJL4E9vuGgitRQYmJFdHDxmlobSWt/m+0TGvHtrRE4yQO
         oUyPQ1i4mDV1VFl7DQ3NENawFSeGVKIgbodtJLjjumu7r5GSXCpS7JlgjZxKAYMWoX
         +ch1s0ez2KtVQdYf3kEs5AaTqFIo8GFp9ukJBi7E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lym5H-1jXjWi2ht9-0165AA; Sun, 09
 Feb 2020 16:56:47 +0100
Subject: [PATCH 2/4] parse-options: factor out parse_options_count()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
References: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Message-ID: <c729aaab-68d7-9cfa-8981-97eaa72a5ebe@web.de>
Date:   Sun, 9 Feb 2020 16:56:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ALM7h8dcNjb2MHX3usUewJq8/mzlrIflr3+qUfv/kzCf3lSuJXs
 h4Zh0GGSDdCVnlya3t/ZpxhRHn5b/rEcidKeJF7306xCvfeqVunbafr9Vr1KsNGtFdKMwzT
 QlVKLNxuROMM4eGvOpZrnnqWUNCw28O7oudfvdq5UXO2YNX0gtVQxyAzUezTNDr047YW9Fg
 xf3D8DMgPPU9UVQkiTVgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zvJW+pvcOzo=:Gim44S/rk4EZRMnfdVZ1Bw
 eJn/3cgDFTFIgC2lDPvMYAC6dwnoGJSJVb+GQU+P48CT3n37yVjvoQV/ZioBdYVcm832Klug+
 rRVRM6qvk4t8KMmGr0g6wGH7VBTqE6KXRPz46/jfoSZGdjgGysPzklhOvXdynaaNxBf1fsXo3
 NVGDyurPVH+bC8t8IWeq9+fWEEb0C0RVwBQSnbG8T2D6fCvji0daZ4RT4dUr5D84LkxUufKJk
 bUt4MfprJqmCThrIRddkXg4tTJdMIDDTHvOK60n6mPtwXWg9R4sQyeNQ6Sp0zAOhMz31zUcTz
 55QND7x/+/i+mYlxk5YXKO+UMiACC1w66I0qqDiuIonJE8GZ1i0OVNC4jkFJD2ttfVl4cgdlB
 22Nj+Wj0sNUFsghlIjKZKpdW1AH/ugvIngczzIC8nT0RN8ySzhcjEDtJcO+t+rHADZRMLLVY2
 c7nEn/l+MmDfivSUSNMNBbUEypBwj9aXAGPmoff5zJXjC9YqkL2TlUYMVA/kvPjGb++LYspmI
 dXjk/y113xJP2u8GA1pHMcZyD7sgpXBpcSNBrDMC+ydxcG7XX+nfuRRIAEXSTyzd1nb/yGt4E
 jTGAJ/7TUd47NHWAD8/jHQqTbzNEO0bpBASm6RzNgdwHKgH8wWUQoqfl8rm1tsEAAmEQDfN71
 DY0f/j3o3eRiRsbNs/1efZu0sa/3/lMpQSKFvMpM2NoZKdi1l/KOljD9HXxxb+F7VDAJZ8J/j
 WswKF4XuBrgFjAtK6lpXTtWZfc9HVEkIRwI2t9nh8UiqC1mrxx8NSPtHwbUpnVgvX2Dc4ZGs/
 PQN2HF+cjBpm44Le28p772igLLnTeyoDE5oU9Nnkdhsp9LqwzwqBzyC0Z+niy16NPOoUiqQxn
 Vv1sYcoPH5gAEtJs9E3hWbBTemfjlmYZycVewyduwIIpl+wjJRFo81227Q4IzpOj9J2lo4uIX
 dR5q96yMR11TcFxQkx+XHt43ZfdxrPj9tNbOQW1YtUIUy4xh/YE5xZyYI4t1BBZfBdi0AoRTW
 x8PiBMX+euUE+lEjykUDJcWuAArpO7m126znPSoG86Vjj5ji341sEzq7Get+/H2mlhc4NthFY
 7wSWHQtW1pMQiXpEwIyAlHrrzP4rSbpD4W9dMQJpbZXW5lx615Uu0ODYRgey9UAPnqhH9TNhV
 aamxcMhnVi3YZr8dwrpSA5733ZqL5OmebQ21S3DfOqIko6cyitx36Eh7wueYhsujavx0xm2z/
 4XYG4Gx5M36J2RTmr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a helper function to count the number of options (excluding the
final OPT_END()) and use it to simplify parse_options_dup() and
parse_options_concat().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options-cb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 012e048856..db6f666ef7 100644
=2D-- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -159,16 +159,20 @@ int parse_opt_tertiary(const struct option *opt, con=
st char *arg, int unset)
 	return 0;
 }

+static size_t parse_options_count(const struct option *opt)
+{
+	size_t n =3D 0;
+
+	for (; opt && opt->type !=3D OPTION_END; opt++)
+		n++;
+	return n;
+}
+
 struct option *parse_options_dup(const struct option *o)
 {
 	const struct option *orig =3D o;
 	struct option *opts;
-	int nr =3D 0;
-
-	while (o && o->type !=3D OPTION_END) {
-		nr++;
-		o++;
-	}
+	size_t nr =3D parse_options_count(o);

 	ALLOC_ARRAY(opts, nr + 1);
 	COPY_ARRAY(opts, orig, nr);
@@ -180,12 +184,8 @@ struct option *parse_options_dup(const struct option =
*o)
 struct option *parse_options_concat(struct option *a, struct option *b)
 {
 	struct option *ret;
-	size_t i, a_len =3D 0, b_len =3D 0;
-
-	for (i =3D 0; a[i].type !=3D OPTION_END; i++)
-		a_len++;
-	for (i =3D 0; b[i].type !=3D OPTION_END; i++)
-		b_len++;
+	size_t a_len =3D parse_options_count(a);
+	size_t b_len =3D parse_options_count(b);

 	ALLOC_ARRAY(ret, st_add3(a_len, b_len, 1));
 	COPY_ARRAY(ret, a, a_len);
=2D-
2.25.0
