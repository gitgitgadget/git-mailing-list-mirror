From: Jeff King <peff@peff.net>
Subject: [PATCH 3/8] t3305: fix ignored exit code inside loop
Date: Wed, 25 Mar 2015 01:28:57 -0400
Message-ID: <20150325052856.GC31924@peff.net>
References: <20150325052456.GA19394@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 06:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YadsH-0000pc-H1
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 06:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbbCYF27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 01:28:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:38163 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751018AbbCYF27 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 01:28:59 -0400
Received: (qmail 17436 invoked by uid 102); 25 Mar 2015 05:28:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 00:28:59 -0500
Received: (qmail 11574 invoked by uid 107); 25 Mar 2015 05:29:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 01:29:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 01:28:57 -0400
Content-Disposition: inline
In-Reply-To: <20150325052456.GA19394@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266256>

When we test deleting notes, we run "git notes remove" in a
loop. However, the exit value of the loop will only reflect
the final note we process. We should break out of the loop
with a failing exit code as soon as we see a problem.

Note that we can call "exit 1" here without explicitly
creating a subshell, because the while loop on the
right-hand side of a pipe executes in its own implicit
subshell.

Note also that the "break" above does not suffer the same
problem; it is meant to exit the loop early at a certain
number of iterations. We can bump it into the conditional of
the loop to make this more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3305-notes-fanout.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index b1ea64b..54460be 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -51,15 +51,12 @@ test_expect_success 'deleting most notes with git-notes' '
 	num_notes=250 &&
 	i=0 &&
 	git rev-list HEAD |
-	while read sha1
+	while test $i -lt $num_notes && read sha1
 	do
 		i=$(($i + 1)) &&
-		if test $i -gt $num_notes
-		then
-			break
-		fi &&
 		test_tick &&
-		git notes remove "$sha1"
+		git notes remove "$sha1" ||
+		exit 1
 	done
 '
 
-- 
2.3.4.635.gd6ffcfe
