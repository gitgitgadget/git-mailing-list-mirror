From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: inform pre-commit if --amend is used
Date: Mon, 24 Nov 2014 22:44:24 -0500
Message-ID: <20141125034424.GA19161@peff.net>
References: <1416828111-4567-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 04:44:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt73F-0005e9-TR
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 04:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbaKYDo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 22:44:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:44598 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750852AbaKYDoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 22:44:25 -0500
Received: (qmail 27074 invoked by uid 102); 25 Nov 2014 03:44:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 21:44:25 -0600
Received: (qmail 26343 invoked by uid 107); 25 Nov 2014 03:44:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 22:44:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 22:44:24 -0500
Content-Disposition: inline
In-Reply-To: <1416828111-4567-1-git-send-email-oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260186>

On Mon, Nov 24, 2014 at 12:21:51PM +0100, =C3=98ystein Walle wrote:

>  This hook is invoked by 'git commit', and can be bypassed
> -with `--no-verify` option.  It takes no parameter, and is
> +with `--no-verify` option.  It takes one parameter which is "amend" =
if
> +`--amend` was used when committing and empty otherwise. It is

This interface change is OK for backwards compatibility, since existing
scripts would not look at the arguments (which are always empty
currently). And I think it is OK for adding new options in the future,
too, because the option is always present (just sometimes as an empty
string).  Can we make the non-amend option something more verbose than
the empty string (like "noamend")? I have two reasons:

  1. It is a bit more obvious when debugging or dumping arguments (e.g.=
,
     via GIT_TRACE), especially if new options are added after the
     first.

  2. It makes it easier for a script to work on old and new versions of
     git. It sees either "amend" or "noamend" for the two obvious cases=
,
     and if it sees no argument, then it knows that it does not know
     either way (it is running on an old version of git).

     Technically one can tell the difference in shell between an empty
     string and a missing argument, but it is sufficiently subtle that =
I
     think "noamend" is a better route.

> +# a hook that checks if "amend" is passed as an argument
> +cat > "$HOOK" <<EOF
> +#!/bin/sh
> +test "\$1" =3D amend
> +EOF

Eric mentioned write_script already (and it would be nice to convert th=
e
existing uses in t7503 to use it). You may also want to use "\EOF" to
inhibit interpolation in the here-document, which means you do not have
to quote variables inside the script.

-Peff
