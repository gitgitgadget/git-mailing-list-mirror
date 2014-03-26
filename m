From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Wed, 26 Mar 2014 15:40:43 -0400
Message-ID: <20140326194043.GB14105@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <20140326185153.GA12912@sigill.intra.peff.net>
 <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
 <20140326192536.GA13989@sigill.intra.peff.net>
 <20140326193359.GA14105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:40:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WStgw-00016u-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbaCZTkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 15:40:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:47875 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751580AbaCZTkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 15:40:45 -0400
Received: (qmail 19612 invoked by uid 102); 26 Mar 2014 19:40:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 14:40:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 15:40:43 -0400
Content-Disposition: inline
In-Reply-To: <20140326193359.GA14105@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245218>

On Wed, Mar 26, 2014 at 03:33:59PM -0400, Jeff King wrote:

> That being said, is the AIX value actually right? I did not look closely
> at first, but just assumed that it was vaguely right. But:
> 
>   999999999999999999 / (86400 * 365)
> 
> is something like 31 billion years in the future, not 160 million.
> A real date calculation will have a few tweaks (leap years, etc), but
> that is orders of magnitude off.

Assuming my math is right, then here is the most sensible patch, IMHO.

-- >8 --
Subject: t4212: loosen far-in-future test for AIX

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
 t/t4212-log-corrupt.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 85c6df4..bb843ab 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -77,11 +77,14 @@ test_expect_success 'date parser recognizes time_t overflow' '
 '
 
 # date is within 2^63-1, but enough to choke glibc's gmtime
-test_expect_success 'absurdly far-in-future dates produce sentinel' '
+#
+# Ideally we would check the output to make sure we replaced it with
+# a useful sentinel value, but some platforms will actually hand us back
+# a nonsensical date. It is not worth our time to try to evaluate these
+# dates, so just make sure we didn't segfault or otherwise abort.
+test_expect_success 'absurdly far-in-future dates' '
 	commit=$(munge_author_date HEAD 999999999999999999) &&
-	echo "Thu Jan 1 00:00:00 1970 +0000" >expect &&
-	git log -1 --format=%ad $commit >actual &&
-	test_cmp expect actual
+	git log -1 --format=%ad $commit
 '
 
 test_done
-- 
1.9.1.656.ge8a0637
