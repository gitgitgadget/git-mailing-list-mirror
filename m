From: Jeff King <peff@peff.net>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue,
 13))
Date: Thu, 15 Dec 2011 01:55:29 -0500
Message-ID: <20111215065529.GA1327@sigill.intra.peff.net>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
 <20111214070916.GA14954@elie.hsd1.il.comcast.net>
 <201112141717.15021.trast@student.ethz.ch>
 <20111214230713.GA13128@sigill.intra.peff.net>
 <20111214232151.GB13128@sigill.intra.peff.net>
 <20111214233119.GA2354@elie>
 <20111215002530.GA2566@sigill.intra.peff.net>
 <20111215005057.GB2566@sigill.intra.peff.net>
 <7vfwgmplgd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 07:55:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb5E9-0004qe-Bm
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 07:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340Ab1LOGzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 01:55:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50344
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932261Ab1LOGzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 01:55:32 -0500
Received: (qmail 5973 invoked by uid 107); 15 Dec 2011 07:02:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Dec 2011 02:02:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2011 01:55:29 -0500
Content-Disposition: inline
In-Reply-To: <7vfwgmplgd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187191>

On Wed, Dec 14, 2011 at 07:23:14PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This correctly detects the bug in t7006. I can't decide if it's clever
> > or ugly.
> 
> I would say it falls on the latter side of the line by small margin. Let's
> do the /dev/null thing and be done with it.

Darn, I wanted to post it on my fridge with an "A+".

Here's a cleaned-up version of the /dev/null one.

-- >8 --
Subject: [PATCH] test-lib: redirect stdin of tests

We want to run tests in a predictable, sterile environment
so we can get repeatable results.  They should take as
little input as possible from the environment outside the
test script. We already sanitize environment variables, but
leave stdin untouched. This means that scripts can
accidentally be impacted by content on stdin, or whether
stdin isatty().

Furthermore, scripts reading from stdin can be annoying to
outer loops which care about their stdin offset, like:

  while read sha1; do
      make test
  done

A test which accidentally reads stdin would soak up all of
the rest of the input intended for the outer shell loop.

Let's redirect stdin from /dev/null, which solves both
of these problems. It won't detect tests accidentally
reading from stdin, but since doing so now gives a
deterministic result, we don't need to consider that an
error.

We'll also leave file descriptor 6 as a link to the original
stdin. Tests shouldn't need to look at this, but it can be
convenient for inserting interactive commands while
debugging tests (e.g., you could insert "bash <&6 >&3 2>&4"
to run interactive commands in the environment of the test
script).

Signed-off-by: Jeff King <peff@peff.net>
---
I went the "redirect each test individually" route. In the course of my
experimentation, I notice that some tests (e.g., t4013) will do:

  while read x; do
          test_expect_success "test something ($x)" "
            ... do some test involving $x ...
          "
  done <<\EOF
  ... some values of $x ....
  EOF

This protects those loops from accidental stdin-readers inside the test
scripts, too.

 t/test-lib.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..5ea9fe3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -191,6 +191,7 @@ then
 fi
 
 exec 5>&1
+exec 6<&0
 if test "$verbose" = "t"
 then
 	exec 4>&2 3>&1
@@ -469,7 +470,7 @@ test_debug () {
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
-	eval >&3 2>&4 "$*"
+	eval </dev/null >&3 2>&4 "$*"
 }
 
 test_run_ () {
-- 
1.7.8.rc2.30.g803b1a
