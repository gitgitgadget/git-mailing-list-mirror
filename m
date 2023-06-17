Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D368EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 20:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjFQUmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346479AbjFQUly (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 16:41:54 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA6A273F
        for <git@vger.kernel.org>; Sat, 17 Jun 2023 13:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687034505; x=1687639305; i=l.s.r@web.de;
 bh=ht5KXuXk5pLUdtGbukC0JzfUgKE3ms8w9nPNRaFyI4g=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
 b=pWaRGffz9ug2HAdsAZUXqyKdeE7IQv5S4x7kF+/bTKNJ6TPa0Gf7onjxAZXoHwUw8mpn4cY
 rtJ406f44O362idyOJ8RIM6vhd9Tm8t3Y4pM+JG7dlvsdTH2A66LOYVtS/GtKNTyeXX8wHxNJ
 ftaBKDbpv2ISxinKHighnOt35+NSG/jhlmSuh5Ab8BR8x398aE9CJ8pSq+t9n/XJWK6wX+GKi
 4aeVxOkB3FhY5+Q/W7Gck84O4kZE7i+mUWC8tyD4wxWPpocn7LVCPyVGT5UhLbIY+gnTqwXsl
 AgKQDdEK6whDizXNis68qVDl9Lr5YZknFML07LlKF/ot7nuVInFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.195]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpTxo-1plTXg3hTY-00qA99 for
 <git@vger.kernel.org>; Sat, 17 Jun 2023 22:41:44 +0200
Message-ID: <caf8e100-1308-cb4e-d61a-4e15ee3f47f7@web.de>
Date:   Sat, 17 Jun 2023 22:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: [PATCH 2/5] strbuf: factor out strbuf_expand_step()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
In-Reply-To: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cg1avrKVw8NBU0fB4/CSzFvfkBarAVnCXBQHbN/JnNNedqylKvm
 HU/xje/5k/vPkY464PF/bO83pxUPlJ/QKfcAh8pvawW5t+g/ouOcH2BlOHAuXy+HyzhgZEX
 GMD2xFzkvSSlo53mPo594BxQ2Pq4HyuUDDvLBHtf8jw1PaynwcfFRKZGje/0i02X7u0Q2Rt
 NDfhT6xR5tHP3qWN/NlzQ==
UI-OutboundReport: notjunk:1;M01:P0:QJEY+Bu9xaM=;0uld1VjVtGAKSS+0CWUT2zzikgV
 vyce5p5XOhLq9Em5JGofz7ARLiys7fvt84wquhsNTy/Dwp3/+8upqwd/m1R0v01MTrdOLh1Pu
 uy5qTLxqiQPeWOrzQenttQZ+pJoBTIaf3pkrGAJ6xIVssUNiSv8KjfVbqxxEO8CzRJ7KSYFSz
 5M6uqIYjHVsJFiFUOTPbg9Uowa3bXSOFreVzUjvl/eeTHSRuF7gb15RjB8kyMsalnicqC+VTL
 NElv++B9xwulij/OWGxOF57zux6lPmYGMLEoUUxSa7Z1xlVvNTefsuvLcrKkLrASFrXjkf1VB
 Wsk0NGUGUvPEJb/dVpCg+qoHTNIqEm2wSl37xQyfZj5vRtunOINkvjGCkJIu53U3agzOmxkSZ
 j+76mIhaXCp//lyOQJ1RrsuMGY8l9JmPrSL/sT4aUbkOAp85E1LcLI5d1ILa60ger08Cqr5xX
 rDnf9c7LooKl+xPbNbkmvWkSuNDhHaSdK06sO/98i7vRO93S3Oc1Y5+0LxhZOS79WpTBnggiM
 AkrkEFoKhmPVCbjmVF23b8NVRU1v5zh+M+TGL7EnsTp90cRdvaq2GMEfOlELgf2HOeWqpIw22
 Hv4XHxv6XhdtPtmfVxm9hKFkY9eyfbuAiL5Vdlg38OPnBQCqghiqrrbGgXGNEL3NUqLVW7mlx
 Ndy2hLOgoNcBBbHwilbAe+u0kr+FcY6fKqEuOq+Ugss0MIlzDCjRLs2WXFz1tCI1pnr6VD9Mg
 XvJIm5g0dvBkhGQBkympqJmWGMYjwd2rVGG/ulRmHJhJfNdC5YJSwtxbLPYzKn3ILnI1zgsAb
 xw7quwXgDlrIMGc/twpEOIs/8BAz0DYYvS8rMmKAjZrADknjdcr28EPoSzWHGFFn87DQ1nrtf
 BBbYeh8hxyO7n/EsG7lyQc6POW/nqlaZRKHEgf9RPr45/2U03SbMsu/fR110AJ4qVhA4s7vUA
 thmODgR/HSYIMSGPmVVGRebv5Ps=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract the part of strbuf_expand that finds the next placeholder into a
