From: Jeff King <peff@peff.net>
Subject: [BUG?] bulk checkin does not respect filters
Date: Thu, 23 Feb 2012 22:02:45 -0500
Message-ID: <20120224030244.GA15742@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 04:03:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0lRJ-0007eA-Ix
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 04:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab2BXDCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 22:02:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49289
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026Ab2BXDCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 22:02:47 -0500
Received: (qmail 19708 invoked by uid 107); 24 Feb 2012 03:02:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Feb 2012 22:02:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2012 22:02:45 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191411>

If I do this:

  git init repo &&
  cd repo &&
  echo foo >small &&
  cat small small small small >large &&
  echo '* filter=foo2bar' >.gitattributes &&
  git config filter.foo2bar.clean 'sed s/foo/bar/' &&
  git config core.bigfilethreshold 10 &&
  git add . &&
  echo "===> small" && git cat-file blob :small
  echo "===> large" && git cat-file blob :large

the output I get is:

  ===> small
  bar
  ===> large
  foo
  foo
  foo
  foo

I.e., the clean filter is not applied to the bulk checkin file. Nor can
it be easily, because we need to know the size of the file to write the
blob header, and we don't know that until we see all of the filter's
output.

In practice, I don't know if this is a huge deal, as people aren't going
to be asking to de-CRLF files that actually cross the 512M
bigfilethreshold (OTOH, I seem to recall there are some filters floating
around for normalizing gzip'd files, which could plausibly be gigantic).

But it seems like the right choice when we see this conflict is not
"don't do filters for streaming checkin", but rather "don't do streaming
checkin when filters are in use" (because streaming is an optimization,
and filters are about correctness).

It would be even nicer if filters could play well with bulk checkin, but
I think that would involve streaming to a tempfile, checking the size of
the file, and then streaming that into an object. Which is better than
putting the whole thing in memory if it would involve swapping, but
probably worse than doing so if you can possibly fit the whole thing in
(because you're doing a ton of extra I/O for the tempfile).

Thoughts? Was this intentional, or just overlooked?

-Peff
