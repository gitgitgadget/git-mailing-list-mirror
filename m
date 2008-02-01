From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] --format=pretty: new modifiers cID, cIM, CIS
Date: Sat, 02 Feb 2008 00:43:29 +0200
Organization: Private
Message-ID: <fxwc70xa.fsf@blue.sea.net>
References: <odb072ca.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 23:44:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL4cp-0003FT-0B
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 23:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbYBAWoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 17:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756443AbYBAWoN
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 17:44:13 -0500
Received: from main.gmane.org ([80.91.229.2]:46124 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756320AbYBAWoM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 17:44:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JL4cD-0001Aa-KI
	for git@vger.kernel.org; Fri, 01 Feb 2008 22:44:09 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 22:44:09 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 22:44:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:R2O43EoUPKbVAP5CEuxp4eA2SL8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72188>

The default ISO 8601 modifier %ci is quite verbose displaying
everything up to the timezone. This consumes considerable amount of
characters.  The new modifiers offer way to display just the needed
amount of information, down to:

        %cID    date: YYYY-MM-DD
        %cIM    hour: YYYY-MM-DD HH:MM
        %cIS    second: YYYY-MM-DD HH:MM:SS

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---

 ******************************************************
 THIS IS SAME PATCH- ONLY COMMIT MESSAGE HAS BEEN FIXED
 TO SYNCH WITH THE CONTENT
 ******************************************************

 Documentation/pretty-formats.txt |    5 ++++-
 cache.h                          |    3 +++
 date.c                           |   17 +++++++++++++++++
 pretty.c                         |   35 ++++++++++++++++++++++++++++++-----
 4 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0193c3c..cb1bbac 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -113,7 +113,10 @@ The placeholders are:
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
-- '%ci': committer date, ISO 8601 format
+- '%ci': committer date, ISO 8601 format, long YYYY-MM-DD HH:MM:SS TZ
+- '%cIM': committer date, ISO 8601 format, short YYYY-MM-DD HH:MM
+- '%cIS': committer date, ISO 8601 format, short YYYY-MM-DD HH:MM:SS
+- '%cID': committer date, ISO 8601 format, short YYYY-MM-DD
 - '%e': encoding
 - '%s': subject
 - '%b': body
diff --git a/cache.h b/cache.h
index 549f4bb..1fae94a 100644
--- a/cache.h
+++ b/cache.h
@@ -444,6 +444,9 @@ enum date_mode {
 	DATE_SHORT,
 	DATE_LOCAL,
 	DATE_ISO8601,
+	DATE_ISO8601_YYYYMMDD,
+	DATE_ISO8601_YYYYMMDDHHMM,
+	DATE_ISO8601_YYYYMMDDHHMMSS,
 	DATE_RFC2822
 };
 
diff --git a/date.c b/date.c
index 8f70500..ded9caa 100644
--- a/date.c
+++ b/date.c
@@ -144,6 +144,23 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
+	else if (mode == DATE_ISO8601_YYYYMMDD)
+		sprintf(timebuf, "%04d-%02d-%02d",
+				tm->tm_year + 1900,
+				tm->tm_mon + 1,
+				tm->tm_mday);
+	else if (mode == DATE_ISO8601_YYYYMMDDHHMM)
+		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d",
+				tm->tm_year + 1900,
+				tm->tm_mon + 1,
+				tm->tm_mday,
+				tm->tm_hour, tm->tm_min);
+	else if (mode == DATE_ISO8601_YYYYMMDDHHMMSS)
+		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d:%02d",
+				tm->tm_year + 1900,
+				tm->tm_mon + 1,
+				tm->tm_mday,
+				tm->tm_hour, tm->tm_min, tm->tm_sec);
 	else if (mode == DATE_RFC2822)
 		sprintf(timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
diff --git a/pretty.c b/pretty.c
index b987ff2..5a8774b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -282,9 +282,11 @@ static char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
-static void format_person_part(struct strbuf *sb, char part,
-                               const char *msg, int len)
+static void format_person_part(struct strbuf *sb, char *ptr,
+			       const char *msg, int len)
 {
+	char part = ptr[0];
+	char next = ptr[1];
 	int start, end, tz = 0;
 	unsigned long date;
 	char *ep;
@@ -359,6 +361,26 @@ static void format_person_part(struct strbuf *sb, char part,
 	case 'i':	/* date, ISO 8601 */
 		strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
 		return;
+	case 'I':	/* date, ISO 8601 + fine grained details */
+		switch (next) {
+		case 'D':	/* up till date */
+			strbuf_addstr(sb,
+					show_date(date, tz,
+						DATE_ISO8601_YYYYMMDD));
+			return;
+		case 'S':	/* up till date + sec */
+			strbuf_addstr(sb,
+					show_date(date, tz,
+						DATE_ISO8601_YYYYMMDDHHMMSS));
+
+			return;
+		default:	/* up till hour */
+			strbuf_addstr(sb,
+					show_date(date, tz,
+						DATE_ISO8601_YYYYMMDDHHMM));
+
+		}
+		return;
 	}
 }
 
@@ -532,11 +554,11 @@ static void format_commit_item(struct strbuf *sb, const char *placeholder,
 		strbuf_add(sb, msg + c->subject.off, c->subject.len);
 		return;
 	case 'a':
-		format_person_part(sb, placeholder[1],
+		format_person_part(sb, placeholder + 1,
 		                   msg + c->author.off, c->author.len);
 		return;
 	case 'c':
-		format_person_part(sb, placeholder[1],
+		format_person_part(sb, placeholder + 1,
 		                   msg + c->committer.off, c->committer.len);
 		return;
 	case 'e':
@@ -571,7 +593,10 @@ void format_commit_message(const struct commit *commit,
 		"cD",		/* committer date, RFC2822 style */
 		"cr",		/* committer date, relative */
 		"ct",		/* committer date, UNIX timestamp */
-		"ci",		/* committer date, ISO 8601 */
+		"ci",		/* committer date, ISO 8601 full, with TZ */
+		"cID",		/* committer date, ISO 8601 YYYY-MM-DD */
+		"cIM",		/* committer date, ISO 8601 YYYY-MM-DD HH:MM */
+		"cIS",		/* committer date, ISO 8601 YYYY-MM-DD HH:MM:SS*/
 		"e",		/* encoding */
 		"s",		/* subject */
 		"b",		/* body */
-- 
1.5.4-rc5.GIT-dirty
