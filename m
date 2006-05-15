From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Tracking branch history
Date: Mon, 15 May 2006 05:53:07 -0400
Message-ID: <20060515095307.GB28337@spearce.org>
References: <20060513071753.GA21998@spearce.org> <20060513074328.GB21998@spearce.org> <Pine.LNX.4.64.0605130815550.3866@g5.osdl.org> <7vbqu1vps3.fsf@assigned-by-dhcp.cox.net> <20060513181816.GA12475@spearce.org> <7vk68o19n4.fsf@assigned-by-dhcp.cox.net> <20060515031511.GA27505@spearce.org> <20060515055830.GC28068@spearce.org> <7vac9jx0nq.fsf@assigned-by-dhcp.cox.net> <20060515063849.GA28337@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 11:53:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfZlS-00035y-Jd
	for gcvg-git@gmane.org; Mon, 15 May 2006 11:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWEOJxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 05:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWEOJxS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 05:53:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48804 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932332AbWEOJxR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 05:53:17 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FfZlH-0008AL-GV; Mon, 15 May 2006 05:53:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DB06C212667; Mon, 15 May 2006 05:53:07 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060515063849.GA28337@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20040>

Shawn Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > Shawn Pearce <spearce@spearce.org> writes:
> > 
> > > This is all well and good but its sort of useless without the diffcore
> > > being able to lookup what SHA1 was valid on a given branch at a given
> > > point in time.  :-)
> > >
> > > I'm thinking about extending the 'extended SHA1' syntax to accept
> > > a date (or date expression) as a suffix:
> > >
> > > 	HEAD@'2 hours ago'
> > > 	HEAD@'2006-04-20'
> > > 	HEAD@'2006-04-20 14:12'
> > >
> > > etc... This would be merged into get_sha1 (sha1_name.c) so its
> > > usable pretty much anywhere.  Does this seem reasonable?  If so
> > > I'll work up a patch for it.

This is a preliminary patch for this syntax.  I haven't handled the
absolute date parsing yet; I was hoping to use the same syntax
accepted by GIT_AUTHOR_DATE/GIT_COMMITTER_DATE but looking at the
code in date.c it wasn't going to be easily reused.  I'll work
on it more tomorrow, right now I have to go do my day job to pay
the rent.  :-)

Hmm... A quick look at date.c indicates I should be able to clean up
this parse_date_spec function quite a bit by using code from date.c.
I'll look at it more later.

-- >8 -
Support 'master@2 hours ago' syntax

Extended sha1 expressions may now include date specifications
which indicate a point in time within the local repository's
history.  If the ref indicated to the left of '@' has a log in
$GIT_DIR/logs/<ref> then the value of the ref at the time indicated
by the specification is obtained from the ref's log.

---

 Documentation/git-rev-parse.txt |    6 ++
 refs.c                          |   52 ++++++++++++++
 refs.h                          |    3 +
 sha1_name.c                     |  145 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 189 insertions(+), 17 deletions(-)

1f16364fd8cadb6cdeb0b14a6f5439f02b578924
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index ab896fc..df308c3 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -124,6 +124,12 @@ syntax.
   happen to have both heads/master and tags/master, you can
   explicitly say 'heads/master' to tell git which one you mean.
 
+* A suffix '@' followed by a date specification such as 'yesterday'
+  (24 hours ago) or '1 month 2 weeks 3 days 1 hour 1 second ago'
+  to specify the value of the ref at a prior point in time.
+  This suffix may only be used immediately following a ref name
+  and the ref must have an existing log ($GIT_DIR/logs/<ref>).
+
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
diff --git a/refs.c b/refs.c
index a50ea8f..da009ac 100644
--- a/refs.c
+++ b/refs.c
@@ -440,3 +440,55 @@ int log_ref_update(const char *ref, cons
 	close(logfd);
 	return 0;
 }
