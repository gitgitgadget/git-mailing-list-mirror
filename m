From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t5538: fix default http port
Date: Mon, 10 Feb 2014 09:39:48 -0500
Message-ID: <20140210143948.GA21242@sigill.intra.peff.net>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-3-git-send-email-pclouds@gmail.com>
 <20140206193533.GB14552@sigill.intra.peff.net>
 <20140207234727.GA17520@sigill.intra.peff.net>
 <CACsJy8CLR4qerWPWs+0TWxnTWidm_VLtYExjKqAOLOSNK0chaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 15:40:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCs1f-0002zi-9l
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 15:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbaBJOjz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 09:39:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:47989 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752111AbaBJOjy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 09:39:54 -0500
Received: (qmail 31166 invoked by uid 102); 10 Feb 2014 14:39:54 -0000
Received: from mobile-032-162-138-072.mycingular.net (HELO sigill.intra.peff.net) (32.162.138.72)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Feb 2014 08:39:54 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Feb 2014 09:39:48 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CLR4qerWPWs+0TWxnTWidm_VLtYExjKqAOLOSNK0chaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241914>

On Sat, Feb 08, 2014 at 02:36:11PM +0700, Duy Nguyen wrote:

> > Thinking on this more, I wonder if we should just do something like
> > this:
> [...]
> Yes!

Here it is as a Real Patch=E2=84=A2. I just based it on master, so it c=
an
replace your 5537/5538 fix in your series.

> Next stop, attempt to start httpd at start_httpd regardless of
> GIT_TEST_HTTPD. If successful, test_set_prereq HTTPD or something tha=
t
> the following tests can use. If GIT_TEST_HTTPD is set and start_httpd
> fails, error out, not set prereq.

I'd be fine with that, as I always run them anyway. The potential
downsides would be:

  1. Is there anybody who has apache installed who would _not_ want to
     bring it up for the test?

  2. Is there anybody for whom the failure mode of bringing up apache
     would be unpleasant (e.g., if it hangs the tests or something)?

=46or (1), we could perhaps have a GIT_NO_TEST_HTTPD to avoid it.

=46or (2), I suspect we may need to make our error handling more robust=
,
but getting people to run it is the first step to figuring out what the
problems are.

If we go this route, we should probably do the same for
GIT_TEST_GIT_DAEMON in t5570 (and for that matter, we should probably d=
o
the same for the port numbers).

-- >8 --
Subject: [PATCH] tests: auto-set LIB_HTTPD_PORT from test name

We set the default apache port for each of the httpd tests
to the 4-digit test number of the test script. We want these
to remain unique so that the tests do not conflict with each
other when run in parallel.

Instead of doing it manually in each test script, let's just
set it from the test name at run time. This is simpler, and
is one less thing to be updated when test scripts are
renamed (e.g., when being re-rolled or when conflicting
after being merged with another topic).

Incidentally, this fixes a case where t5537 and t5538 used
the same port number (5537), and could conflict with each
other when run in parallel.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh           | 2 +-
 t/t5537-fetch-shallow.sh | 1 -
 t/t5538-push-shallow.sh  | 1 -
 t/t5540-http-push.sh     | 1 -
 t/t5541-http-push.sh     | 1 -
 t/t5550-http-fetch.sh    | 1 -
 t/t5551-http-fetch.sh    | 1 -
 t/t5561-http-backend.sh  | 1 -
 8 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index bfdff2a..b43162e 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -64,7 +64,7 @@ case $(uname) in
 esac
=20
 LIB_HTTPD_PATH=3D${LIB_HTTPD_PATH-"$DEFAULT_HTTPD_PATH"}
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'8111'}
+LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-${this_test#t}}
=20
 TEST_PATH=3D"$TEST_DIRECTORY"/lib-httpd
 HTTPD_ROOT_PATH=3D"$PWD"/httpd
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index b0fa738..adf215a 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -178,7 +178,6 @@ if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
 	test_done
 fi
=20
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5537'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 0a6e40f..8e54ac5 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -126,7 +126,6 @@ if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
 	test_done
 fi
=20
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5537'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 5b0198c..8d7b3c5 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -16,7 +16,6 @@ then
 fi
=20
 LIB_HTTPD_DAV=3Dt
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5540'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 ROOT_PATH=3D"$PWD"
 start_httpd
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index bfd241e..73af16f 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -12,7 +12,6 @@ if test -n "$NO_CURL"; then
 fi
=20
 ROOT_PATH=3D"$PWD"
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5541'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 start_httpd
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 8392624..1a3a2b6 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -8,7 +8,6 @@ if test -n "$NO_CURL"; then
 	test_done
 fi
=20
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5550'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index a124efe..e07eaf3 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -8,7 +8,6 @@ if test -n "$NO_CURL"; then
 	test_done
 fi
=20
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5551'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index b5d7fbc..d23fb02 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -8,7 +8,6 @@ if test -n "$NO_CURL"; then
 	test_done
 fi
=20
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5561'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20
--=20
1.8.5.2.500.g8060133
