From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v15 4/7] parse-options.c: make OPTION_COUNTUP respect "unspecified" values
Date: Sun,  1 May 2016 01:33:33 +0530
Message-ID: <1462046616-2582-4-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 22:04:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awb7s-00015z-UJ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 22:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbcD3UEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 16:04:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35773 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbcD3UEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 16:04:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so18013176pfr.2
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GnWMUjOo/jiLXTTMhccWE+PfzgQbae9pnz+zoKy1ppg=;
        b=ClMswjS/I06Rdz/ja5C43y31QVf1803z4BSDtAHK9AuW/Wax055Zw6Ns195ZTniPPb
         GK3EvQIxcIawvfZcVNPrR9TTTEPoZNPoYx0aNp3Ipc9+fEllNySwv/nKNkTONj+z5e9M
         CW0uGzKTuzG/blILPmCIWgeLwolsSBaH9rl8uGJbV2uCROVUpb33G1Glr+Yawcjad/Nv
         Bcblp6jX/u7Hndl5rTr0CCI0lxF31ukOuzqz/PLjZhQ7lBL2yCS5926xCUdv6f1qGujz
         L5/lJnho9QlEROGtD9REpVI4QamIoFuwVUdo6LgSxxZmk60jXt9Dkkzh5IN33TYnJx7G
         I2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GnWMUjOo/jiLXTTMhccWE+PfzgQbae9pnz+zoKy1ppg=;
        b=WWhWv65PVhQmXVhExhe9rn8e9I1PSFmQhtPe+Yzc/krDWBch7mF6a8UUYsT7NJE51N
         DBsODARAm5lbTb1x85P+n0AqRXk03L59HsnABW6cZDZua00RMNyaU1JUfChbxBcQriiS
         qwMnWjlQEq+Tg+55/+jefR0GdXic5JxIThsfn2bXjG0QmcjF2XNQ2BLfa38uXAvdmEH0
         Tx491oyWA4c691VbDQCblKqtJ8b1xmhNB4gamBnevviHtuGFqiPwlltR3aC6UChf+TwY
         HkGjwjKtdnIaMnTdCBrpj/iyEvlyrpn06ZfL+8dKWj9AtWxwi+edeVLXCZkF148990ZW
         Dc0g==
X-Gm-Message-State: AOPr4FVQkTS2Nb0K4Turzwjo702SZ40a+Or8VqgnXQy397eJcEij33thvpitvdWwt5mP7g==
X-Received: by 10.98.93.138 with SMTP id n10mr39103370pfj.43.1462046663101;
        Sat, 30 Apr 2016 13:04:23 -0700 (PDT)
Received: from localhost.localdomain ([27.106.101.191])
        by smtp.gmail.com with ESMTPSA id h85sm33329025pfj.52.2016.04.30.13.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Apr 2016 13:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293130>

OPT_COUNTUP() merely increments the counter upon --option, and resets it
to 0 upon --no-option, which means that there is no "unspecified" value
with which a client can initialize the counter to determine whether or
not --[no]-option was seen at all.

Make OPT_COUNTUP() treat any negative number as an "unspecified" value
to address this shortcoming. In particular, if a client initializes the
counter to -1, then if it is still -1 after parse_options(), then
neither --option nor --no-option was seen; if it is 0, then --no-option
was seen last, and if it is 1 or greater, than --option was seen last.

This change does not affect the behavior of existing clients because
they all use the initial value of 0 (or more).

Note that builtin/clean.c initializes the variable used with
OPT__FORCE (which uses OPT_COUNTUP()) to a negative value, but it is set
to either 0 or 1 by reading the configuration before the code calls
parse_options(), i.e. as far as parse_options() is concerned, the
initial value of the variable is not negative.

To test this behavior, in test-parse-options.c, "verbose" is set to
"unspecified" while quiet is set to 0 which will test the new behavior
with all sets of values.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The discussion about this patch:
[1] : http://thread.gmane.org/gmane.comp.version-control.git/289027

Previous version of the patch:
[v14] : http://thread.gmane.org/gmane.comp.version-control.git/288820

Changes wrt previous version (v14):
 - Remove a test and move it to a preparatory patch.

Please Note: The diff might seem improper especially the part where I
have introduced some continuous lines but this is a logical error by git
diff (nothing could be done about it) and thus the changes will be
clearly visible with the original file itself.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 Documentation/technical/api-parse-options.txt |  8 ++++++--
 parse-options.c                               |  2 ++
 t/t0040-parse-options.sh                      | 26 +++++++++++++-------------
 test-parse-options.c                          |  3 ++-
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 695bd4b..27bd701 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -144,8 +144,12 @@ There are some macros to easily define options:
 
 `OPT_COUNTUP(short, long, &int_var, description)`::
 	Introduce a count-up option.
-	`int_var` is incremented on each use of `--option`, and
-	reset to zero with `--no-option`.
+	Each use of `--option` increments `int_var`, starting from zero
+	(even if initially negative), and `--no-option` resets it to
+	zero. To determine if `--option` or `--no-option` was encountered at
+	all, initialize `int_var` to a negative value, and if it is still
+	negative after parse_options(), then neither `--option` nor
+	`--no-option` was seen.
 
 `OPT_BIT(short, long, &int_var, description, mask)`::
 	Introduce a boolean option.
diff --git a/parse-options.c b/parse-options.c
index 47a9192..312a85d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -110,6 +110,8 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	case OPTION_COUNTUP:
+		if (*(int *)opt->value < 0)
+			*(int *)opt->value = 0;
 		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
 		return 0;
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 57fc2a1..9638ca0 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -63,7 +63,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -211,7 +211,7 @@ magnitude: 0
 timestamp: 0
 string: 123
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -234,7 +234,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -263,7 +263,7 @@ magnitude: 0
 timestamp: 0
 string: 123
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -302,7 +302,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -322,7 +322,7 @@ magnitude: 0
 timestamp: 1
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 1
 dry run: no
 file: (not set)
@@ -344,7 +344,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -373,7 +373,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -398,7 +398,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -429,7 +429,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -448,7 +448,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -483,7 +483,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 3
 dry run: no
 file: (not set)
@@ -502,7 +502,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
diff --git a/test-parse-options.c b/test-parse-options.c
index 86afa98..f02c275 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -7,7 +7,8 @@ static int integer = 0;
 static unsigned long magnitude = 0;
 static unsigned long timestamp;
 static int abbrev = 7;
-static int verbose = 0, dry_run = 0, quiet = 0;
+static int verbose = -1; /* unspecified */
+static int dry_run = 0, quiet = 0;
 static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;
-- 
2.8.1