+
+int read_ref_at(const char *ref, unsigned long at_time, unsigned char *sha1)
+{
+	const char *logfile, *logdata, *rec, *c;
+	char *tz_c;
+	int logfd, tz;
+	struct stat st;
+	unsigned long date;
+	unsigned char oldsha1[20];
+
+	logfile = git_path("logs/%s", ref);
+	logfd = open(logfile, O_RDONLY, 0);
+	if (logfd < 0)
+		die("Unable to read log %s: %s", logfile, strerror(errno));
+	fstat(logfd, &st);
+	if (!st.st_size)
+		die("Log %s is empty.", logfile);
+	logdata = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, logfd, 0);
+	close(logfd);
+
+	rec = logdata + st.st_size;
+	while (logdata < rec) {
+		if (logdata < rec && *(rec-1) == '\n')
+			rec--;
+		while (logdata < rec && *(rec-1) != '\n')
+			rec--;
+		c = rec;
+		while (*c++ != '>')
+			/* nada */;
+		date = strtoul(c, NULL, 10);
+		if (date <= at_time) {
+			if (get_sha1_hex(rec, oldsha1))
+				die("Log %s is corrupt.", logfile);
+			if (get_sha1_hex(rec + 41, sha1))
+				die("Log %s is corrupt.", logfile);
+			munmap((void*)logdata, st.st_size);
+			return 0;
+		}
+	}
+
+	c = logdata;
+	while (*c++ != '>')
+		/* nada */;
+	date = strtoul(c, &tz_c, 10);
+	tz = strtoul(tz_c, NULL, 10);
+	if (get_sha1_hex(logdata, sha1))
+		die("Log %s is corrupt.", logfile);
+	munmap((void*)logdata, st.st_size);
+	fprintf(stderr, "warning: Log %s only goes back to %s.\n",
+		logfile, show_rfc2822_date(date, tz));
+	return 0;
+}
diff --git a/refs.h b/refs.h
index de3cb92..4831cdb 100644
--- a/refs.h
+++ b/refs.h
@@ -31,4 +31,7 @@ extern int check_ref_format(const char *
 /** If logging is enabled logs the change made to the ref. **/
 extern int log_ref_update(const char *ref, const unsigned char *currsha1, const unsigned char *newsha1, const char *msg);
 
+/** Reads log for the value of ref during at_time. **/
+extern int read_ref_at(const char *ref, unsigned long at_time, unsigned char *sha1);
+
 #endif /* REFS_H */
diff --git a/sha1_name.c b/sha1_name.c
index dc68355..5f33aea 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -4,6 +4,7 @@ #include "commit.h"
 #include "tree.h"
 #include "blob.h"
 #include "tree-walk.h"
+#include "refs.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -234,6 +235,98 @@ static int ambiguous_path(const char *pa
 	return slash;
 }
 
