From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/16] log: teach -L/RE/ to search from end of previous -L range
Date: Tue,  6 Aug 2013 09:59:43 -0400
Message-ID: <1375797589-65308-11-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:01:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hor-0003fH-OB
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab3HFOAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:48 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:49422 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab3HFOAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:47 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so741734oah.20
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ut/h11JscG8i4tdAZX10qd330v38bSEROPex3qCFvPs=;
        b=l1wtFSzBf6Uqo1Kil6g9QhvhOX1N4q/xVtzzKA8HS9DTFxAExUwqxGBILI2qNGcZql
         TiQVKRl8GEN+VL9k5Tq1dPHSB9u9LlUH9c4UPdNwqxdKG5ftiXYofqSfLMGYU6CTpvFM
         gQWvKl7Yg5eOjuPBcpOZ+Z6BmY6yGFf90+bybh/THa6jLGl2GyXE6+JU4+wLMO1fDVZ5
         8Fg7+25heM8Q+4maal3rAJ2NKOdLiobG+AjVSmkrwJ1DqTLKiMpRhUAdP++6BgmmClwX
         o/lPaj4d8lkmn6Y9OOulbEUV8oKYiZHXJRoEy8ZLQAg/HGJ893pZt/48K35+VU4r7YzK
         2CYQ==
X-Received: by 10.60.135.3 with SMTP id po3mr1155077oeb.15.1375797646189;
        Tue, 06 Aug 2013 07:00:46 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231748>

This is complicated slightly by having to remember the previous -L range
for each file specified via -L<range>:file.

The existing implementation coalesces ranges for each file as each -L is
parsed which makes it impossible to refer back to the previous -L range
for any particular file. Re-implement to instead store each file's set
of -L ranges verbatim, and then coalesce the ranges in a post-processing
step.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 line-log.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/line-log.c b/line-log.c
index 38f827b..d40c79d 100644
--- a/line-log.c
+++ b/line-log.c
@@ -291,7 +291,6 @@ static void line_log_data_insert(struct line_log_data **list,
 
 	if (p) {
 		range_set_append_unsafe(&p->ranges, begin, end);
-		sort_and_merge_range_set(&p->ranges);
 		free(path);
 		return;
 	}
@@ -299,7 +298,6 @@ static void line_log_data_insert(struct line_log_data **list,
 	p = xcalloc(1, sizeof(struct line_log_data));
 	p->path = path;
 	range_set_append(&p->ranges, begin, end);
-	sort_and_merge_range_set(&p->ranges);
 	if (ip) {
 		p->next = ip->next;
 		ip->next = p;
@@ -566,12 +564,14 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 	struct nth_line_cb cb_data;
 	struct string_list_item *item;
 	struct line_log_data *ranges = NULL;
+	struct line_log_data *p;
 
 	for_each_string_list_item(item, args) {
 		const char *name_part, *range_part;
 		char *full_name;
 		struct diff_filespec *spec;
 		long begin = 0, end = 0;
+		long anchor;
 
 		name_part = skip_range_arg(item->string);
 		if (!name_part || *name_part != ':' || !name_part[1])
@@ -590,8 +590,14 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 		cb_data.lines = lines;
 		cb_data.line_ends = ends;
 
+		p = search_line_log_data(ranges, full_name, NULL);
+		if (p && p->ranges.nr)
+			anchor = p->ranges.ranges[p->ranges.nr - 1].end + 1;
+		else
+			anchor = 1;
+
 		if (parse_range_arg(range_part, nth_line, &cb_data,
-				    lines, 1, &begin, &end,
+				    lines, anchor, &begin, &end,
 				    full_name))
 			die("malformed -L argument '%s'", range_part);
 		if (lines < end || ((lines || begin) && lines < begin))
@@ -608,6 +614,9 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 		ends = NULL;
 	}
 
+	for (p = ranges; p; p = p->next)
+		sort_and_merge_range_set(&p->ranges);
+
 	return ranges;
 }
 
-- 
1.8.4.rc1.409.gbd48715