new function.  It allows to build parsers without callback functions and
the overhead imposed by them.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/branch.c | 13 ++-----------
 strbuf.c         | 28 ++++++++++++++--------------
 strbuf.h         |  8 ++++++++
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e6c2655af6..7c20e049a2 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -366,17 +366,8 @@ static const char *quote_literal_for_format(const cha=
r *s)
 	static struct strbuf buf =3D STRBUF_INIT;

 	strbuf_reset(&buf);
-	while (*s) {
-		const char *ep =3D strchrnul(s, '%');
-		if (s < ep)
-			strbuf_add(&buf, s, ep - s);
-		if (*ep =3D=3D '%') {
-			strbuf_addstr(&buf, "%%");
-			s =3D ep + 1;
-		} else {
-			s =3D ep;
-		}
-	}
+	while (strbuf_expand_step(&buf, &s))
+		strbuf_addstr(&buf, "%%");
 	return buf.buf;
 }

diff --git a/strbuf.c b/strbuf.c
index 08eec8f1d8..a90b597da1 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -415,19 +415,24 @@ void strbuf_vaddf(struct strbuf *sb, const char *fmt=
, va_list ap)
 	strbuf_setlen(sb, sb->len + len);
 }

+int strbuf_expand_step(struct strbuf *sb, const char **formatp)
+{
+	const char *format =3D *formatp;
+	const char *percent =3D strchrnul(format, '%');
+
+	strbuf_add(sb, format, percent - format);
+	if (!*percent)
+		return 0;
+	*formatp =3D percent + 1;
+	return 1;
+}
+
 void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
 		   void *context)
 {
-	for (;;) {
-		const char *percent;
+	while (strbuf_expand_step(sb, &format)) {
 		size_t consumed;

-		percent =3D strchrnul(format, '%');
-		strbuf_add(sb, format, percent - format);
-		if (!*percent)
-			break;
-		format =3D percent + 1;
-
 		if (*format =3D=3D '%') {
 			strbuf_addch(sb, '%');
 			format++;
@@ -1022,12 +1027,7 @@ void strbuf_addftime(struct strbuf *sb, const char =
*fmt, const struct tm *tm,
 	 * we want for %z, but the computation for %s has to convert to number
 	 * of seconds.
 	 */
-	for (;;) {
-		const char *percent =3D strchrnul(fmt, '%');
-		strbuf_add(&munged_fmt, fmt, percent - fmt);
-		if (!*percent)
-			break;
-		fmt =3D percent + 1;
+	while (strbuf_expand_step(&munged_fmt, &fmt)) {
 		switch (*fmt) {
 		case '%':
 			strbuf_addstr(&munged_fmt, "%%");
diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c..a189f12b84 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -371,6 +371,14 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb,
 			     const char *placeholder,
 			     void *context);

+/**
+ * If the string pointed to by `formatp` contains a percent sign ("%"),
+ * advance it to point to the character following the next one and
+ * return 1, otherwise return 0.  Append the substring before that
+ * percent sign to `sb`, or the whole string if there is none.
+ */
+int strbuf_expand_step(struct strbuf *sb, const char **formatp);
+
 /**
  * Append the contents of one strbuf to another, quoting any
  * percent signs ("%") into double-percents ("%%") in the
=2D-
2.41.0
