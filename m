From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] Accept object data in the fsck_object() function
Date: Fri, 29 Aug 2014 19:05:46 -0400
Message-ID: <20140829230546.GC24834@peff.net>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1408281646400.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 30 01:06:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNVEx-0004Za-Te
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 01:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbaH2XFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 19:05:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:33476 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751636AbaH2XFs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 19:05:48 -0400
Received: (qmail 11495 invoked by uid 102); 29 Aug 2014 23:05:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 18:05:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 19:05:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1408281646400.990@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256201>

On Thu, Aug 28, 2014 at 04:46:42PM +0200, Johannes Schindelin wrote:

> When fsck'ing an incoming pack, we need to fsck objects that cannot be
> read via read_sha1_file() because they are not local yet (and might even
> be rejected if transfer.fsckobjects is set to 'true').
> 
> For commits, there is a hack in place: we basically cache commit
> objects' buffers anyway, but the same is not true, say, for tag objects.
> 
> By refactoring fsck_object() to take the object buffer and size as
> optional arguments -- optional, because we still fall back to the
> previous method to look at the cached commit objects if the caller
> passes NULL -- we prepare the machinery for the upcoming handling of tag
> objects.
> 
> The assumption that such buffers are inherently NUL terminated is now
> wrong, of course, hence we pass the size of the buffer so that we can
> add a sanity check later, to prevent running past the end of the buffer.

After this, can we get rid of passing a "struct object" to the fsck code
entirely? It should be able to operate only on a type/buffer pair, along
with possibly a sha1 for error reporting.

The buffer management in index-pack's sha1_object function is
significantly complicated by attaching the temporary buffer to a "struct
commit", only to then have to detach it a few lines later. It is the
sole reason we had to add "detach_commit_buffer" a while ago.

-Peff
