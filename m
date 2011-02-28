From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/WIP] attr: make attributes depend on file type
Date: Mon, 28 Feb 2011 12:30:37 -0500
Message-ID: <20110228173037.GC24915@sigill.intra.peff.net>
References: <20110228130850.GB9054@sigill.intra.peff.net>
 <f35b1b4b57a563f57f169602440b3b0abdef5a07.1298906628.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 18:30:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu6vj-0006E1-VC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 18:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab1B1Raj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 12:30:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38838 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195Ab1B1Rai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 12:30:38 -0500
Received: (qmail 26116 invoked by uid 111); 28 Feb 2011 17:30:38 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 28 Feb 2011 17:30:38 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Feb 2011 12:30:37 -0500
Content-Disposition: inline
In-Reply-To: <f35b1b4b57a563f57f169602440b3b0abdef5a07.1298906628.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168125>

On Mon, Feb 28, 2011 at 04:26:18PM +0100, Michael J Gruber wrote:

> This is a whether balloon patch (to check whether this balloons or not,
> uhm). Hit it hard, not me ;)

Ouch.

> It's part of the way to revive the old idea of making attributes depend
> on file type. I am not following the old path
> 
> pattern is_symlink otherattr
> 
> because that would mean something which looks like an attribute
> (is_symlink) but is not. Instead,
> 
> symlink:pattern attrs
> 
> is to specify attrs for pattern if it is a symlink. So, e.g.,

This is way better than what I proposed. From the user's perspective, it
is visually clearer that the symlink bit is part of the selector, and
not an attribute. And it syntactically disallows nonsense like:

  pattern is_symlink is_gitlink otherattr

The only downside is that it is technically a regression if somebody was
using gitattributes for the bizarrely named file "symlink:". It seems
pretty unlikely, but possibly we should be carving out a syntactic
namespace like:

  ^[a-z]+:

or even:

  ^[a-z]+(=[^:]*)?:

And that would later allow stuff like "submodule:" if people wanted to
attach specific bits to submodules (though perhaps it is not necessary,
because we have the entire separate .gitmodules file). I don't know if
there are other non-name elements people would be interested in
selecting on. So maybe that is over-engineering.

We also need some way of quoting. Duy has a 1.8.0 proposal to handle
this. If we're going to make a syntactic change to gitattributes for
this, it should probably be related (since the quoting mechanism is the
way you would fix it if you _are_ affected), and should probably follow
the same migration mechanism (it looks like there is talk of a "#
feature: foo bar" line).

See:

  http://article.gmane.org/gmane.comp.version-control.git/165970

I didn't test, but do we now assume that a pattern like "foo.*
diff=bar" will only match when foo is a regular file? I think that would
fix stuff like "*.pdf merge=pdf" when there is a symlink named
"file.pdf", which I'm pretty sure is currently broken (but did not
test).

OTOH, that is yet another behavior change if somebody had something like
"foo diff=symlink", which we would be breaking. So perhaps we will need
many "# feature" markers to make this right. :)

-Peff
