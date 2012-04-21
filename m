From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH] grep -z: do not use NUL to after line number
Date: Fri, 20 Apr 2012 23:08:18 -0400
Message-ID: <1334977698-31376-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 05:08:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLQgh-0000xD-5H
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 05:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab2DUDIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 23:08:35 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53711 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab2DUDIe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 23:08:34 -0400
Received: by vcqp1 with SMTP id p1so6847159vcq.19
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/RoIQaOmI1uJFbpN5OQff1y9+9j9SyL+b510lSp/ZM0=;
        b=Bq/1xwpQ2WL+nsN8F8PUNZMMMbc/XuNdcolsCXQ4fVHzMjYTXwoN/BArpQ0yhnXjN4
         b4daF16brQ4IZpqrHznBVW47d0j3jtmkTts/hwoKIhd9xBiIriAPTqVo5rYexwGH7IMK
         hf+Xj0xFtkcl5FKT9NWej6dapVSrZobzREazo/4sYX6n6pm64BFKHaJGFs0jiE8fpdaE
         DazqOOIxf9IY36aY87Fay15kQ/EU+SpIUkgA6nw4GqFFRSsHTW0S3Dzl5S9z5KfLZgX6
         iR+Hxmunhpzmk8YKjRW9w5f+4I8vx/rUP+mRU+RoaUsJ9b1SuXgXRVUH5Uf3b+EyqQes
         0Q8g==
Received: by 10.220.38.8 with SMTP id z8mr7372193vcd.68.1334977713363;
        Fri, 20 Apr 2012 20:08:33 -0700 (PDT)
Received: from mark.hsd1.dc.comcast.net. (c-76-21-213-235.hsd1.dc.comcast.net. [76.21.213.235])
        by mx.google.com with ESMTPS id o13sm83437vdh.6.2012.04.20.20.08.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Apr 2012 20:08:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196033>

This makes `git grep -z' consistent with GNU `grep -Z' and also allows
the reader of the output to determine whether each line is a match,
context, or function.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
It seems like this should have been the original behavior, but I don't know if
it has been too long to change the output format, especially since this option
is used exclusively for processing by scripts.  Perhaps as a new option (-Z?)
or environment variable?

 grep.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 190139c..82958f2 100644
--- a/grep.c
+++ b/grep.c
@@ -469,9 +469,9 @@ static void output_color(struct grep_opt *opt, const void *data, size_t size,
 		opt->output(opt, data, size);
 }
 
-static void output_sep(struct grep_opt *opt, char sign)
+static void output_sep(struct grep_opt *opt, char sign, int after_name)
 {
-	if (opt->null_following_name)
+	if (after_name && opt->null_following_name)
 		opt->output(opt, "\0", 1);
 	else
 		output_color(opt, &sign, 1, opt->color_sep);
@@ -762,13 +762,13 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 
 	if (!opt->heading && opt->pathname) {
 		output_color(opt, name, strlen(name), opt->color_filename);
-		output_sep(opt, sign);
+		output_sep(opt, sign, 1);
 	}
 	if (opt->linenum) {
 		char buf[32];
 		snprintf(buf, sizeof(buf), "%d", lno);
 		output_color(opt, buf, strlen(buf), opt->color_lineno);
-		output_sep(opt, sign);
+		output_sep(opt, sign, 0);
 	}
 	if (opt->color) {
 		regmatch_t match;
@@ -1152,7 +1152,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	if (opt->count && count) {
 		char buf[32];
 		output_color(opt, gs->name, strlen(gs->name), opt->color_filename);
-		output_sep(opt, ':');
+		output_sep(opt, ':', 1);
 		snprintf(buf, sizeof(buf), "%u\n", count);
 		opt->output(opt, buf, strlen(buf));
 		return 1;
-- 
1.7.10
