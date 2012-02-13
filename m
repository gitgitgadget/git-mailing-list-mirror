From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] diff-highlight: document some non-optimal cases
Date: Mon, 13 Feb 2012 17:37:33 -0500
Message-ID: <20120213223733.GE19521@sigill.intra.peff.net>
References: <20120213222702.GA19393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 23:37:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4Wk-00072F-0Y
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 23:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757842Ab2BMWhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 17:37:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34506
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab2BMWhg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 17:37:36 -0500
Received: (qmail 1989 invoked by uid 107); 13 Feb 2012 22:44:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Feb 2012 17:44:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2012 17:37:33 -0500
Content-Disposition: inline
In-Reply-To: <20120213222702.GA19393@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190686>

The diff-highlight script works on heuristics, so it can be
wrong. Let's document some of the wrong-ness in case
somebody feels like working on it.

Signed-off-by: Jeff King <peff@peff.net>
---
These were just some that I considered while looking at the output of
the original and the current code. Suggestions are welcome for more.

 contrib/diff-highlight/README |   93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
index 4a58579..502e03b 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -57,3 +57,96 @@ following in your git configuration:
 	show = diff-highlight | less
 	diff = diff-highlight | less
 ---------------------------------------------
+
+Bugs
+----
+
+Because diff-highlight relies on heuristics to guess which parts of
+changes are important, there are some cases where the highlighting is
+more distracting than useful. Fortunately, these cases are rare in
+practice, and when they do occur, the worst case is simply a little
+extra highlighting. This section documents some cases known to be
+sub-optimal, in case somebody feels like working on improving the
+heuristics.
+
+1. Two changes on the same line get highlighted in a blob. For example,
+   highlighting:
+
+----------------------------------------------
+-foo(buf, size);
++foo(obj->buf, obj->size);
+----------------------------------------------
+
+   yields (where the inside of "+{}" would be highlighted):
+
+----------------------------------------------
+-foo(buf, size);
++foo(+{obj->buf, obj->}size);
+----------------------------------------------
+
+   whereas a more semantically meaningful output would be:
+
+----------------------------------------------
+-foo(buf, size);
++foo(+{obj->}buf, +{obj->}size);
+----------------------------------------------
+
+   Note that doing this right would probably involve a set of
+   content-specific boundary patterns, similar to word-diff. Otherwise
+   you get junk like:
+
+-----------------------------------------------------
+-this line has some -{i}nt-{ere}sti-{ng} text on it
++this line has some +{fa}nt+{a}sti+{c} text on it
+-----------------------------------------------------
+
+   which is less readable than the current output.
+
+2. The multi-line matching assumes that lines in the pre- and post-image
+   match by position. This is often the case, but can be fooled when a
+   line is removed from the top and a new one added at the bottom (or
+   vice versa). Unless the lines in the middle are also changed, diffs
+   will show this as two hunks, and it will not get highlighted at all
+   (which is good). But if the lines in the middle are changed, the
+   highlighting can be misleading. Here's a pathological case:
+
+-----------------------------------------------------
+-one
+-two
+-three
+-four
++two 2
++three 3
++four 4
++five 5
+-----------------------------------------------------
+
+   which gets highlighted as:
+
+-----------------------------------------------------
+-one
+-t-{wo}
+-three
+-f-{our}
++two 2
++t+{hree 3}
++four 4
++f+{ive 5}
+-----------------------------------------------------
+
+   because it matches "two" to "three 3", and so forth. It would be
+   nicer as:
+
+-----------------------------------------------------
+-one
+-two
+-three
+-four
++two +{2}
++three +{3}
++four +{4}
++five 5
+-----------------------------------------------------
+
+   which would probably involve pre-matching the lines into pairs
+   according to some heuristic.
-- 
1.7.8.4.17.g2df81
