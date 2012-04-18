From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: fix off-by-one in append_option
Date: Wed, 18 Apr 2012 13:21:16 -0700
Message-ID: <20120418202116.GA12964@sigill.intra.peff.net>
References: <20120417233255.GA24626@sigill.intra.peff.net>
 <20120418191849.GA12619@sigill.intra.peff.net>
 <7vd374ltqh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:21:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKbNW-0007CD-54
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 22:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277Ab2DRUVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 16:21:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37977
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801Ab2DRUVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 16:21:20 -0400
Received: (qmail 20233 invoked by uid 107); 18 Apr 2012 20:21:28 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Apr 2012 16:21:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Apr 2012 13:21:16 -0700
Content-Disposition: inline
In-Reply-To: <7vd374ltqh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195899>

On Wed, Apr 18, 2012 at 12:34:14PM -0700, Junio C Hamano wrote:

> > I've included a patch below that makes this look like:
> >
> >   static const char repack_cmd[] = {"repack", "-d", "-l", NULL };
> >   static struct argv_array repack = ARGV_ARRAY_INIT_DEFAULT(repack_cmd);
>
> I do not know it is worth it to try to be too fancy.
> 
> I was about to suggest, immediately after seeing the first one I quoted
> above, to omit NULL and instead use ARRAY_SIZE(), but I do not think that
> is even worth it, as some (possibly future) caller may have only "char **"
> as a usual NULL terminated array at hand.

Actually, that is broken already, because the initializer uses
ARRAY_SIZE to set argc properly. Omitting NULL wouldn't work anyway,
though, because then the state before any push violates the invariant
(that the value is NUL-terminated).

I think it really is impossible to make it nice, because we can't count
on running _any_ code before somebody peeks at array.argv (we don't even
have an accessor, but just let people look at that directly).

> I am perfectly OK with even without initializers, like this:
> 
> 	struct argv_array repack = ARGV_ARRAY_INIT;
> 	argv_array_push_strings(&repack, "repack", "-d", "-l", NULL);

I think that is sane, and certainly the simplest. I'll send a patch in a
moment.

-Peff
