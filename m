From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] t4212: loosen far-in-future test for AIX
Date: Tue, 1 Apr 2014 03:43:06 -0400
Message-ID: <20140401074306.GB22550@sigill.intra.peff.net>
References: <20140401073848.GA22023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 09:43:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUtLn-0001Va-8s
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 09:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbaDAHnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 03:43:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:51549 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751000AbaDAHnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 03:43:08 -0400
Received: (qmail 11132 invoked by uid 102); 1 Apr 2014 07:43:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 02:43:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 03:43:06 -0400
Content-Disposition: inline
In-Reply-To: <20140401073848.GA22023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245574>

One of the tests in t4212 checks our behavior when we feed
gmtime a date so far in the future that it gives up and
returns NULL. Some implementations, like AIX, may actually
just provide us a bogus result instead.

It's not worth it for us to come up with heuristics that
guess whether the return value is sensible or not. On good
platforms where gmtime reports the problem to us with NULL,
we will print the epoch value. On bad platforms, we will
print garbage.  But our test should be written for the
lowest common denominator so that it passes everywhere.

Reported-by: Charles Bailey <cbailey32@bloomberg.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4212-log-corrupt.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 3fa1715..58b792b 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -82,11 +82,9 @@ test_expect_success 'date parser recognizes time_t overflow' '
 '
 
 # date is within 2^63-1, but enough to choke glibc's gmtime
-test_expect_success 'absurdly far-in-future dates produce sentinel' '
+test_expect_success 'absurdly far-in-future date' '
 	commit=$(munge_author_date HEAD 999999999999999999) &&
-	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
-	git log -1 --format=%ad $commit >actual &&
-	test_cmp expect actual
+	git log -1 --format=%ad $commit
 '
 
 test_done
-- 
1.9.1.656.ge8a0637
