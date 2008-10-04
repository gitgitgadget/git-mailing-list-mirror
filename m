From: Jeff King <peff@peff.net>
Subject: Re: git apply: git diff header lacks filename information for git
	diff --no-index patch
Date: Sat, 4 Oct 2008 00:17:14 -0400
Message-ID: <20081004041714.GA12413@coredump.intra.peff.net>
References: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Imre Deak <imre.deak@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 06:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klygd-0002ZM-4N
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 06:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbYJDERS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 00:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbYJDERS
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 00:17:18 -0400
Received: from peff.net ([208.65.91.99]:4498 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbYJDERR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 00:17:17 -0400
Received: (qmail 10049 invoked by uid 111); 4 Oct 2008 04:17:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 04 Oct 2008 00:17:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Oct 2008 00:17:14 -0400
Content-Disposition: inline
In-Reply-To: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97464>

On Thu, Oct 02, 2008 at 09:27:36PM +0300, Imre Deak wrote:

> $ git apply patch
> fatal: git diff header lacks filename information (line 4)
> $ cat patch
> diff --git a/dev/null b/a
> new file mode 100644
> index 0000000000000000000000000000000000000000..1f2a4f5ef3df7f7456d91c961da36fc58904f2f1
> GIT binary patch

Hmm. The problem is that "git apply" doesn't accept that "a/dev/null"
and "b/a" are the same, so it rejects them as a name. I guess on a text
patch, we would just pull that information from the "---" and "+++"
lines, so we don't care that it's not on the diff commandline.

However, a _non_ --no-index patch doesn't produce the same output. It
will actually produce the line:

  diff --git a/a b/a

even if it is a creation patch. So I'm not sure which piece of code is
at fault. Either:

  1. git apply is right to reject, and "git diff --no-index" should be
     putting the actual filename on the commandline of a binary patch
     instead of /dev/null, even if it is a creation patch.

     or

  2. git apply should accept this construct. Perhaps we should relax the
     "both names must be the same" rule if one of the names is /dev/null
     (and we would take the other)?

Linus, the "both names must be the same" code in git_header_name blames
to you (5041aa70). Thoughts on number 2?

-Peff
