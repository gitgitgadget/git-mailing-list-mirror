From: Jeff King <peff@peff.net>
Subject: [PATCH] t5537: re-drop http tests
Date: Thu, 29 May 2014 21:34:19 -0400
Message-ID: <20140530013419.GE28683@sigill.intra.peff.net>
References: <87y4xk8asq.fsf@spindle.srvr.nix>
 <20140530010649.GD28683@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nix <nix@esperi.org.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 03:34:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqBiF-0007hM-He
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 03:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbaE3BeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 21:34:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:33838 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754339AbaE3BeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 21:34:20 -0400
Received: (qmail 1884 invoked by uid 102); 30 May 2014 01:34:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 20:34:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 21:34:19 -0400
Content-Disposition: inline
In-Reply-To: <20140530010649.GD28683@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250426>

These were originally removed by 0232852 (t5537: move
http tests out to t5539, 2014-02-13). However, they were
accidentally re-added in 1ddb4d7 (Merge branch
'nd/upload-pack-shallow', 2014-03-21).

This looks like an error in manual conflict resolution.
Here's what happened:

  1. v1.9.0 shipped with the http tests in t5537.

  2. We realized that this caused problems, and built
     0232852 on top to move the tests to their own file.
     This fix made it into v1.9.1.

  3. We later had another fix in nd/upload-pack-shallow that
     also touched t5537. It was built directly on v1.9.0.

When we merged nd/upload-pack-shallow to master, we got a
conflict; it was built on a version with the http tests, but
we had since removed them. The correct resolution was to
drop the http tests and keep the new ones, but instead we
kept everything.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a regression in running "make test" in v2.0.0 for people who do
not have apache installed, so it would be nice to hit maint for 2.0.1.

I had a very hard time finding the merge to blame, because the
combined-diff code is convinced this isn't an interesting hunk (because
we kept no content from the other side, as there was none to keep!). I
eventually tracked it down with "git log --first-parent -m t/t5537*".

And a final side note. If you retry the merge by:

  m=1ddb4d7
  git checkout $m^1
  git merge $m^2

you can see the resulting conflict is quite tricky to understand. You
can tell from the blank "ours" side that _something_ was removed
(otherwise there would not have been a conflict), but there is no way to
tell what, or that the same something is part of the "theirs" side.
Viewing it with diff3 conflict-style makes it much more obvious.

 t/t5537-fetch-shallow.sh | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index be951a4..a980574 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -173,33 +173,6 @@ EOF
 	)
 '
 
-if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
-	say 'skipping remaining tests, git built without http support'
-	test_done
-fi
-
-LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5537'}
-. "$TEST_DIRECTORY"/lib-httpd.sh
-start_httpd
-
-test_expect_success 'clone http repository' '
-	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
-	git clone $HTTPD_URL/smart/repo.git clone &&
-	(
-	cd clone &&
-	git fsck &&
-	git log --format=%s origin/master >actual &&
-	cat <<EOF >expect &&
-7
-6
-5
-4
-3
-EOF
-	test_cmp expect actual
-	)
-'
-
 test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only repo' '
 	cp -R .git read-only.git &&
 	find read-only.git -print | xargs chmod -w &&
@@ -213,5 +186,4 @@ EOF
 	test_cmp expect actual
 '
 
-stop_httpd
 test_done
-- 
2.0.0.rc1.436.g03cb729
