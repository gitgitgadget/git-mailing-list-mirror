From: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Thu, 26 May 2016 22:46:10 -0500
Message-ID: <20160527034610.GA31629@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 05:46:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b68jO-0000nL-97
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 05:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbcE0DqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 23:46:18 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32871 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbcE0DqQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2016 23:46:16 -0400
Received: by mail-io0-f194.google.com with SMTP id p194so1635413iod.0
        for <git@vger.kernel.org>; Thu, 26 May 2016 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=7hZlPzD3XyK4Q31Xp5ThMX3u6LMlxMtM0R26rkVnLkA=;
        b=l32Xd38v1mTrkZfTYiC71KCUTd17RIWZJ2eSqDiG0j3rU9LbA4yUHP552pXit3Q4DC
         pOPgthmu2qorRBtpJojmBp9cALjfEmZ0nh3qZ1aXAsv8MGxjplJCUYo+mGgIrKrPt573
         nD8xxCHkH7wyjXBUWbFiqwL8LN/pjACW5S64AJQeizRrnD/WkvfueWjYlrJfGt80c+NR
         F5e0e1cjiQ+psDR17cVzm6ngHnUfp1CELlIRE0XYF1IPBFZUwDOBAOkuyRvpxS2djg2v
         FL3eiWgLSmPJNOhVrUoL6fGOIVoJIcueF1EGtBJe8HF7DhmhVuDZNCv7nbyyFatxvoga
         anoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=7hZlPzD3XyK4Q31Xp5ThMX3u6LMlxMtM0R26rkVnLkA=;
        b=UxKoVPBKjrcmcsjY4l9kZItwZHxSn9TbDOLgt8uLqkIDDplDiyA7Og517XTrrex/RE
         7lA8Xe6noTaR+F0p+C3otiPKn7NFjOUlspe8M/gb0BbrXH/NdtT0zGkq9+/9uzPjGFy9
         Qb+EWIIc8YtKaW/UQInMH3+61K8BOEGdHsXhwgVYg1IsQ/BfrqRIuaUak8G0BipCqacp
         +lrhqZpCGwlB2wzwyEPqlBIkgTbethvG8yx9a+tzj2J5D0vlyBf4YV8Y1GUmvBBn3AYD
         Ng2SbdKG6tpy5oDa96P3Ox7dCj3j9GKTtuy4yCjwdX4QZ7dF/IKXQ2xuj7RdeVVggVJP
         0L1g==
X-Gm-Message-State: ALyK8tLJVjhlPnsdM+ay0A648FIyBmh4f8e2j+3//QGwYv2wt3uKisRFAcxsPbRZ1vPS3w==
X-Received: by 10.107.5.141 with SMTP id 135mr12339808iof.91.1464320775309;
        Thu, 26 May 2016 20:46:15 -0700 (PDT)
Received: from zoidberg ([2601:249:1000:6850:3125:f490:e3f1:e1d])
        by smtp.gmail.com with ESMTPSA id j70sm5483137ioi.19.2016.05.26.20.46.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2016 20:46:14 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295722>

git-log(1) documents that when specifying the `%C(auto)` format
placeholder will "turn on auto coloring on the next %placeholders
until the color is switched again."

However, when `%C(auto)` is used, the present implementation will turn
colors on unconditionally (even if the color configuration is turned off
for the current context - for example, `--no-color` was specified or the
color is `auto` and the output is not a tty).

Update `format_commit_one` to examine the current context when a format
string of `%C(auto)` is specified, which ensures that we will not
unconditionally write colors.  This brings that behavior in line with
the behavior of `%C(auto,<colorname>)`, and allows the user the ability
to specify that color should be displayed only when the output is a
tty.

Additionally, add a test for `%C(auto)` and update the existing tests
for `%C(auto,...)` as they were misidentified as being applicable to
`%C(auto)`.

Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>

Tests from Jeff King.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c                   |  2 +-
 t/t6006-rev-list-format.sh | 26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/pretty.c b/pretty.c
index 87c4497..c3ec430 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1063,7 +1063,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	switch (placeholder[0]) {
 	case 'C':
 		if (starts_with(placeholder + 1, "(auto)")) {
-			c->auto_color = 1;
+			c->auto_color = want_color(c->pretty_ctx->color);
 			return 7; /* consumed 7 bytes, "C(auto)" */
 		} else {
 			int ret = parse_color(sb, placeholder, c);
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index b77d4c9..a1dcdb8 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -184,38 +184,38 @@ commit $head1
 [1;31;43mfoo[m
 EOF
 
-test_expect_success '%C(auto) does not enable color by default' '
+test_expect_success '%C(auto,...) does not enable color by default' '
 	git log --format=$AUTO_COLOR -1 >actual &&
 	has_no_color actual
 '
 
-test_expect_success '%C(auto) enables colors for color.diff' '
+test_expect_success '%C(auto,...) enables colors for color.diff' '
 	git -c color.diff=always log --format=$AUTO_COLOR -1 >actual &&
 	has_color actual
 '
 
-test_expect_success '%C(auto) enables colors for color.ui' '
+test_expect_success '%C(auto,...) enables colors for color.ui' '
 	git -c color.ui=always log --format=$AUTO_COLOR -1 >actual &&
 	has_color actual
 '
 
-test_expect_success '%C(auto) respects --color' '
+test_expect_success '%C(auto,...) respects --color' '
 	git log --format=$AUTO_COLOR -1 --color >actual &&
 	has_color actual
 '
 
-test_expect_success '%C(auto) respects --no-color' '
+test_expect_success '%C(auto,...) respects --no-color' '
 	git -c color.ui=always log --format=$AUTO_COLOR -1 --no-color >actual &&
 	has_no_color actual
 '
 
-test_expect_success TTY '%C(auto) respects --color=auto (stdout is tty)' '
+test_expect_success TTY '%C(auto,...) respects --color=auto (stdout is tty)' '
 	test_terminal env TERM=vt100 \
 		git log --format=$AUTO_COLOR -1 --color=auto >actual &&
 	has_color actual
 '
 
-test_expect_success '%C(auto) respects --color=auto (stdout not tty)' '
+test_expect_success '%C(auto,...) respects --color=auto (stdout not tty)' '
 	(
 		TERM=vt100 && export TERM &&
 		git log --format=$AUTO_COLOR -1 --color=auto >actual &&
@@ -223,6 +223,18 @@ test_expect_success '%C(auto) respects --color=auto (stdout not tty)' '
 	)
 '
 
+test_expect_success '%C(auto) respects --color' '
+	git log --color --format="%C(auto)%H" -1 >actual &&
+	printf "\\033[33m%s\\033[m\\n" $(git rev-parse HEAD) >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%C(auto) respects --no-color' '
+	git log --no-color --format="%C(auto)%H" -1 >actual &&
+	git rev-parse HEAD >expect &&
+	test_cmp expect actual
+'
+
 iconv -f utf-8 -t $test_encoding > commit-msg <<EOF
 Test printing of complex bodies
 
-- 
2.7.4 (Apple Git-66)
