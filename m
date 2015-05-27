From: Jeff King <peff@peff.net>
Subject: [PATCH] t7063: hide stderr from setup inside prereq
Date: Wed, 27 May 2015 05:34:58 -0400
Message-ID: <20150527093457.GA2826@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 11:35:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxXjw-0005dT-On
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 11:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbbE0JfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 05:35:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:36561 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750755AbbE0JfC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 05:35:02 -0400
Received: (qmail 8882 invoked by uid 102); 27 May 2015 09:35:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 04:35:02 -0500
Received: (qmail 5795 invoked by uid 107); 27 May 2015 09:35:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 05:35:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 05:34:58 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270039>

When t7063 starts, it runs "update-index --untracked-cache"
to see if we support the untracked cache. Its output goes
straight to stderr, even if the test is not run with "-v".
Let's wrap it in a prereq that will hide the output by
default, but show it with "-v".

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed this messing up my "prove" output. And it always runs first
with "prove --state=slow", because it has a whopping 17 seconds of
sleeps in it.

 t/t7063-status-untracked-cache.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 2b2ffd7..bd4806c 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -8,10 +8,14 @@ avoid_racy() {
 	sleep 1
 }
 
-git update-index --untracked-cache
 # It's fine if git update-index returns an error code other than one,
 # it'll be caught in the first test.
-if test $? -eq 1; then
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+if ! test_have_prereq UNTRACKED_CACHE; then
 	skip_all='This system does not support untracked cache'
 	test_done
 fi
-- 
2.4.1.552.g6de66a4
