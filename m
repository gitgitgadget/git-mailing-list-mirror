From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add date formatting and parsing functions relative
 to a given time
Date: Sun, 30 Aug 2009 05:36:42 -0400
Message-ID: <20090830093642.GA30922@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
 <20090828190319.GA9233@blimp.localdomain>
 <20090828191521.GA12292@coredump.intra.peff.net>
 <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
 <20090828193302.GB9233@blimp.localdomain>
 <20090828205232.GD9233@blimp.localdomain>
 <7vk50mz41e.fsf@alter.siamese.dyndns.org>
 <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
 <20090830091346.GA14928@blimp.localdomain>
 <20090830091557.GA28531@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 11:36:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhgqE-0008EZ-5p
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 11:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbZH3Jgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 05:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZH3Jgo
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 05:36:44 -0400
Received: from peff.net ([208.65.91.99]:54799 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427AbZH3Jgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 05:36:43 -0400
Received: (qmail 16721 invoked by uid 107); 30 Aug 2009 09:36:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 05:36:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 05:36:42 -0400
Content-Disposition: inline
In-Reply-To: <20090830091557.GA28531@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127404>

On Sun, Aug 30, 2009 at 05:15:57AM -0400, Jeff King wrote:

> FYI, I am munging test-date to match the test script I am writing, so
> don't bother with that patch.

Here is what my patch is looking like. Please give any comments, and
then I will resubmit in a form that will be simpler for Junio, which
should be a series with:

  - your patch to refactor date.c
  - this patch (this version uses the original interface to
    show_relative; I will tweak to match the new patch you just sent)
  - another patch to go on top of lt/approxidate to test recent fixes
    from Linus

---
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
new file mode 100755
index 0000000..4beb44b
--- /dev/null
+++ b/t/t0006-date.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description='test date parsing and printing'
+. ./test-lib.sh
+
+# arbitrary reference time: 2009-08-30 19:20:00
+TEST_DATE_NOW=1251660000; export TEST_DATE_NOW
+
+check_show() {
+	t=$(($TEST_DATE_NOW - $1))
+	echo "$t -> $2" >expect
+	test_expect_success "relative date ($2)" "
+	test-date show $t >actual &&
+	test_cmp expect actual
+	"
+}
+
+check_show 5 '5 seconds ago'
+check_show 300 '5 minutes ago'
+check_show 18000 '5 hours ago'
+check_show 432000 '5 days ago'
+check_show 1728000 '3 weeks ago'
+check_show 13000000 '5 months ago'
+check_show 37500000 '1 year, 2 months ago'
+check_show 55188000 '1 year, 9 months ago'
+check_show 630000000 '20 years ago'
+
+check_parse() {
+	echo "$1 -> $2" >expect
+	test_expect_success "parse date ($1)" "
+	test-date parse '$1' >actual &&
+	test_cmp expect actual
+	"
+}
+
+check_parse 2008 bad
+check_parse 2008-02 bad
+check_parse 2008-02-14 '2008-02-14 00:00:00 +0000'
+check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
+
+check_approxidate() {
+	echo "$1 -> $2 +0000" >expect
+	test_expect_success "parse approxidate ($1)" "
+	test-date approxidate '$1' >actual &&
+	test_cmp expect actual
+	"
+}
+
+check_approxidate now '2009-08-30 19:20:00'
+check_approxidate '5 seconds ago' '2009-08-30 19:19:55'
+check_approxidate 5.seconds.ago '2009-08-30 19:19:55'
+check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
+check_approxidate yesterday '2009-08-29 19:20:00'
+check_approxidate 3.days.ago '2009-08-27 19:20:00'
+check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
+check_approxidate 3.months.ago '2009-05-30 19:20:00'
+check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
+
+check_approxidate '6am yesterday' '2009-08-29 06:00:00'
+check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
+check_approxidate '3:00' '2009-08-30 03:00:00'
+check_approxidate '15:00' '2009-08-30 15:00:00'
+check_approxidate 'noon today' '2009-08-30 12:00:00'
+check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
+
+check_approxidate 'last tuesday' '2009-08-25 19:20:00'
+check_approxidate 'July 5th' '2009-07-05 19:20:00'
+check_approxidate '06/05/2009' '2009-06-05 00:00:00'
+check_approxidate '06.05.2009' '2009-05-06 00:00:00'
+
+test_done
diff --git a/test-date.c b/test-date.c
index 62e8f23..8d263a3 100644
--- a/test-date.c
+++ b/test-date.c
@@ -1,20 +1,63 @@
 #include "cache.h"
 
-int main(int argc, char **argv)
+static const char *usage_msg = "\n"
+"  test-date show [time_t]...\n"
+"  test-date parse [date]...\n"
+"  test-date approxidate [date]...\n";
+
+static void show_dates(char **argv, struct timeval *now)
 {
-	int i;
+	for (; *argv; argv++) {
+		time_t t = atoi(*argv);
+		printf("%s -> %s\n", *argv, show_date_relative(t, 0, now));
+	}
+}
 
-	for (i = 1; i < argc; i++) {
+static void parse_dates(char **argv, struct timeval *now)
+{
+	for (; *argv; argv++) {
 		char result[100];
 		time_t t;
 
-		memcpy(result, "bad", 4);
-		parse_date(argv[i], result, sizeof(result));
+		parse_date(*argv, result, sizeof(result));
 		t = strtoul(result, NULL, 0);
-		printf("%s -> %s -> %s", argv[i], result, ctime(&t));
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
 
-		t = approxidate(argv[i]);
-		printf("%s -> %s\n", argv[i], ctime(&t));
+int main(int argc, char **argv)
+{
+	struct timeval now;
+	const char *x;
+
+	x = getenv("TEST_DATE_NOW");
+	if (x) {
+		now.tv_sec = atoi(x);
+		now.tv_usec = 0;
 	}
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
 	return 0;
 }
