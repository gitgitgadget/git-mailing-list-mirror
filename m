From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Mon, 19 Jan 2009 23:04:48 -0500
Message-ID: <20090120040448.GA30714@sigill.intra.peff.net>
References: <20090117153846.GB27071@coredump.intra.peff.net> <20090118194328.GA31180@coredump.intra.peff.net> <20090118195342.GA612@coredump.intra.peff.net> <200901182137.16562.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 05:07:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP7uA-0005i6-6k
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 05:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbZATEEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 23:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZATEEz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 23:04:55 -0500
Received: from peff.net ([208.65.91.99]:51809 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950AbZATEEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 23:04:54 -0500
Received: (qmail 31278 invoked by uid 107); 20 Jan 2009 04:04:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 19 Jan 2009 23:04:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jan 2009 23:04:48 -0500
Content-Disposition: inline
In-Reply-To: <200901182137.16562.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106433>

On Sun, Jan 18, 2009 at 09:37:15PM +0100, Markus Heidelberg wrote:

> Not sure, if you it has something to do with the following, but I had
> this in my tree for some days now, waiting for the 2 commits mentioned
> in the log message to graduate to master, which happend just an hour or
> so ago.

I think this is probably an improvement, but I had in mind something a
little more drastic. Right now we keep munging one variable that is our
current idea of "should we do color" based on multiple config values.
Then you end up with (best case) this "finalize color config", which is
a bit ugly, or (worst case) bugs where the value hasn't always been
properly initialized (or finalized).

So I think it makes more sense to record each config value, and then
check a _function_ that does the right thing. I.e., you end up with
something like:

  if (use_color(COLOR_DIFF)) /* or COLOR_BRANCH, etc */
    ...

  int use_color(enum color_type t)
  {
    enum color_preference preference;
    preference = color_config[t];
    if (preference == COLOR_UNKNOWN)
      preference = color_config[COLOR_UI];
    if (preference == COLOR_UNKNOWN)
      preference = /* some sane default, possibly command-dependent */
    if (preference == COLOR_AUTO)
      return pager_in_use() || isatty(1);
    if (preference == COLOR_ALWAYS)
      return 1;
    if (preference == COLOR_NEVER)
      return 0;
  }

which very clearly expresses the policy being used (and you probably
want to memo-ize either that whole thing, or at least the isatty check
to avoid making repeated system calls).

-Peff
