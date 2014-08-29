From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] Make sure fsck_commit_buffer() does not run out of
 the buffer
Date: Fri, 29 Aug 2014 19:27:15 -0400
Message-ID: <20140829232715.GE24834@peff.net>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1408281646450.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 30 01:27:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNVZo-0005Qc-OI
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 01:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbaH2X1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 19:27:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:33492 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbaH2X1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 19:27:17 -0400
Received: (qmail 12494 invoked by uid 102); 29 Aug 2014 23:27:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 18:27:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 19:27:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1408281646450.990@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256203>

On Thu, Aug 28, 2014 at 04:46:49PM +0200, Johannes Schindelin wrote:

> So far, we assumed that the buffer is NUL terminated, but this is not
> a safe assumption, now that we opened the fsck_object() API to pass a
> buffer directly.
> 
> So let's make sure that there is at least an empty line in the buffer.
> That way, our checks would fail if the empty line was encountered
> prematurely, and consequently we can get away with the current string
> comparisons even with non-NUL-terminated buffers are passed to
> fsck_object().

Hmm. So having looked through all of the code, I _think_ this is enough
because all of the parsing:

  - is left-to-right, and stops when it sees something unexpected, which
    would include a double newline

  - uses strcspn for the string-dependent calls, and each call has "\n"
    in its list of stop-characters.

But it seems kind of flaky and easy for later code to get wrong.

Would it be that hard to just allocate an extra NUL at the end of
objects we inflate in index-pack? All of the regular object code paths
provide the extra NUL-termination, and many parts of git depend on that.
I do not think we call into any other reusable code paths besides fsck()
from index-pack, but if we were to add the NUL, we would future-proof
against these "weird" object buffers getting passed elsewhere.

-Peff
