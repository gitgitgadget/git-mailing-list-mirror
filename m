From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 1/3] Use parse_date_format() convenience function for converting a format string to an enum date_mode in revisions.c
Date: Sat, 29 Sep 2007 08:39:44 +0100
Message-ID: <200709290839.45467.andyparkins@gmail.com>
References: <7v1wcipsn9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 09:40:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbWvm-0005X0-Fo
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 09:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbXI2Hjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 03:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbXI2Hjy
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 03:39:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:13431 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbXI2Hjx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 03:39:53 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1597068ugc
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=gC443Djb4bZNuRggLLucv+JqBqEb/Ub5ABe2ldWS3Uc=;
        b=WPPsZullbPhrxDy9ldov8psOSAND8LVguOOeuerSW8hqzWZUb6prXoW55fdOcHIWd2Fg0bU27XcwECp9/X48gXvbELxRuBo+MvkrOKuQuzPmbgSvoumjJYdw6t0giBWYc1u+zOpj/TKMLqh+O9nSCEalxoVKQLDAZQvCQ5OT/ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=KWolQH82bmnrgSTsRhzjIdAl5hzRjRBgCE5GePP0HJHdU+hGvqffG0SmVTqh3t1LPlPI1Huv+hU0MdPdXf2IfFJPKYQEG8lTDpvwtdvOhvnG71tBFB2Zu1Gu7FhTcc8biM8T+Ee6b+G54HNubBPM5k+wqf6/doUuE7aL/aAyMnM=
Received: by 10.66.239.2 with SMTP id m2mr6097396ugh.1191051591723;
        Sat, 29 Sep 2007 00:39:51 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id k28sm9599713ugd.2007.09.29.00.39.50
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Sep 2007 00:39:51 -0700 (PDT)
In-Reply-To: <7v1wcipsn9.fsf@gitster.siamese.dyndns.org>
X-TUID: 737bc6f0ba2d704a
X-UID: 337
X-Length: 3637
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59442>

parse_date_format() is passed a string that is compared against a
pre-defined list and converted to an enum date_format.  The table is as
follows:

 - "relative"         => DATE_RELATIVE
 - "iso8601" or "iso" => DATE_ISO8601
 - "rfc2822"          => DATE_RFC2822
 - "short"            => DATE_SHORT
 - "local"            => DATE_LOCAL
 - "default"          => DATE_NORMAL

In the event that none of these strings is found, the function die()s.

Then we use parse_date_format() in revisions.c to parse the --date
parameter.  The --date parameter was previously handled in revisions.c
with a list of if(strcmp()) calls; now parse_date_format() is called
instead.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 cache.h    |    1 +
 date.c     |   20 ++++++++++++++++++++
 revision.c |   17 +----------------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index 8246500..5587f7e 100644
--- a/cache.h
+++ b/cache.h
@@ -432,6 +432,7 @@ const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
+enum date_mode parse_date_format(const char *format);
 
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
diff --git a/date.c b/date.c
index 93bef6e..8f70500 100644
--- a/date.c
+++ b/date.c
@@ -584,6 +584,26 @@ int parse_date(const char *date, char *result, int maxlen)
 	return date_string(then, offset, result, maxlen);
 }
 
+enum date_mode parse_date_format(const char *format)
+{
+	if (!strcmp(format, "relative"))
+		return DATE_RELATIVE;
+	else if (!strcmp(format, "iso8601") ||
+		 !strcmp(format, "iso"))
+		return DATE_ISO8601;
+	else if (!strcmp(format, "rfc2822") ||
+		 !strcmp(format, "rfc"))
+		return DATE_RFC2822;
+	else if (!strcmp(format, "short"))
+		return DATE_SHORT;
+	else if (!strcmp(format, "local"))
+		return DATE_LOCAL;
+	else if (!strcmp(format, "default"))
+		return DATE_NORMAL;
+	else
+		die("unknown date format %s", format);
+}
+
 void datestamp(char *buf, int bufsize)
 {
 	time_t now;
diff --git a/revision.c b/revision.c
index 33d092c..75cd0c6 100644
--- a/revision.c
+++ b/revision.c
@@ -1134,22 +1134,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				continue;
 			}
 			if (!strncmp(arg, "--date=", 7)) {
-				if (!strcmp(arg + 7, "relative"))
-					revs->date_mode = DATE_RELATIVE;
-				else if (!strcmp(arg + 7, "iso8601") ||
-					 !strcmp(arg + 7, "iso"))
-					revs->date_mode = DATE_ISO8601;
-				else if (!strcmp(arg + 7, "rfc2822") ||
-					 !strcmp(arg + 7, "rfc"))
-					revs->date_mode = DATE_RFC2822;
-				else if (!strcmp(arg + 7, "short"))
-					revs->date_mode = DATE_SHORT;
-				else if (!strcmp(arg + 7, "local"))
-					revs->date_mode = DATE_LOCAL;
-				else if (!strcmp(arg + 7, "default"))
-					revs->date_mode = DATE_NORMAL;
-				else
-					die("unknown date format %s", arg);
+				revs->date_mode = parse_date_format(arg + 7);
 				continue;
 			}
 			if (!strcmp(arg, "--log-size")) {
-- 
1.5.3.rc5.11.g312e
