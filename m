From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Wed, 26 Jun 2013 18:35:52 -0400
Message-ID: <20130626223552.GA12785@sigill.intra.peff.net>
References: <51C5FD28.1070004@ramsay1.demon.co.uk>
 <51C6BC4B.9030905@web.de>
 <51C8BF2C.2050203@ramsay1.demon.co.uk>
 <7vy59y4w3r.fsf@alter.siamese.dyndns.org>
 <51C94425.7050006@alum.mit.edu>
 <51CB610C.7050501@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 27 00:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UryJm-00082T-Bf
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 00:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab3FZWf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 18:35:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:33009 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796Ab3FZWf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 18:35:56 -0400
Received: (qmail 21697 invoked by uid 102); 26 Jun 2013 22:37:01 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Jun 2013 17:37:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jun 2013 18:35:52 -0400
Content-Disposition: inline
In-Reply-To: <51CB610C.7050501@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229067>

On Wed, Jun 26, 2013 at 10:45:48PM +0100, Ramsay Jones wrote:

> > This patch adds some *extra* cache invalidation that was heretofore
> > missing.  If stat() is broken it could
> > 
> > (a) cause a false positive, resulting in some unnecessary cache
> > invalidation and re-reading of packed-refs, which will hurt performance
> > but not correctness; or
> > 
> > (b) cause a false negative, in which case the stale cache might be used
> > for reading (but not writing), just as was *always* the case before this
> > patch.
> > 
> > As far as I understand, the concern for cygwin is (a).  I will leave it
> > to others to measure and/or decide whether the performance loss is too
> > grave to endure until the cygwin stat() situation is fixed.
> 
> Hmm, I'm not sure I understand ... However, I can confirm that the
> 'mh/ref-races' branch in next is broken on cygwin. (i.e. it is not
> just a speed issue; it provokes fatal errors).

I think Michael's assessment above is missing one thing. It is true that
a false positive is just a performance problem in most cases, as we
unnecessarily reload the file, thinking it has changed.

However, when we have taken a lock on the file, there is an additional
safety measure: if we find the file is changed, we abort, as that should
never happen (it means somebody else modified the file while we had it
locked). But of course Cygwin's false positive here triggers the safety
valve, and we die without even realizing that nothing changed.

In theory we can drop the safety valve; it should never actually happen.
But I'd like to keep it there for working systems. Perhaps it is worth
doing something like this:

diff --git a/refs.c b/refs.c
index 4302206..7cac42d 100644
--- a/refs.c
+++ b/refs.c
@@ -1080,6 +1080,16 @@ static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 		packed_refs_file = git_path("packed-refs");
 
 	if (refs->packed &&
+#ifdef STAT_VALIDITY_GIVES_FALSE_POSITIVES
+	    /*
+	     * If we get false positives from our stat calls on this platform,
+	     * then we must assume that once we have locked the packed-refs
+	     * file it does not change. Otherwise it looks like somebody else
+	     * has changed it out from under us (while we have it locked!), and
+	     * we die().
+	     */
+	    !refs->packed->lock &&
+#endif
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
 		clear_packed_ref_cache(refs);
 

and then we can add that define to Cygwin in the Makefile. I verified
the issue on Linux by "breaking" stat_validity_check to always return 0
(i.e., to always give a false positive that the file has changed, which
is what Cygwin is doing).

I am curious how often Cygwin gives us the false positive. If it is
every time, then the check is not doing much good at all. Is it possible
for you to instrument stat_validity_check to report how often it does or
does not do anything useful?

-Peff
