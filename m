Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B54C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147E1246B7
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uD83Slkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbgBKTgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:36:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52973 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgBKTgh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:36:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57FA89986E;
        Tue, 11 Feb 2020 14:36:32 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=g3KKKYINOzlCKk6OOgznzmYDO
        Ak=; b=uD83Slkh3PchzXA03vYF7AG/dPLFbnhHY6xWimvSZB0aEbhLUvk+Z9YAa
        qT9CJdkdRrfb2pGizuV7MyachdBMrb2jQFNtnv8OgQKNLqY9S38NTVTQI7dDiLHY
        b1VHgl80ROk1sysoY6CqE1X1N7xqM2PRIYUDZ5S7JhaBTg7bfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=nIoJlZUV7S+ZchKXMkA
        q+Z16M0sgZapJYVuih9H0arb3NPBthoyI9BKFAFYwZ0Nfw3JQXJpXjHSMHjdDfPn
        Fmm0PBlM6UlhH0cG3JUPfDryifGzkHfOlclilzlgt2xDQG6qfCFA3aSkkRbmtmzT
        miHNUSjvEqTfwsMj/Je/sdNw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FFCC9986D;
        Tue, 11 Feb 2020 14:36:32 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E1079986B;
        Tue, 11 Feb 2020 14:36:29 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/3] color.c: refactor color_output arguments
Date:   Tue, 11 Feb 2020 11:36:23 -0800
Message-Id: <20200211193625.231492-2-gitster@pobox.com>
X-Mailer: git-send-email 2.25.0-453-g769eb9f0f1
In-Reply-To: <20200211193625.231492-1-gitster@pobox.com>
References: <20200121165623.151880-1-shawarmakarma@gmail.com>
 <20200211193625.231492-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: CCDADF8A-4D05-11EA-8722-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eyal Soha <shawarmakarma@gmail.com>

color_output() takes a "type" parameter, which is either '3' or '4',
and that byte is shown in front of '0'-'7' to form "30"-"37" or
"40"-"47" in ANSI output mode for fore-ground and back-ground
colors.

Clarify the purpose of the parameter by renaming it to the
"background" that is a boolean.

Also, change the .value field in the color struct from storing 0-7
for basic 8 colors to storing 30-37 for ANSI colors.  This aligns
the code to show ANSI colors to the code for the 256 color scheme,
which already uses the actual value to be sent to the terminal.

Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 color.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/color.c b/color.c
index ebb222ec33..4ee690bd4e 100644
--- a/color.c
+++ b/color.c
@@ -24,6 +24,13 @@ const char *column_colors_ansi[] =3D {
 	GIT_COLOR_RESET,
 };
=20
+enum {
+	COLOR_BACKGROUND_OFFSET =3D 10,
+	COLOR_FOREGROUND_ANSI =3D 30,
+	COLOR_FOREGROUND_RGB =3D 38,
+	COLOR_FOREGROUND_256 =3D 38,
+};
+
 /* Ignore the RESET at the end when giving the size */
 const int column_colors_ansi_max =3D ARRAY_SIZE(column_colors_ansi) - 1;
=20
@@ -92,7 +99,7 @@ static int parse_color(struct color *out, const char *n=
ame, int len)
 	for (i =3D 0; i < ARRAY_SIZE(color_names); i++) {
 		if (match_word(name, len, color_names[i])) {
 			out->type =3D COLOR_ANSI;
-			out->value =3D i;
+			out->value =3D i + COLOR_FOREGROUND_ANSI;
 			return 0;
 		}
 	}
@@ -112,7 +119,7 @@ static int parse_color(struct color *out, const char =
*name, int len)
 		/* Rewrite low numbers as more-portable standard colors. */
 		} else if (val < 8) {
 			out->type =3D COLOR_ANSI;
-			out->value =3D val;
+			out->value =3D val + COLOR_FOREGROUND_ANSI;
 			return 0;
 		} else if (val < 256) {
 			out->type =3D COLOR_256;
@@ -166,23 +173,26 @@ int color_parse(const char *value, char *dst)
  * already have the ANSI escape code in it. "out" should have enough
  * space in it to fit any color.
  */
-static char *color_output(char *out, int len, const struct color *c, cha=
r type)
+static char *color_output(char *out, int len, const struct color *c, int=
 background)
 {
+	int offset =3D 0;
+
+	if (background)
+		offset =3D COLOR_BACKGROUND_OFFSET;
 	switch (c->type) {
 	case COLOR_UNSPECIFIED:
 	case COLOR_NORMAL:
 		break;
 	case COLOR_ANSI:
-		if (len < 2)
-			BUG("color parsing ran out of space");
-		*out++ =3D type;
-		*out++ =3D '0' + c->value;
+		out +=3D xsnprintf(out, len, "%d", c->value + offset);
 		break;
 	case COLOR_256:
-		out +=3D xsnprintf(out, len, "%c8;5;%d", type, c->value);
+		out +=3D xsnprintf(out, len, "%d;5;%d", COLOR_FOREGROUND_256 + offset,
+				 c->value);
 		break;
 	case COLOR_RGB:
-		out +=3D xsnprintf(out, len, "%c8;2;%d;%d;%d", type,
+		out +=3D xsnprintf(out, len, "%d;2;%d;%d;%d",
+				 COLOR_FOREGROUND_RGB + offset,
 				 c->red, c->green, c->blue);
 		break;
 	}
@@ -279,14 +289,12 @@ int color_parse_mem(const char *value, int value_le=
n, char *dst)
 		if (!color_empty(&fg)) {
 			if (sep++)
 				OUT(';');
-			/* foreground colors are all in the 3x range */
-			dst =3D color_output(dst, end - dst, &fg, '3');
+			dst =3D color_output(dst, end - dst, &fg, 0);
 		}
 		if (!color_empty(&bg)) {
 			if (sep++)
 				OUT(';');
-			/* background colors are all in the 4x range */
-			dst =3D color_output(dst, end - dst, &bg, '4');
+			dst =3D color_output(dst, end - dst, &bg, 1);
 		}
 		OUT('m');
 	}
--=20
2.25.0-453-g769eb9f0f1

