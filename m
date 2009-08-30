From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] tests: add date printing and parsing tests
Date: Sun, 30 Aug 2009 17:47:41 -0400
Message-ID: <20090830214741.GC16119@coredump.intra.peff.net>
References: <20090830093642.GA30922@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 23:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhsFb-0004pv-7p
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 23:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbZH3Vrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 17:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbZH3Vrm
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 17:47:42 -0400
Received: from peff.net ([208.65.91.99]:42507 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbZH3Vrm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 17:47:42 -0400
Received: (qmail 19365 invoked by uid 107); 30 Aug 2009 21:47:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 17:47:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 17:47:41 -0400
Content-Disposition: inline
In-Reply-To: <20090830093642.GA30922@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127437>

Until now, there was no coverage of relative date printing
or approxidate parsing routines (mainly because we had no
way of faking the "now" time for relative date calculations,
which made consistent testing impossible).

This new script tries to exercise the basic features of
show_date and approxidate. The only specific problem case
tested is showing relative year/month dates in the latter
half of a year, as fixed by 607a9e8.

Signed-off-by: Jeff King <peff@peff.net>
---
Like I said, this is really just to exercise the basic code paths.
But now that the infrastructure is there, we can add any corner cases
or verify new features or bug fixes as they come up. Patches welcome. :)

 t/t0006-date.sh |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 t/t0006-date.sh

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
-- 
1.6.4.2.375.g73938
