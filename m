From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Add --relative-date option to the revision interface
Date: Mon, 28 Aug 2006 15:52:13 +0200
Message-ID: <20060828135213.GB32266@diku.dk>
References: <7vodu5qqd3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 15:53:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHhXc-0001pg-TG
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 15:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWH1Nw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 09:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWH1Nw2
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 09:52:28 -0400
Received: from [130.225.96.91] ([130.225.96.91]:7052 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750819AbWH1Nw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 09:52:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id F1BF2770032;
	Mon, 28 Aug 2006 15:52:14 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20691-03; Mon, 28 Aug 2006 15:52:13 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 39202770005;
	Mon, 28 Aug 2006 15:52:13 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A00886DF893; Mon, 28 Aug 2006 15:50:50 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2476F62A01; Mon, 28 Aug 2006 15:52:13 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodu5qqd3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26157>

Exposes the infrastructure from 9a8e35e98793af086f05d1ca9643052df9b44a74.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

Junio C Hamano <junkio@cox.net> wrote Mon, Aug 28, 2006:
>   - The internal is readied to be able to say "32 hours ago" in
>     "git log" and friends by Linus; we do not have an UI to
>     enable it yet.

Since nobody else has posted a patch, here is one.

 Documentation/git-rev-list.txt |    5 +++++
 builtin-rev-list.c             |    2 +-
 builtin-show-branch.c          |    2 +-
 commit.c                       |   20 ++++++++++++++------
 commit.h                       |    2 +-
 log-tree.c                     |    4 +++-
 revision.c                     |    4 ++++
 revision.h                     |    3 ++-
 8 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index dd9fff1..a446a6b 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -128,6 +128,11 @@ OPTIONS
 	After a failed merge, show refs that touch files having a
 	conflict and don't exist on all heads to merge.
 
+--relative-date::
+	Show dates relative to the current time, e.g. "2 hours ago".
+	Only takes effect for dates shown in human-readable format,
+	such as when using "--pretty".
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index bc48a3e..ac648e9 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -85,7 +85,7 @@ static void show_commit(struct commit *c
 		static char pretty_header[16384];
 		pretty_print_commit(revs.commit_format, commit, ~0,
 				    pretty_header, sizeof(pretty_header),
-				    revs.abbrev, NULL, NULL);
+				    revs.abbrev, NULL, NULL, revs.relative_date);
 		printf("%s%c", pretty_header, hdr_termination);
 	}
 	fflush(stdout);
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 18786f8..d7de18e 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -261,7 +261,7 @@ static void show_one_commit(struct commi
 	struct commit_name *name = commit->util;
 	if (commit->object.parsed)
 		pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-				    pretty, sizeof(pretty), 0, NULL, NULL);
+				    pretty, sizeof(pretty), 0, NULL, NULL, 0);
 	else
 		strcpy(pretty, "(unavailable)");
 	if (!strncmp(pretty, "[PATCH] ", 8))
diff --git a/commit.c b/commit.c
index 307883f..3f4bc31 100644
--- a/commit.c
+++ b/commit.c
@@ -482,7 +482,8 @@ static int add_rfc2047(char *buf, const 
 	return bp - buf;
 }
 
-static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf, const char *line)
+static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
+			 const char *line, int relative_date)
 {
 	char *date;
 	int namelen;
@@ -522,14 +523,16 @@ static int add_user_info(const char *wha
 	}
 	switch (fmt) {
 	case CMIT_FMT_MEDIUM:
-		ret += sprintf(buf + ret, "Date:   %s\n", show_date(time, tz, 0));
+		ret += sprintf(buf + ret, "Date:   %s\n",
+			       show_date(time, tz, relative_date));
 		break;
 	case CMIT_FMT_EMAIL:
 		ret += sprintf(buf + ret, "Date: %s\n",
 			       show_rfc2822_date(time, tz));
 		break;
 	case CMIT_FMT_FULLER:
-		ret += sprintf(buf + ret, "%sDate: %s\n", what, show_date(time, tz, 0));
+		ret += sprintf(buf + ret, "%sDate: %s\n", what,
+			       show_date(time, tz, relative_date));
 		break;
 	default:
 		/* notin' */
@@ -572,7 +575,10 @@ static int add_merge_info(enum cmit_fmt 
 	return offset;
 }
 
-unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject, const char *after_subject)
+unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
+				  unsigned long len, char *buf, unsigned long space,
+				  int abbrev, const char *subject,
+				  const char *after_subject, int relative_date)
 {
 	int hdr = 1, body = 0;
 	unsigned long offset = 0;
@@ -661,12 +667,14 @@ unsigned long pretty_print_commit(enum c
 			if (!memcmp(line, "author ", 7))
 				offset += add_user_info("Author", fmt,
 							buf + offset,
-							line + 7);
+							line + 7,
+							relative_date);
 			if (!memcmp(line, "committer ", 10) &&
 			    (fmt == CMIT_FMT_FULL || fmt == CMIT_FMT_FULLER))
 				offset += add_user_info("Commit", fmt,
 							buf + offset,
-							line + 10);
+							line + 10,
+							relative_date);
 			continue;
 		}
 
diff --git a/commit.h b/commit.h
index 779ed82..fc13de9 100644
--- a/commit.h
+++ b/commit.h
@@ -52,7 +52,7 @@ enum cmit_fmt {
 };
 
 extern enum cmit_fmt get_commit_format(const char *arg);
-extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject, const char *after_subject);
+extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject, const char *after_subject, int relative_date);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/log-tree.c b/log-tree.c
index 031af88..54cdaa4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -194,7 +194,9 @@ void show_log(struct rev_info *opt, cons
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev, subject, extra_headers);
+	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header,
+				  sizeof(this_header), abbrev, subject,
+				  extra_headers, opt->relative_date);
 
 	if (opt->add_signoff)
 		len = append_signoff(this_header, sizeof(this_header), len,
diff --git a/revision.c b/revision.c
index 1d89d72..b588f74 100644
--- a/revision.c
+++ b/revision.c
@@ -816,6 +816,10 @@ int setup_revisions(int argc, const char
 				revs->simplify_history = 0;
 				continue;
 			}
+			if (!strcmp(arg, "--relative-date")) {
+				revs->relative_date = 1;
+				continue;
+			}
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
 				revs->diff = 1;
diff --git a/revision.h b/revision.h
index 0c3b8d9..d289781 100644
--- a/revision.h
+++ b/revision.h
@@ -55,7 +55,8 @@ struct rev_info {
 
 	/* Format info */
 	unsigned int	shown_one:1,
-			abbrev_commit:1;
+			abbrev_commit:1,
+			relative_date:1;
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
 	struct log_info *loginfo;
-- 
1.4.2.g6e47-dirty

-- 
Jonas Fonseca
