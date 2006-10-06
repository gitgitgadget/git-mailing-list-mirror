From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ref-log: allow ref@{count} syntax.
Date: Thu, 05 Oct 2006 23:16:15 -0700
Message-ID: <7vsli20y1c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 08:16:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVj0N-0004PE-S3
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 08:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWJFGQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 02:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWJFGQR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 02:16:17 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53502 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932629AbWJFGQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 02:16:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061006061615.KRZM21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Fri, 6 Oct 2006 02:16:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WuGJ1V0051kojtg0000000
	Fri, 06 Oct 2006 02:16:18 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28387>

Often I find myself wanting to say 'tip of "next" before I
merged the last three topics'.  Now I can say that with:

	git log next@{3}..next

Since small integers alone are invalid input strings to
approxidate, there is no fear of confusion.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * The implementation is rather hacky but I think this is
   mildly useful.  Likes, dislikes?

 refs.c      |    6 ++++--
 refs.h      |    2 +-
 sha1_name.c |   44 +++++++++++++++++++++++++++-----------------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index 305c1a9..d7f4aa5 100644
--- a/refs.c
+++ b/refs.c
@@ -795,7 +795,7 @@ int write_ref_sha1(struct ref_lock *lock
 	return 0;
 }
 
-int read_ref_at(const char *ref, unsigned long at_time, unsigned char *sha1)
+int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1)
 {
 	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
 	char *tz_c;
@@ -828,7 +828,7 @@ int read_ref_at(const char *ref, unsigne
 		if (!lastgt)
 			die("Log %s is corrupt.", logfile);
 		date = strtoul(lastgt + 1, &tz_c, 10);
-		if (date <= at_time) {
+		if (date <= at_time || cnt == 0) {
 			if (lastrec) {
 				if (get_sha1_hex(lastrec, logged_sha1))
 					die("Log %s is corrupt.", logfile);
@@ -859,6 +859,8 @@ int read_ref_at(const char *ref, unsigne
 			return 0;
 		}
 		lastrec = rec;
+		if (cnt > 0)
+			cnt--;
 	}
 
 	rec = logdata;
diff --git a/refs.h b/refs.h
index 0d4d79e..a57d437 100644
--- a/refs.h
+++ b/refs.h
@@ -39,7 +39,7 @@ extern void unlock_ref(struct ref_lock *
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *ref, unsigned long at_time, unsigned char *sha1);
+extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1);
 
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
diff --git a/sha1_name.c b/sha1_name.c
index ed711f2..e517033 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -249,24 +249,23 @@ static int get_sha1_basic(const char *st
 	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
 	const char **p, *ref;
 	char *real_ref = NULL;
-	int refs_found = 0, am;
-	unsigned long at_time = (unsigned long)-1;
+	int refs_found = 0;
+	int at, reflog_len;
 	unsigned char *this_result;
 	unsigned char sha1_from_ref[20];
 
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
 
-	/* At a given period of time? "@{2 hours ago}" */
-	for (am = 1; am < len - 1; am++) {
-		if (str[am] == '@' && str[am+1] == '{' && str[len-1] == '}') {
-			int date_len = len - am - 3;
-			char *date_spec = xmalloc(date_len + 1);
-			strlcpy(date_spec, str + am + 2, date_len + 1);
-			at_time = approxidate(date_spec);
-			free(date_spec);
-			len = am;
-			break;
+	/* basic@{time or number} format to query ref-log */
+	reflog_len = 0;
+	if (str[len-1] == '}') {
+		for (at = 1; at < len - 1; at++) {
+			if (str[at] == '@' && str[at+1] == '{') {
+				reflog_len = (len-1) - (at+2);
+				len = at;
+				break;
+			}
 		}
 	}
 
@@ -291,11 +290,22 @@ static int get_sha1_basic(const char *st
 	if (warn_ambiguous_refs && refs_found > 1)
 		fprintf(stderr, warning, len, str);
 
-	if (at_time != (unsigned long)-1) {
-		read_ref_at(
-			real_ref,
-			at_time,
-			sha1);
+	if (reflog_len) {
+		/* Is it asking for N-th entry, or approxidate? */
+		int nth, i;
+		unsigned long at_time;
+		for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
+			char ch = str[at+2+i];
+			if ('0' <= ch && ch <= '9')
+				nth = nth * 10 + ch - '0';
+			else
+				nth = -1;
+		}
+		if (0 <= nth)
+			at_time = 0;
+		else
+			at_time = approxidate(str + at + 2);
+		read_ref_at(real_ref, at_time, nth, sha1);
 	}
 
 	free(real_ref);
-- 
1.4.2.3.gae59
