From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/7] make test output coloring more intuitive
Date: Thu, 20 Dec 2012 11:11:10 -0500
Message-ID: <20121220161110.GA10605@sigill.intra.peff.net>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
 <7v8v8xrfnp.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9B_HfUZmqNqO35mtjTvdihBTiW=uOV2oEQgLUw1xyf=A@mail.gmail.com>
 <20121220153411.GA1497@sigill.intra.peff.net>
 <CAOkDyE9y6JvNKTCBoJqu47Hn-3axfjZPUdBhf4bOEfSP-9Q84A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 17:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TliiY-0006Zj-Rs
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 17:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab2LTQLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 11:11:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59778 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab2LTQLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 11:11:12 -0500
Received: (qmail 10535 invoked by uid 107); 20 Dec 2012 16:12:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 11:12:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 11:11:10 -0500
Content-Disposition: inline
In-Reply-To: <CAOkDyE9y6JvNKTCBoJqu47Hn-3axfjZPUdBhf4bOEfSP-9Q84A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211903>

On Thu, Dec 20, 2012 at 03:44:53PM +0000, Adam Spiers wrote:

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 256f1c6..31f59af 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -227,7 +227,7 @@ then
> >                 pass)
> >                         tput setaf 2;;            # green
> >                 info)
> > -                       tput bold; tput setaf 6;; # bold cyan
> > +                       tput setaf 6;; # cyan
> >                 *)
> >                         test -n "$quiet" && return;;
> >                 esac
> >
> 
> Good point, I forgot to check what it looked like with -v.  Since this
> series is already on v6, is there a more lightweight way of addressing
> this tiny tweak than sending v7?

It is ultimately up to Junio, but I suspect he would be OK if you just
reposted patch 4/7 with the above squashed. Or even just said "I like
this, please squash it into patch 4 (change info messages from
yellow/brown to bold cyan).

As an aside, it made me wonder how hard/useful it would be to color the
snippets even more. Doing this:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f9ccbf2..3d44a94 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -364,7 +364,12 @@ test_expect_success () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
-		say >&3 "expecting success: $2"
+		if test -z "$GIT_TEST_HIGHLIGHT"; then
+			say >&3 "expecting success: $2"
+		else
+			say >&3 "expecting success:"
+			echo "$2" | eval "$GIT_TEST_HIGHLIGHT"
+		fi
 		if test_run_ "$2"
 		then
 			test_ok_ "$1"

produces highlighted snippets with:

  GIT_TEST_HIGHLIGHT='highlight -S sh -O ansi'

or

  GIT_TEST_HIGHLIGHT='pygmentize -l sh'

depending on what you have installed on your system. I'm not convinced
it actually adds anything, but it's a fun toy. A real patch would
probably turn it off in non-verbose mode, as invoking the highlighter
(especially pygmentize) repeatedly is somewhat expensive.

-Peff
