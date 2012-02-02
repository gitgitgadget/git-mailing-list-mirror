From: Jeff King <peff@peff.net>
Subject: Re: BUG 1.7.9: git-update-ref strange behavior with ref with
 trailing newline
Date: Thu, 2 Feb 2012 17:32:50 -0500
Message-ID: <20120202223250.GA28618@sigill.intra.peff.net>
References: <15093.1328220568@plover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Jason Dominus <mjd@plover.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 23:33:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt5D7-0005EA-IH
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 23:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676Ab2BBWcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 17:32:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53771
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab2BBWcw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 17:32:52 -0500
Received: (qmail 26874 invoked by uid 107); 2 Feb 2012 22:39:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 17:39:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 17:32:50 -0500
Content-Disposition: inline
In-Reply-To: <15093.1328220568@plover.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189718>

On Thu, Feb 02, 2012 at 05:09:28PM -0500, Mark Jason Dominus wrote:

> Here I use git symbolic-ref to update HEAD with a ref whose name
> contains trailing newlines:
> 
>         $ git symbolic-ref -m "this message does not appear" HEAD 'refs/heads/master
>         >
>         >
>         > '
> 
> The newlines are inserted into .git/HEAD, but are innocuous, because
> other git commands ignore them.  The bug is that the -m option is
> completely ignored:
> 
>         $ git reflog HEAD | grep 'message does not appear'

Is it trailing newlines, or is simply pointing to a ref that does not
exist? Because I believe we do not create a HEAD reflog entry in that
case, as we would have nothing to write in the "new sha1" field. I guess
we could write an entry that it went to "0{40}", though I'm not sure how
things like "git reflog show" would handle that. The logic is at the
very end of refs.c:create_symref if you want to experiment.

As far as the newlines go, I'm surprised we don't reject that. We should
probably run check_refname_format on the proposed contents of the
symbolic-ref.

-Peff
