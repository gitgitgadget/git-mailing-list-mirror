From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] t7502: clean up fake_editor tests
Date: Thu, 26 Jul 2012 16:27:55 -0400
Message-ID: <20120726202754.GA16048@sigill.intra.peff.net>
References: <20120726202644.GA15043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:28:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuUfC-00031j-7T
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 22:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab2GZU15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 16:27:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37583 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2GZU15 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 16:27:57 -0400
Received: (qmail 13284 invoked by uid 107); 26 Jul 2012 20:27:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 16:27:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 16:27:55 -0400
Content-Disposition: inline
In-Reply-To: <20120726202644.GA15043@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202303>

Using write_script saves us a few lines of code, and means
we consistently use $SHELL_PATH.

We can also drop the setting of the $pwd variable from
$(pwd). In the first instance, there is no reason to use it
(we can just use $(pwd) directly two lines later, since we
are interpolating the here-document). In the second
instance, it is totally pointless and probably just a
cut-and-paste from the first instance.

Finally, we can use a non-interpolating here document for
the final script, which saves some quoting.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7502-commit.sh | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 181456a..ddce53a 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -266,13 +266,10 @@ test_expect_success 'committer is automatic' '
 	test_i18ncmp expect actual
 '
 
-pwd=`pwd`
-cat >> .git/FAKE_EDITOR << EOF
-#! /bin/sh
-echo editor started > "$pwd/.git/result"
+write_script .git/FAKE_EDITOR <<EOF
+echo editor started > "$(pwd)/.git/result"
 exit 0
 EOF
-chmod +x .git/FAKE_EDITOR
 
 test_expect_success 'do not fire editor in the presence of conflicts' '
 
@@ -300,9 +297,7 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 	test "$(cat .git/result)" = "editor not started"
 '
 
-pwd=`pwd`
-cat >.git/FAKE_EDITOR <<EOF
-#! $SHELL_PATH
+write_script .git/FAKE_EDITOR <<EOF
 # kill -TERM command added below.
 EOF
 
@@ -339,13 +334,12 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 '
 
-cat >.git/FAKE_EDITOR <<EOF
-#!$SHELL_PATH
-mv "\$1" "\$1.orig"
+write_script .git/FAKE_EDITOR <<\EOF
+mv "$1" "$1.orig"
 (
 	echo message
-	cat "\$1.orig"
-) >"\$1"
+	cat "$1.orig"
+) >"$1"
 EOF
 
 echo '## Custom template' >template
-- 
1.7.11.3.8.ge78f547
