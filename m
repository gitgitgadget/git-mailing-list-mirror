From: Jeff King <peff@peff.net>
Subject: [PATCH] t4213: avoid "|" in sed regexp
Date: Mon, 10 Nov 2014 01:51:39 -0500
Message-ID: <20141110065139.GB7677@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <tr@thomasrast.ch>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 07:51:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnipG-0008R0-5a
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 07:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbaKJGvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 01:51:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:38621 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751238AbaKJGvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 01:51:41 -0500
Received: (qmail 16264 invoked by uid 102); 10 Nov 2014 06:51:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 00:51:41 -0600
Received: (qmail 365 invoked by uid 107); 10 Nov 2014 06:51:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 01:51:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 01:51:39 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 06:46:01PM -0800, Michael Blume wrote:

> Ok, with that I have a different test failure on the pu branch --
> please tell me if I'm spamming the list or if there's some other
> protocol I should be using to report issues on pu.

No, reporting problems to the list is exactly the right spot. It is nice
to start a new thread, though, if it is an unrelated problem. And
possibly cc folks you think might be responsible. E.g.:

  git shortlog -se origin/master..origin/pu t/t4213-*

points to Thomas. :)

-- >8 --
Many versions of sed (e.g., that found on OS X) do not understand
"|"-alternation, even when backslash escaped.  Some versions can turn on
extended regexps with a special option, but of course that option is not
standard, either. Let's just write out our alternates longhand.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of the tr/remerge-diff topic.

For curiosity, it is "-E" on OS X and "-r" on GNU sed to turn on
extended regexps. But I hear that Solaris sed also does not handle "\|",
and I would not be surprised to find that it has no extended regexp
support at all. :)

 t/t4213-log-remerge-diff.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t4213-log-remerge-diff.sh b/t/t4213-log-remerge-diff.sh
index 36ef17a..ec93b96 100755
--- a/t/t4213-log-remerge-diff.sh
+++ b/t/t4213-log-remerge-diff.sh
@@ -75,7 +75,9 @@ test_expect_success 'unrelated merge: without conflicts' '
 clean_output () {
 	git name-rev --name-only --stdin |
 	# strip away bits that aren't treated by the above
-	sed -e 's/^\(index\|Merge:\|Date:\).*/\1/'
+	sed -e 's/^\(index\).*/\1/' \
+	    -e 's/^\(Merge:\).*/\1/' \
+	    -e 's/^\(Date:\).*/\1/'
 }
 
 cat >expected <<EOF
-- 
2.1.2.596.g7379948
