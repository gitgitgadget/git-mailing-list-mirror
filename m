From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] fetch-pack: sort incoming heads
Date: Tue, 22 May 2012 16:23:36 -0400
Message-ID: <20120522202336.GA31231@sigill.intra.peff.net>
References: <20120521221417.GA22664@sigill.intra.peff.net>
 <20120521221702.GA22914@sigill.intra.peff.net>
 <7v7gw43rn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 22:23:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWvcO-0004eo-QU
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 22:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab2EVUXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 16:23:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51956
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932296Ab2EVUXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 16:23:39 -0400
Received: (qmail 23121 invoked by uid 107); 22 May 2012 20:24:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 16:24:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 16:23:36 -0400
Content-Disposition: inline
In-Reply-To: <7v7gw43rn9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198239>

On Tue, May 22, 2012 at 01:08:42PM -0700, Junio C Hamano wrote:

> > @@ -1076,6 +1081,8 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
> >  			st.st_mtime = 0;
> >  	}
> >  
> > +	qsort(heads, nr_heads, sizeof(*heads), compare_heads);
> > +
> >  	if (heads && nr_heads)
> >  		nr_heads = remove_duplicates(nr_heads, heads);
> 
> Hrm, could heads and/or nr_heads be NULL/0 here when we try to run qsort()
> in this codepath?

Good catch. I had originally put the qsort into remove_duplicates, but
hoisted it out, as the second optimization depends on the sorting, too.
heads can be NULL here (for example, if you run fetch-pack without any
arguments, and without --stdin; though why you would do so is a
mystery, we should protect against it).

A sane qsort would see that its second parameter is 0 and never try to
dereference the array. But I'm not sure all qsort implementations we
will see are sane, so it's probably better to protect it by putting it
inside the conditional block just below.

-Peff
