From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
 commits older than a year
Date: Fri, 20 Feb 2009 14:15:22 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902201409230.21686@localhost.localdomain>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net, git@vger.kernel.org,
	eletuchy@facebook.com, Eugene Letuchy <eugene@facebook.com>
To: eletuchy@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 20 23:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ladgf-00017U-0C
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 23:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbZBTWQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 17:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbZBTWQC
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 17:16:02 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42390 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752997AbZBTWQB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 17:16:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1KMFNoc018502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2009 14:15:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1KMFM5H003337;
	Fri, 20 Feb 2009 14:15:22 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.956 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110897>


Subject: Support 'raw' date format

Talking about --date, one thing I wanted for the 1234567890 date was to 
get things in the raw format. Sure, you get them with --pretty=raw, but it 
felt a bit sad that you couldn't just ask for the date in raw format.

So here's a throw-away patch (meaning: I won't be re-sending it, because I 
really don't think it's a big deal) to add "--date=raw". It just prints 
out the internal raw git format - seconds since epoch plus timezone (put 
another way: 'date +"%s %z"' format)

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Not a whole lot of testing. But 

	git show --date=raw v2.6.29-rc5

works correctly.

 Documentation/rev-list-options.txt |    4 +++-
 cache.h                            |    3 ++-
 date.c                             |    7 +++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git i/Documentation/rev-list-options.txt w/Documentation/rev-list-options.txt
index b9f6e4d..5076322 100644
--- i/Documentation/rev-list-options.txt
+++ w/Documentation/rev-list-options.txt
@@ -13,7 +13,7 @@ include::pretty-options.txt[]
 
 	Synonym for `--date=relative`.
 
---date={relative,local,default,iso,rfc,short}::
+--date={relative,local,default,iso,rfc,short,raw}::
 
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty". `log.date` config variable sets a default
@@ -31,6 +31,8 @@ format, often found in E-mail messages.
 +
 `--date=short` shows only date but not time, in `YYYY-MM-DD` format.
 +
+`--date=raw` shows the date in the internal raw git format `%s %z` format.
++
 `--date=default` shows timestamps in the original timezone
 (either committer's or author's).
 
diff --git i/cache.h w/cache.h
index 21a6310..189151d 100644
--- i/cache.h
+++ w/cache.h
@@ -696,7 +696,8 @@ enum date_mode {
 	DATE_SHORT,
 	DATE_LOCAL,
 	DATE_ISO8601,
-	DATE_RFC2822
+	DATE_RFC2822,
+	DATE_RAW
 };
 
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
diff --git i/date.c w/date.c
index 950b88f..d75dff4 100644
--- i/date.c
+++ w/date.c
@@ -89,6 +89,11 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	struct tm *tm;
 	static char timebuf[200];
 
+	if (mode == DATE_RAW) {
+		snprintf(timebuf, sizeof(timebuf), "%lu %+05d", time, tz);
+		return timebuf;
+	}
+
 	if (mode == DATE_RELATIVE) {
 		unsigned long diff;
 		struct timeval now;
@@ -615,6 +620,8 @@ enum date_mode parse_date_format(const char *format)
 		return DATE_LOCAL;
 	else if (!strcmp(format, "default"))
 		return DATE_NORMAL;
+	else if (!strcmp(format, "raw"))
+		return DATE_RAW;
 	else
 		die("unknown date format %s", format);
 }
