From: Jeff King <peff@peff.net>
Subject: Re: [REGRESSION, BISECTED] `git checkout <branch>` started to be
 memory hog
Date: Fri, 22 Jul 2011 11:36:02 -0600
Message-ID: <20110722173601.GA9422@sigill.intra.peff.net>
References: <20110722130518.GA9873@tugrik.mns.mnsspb.ru>
 <20110722170001.GB20700@sigill.intra.peff.net>
 <7vipquz0d0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Smelkov <kirr@mns.spb.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 19:36:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkJdz-0007L5-BT
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 19:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab1GVRgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 13:36:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34390
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab1GVRgE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 13:36:04 -0400
Received: (qmail 21558 invoked by uid 107); 22 Jul 2011 17:36:33 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 13:36:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 11:36:02 -0600
Content-Disposition: inline
In-Reply-To: <7vipquz0d0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177650>

On Fri, Jul 22, 2011 at 10:33:31AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > From my quick look, I came up with the fix below. It removes the leak
> > and doesn't trigger any memory errors according to valgrind. So it
> > _must_ be right. :)
> >
> > -Peff
> >
> > ---
> > diff --git a/streaming.c b/streaming.c
> > index 565f000..f3acc5d 100644
> > --- a/streaming.c
> > +++ b/streaming.c
> > @@ -93,7 +93,9 @@ struct git_istream {
> >  
> >  int close_istream(struct git_istream *st)
> >  {
> > -	return st->vtbl->close(st);
> > +	int r = st->vtbl->close(st);
> > +	free(st);
> > +	return r;
> >  }
> 
> I do not think of a reason any future callers would want to close the
> stream first and then inspect some attribute of the stream afterwards (if
> this were an output stream, there might be things like output stats that
> may want such an interface, but even in such a case, the caller should say
> "flush" first to drain whatever is pending, grab stats and then close), so
> freeing the resource at close time seems sensible to me.

Yeah. My impression was that these istreams would operate much like
"FILE *" streams. And closing those frees all resources, and you can
throw away the pointer afterwards.

> Both the external caller in entry.c and the internal caller (a filtered
> istream reads from its underlying istream, and when it is getting closed,
> closes the underlying istream) were leaking the istream exactly the same
> way, so this fix should plug both of them.
> 
> Thanks.

Did you want me to write a commit message? I think you might do a better
job of writing a coherent one for this particular patch.

-Peff
