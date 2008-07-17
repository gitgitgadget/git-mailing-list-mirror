From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
	only
Date: Thu, 17 Jul 2008 01:18:34 -0400
Message-ID: <20080717051833.GA3100@sigio.intra.peff.net>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net> <20080716051829.GB4030@segfault.peff.net> <7v4p6qwezy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 07:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJLsu-0007tn-Je
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 07:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbYGQFRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 01:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbYGQFRd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 01:17:33 -0400
Received: from peff.net ([208.65.91.99]:3306 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbYGQFRc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 01:17:32 -0400
Received: (qmail 12442 invoked by uid 111); 17 Jul 2008 05:17:30 -0000
Received: from sigio.intra.peff.net (HELO sigio.intra.peff.net) (10.0.0.10)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 17 Jul 2008 01:17:30 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jul 2008 01:18:34 -0400
Content-Disposition: inline
In-Reply-To: <7v4p6qwezy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88803>

On Tue, Jul 15, 2008 at 10:54:25PM -0700, Junio C Hamano wrote:

> Anything that returns error() from its cmd_xxx() routine, for example,
> would end up exiting with (-1).  Is it "such bogus" error codes, though?

I think it is bogus, because it is being implicitly truncated to an
unsigned 8-bit value (at least on Linux -- I have no idea what other
platforms do). So your -1 is actually 255. Portably speaking, C defines
only the macros EXIT_SUCCESS and EXIT_FAILURE; in practice, I don't know
what is most common.

Bad side effects of not treating your exit codes as unsigned 8-bit
integers:

  - the exit values are easily confused with other things, like signal
    death. As in this case. We have modified our checking code in the
    test scripts, but there may be other, less robust code out there.

  - other exit values can be mistaken as success. Obviously 256, -256,
    512, -512, etc all produce an erroneous "success". Now we aren't
    doing this, as we are using "-1", but it just seems a bit cleaner to
    be up front about what is happening (and the 255 we end up with is
    unnecessarily confusing; some documents, like this one:

      http://tldp.org/LDP/abs/html/exitcodes.html

    claim 255 as "out of range").

So what we are doing now isn't terrible, but since it was noted (and did
in fact cause a problem!), I just expected a "let's stop doing that"
patch in the original series.

-Peff
