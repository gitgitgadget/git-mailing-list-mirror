From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC 5/5] Support 'master@2 hours ago' syntax
Date: Wed, 17 May 2006 05:56:09 -0400
Message-ID: <20060517095609.GF28529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 17 11:56:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgIlc-0004cQ-Vf
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWEQJ4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWEQJ4N
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:56:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:209 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750782AbWEQJ4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:56:12 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgIlD-0000xC-Pn
	for git@vger.kernel.org; Wed, 17 May 2006 05:56:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 20241212667; Wed, 17 May 2006 05:56:09 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20184>

Extended sha1 expressions may now include date specifications
which indicate a point in time within the local repository's
history.  If the ref indicated to the left of '@' has a log in
$GIT_DIR/logs/<ref> then the value of the ref at the time indicated
by the specification is obtained from the ref's log.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 Documentation/git-rev-parse.txt |    6 ++++
 refs.c                          |   53 +++++++++++++++++++++++++++++++++++
 refs.h                          |    3 ++
 sha1_name.c                     |   59 ++++++++++++++++++++++++++++-----------
 4 files changed, 104 insertions(+), 17 deletions(-)

efffa32e4896acd7978767b6a856fc7421060040
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
index 4be75a5..4c99e37 100644
--- a/refs.c
+++ b/refs.c
@@ -429,3 +429,56 @@ int write_ref_sha1(struct ref_lock *lock
 	unlock_ref(lock);
 	return 0;
 }
+
+int read_ref_at(const char *ref, unsigned long at_time, unsigned char *sha1)
+{
+	const char *logfile, *logdata, *logend, *rec, *c;
+	char *tz_c;
+	int logfd, tz;
+	struct stat st;
+	unsigned long date;
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
+	rec = logend = logdata + st.st_size;
+	while (logdata < rec) {
+		if (logdata < rec && *(rec-1) == '\n')
+			rec--;
+		while (logdata < rec && *(rec-1) != '\n')
+			rec--;
+		c = rec;
+		while (c < logend && *c != '>' && *c != '\n')
+			c++;
+		if (c == logend || *c == '\n')
+			die("Log %s is corrupt.", logfile);
+		date = strtoul(c, NULL, 10);
+		if (date <= at_time) {
+			if (get_sha1_hex(rec + 41, sha1))
+				die("Log %s is corrupt.", logfile);
+			munmap((void*)logdata, st.st_size);
+			return 0;
+		}
+	}
+
+	c = logdata;
+	while (c < logend && *c != '>' && *c != '\n')
+		c++;
+	if (c == logend || *c == '\n')
+		die("Log %s is corrupt.", logfile);
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
index 43831e9..2c854de 100644
--- a/refs.h
+++ b/refs.h
@@ -34,6 +34,9 @@ extern void unlock_ref (struct ref_lock 
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
+/** Reads log for the value of ref during at_time. **/
+extern int read_ref_at(const char *ref, unsigned long at_time, unsigned char *sha1);
+
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
 
diff --git a/sha1_name.c b/sha1_name.c
index dc68355..3ac3ab4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -4,6 +4,7 @@ #include "commit.h"
 #include "tree.h"
 #include "blob.h"
 #include "tree-walk.h"
+#include "refs.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -245,36 +246,60 @@ static int get_sha1_basic(const char *st
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
+			int date_len = len - at_mark - 1;
+			char *date_spec = xmalloc(date_len + 1);
+			strncpy(date_spec, str + at_mark + 1, date_len);
+			date_spec[date_len] = 0;
+			at_time = approxidate(date_spec);
+			free(date_spec);
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
+		read_ref_at(
+			real_path + strlen(git_path(".")) - 1,
+			at_time,
+			sha1);
+	}
+
+	free(real_path);
+	return 0;
 }
 
 static int get_sha1_1(const char *name, int len, unsigned char *sha1);
-- 
1.3.2.g7278
