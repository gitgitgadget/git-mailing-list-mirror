From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/16] line-range: teach -L^:RE to search from start of file
Date: Tue,  6 Aug 2013 09:59:47 -0400
Message-ID: <1375797589-65308-15-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hou-0003fH-Eu
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab3HFOA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:59 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:65468 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab3HFOAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:55 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so927782obb.9
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZHSaD4lp4JTKx0d/ycXiKgGQu9QMrzXcLIb/oRai7MQ=;
        b=sORIZNPXF94Uu7y6Wr76skDxiWLEdU2E46/889DWMMlYJQtikHlKtMp3iPWjZX5B55
         Ei5hMIW8C3A5EKDv/T+r92pGF78Zj4jbb/wkuc0qxS/TW75GQhLyhj9JbG6Ji+8QE5hT
         +R8rrsLieqvQz0mLbVcTB6IcUoDD4xWlVp5X+ZXTu2ZvD7FkxphTmlY8MBzA4MeH24FO
         brSk5SnOO8FCfqfrh33xlVUOh3CW5J6BwlVdOkfLrsNxv+S6nMWjZIiajopsnP8wCyB4
         /fqX+3eJGw1Wt7FlhWVw1vv9sSyPJw0/xhMHryyYwrbFJ16aP3ryINT9skLl0FYnmUUQ
         hvgQ==
X-Received: by 10.182.200.230 with SMTP id jv6mr1149983obc.46.1375797654788;
        Tue, 06 Aug 2013 07:00:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231749>

The -L:RE option of blame/log searches from the end of the previous -L
range, if any. Add new notation -L^:RE to override this behavior and
search from start of file.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/line-range-format.txt |  1 +
 line-range.c                        |  9 +++++++--
 t/annotate-tests.sh                 | 17 +++++++++++++++++
 t/t4211-line-log.sh                 |  1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index 469d80b..d7f2603 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -26,3 +26,4 @@ If ``:<regex>'' is given in place of <start> and <end>, it denotes the range
 from the first funcname line that matches <regex>, up to the next
 funcname line. ``:<regex>'' searches from the end of the previous `-L` range,
 if any, otherwise from the start of file.
+``^:<regex>'' searches from the start of file.
diff --git a/line-range.c b/line-range.c
index 4bae4bf..ede0c6c 100644
--- a/line-range.c
+++ b/line-range.c
@@ -173,6 +173,11 @@ static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_
 	int reg_error;
 	regex_t regexp;
 
+	if (*arg == '^') {
+		anchor = 1;
+		arg++;
+	}
+
 	assert(*arg == ':');
 	term = arg+1;
 	while (*term && *term != ':') {
@@ -245,7 +250,7 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 	if (anchor > lines)
 		anchor = lines + 1;
 
-	if (*arg == ':') {
+	if (*arg == ':' || (*arg == '^' && *(arg + 1) == ':')) {
 		arg = parse_range_funcname(arg, nth_line_cb, cb_data, lines, anchor, begin, end, path);
 		if (!arg || *arg)
 			return -1;
@@ -270,7 +275,7 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 
 const char *skip_range_arg(const char *arg)
 {
-	if (*arg == ':')
+	if (*arg == ':' || (*arg == '^' && *(arg + 1) == ':'))
 		return parse_range_funcname(arg, NULL, NULL, 0, 0, NULL, NULL, NULL);
 
 	arg = parse_loc(arg, NULL, NULL, 0, -1, NULL);
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 4f7d6ba..dabe89d 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -398,6 +398,23 @@ test_expect_success 'blame -L :RE (relative: end-of-file)' '
 	test_must_fail $PROG -L, -L:main hello.c
 '
 
+test_expect_success 'blame -L ^:RE (absolute)' '
+	check_count -f hello.c -L3,3 -L^:ma.. F 4 G 1
+'
+
+test_expect_success 'blame -L ^:RE (absolute: no preceding range)' '
+	check_count -f hello.c -L^:ma.. F 4 G 1
+'
+
+test_expect_success 'blame -L ^:RE (absolute: not found)' '
+	test_must_fail $PROG -L4,4 -L^:tambourine hello.c
+'
+
+test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
+	n=$(printf "%d" $(wc -l <hello.c)) &&
+	check_count -f hello.c -L$n -L^:ma.. F 4 G 1 H 1
+'
+
 test_expect_success 'setup incremental' '
 	(
 	GIT_AUTHOR_NAME=I &&
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 8ba2d51..7369d3c 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -48,6 +48,7 @@ canned_test "-M -L '/long f/,/^}/:b.c' move-support" move-support-f
 canned_test "-M -L ':f:b.c' parallel-change" parallel-change-f-to-main
 
 canned_test "-L 4,12:a.c -L :main:a.c simple" multiple
+canned_test "-L 4,18:a.c -L ^:main:a.c simple" multiple-overlapping
 canned_test "-L :main:a.c -L 4,18:a.c simple" multiple-overlapping
 canned_test "-L 4:a.c -L 8,12:a.c simple" multiple-superset
 canned_test "-L 8,12:a.c -L 4:a.c simple" multiple-superset
-- 
1.8.4.rc1.409.gbd48715
