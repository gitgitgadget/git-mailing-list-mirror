From: Jeff King <peff@peff.net>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Mon, 18 Jan 2016 16:54:33 -0500
Message-ID: <20160118215433.GB24136@sigill.intra.peff.net>
References: <569D580F.4070302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 18 22:54:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLHl2-0002lL-AU
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 22:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbcARVyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 16:54:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:55710 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932230AbcARVyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 16:54:36 -0500
Received: (qmail 6858 invoked by uid 102); 18 Jan 2016 21:54:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 16:54:36 -0500
Received: (qmail 14292 invoked by uid 107); 18 Jan 2016 21:54:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 16:54:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 16:54:33 -0500
Content-Disposition: inline
In-Reply-To: <569D580F.4070302@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284328>

On Mon, Jan 18, 2016 at 10:24:31PM +0100, Toralf F=C3=B6rster wrote:

>  very first line is "error: malformed object name <id>" which tells a=
ll, or ?

Yeah, I agree that showing the "-h" help is a bit much.

This is a side effect of looking up in the commit in the parse-options
callback. It has to signal an error to the option parser, and then the
option parser always shows the help on an error.

I think we'd need to do one of:

  1. call die() in the option-parsing callback (this is probably a bad
     precedent, as the callbacks might be reused from a place that want=
s
     to behave differently)

  2. have the callback just store the argument string, and then resolve
     the commit later (and die or whatever if it doesn't exist). This
     pushes more work onto the caller, but in this case it's all done b=
y
     the ref-filter code, so it could presumably happen during another
     part of the ref-filter setup.

  3. teach parse-options to accept some specific non-zero return code
     that means "return an error, but don't show the usage"

I think any one of those would be a good project for somebody looking t=
o
get their feet wet in working on git. I think (2) is the cleanest.

-Peff
