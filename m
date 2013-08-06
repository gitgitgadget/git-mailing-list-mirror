From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/16] line-range: teach -L/RE/ to search relative to anchor point
Date: Tue,  6 Aug 2013 09:59:41 -0400
Message-ID: <1375797589-65308-9-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hpC-0003t2-IV
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab3HFOBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:01:14 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:37765 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab3HFOAm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:42 -0400
Received: by mail-ob0-f169.google.com with SMTP id wc20so913132obb.14
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GIXosb3y6Qel13VqSIM+o0me5LSFFR0SNgNbTkE/JNc=;
        b=boGP0AW3UcaGx5FeSIsOph65TqQ6dg7luNKdJLNWVxbszXgz1YpedCNkvkXLwt5DQt
         oWtSFBTF0LbK+WudxbTJxflTfm+qPMkBCr7vUWRDuAlvyu7okZdBcsl9D38+ScB+GePA
         unIN5DUv7hPpOm3dVcBm4fHPEgLZZDL84+2KFF6rJl87tJORjlzIh493+uDaHUcRIwkn
         gttPVSctm//hTJf50rWfbvMaNpkrwaQPkXwJakTX1zBvDX8oZWcalAoZjKTIIFTbZUf7
         oElUbFQp48zsfEtt6m6xG4hCKzvJbGhWqH0KYEW76wYZOeK0OFUjLcwMfw3J5GY33R9+
         Fo9g==
X-Received: by 10.182.18.40 with SMTP id t8mr1088734obd.85.1375797641720;
        Tue, 06 Aug 2013 07:00:41 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231754>

Range specification -L/RE/ for blame/log unconditionally begins
searching at line one. Mailing list discussion [1] suggests that, in the
presence of multiple -L options, -L/RE/ should search relative to the
endpoint of the previous -L range, if any.

Teach the parsing machinery underlying blame's and log's -L options to
accept a start point for -L/RE/ searches. Follow-up patches will upgrade
blame and log to take advantage of this ability.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/229755/focus=229966

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/blame.c |  2 +-
 line-log.c      |  2 +-
 line-range.c    | 30 ++++++++++++++++++++++++++----
 line-range.h    |  5 ++++-
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 2f4d9e2..7b084d8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2479,7 +2479,7 @@ parse_done:
 	for (range_i = 0; range_i < range_list.nr; ++range_i) {
 		long bottom, top;
 		if (parse_range_arg(range_list.items[range_i].string,
-				    nth_line_cb, &sb, lno,
+				    nth_line_cb, &sb, lno, 1,
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
 		if (lno < top || ((lno || bottom) && lno < bottom))
diff --git a/line-log.c b/line-log.c
index bdadf35..38f827b 100644
--- a/line-log.c
+++ b/line-log.c
@@ -591,7 +591,7 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 		cb_data.line_ends = ends;
 
 		if (parse_range_arg(range_part, nth_line, &cb_data,
-				    lines, &begin, &end,
+				    lines, 1, &begin, &end,
 				    full_name))
 			die("malformed -L argument '%s'", range_part);
 		if (lines < end || ((lines || begin) && lines < begin))
diff --git a/line-range.c b/line-range.c
index 69e8d6b..bbf3c0f 100644
--- a/line-range.c
+++ b/line-range.c
@@ -6,6 +6,18 @@
 
 /*
  * Parse one item in the -L option
+ *
+ * 'begin' is applicable only to relative range anchors. Absolute anchors
+ * ignore this value.
+ *
+ * When parsing "-L A,B", parse_loc() is called once for A and once for B.
+ *
+ * When parsing A, 'begin' must be a negative number, the absolute value of
+ * which is the line at which relative start-of-range anchors should be
+ * based. Beginning of file is represented by -1.
+ *
+ * When parsing B, 'begin' must be the positive line number immediately
+ * following the line computed for 'A'.
  */
 static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 			     void *data, long lines, long begin, long *ret)
@@ -46,6 +58,10 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 			*ret = num;
 		return term;
 	}
+
+	if (begin < 0)
+		begin = -begin;
+
 	if (spec[0] != '/')
 		return spec;
 
@@ -85,7 +101,8 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 	else {
 		char errbuf[1024];
 		regerror(reg_error, &regexp, errbuf, 1024);
-		die("-L parameter '%s': %s", spec + 1, errbuf);
+		die("-L parameter '%s' starting at line %ld: %s",
+		    spec + 1, begin + 1, errbuf);
 	}
 }
 
@@ -210,11 +227,16 @@ static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_
 }
 
 int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
-		    void *cb_data, long lines, long *begin, long *end,
-		    const char *path)
+		    void *cb_data, long lines, long anchor,
+		    long *begin, long *end, const char *path)
 {
 	*begin = *end = 0;
 
+	if (anchor < 1)
+		anchor = 1;
+	if (anchor > lines)
+		anchor = lines + 1;
+
 	if (*arg == ':') {
 		arg = parse_range_funcname(arg, nth_line_cb, cb_data, lines, begin, end, path);
 		if (!arg || *arg)
@@ -222,7 +244,7 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 		return 0;
 	}
 
-	arg = parse_loc(arg, nth_line_cb, cb_data, lines, 1, begin);
+	arg = parse_loc(arg, nth_line_cb, cb_data, lines, -anchor, begin);
 
 	if (*arg == ',')
 		arg = parse_loc(arg + 1, nth_line_cb, cb_data, lines, *begin + 1, end);
diff --git a/line-range.h b/line-range.h
index ae3d012..83ba3c2 100644
--- a/line-range.h
+++ b/line-range.h
@@ -9,6 +9,9 @@
  * line 'lno' inside the 'cb_data'.  The caller is expected to already
  * have a suitable map at hand to make this a constant-time lookup.
  *
+ * 'anchor' is the 1-based line at which relative range specifications
+ * should be anchored. Absolute ranges are unaffected by this value.
+ *
  * Returns 0 in case of success and -1 if there was an error.  The
  * actual range is stored in *begin and *end.  The counting starts
  * at 1!  In case of error, the caller should show usage message.
@@ -18,7 +21,7 @@ typedef const char *(*nth_line_fn_t)(void *data, long lno);
 
 extern int parse_range_arg(const char *arg,
 			   nth_line_fn_t nth_line_cb,
-			   void *cb_data, long lines,
+			   void *cb_data, long lines, long anchor,
 			   long *begin, long *end,
 			   const char *path);
 
-- 
1.8.4.rc1.409.gbd48715
