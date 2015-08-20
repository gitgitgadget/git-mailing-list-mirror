From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] log: show merge commit when --cc is given
Date: Thu, 20 Aug 2015 15:43:11 -0700
Message-ID: <1440110591-12941-4-git-send-email-gitster@pobox.com>
References: <1440110591-12941-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 00:43:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSYYT-0002mX-8f
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 00:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbbHTWnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 18:43:17 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33261 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbHTWnP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 18:43:15 -0400
Received: by padfo6 with SMTP id fo6so31771446pad.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=A5Rh+HrQ/7+LV6TRjobYbYXSlGhzsGynYYp9JMeoypY=;
        b=PU1qJIIq8o8JhcWjP92nuq6GTM7gWVJVgO0rPv8FAexZMO/J71HCTU/fVqpphpc2EZ
         Ryr1TL+anGL5p1ONMqhcXiGltzdBKwUOpkUVIGZIwiT/6Z06z8+bBD3w5LiG+36oM/So
         yIGC3dvq+2g1JmOhQs/h/rACFdBtRc/kftAnwKi0+FB/zBuemzjguhTCcgHDkZKr6cb4
         q8QnQCYioMXwMWx++/ZAGe6Gp/ACQFmuTAwB6zQ7S5NZOUt6PKD4ydXGoRdRkiXWgtEm
         6cpjrFJKSDFLc9OBGV7fIo9Nj4mmoPSP1HypgbHbc0xGY8lUHzgXjc6y/CoypNNhHeYB
         OExQ==
X-Received: by 10.66.230.201 with SMTP id ta9mr10822139pac.95.1440110595366;
        Thu, 20 Aug 2015 15:43:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id cn8sm5502409pac.7.2015.08.20.15.43.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 15:43:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-546-gb1bbc0d
In-Reply-To: <1440110591-12941-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276271>

We defaulted to ignoring merge diffs because long long ago, in a
galaxy far away, we didn't have a great way to show the diffs.  The
whole "--cc" option goes back to January '06 and commit d8f4790e6fe7
("diff-tree --cc: denser combined diff output for a merge commit").
And before that option - so for about 8 months - we had no good way
to show the diffs of merges in a good dense way.  So the whole
"don't show diffs for merges by default" actually made a lot of
sense originally, because our merge diffs were not very useful.

And this was carried forward to this day.  "git log --cc" still
ignores merge commits, and you need to say "git log -m --cc" to view
a sensible rendition of merge and non-merge commits, even with the
previous change to make "--cc" imply "-p".

Teach "git log" that "--cc" means the user wants to see interesting
changes in merge commits by turning "-m" on.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index e37c27a..0cdd889 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -637,6 +637,10 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	/* Turn --cc/-c into -p --cc/-c when -p was not given */
 	if (!rev->diffopt.output_format && rev->combine_merges)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
+
+	/* Turn -m on when --cc/-c was given */
+	if (rev->combine_merges)
+		rev->ignore_merges = 0;
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
-- 
2.5.0-546-gb1bbc0d
