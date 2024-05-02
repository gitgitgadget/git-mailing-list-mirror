Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F355FB8A
	for <git@vger.kernel.org>; Thu,  2 May 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647842; cv=none; b=o9E7CK0dErb7svEtFdctqGHjNlvdCRS4FS645Xa0lZx+Ly3gmqvRh9DasIGNXOXw4Uf56ChgZ0O17zb9OCtdBGzA/K7LLHYKxts4mi+QCm/bs0VGtmG+m4PKb2xTq9YIpeTQnX9qmB19qQoZ2l98tbHhEKZ9WWyf7OmNzXVMcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647842; c=relaxed/simple;
	bh=aFAjLGGaYE7Df90BbRxdAUse7xSyVFfmwEboYcMFNdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeOkFKXGbu/qakYZClA5UJhshZqn4v+jIVLfvGt9z6Hv7EOCFEFTs+7hSfllI4eoJkh8cYoHSQdCnKcHBZ0ussBqMqCsd84awMICJ5rhmH0HsdmVJS9EGul4I/+t0IFKg6Dgx6xzpergmil2r/b+B88PAo6TUPICDCHJhUgtPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1s2UEC-0000000025z-2vPN
	for git@vger.kernel.org;
	Thu, 02 May 2024 13:03:53 +0200
Received: from [10.20.10.231] (port=15846 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1s2UEB-00EbFB-1t;
	Thu, 02 May 2024 13:03:51 +0200
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 3CDAC1801C7;
	Thu,  2 May 2024 13:03:50 +0200 (CEST)
Received: by minibeat.bolli (sSMTP sendmail emulation); Thu, 02 May 2024 13:03:50 +0200
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 3/3] color: add support for 12-bit RGB colors
Date: Thu,  2 May 2024 13:03:31 +0200
Message-ID: <20240502110331.6347-4-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502110331.6347-1-dev+git@drbeat.li>
References: <20240502110331.6347-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

RGB color parsing currently supports 24-bit values in the form #RRGGBB.

As in Cascading Style Sheets (CSS [1]), also allow to specify an RGB color
using only three digits with #RGB.

In this shortened form, each of the digits is – again, as in CSS –
duplicated to convert the color to 24 bits, e.g. #f1b specifies the same
color as #ff11bb.

In color.h, remove the '0x' prefix in the example to match the actual
syntax.

[1] https://developer.mozilla.org/en-US/docs/Web/CSS/hex-color

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 Documentation/config.txt |  3 ++-
 color.c                  | 21 ++++++++++++++-------
 color.h                  |  3 ++-
 t/t4026-color.sh         | 10 ++++++----
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 70b448b13262..6f649c997c0f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -316,7 +316,8 @@ terminals, this is usually not the same as setting to "white black".
 Colors may also be given as numbers between 0 and 255; these use ANSI
 256-color mode (but note that not all terminals may support this).  If
 your terminal supports it, you may also specify 24-bit RGB values as
-hex, like `#ff0ab3`.
+hex, like `#ff0ab3`, or 12-bit RGB values like `#f1b`, which is
+equivalent to the 24-bit color `#ff11bb`.
 +
 The accepted attributes are `bold`, `dim`, `ul`, `blink`, `reverse`,
 `italic`, and `strike` (for crossed-out or "strikethrough" letters).
diff --git a/color.c b/color.c
index f663c06ac4ed..227a5ab2f42e 100644
--- a/color.c
+++ b/color.c
@@ -64,12 +64,16 @@ static int match_word(const char *word, int len, const char *match)
 	return !strncasecmp(word, match, len) && !match[len];
 }
 
-static int get_hex_color(const char *in, unsigned char *out)
+static int get_hex_color(const char **inp, int width, unsigned char *out)
 {
+	const char *in = *inp;
 	unsigned int val;
-	val = (hexval(in[0]) << 4) | hexval(in[1]);
+
+	assert(width == 1 || width == 2);
+	val = (hexval(in[0]) << 4) | hexval(in[width - 1]);
 	if (val & ~0xff)
 		return -1;
+	*inp += width;
 	*out = val;
 	return 0;
 }
@@ -135,11 +139,14 @@ static int parse_color(struct color *out, const char *name, int len)
 		return 0;
 	}
 
-	/* Try a 24-bit RGB value */
-	if (len == 7 && name[0] == '#') {
-		if (!get_hex_color(name + 1, &out->red) &&
-		    !get_hex_color(name + 3, &out->green) &&
-		    !get_hex_color(name + 5, &out->blue)) {
+	/* Try a 24- or 12-bit RGB value prefixed with '#' */
+	if ((len == 7 || len == 4) && name[0] == '#') {
+		int width_per_color = (len == 7) ? 2 : 1;
+		const char *color = name + 1;
+
+		if (!get_hex_color(&color, width_per_color, &out->red) &&
+		    !get_hex_color(&color, width_per_color, &out->green) &&
+		    !get_hex_color(&color, width_per_color, &out->blue)) {
 			out->type = COLOR_RGB;
 			return 0;
 		}
diff --git a/color.h b/color.h
index bb28343be210..7ed259a35bb4 100644
--- a/color.h
+++ b/color.h
@@ -112,7 +112,8 @@ int want_color_fd(int fd, int var);
  * Translate a Git color from 'value' into a string that the terminal can
  * interpret and store it into 'dst'. The Git color values are of the form
  * "foreground [background] [attr]" where fore- and background can be a color
- * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
+ * name ("red"), a RGB code (#FF0000 or #F00) or a 256-color-mode from the
+ * terminal.
  */
 int color_parse(const char *value, char *dst);
 int color_parse_mem(const char *value, int len, char *dst);
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index c41138031989..b05f2a9b6075 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -96,8 +96,8 @@ test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
 
-test_expect_success '24-bit colors' '
-	color "#ff00ff black" "[38;2;255;0;255;40m"
+test_expect_success 'RGB colors' '
+	color "#ff00ff #0f0" "[38;2;255;0;255;48;2;0;255;0m"
 '
 
 test_expect_success '"default" foreground' '
@@ -146,13 +146,15 @@ test_expect_success 'non-hex character in RGB color' '
 	invalid_color "#12x456" &&
 	invalid_color "#123x56" &&
 	invalid_color "#1234x6" &&
-	invalid_color "#12345x"
+	invalid_color "#12345x" &&
+	invalid_color "#x23" &&
+	invalid_color "#1x3" &&
+	invalid_color "#12x"
 '
 
 test_expect_success 'wrong number of letters in RGB color' '
 	invalid_color "#1" &&
 	invalid_color "#23" &&
-	invalid_color "#456" &&
 	invalid_color "#789a" &&
 	invalid_color "#bcdef" &&
 	invalid_color "#1234567"
-- 
2.44.0

