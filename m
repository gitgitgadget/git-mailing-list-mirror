From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/4] tests: add date printing and parsing tests
Date: Sun, 30 Aug 2009 22:30:16 -0400
Message-ID: <20090831023015.GC5507@coredump.intra.peff.net>
References: <20090831022228.GA4833@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 04:30:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhwf6-00063s-73
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 04:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbZHaCaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 22:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754261AbZHaCaR
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 22:30:17 -0400
Received: from peff.net ([208.65.91.99]:51400 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754242AbZHaCaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 22:30:16 -0400
Received: (qmail 20402 invoked by uid 107); 31 Aug 2009 02:30:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 22:30:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 22:30:16 -0400
Content-Disposition: inline
In-Reply-To: <20090831022228.GA4833@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127454>

Until now, there was no coverage of relative date printing
or approxidate parsing routines (mainly because we had no
way of faking the "now" time for relative date calculations,
which made consistent testing impossible).

This new script tries to exercise the basic features of
show_date and approxidate. Most of the tests are just "this
obvious thing works" to prevent future regressions, with a
few exceptions:

  - We confirm the fix in 607a9e8 that relative year/month
    dates in the latter half of a year round correctly.

  - We confirm that the improvements in b5373e9 and 1bddb25
    work.

  - A few tests are marked to expect failure, which are
    regressions recently introduced by the two commits
    above.

Signed-off-by: Jeff King <peff@peff.net>
---
Similar to earlier 3/3, but improvements and regressions from
lt/approxidate included.

Linus, when you posted the approxidate fixes earlier, you mentioned you
might have some other corner cases. I think you were just referring to
the stuff you improved in the followup patch, but if you know of more
broken-ness, we should probably include it here.

 t/t0006-date.sh |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100755 t/t0006-date.sh

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
new file mode 100755
index 0000000..02cd565
--- /dev/null
+++ b/t/t0006-date.sh
@@ -0,0 +1,75 @@
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
+	test_expect_${3:-success} "relative date ($2)" "
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
+	test_expect_${3:-success} "parse date ($1)" "
+	test-date parse '$1' >actual &&
+	test_cmp expect actual
+	"
+}
+
+check_parse 2008 bad
+check_parse 2008-02 bad
+check_parse 2008-02-14 bad
+check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
+
+check_approxidate() {
+	echo "$1 -> $2 +0000" >expect
+	test_expect_${3:-success} "parse approxidate ($1)" "
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
+check_approxidate 3.months.ago '2009-05-30 19:20:00' failure
+check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00' failure
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
+check_approxidate '06/05/2009' '2009-06-05 19:20:00'
+check_approxidate '06.05.2009' '2009-05-06 19:20:00'
+
+check_approxidate 'Jun 6, 5AM' '2009-06-06 05:00:00'
+check_approxidate '5AM Jun 6' '2009-06-06 05:00:00'
+check_approxidate '6AM, June 7, 2009' '2009-06-07 06:00:00'
+
+test_done
-- 
1.6.4.2.373.g5881fd
