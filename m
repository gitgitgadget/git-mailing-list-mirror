From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0300-credentials: Word around a solaris /bin/sh bug
Date: Fri, 3 Feb 2012 07:06:57 -0500
Message-ID: <20120203120657.GB31441@sigill.intra.peff.net>
References: <1328211135-25217-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120202200240.GC9246@sigill.intra.peff.net>
 <7vr4ycu3ty.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 13:07:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtHv2-0007Y9-OM
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 13:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154Ab2BCMHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 07:07:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55392
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425Ab2BCMG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 07:06:59 -0500
Received: (qmail 30936 invoked by uid 107); 3 Feb 2012 12:14:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 07:14:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 07:06:57 -0500
Content-Disposition: inline
In-Reply-To: <7vr4ycu3ty.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189750>

On Thu, Feb 02, 2012 at 05:02:17PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I wonder if a better solution is to use a known-good shell instead of
> > trying to work around problems in a bogus shell.
> 
> Yeah, I think that is a better approach.
> 
> What prevents us from doing 's|^#! */bin/sh|$#$SHELL_PATH|' on everything
> in t/ directory (I am not suggesting to do this. I just want to know if
> there is a reason we want hardcoded "#!/bin/sh" for some instances).

The quoting is more annoying, because you usually don't want
interpolation on the rest of the lines of your embedded script. So:

  cat >foo.sh <<\EOF
  #!/bin/sh
  echo my arguments are "$@"
  EOF

cannot have the mechanical replace you mentioned above. It would need:

  cat >foo.sh <<EOF
  #!$SHELL_PATH
  echo my arguments are "\$@"
  EOF

or:

  {
    echo "#!$SHELL_PATH" &&
    cat <<EOF
    echo my arguments are "$@"
    EOF
  } >foo.sh

When I have hard-coded "#!/bin/sh", my thinking is usually "this is less
cumbersome to type and to read, and this script-let is so small that
even Solaris will get it right".

-Peff
