From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v16 5/7] parse-options.c: make OPTION_COUNTUP respect "unspecified" values
Date: Thu,  5 May 2016 15:20:00 +0530
Message-ID: <1462441802-4768-6-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, szeder@ira.uka.de, git@vger.kernel.org,
	Pranit Bauva <pranit.bauva@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 05 11:51:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayFwO-0007oe-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 11:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722AbcEEJv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 05:51:26 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36032 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808AbcEEJvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 05:51:25 -0400
Received: by mail-pf0-f175.google.com with SMTP id c189so37266136pfb.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9yDS3Fn+Zu0ivHqgtQQF2uMBsP9bmRozFGJf3RtIXZc=;
        b=r0hxHNXmsXR5w1HUJ7mAXei7iREYeqjmAftwnS8ArliGyZkfQl3Qip8rfU3H3CTZEd
         KE6de0v3dN4slS3X+7tDb7h1lwpFcAbi614bs5UrFy3sb4CrQSckUyBnhajY+bjzZwGa
         JgpZIqlbhu9Xy7vuLjqr4DRZ8VtiIFJkxt3/qY2d8I5IC151QtdBJyEsU5sLy9zjGHMJ
         F8w6O0pGRJGka/2zFDnuY1uCj32vPJS/A7p1KI4iFpsCJRV7Z96qx7/HnD/5eI/daFoV
         l7xf2LsAEWx6qTXHveamN+fxMGnWZ3qC4QyAmh1zT3vXdZqKzRtfa6vLZzBiTONmzO+b
         WgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9yDS3Fn+Zu0ivHqgtQQF2uMBsP9bmRozFGJf3RtIXZc=;
        b=M6BsAqScjDik4fPUj/71Rs9oPbgKyS0OFty341HxupLh7OMu8IN8eEZ3C4nkFF5LWm
         z56EjRBp5J+gkG8BCoaKwHBBs/mvm4s05qnYNtBGRl2yv28RpuNEVTmO6XcEqB3ZJ0td
         QCxChX5X8hOqvMG6FGP2hNpQZEYuZ8F352nF+9CrasY02v47+Si9qJat71X53qZd3zdm
         49JmkrwMy5IpeZQ/uPm1wb+7xq38Sw042gFKteeKDqko4labZlmwwCq22x7w5GgRItWw
         M2CuSkHNAfDASPknNczdylOaW0AKk1XxeNYo0FVj9YFMTXyviB3mbDJ4+qQHZJUmJy3y
         XiYw==
X-Gm-Message-State: AOPr4FVDOVNg5+H1LlwDbeEqN5AXbdHYnv6sRMwTDXuiFoN1VfZ7oJISTVTptlJ0mkS+yA==
X-Received: by 10.98.72.16 with SMTP id v16mr19338395pfa.12.1462441884774;
        Thu, 05 May 2016 02:51:24 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id zn12sm12255111pab.14.2016.05.05.02.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 May 2016 02:51:24 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293637>

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

---
 Documentation/technical/api-parse-options.txt |  8 ++++++--
 parse-options.c                               |  2 ++
 t/t0040-parse-options.sh                      | 28 +++++++++++++--------------
 test-parse-options.c                          |  3 ++-
 4 files changed, 24 insertions(+), 17 deletions(-)

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
index 717a514..fec3fef 100755
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
@@ -521,7 +521,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -540,7 +540,7 @@ magnitude: 0
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
