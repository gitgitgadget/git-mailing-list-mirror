From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] send-email: do not prompt for explicit repo ident
Date: Wed, 14 Nov 2012 12:26:16 -0800
Message-ID: <20121114202616.GA23492@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165327.GF12626@sigill.intra.peff.net>
 <20121114171827.GE6858@elie.Belkin>
 <20121114200505.GA13317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:26:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYjXd-0002MT-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 21:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067Ab2KNU0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 15:26:20 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48638 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab2KNU0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 15:26:19 -0500
Received: (qmail 6690 invoked by uid 107); 14 Nov 2012 20:27:07 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 15:27:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 12:26:16 -0800
Content-Disposition: inline
In-Reply-To: <20121114200505.GA13317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209751>

On Wed, Nov 14, 2012 at 12:05:05PM -0800, Jeff King wrote:

> > When someone writes such a test, I think it could check that git
> > either prompts or writes a message advising to configure the user
> > email, no?  Waiting until later for that seems fine to me, though.
> 
> Yes. The problem is that the behavior and output are dependent on
> factors outside the test suite, so we would have to check that one of
> the possible expected outcomes happens. But I think there are really
> only two such outcomes (neglecting that the ident itself can have
> arbitrary content, but we do not have to check the actual content).

Actually, I think the simplest thing is to add a prerequisite, like:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 489bc80..8d192ff 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -738,6 +738,14 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
 	esac
 '
 
+test_lazy_prereq IMPLICIT_IDENT '
+	sane_unset GIT_AUTHOR_NAME &&
+	sane_unset GIT_AUTHOR_EMAIL &&
+	git var GIT_AUTHOR_IDENT &&
+	# double check that we were not polluted by config
+	test "$(git var GIT_AUTHOR_EXPLICIT)" = 0
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY

We can't have one test machine that will cover all of the cases, but
given that the test suite is run by many people across many machines, we
will get coverage (and I know that some people have machines which would
not pass that prereq, because I got test failure reports during the last
ident refactoring).

I'll include something like that in my re-roll (and it should let us
test "git commit" more thoroughly, too).

-Peff
