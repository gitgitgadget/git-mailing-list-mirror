From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 13/16] line-range: teach -L:RE to search from end of previous -L range
Date: Tue,  6 Aug 2013 09:59:46 -0400
Message-ID: <1375797589-65308-14-git-send-email-sunshine@sunshineco.com>
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
	id 1V6hot-0003fH-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab3HFOAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:54 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:53455 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab3HFOAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:53 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so744305oag.21
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hAPp/S6vKy6duWND7XZPu6ej/aNIHLff6TWDRLaIlWE=;
        b=O+pdf9KAfqWMXnf3CNlm2zoXboRYTO4HOgY2/iU+CyyXnemLoTER+M9EPyin5hkQOe
         Ll4AcgqsDAP9+oLGwYNLFLIrehzFWNWH87UpuEwAubJd/3MagbQZjTgYqYJYY5XbLrkf
         ve5SukICShy8iEMyuAoXAHq5DrJ/drau84O516pbInXAnZXEtgx0TApTPX0yKIHSb9/F
         khc/ln8HuRsHrygmrJY3T+wIw7I4PU1H1WvoU2CiBm5378BOdKKLAYsIEPi+q1Ai5lMI
         UcpLnWA2y/iswdgN1WAwOdBCOt+CcTMCYPUtEg/Ofk7ewSg1b7lAVuzAQa9/ey8vOH+D
         00cg==
X-Received: by 10.182.33.103 with SMTP id q7mr1083822obi.77.1375797652449;
        Tue, 06 Aug 2013 07:00:52 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231750>

For consistency with -L/RE/, teach -L:RE to search relative to the end
of the previous -L range, if any.

The new behavior invalidates one test in t4211 which assumes that -L:RE
begins searching at start of file. This test will be resurrected in a
follow-up patch which teaches -L:RE how to override the default relative
search behavior.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/line-range-format.txt |  3 ++-
 line-range.c                        | 12 +++++++-----
 t/annotate-tests.sh                 | 16 ++++++++++++++++
 t/t4211-line-log.sh                 |  1 -
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index cf84417..469d80b 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -24,4 +24,5 @@ of lines before or after the line given by <start>.
 +
 If ``:<regex>'' is given in place of <start> and <end>, it denotes the range
 from the first funcname line that matches <regex>, up to the next
-funcname line.
+funcname line. ``:<regex>'' searches from the end of the previous `-L` range,
+if any, otherwise from the start of file.
diff --git a/line-range.c b/line-range.c
index 7048489..4bae4bf 100644
--- a/line-range.c
+++ b/line-range.c
@@ -161,7 +161,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
 }
 
 static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_cb,
-					void *cb_data, long lines, long *begin, long *end,
+					void *cb_data, long lines, long anchor, long *begin, long *end,
 					const char *path)
 {
 	char *pattern;
@@ -187,7 +187,8 @@ static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_
 
 	pattern = xstrndup(arg+1, term-(arg+1));
 
-	start = nth_line_cb(cb_data, 0);
+	anchor--; /* input is in human terms */
+	start = nth_line_cb(cb_data, anchor);
 
 	drv = userdiff_find_by_path(path);
 	if (drv && drv->funcname.pattern) {
@@ -205,7 +206,8 @@ static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_
 
 	p = find_funcname_matching_regexp(xecfg, (char*) start, &regexp);
 	if (!p)
-		die("-L parameter '%s': no match", pattern);
+		die("-L parameter '%s' starting at line %ld: no match",
+		    pattern, anchor + 1);
 	*begin = 0;
 	while (p > nth_line_cb(cb_data, *begin))
 		(*begin)++;
@@ -244,7 +246,7 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 		anchor = lines + 1;
 
 	if (*arg == ':') {
-		arg = parse_range_funcname(arg, nth_line_cb, cb_data, lines, begin, end, path);
+		arg = parse_range_funcname(arg, nth_line_cb, cb_data, lines, anchor, begin, end, path);
 		if (!arg || *arg)
 			return -1;
 		return 0;
@@ -269,7 +271,7 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 const char *skip_range_arg(const char *arg)
 {
 	if (*arg == ':')
-		return parse_range_funcname(arg, NULL, NULL, 0, NULL, NULL, NULL);
+		return parse_range_funcname(arg, NULL, NULL, 0, 0, NULL, NULL, NULL);
 
 	arg = parse_loc(arg, NULL, NULL, 0, -1, NULL);
 
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 5a7d7c7..4f7d6ba 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -382,6 +382,22 @@ test_expect_success 'blame -L :nomatch' '
 	test_must_fail $PROG -L:nomatch hello.c
 '
 
+test_expect_success 'blame -L :RE (relative)' '
+	check_count -f hello.c -L3,3 -L:ma.. F 1 H 4
+'
+
+test_expect_success 'blame -L :RE (relative: no preceding range)' '
+	check_count -f hello.c -L:ma.. F 4 G 1
+'
+
+test_expect_success 'blame -L :RE (relative: not found)' '
+	test_must_fail $PROG -L3,3 -L:tambourine hello.c
+'
+
+test_expect_success 'blame -L :RE (relative: end-of-file)' '
+	test_must_fail $PROG -L, -L:main hello.c
+'
+
 test_expect_success 'setup incremental' '
 	(
 	GIT_AUTHOR_NAME=I &&
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index b01b3dd..8ba2d51 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -48,7 +48,6 @@ canned_test "-M -L '/long f/,/^}/:b.c' move-support" move-support-f
 canned_test "-M -L ':f:b.c' parallel-change" parallel-change-f-to-main
 
 canned_test "-L 4,12:a.c -L :main:a.c simple" multiple
-canned_test "-L 4,18:a.c -L :main:a.c simple" multiple-overlapping
 canned_test "-L :main:a.c -L 4,18:a.c simple" multiple-overlapping
 canned_test "-L 4:a.c -L 8,12:a.c simple" multiple-superset
 canned_test "-L 8,12:a.c -L 4:a.c simple" multiple-superset
-- 
1.8.4.rc1.409.gbd48715
