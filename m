From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/25] t/test-lib: introduce --chain-lint option
Date: Tue, 24 Mar 2015 23:05:44 -0400
Message-ID: <20150325030544.GD15051@peff.net>
References: <20150320100429.GA17354@peff.net>
 <20150320100548.GA12543@peff.net>
 <20150325035352.Horde.wlh5PImm_EGVzNTHeSEb7g1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:05:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yabdf-0002u8-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 04:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbbCYDFr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 23:05:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:38130 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752160AbbCYDFq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 23:05:46 -0400
Received: (qmail 11338 invoked by uid 102); 25 Mar 2015 03:05:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 22:05:46 -0500
Received: (qmail 10863 invoked by uid 107); 25 Mar 2015 03:06:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 23:06:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2015 23:05:44 -0400
Content-Disposition: inline
In-Reply-To: <20150325035352.Horde.wlh5PImm_EGVzNTHeSEb7g1@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266252>

On Wed, Mar 25, 2015 at 03:53:52AM +0100, SZEDER G=C3=A1bor wrote:

> >     cmd1 &&
> >     for i in a b c; do
> >	     cmd2 $i
> >     done &&
> >     cmd3
> >
> >   which will not notice failures of "cmd2 a" or "cmd b"
>=20
> s/cmd b/cmd2 b/ ?

Yes, but the patches are already in next, so it is sadly too late for
commit message fixups.

> > - it cannot find a missing &&-chain inside a block or
> >   subfunction, like:
> [...]
> And inside subshells. [...]

Yeah, I had mentally filed them with "block", but true subshells are
probably the most common place. However, I'd suspect a good portion of
them are going to be the "trivial" type, especially if they involve
setting up the sub-environment at the top of the subshell. E.g.,
something like this:

  cmd1 &&
  (
    FOO=3Dbar; export FOO
    cmd2
  ) &&
  cmd3

does not break the outer chain (which is what --chain-lint checks). It
does break the chain inside the subshell, but we never expect variable
assignment or export to fail (it is nice to fix it, of course, but the
main purpose in fixing the ones in my "trivial" patch was more about
shutting up --chain-lint to make the real breakages more obvious).

-Peff
