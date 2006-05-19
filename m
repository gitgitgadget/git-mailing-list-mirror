From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 1/5] General ref log reading improvements.
Date: Fri, 19 May 2006 03:28:19 -0400
Message-ID: <20060519072819.GB22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 09:28:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgzPR-0005Ka-US
	for gcvg-git@gmane.org; Fri, 19 May 2006 09:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWESH2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 03:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWESH2X
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 03:28:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:26563 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751092AbWESH2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 03:28:23 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgzPH-0002hy-JG; Fri, 19 May 2006 03:28:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E04F6212691; Fri, 19 May 2006 03:28:19 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20329>

Corrected the log starting time displayed in the error message
(as it was always showing the epoch due to a bad input to strtoul).

Improved the log parser so we only scan backwards towards the
'\n' from the end of the prior log; during this scan the last '>'
is remembered to improve performance (rather than scanning forward
to it).

If the log record matched is the last log record in the file only
use its new sha1 value if the date matches exactly; otherwise we
leave the passed in sha1 alone as it already contains the current
value of the ref.  This way lookups of dates later than the log
end to stick with the current ref value in case the ref was updated
without logging.

If it looks like someone changed the ref without logging it and we
are going to return the sha1 which should have been valid during
the missing period then warn the user that there might be log data
missing and thus their query result may not be accurate.  The check
isn't perfect as its just based on comparing the old and new sha1
values between the two log records but its better than not checking
at all.

Implemented test cases based on git-rev-parse for most of the
boundary conditions.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 refs.c                |   54 +++++++++++++++++++++++++++++++----------
 t/t1400-update-ref.sh |   64 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 14 deletions(-)
 mode change 100644 => 100755 t/t1400-update-ref.sh

