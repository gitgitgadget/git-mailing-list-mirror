From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] do not stream large files to pack when filters are
 in use
Date: Fri, 24 Feb 2012 16:01:34 -0500
Message-ID: <20120224210134.GA22177@sigill.intra.peff.net>
References: <20120224093924.GA11680@sigill.intra.peff.net>
 <20120224094805.GB11846@sigill.intra.peff.net>
 <7vehtkyp6i.fsf@alter.siamese.dyndns.org>
 <20120224204810.GC21447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:01:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12Gr-0007xd-4b
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223Ab2BXVBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:01:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56017
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab2BXVBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:01:36 -0500
Received: (qmail 28841 invoked by uid 107); 24 Feb 2012 21:01:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 16:01:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 16:01:34 -0500
Content-Disposition: inline
In-Reply-To: <20120224204810.GC21447@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191478>

On Fri, Feb 24, 2012 at 03:48:10PM -0500, Jeff King wrote:

> On Fri, Feb 24, 2012 at 12:03:17PM -0800, Junio C Hamano wrote:
> 
> > > -	else if (size <= big_file_threshold || type != OBJ_BLOB)
> > > +	else if (size <= big_file_threshold || type != OBJ_BLOB ||
> > > +		 convert_to_git(path, NULL, 0, NULL, 0))
> > 
> > Nice.  It would be even nicer to give a readability macro whose name makes
> > it clear that this is a query (unfortunately we cannot add '?' at the end
> > of the function name) and not a conversion.  Any name suggestions?
> 
> Yeah, I cringed a little at all of the NULLs. How about:
> 
>   int would_convert_to_git(const char *path);
> 
> ?

I started to do this but had a thought: would other callers want more
flexibility? That is, should convert_to_git's dry run trigger actually
be: the _destination_ buffer is NULL?

I.e., you could call it like this:

  convert_to_git(path, buf, len, NULL, 0);

and find out the real answer, including inspecting buf, about whether
we would convert. Or you could also use a NULL buffer to get the
pessimistic "we might convert" case.

I don't think it really matters that much, as I am introducing only one
caller. I'm not sure if any other code paths would care about this
speculative "maybe we would convert" question, so perhaps it is simply
over-engineering.

-Peff
