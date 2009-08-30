From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] refactor test-date interface
Date: Sun, 30 Aug 2009 17:46:04 -0400
Message-ID: <20090830214604.GB16119@coredump.intra.peff.net>
References: <20090830093642.GA30922@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 23:46:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhsE4-0004Qv-Jr
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 23:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZH3VqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 17:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbZH3VqH
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 17:46:07 -0400
Received: from peff.net ([208.65.91.99]:42501 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897AbZH3VqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 17:46:06 -0400
Received: (qmail 19329 invoked by uid 107); 30 Aug 2009 21:46:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 17:46:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 17:46:04 -0400
Content-Disposition: inline
In-Reply-To: <20090830093642.GA30922@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127436>

The test-date program goes back to the early days of git,
where it was presumably used to do manual sanity checks on
changes to the date code. However, it is not actually used
by the test suite to do any sort of automatic of systematic
tests.

This patch refactors the interface to the program to try to
make it more suitable for use by the test suite. There
should be no fallouts to changing the interface since it is
not actually installed and is not internally called by any
other programs.

The changes are:

  - add a "mode" parameter so the caller can specify which
    operation to test

  - add a mode to test relative date output from show_date

  - allow faking a fixed time via the TEST_DATE_NOW
    environment variable, which allows consistent automated
    testing

  - drop the use of ctime for showing dates in favor of our
    internal iso8601 printing routines. The ctime output is
    somewhat redundant (because of the day-of-week) which
    makes writing test cases more annoying.

Signed-off-by: Jeff King <peff@peff.net>
---
I mulled over replacing ctime for a bit, as we are testing git's date
code with other parts of git's date code. But it really is more
convenient for writing test cases to use iso8601, since you don't have
to calculate the day-of-week (and I also think it is a bit more
readable). And our iso8601 code is dead simple, so I am not too worried
about a bug in it hiding a bug elsewhere.

 test-date.c |   86 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 66 insertions(+), 20 deletions(-)
 rewrite test-date.c (63%)

diff --git a/test-date.c b/test-date.c
dissimilarity index 63%
index 62e8f23..5b0a220 100644
--- a/test-date.c
+++ b/test-date.c
@@ -1,20 +1,66 @@
-#include "cache.h"
-
-int main(int argc, char **argv)
-{
-	int i;
-
-	for (i = 1; i < argc; i++) {
-		char result[100];
-		time_t t;
-
-		memcpy(result, "bad", 4);
-		parse_date(argv[i], result, sizeof(result));
-		t = strtoul(result, NULL, 0);
-		printf("%s -> %s -> %s", argv[i], result, ctime(&t));
-
-		t = approxidate(argv[i]);
-		printf("%s -> %s\n", argv[i], ctime(&t));
-	}
-	return 0;
-}
+#include "cache.h"
+
+static const char *usage_msg = "\n"
+"  test-date show [time_t]...\n"
+"  test-date parse [date]...\n"
+"  test-date approxidate [date]...\n";
+
+static void show_dates(char **argv, struct timeval *now)
+{
+	char buf[128];
+
+	for (; *argv; argv++) {
+		time_t t = atoi(*argv);
+		show_date_relative(t, 0, now, buf, sizeof(buf));
+		printf("%s -> %s\n", *argv, buf);
+	}
+}
+
+static void parse_dates(char **argv, struct timeval *now)
+{
+	for (; *argv; argv++) {
+		char result[100];
+		time_t t;
+
+		parse_date(*argv, result, sizeof(result));
+		t = strtoul(result, NULL, 0);
+		printf("%s -> %s\n", *argv,
+			t ? show_date(t, 0, DATE_ISO8601) : "bad");
+	}
+}
+
+static void parse_approxidate(char **argv, struct timeval *now)
+{
+	for (; *argv; argv++) {
+		time_t t;
+		t = approxidate_relative(*argv, now);
+		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_ISO8601));
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct timeval now;
+	const char *x;
+
+	x = getenv("TEST_DATE_NOW");
+	if (x) {
+		now.tv_sec = atoi(x);
+		now.tv_usec = 0;
+	}
+	else
+		gettimeofday(&now, NULL);
+
+	argv++;
+	if (!*argv)
+		usage(usage_msg);
+	if (!strcmp(*argv, "show"))
+		show_dates(argv+1, &now);
+	else if (!strcmp(*argv, "parse"))
+		parse_dates(argv+1, &now);
+	else if (!strcmp(*argv, "approxidate"))
+		parse_approxidate(argv+1, &now);
+	else
+		usage(usage_msg);
+	return 0;
+}
-- 
1.6.4.2.375.g73938