54717d099405378da50cd3d4715c1e5d6d793d68
diff --git a/refs.c b/refs.c
index ae9825d..9d37a02 100644
--- a/refs.c
+++ b/refs.c
@@ -432,11 +432,12 @@ int write_ref_sha1(struct ref_lock *lock
 
 int read_ref_at(const char *ref, unsigned long at_time, unsigned char *sha1)
 {
-	const char *logfile, *logdata, *logend, *rec, *c;
+	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
 	char *tz_c;
 	int logfd, tz;
 	struct stat st;
 	unsigned long date;
+	unsigned char logged_sha1[20];
 
 	logfile = git_path("logs/%s", ref);
 	logfd = open(logfile, O_RDONLY, 0);
@@ -448,32 +449,57 @@ int read_ref_at(const char *ref, unsigne
 	logdata = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, logfd, 0);
 	close(logfd);
 
+	lastrec = NULL;
 	rec = logend = logdata + st.st_size;
 	while (logdata < rec) {
 		if (logdata < rec && *(rec-1) == '\n')
 			rec--;
-		while (logdata < rec && *(rec-1) != '\n')
+		lastgt = NULL;
+		while (logdata < rec && *(rec-1) != '\n') {
 			rec--;
-		c = rec;
-		while (c < logend && *c != '>' && *c != '\n')
-			c++;
-		if (c == logend || *c == '\n')
+			if (*rec == '>')
+				lastgt = rec;
+		}
+		if (!lastgt)
 			die("Log %s is corrupt.", logfile);
-		date = strtoul(c + 1, NULL, 10);
+		date = strtoul(lastgt + 1, &tz_c, 10);
 		if (date <= at_time) {
-			if (get_sha1_hex(rec + 41, sha1))
-				die("Log %s is corrupt.", logfile);
+			if (lastrec) {
+				if (get_sha1_hex(lastrec, logged_sha1))
+					die("Log %s is corrupt.", logfile);
+				if (get_sha1_hex(rec + 41, sha1))
+					die("Log %s is corrupt.", logfile);
+				if (memcmp(logged_sha1, sha1, 20)) {
+					tz = strtoul(tz_c, NULL, 10);
+					fprintf(stderr,
+						"warning: Log %s has gap after %s.\n",
+						logfile, show_rfc2822_date(date, tz));
+				}
+			} else if (date == at_time) {
+				if (get_sha1_hex(rec + 41, sha1))
+					die("Log %s is corrupt.", logfile);
+			} else {
+				if (get_sha1_hex(rec + 41, logged_sha1))
+					die("Log %s is corrupt.", logfile);
+				if (memcmp(logged_sha1, sha1, 20)) {
+					tz = strtoul(tz_c, NULL, 10);
+					fprintf(stderr,
+						"warning: Log %s unexpectedly ended on %s.\n",
+						logfile, show_rfc2822_date(date, tz));
+				}
+			}
 			munmap((void*)logdata, st.st_size);
 			return 0;
 		}
+		lastrec = rec;
 	}
 
-	c = logdata;
-	while (c < logend && *c != '>' && *c != '\n')
-		c++;
-	if (c == logend || *c == '\n')
+	rec = logdata;
+	while (rec < logend && *rec != '>' && *rec != '\n')
+		rec++;
+	if (rec == logend || *rec == '\n')
 		die("Log %s is corrupt.", logfile);
-	date = strtoul(c, &tz_c, 10);
+	date = strtoul(rec + 1, &tz_c, 10);
 	tz = strtoul(tz_c, NULL, 10);
 	if (get_sha1_hex(logdata, sha1))
 		die("Log %s is corrupt.", logfile);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
old mode 100644
new mode 100755
index f338c53..7858d86
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -9,6 +9,10 @@ test_description='Test git-update-ref an
 Z=0000000000000000000000000000000000000000
 A=1111111111111111111111111111111111111111
 B=2222222222222222222222222222222222222222
+C=3333333333333333333333333333333333333333
+D=4444444444444444444444444444444444444444
+E=5555555555555555555555555555555555555555
+F=6666666666666666666666666666666666666666
 m=refs/heads/master
 
 test_expect_success \
@@ -109,4 +113,64 @@ test_expect_success \
 	'diff expect .git/logs/$m'
 rm -f .git/$m .git/logs/$m expect
 
+git-update-ref $m $D
+cat >.git/logs/$m <<EOF
+$C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
+$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
+$F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
+$Z $E $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 -0500
+EOF
+
+ed="Thu, 26 May 2005 18:32:00 -0500"
+gd="Thu, 26 May 2005 18:33:00 -0500"
+ld="Thu, 26 May 2005 18:43:00 -0500"
+test_expect_success \
+	'Query "master@May 25 2005" (before history)' \
+	'rm -f o e
+	 git-rev-parse --verify "master@May 25 2005" >o 2>e &&
+	 test $C = $(cat o) &&
+	 test "warning: Log .git/logs/$m only goes back to $ed." = "$(cat e)"'
+test_expect_success \
+	"Query master@2005-05-25 (before history)" \
+	'rm -f o e
+	 git-rev-parse --verify master@2005-05-25 >o 2>e &&
+	 test $C = $(cat o) &&
+	 echo test "warning: Log .git/logs/$m only goes back to $ed." = "$(cat e)"'
+test_expect_success \
+	'Query "master@May 26 2005 23:31:59" (1 second before history)' \
+	'rm -f o e
+	 git-rev-parse --verify "master@May 26 2005 23:31:59" >o 2>e &&
+	 test $C = $(cat o) &&
+	 test "warning: Log .git/logs/$m only goes back to $ed." = "$(cat e)"'
+test_expect_success \
+	'Query "master@May 26 2005 23:32:00" (exactly history start)' \
+	'rm -f o e
+	 git-rev-parse --verify "master@May 26 2005 23:32:00" >o 2>e &&
+	 test $A = $(cat o) &&
+	 test "" = "$(cat e)"'
+test_expect_success \
+	'Query "master@2005-05-26 23:33:01" (middle of history with gap)' \
+	'rm -f o e
+	 git-rev-parse --verify "master@2005-05-26 23:33:01" >o 2>e &&
+	 test $B = $(cat o) &&
+	 test "warning: Log .git/logs/$m has gap after $gd." = "$(cat e)"'
+test_expect_success \
+	'Query "master@2005-05-26 23:33:01" (middle of history)' \
+	'rm -f o e
+	 git-rev-parse --verify "master@2005-05-26 23:38:00" >o 2>e &&
+	 test $Z = $(cat o) &&
+	 test "" = "$(cat e)"'
+test_expect_success \
+	'Query "master@2005-05-26 23:43:00" (exact end of history)' \
+	'rm -f o e
+	 git-rev-parse --verify "master@2005-05-26 23:43:00" >o 2>e &&
+	 test $E = $(cat o) &&
+	 test "" = "$(cat e)"'
+test_expect_success \
+	'Query "master@2005-05-28" (past end of history)' \
+	'rm -f o e
+	 git-rev-parse --verify "master@2005-05-28" >o 2>e &&
+	 test $D = $(cat o) &&
+	 test "warning: Log .git/logs/$m unexpectedly ended on $ld." = "$(cat e)"'
+
 test_done
-- 
1.3.2.g7278
