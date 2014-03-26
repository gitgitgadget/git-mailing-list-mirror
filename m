From: Jeff King <peff@peff.net>
Subject: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Wed, 26 Mar 2014 14:51:53 -0400
Message-ID: <20140326185153.GA12912@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:52:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSsvg-0004Pj-IP
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbaCZSv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 14:51:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:47758 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751580AbaCZSvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 14:51:55 -0400
Received: (qmail 16634 invoked by uid 102); 26 Mar 2014 18:51:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 13:51:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 14:51:53 -0400
Content-Disposition: inline
In-Reply-To: <20140326182103.GB7087@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245208>

One of the tests in t4212 checks our behavior when we feed
gmtime a date so far in the future that it gives up and
returns NULL.

But some gmtime implementations just refuse to quit. They
soldier on, giving us a glimpse of a chilly October evening
some 160 million years in the future (and presumably filled
with our leather-clad horseback-riding ape descendants).

Let's allow the test to match either the sentinel value
(i.e., what we want when gmtime gives up) or any reasonable
value returned by known implementations.

Reported-by: Charles Bailey <cbailey32@bloomberg.net>
Signed-off-by: Jeff King <peff@peff.net>
---
On top of jk/commit-dates-parsing-fix (though the test is already in
v1.9.1).

 t/t4212-log-corrupt.sh | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 85c6df4..08f982c 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -76,12 +76,27 @@ test_expect_success 'date parser recognizes time_t overflow' '
 	test_cmp expect actual
 '
 
-# date is within 2^63-1, but enough to choke glibc's gmtime
-test_expect_success 'absurdly far-in-future dates produce sentinel' '
+cmp_one_of () {
+	for candidate in "$@"; do
+		echo "$candidate" >expect &&
+		test_cmp expect actual &&
+		return 0
+	done
+	return 1
+}
+
+# date is within 2^63-1, but enough to choke glibc's gmtime.
+# We check that either the date broke gmtime (and we return the
+# usual epoch value), or gmtime gave us some sensible value.
+#
+# The sensible values are determined experimentally. The first
+# is from AIX.
+test_expect_success 'absurdly far-in-future dates' '
 	commit=$(munge_author_date HEAD 999999999999999999) &&
-	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
 	git log -1 --format=%ad $commit >actual &&
-	test_cmp expect actual
+	cmp_one_of \
+		"Thu Jan 1 00:00:00 1970 +0000" \
+		"Thu Oct 24 18:46:39 162396404 -0700"
 '
 
 test_done
-- 
1.9.1.656.ge8a0637
