From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5540: skip under NO_CURL=NoThanks
Date: Wed, 6 May 2015 13:42:29 -0400
Message-ID: <20150506174229.GA8497@peff.net>
References: <xmqq6185d4o1.fsf@gitster.dls.corp.google.com>
 <20150506173200.GA7985@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 19:42:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq3LC-0002PG-62
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbbEFRme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 13:42:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:54813 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752390AbbEFRmc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 13:42:32 -0400
Received: (qmail 27817 invoked by uid 102); 6 May 2015 17:42:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 May 2015 12:42:31 -0500
Received: (qmail 18933 invoked by uid 107); 6 May 2015 17:43:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 May 2015 13:43:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 May 2015 13:42:29 -0400
Content-Disposition: inline
In-Reply-To: <20150506173200.GA7985@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268472>

On Wed, May 06, 2015 at 01:32:00PM -0400, Jeff King wrote:

> On Wed, May 06, 2015 at 09:58:06AM -0700, Junio C Hamano wrote:
> 
> > All the other tests in t5xxx series that require http support check
> > NO_CURL and skip the test, but this one forgot to do so.
> 
> Makes sense, though I wonder if this check should just get pushed into
> lib-httpd.sh. Surely we can't do anything useful with a web server we
> started if we have no curl support? And this seems to support the case:
> 
>   $ comm -23 <(git grep -l lib-httpd.sh) <(git grep -l NO_CURL)
>   lib-httpd.sh
>   t5540-http-push-webdav.sh
> 
> After your patch, there is literally no script which includes
> lib-httpd.sh but does not respect NO_CURL.

Here's a patch if you want to go that route.

-- >8 --
Subject: t/lib-httpd.sh: skip tests if NO_CURL is defined

If we built git without curl, we can't actually test against
an http server. In fact, all of the test scripts which
include lib-httpd.sh already perform this check, with one
exception: t5540. For those scripts, this is a noop, and for
t5540, this is a bugfix (it used to fail when built with
NO_CURL, though it could go unnoticed if you had a stale
git-remote-https in your build directory).

Noticed-by: Junio C Hamano <junio@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh                | 5 +++++
 t/t5539-fetch-http-shallow.sh | 6 ------
 t/t5541-http-push-smart.sh    | 5 -----
 t/t5542-push-http-shallow.sh  | 6 ------
 t/t5550-http-fetch-dumb.sh    | 6 ------
 t/t5551-http-fetch-smart.sh   | 6 ------
 t/t5561-http-backend.sh       | 6 ------
 7 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index e6adf2f..c3b5250 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -30,6 +30,11 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
+if test -n "$NO_CURL"; then
+	skip_all='skipping test, git built without http support'
+	test_done
+fi
+
 test_tristate GIT_TEST_HTTPD
 if test "$GIT_TEST_HTTPD" = false
 then
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index b461188..37a4335 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -3,12 +3,6 @@
 test_description='fetch/clone from a shallow clone over http'
 
 . ./test-lib.sh
-
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 9cf27e8..fd7d06b 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -6,11 +6,6 @@
 test_description='test smart pushing over http via http-backend'
 . ./test-lib.sh
 
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 ROOT_PATH="$PWD"
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
index 2a691e0..5165833 100755
--- a/t/t5542-push-http-shallow.sh
+++ b/t/t5542-push-http-shallow.sh
@@ -3,12 +3,6 @@
 test_description='push from/to a shallow clone over http'
 
 . ./test-lib.sh
-
-if test -n "$NO_CURL"; then
-	say 'skipping test, git built without http support'
-	test_done
-fi
-
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 3d11b7a..87a7aa0 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -2,12 +2,6 @@
 
 test_description='test dumb fetching over http via static file'
 . ./test-lib.sh
-
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 66439e5..2b29311 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -2,12 +2,6 @@
 
 test_description='test smart fetching over http via http-backend'
 . ./test-lib.sh
-
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index d23fb02..19afe96 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -2,12 +2,6 @@
 
 test_description='test git-http-backend'
 . ./test-lib.sh
-
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.4.0.488.gf55b16a
