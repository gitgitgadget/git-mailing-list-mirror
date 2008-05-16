From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Fri, 16 May 2008 00:42:38 -0400
Message-ID: <20080516044238.GA6784@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <20080502060930.GA1079@sigill.intra.peff.net> <7vd4o5xm62.fsf@gitster.siamese.dyndns.org> <20080502125553.GB2923@sigill.intra.peff.net> <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org> <20080506055128.GA26311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 06:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwrn3-0007rr-4O
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 06:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbYEPEmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 00:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbYEPEmm
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 00:42:42 -0400
Received: from peff.net ([208.65.91.99]:4661 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbYEPEml (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 00:42:41 -0400
Received: (qmail 26025 invoked by uid 111); 16 May 2008 04:42:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 16 May 2008 00:42:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2008 00:42:38 -0400
Content-Disposition: inline
In-Reply-To: <20080506055128.GA26311@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82256>

On Tue, May 06, 2008 at 01:51:28AM -0400, Jeff King wrote:

> So anyway, here is the less invasive version.
> [of configurable paging]

Gah. Lacking any more input, I was going to clean this up and re-submit,
but it seems to fail some unrelated tests.

It appears that with this patch, you can no longer do:

  cd .git && git show HEAD

because of some awful ordering constraints in the wrapper. Specifically,
looking in the config for pager.* entails calling git_path, which ends
up calling setup_git_env, which says "I guess our git_dir is '.git'".
Which is of course totally wrong, and calling setup_git_directory would
find the right thing.

So the logic in setup_git_env seems bogus, but should basically never be
invoked because we do generally call setup_git_directory_gently before
then. Either it should probably call setup_git_directory_gently (though
I am afraid of what awful side effects that could have), or it should
just barf, and people should do setup_git_directory beforehand (and I'm
sure that will break something too).

Blargh.

-Peff
