From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t1301: set umask in reflog sharedrepository=group test
Date: Mon, 5 Jan 2015 22:49:43 -0500
Message-ID: <20150106034942.GA20087@peff.net>
References: <20150106034702.GA11503@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Sokolovsky <paul.sokolovsky@linaro.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 04:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8L9S-0000IE-8q
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 04:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbbAFDtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 22:49:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:59306 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753708AbbAFDtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 22:49:45 -0500
Received: (qmail 3717 invoked by uid 102); 6 Jan 2015 03:49:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jan 2015 21:49:45 -0600
Received: (qmail 6855 invoked by uid 107); 6 Jan 2015 03:50:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jan 2015 22:50:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jan 2015 22:49:43 -0500
Content-Disposition: inline
In-Reply-To: <20150106034702.GA11503@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262044>

The t1301 script sets the umask globally before many of the
tests. Most of the tests that care about the umask then set
it explicitly at the start of the test. However, one test
does not, and relies on the 077 umask setting from earlier
tests. This is fragile and can break if another test is
added in between. Let's be more explicit.

Signed-off-by: Jeff King <peff@peff.net>
---
I suspect the world would be a better place if t1301 did all of its
umask setting in subshells, as it may also affect things like writing
out the test results. But nobody has complained, so I'm not inclined to
spend a lot of time futzing with it.

This is enough to protect the test I'm about to add in the next patch,
so it's not worse than the status quo.

 t/t1301-shared-repo.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index de42d21..86ed901 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -112,6 +112,7 @@ do
 done
 
 test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
+	umask 077 &&
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
 	actual="$(ls -l .git/logs/refs/heads/master)" &&
-- 
2.2.1.425.g441bb3c