+static unsigned long parse_date_spec(const char *str, int len)
+{
+	long delta;
+	time_t now;
+
+	time(&now);
+	if (len == 9 && !strncasecmp("yesterday", str, 9))
+		return now - 24 * 60 * 60;
+	if (len > 4 && !strncasecmp(" ago", str + (len - 4), 4)) {
+		len -= 4;
+		while (len) {
+			if (len > 2 && !strncasecmp("a ", str, 2)) {
+				delta = 1;
+				len -= 2;
+				str += 2;
+			}
+			else if (len > 3 && !strncasecmp("an ", str, 3)) {
+				delta = 1;
+				len -= 2;
+				str += 2;
+			} else {
+				delta = 0;
+				while (len && isdigit(*str)) {
+					if (delta)
+						delta *= 10;
+					delta += *str++ - '0';
+					len--;
+				}
+				if (!delta)
+					return (time_t)-1;
+				while (len && isspace(*str)) {
+					str++;
+					len--;
+				}
+			}
+
+			if (len >= 5 && !strncasecmp("month", str, 5)) {
+				len -= 5;
+				str += 5;
+				now -= 30 * 24 * 60 * 60 * delta;
+			}
+			else if (len >= 4 && !strncasecmp("week", str, 4)) {
+				len -= 4;
+				str += 4;
+				now -= 7 * 24 * 60 * 60 * delta;
+			}
+			else if (len >= 3 && !strncasecmp("day", str, 3)) {
+				len -= 3;
+				str += 3;
+				now -= 24 * 60 * 60 * delta;
+			}
+			else if (len >= 4 && !strncasecmp("hour", str, 4)) {
+				len -= 4;
+				str += 4;
+				now -= 60 * 60 * delta;
+			}
+			else if (len >= 6 && !strncasecmp("minute", str, 6)) {
+				len -= 6;
+				str += 6;
+				now -= 60 * delta;
+			}
+			else if (len >= 3 && !strncasecmp("min", str, 3)) {
+				len -= 3;
+				str += 3;
+				now -= 60 * delta;
+			}
+			else if (len >= 6 && !strncasecmp("second", str, 6)) {
+				len -= 6;
+				str += 6;
+				now -= delta;
+			}
+			else if (len >= 3 && !strncasecmp("sec", str, 3)) {
+				len -= 3;
+				str += 3;
+				now -= delta;
+			}
+
+			if (len && *str == 's') {
+				len -= 1;
+				str += 1;
+			}
+
+			while (len && isspace(*str)) {
+				str++;
+				len--;
+			}
+		}
+		return now;
+	}
+	return (time_t)-1;
+}
+
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
 	static const char *fmt[] = {
@@ -245,36 +338,54 @@ static int get_sha1_basic(const char *st
 		"refs/remotes/%.*s/HEAD",
 		NULL
 	};
-	const char **p;
-	const char *warning = "warning: refname '%.*s' is ambiguous.\n";
-	char *pathname;
-	int already_found = 0;
+	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
+	const char **p, *pathname;
+	char *real_path = NULL;
+	int refs_found = 0, at_mark;
+	unsigned long at_time = (unsigned long)-1;
 	unsigned char *this_result;
 	unsigned char sha1_from_ref[20];
 
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
 
+	/* At a given period of time? "@2 hours ago" */
+	for (at_mark = 1; at_mark < len; at_mark++) {
+		if (str[at_mark] == '@') {
+			at_time = parse_date_spec(str + at_mark + 1, len - at_mark - 1);
+			if (at_time == (unsigned long)-1)
+				die("Invalid date spec after @ in '%.*s'", len, str);
+			len = at_mark;
+		}
+	}
+
 	/* Accept only unambiguous ref paths. */
 	if (ambiguous_path(str, len))
 		return -1;
 
 	for (p = fmt; *p; p++) {
-		this_result = already_found ? sha1_from_ref : sha1;
-		pathname = git_path(*p, len, str);
-		if (!read_ref(pathname, this_result)) {
-			if (warn_ambiguous_refs) {
-				if (already_found)
-					fprintf(stderr, warning, len, str);
-				already_found++;
-			}
-			else
-				return 0;
+		this_result = refs_found ? sha1_from_ref : sha1;
+		pathname = resolve_ref(git_path(*p, len, str), this_result, 1);
+		if (pathname) {
+			if (!refs_found++)
+				real_path = strdup(pathname);
+			if (!warn_ambiguous_refs)
+				break;
 		}
 	}
-	if (already_found)
-		return 0;
-	return -1;
+
+	if (!refs_found)
+		return -1;
+
+	if (warn_ambiguous_refs && refs_found > 1)
+		fprintf(stderr, warning, len, str);
+
+	if (at_time != (unsigned long)-1) {
+		read_ref_at(real_path + strlen(git_path(".")) - 1, at_time, sha1);
+	}
+
+	free(real_path);
+	return 0;
 }
 
 static int get_sha1_1(const char *name, int len, unsigned char *sha1);
-- 
1.3.2.g7278
