From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add --pretty=fuller
Date: Wed, 09 Nov 2005 22:16:34 -0800
Message-ID: <7vzmod58ot.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 10 07:17:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea5jp-0006vf-SP
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 07:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVKJGQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 01:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVKJGQh
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 01:16:37 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:48603 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751120AbVKJGQg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 01:16:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110061637.OOZB9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 01:16:37 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11464>

git log without --pretty showed author and author-date, while
with --pretty=full showed author and committer but no dates.
The new formatting option, --pretty=fuller, shows both name and
timestamp for author and committer.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * again, likes, dislikes, don't-cares?

 commit.c |   37 ++++++++++++++++++++++++++++++-------
 commit.h |    1 +
 2 files changed, 31 insertions(+), 7 deletions(-)

applies-to: 6466c53ae80cddbb581c5fdb2332f9321fade867
2155be5980310bac027d4719458e9f5d5975c334
diff --git a/commit.c b/commit.c
index a8c9bfc..534c03e 100644
--- a/commit.c
+++ b/commit.c
@@ -34,6 +34,8 @@ enum cmit_fmt get_commit_format(const ch
 		return CMIT_FMT_SHORT;
 	if (!strcmp(arg, "=full"))
 		return CMIT_FMT_FULL;
+	if (!strcmp(arg, "=fuller"))
+		return CMIT_FMT_FULLER;
 	if (!strcmp(arg, "=oneline"))
 		return CMIT_FMT_ONELINE;
 	die("invalid --pretty format");
@@ -361,6 +363,7 @@ static int add_user_info(const char *wha
 	int namelen;
 	unsigned long time;
 	int tz, ret;
+	const char *filler = "    ";
 
 	if (fmt == CMIT_FMT_ONELINE)
 		return 0;
@@ -371,9 +374,20 @@ static int add_user_info(const char *wha
 	time = strtoul(date, &date, 10);
 	tz = strtol(date, NULL, 10);
 
-	ret = sprintf(buf, "%s: %.*s\n", what, namelen, line);
-	if (fmt == CMIT_FMT_MEDIUM)
+	ret = sprintf(buf, "%s: %.*s%.*s\n", what,
+		      (fmt == CMIT_FMT_FULLER) ? 4 : 0,
+		      filler, namelen, line);
+	switch (fmt) {
+	case CMIT_FMT_MEDIUM:
 		ret += sprintf(buf + ret, "Date:   %s\n", show_date(time, tz));
+		break;
+	case CMIT_FMT_FULLER:
+		ret += sprintf(buf + ret, "%sDate: %s\n", what, show_date(time, tz));
+		break;
+	default:
+		/* notin' */
+		break;
+	}
 	return ret;
 }
 
@@ -448,12 +462,21 @@ unsigned long pretty_print_commit(enum c
 					die("bad parent line in commit");
 				offset += add_parent_info(fmt, buf + offset, line, ++parents);
 			}
+
+			/*
+			 * MEDIUM == DEFAULT shows only author with dates.
+			 * FULL shows both authors but not dates.
+			 * FULLER shows both authors and dates.
+			 */
 			if (!memcmp(line, "author ", 7))
-				offset += add_user_info("Author", fmt, buf + offset, line + 7);
-			if (fmt == CMIT_FMT_FULL) {
-				if (!memcmp(line, "committer ", 10))
-					offset += add_user_info("Commit", fmt, buf + offset, line + 10);
-			}
+				offset += add_user_info("Author", fmt,
+							buf + offset,
+							line + 7);
+			if (!memcmp(line, "committer ", 10) &&
+			    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER))
+				offset += add_user_info("Commit", fmt,
+							buf + offset,
+							line + 10);
 			continue;
 		}
 
diff --git a/commit.h b/commit.h
index 30702ca..6738a69 100644
--- a/commit.h
+++ b/commit.h
@@ -43,6 +43,7 @@ enum cmit_fmt {
 	CMIT_FMT_DEFAULT = CMIT_FMT_MEDIUM,
 	CMIT_FMT_SHORT,
 	CMIT_FMT_FULL,
+	CMIT_FMT_FULLER,
 	CMIT_FMT_ONELINE,
 };
 
---
0.99.9.GIT
