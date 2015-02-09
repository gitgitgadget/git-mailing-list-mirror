From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] builtin/blame: destroy initialized commit_info only
Date: Mon,  9 Feb 2015 16:28:07 -0500
Message-ID: <1423517287-8354-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Dilyan Palauzov <dilyan.palauzov@aegee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 22:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvsn-0000hS-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761312AbbBIV2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:28:37 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:47671 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761201AbbBIV2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:28:36 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so19551699igk.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 13:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=M4P/Sbm4Km8Bxvw8SdM8EEOxU5v/zmgdY5w6Pxj7QG4=;
        b=0kCH8/+sRtqoA7BBvlxFLvGk6rJWsCY6yjAzCrERxdgXSRhJwvPf+YuTNJbsX3iUoW
         Z1AT7VqkEX6Klq35aw+vSIN7uF9JO8tRqTGoLmkmIdqcaWe0SxHQPMCCGgJuwBifS/Iv
         AhRH/AOnXSoJByvtpEfqn9OxEOkaKXk/HhQ1I0D6XeC65pkgWAqBJGO7ro9b5stNs8+G
         edRiatlgiB7lQhyO5PbyTXhYtsc72xW3YZofW1Ja3uiPDANnLEPZUOAt6vrnW9dZMnDy
         a0C4NW5U1NdzdwCy8gkPcHq3pYv/mKyLwH7kvBqf+KineX2lozIKOFJCzb7Py8X2ET0s
         VMjw==
X-Received: by 10.43.78.196 with SMTP id zn4mr962319icb.81.1423517315931;
        Mon, 09 Feb 2015 13:28:35 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id k35sm7166319iod.5.2015.02.09.13.28.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Feb 2015 13:28:35 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc2.191.g303d43c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263603>

Since ea02ffa3 (mailmap: simplify map_user() interface, 2013-01-05),
find_alignment() has been invoking commit_info_destroy() on an
uninitialized auto 'struct commit_info' (when METAINFO_SHOWN is not
set). commit_info_destroy() calls strbuf_release() for each of
'commit_info' strbuf member, which randomly invokes free() on whatever
random stack value happens to be reside in strbuf.buf, thus leading to
periodic crashes.

Reported-by: Dilyan Palauzov <dilyan.palauzov@aegee.org>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No test accompanying this fix since I don't know how to formulate one.

Discussion: http://thread.gmane.org/gmane.comp.version-control.git/263534

 builtin/blame.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 303e217..a3cc972 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2085,7 +2085,6 @@ static void find_alignment(struct scoreboard *sb, int *option)
 
 	for (e = sb->ent; e; e = e->next) {
 		struct origin *suspect = e->suspect;
-		struct commit_info ci;
 		int num;
 
 		if (compute_auto_abbrev)
@@ -2096,6 +2095,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		if (longest_file < num)
 			longest_file = num;
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
+			struct commit_info ci;
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
 			if (*option & OUTPUT_SHOW_EMAIL)
@@ -2104,6 +2104,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 				num = utf8_strwidth(ci.author.buf);
 			if (longest_author < num)
 				longest_author = num;
+			commit_info_destroy(&ci);
 		}
 		num = e->s_lno + e->num_lines;
 		if (longest_src_lines < num)
@@ -2113,8 +2114,6 @@ static void find_alignment(struct scoreboard *sb, int *option)
 			longest_dst_lines = num;
 		if (largest_score < ent_score(sb, e))
 			largest_score = ent_score(sb, e);
-
-		commit_info_destroy(&ci);
 	}
 	max_orig_digits = decimal_width(longest_src_lines);
 	max_digits = decimal_width(longest_dst_lines);
-- 
2.3.0.rc2.191.g303d43c
