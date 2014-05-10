From: Jeff King <peff@peff.net>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Sat, 10 May 2014 10:02:59 -0400
Message-ID: <20140510140259.GA6836@sigill.intra.peff.net>
References: <536A8FF8.7080909@fabiodalfonso.com>
 <xmqqeh056z6q.fsf@gitster.dls.corp.google.com>
 <20140508041423.GC26630@sigill.intra.peff.net>
 <536B1DF4.5080109@fabiodalfonso.com>
 <20140509155945.GG18197@sigill.intra.peff.net>
 <xmqqy4yavewk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 10 16:03:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wj7rs-0004LX-Vf
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 16:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbaEJODF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 10:03:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:48876 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756149AbaEJODD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 10:03:03 -0400
Received: (qmail 595 invoked by uid 102); 10 May 2014 14:03:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 May 2014 09:03:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 May 2014 10:02:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4yavewk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248660>

On Fri, May 09, 2014 at 02:08:27PM -0700, Junio C Hamano wrote:

> >   3. Just disable the http tests when run as root.
> >
> > I think I'd favor 3. But I'd like to be sure that being root is the
> > problem.
> 
> I agree with both the conclusion and the precondition.

Here's the patch.

The problem starts in v1.9.2, not in v2.0.0, so it's not technically a
regression in this cycle. And we are awfully late in the -rc period. But
it is just a change in the test script, and one that seems rather
unlikely to produce unexpected side effects. I'll leave it you whether
you want to queue it for v2.0.0, or for the next maint release.

-- >8 --
Subject: t/lib-httpd: require SANITY prereq

Our test httpd setup will not generally run as root, because
Apache will want to setuid, and we do not set up the "User"
config directive. On some systems, like current Debian
unstable, Apache fails to start, and we skip the tests:

    $ sudo ./t5539-fetch-http-shallow.sh --debug
    1..0 # SKIP web server setup failed
    $ cat trash*t5539*/httpd/error.log
    [...]
    (22)Invalid argument: AH00024: Couldn't set permissions on
      the rewrite-map mutex; check User and Group directives
    AH00016: Configuration Failed

However, on other systems (reportedly Ubuntu 11.04), Apache
seems to start, and then bails during our tests with:

   getpwuid: couldn't determine user name from uid 4294967295,
     you probably need to modify the User directive
   Child 12037 returned a Fatal error...  Apache is exiting!

This may be related to the pre-fork/threading model in use
(note that the second one complains of the child dying).
However, it's not even worth investigating; in either case
we just want to skip the tests, and we already recommend
against running the test suite as root. Let's just
explicitly check this condition and skip the tests rather
than expecting Apache to do the right thing.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 252cbf1..8b67021 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -37,6 +37,11 @@ then
 	test_done
 fi
 
+if ! test_have_prereq SANITY; then
+	test_skip_or_die $GIT_TEST_HTTPD \
+		"Cannot run httpd tests as root"
+fi
+
 HTTPD_PARA=""
 
 for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
-- 
2.0.0.rc1.436.g03cb729
