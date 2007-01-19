From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] Extend read_ref_at() to be usable from places other than sha1_name.
Date: Fri, 19 Jan 2007 15:51:06 -0800
Message-ID: <7vodoud191.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 20 00:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H83Vv-00040z-9W
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 00:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbXASXvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 18:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXASXvK
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 18:51:10 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49214 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932873AbXASXvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 18:51:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119235107.LPH29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 18:51:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DBrQ1W00M1kojtg0000000; Fri, 19 Jan 2007 18:51:24 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37220>

You can pass an extra argument to the function to receive the
reflog message information.  Also when the log does not go back
beyond the point the user asked, the cut-off time and count are
given back to the caller for emitting the error messages as
appropriately.

We could later add configuration for get_sha1_basic() to make it
an error instead of it being just a warning.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 refs.c                |   41 +++++++++++++++++++++++++++++++++--------
 refs.h                |    2 +-
 sha1_name.c           |   16 +++++++++++++++-
 t/t1400-update-ref.sh |    6 +++---
 4 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 6310cf4..60375a7 100644
--- a/refs.c
+++ b/refs.c
@@ -1017,7 +1017,21 @@ int write_ref_sha1(struct ref_lock *lock,
 	return 0;
 }
 
-int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1)
+static char *ref_msg(const char *line, const char *endp)
+{
+	const char *ep;
+	char *msg;
+
+	line += 82;
+	for (ep = line; ep < endp && *ep != '\n'; ep++)
+		;
+	msg = xmalloc(ep - line + 1);
+	memcpy(msg, line, ep - line);
+	msg[ep - line] = 0;
+	return msg;
+}
+
+int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
 	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
 	char *tz_c;
@@ -1054,6 +1068,14 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 			die("Log %s is corrupt.", logfile);
 		date = strtoul(lastgt + 1, &tz_c, 10);
 		if (date <= at_time || cnt == 0) {
+			if (msg)
+				*msg = ref_msg(rec, logend);
+			if (cutoff_time)
+				*cutoff_time = date;
+			if (cutoff_tz)
+				*cutoff_tz = tz;
+			if (cutoff_cnt)
+				*cutoff_cnt = reccnt;
 			if (lastrec) {
 				if (get_sha1_hex(lastrec, logged_sha1))
 					die("Log %s is corrupt.", logfile);
@@ -1097,14 +1119,17 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	tz = strtoul(tz_c, NULL, 10);
 	if (get_sha1_hex(logdata, sha1))
 		die("Log %s is corrupt.", logfile);
+	if (msg)
+		*msg = ref_msg(logdata, logend);
 	munmap(log_mapped, st.st_size);
-	if (at_time)
-		fprintf(stderr, "warning: Log %s only goes back to %s.\n",
-			logfile, show_rfc2822_date(date, tz));
-	else
-		fprintf(stderr, "warning: Log %s only has %d entries.\n",
-			logfile, reccnt);
-	return 0;
+
+	if (cutoff_time)
+		*cutoff_time = date;
+	if (cutoff_tz)
+		*cutoff_tz = tz;
+	if (cutoff_cnt)
+		*cutoff_cnt = reccnt;
+	return 1;
 }
 
 int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index 0e877e8..33450f1 100644
--- a/refs.h
+++ b/refs.h
@@ -42,7 +42,7 @@ extern void unlock_ref(struct ref_lock *lock);
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1);
+extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
diff --git a/sha1_name.c b/sha1_name.c
index ae31851..9dfb3ac 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -304,6 +304,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		/* Is it asking for N-th entry, or approxidate? */
 		int nth, i;
 		unsigned long at_time;
+		unsigned long co_time;
+		int co_tz, co_cnt;
+
 		for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
 			char ch = str[at+2+i];
 			if ('0' <= ch && ch <= '9')
@@ -315,7 +318,18 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 			at_time = 0;
 		else
 			at_time = approxidate(str + at + 2);
-		read_ref_at(real_ref, at_time, nth, sha1);
+		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
+				&co_time, &co_tz, &co_cnt)) {
+			if (at_time)
+				fprintf(stderr,
+					"warning: Log for '%.*s' only goes "
+					"back to %s.\n", len, str,
+					show_rfc2822_date(co_time, co_tz));
+			else
+				fprintf(stderr,
+					"warning: Log for '%.*s' only has "
+					"%d entries.\n", len, str, co_cnt);
+		}
 	}
 
 	free(real_ref);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 5637cb5..e48e2b7 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -138,19 +138,19 @@ test_expect_success \
 	'rm -f o e
 	 git-rev-parse --verify "master@{May 25 2005}" >o 2>e &&
 	 test '"$C"' = $(cat o) &&
-	 test "warning: Log .git/logs/'"$m only goes back to $ed"'." = "$(cat e)"'
+	 test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
 test_expect_success \
 	"Query master@{2005-05-25} (before history)" \
 	'rm -f o e
 	 git-rev-parse --verify master@{2005-05-25} >o 2>e &&
 	 test '"$C"' = $(cat o) &&
-	 echo test "warning: Log .git/logs/'"$m only goes back to $ed"'." = "$(cat e)"'
+	 echo test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
 test_expect_success \
 	'Query "master@{May 26 2005 23:31:59}" (1 second before history)' \
 	'rm -f o e
 	 git-rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
 	 test '"$C"' = $(cat o) &&
-	 test "warning: Log .git/logs/'"$m only goes back to $ed"'." = "$(cat e)"'
+	 test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"'
 test_expect_success \
 	'Query "master@{May 26 2005 23:32:00}" (exactly history start)' \
 	'rm -f o e
-- 
1.5.0.rc1.gcb48c
